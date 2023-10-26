Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E67D8951
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjJZUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJZUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:01:27 -0400
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F24B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:01:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698350482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w9sbKYXZtIyf/ohQE3Edg07I3no4RCuR4cZPauSieZc=;
        b=Q6YJK2jt8aNtYlz8aXpbXEWd2kqMpPtQi5xuwpIHAqyuf9aFF60iI469yR9sXN+U5jAsl1
        Mtp7c9Vc5whZ4u38LKe46DBzYaXVhRTQQCFXcC/gDZVPwZarUGe2TcuOM0l9txxgRMmVIq
        drqS5ay+gubC+PaR89dnjZTdhkwB61U=
From:   andrey.konovalov@linux.dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: raw-gadget: properly handle interrupted requests
Date:   Thu, 26 Oct 2023 22:01:12 +0200
Message-Id: <0db45b1d7cc466e3d4d1ab353f61d63c977fbbc5.1698350424.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

Currently, if a USB request that was queued by Raw Gadget is interrupted
(via a signal), wait_for_completion_interruptible returns -ERESTARTSYS.
Raw Gadget then attempts to propagate this value to userspace as a return
value from its ioctls. However, when -ERESTARTSYS is returned by a syscall
handler, the kernel internally restarts the syscall.

This doesn't allow userspace applications to interrupt requests queued by
Raw Gadget (which is required when the emulated device is asked to switch
altsettings). It also violates the implied interface of Raw Gadget that a
single ioctl must only queue a single USB request.

Instead, make Raw Gadget do what GadgetFS does: check whether the request
was interrupted (dequeued with status == -ECONNRESET) and report -EINTR to
userspace.

Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index b9ecc55a2ce2..ce9e87f84911 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -674,12 +674,12 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 	if (WARN_ON(in && dev->ep0_out_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 	if (WARN_ON(!in && dev->ep0_in_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 
 	dev->req->buf = data;
@@ -694,7 +694,7 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&dev->ep0_done);
@@ -703,13 +703,16 @@ static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 		usb_ep_dequeue(dev->gadget->ep0, dev->req);
 		wait_for_completion(&dev->ep0_done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (dev->ep0_status == -ECONNRESET)
+			dev->ep0_status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = dev->ep0_status;
 
-out_done:
+out_interrupted:
+	ret = dev->ep0_status;
+out_queue_failed:
 	dev->ep0_urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1078,7 +1081,7 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&done);
@@ -1087,13 +1090,16 @@ static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
 		usb_ep_dequeue(ep->ep, ep->req);
 		wait_for_completion(&done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (ep->status == -ECONNRESET)
+			ep->status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = ep->status;
 
-out_done:
+out_interrupted:
+	ret = ep->status;
+out_queue_failed:
 	ep->urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
-- 
2.25.1

