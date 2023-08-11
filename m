Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02C779851
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjHKUO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:14:25 -0400
Received: from out-96.mta1.migadu.com (out-96.mta1.migadu.com [IPv6:2001:41d0:203:375::60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9AB30E8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:14:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691784863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXxLpbwnK2iER9aMBTnDKfRuAwj+8nGNCQhtYFkwJrs=;
        b=fOEGh3YG4Ed6CywSJa3zIzGH2UVPJ+thdSdatxaiyOcU9nDq8LREc/TvthapaRnzpBYlnG
        FkZ+uW225LdaA9JsXIeD5pOY9Rx70nNzbDvQkHyx4EZkch9XQTJ+q+Trt3jDSQ0HaXCLWM
        4TNb6SgeURSj5+UtJy+h5JVwtLu9vuMthKYiutq26Ba0xvfEQSeWgHXfXoIXu0HtFLiMf9
        kKijtcXvYSnpNQ/MVYktvL6GvO1DSGUTJWvhaVC7DleXPcqp14j6KzM9nheB19wcrGJnhQ
        M6Y7kj7j4/qNa4Mbt+bxVFjD7KRyMATH5Ja2J+Lsga4DJsrlT78qDjwMeGd7LA==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] ASoC: sunxi: sun4i-i2s: Prepare for runtime DIN pin selection
Date:   Sat, 12 Aug 2023 06:14:00 +1000
Message-ID: <20230811201406.4096210-2-contact@jookia.org>
In-Reply-To: <20230811201406.4096210-1-contact@jookia.org>
References: <20230811201406.4096210-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R329 and D1 support multiple I2S data input pins, but to use these
they require explicit mapping to channels.

Add a mapping of DIN pins to the 16 channels in the sun4i_i2s struct
then use that to write the channel mapping register.

For now the mapping is always to DIN0, identical to the previous
behaviour.

Signed-off-by: John Watts <contact@jookia.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 40 +++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 669d712bbe9f..d8f999ecaf05 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -216,6 +216,7 @@ struct sun4i_i2s {
 	unsigned int	mclk_freq;
 	unsigned int	slots;
 	unsigned int	slot_width;
+	u8	channel_dins[16];
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -233,6 +234,13 @@ struct sun4i_i2s_clk_div {
 	u8	val;
 };
 
+static int sun4i_i2s_read_channel_dins(struct device *dev, struct sun4i_i2s *i2s)
+{
+	/* Use DIN pin 0 by default */
+	memset(i2s->channel_dins, 0, sizeof(i2s->channel_dins));
+	return 0;
+}
+
 static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 2, .val = 0 },
 	{ .div = 4, .val = 1 },
@@ -527,6 +535,25 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	return 0;
 }
 
+static void sun50i_h6_write_channel_map(const struct sun4i_i2s *i2s,
+					unsigned int reg,
+					unsigned int channel_start)
+{
+	unsigned int reg_value = 0;
+
+	/* Loop backwards so we can shift values in */
+	for (int i = 3; i >= 0; i--) {
+		int channel = channel_start + i;
+		u8 din = i2s->channel_dins[channel];
+		u8 slot = channel; /* Map slot to channel */
+
+		reg_value <<= 8;
+		reg_value |= (din << 4) | slot;
+	}
+
+	regmap_write(i2s->regmap, reg, reg_value);
+}
+
 static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 				      unsigned int channels, unsigned int slots,
 				      unsigned int slot_width)
@@ -537,10 +564,10 @@ static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP0_REG(0), 0xFEDCBA98);
 	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG(0), 0x76543210);
 	if (i2s->variant->num_din_pins > 1) {
-		regmap_write(i2s->regmap, SUN50I_R329_I2S_RX_CHAN_MAP0_REG, 0x0F0E0D0C);
-		regmap_write(i2s->regmap, SUN50I_R329_I2S_RX_CHAN_MAP1_REG, 0x0B0A0908);
-		regmap_write(i2s->regmap, SUN50I_R329_I2S_RX_CHAN_MAP2_REG, 0x07060504);
-		regmap_write(i2s->regmap, SUN50I_R329_I2S_RX_CHAN_MAP3_REG, 0x03020100);
+		sun50i_h6_write_channel_map(i2s, SUN50I_R329_I2S_RX_CHAN_MAP0_REG, 12);
+		sun50i_h6_write_channel_map(i2s, SUN50I_R329_I2S_RX_CHAN_MAP1_REG, 8);
+		sun50i_h6_write_channel_map(i2s, SUN50I_R329_I2S_RX_CHAN_MAP2_REG, 4);
+		sun50i_h6_write_channel_map(i2s, SUN50I_R329_I2S_RX_CHAN_MAP3_REG, 0);
 	} else {
 		regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0xFEDCBA98);
 		regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
@@ -1559,6 +1586,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (sun4i_i2s_read_channel_dins(&pdev->dev, i2s)) {
+		dev_err(&pdev->dev, "Invalid channel DINs\n");
+		return -EINVAL;
+	}
+
 	i2s->playback_dma_data.addr = res->start +
 					i2s->variant->reg_offset_txdata;
 	i2s->playback_dma_data.maxburst = 8;
-- 
2.41.0

