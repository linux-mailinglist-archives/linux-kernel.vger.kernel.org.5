Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5419B78A495
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjH1CSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjH1CRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:17:48 -0400
Received: from out-248.mta1.migadu.com (out-248.mta1.migadu.com [IPv6:2001:41d0:203:375::f8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF7BD9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:17:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693188644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtKvrVKkVQRnt5532V2eBTwRFEQ3kLH/lmwR/1FmH1s=;
        b=nX51DTd6k2pYWpSmnb5tXrNcL7PyuZHU/VuPVXFkQycEyI73p4Ck5Zd3i6mIhYwxplI1OU
        5x2GgSy80mXEG3edYDZ16LNYljPSqkJtJ54EuxeSCHqLUlv08XpVsouQghCSaIzq81AqLn
        39nwhdXuhAOArDezqY66niYxhT+Ljmw=
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
Subject: [PATCH 3/3] usb: gadgetfs: return USB_GADGET_DELAYED_STATUS from setup()
Date:   Mon, 28 Aug 2023 04:10:32 +0200
Message-Id: <35c01a524b2eb6c3f01bc08f16bdff2d72256a1f.1693188390.git.andreyknvl@gmail.com>
In-Reply-To: <5c2913d70556b03c9bb1893c6941e8ece04934b0.1693188390.git.andreyknvl@gmail.com>
References: <5c2913d70556b03c9bb1893c6941e8ece04934b0.1693188390.git.andreyknvl@gmail.com>
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

Return USB_GADGET_DELAYED_STATUS from the setup() callback for 0-length
transfers as a workaround to stop some UDC drivers (e.g. dwc3) from
automatically proceeding with the status stage.

This workaround should be removed once all UDC drivers are fixed to
always delay the status stage until a response is queued to EP0.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 28249d0bf062..154bbf578ba2 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -31,6 +31,7 @@
 
 #include <linux/usb/gadgetfs.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
 
 
 /*
@@ -241,6 +242,7 @@ static DEFINE_MUTEX(sb_mutex);		/* Serialize superblock operations */
 #define xprintk(d,level,fmt,args...) \
 	printk(level "%s: " fmt , shortname , ## args)
 
+#undef DBG
 #ifdef DEBUG
 #define DBG(dev,fmt,args...) \
 	xprintk(dev , KERN_DEBUG , fmt , ## args)
@@ -256,8 +258,10 @@ static DEFINE_MUTEX(sb_mutex);		/* Serialize superblock operations */
 	do { } while (0)
 #endif /* DEBUG */
 
+#undef ERROR
 #define ERROR(dev,fmt,args...) \
 	xprintk(dev , KERN_ERR , fmt , ## args)
+#undef INFO
 #define INFO(dev,fmt,args...) \
 	xprintk(dev , KERN_INFO , fmt , ## args)
 
@@ -1511,7 +1515,16 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			event->u.setup = *ctrl;
 			ep0_readable (dev);
 			spin_unlock (&dev->lock);
-			return 0;
+			/*
+			 * Return USB_GADGET_DELAYED_STATUS as a workaround to
+			 * stop some UDC drivers (e.g. dwc3) from automatically
+			 * proceeding with the status stage for 0-length
+			 * transfers.
+			 * Should be removed once all UDC drivers are fixed to
+			 * always delay the status stage until a response is
+			 * queued to EP0.
+			 */
+			return w_length == 0 ? USB_GADGET_DELAYED_STATUS : 0;
 		}
 	}
 
-- 
2.25.1

