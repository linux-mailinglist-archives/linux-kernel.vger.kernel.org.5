Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4006E76FF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjHDLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjHDLCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:02:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB5558A;
        Fri,  4 Aug 2023 04:00:35 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHN2Y2tQ5ztRhc;
        Fri,  4 Aug 2023 18:57:09 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:00:33 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herve.codina@bootlin.com>,
        <stern@rowland.harvard.edu>, <robh@kernel.org>,
        <aaro.koskinen@iki.fi>, <sergei.shtylyov@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH v4] usb: gadget: udc: gr_udc: Fix deferred probing
Date:   Fri, 4 Aug 2023 19:00:05 +0800
Message-ID: <20230804110005.97061-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When platform_get_irq() fails, it may return -EPROBE_DEFER, which
suggested deferred probing, it is very important to propagate it
upstream. We cannot override it with other error code.

Commit ce753ad1549c ("platform: finally disallow IRQ0 in
platform_get_irq() and its ilk") makes sure IRQ0 is not returned.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

---
Changes in v2:
- Update the commit message, present the reason of replacing the return
value of the probe.

---
Changes in v3:
- Update the commit message, explain in detail why the return value of
platform_get_irq() cannot be override.

---
Changes in v4:
- Update the title to "Fix deferred probing".
- Update the commit message, emphasize the -EPROBE_DEFER cannot be
overwritten by other error code.
- Remove -next tag.
---
 drivers/usb/gadget/udc/gr_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 0c3969301a53..c6dfa7cccc11 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2136,15 +2136,15 @@ static int gr_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	dev->irq = platform_get_irq(pdev, 0);
-	if (dev->irq <= 0)
-		return -ENODEV;
+	if (dev->irq < 0)
+		return dev->irq;
 
 	/* Some core configurations has separate irqs for IN and OUT events */
 	dev->irqi = platform_get_irq(pdev, 1);
 	if (dev->irqi > 0) {
 		dev->irqo = platform_get_irq(pdev, 2);
-		if (dev->irqo <= 0)
-			return -ENODEV;
+		if (dev->irqo < 0)
+			return dev->irqo;
 	} else {
 		dev->irqi = 0;
 	}
-- 
2.17.1

