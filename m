Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C876E799
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjHCMBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjHCMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:01:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672EC2726;
        Thu,  3 Aug 2023 05:01:10 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGnTc4fF3zrS2f;
        Thu,  3 Aug 2023 20:00:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 20:01:08 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sergei.shtylyov@gmail.com>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v3] usb: musb: Do not check 0 for platform_get_irq_byname()
Date:   Thu, 3 Aug 2023 20:00:39 +0800
Message-ID: <20230803120039.83502-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When platform_get_irq_byname() failed, it may return -EPROBE_DEFER,
-EINVAL or -ENXIO, it is important to propagate the detail upstream, we
cannot override it.

And platform_get_irq_byname() used to return 0 (as both IRQ0 and error
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
platform_get_irq_byname() cannot be override.
---
 drivers/usb/musb/musb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index ecbd3784bec3..b24adb5b399f 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2610,8 +2610,8 @@ static int musb_probe(struct platform_device *pdev)
 	int		irq = platform_get_irq_byname(pdev, "mc");
 	void __iomem	*base;
 
-	if (irq <= 0)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
-- 
2.17.1

