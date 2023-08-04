Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA376FF0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjHDK5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHDK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:56:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B234C04;
        Fri,  4 Aug 2023 03:55:00 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHMxy4YtnzVk0P;
        Fri,  4 Aug 2023 18:53:10 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.202) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 18:54:58 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <b-liu@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sergei.shtylyov@gmail.com>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH v4] usb: musb: Fix deferred probing
Date:   Fri, 4 Aug 2023 18:54:30 +0800
Message-ID: <20230804105430.95773-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.202]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

When platform_get_irq_byname() fails, it may return -EPROBE_DEFER,
which suggested deferred probing, it is very important to propagate it
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
platform_get_irq_byname() cannot be override.

---
Changes in v4:
- Update the title to "Fix deferred probing".
- Update the commit message, emphasize the -EPROBE_DEFER cannot be
overwritten by other error code.
- Remove -next tag.
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

