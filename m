Return-Path: <linux-kernel+bounces-77121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC60860174
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCDBB2223E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E115D5AB;
	Thu, 22 Feb 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="wrkOwpD7"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1814F99E;
	Thu, 22 Feb 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625939; cv=none; b=Mjv269JZWz/2u7/adSzQpVXa6X7t05PPp3qSnY+vl4/PulannDGfHNNNgyjiMI99DV6Ksk6C55ESabzwSfFTbaTO6ijyu1eb/iBoeVgKPWM92fEcbQGfz4cOgE7KRjz91B2oq8kPofKHZZroqjbGkQSdSQbYN2cEu8GVT6k0IEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625939; c=relaxed/simple;
	bh=zEYEjJpWS/2RpwHzMoVR1JN0VC9wPDX+31y4Z9y8aL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCh25dP3wZGBN5nNrsVF5i4bjPT+T3PFa94scg2zbPh1Q6iLLOUw06u+/hwsTfj0x8xEMN8+mkHKjtDn8PwLd2QGkrcYfveQx0HwvlwAq5+5pRv3nZk8HeE82UkgjEDkXzggwvlkogEJzlqXu2qqh6GMkOY18J3/m5ldBSyNlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=wrkOwpD7; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708625935; bh=zEYEjJpWS/2RpwHzMoVR1JN0VC9wPDX+31y4Z9y8aL8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=wrkOwpD7306NTvSBVZO+Sv31n73MjaIUE4haJd6XWoAOxOEzPiis8t/UCzZLjdOKK
	 MDMWtFMzC38tpNq+PK7EICXCzYG1txOgo0QvStP7qCVIM2GfXXmSP9jAA9re5Et/Zz
	 bT1JFpb99bXPQ+Ne9itQLaRXx8Xms9B8juSqqqlk=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ondrej Jirman <megi@xff.cz>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 4/4] ASoC: sun8i-codec: Implement jack and accessory detection
Date: Thu, 22 Feb 2024 19:18:47 +0100
Message-ID: <20240222181851.3398254-5-megi@xff.cz>
In-Reply-To: <20240222181851.3398254-1-megi@xff.cz>
References: <20240222181851.3398254-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Add support for the jack detection functionality in the A64 variant,
which uses a pair of IRQs; and microphone accessory (button) detection,
which uses an ADC with an IRQ trigger.

Since not all users of this component have a headphone or headset jack,
only enable jack pins where the corresponding widget exists. Similarly,
only enable microphone accessory detection when the microphone is hooked
up to a headset jack.

IRQs will only be triggered if the JACKDETEN, HMICBIASEN, and MICADCEN
bits are set appropriately in the analog codec component, but there is
no direct software dependency between the two components.

Setup ADC so that it samples with period of 16ms, disable smoothing
and enable MDATA threshold (should be below idle voltage/HMIC_DATA
value). Also enable HMIC_N, which makes sure we get HMIC_N samples
after HMIC_DATA crosses the threshold.

This allows us to perform steady state detection of HMIC_DATA, by
comparing current and previous ADC samples, to detect end of the
transient when the user de-presses the button. Otherwise ADC could
sample anywhere within the transient, and the driver may mis-issue
key-press events for other buttons attached to the resistor ladder.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: Decouple from analog codec, automatic pin detection, fixes]
Co-developed-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
[Ondrej: Re-work the sampling mechanism to prevent mis-detection of
button presses due to slow transient change of mic line DC voltage.
Completely rewritten interrupt handling, to debounce plugin
plugout interrupt events properly.]
Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 sound/soc/sunxi/sun50i-codec-analog.c |  12 +
 sound/soc/sunxi/sun8i-codec.c         | 351 ++++++++++++++++++++++++++
 2 files changed, 363 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 2081721a8ff2..2dcdf113b66e 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -115,6 +115,11 @@
 #define SUN50I_ADDA_HS_MBIAS_CTRL	0x0e
 #define SUN50I_ADDA_HS_MBIAS_CTRL_MMICBIASEN	7
 
+#define SUN50I_ADDA_MDET_CTRL		0x1c
+#define SUN50I_ADDA_MDET_CTRL_SELDETADC_FS	4
+#define SUN50I_ADDA_MDET_CTRL_SELDETADC_DB	2
+#define SUN50I_ADDA_MDET_CTRL_SELDETADC_BF	0
+
 #define SUN50I_ADDA_JACK_MIC_CTRL	0x1d
 #define SUN50I_ADDA_JACK_MIC_CTRL_JACKDETEN	7
 #define SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN	6
@@ -564,6 +569,13 @@ static int sun50i_codec_analog_probe(struct platform_device *pdev)
 			   BIT(SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN),
 			   enable << SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN);
 
+	/* Select sample interval of the ADC sample to 16ms */
+	regmap_update_bits(regmap, SUN50I_ADDA_MDET_CTRL,
+			   0x7 << SUN50I_ADDA_MDET_CTRL_SELDETADC_FS |
+			   0x3 << SUN50I_ADDA_MDET_CTRL_SELDETADC_BF,
+			   0x3 << SUN50I_ADDA_MDET_CTRL_SELDETADC_FS |
+			   0x3 << SUN50I_ADDA_MDET_CTRL_SELDETADC_BF);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 					       &sun50i_codec_analog_cmpnt_drv,
 					       NULL, 0);
diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 2a46b96b03cc..9b78b6226012 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -12,12 +12,16 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/input.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 
+#include <sound/jack.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -118,6 +122,23 @@
 #define SUN8I_ADC_VOL_CTRL				0x104
 #define SUN8I_ADC_VOL_CTRL_ADCL_VOL			8
 #define SUN8I_ADC_VOL_CTRL_ADCR_VOL			0
+#define SUN8I_HMIC_CTRL1				0x110
+#define SUN8I_HMIC_CTRL1_HMIC_M				12
+#define SUN8I_HMIC_CTRL1_HMIC_N				8
+#define SUN8I_HMIC_CTRL1_MDATA_THRESHOLD_DB		5
+#define SUN8I_HMIC_CTRL1_JACK_OUT_IRQ_EN		4
+#define SUN8I_HMIC_CTRL1_JACK_IN_IRQ_EN			3
+#define SUN8I_HMIC_CTRL1_HMIC_DATA_IRQ_EN		0
+#define SUN8I_HMIC_CTRL2				0x114
+#define SUN8I_HMIC_CTRL2_HMIC_SAMPLE			14
+#define SUN8I_HMIC_CTRL2_HMIC_MDATA_THRESHOLD		8
+#define SUN8I_HMIC_CTRL2_HMIC_SF			6
+#define SUN8I_HMIC_STS					0x118
+#define SUN8I_HMIC_STS_MDATA_DISCARD			13
+#define SUN8I_HMIC_STS_HMIC_DATA			8
+#define SUN8I_HMIC_STS_JACK_OUT_IRQ_ST			4
+#define SUN8I_HMIC_STS_JACK_IN_IRQ_ST			3
+#define SUN8I_HMIC_STS_HMIC_DATA_IRQ_ST			0
 #define SUN8I_DAC_DIG_CTRL				0x120
 #define SUN8I_DAC_DIG_CTRL_ENDA				15
 #define SUN8I_DAC_VOL_CTRL				0x124
@@ -143,6 +164,17 @@
 #define SUN8I_AIF_CLK_CTRL_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF_CLK_CTRL_DATA_FMT_MASK	GENMASK(3, 2)
 #define SUN8I_AIF3_CLK_CTRL_AIF3_CLK_SRC_MASK	GENMASK(1, 0)
+#define SUN8I_HMIC_CTRL1_HMIC_M_MASK		GENMASK(15, 12)
+#define SUN8I_HMIC_CTRL1_HMIC_N_MASK		GENMASK(11, 8)
+#define SUN8I_HMIC_CTRL1_MDATA_THRESHOLD_DB_MASK GENMASK(6, 5)
+#define SUN8I_HMIC_CTRL2_HMIC_SAMPLE_MASK	GENMASK(15, 14)
+#define SUN8I_HMIC_CTRL2_HMIC_SF_MASK		GENMASK(7, 6)
+#define SUN8I_HMIC_STS_HMIC_DATA_MASK		GENMASK(12, 8)
+
+#define SUN8I_CODEC_BUTTONS	(SND_JACK_BTN_0|\
+				 SND_JACK_BTN_1|\
+				 SND_JACK_BTN_2|\
+				 SND_JACK_BTN_3)
 
 #define SUN8I_CODEC_PASSTHROUGH_SAMPLE_RATE 48000
 
@@ -178,16 +210,33 @@ struct sun8i_codec_aif {
 
 struct sun8i_codec_quirks {
 	bool	bus_clock	: 1;
+	bool	jack_detection	: 1;
 	bool	legacy_widgets	: 1;
 	bool	lrck_inversion	: 1;
 };
 
+enum {
+	SUN8I_JACK_STATUS_DISCONNECTED,
+	SUN8I_JACK_STATUS_WAITING_HBIAS,
+	SUN8I_JACK_STATUS_CONNECTED,
+};
+
 struct sun8i_codec {
 	struct regmap			*regmap;
+	struct snd_soc_card		*card;
 	struct clk			*clk_bus;
 	struct clk			*clk_module;
 	const struct sun8i_codec_quirks	*quirks;
 	struct sun8i_codec_aif		aifs[SUN8I_CODEC_NAIFS];
+	struct snd_soc_jack		jack;
+	struct delayed_work		jack_work;
+	int				jack_irq;
+	int				jack_status;
+	int				jack_last_sample;
+	ktime_t				jack_hbias_ready;
+	int				jack_type;
+	int				last_hmic_irq;
+	struct mutex			jack_mutex;
 	unsigned int			sysclk_rate;
 	int				sysclk_refcnt;
 };
@@ -1239,12 +1288,79 @@ static const struct snd_soc_dapm_route sun8i_codec_legacy_routes[] = {
 	{ "AIF1 Slot 0 Right", NULL, "DACR" },
 };
 
+static struct snd_soc_jack_pin sun8i_codec_jack_pins[] = {
+	{
+		.pin	= "Headphone Jack",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Microphone",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
+static int sun8i_codec_jack_init(struct sun8i_codec *scodec)
+{
+	int pins = 0;
+	int type = 0;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_codec_jack_pins); ++i) {
+		struct snd_soc_jack_pin *pin = &sun8i_codec_jack_pins[i];
+		struct snd_soc_dapm_widget *w;
+
+		for_each_card_widgets(scodec->card, w) {
+			if (!strcmp(pin->pin, w->name)) {
+				pins |= BIT(i);
+				type |= pin->mask;
+				break;
+			}
+		}
+	}
+
+	if (!type)
+		return 0;
+
+	if (type & SND_JACK_MICROPHONE)
+		type |= SUN8I_CODEC_BUTTONS;
+
+	ret = snd_soc_card_jack_new(scodec->card, "Headset Jack", type,
+				    &scodec->jack);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_codec_jack_pins); ++i) {
+		struct snd_soc_jack_pin *pin = &sun8i_codec_jack_pins[i];
+
+		if (pins & BIT(i)) {
+			ret = snd_soc_jack_add_pins(&scodec->jack, 1, pin);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (type & SND_JACK_MICROPHONE) {
+		struct snd_jack *jack = scodec->jack.jack;
+
+		snd_jack_set_key(jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+		snd_jack_set_key(jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+		snd_jack_set_key(jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
+	}
+
+	scodec->jack_type = type;
+
+	return 0;
+}
+
 static int sun8i_codec_component_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(component);
 	int ret;
 
+	scodec->card = component->card;
+
 	/* Add widgets for backward compatibility with old device trees. */
 	if (scodec->quirks->legacy_widgets) {
 		ret = snd_soc_dapm_new_controls(dapm, sun8i_codec_legacy_widgets,
@@ -1278,9 +1394,53 @@ static int sun8i_codec_component_probe(struct snd_soc_component *component)
 	/* Program the default sample rate. */
 	sun8i_codec_update_sample_rate(scodec);
 
+	if (scodec->quirks->jack_detection) {
+		ret = sun8i_codec_jack_init(scodec);
+		if (ret)
+			return ret;
+	}
+
+	if (scodec->jack_type) {
+		/* Reserved value required for jack IRQs to trigger. */
+		regmap_write(scodec->regmap, SUN8I_HMIC_CTRL1,
+				   0xf << SUN8I_HMIC_CTRL1_HMIC_N |
+				   0x0 << SUN8I_HMIC_CTRL1_MDATA_THRESHOLD_DB |
+				   0x4 << SUN8I_HMIC_CTRL1_HMIC_M);
+
+		/* Sample the ADC at 128 Hz; bypass smooth filter. */
+		regmap_write(scodec->regmap, SUN8I_HMIC_CTRL2,
+				   0x0 << SUN8I_HMIC_CTRL2_HMIC_SAMPLE |
+				   0x17 << SUN8I_HMIC_CTRL2_HMIC_MDATA_THRESHOLD |
+				   0x0 << SUN8I_HMIC_CTRL2_HMIC_SF);
+
+		/* Do not discard any MDATA, enable user written MDATA threshold. */
+		regmap_write(scodec->regmap, SUN8I_HMIC_STS, 0);
+
+		regmap_set_bits(scodec->regmap, SUN8I_HMIC_CTRL1,
+				BIT(SUN8I_HMIC_CTRL1_JACK_OUT_IRQ_EN) |
+				BIT(SUN8I_HMIC_CTRL1_JACK_IN_IRQ_EN));
+
+		enable_irq(scodec->jack_irq);
+	}
+
 	return 0;
 }
 
+static void sun8i_codec_component_remove(struct snd_soc_component *component)
+{
+	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(component);
+
+	if (scodec->jack_type) {
+		disable_irq(scodec->jack_irq);
+		cancel_delayed_work_sync(&scodec->jack_work);
+
+		regmap_clear_bits(scodec->regmap, SUN8I_HMIC_CTRL1,
+				  BIT(SUN8I_HMIC_CTRL1_JACK_OUT_IRQ_EN) |
+				  BIT(SUN8I_HMIC_CTRL1_JACK_IN_IRQ_EN) |
+				  BIT(SUN8I_HMIC_CTRL1_HMIC_DATA_IRQ_EN));
+	}
+}
+
 static const struct snd_soc_component_driver sun8i_soc_component = {
 	.controls		= sun8i_codec_controls,
 	.num_controls		= ARRAY_SIZE(sun8i_codec_controls),
@@ -1289,20 +1449,194 @@ static const struct snd_soc_component_driver sun8i_soc_component = {
 	.dapm_routes		= sun8i_codec_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),
 	.probe			= sun8i_codec_component_probe,
+	.remove			= sun8i_codec_component_remove,
 	.idle_bias_on		= 1,
 	.suspend_bias_off	= 1,
 	.endianness		= 1,
 };
 
+static bool sun8i_codec_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg == SUN8I_HMIC_STS;
+}
+
 static const struct regmap_config sun8i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
+	.volatile_reg	= sun8i_codec_volatile_reg,
 	.max_register	= SUN8I_DAC_MXR_SRC,
 
 	.cache_type	= REGCACHE_FLAT,
 };
 
+static void sun8i_codec_set_hmic_bias(struct sun8i_codec *scodec, bool enable)
+{
+	struct snd_soc_dapm_context *dapm = &scodec->card->dapm;
+	int irq_mask = BIT(SUN8I_HMIC_CTRL1_HMIC_DATA_IRQ_EN);
+
+	if (enable)
+		snd_soc_dapm_force_enable_pin(dapm, "HBIAS");
+	else
+		snd_soc_dapm_disable_pin(dapm, "HBIAS");
+
+	snd_soc_dapm_sync(dapm);
+
+	regmap_update_bits(scodec->regmap, SUN8I_HMIC_CTRL1,
+			   irq_mask, enable ? irq_mask : 0);
+}
+
+static void sun8i_codec_jack_work(struct work_struct *work)
+{
+	struct sun8i_codec *scodec = container_of(work, struct sun8i_codec,
+						  jack_work.work);
+	unsigned int mdata;
+	int type;
+
+	guard(mutex)(&scodec->jack_mutex);
+
+	if (scodec->jack_status == SUN8I_JACK_STATUS_DISCONNECTED) {
+		if (scodec->last_hmic_irq != SUN8I_HMIC_STS_JACK_IN_IRQ_ST)
+			return;
+
+		scodec->jack_last_sample = -1;
+
+		if (scodec->jack_type & SND_JACK_MICROPHONE) {
+			/*
+			 * If we were in disconnected state, we enable HBIAS and
+			 * wait 600ms before reading initial HDATA value.
+			 */
+			scodec->jack_hbias_ready = ktime_add_ms(ktime_get(), 600);
+			sun8i_codec_set_hmic_bias(scodec, true);
+			queue_delayed_work(system_power_efficient_wq,
+					   &scodec->jack_work,
+					   msecs_to_jiffies(610));
+			scodec->jack_status = SUN8I_JACK_STATUS_WAITING_HBIAS;
+		} else {
+			snd_soc_jack_report(&scodec->jack, SND_JACK_HEADPHONE,
+					    scodec->jack_type);
+			scodec->jack_status = SUN8I_JACK_STATUS_CONNECTED;
+		}
+	} else if (scodec->jack_status == SUN8I_JACK_STATUS_WAITING_HBIAS) {
+		/*
+		 * If we're waiting for HBIAS to stabilize, and we get plug-out
+		 * interrupt and nothing more for > 100ms, just cancel the
+		 * initialization.
+		 */
+		if (scodec->last_hmic_irq == SUN8I_HMIC_STS_JACK_OUT_IRQ_ST) {
+			scodec->jack_status = SUN8I_JACK_STATUS_DISCONNECTED;
+			sun8i_codec_set_hmic_bias(scodec, false);
+			return;
+		}
+
+		/*
+		 * If we're not done waiting for HBIAS to stabilize, wait more.
+		 */
+		if (!ktime_after(ktime_get(), scodec->jack_hbias_ready)) {
+			s64 msecs = ktime_ms_delta(scodec->jack_hbias_ready,
+						   ktime_get());
+
+			queue_delayed_work(system_power_efficient_wq,
+					   &scodec->jack_work,
+					   msecs_to_jiffies(msecs + 10));
+			return;
+		}
+
+		/*
+		 * Everything is stabilized, determine jack type and report it.
+		 */
+		regmap_read(scodec->regmap, SUN8I_HMIC_STS, &mdata);
+		mdata &= SUN8I_HMIC_STS_HMIC_DATA_MASK;
+		mdata >>= SUN8I_HMIC_STS_HMIC_DATA;
+
+		regmap_write(scodec->regmap, SUN8I_HMIC_STS, 0);
+
+		type = mdata < 16 ? SND_JACK_HEADPHONE : SND_JACK_HEADSET;
+		if (type == SND_JACK_HEADPHONE)
+			sun8i_codec_set_hmic_bias(scodec, false);
+
+		snd_soc_jack_report(&scodec->jack, type, scodec->jack_type);
+		scodec->jack_status = SUN8I_JACK_STATUS_CONNECTED;
+	} else if (scodec->jack_status == SUN8I_JACK_STATUS_CONNECTED) {
+		if (scodec->last_hmic_irq != SUN8I_HMIC_STS_JACK_OUT_IRQ_ST)
+			return;
+
+		scodec->jack_status = SUN8I_JACK_STATUS_DISCONNECTED;
+		if (scodec->jack_type & SND_JACK_MICROPHONE)
+			sun8i_codec_set_hmic_bias(scodec, false);
+
+		snd_soc_jack_report(&scodec->jack, 0, scodec->jack_type);
+	}
+}
+
+static irqreturn_t sun8i_codec_jack_irq(int irq, void *dev_id)
+{
+	struct sun8i_codec *scodec = dev_id;
+	int type = SND_JACK_HEADSET;
+	unsigned int status, value;
+
+	guard(mutex)(&scodec->jack_mutex);
+
+	regmap_read(scodec->regmap, SUN8I_HMIC_STS, &status);
+	regmap_write(scodec->regmap, SUN8I_HMIC_STS, status);
+
+	/*
+	 * De-bounce in/out interrupts via a delayed work re-scheduling to
+	 * 100ms after each interrupt..
+	 */
+	if (status & BIT(SUN8I_HMIC_STS_JACK_OUT_IRQ_ST)) {
+		/*
+		 * Out interrupt has priority over in interrupt so that if
+		 * we get both, we assume the disconnected state, which is
+		 * safer.
+		 */
+		scodec->last_hmic_irq = SUN8I_HMIC_STS_JACK_OUT_IRQ_ST;
+		mod_delayed_work(system_power_efficient_wq, &scodec->jack_work,
+				 msecs_to_jiffies(100));
+	} else if (status & BIT(SUN8I_HMIC_STS_JACK_IN_IRQ_ST)) {
+		scodec->last_hmic_irq = SUN8I_HMIC_STS_JACK_IN_IRQ_ST;
+		mod_delayed_work(system_power_efficient_wq, &scodec->jack_work,
+				 msecs_to_jiffies(100));
+	} else if (status & BIT(SUN8I_HMIC_STS_HMIC_DATA_IRQ_ST)) {
+		/*
+		 * Ignore data interrupts until jack status turns to connected
+		 * state, which is after HMIC enable stabilization is completed.
+		 * Until then tha data are bogus.
+		 */
+		if (scodec->jack_status != SUN8I_JACK_STATUS_CONNECTED)
+			return IRQ_HANDLED;
+
+		value = (status & SUN8I_HMIC_STS_HMIC_DATA_MASK) >>
+			SUN8I_HMIC_STS_HMIC_DATA;
+
+		/*
+		 * Assumes 60 mV per ADC LSB increment, 2V bias voltage, 2.2kOhm
+		 * bias resistor.
+		 */
+		if (value == 0)
+			type |= SND_JACK_BTN_0;
+		else if (value == 1)
+			type |= SND_JACK_BTN_3;
+		else if (value <= 3)
+			type |= SND_JACK_BTN_1;
+		else if (value <= 8)
+			type |= SND_JACK_BTN_2;
+
+		/*
+		 * De-bounce. Only report button after two consecutive A/D
+		 * samples are identical.
+		 */
+		if (scodec->jack_last_sample >= 0 &&
+		    scodec->jack_last_sample == value)
+			snd_soc_jack_report(&scodec->jack, type,
+					    scodec->jack_type);
+
+		scodec->jack_last_sample = value;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int sun8i_codec_probe(struct platform_device *pdev)
 {
 	struct sun8i_codec *scodec;
@@ -1344,6 +1678,22 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->regmap);
 	}
 
+	if (scodec->quirks->jack_detection) {
+		scodec->jack_irq = platform_get_irq(pdev, 0);
+		if (scodec->jack_irq < 0)
+			return scodec->jack_irq;
+
+		ret = devm_request_threaded_irq(&pdev->dev, scodec->jack_irq,
+						NULL, sun8i_codec_jack_irq,
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						dev_name(&pdev->dev), scodec);
+		if (ret)
+			return ret;
+
+		INIT_DELAYED_WORK(&scodec->jack_work, sun8i_codec_jack_work);
+		mutex_init(&scodec->jack_mutex);
+	}
+
 	regcache_cache_only(scodec->regmap, true);
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
@@ -1387,6 +1737,7 @@ static const struct sun8i_codec_quirks sun8i_a33_quirks = {
 
 static const struct sun8i_codec_quirks sun50i_a64_quirks = {
 	.bus_clock	= true,
+	.jack_detection	= true,
 };
 
 static const struct of_device_id sun8i_codec_of_match[] = {
-- 
2.43.0


