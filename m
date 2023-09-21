Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C477A9CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjIUT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIUT1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:25 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C6BA0C33
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:57:35 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.spreadtrum.com with ESMTP id 38LCRJlj012213
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 20:27:19 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38LCPc0P001541;
        Thu, 21 Sep 2023 20:25:38 +0800 (+08)
        (envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rrvff0yg8z2SbDtc;
        Thu, 21 Sep 2023 20:22:18 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 21 Sep
 2023 20:25:36 +0800
From:   Wenhua Lin <Wenhua.Lin@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: [PATCH V2 2/2] gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip
Date:   Thu, 21 Sep 2023 20:25:27 +0800
Message-ID: <20230921122527.15261-3-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921122527.15261-1-Wenhua.Lin@unisoc.com>
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL: SHSQR01.spreadtrum.com 38LCPc0P001541
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers uses a mutex and I2C bus access in its PMIC EIC chip
get implementation. This means these functions can sleep and the PMIC EIC
chip should set the can_sleep property to true.

This will ensure that a warning is printed when trying to get the
value from a context that potentially can't sleep.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/gpio/gpio-pmic-eic-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 442968bb2490..f04a40288638 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -353,6 +353,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	irq = &pmic_eic->chip.irq;
 	gpio_irq_chip_set_chip(irq, &pmic_eic_irq_chip);
-- 
2.17.1

