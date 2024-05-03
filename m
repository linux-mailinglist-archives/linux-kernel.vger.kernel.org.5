Return-Path: <linux-kernel+bounces-168090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F398BB38A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6EB22095
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920C4158D7A;
	Fri,  3 May 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD3GHqCP"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0661586F5;
	Fri,  3 May 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762528; cv=none; b=E1x1EcNGlLB55fs9JyQdX5+iswlrgOgTevDDe/pKNu/AwiwOvrmx2K0+w5ceHwd89OIQq6ZLbjImh5BwaG9v/mLmAAc/aMtB1Z5CaFCXXDnXqPZysb2wnl56iC5+gbg1dwI2/PZ07LHJaOzSqWbAz/npPhXNCoYe6peKrXKIRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762528; c=relaxed/simple;
	bh=/bENfoqr33Deh+36b873gv6Z24nDakoAKeNHo3TJKok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vah0pg/5zivJNvy5llUgikcVXVtBTH6PusncLjChThGNf2j0Rapm68esygQBteTMloyjmIpbQ4mw0yJJRy7wsOMK4M690StZXc9tDttiX3u6j+L0NICOCatE1ucN/7nRQyhYxt0/VoMNUXBXopOgm8ysweo0QCojV7uOFT3XOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD3GHqCP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso3034299e87.1;
        Fri, 03 May 2024 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714762524; x=1715367324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaLJt3CrEL7LI/neNr6VMqZn//h/KqT1cG+3ONCcvbk=;
        b=KD3GHqCPkKKX7+PkmbStuuCNRxverP38omRIp3pI69750q2CIC33DyGYfkEWUTBsZf
         Wdl4HxMf9jy3kuH+h1gXV6i4g661ViIgrrLykKZTLsOVewRrT4MP2J5qCHL50HD0fIDr
         FNjlPAkAlih1if+dVHxmDORYxKAQo00JGz/AP0IQ+tqteVwXNJRm+vzrTOk3Uxk/KISM
         kc+9vNWKkiejdXsjPvO00o571//5EBjjLYe5pFxOrm6xgH8c86ircxkOw0KfchmkJAmn
         8o0f+nSQByJzzphZ1LFBElAgK02POZsqBMcM4hVCsI0qXtY6oGgMqxl7zNAMOzO9Pklv
         zBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714762524; x=1715367324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaLJt3CrEL7LI/neNr6VMqZn//h/KqT1cG+3ONCcvbk=;
        b=jSmhoP8OhJrHo6myxvlocQsXL+R59MMKMVGVW0FTaHe3P7UGOkwLVYQJZJ6r+OLjp+
         vbUTfKDMm7Uq5Hme1uhSC8cznmvdzt9vF+Fa4aEHxmbGJgMz147LTK9Y1oN5ItrVmjRv
         l7394PeAfsLs6lBZsWByvL7SiAqhjoInebDlOLsQb8MkmthTalXlv4pEsy/DtFehWrqO
         LVmVa21x9NLvUTWsYGFtu8tJXsfCXY+pvMnOLekFYrEN2PxGGnmzTR4DM8XmNWrUI+Pq
         pI7unbkI/lMlktsfaeUE/cL9u3qIc/B3oL/FdLl7LoQp7kgUKH3Bk6wH9t8dWdmG4+RB
         M4eA==
X-Forwarded-Encrypted: i=1; AJvYcCVr8zAQC0fN7t27L+LVy7Qf+u4K7feQdTiwH2YaB+yf/ptqSPT9RZLpTx8wmrCqby5UY4SN9cNT2QZXmTF7gQrJWJmvEB8YhYXHbqQed+iHi8DV4Tsyg+jZ3RZ05X0xeBdDzKzB/FQhyrEZSOhce/8rCsXEopUC8k2D5GqDNKzbtl9OGoV5r26+RLZeoZDyqM76R0ewMVfn0ZLspoQxCRUS6BRmH1YHZkg=
X-Gm-Message-State: AOJu0YzMWVRdihKiGs7yaLDdJDMMN0fJigZLKcWgWUF4T5zuMUVMS0s8
	bdjD52KUd80T7k2J1IM++kVf2o7EmCoW/sY4TEI6jp8oB58Yn8PQ
X-Google-Smtp-Source: AGHT+IFiuOPhU9b+r8pW/xcxVPJuQACI/MSqzs6EaP7yMC8jhNXlFywNjSHA0WrTIrj2YXK11IW4Lg==
X-Received: by 2002:ac2:4945:0:b0:51b:6ed6:af3f with SMTP id o5-20020ac24945000000b0051b6ed6af3fmr2238853lfi.16.1714762523689;
        Fri, 03 May 2024 11:55:23 -0700 (PDT)
Received: from hex.my.domain (83.25.185.84.ipv4.supernova.orange.pl. [83.25.185.84])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906078800b00a598d3ddf8dsm1104618ejc.28.2024.05.03.11.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:55:23 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 03 May 2024 20:55:12 +0200
Subject: [PATCH 2/3] ASoC: samsung: midas_wm1811: Add GPIO-based headset
 jack detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-midas-wm1811-gpio-jack-v1-2-e8cddbd67cbf@gmail.com>
References: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
In-Reply-To: <20240503-midas-wm1811-gpio-jack-v1-0-e8cddbd67cbf@gmail.com>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714762519; l=11162;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=/bENfoqr33Deh+36b873gv6Z24nDakoAKeNHo3TJKok=;
 b=USavtv/kIxxsiKYsTqgVjRjDeGfhckh1wgRCP0r2FNybgFhfNN8FGJuvou7Qm8ApR9HNuTTug
 uoSZsAhZnZzASvIYYa7VMrlpuH3OwOhNhXhGxmdCY4aSNryTU21Nejh
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Some Samsung devices that use the midas_wm1811 driver use a GPIO-based
method for detecting whether the headset jack is plugged in, as well as
detecting which headset buttons are pressed. There are two GPIOs:
a "headset detect" GPIO responsible for detecting jack insertion, and
a "headset key" GPIO which triggers when a button on the headset is
pressed. The plug type and the button pressed are determined based
on information from an ADC channel.

Add support for the GPIO-based headset jack detection mechanism,
and make it configurable from the device tree.

This implementation borrows somewhat from the aries_wm8994.c driver,
though there are a few changes to make the code cleaner, and to add
support for DT-based configuration.

Notably, a dependency on IIO is introduced, to accommodate the ADC
reading requirement.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 sound/soc/samsung/Kconfig        |   2 +-
 sound/soc/samsung/midas_wm1811.c | 265 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 256 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 93c2b1b08d0a..4b1ea7b2c796 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -140,7 +140,7 @@ config SND_SOC_SAMSUNG_ARIES_WM8994
 
 config SND_SOC_SAMSUNG_MIDAS_WM1811
 	tristate "SoC I2S Audio support for Midas boards"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && IIO
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8994
 	help
diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index f31244156ff6..bbffb9301cbf 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -7,7 +7,9 @@
 
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iio/consumer.h>
 #include <linux/mfd/wm8994/registers.h>
+#include <linux/input-event-codes.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
@@ -31,6 +33,9 @@ struct midas_priv {
 	struct regulator *reg_submic_bias;
 	struct gpio_desc *gpio_fm_sel;
 	struct gpio_desc *gpio_lineout_sel;
+	struct gpio_desc *gpio_headset_detect;
+	struct gpio_desc *gpio_headset_key;
+	struct iio_channel *adc_headset_detect;
 	unsigned int fll1_rate;
 
 	struct snd_soc_jack headset_jack;
@@ -47,6 +52,109 @@ static struct snd_soc_jack_pin headset_jack_pins[] = {
 	},
 };
 
+/*
+ * min_mv/max_mv values in this struct are set up based on DT values.
+ */
+static struct snd_soc_jack_zone headset_jack_zones[] = {
+	{ .jack_type = SND_JACK_HEADPHONE, },
+	{ .jack_type = SND_JACK_HEADSET, },
+	{ .jack_type = SND_JACK_HEADPHONE, },
+};
+
+/*
+ * This is used for manual detection in headset_key_check, we reuse the
+ * structure since it's convenient.
+ *
+ * min_mv/max_mv values in this struct are set up based on DT values.
+ */
+static struct snd_soc_jack_zone headset_key_zones[] = {
+	{ .jack_type = SND_JACK_BTN_0, },  /* Media */
+	{ .jack_type = SND_JACK_BTN_1, },  /* Volume Up */
+	{ .jack_type = SND_JACK_BTN_2, },  /* Volume Down */
+};
+
+static int headset_jack_check(void *data)
+{
+	struct midas_priv *priv = (struct midas_priv *) data;
+	int adc, jack_type, ret;
+
+	if (!gpiod_get_value_cansleep(priv->gpio_headset_detect))
+		return 0;
+
+	/* Temporarily enable micbias for ADC measurement */
+	ret = regulator_enable(priv->reg_mic_bias);
+	if (ret)
+		pr_err("%s: Failed to enable micbias: %d\n", __func__, ret);
+
+	/* Sleep for a small amount of time to get the value to stabilize */
+	msleep(20);
+
+	ret = iio_read_channel_processed(priv->adc_headset_detect, &adc);
+	if (ret) {
+		pr_err("%s: Failed to read ADC (%d), assuming headphones\n",
+		       __func__, ret);
+		return SND_JACK_HEADPHONE;
+	}
+	pr_debug("%s: ADC value is %d\n", __func__, adc);
+
+	jack_type = snd_soc_jack_get_type(&priv->headset_jack, adc);
+
+	/* Disable micbias if the jack is not a headset */
+	if ((jack_type & SND_JACK_HEADSET) != SND_JACK_HEADSET) {
+		ret = regulator_disable(priv->reg_mic_bias);
+		if (ret)
+			pr_err("%s: Failed to disable micbias: %d\n",
+			       __func__, ret);
+	}
+
+	return jack_type;
+}
+
+static int headset_key_check(void *data)
+{
+	struct midas_priv *priv = (struct midas_priv *) data;
+	int adc, i, ret;
+
+	if (!gpiod_get_value_cansleep(priv->gpio_headset_key))
+		return 0;
+
+	/* Filter out keypresses when 4 pole jack not detected */
+	if (!(priv->headset_jack.status & SND_JACK_MICROPHONE))
+		return 0;
+
+	ret = iio_read_channel_processed(priv->adc_headset_detect, &adc);
+	if (ret) {
+		pr_err("%s: Failed to read ADC (%d), can't detect key type\n",
+		       __func__, ret);
+		return 0;
+	}
+	pr_debug("%s: ADC value is %d\n", __func__, adc);
+
+	for (i = 0; i < ARRAY_SIZE(headset_key_zones); i++) {
+		if (adc >= headset_key_zones[i].min_mv &&
+		    adc <= headset_key_zones[i].max_mv) {
+			return headset_key_zones[i].jack_type;
+		}
+	}
+
+	return 0;
+}
+
+static struct snd_soc_jack_gpio headset_gpio[] = {
+	{
+		.name = "Headset Jack",
+		.report = SND_JACK_HEADSET,
+		.debounce_time = 150,
+		.jack_status_check = headset_jack_check,
+	},
+	{
+		.name = "Headset Key",
+		.report = SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2,
+		.debounce_time = 30,
+		.jack_status_check = headset_key_check,
+	},
+};
+
 static int midas_start_fll1(struct snd_soc_pcm_runtime *rtd, unsigned int rate)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -315,18 +423,67 @@ static int midas_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new_pins(card, "Headset",
-					 SND_JACK_HEADSET | SND_JACK_MECHANICAL |
-					 SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
-					 SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5,
-					 &priv->headset_jack,
-					 headset_jack_pins,
-					 ARRAY_SIZE(headset_jack_pins));
-	if (ret)
+	if (!priv->gpio_headset_detect) {
+		ret = snd_soc_card_jack_new_pins(card, "Headset",
+				 SND_JACK_HEADSET | SND_JACK_MECHANICAL |
+				 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				 SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+				 SND_JACK_BTN_4 | SND_JACK_BTN_5,
+				 &priv->headset_jack,
+				 headset_jack_pins,
+				 ARRAY_SIZE(headset_jack_pins));
+		if (ret)
+			return ret;
+
+		wm8958_mic_detect(aif1_dai->component, &priv->headset_jack,
+				  NULL, NULL, NULL, NULL);
+	} else {
+		/* Some devices (n8000, t310) use a GPIO to detect the jack. */
+		ret = snd_soc_card_jack_new_pins(card, "Headset",
+				SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				SND_JACK_BTN_1 | SND_JACK_BTN_2,
+				&priv->headset_jack,
+				headset_jack_pins,
+				ARRAY_SIZE(headset_jack_pins));
+		if (ret) {
+			dev_err(card->dev,
+				"Failed to set up headset pins: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_jack_add_zones(&priv->headset_jack,
+				ARRAY_SIZE(headset_jack_zones),
+				headset_jack_zones);
+		if (ret) {
+			dev_err(card->dev,
+				"Failed to set up headset zones: %d\n", ret);
+			return ret;
+		}
+
+		headset_gpio[0].data = priv;
+		headset_gpio[0].desc = priv->gpio_headset_detect;
+
+		headset_gpio[1].data = priv;
+		headset_gpio[1].desc = priv->gpio_headset_key;
+
+		snd_jack_set_key(priv->headset_jack.jack,
+				 SND_JACK_BTN_0, KEY_MEDIA);
+		snd_jack_set_key(priv->headset_jack.jack,
+				 SND_JACK_BTN_1, KEY_VOLUMEUP);
+		snd_jack_set_key(priv->headset_jack.jack,
+				 SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+
+		ret = snd_soc_jack_add_gpios(&priv->headset_jack,
+				ARRAY_SIZE(headset_gpio),
+				headset_gpio);
+		if (ret)
+			dev_err(card->dev,
+				"Failed to set up headset jack GPIOs: %d\n",
+				ret);
+
 		return ret;
+	}
 
-	wm8958_mic_detect(aif1_dai->component, &priv->headset_jack,
-			  NULL, NULL, NULL, NULL);
 	return 0;
 }
 
@@ -433,6 +590,9 @@ static int midas_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &midas_card;
 	struct device *dev = &pdev->dev;
 	static struct snd_soc_dai_link *dai_link;
+	enum iio_chan_type channel_type;
+	u32 fourpole_threshold[2];
+	u32 button_threshold[3];
 	struct midas_priv *priv;
 	int ret, i;
 
@@ -468,6 +628,91 @@ static int midas_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->gpio_lineout_sel);
 	}
 
+	priv->gpio_headset_detect = devm_gpiod_get_optional(dev,
+				"headset-detect", GPIOD_IN);
+	if (IS_ERR(priv->gpio_headset_detect)) {
+		dev_err(dev, "Failed to get headset jack detect GPIO\n");
+		return PTR_ERR(priv->gpio_headset_detect);
+	}
+
+	if (priv->gpio_headset_detect) {
+		priv->adc_headset_detect = devm_iio_channel_get(dev,
+							"headset-detect");
+		if (IS_ERR(priv->adc_headset_detect)) {
+			dev_err(dev, "Failed to get ADC channel\n");
+			return PTR_ERR(priv->adc_headset_detect);
+		}
+
+		ret = iio_get_channel_type(priv->adc_headset_detect,
+					   &channel_type);
+		if (ret) {
+			dev_err(dev, "Failed to get ADC channel type\n");
+			return ret;
+		}
+
+		if (channel_type != IIO_VOLTAGE) {
+			dev_err(dev, "ADC channel is not voltage\n");
+			return ret;
+		}
+
+		priv->gpio_headset_key = devm_gpiod_get(dev, "headset-key",
+							GPIOD_IN);
+		if (IS_ERR(priv->gpio_headset_key)) {
+			dev_err(dev, "Failed to get headset key gpio\n");
+			return PTR_ERR(priv->gpio_headset_key);
+		}
+
+		ret = of_property_read_u32_array(dev->of_node,
+				"headset-4pole-threshold-microvolt",
+				fourpole_threshold,
+				ARRAY_SIZE(fourpole_threshold));
+		if (ret) {
+			dev_err(dev, "Failed to get 4-pole jack detection threshold\n");
+			return ret;
+		}
+
+		if (fourpole_threshold[0] > fourpole_threshold[1]) {
+			dev_err(dev, "Invalid 4-pole jack detection threshold value\n");
+			return -EINVAL;
+		}
+
+		headset_jack_zones[0].max_mv = (fourpole_threshold[0]);
+		headset_jack_zones[1].min_mv = (fourpole_threshold[0] + 1);
+
+		headset_jack_zones[1].max_mv = (fourpole_threshold[1]);
+		headset_jack_zones[2].min_mv = (fourpole_threshold[1] + 1);
+
+		ret = of_property_read_u32_array(dev->of_node,
+				"headset-button-threshold-microvolt",
+				button_threshold,
+				ARRAY_SIZE(button_threshold));
+		if (ret) {
+			dev_err(dev, "Failed to get headset button detection threshold\n");
+			return ret;
+		}
+
+		if (button_threshold[0] > button_threshold[1] ||
+		    button_threshold[1] > button_threshold[2]) {
+			dev_err(dev, "Invalid headset button detection threshold value\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < 3; i++) {
+			if (i != 0 && button_threshold[i] <= 0) {
+				dev_err(dev, "Invalid headset button detection threshold value\n");
+				return -EINVAL;
+			}
+
+			headset_key_zones[i].min_mv = button_threshold[i];
+
+			if (i == 2)
+				headset_key_zones[i].max_mv = UINT_MAX;
+			else
+				headset_key_zones[i].max_mv = \
+						(button_threshold[i+1] - 1);
+		}
+	}
+
 	ret = snd_soc_of_parse_card_name(card, "model");
 	if (ret < 0) {
 		dev_err(dev, "Card name is not specified\n");

-- 
2.45.0


