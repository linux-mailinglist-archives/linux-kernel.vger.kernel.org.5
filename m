Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA5771149
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHESGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjHESGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:06:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC633C0A;
        Sat,  5 Aug 2023 11:05:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso30919055e9.1;
        Sat, 05 Aug 2023 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691258749; x=1691863549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAC/Wd+inkjB4rZNJmg2rnNyd7z2tGVBYSRDfN+uDnU=;
        b=QalTVPp99U5GkYPsftBnJpEN/E3WVR1rI51rfqRh6+txnTAGebddqZIzLWYGbywjwa
         BXB/ztRyBIhZfaqsEViuxXDjzDrVSu/cOzlN2akYtc7YRXZ3HUraBqg1kj/7+VRoiDlM
         bo7u5eTypSQdGZenPjdR0A7LGfcx2y8spn4PEC8O4P2B+svZsA+k+heATQV+jyrOnFj9
         Z0c7mSkuiK+H5/6kpbLdugJNmUKUU6JHXhegDkFvMmpCl3WLD+C3HD/MCyJqV7jNgLtW
         hM/MN+D7rx81l3nri3rlikILCQfEAeKN3Wnsj0C79RNrLwMoo2+txBWm96GwA/ef3JV0
         wZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691258749; x=1691863549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAC/Wd+inkjB4rZNJmg2rnNyd7z2tGVBYSRDfN+uDnU=;
        b=YanZ5gx5PcYS1INg4nWgbcZx4LQN9JY9KnQTUaNmqPZpuS9qbYPpRAsMFyox/iz7z8
         EgwPOGTn/5MroKGsCExfWwPBRmLOSjVjbSlSuFdr3LHGzV6ogiQ8ZoMY3Fu/4QKEm+Qx
         8VIElbRoyuXcbbySeuTCQ7sLfUhLQmYdIi0yqgBWCmsDytl2BZPgFndnmMsCh/tnFSiZ
         E74S5NpPASXOaawWS15N+MyhQzeXRffQM5M8L1qpsEfm3gK2jVSP46uX8CTuNhYD8VU7
         7fAb67bTh6Pi/Z3lBrWE+rTLtEVLcYCyEl5J/G6WkunktU0Mpyi4lX61ZKzqLCBlk0lU
         MfAQ==
X-Gm-Message-State: AOJu0YyBnpcqZCJvIuIVJEa8Dv4tCtS53eSgoMvHmDeLV2Sy0/nn/Je6
        LDE1HT3nV5X7OAVapOmTx0gyQNNrYXRQoQ==
X-Google-Smtp-Source: AGHT+IHq3qJBx8OwucTasP0y54mcsYMF8ABW5B6yS8muHb6MykWjBz3vRDYpRoFBtQWY1Dzou+tqWA==
X-Received: by 2002:a7b:c850:0:b0:3fe:173e:4a34 with SMTP id c16-20020a7bc850000000b003fe173e4a34mr3579314wml.40.1691258748561;
        Sat, 05 Aug 2023 11:05:48 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6104000000b003176aa612b1sm5710402wrt.38.2023.08.05.11.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 11:05:48 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/5] ASoC: sunxi: sun4i-codec: add basic support for D1 audio codec
Date:   Sat,  5 Aug 2023 21:05:03 +0300
Message-Id: <20230805180506.718364-4-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805180506.718364-1-bigunclemax@gmail.com>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner D1 has an audio codec similar to earlier ones, but it comes
with 3 channel ADC instead of 2, and many registers are moved.

Add basic support for it.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 364 ++++++++++++++++++++++++++++------
 1 file changed, 300 insertions(+), 64 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 55328850aef5..4d4f396da3ee 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -232,15 +232,65 @@
 
 /* TODO H3 DAP (Digital Audio Processing) bits */
 
+/*
+ * sun20i D1 and similar codecs specific registers
+ *
+ * Almost all registers moved on D1, including ADC digital controls,
+ * FIFO and RX data registers. Only DAC control are at the same offset.
+ */
+
+#define SUN20I_D1_CODEC_DAC_VOL_CTRL		(0x04)
+#define SUN20I_D1_CODEC_DAC_VOL_SEL			(16)
+#define SUN20I_D1_CODEC_DAC_VOL_L			(8)
+#define SUN20I_D1_CODEC_DAC_VOL_R			(0)
+#define SUN20I_D1_CODEC_DAC_FIFOC		(0x10)
+#define SUN20I_D1_CODEC_ADC_FIFOC		(0x30)
+#define SUN20I_D1_CODEC_ADC_FIFOC_EN_AD			(28)
+#define SUN20I_D1_CODEC_ADC_FIFOC_RX_SAMPLE_BITS	(16)
+#define SUN20I_D1_CODEC_ADC_FIFOC_RX_TRIG_LEVEL		(4)
+#define SUN20I_D1_CODEC_ADC_FIFOC_ADC_DRQ_EN		(3)
+#define SUN20I_D1_CODEC_ADC_VOL_CTRL1		(0x34)
+#define SUN20I_D1_CODEC_ADC_VOL_CTRL1_ADC3_VOL		(16)
+#define SUN20I_D1_CODEC_ADC_VOL_CTRL1_ADC2_VOL		(8)
+#define SUN20I_D1_CODEC_ADC_VOL_CTRL1_ADC1_VOL		(0)
+#define SUN20I_D1_CODEC_ADC_RXDATA		(0x40)
+#define SUN20I_D1_CODEC_ADC_DIG_CTRL		(0x50)
+#define SUN20I_D1_CODEC_ADC_DIG_CTRL_ADC3_CH_EN		(2)
+#define SUN20I_D1_CODEC_ADC_DIG_CTRL_ADC2_CH_EN		(1)
+#define SUN20I_D1_CODEC_ADC_DIG_CTRL_ADC1_CH_EN		(0)
+#define SUN20I_D1_CODEC_VRA1SPEEDUP_DOWN_CTRL	(0x54)
+
+/* TODO D1 DAP (Digital Audio Processing) bits */
+
+struct sun4i_codec;
+
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+	const struct snd_soc_component_driver *codec;
+	struct snd_soc_card * (*create_card)(struct device *dev);
+	struct reg_field reg_dac_fifoc;	/* used for regmap_field */
+	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
+	unsigned int adc_drq_en;
+	unsigned int rx_sample_bits;
+	unsigned int rx_trig_level;
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
+	bool has_reset;
+	bool has_dual_clock;
+};
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
 	struct clk	*clk_apb;
-	struct clk	*clk_module;
+	struct clk	*clk_module; /* used for ADC if clocks are separate */
+	struct clk	*clk_module_dac;
 	struct reset_control *rst;
 	struct gpio_desc *gpio_pa;
+	const struct sun4i_codec_quirks *quirks;
 
-	/* ADC_FIFOC register is at different offset on different SoCs */
+	/* DAC/ADC FIFOC registers are at different offset on different SoCs */
+	struct regmap_field *reg_dac_fifoc;
 	struct regmap_field *reg_adc_fifoc;
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
@@ -250,33 +300,33 @@ struct sun4i_codec {
 static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
 {
 	/* Flush TX FIFO */
-	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
+	regmap_field_set_bits(scodec->reg_dac_fifoc,
+			      BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
 
 	/* Enable DAC DRQ */
-	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
+	regmap_field_set_bits(scodec->reg_dac_fifoc,
+			      BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
 }
 
 static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 {
 	/* Disable DAC DRQ */
-	regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			  BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
+	regmap_field_clear_bits(scodec->reg_dac_fifoc,
+				BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
 }
 
 static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 {
 	/* Enable ADC DRQ */
 	regmap_field_set_bits(scodec->reg_adc_fifoc,
-			      BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
+			      BIT(scodec->quirks->adc_drq_en));
 }
 
 static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
 {
 	/* Disable ADC DRQ */
 	regmap_field_clear_bits(scodec->reg_adc_fifoc,
-				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
+				BIT(scodec->quirks->adc_drq_en));
 }
 
 static int sun4i_codec_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -325,8 +375,8 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 
 	/* Set RX FIFO trigger level */
 	regmap_field_update_bits(scodec->reg_adc_fifoc,
-				 0xf << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
-				 0x7 << SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL);
+				 0xf << scodec->quirks->rx_trig_level,
+				 0x7 << scodec->quirks->rx_trig_level);
 
 	/*
 	 * FIXME: Undocumented in the datasheet, but
@@ -360,13 +410,13 @@ static int sun4i_codec_prepare_playback(struct snd_pcm_substream *substream,
 	u32 val;
 
 	/* Flush the TX FIFO */
-	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
+	regmap_field_set_bits(scodec->reg_dac_fifoc,
+			      BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
 
 	/* Set TX FIFO Empty Trigger Level */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   0x3f << SUN4I_CODEC_DAC_FIFOC_TX_TRIG_LEVEL,
-			   0xf << SUN4I_CODEC_DAC_FIFOC_TX_TRIG_LEVEL);
+	regmap_field_update_bits(scodec->reg_dac_fifoc,
+				 0x3f << SUN4I_CODEC_DAC_FIFOC_TX_TRIG_LEVEL,
+				 0xf << SUN4I_CODEC_DAC_FIFOC_TX_TRIG_LEVEL);
 
 	if (substream->runtime->rate > 32000)
 		/* Use 64 bits FIR filter */
@@ -375,13 +425,12 @@ static int sun4i_codec_prepare_playback(struct snd_pcm_substream *substream,
 		/* Use 32 bits FIR filter */
 		val = BIT(SUN4I_CODEC_DAC_FIFOC_FIR_VERSION);
 
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_FIR_VERSION),
-			   val);
+	regmap_field_update_bits(scodec->reg_dac_fifoc,
+				 BIT(SUN4I_CODEC_DAC_FIFOC_FIR_VERSION), val);
 
 	/* Send zeros when we have an underrun */
-	regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_SEND_LASAT));
+	regmap_field_clear_bits(scodec->reg_dac_fifoc,
+				BIT(SUN4I_CODEC_DAC_FIFOC_SEND_LASAT));
 
 	return 0;
 };
@@ -476,30 +525,32 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 				 7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
 				 hwrate << SUN4I_CODEC_ADC_FIFOC_ADC_FS);
 
-	/* Set the number of channels we want to use */
-	if (params_channels(params) == 1)
-		regmap_field_set_bits(scodec->reg_adc_fifoc,
-					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
-	else
-		regmap_field_clear_bits(scodec->reg_adc_fifoc,
-					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
+	if (!scodec->quirks->has_dual_clock) {
+		/* Set the number of channels we want to use */
+		if (params_channels(params) == 1)
+			regmap_field_set_bits(scodec->reg_adc_fifoc,
+					      BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
+		else
+			regmap_field_clear_bits(scodec->reg_adc_fifoc,
+						BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
+	}
 
 	/* Set the number of sample bits to either 16 or 24 bits */
 	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
 		regmap_field_set_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
+				      BIT(scodec->quirks->rx_sample_bits));
 
 		regmap_field_clear_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
+					BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
 
 		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	} else {
 		regmap_field_clear_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
+					BIT(scodec->quirks->rx_sample_bits));
 
 		/* Fill most significant bits with valid data MSB */
 		regmap_field_set_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
+				      BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
 
 		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	}
@@ -514,9 +565,9 @@ static int sun4i_codec_hw_params_playback(struct sun4i_codec *scodec,
 	u32 val;
 
 	/* Set DAC sample rate */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   7 << SUN4I_CODEC_DAC_FIFOC_DAC_FS,
-			   hwrate << SUN4I_CODEC_DAC_FIFOC_DAC_FS);
+	regmap_field_update_bits(scodec->reg_dac_fifoc,
+				 7 << SUN4I_CODEC_DAC_FIFOC_DAC_FS,
+				 hwrate << SUN4I_CODEC_DAC_FIFOC_DAC_FS);
 
 	/* Set the number of channels we want to use */
 	if (params_channels(params) == 1)
@@ -524,27 +575,26 @@ static int sun4i_codec_hw_params_playback(struct sun4i_codec *scodec,
 	else
 		val = 0;
 
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_MONO_EN),
-			   val);
+	regmap_field_update_bits(scodec->reg_dac_fifoc,
+				 BIT(SUN4I_CODEC_DAC_FIFOC_MONO_EN), val);
 
 	/* Set the number of sample bits to either 16 or 24 bits */
 	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
-		regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
+		regmap_field_set_bits(scodec->reg_dac_fifoc,
+				      BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
 
 		/* Set TX FIFO mode to padding the LSBs with 0 */
-		regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
+		regmap_field_clear_bits(scodec->reg_dac_fifoc,
+					BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
 
 		scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	} else {
-		regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
+		regmap_field_clear_bits(scodec->reg_dac_fifoc,
+					BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
 
 		/* Set TX FIFO mode to repeat the MSB */
-		regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
+		regmap_field_set_bits(scodec->reg_dac_fifoc,
+				      BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
 
 		scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	}
@@ -565,7 +615,11 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	if (!clk_freq)
 		return -EINVAL;
 
-	ret = clk_set_rate(scodec->clk_module, clk_freq);
+	if (scodec->clk_module_dac &&
+	    substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ret = clk_set_rate(scodec->clk_module_dac, clk_freq);
+	else
+		ret = clk_set_rate(scodec->clk_module, clk_freq);
 	if (ret)
 		return ret;
 
@@ -607,10 +661,14 @@ static int sun4i_codec_startup(struct snd_pcm_substream *substream,
 	 * Stop issuing DRQ when we have room for less than 16 samples
 	 * in our TX FIFO
 	 */
-	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   3 << SUN4I_CODEC_DAC_FIFOC_DRQ_CLR_CNT);
+	regmap_field_set_bits(scodec->reg_dac_fifoc,
+			      3 << SUN4I_CODEC_DAC_FIFOC_DRQ_CLR_CNT);
 
-	return clk_prepare_enable(scodec->clk_module);
+	if (scodec->clk_module_dac &&
+	    substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return clk_prepare_enable(scodec->clk_module_dac);
+	else
+		return clk_prepare_enable(scodec->clk_module);
 }
 
 static void sun4i_codec_shutdown(struct snd_pcm_substream *substream,
@@ -619,7 +677,11 @@ static void sun4i_codec_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 
-	clk_disable_unprepare(scodec->clk_module);
+	if (scodec->clk_module_dac &&
+	    substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		clk_disable_unprepare(scodec->clk_module_dac);
+	else
+		clk_disable_unprepare(scodec->clk_module);
 }
 
 static const struct snd_soc_dai_ops sun4i_codec_dai_ops = {
@@ -1229,6 +1291,55 @@ static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
 	.endianness		= 1,
 };
 
+/* sun20i D1 codec */
+static const DECLARE_TLV_DB_SCALE(sun20i_d1_codec_dvol_scale, -12000, 75, 1);
+
+static const struct snd_kcontrol_new sun20i_d1_codec_codec_controls[] = {
+	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
+		       SUN4I_CODEC_DAC_DPC_DVOL, 0x3f, 1,
+		       sun6i_codec_dvol_scale),
+	SOC_DOUBLE_TLV("DAC Front Playback Volume", SUN20I_D1_CODEC_DAC_VOL_CTRL,
+		       SUN20I_D1_CODEC_DAC_VOL_L, SUN20I_D1_CODEC_DAC_VOL_R,
+		       0xFF, 0, sun20i_d1_codec_dvol_scale),
+
+	SOC_SINGLE_TLV("ADC1 Capture Volume", SUN20I_D1_CODEC_ADC_VOL_CTRL1,
+		       SUN20I_D1_CODEC_ADC_VOL_CTRL1_ADC1_VOL, 0xff, 0,
+		       sun20i_d1_codec_dvol_scale),
+	SOC_SINGLE_TLV("ADC2 Capture Volume", SUN20I_D1_CODEC_ADC_VOL_CTRL1,
+		       SUN20I_D1_CODEC_ADC_VOL_CTRL1_ADC2_VOL, 0xff, 0,
+		       sun20i_d1_codec_dvol_scale),
+	SOC_SINGLE_TLV("ADC3 Capture Volume", SUN20I_D1_CODEC_ADC_VOL_CTRL1,
+		       SUN20I_D1_CODEC_ADC_VOL_CTRL1_ADC3_VOL, 0xff, 0,
+		       sun20i_d1_codec_dvol_scale),
+};
+
+static const struct snd_soc_dapm_widget sun20i_d1_codec_codec_widgets[] = {
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUN20I_D1_CODEC_ADC_FIFOC,
+			    SUN20I_D1_CODEC_ADC_FIFOC_EN_AD, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC1 CH Enable", SUN20I_D1_CODEC_ADC_DIG_CTRL,
+			    SUN20I_D1_CODEC_ADC_DIG_CTRL_ADC1_CH_EN, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC2 CH Enable", SUN20I_D1_CODEC_ADC_DIG_CTRL,
+			    SUN20I_D1_CODEC_ADC_DIG_CTRL_ADC2_CH_EN, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC3 CH Enable", SUN20I_D1_CODEC_ADC_DIG_CTRL,
+			    SUN20I_D1_CODEC_ADC_DIG_CTRL_ADC3_CH_EN, 0, NULL, 0),
+	/* Digital parts of the DACs */
+	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
+			    SUN4I_CODEC_DAC_DPC_EN_DA, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC VOL_SEL Enable", SUN20I_D1_CODEC_DAC_VOL_CTRL,
+			    SUN20I_D1_CODEC_DAC_VOL_SEL, 0, NULL, 0),
+};
+
+static const struct snd_soc_component_driver sun20i_d1_codec_codec = {
+	.controls		= sun20i_d1_codec_codec_controls,
+	.num_controls		= ARRAY_SIZE(sun20i_d1_codec_codec_controls),
+	.dapm_widgets		= sun20i_d1_codec_codec_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun20i_d1_codec_codec_widgets),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name			= "sun4i-codec",
 	.legacy_dai_naming	= 1,
@@ -1528,6 +1639,66 @@ static struct snd_soc_card *sun8i_v3s_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct snd_soc_dapm_route sun20i_d1_codec_card_routes[] = {
+	/* ADC Routes */
+	{ "ADC1", NULL, "ADC Enable" },
+	{ "ADC2", NULL, "ADC Enable" },
+	{ "ADC3", NULL, "ADC Enable" },
+	{ "ADC1", NULL, "ADC1 CH Enable" },
+	{ "ADC2", NULL, "ADC2 CH Enable" },
+	{ "ADC3", NULL, "ADC3 CH Enable" },
+	{ "Codec Capture", NULL, "ADC1" },
+	{ "Codec Capture", NULL, "ADC2" },
+	{ "Codec Capture", NULL, "ADC3" },
+
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+	{ "Left DAC", NULL, "DAC VOL_SEL Enable" },
+	{ "Right DAC", NULL, "DAC VOL_SEL Enable" },
+	{ "Left DAC", NULL, "Codec Playback" },
+	{ "Right DAC", NULL, "Codec Playback" },
+};
+
+static struct snd_soc_card *sun20i_d1_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	aux_dev.dlc.of_node = of_parse_phandle(dev->of_node,
+					       "allwinner,codec-analog-controls",
+					       0);
+	if (!aux_dev.dlc.of_node) {
+		dev_err(dev, "Can't find analog controls for codec.\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	card->dev		= dev;
+	card->owner		= THIS_MODULE;
+	card->name		= "D1 Audio Codec";
+	card->dapm_widgets	= sun6i_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(sun6i_codec_card_dapm_widgets);
+	card->dapm_routes	= sun20i_d1_codec_card_routes;
+	card->num_dapm_routes	= ARRAY_SIZE(sun20i_d1_codec_card_routes);
+	card->aux_dev		= &aux_dev;
+	card->num_aux_devs	= 1;
+	card->fully_routed	= true;
+
+	ret = snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
+
+	return card;
+};
+
 static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1570,21 +1741,22 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
 	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
 };
 
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-	const struct snd_soc_component_driver *codec;
-	struct snd_soc_card * (*create_card)(struct device *dev);
-	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
-	bool has_reset;
+static const struct regmap_config sun20i_d1_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN20I_D1_CODEC_VRA1SPEEDUP_DOWN_CTRL,
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.regmap_config	= &sun4i_codec_regmap_config,
 	.codec		= &sun4i_codec_codec,
 	.create_card	= sun4i_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
 };
@@ -1593,7 +1765,11 @@ static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
 	.regmap_config	= &sun6i_codec_regmap_config,
 	.codec		= &sun6i_codec_codec,
 	.create_card	= sun6i_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
@@ -1603,7 +1779,11 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.regmap_config	= &sun7i_codec_regmap_config,
 	.codec		= &sun7i_codec_codec,
 	.create_card	= sun4i_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
 };
@@ -1612,7 +1792,11 @@ static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
 	.regmap_config	= &sun8i_a23_codec_regmap_config,
 	.codec		= &sun8i_a23_codec_codec,
 	.create_card	= sun8i_a23_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
@@ -1627,7 +1811,11 @@ static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
 	 */
 	.codec		= &sun8i_a23_codec_codec,
 	.create_card	= sun8i_h3_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
@@ -1641,12 +1829,31 @@ static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
 	 */
 	.codec		= &sun8i_a23_codec_codec,
 	.create_card	= sun8i_v3s_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_adc_fifoc	= REG_FIELD(SUN6I_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN4I_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
 };
 
+static const struct sun4i_codec_quirks sun20i_d1_codec_quirks = {
+	.regmap_config	= &sun20i_d1_codec_regmap_config,
+	.codec		= &sun20i_d1_codec_codec,
+	.create_card	= sun20i_d1_codec_create_card,
+	.reg_dac_fifoc	= REG_FIELD(SUN20I_D1_CODEC_DAC_FIFOC, 0, 31),
+	.reg_adc_fifoc	= REG_FIELD(SUN20I_D1_CODEC_ADC_FIFOC, 0, 31),
+	.adc_drq_en	= SUN20I_D1_CODEC_ADC_FIFOC_ADC_DRQ_EN,
+	.rx_sample_bits	= SUN20I_D1_CODEC_ADC_FIFOC_RX_SAMPLE_BITS,
+	.rx_trig_level	= SUN20I_D1_CODEC_ADC_FIFOC_RX_TRIG_LEVEL,
+	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUN20I_D1_CODEC_ADC_RXDATA,
+	.has_reset	= true,
+	.has_dual_clock = true,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-codec",
@@ -1672,6 +1879,10 @@ static const struct of_device_id sun4i_codec_of_match[] = {
 		.compatible = "allwinner,sun8i-v3s-codec",
 		.data = &sun8i_v3s_codec_quirks,
 	},
+	{
+		.compatible = "allwinner,sun20i-d1-codec",
+		.data = &sun20i_d1_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
@@ -1700,6 +1911,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
+	scodec->quirks = quirks;
 
 	scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       quirks->regmap_config);
@@ -1715,10 +1927,24 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->clk_apb);
 	}
 
-	scodec->clk_module = devm_clk_get(&pdev->dev, "codec");
-	if (IS_ERR(scodec->clk_module)) {
-		dev_err(&pdev->dev, "Failed to get the module clock\n");
-		return PTR_ERR(scodec->clk_module);
+	if (quirks->has_dual_clock) {
+		scodec->clk_module = devm_clk_get(&pdev->dev, "adc");
+		if (IS_ERR(scodec->clk_module)) {
+			dev_err(&pdev->dev, "Failed to get the ADC module clock\n");
+			return PTR_ERR(scodec->clk_module);
+		}
+
+		scodec->clk_module_dac = devm_clk_get(&pdev->dev, "dac");
+		if (IS_ERR(scodec->clk_module_dac)) {
+			dev_err(&pdev->dev, "Failed to get the DAC module clock\n");
+			return PTR_ERR(scodec->clk_module_dac);
+		}
+	} else {
+		scodec->clk_module = devm_clk_get(&pdev->dev, "codec");
+		if (IS_ERR(scodec->clk_module)) {
+			dev_err(&pdev->dev, "Failed to get the module clock\n");
+			return PTR_ERR(scodec->clk_module);
+		}
 	}
 
 	if (quirks->has_reset) {
@@ -1749,6 +1975,16 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	scodec->reg_dac_fifoc = devm_regmap_field_alloc(&pdev->dev,
+							scodec->regmap,
+							quirks->reg_dac_fifoc);
+	if (IS_ERR(scodec->reg_dac_fifoc)) {
+		ret = PTR_ERR(scodec->reg_dac_fifoc);
+		dev_err(&pdev->dev, "Failed to create regmap fields: %d\n",
+			ret);
+		return ret;
+	}
+
 	/* Enable the bus clock */
 	if (clk_prepare_enable(scodec->clk_apb)) {
 		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
-- 
2.39.2

