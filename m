Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671D7F375A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjKUU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKUU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:29:00 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21320D47;
        Tue, 21 Nov 2023 12:28:56 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B936E100070;
        Tue, 21 Nov 2023 23:28:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B936E100070
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700598534;
        bh=76ydPlpjagvRxWC3zBbtfZt+PaH6lVvkPGoancV3mLs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=cQo5NRCvRh1OdTrDT+zJn2fVFy/H0XkzoFV1hF7yzSdJ8o3dv3rRKglCbok9wOSjk
         flONL9Jk3I+F1avmt/gytt93lNl7vyF4zw/AW5Op/Ptt9xHwemOoYjC9/+OxFC4LBB
         zN8JsVG197eDvAGiB6pwItUS0XyimH96LLMo1awEpEdzDWe4PFWNrD/NXZ6yJiRu8c
         88CZEJAFrgzvgGmHF9W0QNfGRLBENkuZmCR8w1lhpgvuLxAYh0K4f4R3k35H08gKKs
         PysgI49Vl8uTiVi71QwefQ6pKMZHCyDPVMn06OIHwq46IAb9ZLEUjwdhsWidrZIKR0
         dVbhD6e9SOIHw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 23:28:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 23:28:54 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v4 09/11] leds: aw200xx: add support for aw20108 device
Date:   Tue, 21 Nov 2023 23:28:33 +0300
Message-ID: <20231121202835.28152-10-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231121202835.28152-1-ddrokosov@salutedevices.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181514 [Nov 21 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/21 17:47:00 #22495004
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

Add support for Awinic aw20108 device from the same LED drivers family.
New device supports 108 LEDs using a matrix of 12x9 outputs.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/leds/Kconfig        | 14 +++++++++-----
 drivers/leds/leds-aw200xx.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6046dfeca16f..a879628e985c 100644
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
+	  This option enables support for Awinic AW200XX LED controller.
+	  It is a matrix LED driver programmed via an I2C interface. Devices have
+	  a set of individually controlled leds and support 3 pattern controllers
+	  for auto breathing or group dimming control. Supported devices:
+	    - AW20036 (3x12) 36 LEDs
+	    - AW20054 (6x9)  54 LEDs
+	    - AW20072 (6x12) 72 LEDs
+	    - AW20108 (9x12) 108 LEDs
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-aw200xx.
diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index c48aa11fd411..4b5036360887 100644
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
@@ -620,10 +620,17 @@ static const struct aw200xx_chipdef aw20072_cdef = {
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
@@ -632,6 +639,7 @@ static const struct of_device_id aw200xx_match_table[] = {
 	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
 	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
 	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
+	{ .compatible = "awinic,aw20108", .data = &aw20108_cdef, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aw200xx_match_table);
-- 
2.36.0

