Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3F7BBC6E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjJFQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjJFQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:07 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37364B9;
        Fri,  6 Oct 2023 09:05:06 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 5CC06120005;
        Fri,  6 Oct 2023 19:05:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5CC06120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608304;
        bh=J48Vb+KSCyfGEqsOwlqZuxevA+23PB5tA/1+mCQizKo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=jQQpHyBn0ZHrr5PbHHOhBOCB4XUQkykz6640jNpR6m8juysu+8jNf2775PJzVwXwE
         dxiUPomjrreLwDEg3NKw/hmGpATOqPfKUQlUnCxY0lvle/JXSsehljfs4gWaES0gEe
         L3FdkSzXmpKGXA2YtO5DJ0/dus8PzJThZncfmqAFxAITEbqsGXMe5xFEiowaRa0upj
         +2HQ9Jchk2MdQ9YkI7weqqHqISoq2Wk6eEkpgKiSyGzTetYqFDy9o0MwM+OjhKk7IT
         qHkgIw1I/ze2s48YoNSQh/L/MDuV7/3N65bxCBwdei4AEPNzcbWFz/EPiFbiqus1Uk
         musVfegIWse0w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:05:04 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:05:03 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 10/11] leds: aw200xx: add support for aw20108 device
Date:   Fri, 6 Oct 2023 19:04:36 +0300
Message-ID: <20231006160437.15627-11-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231006160437.15627-1-ddrokosov@salutedevices.com>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180439 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/06 13:25:00 #22070343
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <gnstark@salutedevices.com>

Add support for Awinic aw20108 device from the same LED drivers famliy.
New device supports 108 leds using matrix of 12x9 outputs.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/Kconfig        |  8 ++++----
 drivers/leds/leds-aw200xx.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6046dfeca16f..40b3f4191cff 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -95,13 +95,13 @@ config LEDS_ARIEL
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
+	  This option enables support for the AW20036/AW20054/AW20072/AW20108
+	  LED driver. It is a 3x12/6x9/6x12/9x12 matrix LED driver programmed via
+	  an I2C interface, up to 36/54/72/108 LEDs or 12/18/24/36 RGBs,
 	  3 pattern controllers for auto breathing or group dimming control.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 09b8bc6724c7..717c6e2e7bb1 100644
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
@@ -632,10 +632,17 @@ static const struct aw200xx_chipdef aw20072_cdef = {
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
@@ -644,6 +651,7 @@ static const struct of_device_id aw200xx_match_table[] = {
 	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
 	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
 	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
+	{ .compatible = "awinic,aw20108", .data = &aw20108_cdef, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aw200xx_match_table);
-- 
2.36.0

