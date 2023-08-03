Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9218076E7F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjHCMML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjHCMMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:12:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6102726;
        Thu,  3 Aug 2023 05:12:07 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGnhL1bWgzJr9D;
        Thu,  3 Aug 2023 20:09:22 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 20:12:05 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herve.codina@bootlin.com>,
        <stern@rowland.harvard.edu>, <robh@kernel.org>,
        <aaro.koskinen@iki.fi>, <sergei.shtylyov@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v3] usb: gadget: udc: gr_udc: Do not check 0 for platform_get_irq()
Date:   Thu, 3 Aug 2023 20:11:36 +0800
Message-ID: <20230803121136.86037-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When platform_get_irq() failed, it may return -EPROBE_DEFER, -EINVAL or
-ENXIO, it is important to propagate the detail upstream, we cannot
override it.

And platform_get_irq() used to return 0 (as both IRQ0 and error
indication), there are several patches fixing the inconsistencies.

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

