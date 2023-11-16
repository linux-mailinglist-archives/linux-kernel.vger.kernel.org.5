Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE67EE968
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjKPWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjKPWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:41:33 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F883130;
        Thu, 16 Nov 2023 14:41:30 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AGMfNnH025370;
        Thu, 16 Nov 2023 16:41:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700174483;
        bh=4thN27hHqejhmVMCyJ7ddgFMYernFuj5amqf/33WzVk=;
        h=From:To:CC:Subject:Date;
        b=PmOJMRQRTOv4KZnchBRD2bkWIebguHeQj+d91ERCq4mT925dyH+WgPG3iJ/H+9R26
         GPGz5JALVYYNIxiCz2W5r3iZpGGsMWnlgDDzdHQjgp9JhVpsyIV7oQmDo9tdXbFpmt
         1rghKIwHvSAb7ua51NhYLgjcTnTWrijGTX5T0mrE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AGMfNR9128084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Nov 2023 16:41:23 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 16:41:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 16:41:23 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AGMfMAW002939;
        Thu, 16 Nov 2023 16:41:23 -0600
From:   Andrew Davis <afd@ti.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] leds: tca6507: Use devm_gpiochip_add_data() to simplify remove path
Date:   Thu, 16 Nov 2023 16:41:20 -0600
Message-ID: <20231116224121.302150-1-afd@ti.com>
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
 drivers/leds/leds-tca6507.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index e190746140959..9a6af6d8b5b5d 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -638,19 +638,13 @@ static int tca6507_probe_gpios(struct device *dev,
 	tca->gpio.direction_output = tca6507_gpio_direction_output;
 	tca->gpio.set = tca6507_gpio_set_value;
 	tca->gpio.parent = dev;
-	err = gpiochip_add_data(&tca->gpio, tca);
+	err = devm_gpiochip_add_data(dev, &tca->gpio, tca);
 	if (err) {
 		tca->gpio.ngpio = 0;
 		return err;
 	}
 	return 0;
 }
-
-static void tca6507_remove_gpio(struct tca6507_chip *tca)
-{
-	if (tca->gpio.ngpio)
-		gpiochip_remove(&tca->gpio);
-}
 #else /* CONFIG_GPIOLIB */
 static int tca6507_probe_gpios(struct device *dev,
 			       struct tca6507_chip *tca,
@@ -658,9 +652,6 @@ static int tca6507_probe_gpios(struct device *dev,
 {
 	return 0;
 }
-static void tca6507_remove_gpio(struct tca6507_chip *tca)
-{
-}
 #endif /* CONFIG_GPIOLIB */
 
 static struct tca6507_platform_data *
@@ -793,7 +784,6 @@ static void tca6507_remove(struct i2c_client *client)
 		if (tca_leds[i].led_cdev.name)
 			led_classdev_unregister(&tca_leds[i].led_cdev);
 	}
-	tca6507_remove_gpio(tca);
 	cancel_work_sync(&tca->work);
 }
 
-- 
2.39.2

