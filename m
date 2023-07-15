Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CFF75485E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGOLHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 07:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGOLHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 07:07:10 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA1269D;
        Sat, 15 Jul 2023 04:07:06 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 45C82100009;
        Sat, 15 Jul 2023 14:07:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 45C82100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689419223;
        bh=dZOh2J+PejsEqvr9CEyYrAsUac8NNrLT8A1ago5/XVo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=L254plI7N+aHYEHu1aptAhg3pCJmrU35E7F27SK1G8PLwgqDhPlpeD2mNOCo1jAnA
         N/4ySi56FUGA+FlEXlxf7UAHlKithRa2IXnwl3uo9OJDDIHhUUG+yXXHYF5fq45CI0
         DN3z1DYUv+0Xm507TZwHNjHEvGU8rFhrbWO4xLv3r69guwKlG//PqAvVidtGUADaoW
         sjSFmzE2B/gOkGy4hodhUeeJwWxKMStWZRRuP5w17r4UQ2aXAkCiATYAE6vojRwwwG
         IhZ4y2WP/Il7cSncXP4KoWUWAv3h/NmN5PCBqb+WclbaFF9Ec2306S0cuaaQtAMmvg
         IUPCgaWoZMJ4A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Sat, 15 Jul 2023 14:07:03 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 15 Jul 2023 14:06:23 +0300
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
Subject: [PATCH v1 2/3] iio: adc: meson: init internal continuous ring counter
Date:   Sat, 15 Jul 2023 14:05:59 +0300
Message-ID: <20230715110654.6035-3-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715110654.6035-1-gnstark@sberdevices.ru>
References: <20230715110654.6035-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178635 [Jul 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/15 07:52:00 #21618415
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

Disable internal continuous ring counter at init stage. Disable value
depends on SoC family: gxl and later SoCs write 1, others write 0.
This bit are inited in vendor boot code (bl2, bl33) already so do it
in the driver to not depend on other code.

Signed-off-by: George Stark <gnstark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 524e5569381e..806ba7cd7320 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -313,6 +313,7 @@ struct meson_sar_adc_param {
 	u8					temperature_trimming_bits;
 	unsigned int				temperature_multiplier;
 	unsigned int				temperature_divider;
+	u8					disable_ring_counter;
 };
 
 struct meson_sar_adc_data {
@@ -967,6 +968,12 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 				   MESON_SAR_ADC_DELTA_10_TS_REVE0, 0);
 	}
 
+	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
+			    priv->param->disable_ring_counter);
+	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			   MESON_SAR_ADC_REG3_CTRL_CONT_RING_COUNTER_EN,
+			   regval);
+
 	ret = clk_set_parent(priv->adc_sel_clk, priv->clkin);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to set adc parent to clkin\n");
@@ -1196,6 +1203,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
+	.disable_ring_counter = 1,
 };
 
 static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
@@ -1204,6 +1212,7 @@ static const struct meson_sar_adc_param meson_sar_adc_g12a_param = {
 	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
+	.disable_ring_counter = 1,
 };
 
 static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
-- 
2.38.4

