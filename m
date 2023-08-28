Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2278A493
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjH1CSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjH1CRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:17:48 -0400
Received: from out-243.mta1.migadu.com (out-243.mta1.migadu.com [IPv6:2001:41d0:203:375::f3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73DD8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:17:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693188642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s3mKfn7GAN06ou/8BCH2fRTTl02YY6jrfUlWZqgBA1E=;
        b=S5Jlqj9UFLejHmRcgZ4/6G80Kbyo2zYmVbxS5xaHtfuC0RMPPFDzZNvT4YJIcxF8JuS/2i
        euoJ3VV4tyyadjGnrNlWL/5ZmHIXs/uPodvi63Kf6bFOecUoGVmWpg7R12NAXrOud5dBkO
        ekAL9kWUDhgU02qM4vhBQz5ZD3xFLVY=
From:   andrey.konovalov@linux.dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: gadget: clarify usage of USB_GADGET_DELAYED_STATUS
Date:   Mon, 28 Aug 2023 04:10:30 +0200
Message-Id: <5c2913d70556b03c9bb1893c6941e8ece04934b0.1693188390.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

USB_GADGET_DELAYED_STATUS was introduced in commit 1b9ba000177e ("usb:
gadget: composite: Allow function drivers to pause control transfers").
It was initially intended for the composite framework to allow delaying
completing the status stage of a SET_CONFIGURATION request until all
functions are ready.

Unfortunately, that commit had an unintended side-effect of returning
USB_GADGET_DELAYED_STATUS from the ->setup() call of the composite
framework gadget driver.

As a result of this and the incomplete documentation, some UDC drivers
started relying on USB_GADGET_DELAYED_STATUS to decide when to avoid
autocompleting the status stage for 0-length control transfers. dwc3 was
the first in commit 5bdb1dcc6330 ("usb: dwc3: ep0: handle delayed_status
again"). And a number of other UDC drivers followed later, probably
relying on the dwc3 behavior as a reference.

Unfortunately, this violated the interface between the UDC and the
gadget driver for 0-length control transfers: the UDC driver must only
proceed with the status stage for a 0-length control transfer once the
gadget driver queued a response to EP0.

As a result, a few gadget drivers are partially broken when used with
a UDC that only delays the status stage for 0-length transfers when
USB_GADGET_DELAYED_STATUS is returned from the setup() callback.

This includes Raw Gadget and GadgetFS. For FunctionFS, a workaround was
added in commit 946ef68ad4e4 ("usb: gadget: ffs: Let setup() return
USB_GADGET_DELAYED_STATUS") and commit 4d644abf2569 ("usb: gadget: f_fs:
Only return delayed status when len is 0").

The proper solution to this issue would be to contain
USB_GADGET_DELAYED_STATUS within the composite framework and make all
UDC drivers to not complete the status stage for 0-length requests on
their own.

Unfortunately, there is quite a few UDC drivers that need to get fixed
and the required changes for some of them are not trivial.

For now, update the comments to clarify that USB_GADGET_DELAYED_STATUS
must not be used by the UDC drivers.

The following two commits also add workarounds to Raw Gadget and GadgetFS
to make them compatible with the broken UDC drivers until they are fixed.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 include/linux/usb/composite.h | 8 ++++++++
 include/linux/usb/gadget.h    | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 07531c4f4350..1d2cf6a070ac 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -35,6 +35,14 @@
  * are ready. The control transfer will then be kept from completing till
  * all the function drivers that requested for USB_GADGET_DELAYED_STAUS
  * invoke usb_composite_setup_continue().
+ *
+ * NOTE: USB_GADGET_DELAYED_STATUS must not be used in UDC drivers: they
+ * must delay completing the status stage for 0-length control transfers
+ * regardless of the whether USB_GADGET_DELAYED_STATUS is returned from
+ * the gadget driver's setup() callback.
+ * Currently, a number of UDC drivers rely on USB_GADGET_DELAYED_STATUS,
+ * which is a bug. These drivers must be fixed and USB_GADGET_DELAYED_STATUS
+ * must be contained within the composite framework.
  */
 #define USB_GADGET_DELAYED_STATUS       0x7fff	/* Impossibly large value */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 75bda0783395..6532beb587b1 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -711,6 +711,15 @@ static inline int usb_gadget_check_config(struct usb_gadget *gadget)
  * get_interface.  Setting a configuration (or interface) is where
  * endpoints should be activated or (config 0) shut down.
  *
+ * The gadget driver's setup() callback does not have to queue a response to
+ * ep0 within the setup() call, the driver can do it after setup() returns.
+ * The UDC driver must wait until such a response is queued before proceeding
+ * with the data/status stages of the control transfer.
+ *
+ * NOTE: Currently, a number of UDC drivers rely on USB_GADGET_DELAYED_STATUS
+ * being returned from the setup() callback, which is a bug. See the comment
+ * next to USB_GADGET_DELAYED_STATUS for details.
+ *
  * (Note that only the default control endpoint is supported.  Neither
  * hosts nor devices generally support control traffic except to ep0.)
  *
-- 
2.25.1

