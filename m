Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE075C49E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjGUKZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjGUKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:24:47 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E030F4;
        Fri, 21 Jul 2023 03:24:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 4C7E410000A;
        Fri, 21 Jul 2023 13:24:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4C7E410000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689935062;
        bh=9mw2Wb+AWetG2JTsZ9sUVojagjBQMLaPFTi87H+EDmQ=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=g9mABSiWFjEp8htrmVKmqIBBJ/ZEodPr1wU+43tAX5hTobZWMgKTHXiVT+Q4kX0I/
         IXOY0KxObc7ohUjjO4PZMErRIxdmCOoxmxwPvTyfONhUM6SsdGo2gwfCuVDiMIx71q
         hfyDLomGoSKpK1FIrTDS6FDngM+DVEnKnNajUVm/aZvNSRgiojCzJo2uf5RlAUjxjU
         QrYZ0uwTgtr1N9dpCJY0K9bfTM7Lgp999YFRUKCjRNLf5OSLs5ToU9rqpmYAD9DUTJ
         vZ4q+Lizy/ddGwp+H9hL0fIb6rV9kB30d/3cfyLIWiv7nerkH/MZDHnzHVF5cmZG98
         Dq9YI5g3QW4xQ==
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
Subject: [PATCH v2 1/2] iio: adc: meson: fix core clock enable/disable moment
Date:   Fri, 21 Jul 2023 13:23:08 +0300
Message-ID: <20230721102413.255726-2-gnstark@sberdevices.ru>
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

Enable core clock at probe stage and disable it at remove stage.
Core clock is responsible for turning on/off the entire SoC module so
it should be on before the first module register is touched and be off
at very last moment.

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: George Stark <gnstark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2ee12f3ad312..8397a5347f32 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1055,12 +1055,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 		goto err_vref;
 	}
 
-	ret = clk_prepare_enable(priv->core_clk);
-	if (ret) {
-		dev_err(dev, "failed to enable core clk\n");
-		goto err_core_clk;
-	}
-
 	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
 			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
@@ -1087,8 +1081,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
 			   MESON_SAR_ADC_REG3_ADC_EN, 0);
 	meson_sar_adc_set_bandgap(indio_dev, false);
-	clk_disable_unprepare(priv->core_clk);
-err_core_clk:
 	regulator_disable(priv->vref);
 err_vref:
 	meson_sar_adc_unlock(indio_dev);
@@ -1116,8 +1108,6 @@ static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 
 	meson_sar_adc_set_bandgap(indio_dev, false);
 
-	clk_disable_unprepare(priv->core_clk);
-
 	regulator_disable(priv->vref);
 
 	if (!ret)
@@ -1379,7 +1369,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clkin))
 		return dev_err_probe(dev, PTR_ERR(priv->clkin), "failed to get clkin\n");
 
-	priv->core_clk = devm_clk_get(dev, "core");
+	priv->core_clk = devm_clk_get_enabled(dev, "core");
 	if (IS_ERR(priv->core_clk))
 		return dev_err_probe(dev, PTR_ERR(priv->core_clk), "failed to get core clk\n");
 
@@ -1462,15 +1452,26 @@ static int meson_sar_adc_remove(struct platform_device *pdev)
 static int meson_sar_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 
 	meson_sar_adc_hw_disable(indio_dev);
 
+	clk_disable_unprepare(priv->core_clk);
+
 	return 0;
 }
 
 static int meson_sar_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->core_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable core clk\n");
+		return ret;
+	}
 
 	return meson_sar_adc_hw_enable(indio_dev);
 }
-- 
2.38.4

