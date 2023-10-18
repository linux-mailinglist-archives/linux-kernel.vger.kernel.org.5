Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FF7CE68E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJRSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjJRSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:30:04 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220111C;
        Wed, 18 Oct 2023 11:30:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 16D1212000E;
        Wed, 18 Oct 2023 21:30:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 16D1212000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697653800;
        bh=OfG8v4a23hHDZuUDnotHJWVQQ6vM9oZBqvofP9QPn0s=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=FhI1AqwLK/GPYBS3bCF7MlEnXxxf0zPrlJOsbr6dQ8BYPNXerpRtdF+D7heYFaZ4/
         jl02B9cbZMuRqW5EegSB1Lg0r4zMaQWkIj/BgNdk0TObkBV3OOpFXTk7xcS7ERXd9+
         MMSPY/pIXGXsw7LJjyJKaAHmAe7g1KoJ2YbGKwhpQkuw1IK4SCgtPPLE5yVDqcFRTB
         NGq1RFm7C9HxSGts8A2HctsNbMb4x+GhkS0p8wqvOgPkX+RevIXL7SE2eRvrR3eD2n
         pmbVgNKeNOMlD2KsL3/PKNLm4Ua4lb7ZQoWALqIM0yVbsnKh0e43vOfCzeg3pXqNX/
         6DOx6XqLCqfvQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 18 Oct 2023 21:29:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 21:29:55 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        George Stark <gnstark@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 04/11] leds: aw200xx: calculate dts property display_rows in driver
Date:   Wed, 18 Oct 2023 21:29:36 +0300
Message-ID: <20231018182943.18700-5-ddrokosov@salutedevices.com>
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

Get rid of device tree property "awinic,display-rows" and calculate it
in driver using led definition nodes. display-row actually means number
of current switches and depends on how leds are connected to the device.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/leds-aw200xx.c | 39 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 911c3154585f..a2a31b8e623e 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -379,6 +379,31 @@ static void aw200xx_disable(const struct aw200xx *const chip)
 	return gpiod_set_value_cansleep(chip->hwen, 0);
 }
 
+static int aw200xx_probe_get_display_rows(struct device *dev, struct aw200xx *chip)
+{
+	struct fwnode_handle *child;
+	u32 max_source = 0;
+
+	device_for_each_child_node(dev, child) {
+		u32 source;
+		int ret;
+
+		ret = fwnode_property_read_u32(child, "reg", &source);
+		if (ret || source >= chip->cdef->channels)
+			continue;
+
+		max_source = max(max_source, source);
+	}
+
+	chip->display_rows = max_source / chip->cdef->display_size_columns + 1;
+	if (!chip->display_rows) {
+		dev_err(dev, "No valid led definitions found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
 {
 	struct fwnode_handle *child;
@@ -386,18 +411,8 @@ static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
 	int ret;
 	int i;
 
-	ret = device_property_read_u32(dev, "awinic,display-rows",
-				       &chip->display_rows);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to read 'display-rows' property\n");
-
-	if (!chip->display_rows ||
-	    chip->display_rows > chip->cdef->display_size_rows_max) {
-		return dev_err_probe(dev, ret,
-				     "Invalid leds display size %u\n",
-				     chip->display_rows);
-	}
+	if (aw200xx_probe_get_display_rows(dev, chip))
+		return -EINVAL;
 
 	current_max = aw200xx_imax_from_global(chip, AW200XX_IMAX_MAX_uA);
 	current_min = aw200xx_imax_from_global(chip, AW200XX_IMAX_MIN_uA);
-- 
2.36.0

