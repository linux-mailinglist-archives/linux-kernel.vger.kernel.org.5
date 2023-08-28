Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC978B4D0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjH1PvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjH1Puq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:50:46 -0400
Received: from out-247.mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85C188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:50:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693237388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AF/k9KMisM9L/zADuvNUFCBoEX8c5c0K7cCwf6wH2B4=;
        b=YM9IegZT32pmaY9uupjiCI7Sa/1GKIP4EKZdVgx5L6JJIzP2HNyeKyCr2iV/01mc7Wk/uJ
        TtC3on7kWFIYuRLA5KNukwHvzrjcEj1Tj8svdcUjBcgSvou8FVNJXVsPijKdRZeude4Iwv
        6P5SSpBywmib77oA+irOh5dqusPqk7w=
From:   andrey.konovalov@linux.dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: gadgetfs: return USB_GADGET_DELAYED_STATUS from setup()
Date:   Mon, 28 Aug 2023 17:43:04 +0200
Message-Id: <a8d2b91f9890dc21daa359183e84879ff4525180.1693237258.git.andreyknvl@gmail.com>
In-Reply-To: <7f0ee06c68c7241c844cd50f8565fdd5ead79b1b.1693237258.git.andreyknvl@gmail.com>
References: <7f0ee06c68c7241c844cd50f8565fdd5ead79b1b.1693237258.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

---

Changes v1->v2:
- Added comment for composite.h include as suggested by Alan.
- Moved undefs next to composite.h include as suggested by Alan.
---
 drivers/usb/gadget/legacy/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 28249d0bf062..e71cd591cda1 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -31,6 +31,12 @@
 
 #include <linux/usb/gadgetfs.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/composite.h> /* for USB_GADGET_DELAYED_STATUS */
+
+/* Undef helpers from linux/usb/composite.h as gadgetfs redefines them */
+#undef DBG
+#undef ERROR
+#undef INFO
 
 
 /*
@@ -1511,7 +1517,16 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
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

