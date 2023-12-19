Return-Path: <linux-kernel+bounces-5438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF3818AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFC5286112
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0739AE6;
	Tue, 19 Dec 2023 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m7cJEeX+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D6374D6;
	Tue, 19 Dec 2023 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D25874000B;
	Tue, 19 Dec 2023 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702997691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ+dkv5LcytXvwpmZW6LbUfALzEzM25xdfM5Hy5tV54=;
	b=m7cJEeX+T2J2vKNK4zS2d0yTG+ZLFdA4nXo7bHfhOpcD8+EwV053CHiKWQlj+8WnRul8dP
	MYN6/72bj+RdhL1h70IMLCF5W19DugIl/4mF8zqJ+9s953YABXXafx+cSZq2Wbl9t+V0kp
	KimqA4poZKHTPC+Jw5nBwk7wTNu06Cpya71NYAVnQTGXlNLkkqriFDJPzvta1xBa67FPc5
	cuhixjsArXT4QNhfzlM/wLoxBLehviVjcnKnrQHf6SrTwhbGpUOVK1tQs2l9yjCKek+tOd
	qUko/+SAcINeAxTDShTGwZFoV3tVG73DA29c91+VE9y94NtoxQd6IjO9TIu3Ag==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 Dec 2023 15:54:19 +0100
Subject: [PATCH v2 4/6] ASoC: codecs: Add RK3308 internal audio codec
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-rk3308-audio-codec-v2-4-c70d06021946@bootlin.com>
References: <20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com>
In-Reply-To: <20231219-rk3308-audio-codec-v2-0-c70d06021946@bootlin.com>
To: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com

Add driver for the internal audio codec of the Rockchip RK3308 SoC.

Initially based on the vendor kernel driver [0], with lots of cleanups,
fixes, improvements, conversion to DAPM and removal of some features.

[0] https://github.com/rockchip-linux/kernel/blob/develop-4.19/sound/soc/codecs/rk3308_codec.c

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v2:
 - convert everything to DAPM support
 - move rk3308_codec_power_on/off() code to .set_bias_level
 - move MICBIAS setting from hw_params to probe
 - support silicon version C which differs in some registers
 - removed LINE IN code as LINE IN is not supported by the hardware
 - remove unneeded digital reset in in rk3308_codec_hw_params
 - rewrite on/off controls to be bool switches, not enums
 - fix _put() operations return value (1 if value changed)
 - fix RK3308_ADC_CURRENT_CHARGE_MSK power-down ramp (it was ramping up
   just like the power-up ramp)
 - enable zero-cross detection unconditionally
 - Remove AGC/ALC implementation
 - Add HPF controls (enable and cut-off frequency)
 - model HP output as a stereo control (requires new ASoC helper macro)
 - use ADC_CH*_MIC_MUTE for muting mics, not the BIST bits
 - fix uninitialized variable is_master
 - remove useless wrappers
 - remove .mute_stream callback
 - remove digital fade in/out for HPOUT volume
 - remove many unneeded register initializations to their reset values and
   documented the few places where open-coded initializations to values
   different from the reset value are needed
 - collapse various functions into rk3308_codec_adc_dig_config(), which
   simplified dramatically the hw_params code
 - various coding style and comments improvements, code reorganization
 - add error checking in several places
---
 MAINTAINERS                     |    2 +
 sound/soc/codecs/Kconfig        |   11 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/rk3308_codec.c | 1012 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rk3308_codec.h |  593 +++++++++++++++++++++++
 5 files changed, 1620 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index feddd6610b51..d250e0e10a24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18673,6 +18673,8 @@ ROCKCHIP RK3308 INTERNAL AUDIO CODEC
 M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
+F:	sound/soc/codecs/rk3308_codec.c
+F:	sound/soc/codecs/rk3308_codec.h
 
 ROCKCHIP VIDEO DECODER DRIVER
 M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3429419ca694..dea9ed9e4dff 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -179,6 +179,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_PCM512x_I2C
 	imply SND_SOC_PCM512x_SPI
 	imply SND_SOC_PEB2466
+	imply SND_SOC_RK3308
 	imply SND_SOC_RK3328
 	imply SND_SOC_RK817
 	imply SND_SOC_RT274
@@ -1396,6 +1397,16 @@ config SND_SOC_PEB2466
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-soc-peb2466.
 
+config SND_SOC_RK3308
+	tristate "Rockchip RK3308 audio CODEC"
+	select REGMAP_MMIO
+	help
+	  This is a device driver for the audio codec embedded in the
+	  Rockchip RK3308 SoC.
+
+	  It has 8 24-bit ADCs and 2 24-bit DACs. The maximum supported
+	  sampling rate is 192 kHz.
+
 config SND_SOC_RK3328
 	tristate "Rockchip RK3328 audio CODEC"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2078bb0d981e..e33042350bfd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -201,6 +201,7 @@ snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
 snd-soc-peb2466-objs := peb2466.o
+snd-soc-rk3308-objs := rk3308_codec.o
 snd-soc-rk3328-objs := rk3328_codec.o
 snd-soc-rk817-objs := rk817_codec.o
 snd-soc-rl6231-objs := rl6231.o
@@ -585,6 +586,7 @@ obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
 obj-$(CONFIG_SND_SOC_PEB2466)	+= snd-soc-peb2466.o
+obj-$(CONFIG_SND_SOC_RK3308)	+= snd-soc-rk3308.o
 obj-$(CONFIG_SND_SOC_RK3328)	+= snd-soc-rk3328.o
 obj-$(CONFIG_SND_SOC_RK817)	+= snd-soc-rk817.o
 obj-$(CONFIG_SND_SOC_RL6231)	+= snd-soc-rl6231.o
diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
new file mode 100644
index 000000000000..cdf1aae665da
--- /dev/null
+++ b/sound/soc/codecs/rk3308_codec.c
@@ -0,0 +1,1012 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Rockchip RK3308 internal audio codec driver
+ *
+ * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd All rights reserved.
+ * Copyright (c) 2023, Vivax-Metrotech Ltd
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/util_macros.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "rk3308_codec.h"
+
+#define ADC_LR_GROUP_MAX		4
+
+#define GRF_CHIP_ID			0x800
+
+enum {
+	ACODEC_VERSION_A = 'A',
+	ACODEC_VERSION_B,
+	ACODEC_VERSION_C,
+};
+
+enum {
+	DAC_LINEOUT = 0,
+	DAC_HPOUT = 1,
+	DAC_LINEOUT_HPOUT = 11,
+};
+
+struct rk3308_codec_priv {
+	const struct device *dev;
+	struct regmap *regmap;
+	struct regmap *grf;
+	struct reset_control *reset;
+	struct clk *hclk;
+	struct clk *mclk_rx;
+	struct clk *mclk_tx;
+	struct snd_soc_component *component;
+	u32 codec_ver;
+};
+
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_adc_alc_gain_tlv,   -1800, 150, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_dac_hpout_gain_tlv, -3900, 150, 0);
+static const DECLARE_TLV_DB_SCALE(rk3308_codec_dac_hpmix_gain_tlv,  -600, 600, 0);
+
+static const DECLARE_TLV_DB_RANGE(rk3308_codec_dac_lineout_gain_tlv,
+	0, 0, TLV_DB_SCALE_ITEM(-600, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(-300, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(-150, 0, 0),
+	3, 3, TLV_DB_SCALE_ITEM(0,    0, 0),
+);
+
+static const char * const rk3308_codec_hpf_cutoff_text[] = {
+	"20 Hz", "245 Hz", "612 Hz"
+};
+
+static SOC_ENUM_SINGLE_DECL(rk3308_codec_hpf_cutoff_enum12, RK3308_ADC_DIG_CON04(0), 0,
+			    rk3308_codec_hpf_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(rk3308_codec_hpf_cutoff_enum34, RK3308_ADC_DIG_CON04(1), 0,
+			    rk3308_codec_hpf_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(rk3308_codec_hpf_cutoff_enum56, RK3308_ADC_DIG_CON04(2), 0,
+			    rk3308_codec_hpf_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(rk3308_codec_hpf_cutoff_enum78, RK3308_ADC_DIG_CON04(3), 0,
+			    rk3308_codec_hpf_cutoff_text);
+
+static const struct snd_kcontrol_new rk3308_codec_controls[] = {
+	/* Despite the register names, these set the gain when AGC is OFF */
+	SOC_SINGLE_RANGE_TLV("MIC1 Capture Volume",
+			     RK3308_ADC_ANA_CON03(0),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC2 Capture Volume",
+			     RK3308_ADC_ANA_CON04(0),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC3 Capture Volume",
+			     RK3308_ADC_ANA_CON03(1),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC4 Capture Volume",
+			     RK3308_ADC_ANA_CON04(1),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC5 Capture Volume",
+			     RK3308_ADC_ANA_CON03(2),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC6 Capture Volume",
+			     RK3308_ADC_ANA_CON04(2),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC7 Capture Volume",
+			     RK3308_ADC_ANA_CON03(3),
+			     RK3308_ADC_CH1_ALC_GAIN_SFT,
+			     RK3308_ADC_CH1_ALC_GAIN_MIN,
+			     RK3308_ADC_CH1_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+	SOC_SINGLE_RANGE_TLV("MIC8 Capture Volume",
+			     RK3308_ADC_ANA_CON04(3),
+			     RK3308_ADC_CH2_ALC_GAIN_SFT,
+			     RK3308_ADC_CH2_ALC_GAIN_MIN,
+			     RK3308_ADC_CH2_ALC_GAIN_MAX,
+			     0, rk3308_codec_adc_alc_gain_tlv),
+
+	SOC_SINGLE("MIC1 Capture Switch", RK3308_ADC_ANA_CON00(0), 3, 1, 0),
+	SOC_SINGLE("MIC2 Capture Switch", RK3308_ADC_ANA_CON00(0), 7, 1, 0),
+	SOC_SINGLE("MIC3 Capture Switch", RK3308_ADC_ANA_CON00(1), 3, 1, 0),
+	SOC_SINGLE("MIC4 Capture Switch", RK3308_ADC_ANA_CON00(1), 7, 1, 0),
+	SOC_SINGLE("MIC5 Capture Switch", RK3308_ADC_ANA_CON00(2), 3, 1, 0),
+	SOC_SINGLE("MIC6 Capture Switch", RK3308_ADC_ANA_CON00(2), 7, 1, 0),
+	SOC_SINGLE("MIC7 Capture Switch", RK3308_ADC_ANA_CON00(3), 3, 1, 0),
+	SOC_SINGLE("MIC8 Capture Switch", RK3308_ADC_ANA_CON00(3), 7, 1, 0),
+
+	SOC_SINGLE("MIC12 HPF Capture Switch", RK3308_ADC_DIG_CON04(0), 2, 1, 1),
+	SOC_SINGLE("MIC34 HPF Capture Switch", RK3308_ADC_DIG_CON04(1), 2, 1, 1),
+	SOC_SINGLE("MIC56 HPF Capture Switch", RK3308_ADC_DIG_CON04(2), 2, 1, 1),
+	SOC_SINGLE("MIC78 HPF Capture Switch", RK3308_ADC_DIG_CON04(3), 2, 1, 1),
+
+	SOC_ENUM("MIC12 HPF Cutoff", rk3308_codec_hpf_cutoff_enum12),
+	SOC_ENUM("MIC34 HPF Cutoff", rk3308_codec_hpf_cutoff_enum34),
+	SOC_ENUM("MIC56 HPF Cutoff", rk3308_codec_hpf_cutoff_enum56),
+	SOC_ENUM("MIC78 HPF Cutoff", rk3308_codec_hpf_cutoff_enum78),
+
+	SOC_DOUBLE_TLV("Line Out Playback Volume",
+		       RK3308_DAC_ANA_CON04,
+		       RK3308_DAC_L_LINEOUT_GAIN_SFT,
+		       RK3308_DAC_R_LINEOUT_GAIN_SFT,
+		       RK3308_DAC_x_LINEOUT_GAIN_MAX,
+		       0, rk3308_codec_dac_lineout_gain_tlv),
+	SOC_DOUBLE("Line Out Playback Switch",
+		   RK3308_DAC_ANA_CON04,
+		   RK3308_DAC_L_LINEOUT_MUTE_SFT,
+		   RK3308_DAC_R_LINEOUT_MUTE_SFT, 1, 0),
+	SOC_DOUBLE_R_TLV("Headphone Playback Volume",
+			 RK3308_DAC_ANA_CON05,
+			 RK3308_DAC_ANA_CON06,
+			 RK3308_DAC_x_HPOUT_GAIN_SFT,
+			 RK3308_DAC_x_HPOUT_GAIN_MAX,
+			 0, rk3308_codec_dac_hpout_gain_tlv),
+	SOC_DOUBLE("Headphone Playback Switch",
+		   RK3308_DAC_ANA_CON03,
+		   RK3308_DAC_L_HPOUT_MUTE_SFT,
+		   RK3308_DAC_R_HPOUT_MUTE_SFT, 1, 0),
+	SOC_DOUBLE_RANGE_TLV("DAC HPMIX Playback Volume",
+			     RK3308_DAC_ANA_CON12,
+			     RK3308_DAC_L_HPMIX_GAIN_SFT,
+			     RK3308_DAC_R_HPMIX_GAIN_SFT,
+			     1, 2, 0, rk3308_codec_dac_hpmix_gain_tlv),
+};
+
+static int rk3308_codec_pop_sound_set(struct snd_soc_dapm_widget *w,
+				      struct snd_kcontrol *kcontrol,
+				      int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	unsigned int val = (event == SND_SOC_DAPM_POST_PMU) ?
+		RK3308_DAC_HPOUT_POP_SOUND_x_WORK :
+		RK3308_DAC_HPOUT_POP_SOUND_x_INIT;
+	unsigned int mask = RK3308_DAC_HPOUT_POP_SOUND_x_MSK;
+
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
+			   mask << w->shift, val << w->shift);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget rk3308_codec_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_INPUT("MIC3"),
+	SND_SOC_DAPM_INPUT("MIC4"),
+	SND_SOC_DAPM_INPUT("MIC5"),
+	SND_SOC_DAPM_INPUT("MIC6"),
+	SND_SOC_DAPM_INPUT("MIC7"),
+	SND_SOC_DAPM_INPUT("MIC8"),
+
+	SND_SOC_DAPM_SUPPLY("ADC_CURRENT_EN12", RK3308_ADC_ANA_CON06(0), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_CURRENT_EN34", RK3308_ADC_ANA_CON06(1), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_CURRENT_EN56", RK3308_ADC_ANA_CON06(2), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC_CURRENT_EN78", RK3308_ADC_ANA_CON06(3), 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC1_EN", RK3308_ADC_ANA_CON00(0), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC2_EN", RK3308_ADC_ANA_CON00(0), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC3_EN", RK3308_ADC_ANA_CON00(1), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC4_EN", RK3308_ADC_ANA_CON00(1), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC5_EN", RK3308_ADC_ANA_CON00(2), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC6_EN", RK3308_ADC_ANA_CON00(2), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC7_EN", RK3308_ADC_ANA_CON00(3), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC8_EN", RK3308_ADC_ANA_CON00(3), 5, 1, 1, 0),
+
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC1_WORK", RK3308_ADC_ANA_CON00(0), 2, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC2_WORK", RK3308_ADC_ANA_CON00(0), 6, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC3_WORK", RK3308_ADC_ANA_CON00(1), 2, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC4_WORK", RK3308_ADC_ANA_CON00(1), 6, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC5_WORK", RK3308_ADC_ANA_CON00(2), 2, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC6_WORK", RK3308_ADC_ANA_CON00(2), 6, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC7_WORK", RK3308_ADC_ANA_CON00(3), 2, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_mic, "MIC8_WORK", RK3308_ADC_ANA_CON00(3), 6, 1, 1, 0),
+
+	/*
+	 * In theory MIC1 and MIC2 can switch to LINE IN, but this is not
+	 * supported so all we can do is enabling the MIC input.
+	 */
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "CH1_IN_SEL", RK3308_ADC_ANA_CON07(0), 4, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "CH2_IN_SEL", RK3308_ADC_ANA_CON07(0), 6, 1, 1, 0),
+
+	SND_SOC_DAPM_SUPPLY("ADC1_BUF_REF_EN", RK3308_ADC_ANA_CON00(0), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC2_BUF_REF_EN", RK3308_ADC_ANA_CON00(0), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC3_BUF_REF_EN", RK3308_ADC_ANA_CON00(1), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC4_BUF_REF_EN", RK3308_ADC_ANA_CON00(1), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC5_BUF_REF_EN", RK3308_ADC_ANA_CON00(2), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC6_BUF_REF_EN", RK3308_ADC_ANA_CON00(2), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC7_BUF_REF_EN", RK3308_ADC_ANA_CON00(3), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC8_BUF_REF_EN", RK3308_ADC_ANA_CON00(3), 4, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("ADC_MCLK_GATE", RK3308_GLB_CON, 5, 1, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("ADC1_CLK_EN", RK3308_ADC_ANA_CON05(0), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC2_CLK_EN", RK3308_ADC_ANA_CON05(0), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC3_CLK_EN", RK3308_ADC_ANA_CON05(1), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC4_CLK_EN", RK3308_ADC_ANA_CON05(1), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC5_CLK_EN", RK3308_ADC_ANA_CON05(2), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC6_CLK_EN", RK3308_ADC_ANA_CON05(2), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC7_CLK_EN", RK3308_ADC_ANA_CON05(3), 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ADC8_CLK_EN", RK3308_ADC_ANA_CON05(3), 4, 0, NULL, 0),
+
+	// The "ALC" name from the TRM is misleading, these are needed even without ALC/AGC
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC1_EN", RK3308_ADC_ANA_CON02(0), 0, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC2_EN", RK3308_ADC_ANA_CON02(0), 4, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC3_EN", RK3308_ADC_ANA_CON02(1), 0, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC4_EN", RK3308_ADC_ANA_CON02(1), 4, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC5_EN", RK3308_ADC_ANA_CON02(2), 0, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC6_EN", RK3308_ADC_ANA_CON02(2), 4, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC7_EN", RK3308_ADC_ANA_CON02(3), 0, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC8_EN", RK3308_ADC_ANA_CON02(3), 4, 1, 1, 0),
+
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC1_EN", RK3308_ADC_ANA_CON05(0), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC2_EN", RK3308_ADC_ANA_CON05(0), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC3_EN", RK3308_ADC_ANA_CON05(1), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC4_EN", RK3308_ADC_ANA_CON05(1), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC5_EN", RK3308_ADC_ANA_CON05(2), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC6_EN", RK3308_ADC_ANA_CON05(2), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC7_EN", RK3308_ADC_ANA_CON05(3), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ADC8_EN", RK3308_ADC_ANA_CON05(3), 5, 1, 1, 0),
+
+	SND_SOC_DAPM_ADC("ADC1_WORK", "Capture", RK3308_ADC_ANA_CON05(0), 2, 0),
+	SND_SOC_DAPM_ADC("ADC2_WORK", "Capture", RK3308_ADC_ANA_CON05(0), 6, 0),
+	SND_SOC_DAPM_ADC("ADC3_WORK", "Capture", RK3308_ADC_ANA_CON05(1), 2, 0),
+	SND_SOC_DAPM_ADC("ADC4_WORK", "Capture", RK3308_ADC_ANA_CON05(1), 6, 0),
+	SND_SOC_DAPM_ADC("ADC5_WORK", "Capture", RK3308_ADC_ANA_CON05(2), 2, 0),
+	SND_SOC_DAPM_ADC("ADC6_WORK", "Capture", RK3308_ADC_ANA_CON05(2), 6, 0),
+	SND_SOC_DAPM_ADC("ADC7_WORK", "Capture", RK3308_ADC_ANA_CON05(3), 2, 0),
+	SND_SOC_DAPM_ADC("ADC8_WORK", "Capture", RK3308_ADC_ANA_CON05(3), 6, 0),
+
+	// The "ALC" name from the TRM is misleading, these are needed even without ALC/AGC
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC1_WORK", RK3308_ADC_ANA_CON02(0), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC2_WORK", RK3308_ADC_ANA_CON02(0), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC3_WORK", RK3308_ADC_ANA_CON02(1), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC4_WORK", RK3308_ADC_ANA_CON02(1), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC5_WORK", RK3308_ADC_ANA_CON02(2), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC6_WORK", RK3308_ADC_ANA_CON02(2), 5, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC7_WORK", RK3308_ADC_ANA_CON02(3), 1, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_adc, "ALC8_WORK", RK3308_ADC_ANA_CON02(3), 5, 1, 1, 0),
+
+	SND_SOC_DAPM_SUPPLY("MICBIAS Current", RK3308_ADC_ANA_CON08(0), 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", RK3308_ADC_ANA_CON07(1), 3, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS2", RK3308_ADC_ANA_CON07(2), 3, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUT_DRV("DAC_L_HPMIX_EN",   RK3308_DAC_ANA_CON13, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("DAC_R_HPMIX_EN",   RK3308_DAC_ANA_CON13, 4, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("DAC_L_HPMIX_WORK", RK3308_DAC_ANA_CON13, 1, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("DAC_R_HPMIX_WORK", RK3308_DAC_ANA_CON13, 5, 0, NULL, 0),
+	/* HPMIX is not actually acting as a mixer as the only supported input is I2S */
+	SND_SOC_DAPM_OUT_DRV("DAC_L_HPMIX_SEL",  RK3308_DAC_ANA_CON12, 2, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("DAC_R_HPMIX_SEL",  RK3308_DAC_ANA_CON12, 6, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("DAC HPMIX Left",     RK3308_DAC_ANA_CON13, 2, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("DAC HPMIX Right",    RK3308_DAC_ANA_CON13, 6, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("DAC_MCLK_GATE", RK3308_GLB_CON, 4, 1, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY("DAC_CURRENT_EN", RK3308_DAC_ANA_CON00, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_L_REF_EN",   RK3308_DAC_ANA_CON02, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_R_REF_EN",   RK3308_DAC_ANA_CON02, 4, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_L_CLK_EN",   RK3308_DAC_ANA_CON02, 1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_R_CLK_EN",   RK3308_DAC_ANA_CON02, 5, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("DAC_L_DAC_EN",  RK3308_DAC_ANA_CON02, 2, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("DAC_R_DAC_EN",  RK3308_DAC_ANA_CON02, 6, 0, NULL, 0),
+	SND_SOC_DAPM_DAC("DAC_L_DAC_WORK", NULL, RK3308_DAC_ANA_CON02, 3, 0),
+	SND_SOC_DAPM_DAC("DAC_R_DAC_WORK", NULL, RK3308_DAC_ANA_CON02, 7, 0),
+
+	SND_SOC_DAPM_SUPPLY("DAC_BUF_REF_L", RK3308_DAC_ANA_CON01, 2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DAC_BUF_REF_R", RK3308_DAC_ANA_CON01, 6, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV_E("HPOUT_POP_SOUND_L", SND_SOC_NOPM, 0, 0, NULL, 0,
+			       rk3308_codec_pop_sound_set,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_OUT_DRV_E("HPOUT_POP_SOUND_R", SND_SOC_NOPM, 4, 0, NULL, 0,
+			       rk3308_codec_pop_sound_set,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_OUT_DRV("L_HPOUT_EN", RK3308_DAC_ANA_CON03, 1, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("R_HPOUT_EN", RK3308_DAC_ANA_CON03, 5, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("L_HPOUT_WORK", RK3308_DAC_ANA_CON03, 2, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("R_HPOUT_WORK", RK3308_DAC_ANA_CON03, 6, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("HPOUT_L"),
+	SND_SOC_DAPM_OUTPUT("HPOUT_R"),
+
+	SND_SOC_DAPM_OUT_DRV("L_LINEOUT_EN", RK3308_DAC_ANA_CON04, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("R_LINEOUT_EN", RK3308_DAC_ANA_CON04, 4, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("LINEOUT_L"),
+	SND_SOC_DAPM_OUTPUT("LINEOUT_R"),
+};
+
+static const struct snd_soc_dapm_route rk3308_codec_dapm_routes[] = {
+	{ "MICBIAS1", NULL, "MICBIAS Current" },
+	{ "MICBIAS2", NULL, "MICBIAS Current" },
+
+	{ "MIC1_EN", NULL, "MIC1" },
+	{ "MIC2_EN", NULL, "MIC2" },
+	{ "MIC3_EN", NULL, "MIC3" },
+	{ "MIC4_EN", NULL, "MIC4" },
+	{ "MIC5_EN", NULL, "MIC5" },
+	{ "MIC6_EN", NULL, "MIC6" },
+	{ "MIC7_EN", NULL, "MIC7" },
+	{ "MIC8_EN", NULL, "MIC8" },
+
+	{ "MIC1_WORK", NULL, "MIC1_EN" },
+	{ "MIC2_WORK", NULL, "MIC2_EN" },
+	{ "MIC3_WORK", NULL, "MIC3_EN" },
+	{ "MIC4_WORK", NULL, "MIC4_EN" },
+	{ "MIC5_WORK", NULL, "MIC5_EN" },
+	{ "MIC6_WORK", NULL, "MIC6_EN" },
+	{ "MIC7_WORK", NULL, "MIC7_EN" },
+	{ "MIC8_WORK", NULL, "MIC8_EN" },
+
+	{ "CH1_IN_SEL", NULL, "MIC1_WORK" },
+	{ "CH2_IN_SEL", NULL, "MIC2_WORK" },
+
+	{ "ALC1_EN", NULL, "CH1_IN_SEL" },
+	{ "ALC2_EN", NULL, "CH2_IN_SEL" },
+	{ "ALC3_EN", NULL, "MIC3_WORK" },
+	{ "ALC4_EN", NULL, "MIC4_WORK" },
+	{ "ALC5_EN", NULL, "MIC5_WORK" },
+	{ "ALC6_EN", NULL, "MIC6_WORK" },
+	{ "ALC7_EN", NULL, "MIC7_WORK" },
+	{ "ALC8_EN", NULL, "MIC8_WORK" },
+
+	{ "ADC1_EN", NULL, "ALC1_EN" },
+	{ "ADC2_EN", NULL, "ALC2_EN" },
+	{ "ADC3_EN", NULL, "ALC3_EN" },
+	{ "ADC4_EN", NULL, "ALC4_EN" },
+	{ "ADC5_EN", NULL, "ALC5_EN" },
+	{ "ADC6_EN", NULL, "ALC6_EN" },
+	{ "ADC7_EN", NULL, "ALC7_EN" },
+	{ "ADC8_EN", NULL, "ALC8_EN" },
+
+	{ "ADC1_WORK", NULL, "ADC1_EN" },
+	{ "ADC2_WORK", NULL, "ADC2_EN" },
+	{ "ADC3_WORK", NULL, "ADC3_EN" },
+	{ "ADC4_WORK", NULL, "ADC4_EN" },
+	{ "ADC5_WORK", NULL, "ADC5_EN" },
+	{ "ADC6_WORK", NULL, "ADC6_EN" },
+	{ "ADC7_WORK", NULL, "ADC7_EN" },
+	{ "ADC8_WORK", NULL, "ADC8_EN" },
+
+	{ "ADC1_BUF_REF_EN", NULL, "ADC_CURRENT_EN12" },
+	{ "ADC2_BUF_REF_EN", NULL, "ADC_CURRENT_EN12" },
+	{ "ADC3_BUF_REF_EN", NULL, "ADC_CURRENT_EN34" },
+	{ "ADC4_BUF_REF_EN", NULL, "ADC_CURRENT_EN34" },
+	{ "ADC5_BUF_REF_EN", NULL, "ADC_CURRENT_EN56" },
+	{ "ADC6_BUF_REF_EN", NULL, "ADC_CURRENT_EN56" },
+	{ "ADC7_BUF_REF_EN", NULL, "ADC_CURRENT_EN78" },
+	{ "ADC8_BUF_REF_EN", NULL, "ADC_CURRENT_EN78" },
+
+	{ "ADC1_WORK", NULL, "ADC1_BUF_REF_EN" },
+	{ "ADC2_WORK", NULL, "ADC2_BUF_REF_EN" },
+	{ "ADC3_WORK", NULL, "ADC3_BUF_REF_EN" },
+	{ "ADC4_WORK", NULL, "ADC4_BUF_REF_EN" },
+	{ "ADC5_WORK", NULL, "ADC5_BUF_REF_EN" },
+	{ "ADC6_WORK", NULL, "ADC6_BUF_REF_EN" },
+	{ "ADC7_WORK", NULL, "ADC7_BUF_REF_EN" },
+	{ "ADC8_WORK", NULL, "ADC8_BUF_REF_EN" },
+
+	{ "ADC1_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC2_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC3_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC4_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC5_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC6_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC7_CLK_EN", NULL, "ADC_MCLK_GATE" },
+	{ "ADC8_CLK_EN", NULL, "ADC_MCLK_GATE" },
+
+	{ "ADC1_WORK", NULL, "ADC1_CLK_EN" },
+	{ "ADC2_WORK", NULL, "ADC2_CLK_EN" },
+	{ "ADC3_WORK", NULL, "ADC3_CLK_EN" },
+	{ "ADC4_WORK", NULL, "ADC4_CLK_EN" },
+	{ "ADC5_WORK", NULL, "ADC5_CLK_EN" },
+	{ "ADC6_WORK", NULL, "ADC6_CLK_EN" },
+	{ "ADC7_WORK", NULL, "ADC7_CLK_EN" },
+	{ "ADC8_WORK", NULL, "ADC8_CLK_EN" },
+
+	{ "ALC1_WORK", NULL, "ADC1_WORK" },
+	{ "ALC2_WORK", NULL, "ADC2_WORK" },
+	{ "ALC3_WORK", NULL, "ADC3_WORK" },
+	{ "ALC4_WORK", NULL, "ADC4_WORK" },
+	{ "ALC5_WORK", NULL, "ADC5_WORK" },
+	{ "ALC6_WORK", NULL, "ADC6_WORK" },
+	{ "ALC7_WORK", NULL, "ADC7_WORK" },
+	{ "ALC8_WORK", NULL, "ADC8_WORK" },
+
+	{ "HiFi Capture", NULL, "ALC1_WORK" },
+	{ "HiFi Capture", NULL, "ALC2_WORK" },
+	{ "HiFi Capture", NULL, "ALC3_WORK" },
+	{ "HiFi Capture", NULL, "ALC4_WORK" },
+	{ "HiFi Capture", NULL, "ALC5_WORK" },
+	{ "HiFi Capture", NULL, "ALC6_WORK" },
+	{ "HiFi Capture", NULL, "ALC7_WORK" },
+	{ "HiFi Capture", NULL, "ALC8_WORK" },
+
+	{ "DAC_L_HPMIX_EN", NULL, "HiFi Playback" },
+	{ "DAC_R_HPMIX_EN", NULL, "HiFi Playback" },
+	{ "DAC_L_HPMIX_WORK", NULL, "DAC_L_HPMIX_EN" },
+	{ "DAC_R_HPMIX_WORK", NULL, "DAC_R_HPMIX_EN" },
+	{ "DAC HPMIX Left",  NULL, "DAC_L_HPMIX_WORK" },
+	{ "DAC HPMIX Right", NULL, "DAC_R_HPMIX_WORK" },
+
+	{ "DAC_L_DAC_EN", NULL, "DAC HPMIX Left"  },
+	{ "DAC_R_DAC_EN", NULL, "DAC HPMIX Right" },
+
+	{ "DAC_L_REF_EN", NULL, "DAC_CURRENT_EN" },
+	{ "DAC_R_REF_EN", NULL, "DAC_CURRENT_EN" },
+	{ "DAC_L_CLK_EN", NULL, "DAC_L_REF_EN" },
+	{ "DAC_R_CLK_EN", NULL, "DAC_R_REF_EN" },
+	{ "DAC_L_CLK_EN", NULL, "DAC_MCLK_GATE" },
+	{ "DAC_R_CLK_EN", NULL, "DAC_MCLK_GATE" },
+	{ "DAC_L_DAC_EN", NULL, "DAC_L_CLK_EN" },
+	{ "DAC_R_DAC_EN", NULL, "DAC_R_CLK_EN" },
+	{ "DAC_L_DAC_WORK", NULL, "DAC_L_DAC_EN" },
+	{ "DAC_R_DAC_WORK", NULL, "DAC_R_DAC_EN" },
+	{ "DAC_L_HPMIX_SEL", NULL, "DAC_L_DAC_WORK" },
+	{ "DAC_R_HPMIX_SEL", NULL, "DAC_R_DAC_WORK" },
+
+	{ "HPOUT_L", NULL, "DAC_BUF_REF_L" },
+	{ "HPOUT_R", NULL, "DAC_BUF_REF_R" },
+	{ "L_HPOUT_EN", NULL, "DAC_L_HPMIX_SEL" },
+	{ "R_HPOUT_EN", NULL, "DAC_R_HPMIX_SEL" },
+	{ "L_HPOUT_WORK", NULL, "L_HPOUT_EN" },
+	{ "R_HPOUT_WORK", NULL, "R_HPOUT_EN" },
+	{ "HPOUT_POP_SOUND_L", NULL, "L_HPOUT_WORK" },
+	{ "HPOUT_POP_SOUND_R", NULL, "R_HPOUT_WORK" },
+	{ "HPOUT_L", NULL, "HPOUT_POP_SOUND_L" },
+	{ "HPOUT_R", NULL, "HPOUT_POP_SOUND_R" },
+
+	{ "L_LINEOUT_EN", NULL, "DAC_L_HPMIX_SEL" },
+	{ "R_LINEOUT_EN", NULL, "DAC_R_HPMIX_SEL" },
+	{ "LINEOUT_L", NULL, "L_LINEOUT_EN" },
+	{ "LINEOUT_R", NULL, "R_LINEOUT_EN" },
+};
+
+static int rk3308_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				    unsigned int fmt)
+{
+	struct snd_soc_component *component = codec_dai->component;
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	const unsigned int inv_bits = fmt & SND_SOC_DAIFMT_INV_MASK;
+	const bool inv_bitclk =
+		(inv_bits & SND_SOC_DAIFMT_IB_IF) ||
+		(inv_bits & SND_SOC_DAIFMT_IB_NF);
+	const bool inv_frmclk =
+		(inv_bits & SND_SOC_DAIFMT_IB_IF) ||
+		(inv_bits & SND_SOC_DAIFMT_NB_IF);
+	const unsigned int dac_master_bits = rk3308->codec_ver < ACODEC_VERSION_C ?
+		RK3308_DAC_IO_MODE_MASTER   | RK3308_DAC_MODE_MASTER  :
+		RK3308BS_DAC_IO_MODE_MASTER | RK3308BS_DAC_MODE_MASTER;
+	unsigned int adc_aif1 = 0, adc_aif2 = 0, dac_aif1 = 0, dac_aif2 = 0;
+	bool is_master = false;
+	int grp;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	case SND_SOC_DAIFMT_CBP_CFP:
+		adc_aif2 |= RK3308_ADC_IO_MODE_MASTER;
+		adc_aif2 |= RK3308_ADC_MODE_MASTER;
+		dac_aif2 |= dac_master_bits;
+		is_master = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_PCM;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_PCM;
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_I2S;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_RJ;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_RJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		adc_aif1 |= RK3308_ADC_I2S_MODE_LJ;
+		dac_aif1 |= RK3308_DAC_I2S_MODE_LJ;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (inv_bitclk) {
+		adc_aif2 |= RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL;
+		dac_aif2 |= RK3308_DAC_I2S_BIT_CLK_POL_REVERSAL;
+	}
+
+	if (inv_frmclk) {
+		adc_aif1 |= RK3308_ADC_I2S_LRC_POL_REVERSAL;
+		dac_aif1 |= RK3308_DAC_I2S_LRC_POL_REVERSAL;
+	}
+
+	/*
+	 * Hold ADC Digital registers start at master mode
+	 *
+	 * There are 8 ADCs which use the same internal SCLK and LRCK for
+	 * master mode. We need to make sure that they are in effect at the
+	 * same time, otherwise they will cause abnormal clocks.
+	 */
+	if (is_master)
+		regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
+
+	for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++) {
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON01(grp),
+				   RK3308_ADC_I2S_LRC_POL_REVERSAL |
+				   RK3308_ADC_I2S_MODE_MSK,
+				   adc_aif1);
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON02(grp),
+				   RK3308_ADC_IO_MODE_MASTER |
+				   RK3308_ADC_MODE_MASTER |
+				   RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL,
+				   adc_aif2);
+	}
+
+	/* Hold ADC Digital registers end at master mode */
+	if (is_master)
+		regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
+
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_DIG_CON01,
+			   RK3308_DAC_I2S_LRC_POL_REVERSAL |
+			   RK3308_DAC_I2S_MODE_MSK,
+			   dac_aif1);
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_DIG_CON02,
+			   dac_master_bits | RK3308_DAC_I2S_BIT_CLK_POL_REVERSAL,
+			   dac_aif2);
+
+	return 0;
+}
+
+static int rk3308_codec_dac_dig_config(struct rk3308_codec_priv *rk3308,
+				       struct snd_pcm_hw_params *params)
+{
+	unsigned int dac_aif1 = 0;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_16BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_20BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_24BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		dac_aif1 |= RK3308_DAC_I2S_VALID_LEN_32BITS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_DIG_CON01,
+			   RK3308_DAC_I2S_VALID_LEN_MSK, dac_aif1);
+	regmap_set_bits(rk3308->regmap, RK3308_DAC_DIG_CON02, RK3308_DAC_I2S_WORK);
+
+	return 0;
+}
+
+static int rk3308_codec_adc_dig_config(struct rk3308_codec_priv *rk3308,
+				       struct snd_pcm_hw_params *params)
+{
+	unsigned int adc_aif1 = 0;
+	/*
+	 * grp 0 = ADC1 and ADC2
+	 * grp 1 = ADC3 and ADC4
+	 * grp 2 = ADC5 and ADC6
+	 * grp 3 = ADC7 and ADC8
+	 */
+	u32 used_adc_grps;
+	int grp;
+
+	switch (params_channels(params)) {
+	case 1:
+		adc_aif1 |= RK3308_ADC_I2S_MONO;
+		used_adc_grps = 1;
+		break;
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		used_adc_grps = params_channels(params) / 2;
+		break;
+	default:
+		dev_err(rk3308->dev, "Invalid channel number %d\n", params_channels(params));
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_16BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_20BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_24BITS;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		adc_aif1 |= RK3308_ADC_I2S_VALID_LEN_32BITS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (grp = 0; grp < used_adc_grps; grp++) {
+		regmap_update_bits(rk3308->regmap,
+				   RK3308_ADC_DIG_CON03(grp),
+				   RK3308_ADC_L_CH_BIST_MSK | RK3308_ADC_R_CH_BIST_MSK,
+				   RK3308_ADC_L_CH_NORMAL_LEFT | RK3308_ADC_R_CH_NORMAL_RIGHT);
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON01(grp),
+				   RK3308_ADC_I2S_VALID_LEN_MSK | RK3308_ADC_I2S_MONO, adc_aif1);
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_DIG_CON02(grp), RK3308_ADC_I2S_WORK);
+	}
+
+	return 0;
+}
+
+static int rk3308_codec_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	return (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		rk3308_codec_dac_dig_config(rk3308, params) :
+		rk3308_codec_adc_dig_config(rk3308, params);
+}
+
+static const struct snd_soc_dai_ops rk3308_codec_dai_ops = {
+	.hw_params = rk3308_codec_hw_params,
+	.set_fmt = rk3308_codec_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver rk3308_codec_dai[] = {
+	{
+		.name = "rk3308-hifi",
+		.id = RK3308_HIFI,
+		.playback = {
+			.stream_name = "HiFi Playback",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+				    SNDRV_PCM_FMTBIT_S20_3LE |
+				    SNDRV_PCM_FMTBIT_S24_LE |
+				    SNDRV_PCM_FMTBIT_S32_LE),
+		},
+		.capture = {
+			.stream_name = "HiFi Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+				    SNDRV_PCM_FMTBIT_S20_3LE |
+				    SNDRV_PCM_FMTBIT_S24_LE |
+				    SNDRV_PCM_FMTBIT_S32_LE),
+		},
+		.ops = &rk3308_codec_dai_ops,
+	},
+};
+
+static void rk3308_codec_reset(struct snd_soc_component *component)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	reset_control_assert(rk3308->reset);
+	usleep_range(10000, 11000);     /* estimated value */
+	reset_control_deassert(rk3308->reset);
+
+	regmap_write(rk3308->regmap, RK3308_GLB_CON, 0x00);
+	usleep_range(10000, 11000);     /* estimated value */
+	regmap_write(rk3308->regmap, RK3308_GLB_CON,
+		     RK3308_SYS_WORK |
+		     RK3308_DAC_DIG_WORK |
+		     RK3308_ADC_DIG_WORK);
+}
+
+/*
+ * Initialize register whose default after HW reset is problematic or which
+ * are never modified.
+ */
+static int rk3308_codec_initialize(struct rk3308_codec_priv *rk3308)
+{
+	int grp;
+
+	/*
+	 * Init ADC digital vol to 0 dB (reset value is 0xff, undocumented).
+	 * Range: -97dB ~ +32dB.
+	 */
+	if (rk3308->codec_ver == ACODEC_VERSION_C) {
+		for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++) {
+			regmap_write(rk3308->regmap, RK3308_ADC_DIG_CON05(grp),
+					   RK3308_ADC_DIG_VOL_CON_x_0DB);
+			regmap_write(rk3308->regmap, RK3308_ADC_DIG_CON06(grp),
+					   RK3308_ADC_DIG_VOL_CON_x_0DB);
+		}
+	}
+
+	/* set HPMIX default gains (reset value is 0, which is illegal) */
+	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON12,
+			   RK3308_DAC_L_HPMIX_GAIN_MSK |
+			   RK3308_DAC_R_HPMIX_GAIN_MSK,
+			   RK3308_DAC_L_HPMIX_GAIN_NDB_6 |
+			   RK3308_DAC_R_HPMIX_GAIN_NDB_6);
+
+	/* recover DAC digital gain to 0 dB (reset value is 0xff, undocumented) */
+	if (rk3308->codec_ver == ACODEC_VERSION_C)
+		regmap_write(rk3308->regmap, RK3308_DAC_DIG_CON04,
+			     RK3308BS_DAC_DIG_GAIN_0DB);
+
+	/*
+	 * Unconditionally enable zero-cross detection (needed for AGC,
+	 * harmless without AGC)
+	 */
+	for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++)
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON02(grp),
+				RK3308_ADC_CH1_ZEROCROSS_DET_EN |
+				RK3308_ADC_CH2_ZEROCROSS_DET_EN);
+
+	return 0;
+}
+
+static int rk3308_codec_probe(struct snd_soc_component *component)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+
+	rk3308->component = component;
+
+	rk3308_codec_reset(component);
+	rk3308_codec_initialize(rk3308);
+
+	return 0;
+}
+
+static int rk3308_codec_set_bias_level(struct snd_soc_component *component,
+				       enum snd_soc_bias_level level)
+{
+	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
+	unsigned int v;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_component_get_bias_level(component) != SND_SOC_BIAS_OFF)
+			break;
+
+		/* Sequence from TRM Section 8.6.3 "Power Up" */
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+				   RK3308_ADC_CURRENT_CHARGE_MSK,
+				   RK3308_ADC_SEL_I(0x1));
+		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+				RK3308_ADC_REF_EN);
+		for (v = 0x1; v <= 0x7f; v++) {
+			regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+					   RK3308_ADC_CURRENT_CHARGE_MSK, v);
+			usleep_range(200, 400);
+		}
+		msleep(20);	/* estimated value */
+		break;
+	case SND_SOC_BIAS_OFF:
+		/* Sequence from TRM Section 8.6.4 "Power Down" */
+		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+				   RK3308_ADC_CURRENT_CHARGE_MSK,
+				   RK3308_ADC_SEL_I(0x1));
+		regmap_clear_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+				  RK3308_ADC_REF_EN);
+
+		for (v = 0x7f; v >= 0x1; v--) {
+			regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON10(0),
+					   RK3308_ADC_CURRENT_CHARGE_MSK, v);
+			usleep_range(200, 400);
+		}
+		msleep(20);	/* estimated value */
+		break;
+	}
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_rk3308 = {
+	.probe = rk3308_codec_probe,
+	.set_bias_level = rk3308_codec_set_bias_level,
+	.controls = rk3308_codec_controls,
+	.num_controls = ARRAY_SIZE(rk3308_codec_controls),
+	.dapm_widgets = rk3308_codec_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk3308_codec_dapm_widgets),
+	.dapm_routes = rk3308_codec_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rk3308_codec_dapm_routes),
+};
+
+static const struct regmap_config rk3308_codec_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = RK3308_DAC_ANA_CON15,
+};
+
+static int rk3308_codec_get_version(struct rk3308_codec_priv *rk3308)
+{
+	unsigned int chip_id;
+	int err;
+
+	err = regmap_read(rk3308->grf, GRF_CHIP_ID, &chip_id);
+	if (err)
+		return err;
+
+	switch (chip_id) {
+	case 3306:
+		rk3308->codec_ver = ACODEC_VERSION_A;
+		break;
+	case 0x3308:
+		rk3308->codec_ver = ACODEC_VERSION_B;
+		return dev_err_probe(rk3308->dev, -EINVAL, "Chip version B not supported\n");
+	case 0x3308c:
+		rk3308->codec_ver = ACODEC_VERSION_C;
+		break;
+	default:
+		return dev_err_probe(rk3308->dev, -EINVAL, "Unknown chip_id: 0x%x\n", chip_id);
+	}
+
+	dev_info(rk3308->dev, "Found codec version %c\n", rk3308->codec_ver);
+	return 0;
+}
+
+static int rk3308_codec_set_micbias_level(struct rk3308_codec_priv *rk3308)
+{
+	struct device_node *np = rk3308->dev->of_node;
+	u32 percent;
+	u32 mult;
+	int err;
+
+	err = of_property_read_u32(np, "rockchip,micbias-avdd-percent", &percent);
+	if (err == -EINVAL)
+		return 0;
+	if (err)
+		return dev_err_probe(rk3308->dev, err,
+				     "Error reading 'rockchip,micbias-avdd-percent'\n");
+
+	/* Convert percent to register value, linerarly (50% -> 0, 5% step = +1) */
+	mult = (percent - 50) / 5;
+
+	/* Check range and that the percent was an exact value allowed */
+	if (mult > RK3308_ADC_LEVEL_RANGE_MICBIAS_MAX || mult * 5 + 50 != percent)
+		return dev_err_probe(rk3308->dev, -EINVAL,
+				     "Invalid value %u for 'rockchip,micbias-avdd-percent'\n",
+				     percent);
+
+	regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(0),
+			   RK3308_ADC_LEVEL_RANGE_MICBIAS_MSK,
+			   mult << RK3308_ADC_LEVEL_RANGE_MICBIAS_SFT);
+
+	return 0;
+}
+
+static int rk3308_codec_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct rk3308_codec_priv *rk3308;
+	void __iomem *base;
+	int err;
+
+	rk3308 = devm_kzalloc(&pdev->dev, sizeof(*rk3308), GFP_KERNEL);
+	if (!rk3308)
+		return -ENOMEM;
+
+	rk3308->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(rk3308->grf))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->grf),
+			"Missing 'rockchip,grf' property\n");
+
+	rk3308->dev = &pdev->dev;
+
+	rk3308->reset = devm_reset_control_get(&pdev->dev, "codec");
+	if (IS_ERR(rk3308->reset)) {
+		err = PTR_ERR(rk3308->reset);
+		if (err != -ENOENT)
+			return err;
+
+		dev_dbg(&pdev->dev, "No reset control found\n");
+		rk3308->reset = NULL;
+	}
+
+	rk3308->hclk = devm_clk_get(&pdev->dev, "hclk");
+	if (IS_ERR(rk3308->hclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->hclk), "Can't get hclk\n");
+
+	rk3308->mclk_rx = devm_clk_get(&pdev->dev, "mclk_rx");
+	if (IS_ERR(rk3308->mclk_rx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->mclk_rx), "Can't get mclk_rx\n");
+
+	rk3308->mclk_tx = devm_clk_get(&pdev->dev, "mclk_tx");
+	if (IS_ERR(rk3308->mclk_tx))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->mclk_tx), "Can't get mclk_tx\n");
+
+	err = clk_prepare_enable(rk3308->hclk);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to enable hclk\n");
+
+	err = clk_prepare_enable(rk3308->mclk_rx);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to enable mclk_rx\n");
+
+	err = clk_prepare_enable(rk3308->mclk_tx);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to enable mclk_tx\n");
+
+	err = rk3308_codec_get_version(rk3308);
+	if (err)
+		return err;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rk3308->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					       &rk3308_codec_regmap_config);
+	if (IS_ERR(rk3308->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3308->regmap),
+				     "Failed to init regmap\n");
+
+	platform_set_drvdata(pdev, rk3308);
+
+	err = rk3308_codec_set_micbias_level(rk3308);
+	if (err)
+		return err;
+
+	err = devm_snd_soc_register_component(&pdev->dev, &soc_codec_dev_rk3308,
+					      rk3308_codec_dai, ARRAY_SIZE(rk3308_codec_dai));
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "Failed to register codec\n");
+
+	return 0;
+}
+
+static const struct of_device_id rk3308_codec_of_match[] = {
+	{ .compatible = "rockchip,rk3308-codec", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rk3308_codec_of_match);
+
+static struct platform_driver rk3308_codec_driver = {
+	.driver = {
+		.name = "rk3308-acodec",
+		.of_match_table = of_match_ptr(rk3308_codec_of_match),
+	},
+	.probe = rk3308_codec_platform_probe,
+};
+module_platform_driver(rk3308_codec_driver);
+
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
+MODULE_DESCRIPTION("ASoC RK3308 Codec Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/rk3308_codec.h b/sound/soc/codecs/rk3308_codec.h
new file mode 100644
index 000000000000..50239a6919ab
--- /dev/null
+++ b/sound/soc/codecs/rk3308_codec.h
@@ -0,0 +1,593 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Rockchip RK3308 internal audio codec driver -- register definitions
+ *
+ * Copyright (c) 2018, Fuzhou Rockchip Electronics Co., Ltd All rights reserved.
+ * Copyright (c) 2022, Vivax-Metrotech Ltd
+ */
+
+#ifndef __RK3308_CODEC_H__
+#define __RK3308_CODEC_H__
+
+#define RK3308_GLB_CON				0x00
+
+/* ADC DIGITAL REGISTERS */
+
+/*
+ * The ADC group are 0 ~ 3, that control:
+ *
+ * CH0: left_0(ADC1) and right_0(ADC2)
+ * CH1: left_1(ADC3) and right_1(ADC4)
+ * CH2: left_2(ADC5) and right_2(ADC6)
+ * CH3: left_3(ADC7) and right_3(ADC8)
+ */
+#define RK3308_ADC_DIG_OFFSET(ch)		(((ch) & 0x3) * 0xc0 + 0x0)
+
+#define RK3308_ADC_DIG_CON01(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x04)
+#define RK3308_ADC_DIG_CON02(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x08)
+#define RK3308_ADC_DIG_CON03(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x0c)
+#define RK3308_ADC_DIG_CON04(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x10)
+#define RK3308_ADC_DIG_CON05(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x14) // ver.C only
+#define RK3308_ADC_DIG_CON06(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x18) // ver.C only
+#define RK3308_ADC_DIG_CON07(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x1c)
+
+#define RK3308_ALC_L_DIG_CON00(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x40)
+#define RK3308_ALC_L_DIG_CON01(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x44)
+#define RK3308_ALC_L_DIG_CON02(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x48)
+#define RK3308_ALC_L_DIG_CON03(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x4c)
+#define RK3308_ALC_L_DIG_CON04(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x50)
+#define RK3308_ALC_L_DIG_CON05(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x54)
+#define RK3308_ALC_L_DIG_CON06(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x58)
+#define RK3308_ALC_L_DIG_CON07(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x5c)
+#define RK3308_ALC_L_DIG_CON08(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x60)
+#define RK3308_ALC_L_DIG_CON09(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x64)
+#define RK3308_ALC_L_DIG_CON12(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x70)
+
+#define RK3308_ALC_R_DIG_CON00(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x80)
+#define RK3308_ALC_R_DIG_CON01(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x84)
+#define RK3308_ALC_R_DIG_CON02(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x88)
+#define RK3308_ALC_R_DIG_CON03(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x8c)
+#define RK3308_ALC_R_DIG_CON04(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x90)
+#define RK3308_ALC_R_DIG_CON05(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x94)
+#define RK3308_ALC_R_DIG_CON06(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x98)
+#define RK3308_ALC_R_DIG_CON07(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0x9c)
+#define RK3308_ALC_R_DIG_CON08(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0xa0)
+#define RK3308_ALC_R_DIG_CON09(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0xa4)
+#define RK3308_ALC_R_DIG_CON12(ch)		(RK3308_ADC_DIG_OFFSET((ch)) + 0xb0)
+
+/* DAC DIGITAL REGISTERS */
+#define RK3308_DAC_DIG_OFFSET			0x300
+#define RK3308_DAC_DIG_CON01			(RK3308_DAC_DIG_OFFSET + 0x04)
+#define RK3308_DAC_DIG_CON02			(RK3308_DAC_DIG_OFFSET + 0x08)
+#define RK3308_DAC_DIG_CON03			(RK3308_DAC_DIG_OFFSET + 0x0c)
+#define RK3308_DAC_DIG_CON04			(RK3308_DAC_DIG_OFFSET + 0x10)
+#define RK3308_DAC_DIG_CON05			(RK3308_DAC_DIG_OFFSET + 0x14)
+#define RK3308_DAC_DIG_CON10			(RK3308_DAC_DIG_OFFSET + 0x28)
+#define RK3308_DAC_DIG_CON11			(RK3308_DAC_DIG_OFFSET + 0x2c)
+#define RK3308_DAC_DIG_CON13			(RK3308_DAC_DIG_OFFSET + 0x34)
+#define RK3308_DAC_DIG_CON14			(RK3308_DAC_DIG_OFFSET + 0x38)
+
+/* ADC ANALOG REGISTERS */
+/*
+ * The ADC group are 0 ~ 3, that control:
+ *
+ * CH0: left_0(ADC1) and right_0(ADC2)
+ * CH1: left_1(ADC3) and right_1(ADC4)
+ * CH2: left_2(ADC5) and right_2(ADC6)
+ * CH3: left_3(ADC7) and right_3(ADC8)
+ */
+#define RK3308_ADC_ANA_OFFSET(ch)		(((ch) & 0x3) * 0x40 + 0x340)
+#define RK3308_ADC_ANA_CON00(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x00)
+#define RK3308_ADC_ANA_CON01(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x04)
+#define RK3308_ADC_ANA_CON02(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x08)
+#define RK3308_ADC_ANA_CON03(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x0c)
+#define RK3308_ADC_ANA_CON04(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x10)
+#define RK3308_ADC_ANA_CON05(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x14)
+#define RK3308_ADC_ANA_CON06(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x18)
+#define RK3308_ADC_ANA_CON07(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x1c)
+#define RK3308_ADC_ANA_CON08(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x20)
+#define RK3308_ADC_ANA_CON10(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x28)
+#define RK3308_ADC_ANA_CON11(ch)		(RK3308_ADC_ANA_OFFSET((ch)) + 0x2c)
+
+/* DAC ANALOG REGISTERS */
+#define RK3308_DAC_ANA_OFFSET			0x440
+#define RK3308_DAC_ANA_CON00			(RK3308_DAC_ANA_OFFSET + 0x00)
+#define RK3308_DAC_ANA_CON01			(RK3308_DAC_ANA_OFFSET + 0x04)
+#define RK3308_DAC_ANA_CON02			(RK3308_DAC_ANA_OFFSET + 0x08)
+#define RK3308_DAC_ANA_CON03			(RK3308_DAC_ANA_OFFSET + 0x0c)
+#define RK3308_DAC_ANA_CON04			(RK3308_DAC_ANA_OFFSET + 0x10)
+#define RK3308_DAC_ANA_CON05			(RK3308_DAC_ANA_OFFSET + 0x14)
+#define RK3308_DAC_ANA_CON06			(RK3308_DAC_ANA_OFFSET + 0x18)
+#define RK3308_DAC_ANA_CON07			(RK3308_DAC_ANA_OFFSET + 0x1c)
+#define RK3308_DAC_ANA_CON08			(RK3308_DAC_ANA_OFFSET + 0x20)
+#define RK3308_DAC_ANA_CON12			(RK3308_DAC_ANA_OFFSET + 0x30)
+#define RK3308_DAC_ANA_CON13			(RK3308_DAC_ANA_OFFSET + 0x34)
+#define RK3308_DAC_ANA_CON14			(RK3308_DAC_ANA_OFFSET + 0x38)
+#define RK3308_DAC_ANA_CON15			(RK3308_DAC_ANA_OFFSET + 0x3c)
+
+/*
+ * These are the bits for registers
+ */
+
+/* RK3308_GLB_CON - REG: 0x0000 */
+#define RK3308_ADC_BIST_WORK			BIT(7)
+#define RK3308_DAC_BIST_WORK			BIT(6)
+#define RK3308_ADC_MCLK_GATING_MSK		BIT(5)
+#define RK3308_DAC_MCLK_GATING_MSK		BIT(4)
+#define RK3308_CODEC_RST_MSK			(0x7 << 0)
+#define RK3308_ADC_DIG_WORK			BIT(2)
+#define RK3308_DAC_DIG_WORK			BIT(1)
+#define RK3308_SYS_WORK				BIT(0)
+
+/* RK3308_ADC_DIG_CON01 - REG: 0x0004 */
+#define RK3308_ADC_I2S_LRC_POL_REVERSAL		BIT(7)
+#define RK3308_ADC_I2S_VALID_LEN_SFT		5
+#define RK3308_ADC_I2S_VALID_LEN_MSK		(0x3 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_32BITS		(0x3 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_24BITS		(0x2 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_20BITS		(0x1 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_VALID_LEN_16BITS		(0x0 << RK3308_ADC_I2S_VALID_LEN_SFT)
+#define RK3308_ADC_I2S_MODE_SFT			3
+#define RK3308_ADC_I2S_MODE_MSK			(0x3 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_PCM			(0x3 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_I2S			(0x2 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_LJ			(0x1 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_MODE_RJ			(0x0 << RK3308_ADC_I2S_MODE_SFT)
+#define RK3308_ADC_I2S_LR_SWAP			BIT(1)
+#define RK3308_ADC_I2S_MONO			BIT(0)
+
+/* RK3308_ADC_DIG_CON02 - REG: 0x0008 */
+#define RK3308_ADC_IO_MODE_MASTER		BIT(5)
+#define RK3308_ADC_MODE_MASTER			BIT(4)
+#define RK3308_ADC_I2S_FRAME_LEN_SFT		2
+#define RK3308_ADC_I2S_FRAME_LEN_MSK		(0x3 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_32BITS		(0x3 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_24BITS		(0x2 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_20BITS		(0x1 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_FRAME_16BITS		(0x0 << RK3308_ADC_I2S_FRAME_LEN_SFT)
+#define RK3308_ADC_I2S_WORK			BIT(1)
+#define RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL	BIT(0)
+
+/* RK3308_ADC_DIG_CON03 - REG: 0x000c */
+#define RK3308_ADC_L_CH_BIST_SFT		2
+#define RK3308_ADC_L_CH_BIST_MSK		(0x3 << RK3308_ADC_L_CH_BIST_SFT)
+#define RK3308_ADC_L_CH_NORMAL_RIGHT		(0x3 << RK3308_ADC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_ADC_L_CH_BIST_CUBE		(0x2 << RK3308_ADC_L_CH_BIST_SFT)
+#define RK3308_ADC_L_CH_BIST_SINE		(0x1 << RK3308_ADC_L_CH_BIST_SFT)
+#define RK3308_ADC_L_CH_NORMAL_LEFT		(0x0 << RK3308_ADC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_ADC_R_CH_BIST_SFT		0
+#define RK3308_ADC_R_CH_BIST_MSK		(0x3 << RK3308_ADC_R_CH_BIST_SFT)
+#define RK3308_ADC_R_CH_NORMAL_LEFT		(0x3 << RK3308_ADC_R_CH_BIST_SFT) /* normal mode */
+#define RK3308_ADC_R_CH_BIST_CUBE		(0x2 << RK3308_ADC_R_CH_BIST_SFT)
+#define RK3308_ADC_R_CH_BIST_SINE		(0x1 << RK3308_ADC_R_CH_BIST_SFT)
+#define RK3308_ADC_R_CH_NORMAL_RIGHT		(0x0 << RK3308_ADC_R_CH_BIST_SFT) /* normal mode */
+
+/* RK3308_ADC_DIG_CON04 - REG: 0x0010 */
+#define RK3308_ADC_HPF_PATH_DIS			BIT(2)
+#define RK3308_ADC_HPF_CUTOFF_SFT		0
+#define RK3308_ADC_HPF_CUTOFF_MSK		(0x3 << RK3308_ADC_HPF_CUTOFF_SFT)
+#define RK3308_ADC_HPF_CUTOFF_612HZ		(0x2 << RK3308_ADC_HPF_CUTOFF_SFT)
+#define RK3308_ADC_HPF_CUTOFF_245HZ		(0x1 << RK3308_ADC_HPF_CUTOFF_SFT)
+#define RK3308_ADC_HPF_CUTOFF_20HZ		(0x0 << RK3308_ADC_HPF_CUTOFF_SFT)
+
+/* RK3308_ADC_DIG_CON07 - REG: 0x001c */
+#define RK3308_ADCL_DATA_SFT			4
+#define RK3308_ADCR_DATA_SFT			2
+#define RK3308_ADCL_DATA_SEL_ADCL		BIT(1)
+#define RK3308_ADCR_DATA_SEL_ADCR		BIT(0)
+
+/*
+ * RK3308_ALC_L_DIG_CON00 - REG: 0x0040 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON00 - REG: 0x0080 + ch * 0xc0
+ */
+#define RK3308_GAIN_ATTACK_JACK			BIT(6)
+#define RK3308_CTRL_GEN_SFT			4
+#define RK3308_CTRL_GEN_MSK			(0x3 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_JACK3			(0x3 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_JACK2			(0x2 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_JACK1			(0x1 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_CTRL_GEN_NORMAL			(0x0 << RK3308_ALC_CTRL_GEN_SFT)
+#define RK3308_AGC_HOLD_TIME_SFT		0
+#define RK3308_AGC_HOLD_TIME_MSK		(0xf << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_1S			(0xa << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_512MS		(0x9 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_256MS		(0x8 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_128MS		(0x7 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_64MS		(0x6 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_32MS		(0x5 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_16MS		(0x4 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_8MS		(0x3 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_4MS		(0x2 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_2MS		(0x1 << RK3308_AGC_HOLD_TIME_SFT)
+#define RK3308_AGC_HOLD_TIME_0MS		(0x0 << RK3308_AGC_HOLD_TIME_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON01 - REG: 0x0044 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON01 - REG: 0x0084 + ch * 0xc0
+ */
+#define RK3308_AGC_DECAY_TIME_SFT		4
+#define RK3308_AGC_ATTACK_TIME_SFT		0
+
+/*
+ * RK3308_ALC_L_DIG_CON02 - REG: 0x0048 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON02 - REG: 0x0088 + ch * 0xc0
+ */
+#define RK3308_AGC_MODE_LIMITER			BIT(7)
+#define RK3308_AGC_ZERO_CRO_EN			BIT(6)
+#define RK3308_AGC_AMP_RECOVER_GAIN		BIT(5)
+#define RK3308_AGC_FAST_DEC_EN			BIT(4)
+#define RK3308_AGC_NOISE_GATE_EN		BIT(3)
+#define RK3308_AGC_NOISE_GATE_THRESH_SFT	0
+#define RK3308_AGC_NOISE_GATE_THRESH_MSK	(0x7 << RK3308_AGC_NOISE_GATE_THRESH_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON03 - REG: 0x004c + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON03 - REG: 0x008c + ch * 0xc0
+ */
+#define RK3308_AGC_PGA_ZERO_CRO_EN		BIT(5)
+#define RK3308_AGC_PGA_GAIN_MAX			0x1f
+#define RK3308_AGC_PGA_GAIN_MIN			0
+#define RK3308_AGC_PGA_GAIN_SFT			0
+
+/*
+ * RK3308_ALC_L_DIG_CON04 - REG: 0x0050 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON04 - REG: 0x0090 + ch * 0xc0
+ */
+#define RK3308_AGC_SLOW_CLK_EN			BIT(3)
+#define RK3308_AGC_APPROX_RATE_SFT		0
+#define RK3308_AGC_APPROX_RATE_MSK		(0x7 << RK3308_AGC_APPROX_RATE_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON05 - REG: 0x0054 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON05 - REG: 0x0094 + ch * 0xc0
+ */
+#define RK3308_AGC_LO_8BITS_AGC_MAX_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON06 - REG: 0x0058 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON06 - REG: 0x0098 + ch * 0xc0
+ */
+#define RK3308_AGC_HI_8BITS_AGC_MAX_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON07 - REG: 0x005c + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON07 - REG: 0x009c + ch * 0xc0
+ */
+#define RK3308_AGC_LO_8BITS_AGC_MIN_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON08 - REG: 0x0060 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON08 - REG: 0x00a0 + ch * 0xc0
+ */
+#define RK3308_AGC_HI_8BITS_AGC_MIN_MSK		0xff
+
+/*
+ * RK3308_ALC_L_DIG_CON09 - REG: 0x0064 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON09 - REG: 0x00a4 + ch * 0xc0
+ */
+#define RK3308_AGC_FUNC_SEL_MSK			BIT(6)
+#define RK3308_AGC_MAX_GAIN_PGA_MAX		0x7
+#define RK3308_AGC_MAX_GAIN_PGA_MIN		0
+#define RK3308_AGC_MAX_GAIN_PGA_SFT		3
+#define RK3308_AGC_MAX_GAIN_PGA_MSK		(0x7 << RK3308_AGC_MAX_GAIN_PGA_SFT)
+#define RK3308_AGC_MIN_GAIN_PGA_MAX		0x7
+#define RK3308_AGC_MIN_GAIN_PGA_MIN		0
+#define RK3308_AGC_MIN_GAIN_PGA_SFT		0
+#define RK3308_AGC_MIN_GAIN_PGA_MSK		(0x7 << RK3308_AGC_MIN_GAIN_PGA_SFT)
+
+/*
+ * RK3308_ALC_L_DIG_CON12 - REG: 0x0068 + ch * 0xc0
+ * RK3308_ALC_R_DIG_CON12 - REG: 0x00a8 + ch * 0xc0
+ */
+#define RK3308_AGC_GAIN_MSK			0x1f
+
+/* RK3308_DAC_DIG_CON01 - REG: 0x0304 */
+#define RK3308_DAC_I2S_LRC_POL_REVERSAL		BIT(7)
+#define RK3308_DAC_I2S_VALID_LEN_SFT		5
+#define RK3308_DAC_I2S_VALID_LEN_MSK		(0x3 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_32BITS		(0x3 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_24BITS		(0x2 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_20BITS		(0x1 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_VALID_LEN_16BITS		(0x0 << RK3308_DAC_I2S_VALID_LEN_SFT)
+#define RK3308_DAC_I2S_MODE_SFT			3
+#define RK3308_DAC_I2S_MODE_MSK			(0x3 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_PCM			(0x3 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_I2S			(0x2 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_LJ			(0x1 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_MODE_RJ			(0x0 << RK3308_DAC_I2S_MODE_SFT)
+#define RK3308_DAC_I2S_LR_SWAP			BIT(2)
+
+/* RK3308_DAC_DIG_CON02 - REG: 0x0308 */
+#define RK3308BS_DAC_IO_MODE_MASTER		BIT(7)
+#define RK3308BS_DAC_MODE_MASTER		BIT(6)
+#define RK3308_DAC_IO_MODE_MASTER		BIT(5)
+#define RK3308_DAC_MODE_MASTER			BIT(4)
+#define RK3308_DAC_I2S_FRAME_LEN_SFT		2
+#define RK3308_DAC_I2S_FRAME_LEN_MSK		(0x3 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_32BITS		(0x3 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_24BITS		(0x2 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_20BITS		(0x1 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_FRAME_16BITS		(0x0 << RK3308_DAC_I2S_FRAME_LEN_SFT)
+#define RK3308_DAC_I2S_WORK			BIT(1)
+#define RK3308_DAC_I2S_BIT_CLK_POL_REVERSAL	BIT(0)
+
+/* RK3308_DAC_DIG_CON03 - REG: 0x030C */
+#define RK3308_DAC_L_CH_BIST_SFT		2
+#define RK3308_DAC_L_CH_BIST_MSK		(0x3 << RK3308_DAC_L_CH_BIST_SFT)
+#define RK3308_DAC_L_CH_BIST_LEFT		(0x3 << RK3308_DAC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_DAC_L_CH_BIST_CUBE		(0x2 << RK3308_DAC_L_CH_BIST_SFT)
+#define RK3308_DAC_L_CH_BIST_SINE		(0x1 << RK3308_DAC_L_CH_BIST_SFT)
+#define RK3308_DAC_L_CH_BIST_RIGHT		(0x0 << RK3308_DAC_L_CH_BIST_SFT) /* normal mode */
+#define RK3308_DAC_R_CH_BIST_SFT		0
+#define RK3308_DAC_R_CH_BIST_MSK		(0x3 << RK3308_DAC_R_CH_BIST_SFT)
+#define RK3308_DAC_R_CH_BIST_LEFT		(0x3 << RK3308_DAC_R_CH_BIST_SFT) /* normal mode */
+#define RK3308_DAC_R_CH_BIST_CUBE		(0x2 << RK3308_DAC_R_CH_BIST_SFT)
+#define RK3308_DAC_R_CH_BIST_SINE		(0x1 << RK3308_DAC_R_CH_BIST_SFT)
+#define RK3308_DAC_R_CH_BIST_RIGHT		(0x0 << RK3308_DAC_R_CH_BIST_SFT) /* normal mode */
+
+/* RK3308_DAC_DIG_CON04 - REG: 0x0310 */
+/* Versions up to B: */
+#define RK3308_DAC_MODULATOR_GAIN_SFT		4
+#define RK3308_DAC_MODULATOR_GAIN_MSK		(0x7 << RK3308_DAC_MODULATOR_GAIN_SFT)
+#define RK3308_DAC_CIC_IF_GAIN_SFT		0
+#define RK3308_DAC_CIC_IF_GAIN_MSK		(0x7 << RK3308_DAC_CIC_IF_GAIN_SFT)
+/* Version C: */
+#define RK3308BS_DAC_DIG_GAIN_SFT		0
+#define RK3308BS_DAC_DIG_GAIN_MSK		(0xff << RK3308BS_DAC_DIG_GAIN_SFT)
+#define RK3308BS_DAC_DIG_GAIN_0DB		(0xed << RK3308BS_DAC_DIG_GAIN_SFT)
+
+/* RK3308BS_ADC_DIG_CON05..06 (Version C only) */
+#define RK3308_ADC_DIG_VOL_CON_x_SFT		0
+#define RK3308_ADC_DIG_VOL_CON_x_MSK		(0xff << RK3308_ADC_DIG_VOL_CON_x_SFT)
+#define RK3308_ADC_DIG_VOL_CON_x_0DB		(0xc2 << RK3308_ADC_DIG_VOL_CON_x_SFT)
+
+/* RK3308_DAC_DIG_CON05 - REG: 0x0314 */
+#define RK3308_DAC_L_REG_CTL_INDATA		BIT(2)
+#define RK3308_DAC_R_REG_CTL_INDATA		BIT(1)
+
+/* RK3308_DAC_DIG_CON10 - REG: 0x0328 */
+#define RK3308_DAC_DATA_HI4(x)			((x) & 0xf)
+
+/* RK3308_DAC_DIG_CON11 - REG: 0x032c */
+#define RK3308_DAC_DATA_LO8(x)			((x) & 0xff)
+
+/* RK3308_ADC_ANA_CON00 - REG: 0x0340 */
+#define RK3308_ADC_CH1_CH2_MIC_ALL_MSK		(0xff << 0)
+#define RK3308_ADC_CH1_CH2_MIC_ALL		0xff
+#define RK3308_ADC_CH2_MIC_UNMUTE		BIT(7)
+#define RK3308_ADC_CH2_MIC_WORK			BIT(6)
+#define RK3308_ADC_CH2_MIC_EN			BIT(5)
+#define RK3308_ADC_CH2_BUF_REF_EN		BIT(4)
+#define RK3308_ADC_CH1_MIC_UNMUTE		BIT(3)
+#define RK3308_ADC_CH1_MIC_WORK			BIT(2)
+#define RK3308_ADC_CH1_MIC_EN			BIT(1)
+#define RK3308_ADC_CH1_BUF_REF_EN		BIT(0)
+
+/* RK3308_ADC_ANA_CON01 - REG: 0x0344
+ *
+ * The PGA of MIC-INs:
+ * - HW version A:
+ *   0x0 - MIC1~MIC8  0 dB (recommended when ADC used as loopback)
+ *   0x3 - MIC1~MIC8 20 dB (recommended when ADC used as MIC input)
+ * - HW version B:
+ *   0x0 - MIC1~MIC8   0 dB
+ *   0x1 - MIC1~MIC8 6.6 dB
+ *   0x2 - MIC1~MIC8  13 dB
+ *   0x3 - MIC1~MIC8  20 dB
+ */
+#define RK3308_ADC_CH2_MIC_GAIN_MAX		0x3
+#define RK3308_ADC_CH2_MIC_GAIN_MIN		0
+#define RK3308_ADC_CH2_MIC_GAIN_SFT		4
+#define RK3308_ADC_CH2_MIC_GAIN_MSK		(0x3 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_20DB		(0x3 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_13DB		(0x2 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_6_6DB		(0x1 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+#define RK3308_ADC_CH2_MIC_GAIN_0DB		(0x0 << RK3308_ADC_CH2_MIC_GAIN_SFT)
+
+#define RK3308_ADC_CH1_MIC_GAIN_MAX		0x3
+#define RK3308_ADC_CH1_MIC_GAIN_MIN		0
+#define RK3308_ADC_CH1_MIC_GAIN_SFT		0
+#define RK3308_ADC_CH1_MIC_GAIN_MSK		(0x3 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_20DB		(0x3 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_13DB		(0x2 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_6_6DB		(0x1 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+#define RK3308_ADC_CH1_MIC_GAIN_0DB		(0x0 << RK3308_ADC_CH1_MIC_GAIN_SFT)
+
+/* RK3308_ADC_ANA_CON02 - REG: 0x0348 */
+#define RK3308_ADC_CH2_ZEROCROSS_DET_EN		BIT(6)
+#define RK3308_ADC_CH2_ALC_WORK			BIT(5)
+#define RK3308_ADC_CH2_ALC_EN			BIT(4)
+#define RK3308_ADC_CH1_ZEROCROSS_DET_EN		BIT(2)
+#define RK3308_ADC_CH1_ALC_WORK			BIT(1)
+#define RK3308_ADC_CH1_ALC_EN			BIT(0)
+
+/* RK3308_ADC_ANA_CON03 - REG: 0x034c */
+#define RK3308_ADC_CH1_ALC_GAIN_MAX		0x1f
+#define RK3308_ADC_CH1_ALC_GAIN_MIN		0
+#define RK3308_ADC_CH1_ALC_GAIN_SFT		0
+#define RK3308_ADC_CH1_ALC_GAIN_MSK		(0x1f << RK3308_ADC_CH1_ALC_GAIN_SFT)
+#define RK3308_ADC_CH1_ALC_GAIN_0DB		(0x0c << RK3308_ADC_CH1_ALC_GAIN_SFT)
+
+/* RK3308_ADC_ANA_CON04 - REG: 0x0350 */
+#define RK3308_ADC_CH2_ALC_GAIN_MAX		0x1f
+#define RK3308_ADC_CH2_ALC_GAIN_MIN		0
+#define RK3308_ADC_CH2_ALC_GAIN_SFT		0
+#define RK3308_ADC_CH2_ALC_GAIN_MSK		(0x1f << RK3308_ADC_CH2_ALC_GAIN_SFT)
+#define RK3308_ADC_CH2_ALC_GAIN_0DB		(0x0c << RK3308_ADC_CH2_ALC_GAIN_SFT)
+
+/* RK3308_ADC_ANA_CON05 - REG: 0x0354 */
+#define RK3308_ADC_CH2_ADC_WORK			BIT(6)
+#define RK3308_ADC_CH2_ADC_EN			BIT(5)
+#define RK3308_ADC_CH2_CLK_EN			BIT(4)
+#define RK3308_ADC_CH1_ADC_WORK			BIT(2)
+#define RK3308_ADC_CH1_ADC_EN			BIT(1)
+#define RK3308_ADC_CH1_CLK_EN			BIT(0)
+
+/* RK3308_ADC_ANA_CON06 - REG: 0x0358 */
+#define RK3308_ADC_CURRENT_EN			BIT(0)
+
+/* RK3308_ADC_ANA_CON07 - REG: 0x035c */
+/* Note: The register configuration is only valid for ADC2 */
+#define RK3308_ADC_CH2_IN_SEL_SFT		6
+#define RK3308_ADC_CH2_IN_SEL_MSK		(0x3 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_LINEIN_MIC		(0x3 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_LINEIN		(0x2 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_MIC			(0x1 << RK3308_ADC_CH2_IN_SEL_SFT)
+#define RK3308_ADC_CH2_IN_NONE			(0x0 << RK3308_ADC_CH2_IN_SEL_SFT)
+/* Note: The register configuration is only valid for ADC1 */
+#define RK3308_ADC_CH1_IN_SEL_SFT		4
+#define RK3308_ADC_CH1_IN_SEL_MSK		(0x3 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_LINEIN_MIC		(0x3 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_LINEIN		(0x2 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_MIC			(0x1 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_CH1_IN_NONE			(0x0 << RK3308_ADC_CH1_IN_SEL_SFT)
+#define RK3308_ADC_MIC_BIAS_BUF_EN		BIT(3)
+#define RK3308_ADC_LEVEL_RANGE_MICBIAS_MAX	7
+#define RK3308_ADC_LEVEL_RANGE_MICBIAS_SFT	0
+#define RK3308_ADC_LEVEL_RANGE_MICBIAS_MSK	(0x7 << RK3308_ADC_LEVEL_RANGE_MICBIAS_SFT)
+
+/* RK3308_ADC_ANA_CON08 - REG: 0x0360 */
+#define RK3308_ADC_MICBIAS_CURRENT_EN		BIT(4)
+
+/* RK3308_ADC_ANA_CON10 - REG: 0x0368 */
+#define RK3308_ADC_REF_EN			BIT(7)
+#define RK3308_ADC_CURRENT_CHARGE_SFT		0
+#define RK3308_ADC_CURRENT_CHARGE_MSK		(0x7f << RK3308_ADC_CURRENT_CHARGE_SFT)
+/*
+ * 1: Choose the current I
+ * 0: Don't choose the current I
+ */
+#define RK3308_ADC_SEL_I(x)			((x) & 0x7f)
+
+/* RK3308_ADC_ANA_CON11 - REG: 0x036c */
+#define RK3308_ADC_ALCR_CON_GAIN_PGAR_EN	BIT(1)
+#define RK3308_ADC_ALCL_CON_GAIN_PGAL_EN	BIT(0)
+
+/* RK3308_DAC_ANA_CON00 - REG: 0x0440 */
+#define RK3308_DAC_HEADPHONE_DET_EN		BIT(1)
+#define RK3308_DAC_CURRENT_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON01 - REG: 0x0444 */
+#define RK3308_DAC_BUF_REF_R_EN			BIT(6)
+#define RK3308_DAC_BUF_REF_L_EN			BIT(2)
+#define RK3308_DAC_HPOUT_POP_SOUND_R_SFT	4
+#define RK3308_DAC_HPOUT_POP_SOUND_L_SFT	0
+// unshifted values for both L and R:
+#define RK3308_DAC_HPOUT_POP_SOUND_x_MSK	0x3
+#define RK3308_DAC_HPOUT_POP_SOUND_x_WORK	0x2
+#define RK3308_DAC_HPOUT_POP_SOUND_x_INIT	0x1
+
+/* RK3308_DAC_ANA_CON02 - REG: 0x0448 */
+#define RK3308_DAC_R_DAC_WORK			BIT(7)
+#define RK3308_DAC_R_DAC_EN			BIT(6)
+#define RK3308_DAC_R_CLK_EN			BIT(5)
+#define RK3308_DAC_R_REF_EN			BIT(4)
+#define RK3308_DAC_L_DAC_WORK			BIT(3)
+#define RK3308_DAC_L_DAC_EN			BIT(2)
+#define RK3308_DAC_L_CLK_EN			BIT(1)
+#define RK3308_DAC_L_REF_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON03 - REG: 0x044c */
+#define RK3308_DAC_R_HPOUT_WORK			BIT(6)
+#define RK3308_DAC_R_HPOUT_EN			BIT(5)
+#define RK3308_DAC_R_HPOUT_MUTE_SFT		4
+#define RK3308_DAC_L_HPOUT_WORK			BIT(2)
+#define RK3308_DAC_L_HPOUT_EN			BIT(1)
+#define RK3308_DAC_L_HPOUT_MUTE_SFT		0
+
+/* RK3308_DAC_ANA_CON04 - REG: 0x0450 */
+#define RK3308_DAC_x_LINEOUT_GAIN_MAX		0x3
+#define RK3308_DAC_R_LINEOUT_GAIN_SFT		6
+#define RK3308_DAC_R_LINEOUT_GAIN_MSK		(0x3 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_0DB		(0x3 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_NDB_1_5	(0x2 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_NDB_3		(0x1 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_GAIN_NDB_6		(0x0 << RK3308_DAC_R_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_R_LINEOUT_MUTE_SFT		5
+#define RK3308_DAC_R_LINEOUT_EN			BIT(4)
+#define RK3308_DAC_L_LINEOUT_GAIN_SFT		2
+#define RK3308_DAC_L_LINEOUT_GAIN_MSK		(0x3 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_0DB		(0x3 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_NDB_1_5	(0x2 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_NDB_3		(0x1 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_GAIN_NDB_6		(0x0 << RK3308_DAC_L_LINEOUT_GAIN_SFT)
+#define RK3308_DAC_L_LINEOUT_MUTE_SFT		1
+#define RK3308_DAC_L_LINEOUT_EN			BIT(0)
+
+/* RK3308_DAC_ANA_CON05 - REG: 0x0454, step is 1.5db */
+/* RK3308_DAC_ANA_CON06 - REG: 0x0458, step is 1.5db */
+#define RK3308_DAC_x_HPOUT_GAIN_MAX		0x1e
+#define RK3308_DAC_x_HPOUT_GAIN_SFT		0
+#define RK3308_DAC_x_HPOUT_GAIN_MSK		(0x1f << RK3308_DAC_x_HPOUT_GAIN_SFT)
+#define RK3308_DAC_x_HPOUT_GAIN_MIN		(0x00 << RK3308_DAC_x_HPOUT_GAIN_SFT)
+
+/* RK3308_DAC_ANA_CON07 - REG: 0x045c */
+#define RK3308_DAC_R_HPOUT_DRV_SFT		4
+#define RK3308_DAC_R_HPOUT_DRV_MSK		(0xf << RK3308_DAC_R_HPOUT_DRV_SFT)
+#define RK3308_DAC_L_HPOUT_DRV_SFT		0
+#define RK3308_DAC_L_HPOUT_DRV_MSK		(0xf << RK3308_DAC_L_HPOUT_DRV_SFT)
+
+/* RK3308_DAC_ANA_CON08 - REG: 0x0460 */
+#define RK3308_DAC_R_LINEOUT_DRV_SFT		4
+#define RK3308_DAC_R_LINEOUT_DRV_MSK		(0xf << RK3308_DAC_R_LINEOUT_DRV_SFT)
+#define RK3308_DAC_L_LINEOUT_DRV_SFT		0
+#define RK3308_DAC_L_LINEOUT_DRV_MSK		(0xf << RK3308_DAC_L_LINEOUT_DRV_SFT)
+
+/* RK3308_DAC_ANA_CON12 - REG: 0x0470 */
+#define RK3308_DAC_R_HPMIX_SEL_SFT		6
+#define RK3308_DAC_R_HPMIX_SEL_MSK		(0x3 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_LINEIN_I2S		(0x3 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_LINEIN		(0x2 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_I2S			(0x1 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_R_HPMIX_NONE			(0x0 << RK3308_DAC_R_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_SEL_SFT		2
+#define RK3308_DAC_L_HPMIX_SEL_MSK		(0x3 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_LINEIN_I2S		(0x3 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_LINEIN		(0x2 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_I2S			(0x1 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_L_HPMIX_NONE			(0x0 << RK3308_DAC_L_HPMIX_SEL_SFT)
+#define RK3308_DAC_x_HPMIX_GAIN_MIN		0x1 /* 0x0 and 0x3 are reserved */
+#define RK3308_DAC_x_HPMIX_GAIN_MAX		0x2
+#define RK3308_DAC_R_HPMIX_GAIN_SFT		4
+#define RK3308_DAC_R_HPMIX_GAIN_MSK		(0x3 << RK3308_DAC_R_HPMIX_GAIN_SFT)
+#define RK3308_DAC_R_HPMIX_GAIN_0DB		(0x2 << RK3308_DAC_R_HPMIX_GAIN_SFT)
+#define RK3308_DAC_R_HPMIX_GAIN_NDB_6		(0x1 << RK3308_DAC_R_HPMIX_GAIN_SFT)
+#define RK3308_DAC_L_HPMIX_GAIN_SFT		0
+#define RK3308_DAC_L_HPMIX_GAIN_MSK		(0x3 << RK3308_DAC_L_HPMIX_GAIN_SFT)
+#define RK3308_DAC_L_HPMIX_GAIN_0DB		(0x2 << RK3308_DAC_L_HPMIX_GAIN_SFT)
+#define RK3308_DAC_L_HPMIX_GAIN_NDB_6		(0x1 << RK3308_DAC_L_HPMIX_GAIN_SFT)
+
+/* RK3308_DAC_ANA_CON13 - REG: 0x0474 */
+#define RK3308_DAC_R_HPMIX_UNMUTE_SFT		6
+#define RK3308_DAC_R_HPMIX_WORK_SFT		5
+#define RK3308_DAC_R_HPMIX_EN_SFT		4
+#define RK3308_DAC_L_HPMIX_UNMUTE_SFT		2
+#define RK3308_DAC_L_HPMIX_WORK_SFT		1
+#define RK3308_DAC_L_HPMIX_EN_SFT		0
+
+/* RK3308_DAC_ANA_CON14 - REG: 0x0478 */
+#define RK3308_DAC_VCM_LINEOUT_EN		(0x1 << 4)
+#define RK3308_DAC_CURRENT_CHARGE_SFT		0
+#define RK3308_DAC_CURRENT_CHARGE_MSK		(0xf << RK3308_DAC_CURRENT_CHARGE_SFT)
+
+/*
+ * 1: Choose the current I
+ * 0: Don't choose the current I
+ */
+#define RK3308_DAC_SEL_I(x)			((x) & 0xf)
+
+/* RK3308_DAC_ANA_CON15 - REG: 0x047C */
+#define RK3308_DAC_LINEOUT_POP_SOUND_R_SFT	4
+#define RK3308_DAC_LINEOUT_POP_SOUND_R_MSK	(0x3 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_R_SEL_DC_FROM_INTERNAL	(0x2 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_R_SEL_DC_FROM_VCM		(0x1 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_R_SEL_LINEOUT_FROM_INTERNAL	(0x0 << RK3308_DAC_LINEOUT_POP_SOUND_R_SFT)
+#define RK3308_DAC_LINEOUT_POP_SOUND_L_SFT	0
+#define RK3308_DAC_LINEOUT_POP_SOUND_L_MSK	(0x3 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_L_SEL_DC_FROM_INTERNAL	(0x2 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_L_SEL_DC_FROM_VCM		(0x1 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+#define RK3308_DAC_L_SEL_LINEOUT_FROM_INTERNAL	(0x0 << RK3308_DAC_LINEOUT_POP_SOUND_L_SFT)
+
+#define RK3308_HIFI				0x0
+
+#endif /* __RK3308_CODEC_H__ */

-- 
2.34.1


