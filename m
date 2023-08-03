Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D576E6EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHCLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjHCLby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:31:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B08B198A;
        Thu,  3 Aug 2023 04:31:52 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RGmnt5PswzJr9H;
        Thu,  3 Aug 2023 19:29:06 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:31:50 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sergei.shtylyov@gmail.com>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next v2] usb: musb: Do not check 0 for platform_get_irq_byname()
Date:   Thu, 3 Aug 2023 19:31:21 +0800
Message-ID: <20230803113121.77273-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

When platform_get_irq_byname() is called to get a interrupt number, it
may return -EINVAL or -ENXIO when failed, while current code returned
-ENODEV, so we replace it with the return value of
platform_get_irq_byname(). And we found that platform_get_irq_byname()
never returned zero by reading its code.

Commit ce753ad1549c ("platform: finally disallow IRQ0 in
platform_get_irq() and its ilk") makes sure IRQ0 is not returned.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

---
Changes in v2:
- Update the commit message, present the reason of replacing the return
value of the probe.
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

