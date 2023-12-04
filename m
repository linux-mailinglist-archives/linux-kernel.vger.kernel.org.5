Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E2803C59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjLDSHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjLDSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:07:12 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7FA119;
        Mon,  4 Dec 2023 10:07:16 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1573310000D;
        Mon,  4 Dec 2023 21:07:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1573310000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701713235;
        bh=qL7h6jprywDr6fISYueZDzA2bOo7TS7aT4PRmSDkI2I=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=AXHUIPIpepj4mQIREeF1kPC+nP2Aeg9UgKbAaF+a/4Og621TFJQudDk4CAmH1u+xr
         GqcDgMerISDiO4q8KtuHwNhymJ9MyfcKFAxc8c2XCIYw699xRp+PWBeYWVKQZoOSKE
         Rh4MdF5tAjhSiMKlAteb8s2h9f7uoFFepa2HjfoAHr5PnsvTA0/3ML6ZMoPfhGDi0V
         rjfGtTevCdAkowz7R0zBmygiQCGMEYbYRdKL7xsU5Kty0rYH7Q5ss9uWAgejTZHyUz
         P7T6DS9QgKBBFH1Wb7GMLfED2orgtYZ8yh6XrKEKt+tICBCt0BBqRyqMXx5HXo1Inx
         5i/pIBi4Oky2g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  4 Dec 2023 21:07:14 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 21:07:14 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <andy.shevchenko@gmail.com>,
        <jic23@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 03/10] leds: aw2013: use devm API to cleanup module's resources
Date:   Mon, 4 Dec 2023 21:05:56 +0300
Message-ID: <20231204180603.470421-4-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204180603.470421-1-gnstark@salutedevices.com>
References: <20231204180603.470421-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181831 [Dec 04 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/04 11:06:00 #22624476
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver LEDs are registered using devm_led_classdev_register()
so they are automatically unregistered after module's remove() is done.
led_classdev_unregister() calls module's led_set_brightness() to turn off
the LEDs and that callback uses resources which were destroyed already
in module's remove() so use devm API instead of remove().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 drivers/leds/leds-aw2013.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index c2bc0782c0cd..1a8acf303548 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Driver for Awinic AW2013 3-channel LED driver
 
+#include <linux/devm-helpers.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/module.h>
@@ -318,6 +319,13 @@ static int aw2013_probe_dt(struct aw2013 *chip)
 	return 0;
 }
 
+static void aw2013_chip_disable_action(void *data)
+{
+	struct aw2013 *chip = (struct aw2013 *)data;
+
+	aw2013_chip_disable(chip);
+}
+
 static const struct regmap_config aw2013_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -334,7 +342,9 @@ static int aw2013_probe(struct i2c_client *client)
 	if (!chip)
 		return -ENOMEM;
 
-	mutex_init(&chip->mutex);
+	if (devm_mutex_init(&client->dev, &chip->mutex))
+		return -ENOMEM;
+
 	mutex_lock(&chip->mutex);
 
 	chip->client = client;
@@ -378,6 +388,10 @@ static int aw2013_probe(struct i2c_client *client)
 		goto error_reg;
 	}
 
+	ret = devm_add_action(&client->dev, aw2013_chip_disable_action, chip);
+	if (ret)
+		goto error_reg;
+
 	ret = aw2013_probe_dt(chip);
 	if (ret < 0)
 		goto error_reg;
@@ -398,19 +412,9 @@ static int aw2013_probe(struct i2c_client *client)
 
 error:
 	mutex_unlock(&chip->mutex);
-	mutex_destroy(&chip->mutex);
 	return ret;
 }
 
-static void aw2013_remove(struct i2c_client *client)
-{
-	struct aw2013 *chip = i2c_get_clientdata(client);
-
-	aw2013_chip_disable(chip);
-
-	mutex_destroy(&chip->mutex);
-}
-
 static const struct of_device_id aw2013_match_table[] = {
 	{ .compatible = "awinic,aw2013", },
 	{ /* sentinel */ },
@@ -424,7 +428,6 @@ static struct i2c_driver aw2013_driver = {
 		.of_match_table = of_match_ptr(aw2013_match_table),
 	},
 	.probe = aw2013_probe,
-	.remove = aw2013_remove,
 };
 
 module_i2c_driver(aw2013_driver);
-- 
2.38.4

