Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2CD7539B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjGNLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjGNLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:40:26 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ACEE65;
        Fri, 14 Jul 2023 04:40:23 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 4203A120029;
        Fri, 14 Jul 2023 14:40:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4203A120029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689334820;
        bh=g3nghZBGDTNeQp+PCOR94djYNfXjY5y9b7dTwR9LJgk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=JxtMs0n8UDCOCTzBHF0qvvTO5W+ujdagBhSa1CMj86fqxO5Jm99VCQNnbW0q92TXV
         M0tdn5NFlU77tgvLVpLhKkZg6NDztUSIie6HH/JN8hwVQS8y2+1CSJ0PNA0FUhGEw7
         cgrRzZf/HsAIoyZnDhjw+kcOMPdfpCI0BS4b4nKaO3XUJM5nyL4qY+CcxIJKMGXzdv
         gadHclpxFFVGgUCddPvVq/75tXbDBmBDeUj7UNQ7cYOc1Gxpuxvzkp/0Xd+n+EqQ33
         cyfC9Hb6dMJVtB6JUL0qDC4fCAPgE6il7VyxtO/gVpeTesRUD2rXPgUzKYgm16G7dX
         ejC3NmXNSvAwA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 14 Jul 2023 14:40:20 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 14:39:48 +0300
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
Subject: [PATCH v7 3/6] iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper
Date:   Fri, 14 Jul 2023 14:37:50 +0300
Message-ID: <20230714114010.293440-4-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714114010.293440-1-gnstark@sberdevices.ru>
References: <20230714114010.293440-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178622 [Jul 14 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/14 02:46:00 #21611850
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

