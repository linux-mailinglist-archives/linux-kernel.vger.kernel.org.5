Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4478A48E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjH1CQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjH1CPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:15:47 -0400
X-Greylist: delayed 256 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 19:15:45 PDT
Received: from out-253.mta1.migadu.com (out-253.mta1.migadu.com [IPv6:2001:41d0:203:375::fd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168AAF1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:15:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693188643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nn8j1xlZiIaYyk41MeUAjHTR8kw6djY6y6n4AYyo8oQ=;
        b=wrlwc8wbRnTKtb9ELzWKJpvmI0XJrjleVVIVz4kg8r56fEO8pnD9pOR8/XkGaubISLoUnW
        ATTS31e3wIVCX+E2p0KnOUt86TtX4co61EeXkuz3++9khWiCWdVMNDgso3pF50iZ8U5MEF
        8EWqbJR3cVBaT5RYABn4KkAxXabW1ds=
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
Subject: [PATCH 2/3] usb: raw-gadget: return USB_GADGET_DELAYED_STATUS from setup()
Date:   Mon, 28 Aug 2023 04:10:31 +0200
Message-Id: <739253b1efa3469e421c869c4520284e854dc48f.1693188390.git.andreyknvl@gmail.com>
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
 drivers/usb/gadget/legacy/raw_gadget.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index e549022642e5..b9ecc55a2ce2 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/ch11.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
 
 #include <uapi/linux/usb/raw_gadget.h>
 
@@ -363,6 +364,16 @@ static int gadget_setup(struct usb_gadget *gadget,
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
 out:
+	if (ret == 0 && ctrl->wLength == 0) {
+		/*
+		 * Return USB_GADGET_DELAYED_STATUS as a workaround to stop
+		 * some UDC drivers (e.g. dwc3) from automatically proceeding
+		 * with the status stage for 0-length transfers.
+		 * Should be removed once all UDC drivers are fixed to always
+		 * delay the status stage until a response is queued to EP0.
+		 */
+		return USB_GADGET_DELAYED_STATUS;
+	}
 	return ret;
 }
 
-- 
2.25.1

