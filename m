Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0447CE67A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbjJRS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjJRS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:29:57 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D0F7;
        Wed, 18 Oct 2023 11:29:55 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 48AEE120008;
        Wed, 18 Oct 2023 21:29:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 48AEE120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697653793;
        bh=EDXtkoNRVpjH5LBhvvyL/XjN07jDmu1c5hgfKsl1iMI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=KCJkyjuGZVO1euiIjah6GGMutv1ChGEf0tDU8xvilcI30Aiwmra+8w4ZSnkSP3sjy
         KDvxizVvvGu7s4jQcEjmRz+InoaI03qW0vMvH/kZT6c0erhox/ULlURpWACGFAAVCg
         tSEE8w0Bz4Wb5BXiBk+VpOqOiJHaW9MlCVYStn9YRoSiY6cr5fcJ9Uu9Hpe3Sc5BeL
         W4Q4n8qNaYTnpWkDY8tIC0YrZqveBRQsqoM8Hc4GFdtW8F0PKWbVseVkVA3I3hwBdI
         vbsnvWNF7yYeMzitB5r9TywV9vtldNHa6mHhcWK4zUgUwxzH1UNXFQdzTlUJ8Yd9t+
         zKZR4FZKYc1eQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 18 Oct 2023 21:29:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 21:29:52 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Martin Kurbanov <mmkurbanov@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 01/11] leds: aw200xx: fix write to DIM parameter
Date:   Wed, 18 Oct 2023 21:29:33 +0300
Message-ID: <20231018182943.18700-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231018182943.18700-1-ddrokosov@salutedevices.com>
References: <20231018182943.18700-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180713 [Oct 18 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 541 541 6f62a06a82e8ec968d29b8e7c7bba6aeceb34f57, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/18 17:21:00 #22224798
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kurbanov <mmkurbanov@salutedevices.com>

If write only DIM value to the page 4, LED brightness will not be
updated, as both DIM and FADE need to be written to the page 4.
Therefore, write DIM to the page 1.

Fixes: 36a87f371b7a ("leds: Add AW20xx driver")
Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/leds-aw200xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index ef4eda6a09ee..842a22087b16 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -74,6 +74,10 @@
 #define AW200XX_LED2REG(x, columns) \
 	((x) + (((x) / (columns)) * (AW200XX_DSIZE_COLUMNS_MAX - (columns))))
 
+/* DIM current configuration register on page 1 */
+#define AW200XX_REG_DIM_PAGE1(x, columns) \
+	AW200XX_REG(AW200XX_PAGE1, AW200XX_LED2REG(x, columns))
+
 /*
  * DIM current configuration register (page 4).
  * The even address for current DIM configuration.
@@ -153,7 +157,8 @@ static ssize_t dim_store(struct device *dev, struct device_attribute *devattr,
 
 	if (dim >= 0) {
 		ret = regmap_write(chip->regmap,
-				   AW200XX_REG_DIM(led->num, columns), dim);
+				   AW200XX_REG_DIM_PAGE1(led->num, columns),
+				   dim);
 		if (ret)
 			goto out_unlock;
 	}
-- 
2.36.0

