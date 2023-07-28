Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914A476657C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjG1HkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjG1HkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:40:00 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70642D61;
        Fri, 28 Jul 2023 00:39:56 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36S7dM7Y090495;
        Fri, 28 Jul 2023 15:39:22 +0800 (+08)
        (envelope-from surong.pang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RBzxn2l5Yz2NWkj2;
        Fri, 28 Jul 2023 15:37:49 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx05.spreadtrum.com (10.29.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 28 Jul 2023 15:39:20 +0800
From:   Surong Pang <surong.pang@unisoc.com>
To:     <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Orson.Zhai@unisoc.com>, <Zhiyong.liu@unisoc.com>,
        <Surong.Pang@Unisoc.com>, <Surong.Pang@gmail.com>
Subject: [PATCH] usb: dwc3: gadget: let pm runtime get/put paired
Date:   Fri, 28 Jul 2023 15:39:19 +0800
Message-ID: <20230728073919.6473-1-surong.pang@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.55.99]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 36S7dM7Y090495
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

Signed-off-by: Surong Pang <surong.pang@unisoc.com>
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

