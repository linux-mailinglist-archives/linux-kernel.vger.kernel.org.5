Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B87EE969
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbjKPWlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjKPWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:41:37 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED5A130;
        Thu, 16 Nov 2023 14:41:34 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AGMfP7v100532;
        Thu, 16 Nov 2023 16:41:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700174486;
        bh=ZskoBXUHv9fBtlKrVNorfYzIsR2m5teUc/XjXTA0PgI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bNSC1FlBfrL7Z7XYoORz70ygHbel/wuT12gJGqZBHc7oVl/2X/UcxYIFvLSOYn8qR
         mqCcjPWD+gnI/jxlOU0qyhYgL7xql1+VU6gOMgtF4cyGyiIcEjuIrCDlvErmzBb6nG
         Q6YE1Fac8mecsG4fa9MICCsD5UT9lCuV/JXB49TA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AGMfPiR128110
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Nov 2023 16:41:25 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Nov 2023 16:41:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Nov 2023 16:41:23 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AGMfMAX002939;
        Thu, 16 Nov 2023 16:41:23 -0600
From:   Andrew Davis <afd@ti.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] leds: tca6507: Use devm_led_classdev_register() to simplify remove path
Date:   Thu, 16 Nov 2023 16:41:21 -0600
Message-ID: <20231116224121.302150-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116224121.302150-1-afd@ti.com>
References: <20231116224121.302150-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm version of LED classdev register add function to handle removal.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/leds/leds-tca6507.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 9a6af6d8b5b5d..4f22f42249467 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -753,37 +753,25 @@ static int tca6507_probe(struct i2c_client *client)
 			l->led_cdev.brightness_set = tca6507_brightness_set;
 			l->led_cdev.blink_set = tca6507_blink_set;
 			l->bank = -1;
-			err = led_classdev_register(dev, &l->led_cdev);
+			err = devm_led_classdev_register(dev, &l->led_cdev);
 			if (err < 0)
-				goto exit;
+				return err;
 		}
 	}
 	err = tca6507_probe_gpios(dev, tca, pdata);
 	if (err)
-		goto exit;
+		return err;
 	/* set all registers to known state - zero */
 	tca->reg_set = 0x7f;
 	schedule_work(&tca->work);
 
 	return 0;
-exit:
-	while (i--) {
-		if (tca->leds[i].led_cdev.name)
-			led_classdev_unregister(&tca->leds[i].led_cdev);
-	}
-	return err;
 }
 
 static void tca6507_remove(struct i2c_client *client)
 {
-	int i;
 	struct tca6507_chip *tca = i2c_get_clientdata(client);
-	struct tca6507_led *tca_leds = tca->leds;
 
-	for (i = 0; i < NUM_LEDS; i++) {
-		if (tca_leds[i].led_cdev.name)
-			led_classdev_unregister(&tca_leds[i].led_cdev);
-	}
 	cancel_work_sync(&tca->work);
 }
 
-- 
2.39.2

