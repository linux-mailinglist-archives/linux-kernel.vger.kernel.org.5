Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF57F8E73
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjKYUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjKYUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:05:27 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726318E;
        Sat, 25 Nov 2023 12:05:33 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 47348100025;
        Sat, 25 Nov 2023 23:05:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 47348100025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700942732;
        bh=XZaUtJIinZsFjG7oW4EmSM0d0XTPrP4/k2a7efLvsns=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=aIIu02lYdQoypBa3oIs4n5XP/m9sSl6fDFToka7rWIvDq+UpqMjeM06et9IoRIXtG
         de+EnBcgtYJ7YnA9y0bFjaI5U3hiojfrbeUQpmA/O/sKOT07qFxmD2aBUH9WE8s4OJ
         S3AxACLsu4/uMzhErtAE8mnJvTzgzy1gBfNykH8FAmTARL2bc1LMie1TlxEqdvmKsg
         Q2ZBSKZi9xz4W9miGSbFHEgHr5piDXKBnIbjANLFXOtgV4CKsJlzU0LFJxNVVCNceD
         H7G8t1r2XGNSWH+E1Ppo4DkrYdGj8hVrrF1/nZ2yAqTArSk34Eb+5fcBzMH1rosF9B
         4nl14chOKN9dg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat, 25 Nov 2023 23:05:32 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 25 Nov 2023 23:05:31 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v5 09/11] leds: aw200xx: add support for aw20108 device
Date:   Sat, 25 Nov 2023 23:05:17 +0300
Message-ID: <20231125200519.1750-10-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231125200519.1750-1-ddrokosov@salutedevices.com>
References: <20231125200519.1750-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181593 [Nov 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/25 18:32:00 #22537065
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

From: George Stark <gnstark@salutedevices.com>

Add support for the Awinic aw20108 device, which belongs to the same LED
drivers family. The new device supports 108 LEDs using a matrix of 12x9
outputs."

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/Kconfig        | 14 +++++++++-----
 drivers/leds/leds-aw200xx.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6046dfeca16f..a898a8679334 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -95,14 +95,18 @@ config LEDS_ARIEL
 	  Say Y to if your machine is a Dell Wyse 3020 thin client.
 
 config LEDS_AW200XX
-	tristate "LED support for Awinic AW20036/AW20054/AW20072"
+	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
 	depends on LEDS_CLASS
 	depends on I2C
 	help
-	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
-	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
-	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
-	  3 pattern controllers for auto breathing or group dimming control.
+	  This option enables support for the Awinic AW200XX LED controllers.
+	  It is a matrix LED driver programmed via an I2C interface. Devices have
+	  a set of individually controlled LEDs and support 3 pattern controllers
+	  for auto breathing or group dimming control. Supported devices:
+	    - AW20036 (3x12) 36 LEDs
+	    - AW20054 (6x9)  54 LEDs
+	    - AW20072 (6x12) 72 LEDs
+	    - AW20108 (9x12) 108 LEDs
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-aw200xx.
diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index e125b6c68c23..1d3943f86f7f 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Awinic AW20036/AW20054/AW20072 LED driver
+ * Awinic AW20036/AW20054/AW20072/AW20108 LED driver
  *
  * Copyright (c) 2023, SberDevices. All Rights Reserved.
  *
@@ -622,10 +622,17 @@ static const struct aw200xx_chipdef aw20072_cdef = {
 	.display_size_columns = 12,
 };
 
+static const struct aw200xx_chipdef aw20108_cdef = {
+	.channels = 108,
+	.display_size_rows_max = 9,
+	.display_size_columns = 12,
+};
+
 static const struct i2c_device_id aw200xx_id[] = {
 	{ "aw20036" },
 	{ "aw20054" },
 	{ "aw20072" },
+	{ "aw20108" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, aw200xx_id);
@@ -634,6 +641,7 @@ static const struct of_device_id aw200xx_match_table[] = {
 	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
 	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
 	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
+	{ .compatible = "awinic,aw20108", .data = &aw20108_cdef, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aw200xx_match_table);
-- 
2.36.0

