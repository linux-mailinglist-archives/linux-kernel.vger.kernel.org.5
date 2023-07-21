Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07E75C49B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGUKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGUKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:24:48 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BBB30FE;
        Fri, 21 Jul 2023 03:24:24 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 710F210000B;
        Fri, 21 Jul 2023 13:24:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 710F210000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689935062;
        bh=EWUIlxsTDbNkizZTsEpwplf6NYv49AJU87NGu8MEmCk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=oajsjVUx8JDqEcZXEXYVq5mcYmbZpxg0SaO/XN0hWUt2aC3QYWZnntz75Vmoit0kK
         cr6sop1jOhmMFt+rMOh0gI950oYWR+pDKzz+G2MdL/5lWkszX+Fc6pKm6rIlE+24t9
         84Yew9SKyD39Vqm2AEk9jOqBXVNDDtCZiDEiNCXPvsKYIcUpkJ8VIxUCMzJOq5Tgag
         snVql/mpBRCzmNoavl3ZwVJX4vNJ0jlNsFUE57kNYp+G3wHn6YtG8sBgo00PqxGaz/
         JBFJzVVzTwdPedYxPHcD2y1dew65ADVpRFk/0Mx4dUBlNUJIRXZ5f5E4pRDQ27Jqtf
         +NSrdXTWO0fXQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 13:24:22 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 13:24:21 +0300
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: [PATCH v2 2/2] iio: adc: meson: improve error logging at probe stage
Date:   Fri, 21 Jul 2023 13:23:09 +0300
Message-ID: <20230721102413.255726-3-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721102413.255726-1-gnstark@sberdevices.ru>
References: <20230721102413.255726-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178775 [Jul 21 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/21 05:36:00 #21651174
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add log messages for errors that may occur at probe stage

Signed-off-by: George Stark <gnstark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 8397a5347f32..11b10459a028 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1046,8 +1046,10 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	u32 regval;
 
 	ret = meson_sar_adc_lock(indio_dev);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "failed to lock adc\n");
 		goto err_lock;
+	}
 
 	ret = regulator_enable(priv->vref);
 	if (ret < 0) {
@@ -1355,15 +1357,15 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 
 	priv->regmap = devm_regmap_init_mmio(dev, base, priv->param->regmap_config);
 	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
+		return dev_err_probe(dev, PTR_ERR(priv->regmap), "failed to init regmap\n");
 
 	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq)
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL, "failed to get irq\n");
 
 	ret = devm_request_irq(dev, irq, meson_sar_adc_irq, IRQF_SHARED, dev_name(dev), indio_dev);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to request irq\n");
 
 	priv->clkin = devm_clk_get(dev, "clkin");
 	if (IS_ERR(priv->clkin))
@@ -1385,7 +1387,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (!priv->adc_clk) {
 		ret = meson_sar_adc_clk_init(indio_dev, base);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to init internal clk\n");
 	}
 
 	priv->vref = devm_regulator_get(dev, "vref");
@@ -1427,8 +1429,10 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, indio_dev);
 
 	ret = iio_device_register(indio_dev);
-	if (ret)
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register iio device\n");
 		goto err_hw;
+	}
 
 	return 0;
 
-- 
2.38.4

