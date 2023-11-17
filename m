Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737E7EEC98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjKQHVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjKQHVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:21:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB7194
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:21:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b59662ff67so22790257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700205699; x=1700810499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QmNuow7pqQbmEqyLv/6VHwYFNel/Mb+y1wxC7UWWDz8=;
        b=pIBFsNuLi6DUA89VctcQZEy/yhJO3mDBXAavZt8gQLqHqG7gNSyTI9tYdFfkl6ha41
         x8OwIZtx0hIUGESYj+8TTO5WfvZc5Rw/7T+SISHiReXE17dVKVefpqw3YcVSth6UjFMv
         pQeSSvCKL8J8uJ9hlHETgryNdMvgXBAIWaM4+S57H7KkSgOq789iCeH497k4cix/9wYF
         3a4qXhLV7LBwXq6RO2GYYCH6HqHitYU/vmaQDOnil1dLIu3ikCz86Zq/DW2pk6Nvzu+k
         TlvdY/+oqGQFkVC0rKiESOXS3Qyv27HG4axn7EE1AISoIjy2jAuBplq16b7BtQH/IHRp
         436A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700205699; x=1700810499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmNuow7pqQbmEqyLv/6VHwYFNel/Mb+y1wxC7UWWDz8=;
        b=u6Ij2yw0xq44j79Xa9GtSX+0voksn/yGbR3w3EtGo6k6f67b43V7ESFq9riH8gsfCv
         DYrBnRLN5QkoDW2UZyWnqpXDeyfi6Q6qyxEISimdInzpR/hAI1Z89KWu0KdcFBKFTz0p
         Gqoy0QtcJpsaRlouzj59XAqZRy2viXie3GqIo4wUiUT0LN6SoQMvIqub1O+BjeNEwGqC
         btviKMdGO4XTicpD0vTdxTmXlhYlcaJYmmS9ZjCLzpOh2LtyCAdDCtbTDwMHN91DMPrE
         oG+qBT9xvzUDALD43P20onsyFj39+6oJ1WVbHSO54HsXtG5WHzDf/fLA5D9mDsUxmbqN
         n0WQ==
X-Gm-Message-State: AOJu0YxQQIrjPMLvVvYpPiViUMWkB/gyiwW8obgvyByd4oqNtn2tAISx
        RcRwS/EmosPrnJffhbvSHkGOtTSt4K8=
X-Google-Smtp-Source: AGHT+IFPNWJtc25bxF1xGb08Jogmq03TI8Hzh8i3wPYfhJBboh90PSnhr8JpNozSMWYgAbkDeUJ0XIFwaSc=
X-Received: from khtsai-large-gcloudtop.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:289])
 (user=khtsai job=sendgmr) by 2002:a05:6902:150f:b0:d89:42d7:e72d with SMTP id
 q15-20020a056902150f00b00d8942d7e72dmr138421ybu.3.1700205699331; Thu, 16 Nov
 2023 23:21:39 -0800 (PST)
Date:   Fri, 17 Nov 2023 15:21:28 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117072131.2886406-1-khtsai@google.com>
Subject: [PATCH] xhci: fix null pointer deref for xhci_urb_enqueue
From:   Kuen-Han Tsai <khtsai@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The null pointer dereference happens when xhci_free_dev() frees the
xhci->devs[slot_id] virtual device while xhci_urb_enqueue() is
processing a urb and checking the max packet size.

[106913.850735][ T2068] usb 2-1: USB disconnect, device number 2
[106913.856999][ T4618] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[106913.857488][ T4618] Call trace:
[106913.857491][ T4618]  xhci_check_maxpacket+0x30/0x2dc
[106913.857494][ T4618]  xhci_urb_enqueue+0x24c/0x47c
[106913.857498][ T4618]  usb_hcd_submit_urb+0x1f4/0xf34
[106913.857501][ T4618]  usb_submit_urb+0x4b8/0x4fc
[106913.857503][ T4618]  usb_control_msg+0x144/0x238
[106913.857507][ T4618]  do_proc_control+0x1f0/0x5bc
[106913.857509][ T4618]  usbdev_ioctl+0xdd8/0x15a8

This patch adds a spinlock to the xhci_urb_enqueue function to make sure
xhci_free_dev() and xhci_urb_enqueue() do not race and cause null
pointer dereference.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/host/xhci.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 884b0898d9c9..e0766ebeff0e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1522,23 +1522,32 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	struct urb_priv	*urb_priv;
 	int num_tds;
 
-	if (!urb)
-		return -EINVAL;
-	ret = xhci_check_args(hcd, urb->dev, urb->ep,
-					true, true, __func__);
-	if (ret <= 0)
-		return ret ? ret : -EINVAL;
+	spin_lock_irqsave(&xhci->lock, flags);
+
+	if (!urb) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = xhci_check_args(hcd, urb->dev, urb->ep, true, true, __func__);
+	if (ret <= 0) {
+		ret = ret ? ret : -EINVAL;
+		goto done;
+	}
 
 	slot_id = urb->dev->slot_id;
 	ep_index = xhci_get_endpoint_index(&urb->ep->desc);
 	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
 
-	if (!HCD_HW_ACCESSIBLE(hcd))
-		return -ESHUTDOWN;
+	if (!HCD_HW_ACCESSIBLE(hcd)) {
+		ret = -ESHUTDOWN;
+		goto done;
+	}
 
 	if (xhci->devs[slot_id]->flags & VDEV_PORT_ERROR) {
 		xhci_dbg(xhci, "Can't queue urb, port error, link inactive\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto done;
 	}
 
 	if (usb_endpoint_xfer_isoc(&urb->ep->desc))
@@ -1552,8 +1561,10 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		num_tds = 1;
 
 	urb_priv = kzalloc(struct_size(urb_priv, td, num_tds), mem_flags);
-	if (!urb_priv)
-		return -ENOMEM;
+	if (!urb_priv) {
+		ret = -ENOMEM;
+		goto done;
+	}
 
 	urb_priv->num_tds = num_tds;
 	urb_priv->num_tds_done = 0;
@@ -1571,13 +1582,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 			if (ret < 0) {
 				xhci_urb_free_priv(urb_priv);
 				urb->hcpriv = NULL;
-				return ret;
+				goto done;
 			}
 		}
 	}
 
-	spin_lock_irqsave(&xhci->lock, flags);
-
 	if (xhci->xhc_state & XHCI_STATE_DYING) {
 		xhci_dbg(xhci, "Ep 0x%x: URB %p submitted for non-responsive xHCI host.\n",
 			 urb->ep->desc.bEndpointAddress, urb);
@@ -1620,6 +1629,7 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		xhci_urb_free_priv(urb_priv);
 		urb->hcpriv = NULL;
 	}
+done:
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return ret;
 }
-- 
2.43.0.rc0.421.g78406f8d94-goog

