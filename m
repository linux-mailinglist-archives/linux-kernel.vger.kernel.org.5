Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E897CE69A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjJRSah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344923AbjJRSaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:30:10 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EAC139;
        Wed, 18 Oct 2023 11:30:07 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D6AD3120008;
        Wed, 18 Oct 2023 21:30:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D6AD3120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697653805;
        bh=/5UiVhsSD5S7UBFKi2NeM/BQQWcB9e4HNthSllcTWiQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=clt5lN4vCd2kdgWOgzRBxD5KlkxDiQzROymG/IsEgJJ/ln/5v7zSIAW1PPVu4yqaQ
         z/elM2oEAND9FoNLX8IvUjFZrCNGM+1I7NVEXgZNijkDQboJeAwT7r9BY+cz8n/mM4
         K7yV/VNQI0gTIRji4VYr4JVSVlkhd9iZK3Z4+IpBoaXLnLJbKlBnBqlh4yX+gfgXdv
         k46oEKWVmJ3baP4ZIw+jYR7yMMcqzuAaIoR5ZjR2jdpTZoC5IQjXmRMq3Sk8pr2TBt
         EcTC5QhaVG+n6Wvg7H1Gso9xGGCjh8ceNS9Xoo2BypDU8E4uCP6VHdrqpRK+w0IaLN
         O5tDFhY7iSNSg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 18 Oct 2023 21:30:05 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 21:29:58 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 08/11] leds: aw200xx: improve autodim calculation method
Date:   Wed, 18 Oct 2023 21:29:40 +0300
Message-ID: <20231018182943.18700-9-ddrokosov@salutedevices.com>
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

From: George Stark <gnstark@salutedevices.com>

It is highly recommended to leverage the DIV_ROUND_UP() function as a
more refined and mathematically precise alternative to employing a
coarse division method.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/leds-aw200xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index ad4bfb9f0938..7b8802bd9497 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -87,6 +87,8 @@
 #define AW200XX_REG_DIM(x, columns) \
 	AW200XX_REG(AW200XX_PAGE4, AW200XX_LED2REG(x, columns) * 2)
 #define AW200XX_REG_DIM2FADE(x) ((x) + 1)
+#define AW200XX_REG_FADE2DIM(fade) \
+	DIV_ROUND_UP((fade) * AW200XX_DIM_MAX, AW200XX_FADE_MAX)
 
 /*
  * Duty ratio of display scan (see p.15 of datasheet for formula):
@@ -195,9 +197,7 @@ static int aw200xx_brightness_set(struct led_classdev *cdev,
 
 	dim = led->dim;
 	if (dim < 0)
-		dim = max_t(int,
-			    brightness / (AW200XX_FADE_MAX / AW200XX_DIM_MAX),
-			    1);
+		dim = AW200XX_REG_FADE2DIM(brightness);
 
 	ret = regmap_write(chip->regmap, reg, dim);
 	if (ret)
@@ -460,6 +460,7 @@ static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
 		led->num = source;
 		led->chip = chip;
 		led->cdev.brightness_set_blocking = aw200xx_brightness_set;
+		led->cdev.max_brightness = AW200XX_FADE_MAX;
 		led->cdev.groups = dim_groups;
 		init_data.fwnode = child;
 
-- 
2.36.0

