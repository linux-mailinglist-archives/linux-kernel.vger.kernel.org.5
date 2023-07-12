Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7C751433
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGLXMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjGLXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:12:11 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9016173C;
        Wed, 12 Jul 2023 16:12:09 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CFBD5120027;
        Thu, 13 Jul 2023 02:12:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CFBD5120027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689203527;
        bh=zepCR8ivj1lp2ezam3ZGoENLF/V6fGJqXHQX5mB8FJc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=qg6f7uohyYCVPJBW3RMqOj9zTBN+7Yx1qP/LfjRscSGd1CBfxDCc8HzEXwQpZPORJ
         qN9t+nJmekSb+Q0AW1OzGqFAj0irydtR/2NyCeEpObdddnU7GPp8EEqT+6k5cX8neD
         /RM7a1N1UCBOvf22NgjHK5UXqI3BmrocDYqpbCJmnSJ3rkPsqwv8GhhPvs3dI9k5i6
         +KuTbbKXUDZTe7InAzSddQDXF8TKrygRzQ+Zf3aNhNnG7sByPLV8Gclnn1jFlhgBRM
         jDBOlcDhrpqhoF1Z7YDWaQvt93FXK8D/eN6LxQ9PO8vEA9O4ggLStZgspWB2QpKkWL
         mMURtcbyHs+XA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 13 Jul 2023 02:12:07 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 02:11:48 +0300
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v6 3/6] iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper
Date:   Thu, 13 Jul 2023 02:10:44 +0300
Message-ID: <20230712231157.261245-4-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712231157.261245-1-gnstark@sberdevices.ru>
References: <20230712231157.261245-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178587 [Jul 12 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 521 521 0c3391dd6036774f2e1052158c81e48587b96e95, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/12 10:49:00 #21602221
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

meson_sar_adc_set_chan7_mux is a basic func() for writing single register,
defined as static. Moved it up so it could be used in more places.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 98b6697a21f6..44ac6ce5e3aa 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -336,6 +336,19 @@ static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 					       1, 10000);
 }
 
+static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
+					enum meson_sar_adc_chan7_mux_sel sel)
+{
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	u32 regval;
+
+	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, sel);
+	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
+			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
+
+	usleep_range(10, 20);
+}
+
 static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 const struct iio_chan_spec *chan,
 					 int *val)
@@ -432,19 +445,6 @@ static void meson_sar_adc_enable_channel(struct iio_dev *indio_dev,
 	}
 }
 
-static void meson_sar_adc_set_chan7_mux(struct iio_dev *indio_dev,
-					enum meson_sar_adc_chan7_mux_sel sel)
-{
-	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	u32 regval;
-
-	regval = FIELD_PREP(MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, sel);
-	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
-			   MESON_SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
-
-	usleep_range(10, 20);
-}
-
 static void meson_sar_adc_start_sample_engine(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-- 
2.38.4

