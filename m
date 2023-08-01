Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362E976A61F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjHABQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHABQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:16:37 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925EA10E3;
        Mon, 31 Jul 2023 18:16:35 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3711Fq3p009236;
        Tue, 1 Aug 2023 09:15:52 +0800 (+08)
        (envelope-from surong.pang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RFHFJ2Y4Fz2K1r9S;
        Tue,  1 Aug 2023 09:14:12 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx05.spreadtrum.com (10.29.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 1 Aug 2023 09:15:51 +0800
From:   Surong Pang <surong.pang@unisoc.com>
To:     <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
        <felipe.balbi@linux.intel.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Orson.Zhai@unisoc.com>, <Chunyan.Zhang@unisoc.com>,
        <Zhiyong.liu@unisoc.com>, <Surong.Pang@Unisoc.com>,
        <Surong.Pang@gmail.com>
Subject: [PATCH V2] usb: dwc3: gadget: Let pm runtime get/put paired
Date:   Tue, 1 Aug 2023 09:15:48 +0800
Message-ID: <20230801011548.30232-1-surong.pang@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.55.99]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 3711Fq3p009236
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pm_runtime_get is called when setting pending_events to true.
Pm_runtime_put is needed for pairing with pm_runtime_get.

Fixes: fc8bb91bc83e ("usb: dwc3: implement runtime PM")
Signed-off-by: Surong Pang <surong.pang@unisoc.com>

---
V2: add Fixes tag, fix Fixes tag
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5fd067151fbf..9c835c5f9928 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4720,5 +4720,6 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
 		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
 		dwc->pending_events = false;
 		enable_irq(dwc->irq_gadget);
+		pm_runtime_put(dwc->dev);
 	}
 }
-- 
2.17.1

