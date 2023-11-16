Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91A47EE94C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKPWa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKPWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:30:57 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86262C5;
        Thu, 16 Nov 2023 14:30:52 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AGMUlIm030689;
        Thu, 16 Nov 2023 16:30:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700173847;
        bh=53MWMbTaJs5GbSNSY78WEVCLzsf+daLjAhhWbSNVocM=;
        h=From:To:CC:Subject:Date;
        b=kGXPTGI9rs5bdB3z9sDKVC3MaspMLYpptZh/nSvxh5rT4vUiRSHbDb+6GMMJpfvpl
         w3/QtO8uSgpa4CNUf6FTu3Zp/16VcswwB69V64CtamRud01cXM6Njc6YIleqblXEus
         rD633DWzwbxyCOfAz+ePQMbjjMezo1R2E6Kn+2uU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AGMUlRO049401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Nov 2023 16:30:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 16:30:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 16:30:47 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AGMUkKq024789;
        Thu, 16 Nov 2023 16:30:46 -0600
From:   Andrew Davis <afd@ti.com>
To:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH] pinctrl: as3722: Use devm_gpiochip_add_data() to simplify remove path
Date:   Thu, 16 Nov 2023 16:30:45 -0600
Message-ID: <20231116223045.274211-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of gpiochip add function to handle removal for us.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/pinctrl/pinctrl-as3722.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index 6a5f23cf7a2a2..0d8c75ce20eda 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -542,7 +542,6 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 
 	as_pci->dev = &pdev->dev;
 	as_pci->as3722 = dev_get_drvdata(pdev->dev.parent);
-	platform_set_drvdata(pdev, as_pci);
 
 	as_pci->pins = as3722_pins_desc;
 	as_pci->num_pins = ARRAY_SIZE(as3722_pins_desc);
@@ -562,7 +561,7 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 
 	as_pci->gpio_chip = as3722_gpio_chip;
 	as_pci->gpio_chip.parent = &pdev->dev;
-	ret = gpiochip_add_data(&as_pci->gpio_chip, as_pci);
+	ret = devm_gpiochip_add_data(&pdev->dev, &as_pci->gpio_chip, as_pci);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't register gpiochip, %d\n", ret);
 		return ret;
@@ -572,21 +571,10 @@ static int as3722_pinctrl_probe(struct platform_device *pdev)
 				0, 0, AS3722_PIN_NUM);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't add pin range, %d\n", ret);
-		goto fail_range_add;
+		return ret;
 	}
 
 	return 0;
-
-fail_range_add:
-	gpiochip_remove(&as_pci->gpio_chip);
-	return ret;
-}
-
-static void as3722_pinctrl_remove(struct platform_device *pdev)
-{
-	struct as3722_pctrl_info *as_pci = platform_get_drvdata(pdev);
-
-	gpiochip_remove(&as_pci->gpio_chip);
 }
 
 static const struct of_device_id as3722_pinctrl_of_match[] = {
@@ -601,7 +589,6 @@ static struct platform_driver as3722_pinctrl_driver = {
 		.of_match_table = as3722_pinctrl_of_match,
 	},
 	.probe = as3722_pinctrl_probe,
-	.remove_new = as3722_pinctrl_remove,
 };
 module_platform_driver(as3722_pinctrl_driver);
 
-- 
2.39.2

