Return-Path: <linux-kernel+bounces-39588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C584F83D342
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A894B27140
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DADBE5D;
	Fri, 26 Jan 2024 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I0kKexL+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C07AD55;
	Fri, 26 Jan 2024 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706241619; cv=none; b=D3o5CXHgI74fOqLYLjVz/tO9RT0XQJOQ7jqXSDMUSnOb5Qf7oUh2FlQG61i0wd5uYh7/zZRJ/5fynpRAziUhcfYcH1iH90kIB0H+YlQ69hvfE9lBYchQ3K1nA6oHdKyP6VdqWnr9LjzhiCsXLyUDSbkBoZ/gdLlAar2iZa2EG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706241619; c=relaxed/simple;
	bh=WzGx60HK79t0ZbIXjbI3Q1mLcgWLHLnXuPVFtmYoeJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n57OqURO6EkzTBR+4EilmrfIjUQbGbR3vF3fy80D5pgpArkU50N5KAOyFARWiw5pj5/kGPQJUdjSiBatqgVRcoP/l82F+lqHCsy/TkHbbtgfnH/8a6dkx1MwR9SqvgalL+r3csGu1MKPKMNi+ewhdxmybqOna72wWZPqOaqiZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I0kKexL+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40Q3x9rM080815;
	Thu, 25 Jan 2024 21:59:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706241549;
	bh=fs4f9QMSks9LwrlVapru9iSV4Q+VGyuJTJ3ikNL3cB4=;
	h=From:To:CC:Subject:Date;
	b=I0kKexL+0ODDPGYxjyDnmP8i9nCyNhIbVCeOK8+xwOo8UDfJ3A2GsBU708KrYo/yC
	 a7/LperDMsBv8LhdF9o9cqs8UIf8yUSqGeRcz4KfiOdqDehQgcGoXE1YJVez2lHyTh
	 Bat6O6G2zZDb2FRfqkpjXTDPhsPLGlqFJFJ6R3gs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40Q3x9uv069827
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 21:59:09 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 21:59:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 21:59:08 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40Q3wwij025780;
	Thu, 25 Jan 2024 21:58:59 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <v-po@ti.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <jkhuang3@ti.com>, <tiwai@suse.de>, <pdjuandi@ti.com>,
        <j-mcpherson@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2 1/4] ASoc: PCM6240: Create PCM6240 Family driver code
Date: Fri, 26 Jan 2024 11:58:51 +0800
Message-ID: <20240126035855.1785-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PCM6240 driver implements a flexible and configurable setting for register
and filter coefficients, to one, two or even multiple PCM6240 Family Audio
chips.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v2:
 - All these chips have only a portion of the functionality of codec,
   such as ADC or DAC, and so on, but their audio performance is far
   superior to the codec's, and cost is lower than codec, and much easier
   to program than codec.
---
 sound/soc/codecs/pcm6240.c | 2062 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2062 insertions(+)
 create mode 100644 sound/soc/codecs/pcm6240.c

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
new file mode 100644
index 000000000000..d9e4d57dc115
--- /dev/null
+++ b/sound/soc/codecs/pcm6240.c
@@ -0,0 +1,2062 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments PCM6240 Family Audio ADC/DAC/Router
+//
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The PCM6240 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// PCM6240 Family chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+//
+
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "pcm6240.h"
+
+static const struct i2c_device_id pcmdevice_i2c_id[] = {
+	{ "adc3120",  ADC3120  },
+	{ "adc5120",  ADC5120  },
+	{ "adc6120",  ADC6120  },
+	{ "dix4192",  DIX4192  },
+	{ "pcm1690",  PCM1690  },
+	{ "pcm3120",  PCM3120  },
+	{ "pcm3140",  PCM3140  },
+	{ "pcm5120",  PCM5120  },
+	{ "pcm5140",  PCM5140  },
+	{ "pcm6120",  PCM6120  },
+	{ "pcm6140",  PCM6140  },
+	{ "pcm6240",  PCM6240  },
+	{ "pcm6260",  PCM6260  },
+	{ "pcm9211",  PCM9211  },
+	{ "pcmd3140", PCMD3140 },
+	{ "pcmd3180", PCMD3180 },
+	{ "pcmd512x", PCMD512X },
+	{ "taa5212",  TAA5212  },
+	{ "taa5412",  TAA5412  },
+	{ "tad5212",  TAD5212  },
+	{ "tad5412",  TAD5412  },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pcmdevice_i2c_id);
+
+static struct pcmdevice_mixer_control adc5120_analog_gain_ctl[] = {
+	{
+		.shift = 1,
+		.reg = ADC5120_REG_CH1_ANALOG_GAIN,
+		.max = 0x54,
+		.invert = 0,
+	},
+	{
+		.shift = 1,
+		.reg = ADC5120_REG_CH2_ANALOG_GAIN,
+		.max = 0x54,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control adc5120_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = ADC5120_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = ADC5120_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcm1690_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH3_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH4_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH5_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH6_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH7_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM1690_REG_CH8_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcm6240_analog_gain_ctl[] = {
+	{
+		.shift = 2,
+		.reg = PCM6240_REG_CH1_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6240_REG_CH2_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6240_REG_CH3_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6240_REG_CH4_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcm6240_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = PCM6240_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6240_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6240_REG_CH3_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6240_REG_CH4_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcm6260_analog_gain_ctl[] = {
+	{
+		.shift = 2,
+		.reg = PCM6260_REG_CH1_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6260_REG_CH2_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6260_REG_CH3_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6260_REG_CH4_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6260_REG_CH5_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	},
+	{
+		.shift = 2,
+		.reg = PCM6260_REG_CH6_ANALOG_GAIN,
+		.max = 0x42,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcm6260_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = PCM6260_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6260_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6260_REG_CH3_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6260_REG_CH4_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6260_REG_CH5_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM6260_REG_CH6_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcm9211_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = PCM9211_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCM9211_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcmd3140_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = PCMD3140_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3140_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3140_REG_CH3_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3140_REG_CH4_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control pcmd3180_digital_gain_ctl[] = {
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH1_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH2_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH3_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH4_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH5_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH6_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH7_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = PCMD3180_REG_CH8_DIGITAL_GAIN,
+		.max = 0xff,
+		.invert = 0,
+	}
+};
+
+static struct pcmdevice_mixer_control taa5412_digital_volume_ctl[] = {
+	{
+		.shift = 0,
+		.reg = TAA5412_REG_CH1_DIGITAL_VOLUME,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = TAA5412_REG_CH2_DIGITAL_VOLUME,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = TAA5412_REG_CH3_DIGITAL_VOLUME,
+		.max = 0xff,
+		.invert = 0,
+	},
+	{
+		.shift = 0,
+		.reg = TAA5412_REG_CH4_DIGITAL_VOLUME,
+		.max = 0xff,
+		.invert = 0,
+	},
+};
+
+static struct pcmdevice_mixer_control taa5412_fine_gain_ctl[] = {
+	{
+		.shift = 4,
+		.reg = TAA5412_REG_CH1_FINE_GAIN,
+		.max = 0xf,
+		.invert = 0,
+	},
+	{
+		.shift = 4,
+		.reg = TAA5412_REG_CH2_FINE_GAIN,
+		.max = 0xf,
+		.invert = 0,
+	},
+	{
+		.shift = 4,
+		.reg = TAA5412_REG_CH3_FINE_GAIN,
+		.max = 0xf,
+		.invert = 4,
+	},
+	{
+		.shift = 0,
+		.reg = TAA5412_REG_CH4_FINE_GAIN,
+		.max = 0xf,
+		.invert = 4,
+	},
+};
+
+static const DECLARE_TLV_DB_MINMAX_MUTE(pcmd3180_dig_gain_tlv,
+	-10000, 2700);
+static const DECLARE_TLV_DB_MINMAX_MUTE(pcmd3140_dig_gain_tlv,
+	-10000, 2700);
+static const DECLARE_TLV_DB_MINMAX_MUTE(pcm1690_fine_dig_gain_tlv,
+	-12750, 0);
+static const DECLARE_TLV_DB_MINMAX_MUTE(pcm1690_dig_gain_tlv,
+	-25500, 0);
+static const DECLARE_TLV_DB_MINMAX_MUTE(pcm9211_dig_gain_tlv,
+	-11450, 2000);
+static const DECLARE_TLV_DB_MINMAX_MUTE(adc5120_fgain_tlv,
+	-10050, 2700);
+static const DECLARE_TLV_DB_LINEAR(adc5120_chgain_tlv, 0, 4200);
+static const DECLARE_TLV_DB_MINMAX_MUTE(pcm6260_fgain_tlv,
+	-10000, 2700);
+static const DECLARE_TLV_DB_LINEAR(pcm6260_chgain_tlv, 0, 4200);
+static const DECLARE_TLV_DB_MINMAX_MUTE(taa5412_dig_vol_tlv,
+	-8050, 4700);
+static const DECLARE_TLV_DB_LINEAR(taa5412_fine_gain_tlv,
+	-80, 70);
+
+static int pcmdev_change_dev(struct pcmdevice_priv *pcm_priv,
+	unsigned short dev_no)
+{
+	struct i2c_client *client = (struct i2c_client *)pcm_priv->client;
+	struct regmap *map = pcm_priv->regmap;
+	int ret = 0;
+
+	if (client->addr != pcm_priv->addr[dev_no]) {
+		client->addr = pcm_priv->addr[dev_no];
+		/* All pcmdevices share the same regmap, clear the page
+		 * inside regmap once switching to another pcmdevice.
+		 * Register 0 at any pages inside pcmdevice is the same
+		 * one for page-switching.
+		 */
+		ret = regmap_write(map, PCMDEVICE_PAGE_SELECT, 0);
+		if (ret < 0)
+			dev_err(pcm_priv->dev, "%s, E=%d\n", __func__, ret);
+	}
+
+	return ret;
+}
+
+static int pcmdev_dev_read(struct pcmdevice_priv *pcm_dev,
+	unsigned int dev_no, unsigned int reg, unsigned int *val)
+{
+	int ret = -EINVAL;
+
+	if (dev_no < pcm_dev->ndev) {
+		struct regmap *map = pcm_dev->regmap;
+
+		ret = pcmdev_change_dev(pcm_dev, dev_no);
+		if (ret < 0) {
+			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
+			goto out;
+		}
+
+		ret = regmap_read(map, reg, val);
+		if (ret < 0)
+			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else
+		dev_err(pcm_dev->dev, "%s, no such channel(%d)\n", __func__,
+			dev_no);
+
+
+out:
+	return ret;
+}
+
+static int pcmdev_dev_bulk_write(struct pcmdevice_priv *pcm_dev,
+	unsigned int dev_no, unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = -EINVAL;
+
+	if (dev_no < pcm_dev->ndev) {
+		struct regmap *map = pcm_dev->regmap;
+
+		ret = pcmdev_change_dev(pcm_dev, dev_no);
+		if (ret < 0) {
+			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
+			goto out;
+		}
+
+		ret = regmap_bulk_write(map, reg, data, len);
+		if (ret < 0)
+			dev_err(pcm_dev->dev, "bulk_write ERROR, E=%d\n",
+				ret);
+	} else
+		dev_err(pcm_dev->dev, "%s, ERROR: no such channel(%d)\n",
+			__func__, dev_no);
+
+out:
+	return ret;
+}
+
+static int pcmdev_dev_update_bits(struct pcmdevice_priv *pcm_dev,
+	unsigned int dev_no, unsigned int reg, unsigned int mask,
+	unsigned int value)
+{
+	struct regmap *map = pcm_dev->regmap;
+	int ret =  -EINVAL;
+
+	if (dev_no < pcm_dev->ndev) {
+		ret = pcmdev_change_dev(pcm_dev, dev_no);
+		if (ret < 0) {
+			dev_err(pcm_dev->dev, "%s, E=%d\n",
+				__func__, ret);
+			goto out;
+		}
+
+		ret = regmap_update_bits(map, reg, mask, value);
+		if (ret < 0)
+			dev_err(pcm_dev->dev, "update_bits ERROR, E=%d\n",
+				ret);
+	} else
+		dev_err(pcm_dev->dev, "%s, ERROR: no such device(%d)\n",
+			__func__, dev_no);
+
+out:
+	return ret;
+}
+
+static int pcmdev_dev_write(struct pcmdevice_priv *pcm_dev,
+	unsigned int dev_no, unsigned int reg, unsigned int value)
+{
+	struct regmap *map = pcm_dev->regmap;
+	int ret = 0;
+
+	if (dev_no < pcm_dev->ndev) {
+		ret = pcmdev_change_dev(pcm_dev, dev_no);
+		if (ret < 0) {
+			dev_err(pcm_dev->dev, "%s, E=%d\n",
+				__func__, ret);
+			goto out;
+		}
+
+		ret = regmap_write(map, reg, value);
+		if (ret < 0)
+			dev_err(pcm_dev->dev, "%s, E=%d\n", __func__, ret);
+	} else
+		dev_err(pcm_dev->dev, "%s, ERROR: no such device(%d)\n",
+			__func__, dev_no);
+
+out:
+	return ret;
+}
+
+static int pcmdevice_info_profile(
+	struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(codec);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = max(0, pcm_dev->regbin.ncfgs - 1);
+
+	return 0;
+}
+
+static int pcmdevice_get_profile_id(
+	struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = pcm_dev->cur_conf;
+
+	return 0;
+}
+
+static int pcmdevice_set_profile_id(
+	struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec
+		= snd_soc_kcontrol_component(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(codec);
+	int ret = 0;
+
+	if (pcm_dev->cur_conf != ucontrol->value.integer.value[0]) {
+		pcm_dev->cur_conf = ucontrol->value.integer.value[0];
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int pcmdevice_info_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = mc->max;
+	return 0;
+}
+
+static int pcmdevice_get_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(component);
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int dev_no = mc->dev_no;
+	int max = mc->max;
+	int rc = 0;
+	unsigned int val;
+	unsigned int shift = mc->shift;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+
+	mutex_lock(&pcm_dev->codec_lock);
+	rc = pcmdev_dev_read(pcm_dev, dev_no, reg, &val);
+	if (rc) {
+		dev_err(pcm_dev->dev, "%s:read, ERROR, E=%d\n",
+			__func__, rc);
+		goto out;
+	}
+
+	val = (val >> shift) & mask;
+	val = (val > max) ? max : val;
+	val = mc->invert ? max - val : val;
+	ucontrol->value.integer.value[0] = val;
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return rc;
+}
+
+static int pcmdevice_put_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(component);
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+	int err = 0;
+	unsigned int reg = mc->reg;
+	unsigned int dev_no = mc->dev_no;
+	int max = mc->max;
+	unsigned int val, val_mask;
+	unsigned int shift = mc->shift;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	val = ucontrol->value.integer.value[0] & mask;
+	val = (val > max) ? max : val;
+	val = mc->invert ? max - val : val;
+	val_mask = mask << shift;
+	val = val << shift;
+	err = pcmdev_dev_update_bits(pcm_dev, dev_no, reg, val_mask,
+		val);
+	if (err) {
+		dev_err(pcm_dev->dev, "%s:update_bits, ERROR, E=%d\n",
+			__func__, err);
+		goto out;
+	}
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return err;
+}
+
+static int pcm1690_get_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(component);
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int dev_no = mc->dev_no;
+	int max = mc->max;
+	int rc = 0;
+	unsigned int val;
+	unsigned int shift = mc->shift;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	rc = pcmdev_dev_read(pcm_dev, dev_no, PCM1690_REG_MODE_CTRL,
+		&val);
+	if (rc) {
+		dev_err(pcm_dev->dev, "%s:read mode, ERROR, E=%d\n",
+			__func__, rc);
+		goto out;
+	}
+	if (!(val & PCM1690_REG_MODE_CTRL_DAMS_MSK)) {
+		dev_info(pcm_dev->dev,
+			"%s: set to wide-range mode, before using this ctrl\n",
+			__func__);
+		ucontrol->value.integer.value[0] = -25500;
+		goto out;
+	}
+	rc = pcmdev_dev_read(pcm_dev, dev_no, reg, &val);
+	if (rc) {
+		dev_err(pcm_dev->dev, "%s:read, ERROR, E=%d\n",
+			__func__, rc);
+		goto out;
+	}
+
+	val = (val >> shift) & mask;
+	val = (val > max) ? max : val;
+	val = mc->invert ? max - val : val;
+	ucontrol->value.integer.value[0] = val;
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return rc;
+}
+
+static int pcm1690_put_volsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(component);
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+	int err = 0;
+	unsigned int reg = mc->reg;
+	unsigned int dev_no = mc->dev_no;
+	int max = mc->max;
+	unsigned int val, val_mask;
+	unsigned int shift = mc->shift;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	val = ucontrol->value.integer.value[0] & mask;
+	val = (val > max) ? max : val;
+	val = mc->invert ? max - val : val;
+	val_mask = mask << shift;
+	val = val << shift;
+	err = pcmdev_dev_update_bits(pcm_dev, dev_no, reg,
+		PCM1690_REG_MODE_CTRL_DAMS_MSK | val_mask,
+		PCM1690_REG_MODE_CTRL_DAMS_WIDE_RANGE | val);
+	if (err) {
+		dev_err(pcm_dev->dev, "%s:update_bits, ERROR, E=%d\n",
+			__func__, err);
+		goto out;
+	}
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return err;
+}
+
+static int pcm1690_get_finevolsw(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(component);
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+	unsigned int reg = mc->reg;
+	unsigned int dev_no = mc->dev_no;
+	int max = mc->max;
+	int rc = 0;
+	unsigned int val;
+	unsigned int shift = mc->shift;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	rc = pcmdev_dev_read(pcm_dev, dev_no, PCM1690_REG_MODE_CTRL,
+		&val);
+	if (rc) {
+		dev_err(pcm_dev->dev, "%s:read mode, ERROR, E=%d\n",
+			__func__, rc);
+		goto out;
+	}
+	if (val & PCM1690_REG_MODE_CTRL_DAMS_MSK) {
+		dev_info(pcm_dev->dev,
+			"%s: Set to fine mode, before using this ctrl\n",
+			__func__);
+		ucontrol->value.integer.value[0] = -12750;
+		goto out;
+	}
+	rc = pcmdev_dev_read(pcm_dev, dev_no, reg, &val);
+	if (rc) {
+		dev_err(pcm_dev->dev, "%s:read, ERROR, E=%d\n",
+			__func__, rc);
+		goto out;
+	}
+
+	val = (val >> shift) & mask;
+	val = (val > max) ? max : val;
+	val = mc->invert ? max - val : val;
+	ucontrol->value.integer.value[0] = val;
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return rc;
+}
+
+static int pcm1690_put_finevolsw(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct pcmdevice_priv *pcm_dev =
+		snd_soc_component_get_drvdata(component);
+	struct pcmdevice_mixer_control *mc =
+		(struct pcmdevice_mixer_control *)kcontrol->private_value;
+	int err = 0;
+	unsigned int reg = mc->reg;
+	unsigned int dev_no = mc->dev_no;
+	int max = mc->max;
+	unsigned int val, val_mask;
+	unsigned int shift = mc->shift;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	val = ucontrol->value.integer.value[0] & mask;
+	val = (val > max) ? max : val;
+	val = mc->invert ? max - val : val;
+	val_mask = mask << shift;
+	val = val << shift;
+	err = pcmdev_dev_update_bits(pcm_dev, dev_no, reg,
+		PCM1690_REG_MODE_CTRL_DAMS_MSK | val_mask,
+		PCM1690_REG_MODE_CTRL_DAMS_FINE_STEP | val);
+	if (err) {
+		dev_err(pcm_dev->dev, "%s:update_bits, ERROR, E=%d\n",
+			__func__, err);
+		goto out;
+	}
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return err;
+}
+
+static int pcm1690_ctrl_add(struct pcmdevice_priv *pcm_dev)
+{
+	struct i2c_adapter *adap = pcm_dev->client->adapter;
+	struct pcmdev_ctrl_info fine_dig_ctl_info = {0};
+	struct pcmdev_ctrl_info dig_ctl_info = {0};
+	struct snd_kcontrol_new *pcmdev_controls;
+	int nr_controls = 1, ret = 0, mix_index = 0, i, chn;
+	char *name;
+
+	dig_ctl_info.gain = pcm1690_dig_gain_tlv;
+	dig_ctl_info.pcmdev_ctrl = pcm1690_digital_gain_ctl;
+	dig_ctl_info.ctrl_array_size =
+		ARRAY_SIZE(pcm1690_digital_gain_ctl);
+
+	fine_dig_ctl_info.gain = pcm1690_fine_dig_gain_tlv;
+	fine_dig_ctl_info.pcmdev_ctrl = pcm1690_digital_gain_ctl;
+	fine_dig_ctl_info.ctrl_array_size =
+		ARRAY_SIZE(pcm1690_digital_gain_ctl);
+	nr_controls += pcm_dev->ndev * (dig_ctl_info.ctrl_array_size +
+		fine_dig_ctl_info.ctrl_array_size);
+
+	pcmdev_controls = devm_kzalloc(pcm_dev->dev,
+		nr_controls * sizeof(*pcmdev_controls),
+		GFP_KERNEL);
+	if (!pcmdev_controls) {
+		pcm_dev->pcm_ctrl.pcmdevice_profile_controls = NULL;
+		ret = -ENOMEM;
+		goto out;
+	}
+	pcm_dev->pcm_ctrl.pcmdevice_profile_controls = pcmdev_controls;
+	/* Create a mixer item for selecting the active profile */
+	name = devm_kzalloc(pcm_dev->dev,
+		SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "PCMDEVICE Profile id");
+	pcmdev_controls[mix_index].name = name;
+	pcmdev_controls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	pcmdev_controls[mix_index].info = pcmdevice_info_profile;
+	pcmdev_controls[mix_index].get = pcmdevice_get_profile_id;
+	pcmdev_controls[mix_index].put = pcmdevice_set_profile_id;
+	mix_index++;
+
+	for (i = 0; i < pcm_dev->ndev; i++) {
+		if (mix_index >= nr_controls) {
+			dev_dbg(pcm_dev->dev,
+				"%s: mix_index: %d nr_controls: %d\n",
+				__func__, mix_index, nr_controls);
+			break;
+		}
+		for (chn = 1; chn <= dig_ctl_info.ctrl_array_size;
+			chn++) {
+			if (mix_index >= nr_controls) {
+				dev_dbg(pcm_dev->dev,
+					"%s: mix_idx = %d nr_controls = %d\n",
+					__func__, mix_index,
+					nr_controls);
+				break;
+			}
+			name = devm_kzalloc(pcm_dev->dev,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+			if (!name) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s-i2c-%d-dev%d-ch%d-digi-gain",
+				pcm_dev->dev_name, adap->nr, i, chn);
+			pcmdev_controls[mix_index].tlv.p = dig_ctl_info.gain;
+			dig_ctl_info.pcmdev_ctrl[chn - 1].dev_no = i;
+			pcmdev_controls[mix_index].private_value =
+				(unsigned long)
+				&dig_ctl_info.pcmdev_ctrl[chn - 1];
+			pcmdev_controls[mix_index].name = name;
+			pcmdev_controls[mix_index].access =
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				SNDRV_CTL_ELEM_ACCESS_READWRITE;
+			pcmdev_controls[mix_index].iface =
+				SNDRV_CTL_ELEM_IFACE_MIXER;
+			pcmdev_controls[mix_index].info = pcmdevice_info_volsw;
+			pcmdev_controls[mix_index].get = pcm1690_get_volsw;
+			pcmdev_controls[mix_index].put = pcm1690_put_volsw;
+			mix_index++;
+		}
+	}
+
+	for (i = 0; i < pcm_dev->ndev; i++) {
+		if (mix_index >= nr_controls) {
+			dev_dbg(pcm_dev->dev,
+				"%s: mix_index = %d nr_controls = %d\n",
+				__func__, mix_index, nr_controls);
+			break;
+		}
+		for (chn = 1; chn <= fine_dig_ctl_info.ctrl_array_size;
+			chn++) {
+			if (mix_index >= nr_controls) {
+				dev_dbg(pcm_dev->dev,
+					"%s: mix_idx = %d nr_controls = %d\n",
+					__func__, mix_index, nr_controls);
+				break;
+			}
+			name = devm_kzalloc(pcm_dev->dev,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+			if (!name) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s-i2c-%d-dev%d-ch%d-fine-digi-gain",
+				pcm_dev->dev_name, adap->nr, i, chn);
+			pcmdev_controls[mix_index].tlv.p =
+				fine_dig_ctl_info.gain;
+			fine_dig_ctl_info.pcmdev_ctrl[chn - 1].dev_no = i;
+			pcmdev_controls[mix_index].private_value =
+				(unsigned long)
+				&fine_dig_ctl_info.pcmdev_ctrl[chn - 1];
+			pcmdev_controls[mix_index].name = name;
+			pcmdev_controls[mix_index].access =
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				SNDRV_CTL_ELEM_ACCESS_READWRITE;
+			pcmdev_controls[mix_index].iface =
+				SNDRV_CTL_ELEM_IFACE_MIXER;
+			pcmdev_controls[mix_index].info = pcmdevice_info_volsw;
+			pcmdev_controls[mix_index].get =
+				pcm1690_get_finevolsw;
+			pcmdev_controls[mix_index].put =
+				pcm1690_put_finevolsw;
+			mix_index++;
+		}
+	}
+
+	ret = snd_soc_add_component_controls(pcm_dev->component,
+		pcmdev_controls,
+		nr_controls < mix_index ? nr_controls : mix_index);
+	if (ret) {
+		dev_err(pcm_dev->dev,
+			"%s: add_component_controls error = %d\n",
+			__func__, ret);
+		goto out;
+	}
+	pcm_dev->pcm_ctrl.nr_controls =
+		nr_controls < mix_index ? nr_controls : mix_index;
+out:
+	return ret;
+}
+
+static void pcm9211_sw_rst(struct pcmdevice_priv *pcm_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < pcm_dev->ndev; i++) {
+		ret = pcmdev_dev_update_bits(pcm_dev, i,
+			PCM9211_REG_SW_CTRL, PCM9211_REG_SW_CTRL_MRST_MSK,
+			PCM9211_REG_SW_CTRL_MRST);
+		if (ret < 0)
+			dev_err(pcm_dev->dev, "%s: dev %d swreset fail, %d\n",
+				__func__, i, ret);
+	}
+}
+
+static void pcmdevice_sw_rst(struct pcmdevice_priv *pcm_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < pcm_dev->ndev; i++) {
+		ret = pcmdev_dev_write(pcm_dev, i, PCMDEVICE_REG_SWRESET,
+			PCMDEVICE_REG_SWRESET_RESET);
+		if (ret < 0)
+			dev_err(pcm_dev->dev, "%s: dev %d swreset fail, %d\n",
+				__func__, i, ret);
+	}
+}
+
+static struct pcmdevice_config_info *pcmdevice_add_config(void *ctxt,
+	const unsigned char *config_data, unsigned int config_size,
+	int *status)
+{
+	struct pcmdevice_priv *pcm_dev = (struct pcmdevice_priv *)ctxt;
+	struct pcmdevice_config_info *cfg_info;
+	struct pcmdevice_block_data **bk_da;
+	unsigned int config_offset = 0, i;
+
+	cfg_info = kzalloc(sizeof(struct pcmdevice_config_info), GFP_KERNEL);
+	if (!cfg_info) {
+		*status = -ENOMEM;
+		dev_err(pcm_dev->dev, "add config: cfg_info alloc failed!\n");
+		goto out;
+	}
+
+	if (pcm_dev->regbin.fw_hdr.binary_version_num >= 0x105) {
+		if (config_offset + 64 > (int)config_size) {
+			*status = -EINVAL;
+			dev_err(pcm_dev->dev, "add config: Out of boundary\n");
+			goto out;
+		}
+		memcpy(cfg_info->cfg_name, &config_data[config_offset], 64);
+		config_offset += 64;
+	}
+
+	if (config_offset + 4 > config_size) {
+		*status = -EINVAL;
+		dev_err(pcm_dev->dev, "add config: Out of boundary\n");
+		goto out;
+	}
+	cfg_info->nblocks =
+		be32_to_cpup((__be32 *)&config_data[config_offset]);
+	config_offset += 4;
+
+	bk_da = cfg_info->blk_data = kcalloc(cfg_info->nblocks,
+		sizeof(struct pcmdevice_block_data *), GFP_KERNEL);
+	if (!bk_da) {
+		*status = -ENOMEM;
+		goto out;
+	}
+	cfg_info->real_nblocks = 0;
+	for (i = 0; i < cfg_info->nblocks; i++) {
+		if (config_offset + 12 > config_size) {
+			*status = -EINVAL;
+			dev_err(pcm_dev->dev,
+				"%s: Out of boundary: i = %d nblocks = %u!\n",
+				__func__, i, cfg_info->nblocks);
+			break;
+		}
+		bk_da[i] = kzalloc(sizeof(struct pcmdevice_block_data),
+			GFP_KERNEL);
+		if (!bk_da[i]) {
+			*status = -ENOMEM;
+			break;
+		}
+		bk_da[i]->dev_idx = config_data[config_offset];
+		config_offset++;
+
+		bk_da[i]->block_type = config_data[config_offset];
+		config_offset++;
+
+		if (bk_da[i]->block_type == PCMDEVICE_BIN_BLK_PRE_POWER_UP) {
+			if (bk_da[i]->dev_idx == 0)
+				cfg_info->active_dev =
+					(1 << pcm_dev->ndev) - 1;
+			else
+				cfg_info->active_dev =
+					1 << (bk_da[i]->dev_idx - 1);
+		}
+
+		bk_da[i]->yram_checksum =
+			be16_to_cpup((__be16 *)&config_data[config_offset]);
+		config_offset += 2;
+		bk_da[i]->block_size =
+			be32_to_cpup((__be32 *)&config_data[config_offset]);
+		config_offset += 4;
+
+		bk_da[i]->n_subblks =
+			be32_to_cpup((__be32 *)&config_data[config_offset]);
+
+		config_offset += 4;
+
+		if (config_offset + bk_da[i]->block_size > config_size) {
+			*status = -EINVAL;
+			dev_err(pcm_dev->dev,
+				"%s: Out of boundary: i = %d blks = %u!\n",
+				__func__, i, cfg_info->nblocks);
+			break;
+		}
+
+		bk_da[i]->regdata = kmemdup(&config_data[config_offset],
+			bk_da[i]->block_size, GFP_KERNEL);
+		if (!bk_da[i]->regdata) {
+			*status = -ENOMEM;
+			goto out;
+		}
+		config_offset += bk_da[i]->block_size;
+		cfg_info->real_nblocks += 1;
+	}
+out:
+	return cfg_info;
+}
+
+static int pcmdev_ctrl_add(struct pcmdevice_priv *pcm_dev)
+{
+	struct i2c_adapter *adap = pcm_dev->client->adapter;
+	struct pcmdev_ctrl_info analog_ctl_info = {0};
+	struct pcmdev_ctrl_info dig_ctl_info = {0};
+	struct snd_kcontrol_new *pcmdev_controls;
+	int nr_controls = 1, ret = 0;
+	int mix_index = 0, dev, chn;
+	char *name;
+
+	switch (pcm_dev->chip_id) {
+	case ADC3120:
+	case ADC5120:
+	case ADC6120:
+	case PCM3120:
+	case PCM5120:
+	case PCM6120:
+		dig_ctl_info.gain = adc5120_fgain_tlv;
+		analog_ctl_info.gain = adc5120_chgain_tlv;
+		analog_ctl_info.pcmdev_ctrl = adc5120_analog_gain_ctl;
+		analog_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(adc5120_analog_gain_ctl);
+		dig_ctl_info.pcmdev_ctrl = adc5120_digital_gain_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(adc5120_digital_gain_ctl);
+		break;
+	case PCM3140:
+	case PCM5140:
+	case PCM6140:
+	case PCM6240:
+		dig_ctl_info.gain = pcm6260_fgain_tlv;
+		analog_ctl_info.gain = pcm6260_chgain_tlv;
+		analog_ctl_info.pcmdev_ctrl = pcm6240_analog_gain_ctl;
+		analog_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcm6240_analog_gain_ctl);
+		dig_ctl_info.pcmdev_ctrl = pcm6240_digital_gain_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcm6240_digital_gain_ctl);
+		break;
+	case PCM6260:
+		dig_ctl_info.gain = pcm6260_fgain_tlv;
+		analog_ctl_info.gain = pcm6260_chgain_tlv;
+		analog_ctl_info.pcmdev_ctrl = pcm6260_analog_gain_ctl;
+		analog_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcm6260_analog_gain_ctl);
+		dig_ctl_info.pcmdev_ctrl = pcm6260_digital_gain_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcm6260_digital_gain_ctl);
+		break;
+	case PCM9211:
+		dig_ctl_info.gain = pcm9211_dig_gain_tlv;
+		dig_ctl_info.pcmdev_ctrl = pcm9211_digital_gain_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcm9211_digital_gain_ctl);
+		break;
+	case PCMD3140:
+		dig_ctl_info.gain = pcmd3140_dig_gain_tlv;
+		dig_ctl_info.pcmdev_ctrl = pcmd3140_digital_gain_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcmd3140_digital_gain_ctl);
+		break;
+	case PCMD3180:
+		dig_ctl_info.gain = pcmd3180_dig_gain_tlv;
+		dig_ctl_info.pcmdev_ctrl = pcmd3180_digital_gain_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(pcmd3180_digital_gain_ctl);
+		break;
+	case TAA5212:
+	case TAA5412:
+		analog_ctl_info.gain = taa5412_fine_gain_tlv;
+		analog_ctl_info.pcmdev_ctrl = taa5412_fine_gain_ctl;
+		analog_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(taa5412_fine_gain_ctl);
+		dig_ctl_info.gain = taa5412_dig_vol_tlv;
+		dig_ctl_info.pcmdev_ctrl = taa5412_digital_volume_ctl;
+		dig_ctl_info.ctrl_array_size =
+			ARRAY_SIZE(taa5412_digital_volume_ctl);
+		break;
+	}
+
+	nr_controls += pcm_dev->ndev * (dig_ctl_info.ctrl_array_size +
+		analog_ctl_info.ctrl_array_size);
+	pcmdev_controls = devm_kzalloc(pcm_dev->dev,
+		nr_controls * sizeof(struct snd_kcontrol_new),
+		GFP_KERNEL);
+	if (!pcmdev_controls) {
+		ret = -ENOMEM;
+		pcm_dev->pcm_ctrl.pcmdevice_profile_controls = NULL;
+		goto out;
+	}
+	pcm_dev->pcm_ctrl.pcmdevice_profile_controls = pcmdev_controls;
+	/* Create a mixer item for selecting the active profile */
+	name = devm_kzalloc(pcm_dev->dev, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+		GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "PCMDEVICE Profile id");
+	pcmdev_controls[mix_index].name = name;
+	pcmdev_controls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	pcmdev_controls[mix_index].info = pcmdevice_info_profile;
+	pcmdev_controls[mix_index].get = pcmdevice_get_profile_id;
+	pcmdev_controls[mix_index].put = pcmdevice_set_profile_id;
+	mix_index++;
+
+	if (analog_ctl_info.ctrl_array_size == 0)
+		goto dig_ctrl;
+
+	for (dev = 0; dev < pcm_dev->ndev; dev++) {
+		if (mix_index >= nr_controls) {
+			dev_dbg(pcm_dev->dev, "mix_idx: %d nr_controls = %d\n",
+				mix_index, nr_controls);
+			break;
+		}
+		for (chn = 1; chn <= analog_ctl_info.ctrl_array_size;
+			chn++) {
+			if (mix_index >= nr_controls) {
+				dev_dbg(pcm_dev->dev,
+					"%s: mix_idx = %d nr_controls = %d\n",
+					__func__, mix_index,
+					nr_controls);
+				break;
+			}
+			name = devm_kzalloc(pcm_dev->dev,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+			if (!name) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				(pcm_dev->chip_id != TAA5412) ?
+				"%s-i2c-%d-dev%d-ch%d-ana-gain" :
+				"%s-i2c-%d-dev%d-ch%d-fine-gain",
+				pcm_dev->dev_name, adap->nr, dev, chn);
+			pcmdev_controls[mix_index].tlv.p =
+				analog_ctl_info.gain;
+			analog_ctl_info.pcmdev_ctrl[chn - 1].dev_no = dev;
+			pcmdev_controls[mix_index].private_value =
+				(unsigned long)
+				&analog_ctl_info.pcmdev_ctrl[chn - 1];
+			pcmdev_controls[mix_index].name = name;
+			pcmdev_controls[mix_index].access =
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				SNDRV_CTL_ELEM_ACCESS_READWRITE;
+			pcmdev_controls[mix_index].iface =
+				SNDRV_CTL_ELEM_IFACE_MIXER;
+			pcmdev_controls[mix_index].info = pcmdevice_info_volsw;
+			pcmdev_controls[mix_index].get = pcmdevice_get_volsw;
+			pcmdev_controls[mix_index].put = pcmdevice_put_volsw;
+			mix_index++;
+		}
+	}
+
+dig_ctrl:
+	if (dig_ctl_info.ctrl_array_size == 0)
+		goto add_ctrls;
+
+	for (dev = 0; dev < pcm_dev->ndev; dev++) {
+		if (mix_index >= nr_controls) {
+			dev_dbg(pcm_dev->dev, "%s: mix_idx: %d nr_ctrls: %d\n",
+				__func__, mix_index, nr_controls);
+			break;
+		}
+		for (chn = 1; chn <= dig_ctl_info.ctrl_array_size; chn++) {
+			if (mix_index >= nr_controls) {
+				dev_dbg(pcm_dev->dev,
+					"%s: mix_idx: %d nr_ctrls: %d\n",
+					__func__, mix_index, nr_controls);
+				break;
+			}
+			name = devm_kzalloc(pcm_dev->dev,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN, GFP_KERNEL);
+			if (!name) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s-i2c-%d-dev%d-ch%d-digi-gain",
+				pcm_dev->dev_name, adap->nr, dev, chn);
+			pcmdev_controls[mix_index].tlv.p = dig_ctl_info.gain;
+			dig_ctl_info.pcmdev_ctrl[chn - 1].dev_no = dev;
+			pcmdev_controls[mix_index].private_value =
+					(unsigned long)
+					&dig_ctl_info.pcmdev_ctrl[chn - 1];
+			pcmdev_controls[mix_index].name = name;
+			pcmdev_controls[mix_index].access =
+				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				SNDRV_CTL_ELEM_ACCESS_READWRITE;
+			pcmdev_controls[mix_index].iface =
+				SNDRV_CTL_ELEM_IFACE_MIXER;
+			pcmdev_controls[mix_index].info = pcmdevice_info_volsw;
+			pcmdev_controls[mix_index].get = pcmdevice_get_volsw;
+			pcmdev_controls[mix_index].put = pcmdevice_put_volsw;
+			mix_index++;
+		}
+	}
+
+add_ctrls:
+	ret = snd_soc_add_component_controls(pcm_dev->component,
+		pcmdev_controls,
+		nr_controls < mix_index ? nr_controls : mix_index);
+	if (ret) {
+		dev_err(pcm_dev->dev, "%s: add_controls error = %d\n",
+			__func__, ret);
+		goto out;
+	}
+	pcm_dev->pcm_ctrl.nr_controls =
+		nr_controls < mix_index ? nr_controls : mix_index;
+out:
+	return ret;
+}
+
+static int pcmdevice_create_controls(struct pcmdevice_priv *pcm_dev)
+{
+	int ret;
+
+	if (pcm_dev->chip_id == PCM1690)
+		ret = pcm1690_ctrl_add(pcm_dev);
+	else
+		ret = pcmdev_ctrl_add(pcm_dev);
+
+	return ret;
+}
+
+static void pcmdevice_config_info_remove(void *pContext)
+{
+	struct pcmdevice_priv *pcm_dev = (struct pcmdevice_priv *) pContext;
+	struct pcmdevice_regbin *regbin = &(pcm_dev->regbin);
+	struct pcmdevice_config_info **cfg_info = regbin->cfg_info;
+	int i, j;
+
+	if (!cfg_info)
+		return;
+	for (i = 0; i < regbin->ncfgs; i++) {
+		if (!cfg_info[i])
+			continue;
+		if (cfg_info[i]->blk_data) {
+			for (j = 0; j < (int)cfg_info[i]->real_nblocks; j++) {
+				if (!cfg_info[i]->blk_data[j])
+					continue;
+				kfree(cfg_info[i]->blk_data[j]->regdata);
+				kfree(cfg_info[i]->blk_data[j]);
+			}
+			kfree(cfg_info[i]->blk_data);
+		}
+		kfree(cfg_info[i]);
+	}
+	kfree(cfg_info);
+}
+
+static void pcmdev_regbin_ready(const struct firmware *fmw, void *ctxt)
+{
+	struct pcmdevice_config_info **cfg_info;
+	struct pcmdevice_priv *pcm_dev = ctxt;
+	struct pcmdevice_regbin_hdr *fw_hdr;
+	struct pcmdevice_regbin *regbin;
+	unsigned int total_config_sz = 0;
+	int offset = 0, ret = 0, i;
+	unsigned char *buf;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	regbin = &(pcm_dev->regbin);
+	fw_hdr = &(regbin->fw_hdr);
+	if (!fmw || !fmw->data) {
+		dev_err(pcm_dev->dev, "Failed to read %s\n",
+			pcm_dev->regbin_name);
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+	buf = (unsigned char *)fmw->data;
+
+	fw_hdr->img_sz = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+	if (fw_hdr->img_sz != fmw->size) {
+		dev_err(pcm_dev->dev, "File size not match, %d %u",
+			(int)fmw->size, fw_hdr->img_sz);
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+
+	fw_hdr->checksum = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+	fw_hdr->binary_version_num = be32_to_cpup((__be32 *)&buf[offset]);
+	if (fw_hdr->binary_version_num < 0x103) {
+		dev_err(pcm_dev->dev, "Bin version 0x%04x is out of date",
+			fw_hdr->binary_version_num);
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+	offset += 4;
+	fw_hdr->drv_fw_version = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 8;
+	fw_hdr->plat_type = buf[offset];
+	offset += 1;
+	fw_hdr->dev_family = buf[offset];
+	offset += 1;
+	fw_hdr->reserve = buf[offset];
+	offset += 1;
+	fw_hdr->ndev = buf[offset];
+	offset += 1;
+	if (fw_hdr->ndev != pcm_dev->ndev) {
+		dev_err(pcm_dev->dev, "Invalid ndev(%u)\n", fw_hdr->ndev);
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+
+	if (offset + PCMDEVICE_DEVICE_SUM > fw_hdr->img_sz) {
+		dev_err(pcm_dev->dev, "regbin_ready: Out of boundary!\n");
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+
+	for (i = 0; i < PCMDEVICE_DEVICE_SUM; i++, offset++)
+		fw_hdr->devs[i] = buf[offset];
+
+	fw_hdr->nconfig = be32_to_cpup((__be32 *)&buf[offset]);
+	offset += 4;
+
+	for (i = 0; i < PCMDEVICE_CONFIG_SUM; i++) {
+		fw_hdr->config_size[i] = be32_to_cpup((__be32 *)&buf[offset]);
+		offset += 4;
+		total_config_sz += fw_hdr->config_size[i];
+	}
+
+	if (fw_hdr->img_sz - total_config_sz != (unsigned int)offset) {
+		dev_err(pcm_dev->dev, "Bin file error!\n");
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+	cfg_info = kcalloc(fw_hdr->nconfig, sizeof(*cfg_info), GFP_KERNEL);
+	if (!cfg_info) {
+		pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+		goto out;
+	}
+	regbin->cfg_info = cfg_info;
+	regbin->ncfgs = 0;
+	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
+		cfg_info[i] = pcmdevice_add_config(ctxt, &buf[offset],
+				fw_hdr->config_size[i], &ret);
+		if (ret) {
+			/* In case the bin file is partially destroyed. */
+			if (regbin->ncfgs == 0)
+				pcm_dev->fw_state = PCMDEVICE_FW_LOAD_FAILED;
+			break;
+		}
+		offset += (int)fw_hdr->config_size[i];
+		regbin->ncfgs += 1;
+	}
+	if (pcm_dev->fw_state == PCMDEVICE_FW_LOAD_OK)
+		pcmdevice_create_controls(pcm_dev);
+out:
+	if (pcm_dev->fw_state == PCMDEVICE_FW_LOAD_FAILED)
+		pcmdevice_config_info_remove(pcm_dev);
+
+	mutex_unlock(&pcm_dev->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+}
+
+static int pcmdevice_codec_probe(struct snd_soc_component *codec)
+{
+	struct pcmdevice_priv *pcm_dev = snd_soc_component_get_drvdata(codec);
+	struct i2c_adapter *adap = pcm_dev->client->adapter;
+	int ret;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	pcm_dev->component = codec;
+	pcm_dev->fw_state = PCMDEVICE_FW_LOAD_OK;
+	strscpy(pcm_dev->dev_name, pcmdevice_i2c_id[pcm_dev->chip_id].name,
+		sizeof(pcm_dev->dev_name));
+
+	/* device-name[defined in pcmdevice_i2c_id]-i2c-bus_id[0,1,...,N]-
+	 * sum[1,2,...,4]dev-reg.bin stores the firmware including register
+	 * setting and params for different filters inside chips, it must be
+	 * copied into firmware folder. The same types of pcmdevices sitting
+	 * on the same i2c bus will be aggregated as one single codec,
+	 * all of them share the same bin file.
+	 */
+	scnprintf(pcm_dev->regbin_name, PCMDEVICE_REGBIN_FILENAME_LEN,
+		"%s-i2c-%d-%udev-reg.bin", pcm_dev->dev_name, adap->nr,
+		pcm_dev->ndev);
+
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+		pcm_dev->regbin_name, pcm_dev->dev, GFP_KERNEL, pcm_dev,
+		pcmdev_regbin_ready);
+	if (ret) {
+		dev_err(pcm_dev->dev, "load %s error = %d\n",
+			pcm_dev->regbin_name, ret);
+		goto out;
+	}
+
+	if (pcm_dev->hw_rst) {
+		gpiod_set_value_cansleep(pcm_dev->hw_rst, 0);
+		usleep_range(500, 1000);
+		gpiod_set_value_cansleep(pcm_dev->hw_rst, 1);
+	} else {
+		if (pcm_dev->sw_rst)
+			pcm_dev->sw_rst(pcm_dev);
+	}
+
+out:
+	mutex_unlock(&pcm_dev->codec_lock);
+	return ret;
+}
+
+
+static void pcmdevice_codec_remove(struct snd_soc_component *codec)
+{
+	struct pcmdevice_priv *pcm_dev = snd_soc_component_get_drvdata(codec);
+
+	if (!pcm_dev)
+		return;
+	mutex_lock(&pcm_dev->codec_lock);
+	pcmdevice_config_info_remove(pcm_dev);
+	mutex_unlock(&pcm_dev->codec_lock);
+}
+
+static const struct snd_soc_dapm_widget pcmdevice_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ASI1 OUT", "ASI1 Capture",
+		0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("MIC"),
+};
+
+static const struct snd_soc_dapm_route pcmdevice_audio_map[] = {
+	{"OUT", NULL, "ASI"},
+	{"ASI1 OUT", NULL, "MIC"},
+};
+
+static const struct snd_soc_component_driver
+	soc_codec_driver_pcmdevice = {
+	.probe			= pcmdevice_codec_probe,
+	.remove			= pcmdevice_codec_remove,
+	.dapm_widgets		= pcmdevice_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcmdevice_dapm_widgets),
+	.dapm_routes		= pcmdevice_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(pcmdevice_audio_map),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 0,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static int pcmdevice_process_block(void *ctxt, unsigned char *data,
+	unsigned char dev_idx, int sublocksize)
+{
+	struct pcmdevice_priv *pcm_dev = (struct pcmdevice_priv *)ctxt;
+	int subblk_offset = 2, chn, chnend, rc;
+	unsigned char subblk_typ = data[1];
+
+	if (dev_idx) {
+		chn = dev_idx - 1;
+		chnend = dev_idx;
+	} else {
+		chn = 0;
+		chnend = pcm_dev->ndev;
+	}
+
+	for (; chn < chnend; chn++) {
+		switch (subblk_typ) {
+		case PCMDEVICE_CMD_SING_W: {
+			unsigned short len = be16_to_cpup((__be16 *)&data[2]);
+			int i = 0;
+
+			subblk_offset += 2;
+			if (subblk_offset + 4 * len > sublocksize) {
+				dev_err(pcm_dev->dev,
+					"process_block: Out of boundary\n");
+				break;
+			}
+
+			for (i = 0; i < len; i++) {
+				rc = pcmdev_dev_write(pcm_dev, chn,
+					PCMDEVICE_REG(data[subblk_offset + 1],
+						data[subblk_offset + 2]),
+					data[subblk_offset + 3]);
+				if (rc < 0)
+					dev_err(pcm_dev->dev,
+						"single write error\n");
+
+				subblk_offset += 4;
+			}
+		}
+		break;
+		case PCMDEVICE_CMD_BURST: {
+			unsigned short len = be16_to_cpup((__be16 *)&data[2]);
+
+			subblk_offset += 2;
+			if (subblk_offset + 4 + len > sublocksize) {
+				dev_err(pcm_dev->dev,
+					"BURST Out of boundary\n");
+				break;
+			}
+			if (len % 4) {
+				dev_err(pcm_dev->dev,
+					"Bst-len(%u)not div by 4\n", len);
+				break;
+			}
+			rc = pcmdev_dev_bulk_write(pcm_dev, chn,
+				PCMDEVICE_REG(data[subblk_offset + 1],
+				data[subblk_offset + 2]),
+				&(data[subblk_offset + 4]), len);
+			if (rc < 0)
+				dev_err(pcm_dev->dev,
+					"bulk_write error = %d\n", rc);
+
+			subblk_offset += (len + 4);
+		}
+			break;
+		case PCMDEVICE_CMD_DELAY: {
+			unsigned int delay_time = 0;
+
+			if (subblk_offset + 2 > sublocksize) {
+				dev_err(pcm_dev->dev,
+					"deley Out of boundary\n");
+				break;
+			}
+			delay_time = be16_to_cpup((__be16 *)&data[2]) * 1000;
+			usleep_range(delay_time, delay_time + 50);
+			subblk_offset += 2;
+		}
+			break;
+		case PCMDEVICE_CMD_FIELD_W:
+		if (subblk_offset + 6 > sublocksize) {
+			dev_err(pcm_dev->dev,
+				"process_block: bit write Out of memory\n");
+			break;
+		}
+			rc = pcmdev_dev_update_bits(pcm_dev, chn,
+				PCMDEVICE_REG(data[subblk_offset + 3],
+				data[subblk_offset + 4]),
+				data[subblk_offset + 1],
+				data[subblk_offset + 5]);
+		if (rc < 0)
+			dev_err(pcm_dev->dev,
+				"process_block: update_bits error = %d\n", rc);
+
+		subblk_offset += 6;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return subblk_offset;
+}
+
+
+static void pcmdevice_select_cfg_blk(void *ctxt, int conf_no,
+	unsigned char block_type)
+{
+	struct pcmdevice_priv *pcm_dev = (struct pcmdevice_priv *)ctxt;
+	struct pcmdevice_regbin *regbin = &(pcm_dev->regbin);
+	struct pcmdevice_config_info **cfg_info = regbin->cfg_info;
+	struct pcmdevice_block_data **blk_data;
+	int j, k, chn, chnend;
+
+	if (conf_no >= regbin->ncfgs || conf_no < 0 || NULL == cfg_info) {
+		dev_err(pcm_dev->dev, "conf_no should be less than %u\n",
+			regbin->ncfgs);
+		goto out;
+	}
+	blk_data = cfg_info[conf_no]->blk_data;
+
+	for (j = 0; j < (int)cfg_info[conf_no]->real_nblocks; j++) {
+		unsigned int length = 0, rc = 0;
+
+		if (block_type > 5 || block_type < 2) {
+			dev_err(pcm_dev->dev,
+				"block_type should be in range from 2 to 5\n");
+			goto out;
+		}
+		if (block_type != blk_data[j]->block_type)
+			continue;
+
+		for (k = 0; k < (int)blk_data[j]->n_subblks; k++) {
+			if (blk_data[j]->dev_idx) {
+				chn = blk_data[j]->dev_idx - 1;
+				chnend = blk_data[j]->dev_idx;
+			} else {
+				chn = 0;
+				chnend = pcm_dev->ndev;
+			}
+
+			rc = pcmdevice_process_block(pcm_dev,
+				blk_data[j]->regdata + length,
+				blk_data[j]->dev_idx,
+				blk_data[j]->block_size - length);
+			length += rc;
+			if (blk_data[j]->block_size < length) {
+				dev_err(pcm_dev->dev,
+					"%s: %u %u out of boundary\n",
+					__func__, length,
+					blk_data[j]->block_size);
+				break;
+			}
+		}
+		if (length != blk_data[j]->block_size)
+			dev_err(pcm_dev->dev, "%s: %u %u size is not same\n",
+				__func__, length, blk_data[j]->block_size);
+	}
+
+out:
+	return;
+}
+
+static int pcmdevice_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct pcmdevice_priv *pcm_dev = snd_soc_component_get_drvdata(codec);
+	unsigned char block_type;
+
+	if (pcm_dev->fw_state == PCMDEVICE_FW_LOAD_FAILED) {
+		dev_err(pcm_dev->dev, "DSP bin file not loaded\n");
+		return -EINVAL;
+	}
+
+	if (mute)
+		block_type = PCMDEVICE_BIN_BLK_PRE_SHUTDOWN;
+	else
+		block_type = PCMDEVICE_BIN_BLK_PRE_POWER_UP;
+
+	mutex_lock(&pcm_dev->codec_lock);
+	pcmdevice_select_cfg_blk(pcm_dev, pcm_dev->cur_conf, block_type);
+	mutex_unlock(&pcm_dev->codec_lock);
+	return 0;
+}
+
+static int pcmdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+	int clk_id, unsigned int freq, int dir)
+{
+	struct pcmdevice_priv *pcm_dev = snd_soc_dai_get_drvdata(codec_dai);
+
+	pcm_dev->sysclk = freq;
+
+	return 0;
+}
+
+static int pcmdevice_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct pcmdevice_priv *pcm_dev = snd_soc_dai_get_drvdata(dai);
+	unsigned int fsrate;
+	unsigned int slot_width;
+	int bclk_rate;
+	int rc = 0;
+
+	fsrate = params_rate(params);
+	switch (fsrate) {
+	case 48000:
+		break;
+	case 44100:
+		break;
+	default:
+		dev_err(pcm_dev->dev,
+			"%s: incorrect sample rate = %u\n",
+			__func__, fsrate);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	slot_width = params_width(params);
+	switch (slot_width) {
+	case 16:
+		break;
+	case 20:
+		break;
+	case 24:
+		break;
+	case 32:
+		break;
+	default:
+		dev_err(pcm_dev->dev, "%s: incorrect slot width = %u\n",
+			__func__, slot_width);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	bclk_rate = snd_soc_params_to_bclk(params);
+	if (bclk_rate < 0) {
+		dev_err(pcm_dev->dev, "%s: incorrect bclk rate = %d\n",
+			__func__, bclk_rate);
+		rc = bclk_rate;
+		goto out;
+	}
+
+out:
+	return rc;
+}
+
+static int pcmdevice_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *codec = dai->component;
+	struct pcmdevice_priv *pcm_priv = snd_soc_component_get_drvdata(codec);
+	int ret = 0;
+
+	if (pcm_priv->fw_state != PCMDEVICE_FW_LOAD_OK) {
+		dev_err(pcm_priv->dev, "DSP bin file not loaded\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops pcmdevice_dai_ops = {
+	.mute_stream = pcmdevice_mute,
+	.startup = pcmdevice_startup,
+	.hw_params = pcmdevice_hw_params,
+	.set_sysclk = pcmdevice_set_dai_sysclk,
+};
+
+static struct snd_soc_dai_driver pcmdevice_dai_driver[] = {
+	{
+		.name = "pcmdevice-codec",
+		.capture = {
+			.stream_name	 = "Capture",
+			.channels_min	 = 2,
+			.channels_max	 = PCMDEVICE_MAX_CHANNELS,
+			.rates		 = PCMDEVICE_RATES,
+			.formats	 = PCMDEVICE_FORMATS,
+		},
+		.playback = {
+			.stream_name	 = "Playback",
+			.channels_min	 = 2,
+			.channels_max	 = PCMDEVICE_MAX_CHANNELS,
+			.rates		 = PCMDEVICE_RATES,
+			.formats	 = PCMDEVICE_FORMATS,
+		},
+		.ops = &pcmdevice_dai_ops,
+		.symmetric_rate = 1,
+	}
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id pcmdevice_of_match[] = {
+	{ .compatible = "ti,adc3120"  },
+	{ .compatible = "ti,adc5120"  },
+	{ .compatible = "ti,adc6120"  },
+	{ .compatible = "ti,dix4192"  },
+	{ .compatible = "ti,pcm1690"  },
+	{ .compatible = "ti,pcm3120"  },
+	{ .compatible = "ti,pcm3140"  },
+	{ .compatible = "ti,pcm5120"  },
+	{ .compatible = "ti,pcm5140"  },
+	{ .compatible = "ti,pcm6120"  },
+	{ .compatible = "ti,pcm6140"  },
+	{ .compatible = "ti,pcm6240"  },
+	{ .compatible = "ti,pcm6260"  },
+	{ .compatible = "ti,pcm9211"  },
+	{ .compatible = "ti,pcmd3140" },
+	{ .compatible = "ti,pcmd3180" },
+	{ .compatible = "ti,pcmd512x" },
+	{ .compatible = "ti,taa5212"  },
+	{ .compatible = "ti,taa5412"  },
+	{ .compatible = "ti,tad5212"  },
+	{ .compatible = "ti,tad5412"  },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pcmdevice_of_match);
+#endif
+
+static const struct regmap_range_cfg pcmdevice_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = 256 * 128,
+		.selector_reg = PCMDEVICE_PAGE_SELECT,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 128,
+	},
+};
+
+static const struct regmap_config pcmdevice_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.ranges = pcmdevice_ranges,
+	.num_ranges = ARRAY_SIZE(pcmdevice_ranges),
+	.max_register = 256 * 128,
+};
+
+static void pcmdevice_remove(struct pcmdevice_priv *pcm_dev)
+{
+	if (gpio_is_valid(pcm_dev->irq_info.gpio)) {
+		gpio_free(pcm_dev->irq_info.gpio);
+		free_irq(pcm_dev->irq_info.nmb, pcm_dev);
+	}
+	mutex_destroy(&pcm_dev->codec_lock);
+}
+
+static int pcmdevice_i2c_probe(struct i2c_client *i2c)
+{
+	const struct i2c_device_id *id = i2c_match_id(pcmdevice_i2c_id, i2c);
+	struct pcmdevice_priv *pcm_dev;
+	struct device_node *np;
+	unsigned int dev_addrs[PCMDEVICE_MAX_DEVICES];
+	int ret = 0, i = 0, ndev = 0;
+#ifdef CONFIG_OF
+	const __be32 *reg, *reg_end;
+	int len, sw, aw;
+#endif
+
+	pcm_dev = devm_kzalloc(&i2c->dev, sizeof(*pcm_dev), GFP_KERNEL);
+	if (!pcm_dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	pcm_dev->chip_id = (id != NULL) ? id->driver_data : 0;
+
+	pcm_dev->dev = &i2c->dev;
+	pcm_dev->client = i2c;
+
+	if (pcm_dev->chip_id >= MAX_DEVICE)
+		pcm_dev->chip_id = 0;
+
+	pcm_dev->regmap = devm_regmap_init_i2c(i2c,
+		&pcmdevice_i2c_regmap);
+	if (IS_ERR(pcm_dev->regmap)) {
+		ret = PTR_ERR(pcm_dev->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto out;
+	}
+
+	np = pcm_dev->dev->of_node;
+#ifdef CONFIG_OF
+	aw = of_n_addr_cells(np);
+	sw = of_n_size_cells(np);
+	if (sw == 0) {
+		reg = (const __be32 *)of_get_property(np,
+			"reg", &len);
+		reg_end = reg + len/sizeof(*reg);
+		ndev = 0;
+		do {
+			dev_addrs[ndev] = of_read_number(reg, aw);
+			reg += aw;
+			ndev++;
+		} while (reg < reg_end);
+	} else {
+		ndev = 1;
+		dev_addrs[0] = i2c->addr;
+	}
+#else
+	ndev = 1;
+	dev_addrs[0] = i2c->addr;
+#endif
+	pcm_dev->irq_info.gpio = of_irq_get(np, 0);
+
+	for (i = 0; i < ndev; i++)
+		pcm_dev->addr[i] = dev_addrs[i];
+
+	pcm_dev->ndev = ndev;
+
+	pcm_dev->hw_rst = devm_gpiod_get_optional(&i2c->dev,
+			"reset-gpios", GPIOD_OUT_HIGH);
+	if (IS_ERR(pcm_dev->hw_rst))
+		dev_dbg(&i2c->dev, "%s: No reset GPIO, no side-effect\n",
+			__func__);
+
+	if (pcm_dev->chip_id == PCM9211 || pcm_dev->chip_id == PCM1690)
+		pcm_dev->sw_rst = pcm9211_sw_rst;
+	else
+		pcm_dev->sw_rst = pcmdevice_sw_rst;
+
+	if (pcm_dev->chip_id == PCM1690)
+		goto skip_interrupt;
+	if (gpio_is_valid(pcm_dev->irq_info.gpio)) {
+		dev_dbg(pcm_dev->dev, "irq-gpio = %d",
+			pcm_dev->irq_info.gpio);
+
+		ret = gpio_request(pcm_dev->irq_info.gpio, "PCMDEV-IRQ");
+		if (!ret) {
+			int gpio = pcm_dev->irq_info.gpio;
+
+			gpio_direction_input(gpio);
+			pcm_dev->irq_info.nmb = gpio_to_irq(gpio);
+
+		} else
+			dev_err(pcm_dev->dev, "%s: GPIO %d request error\n",
+				__func__, pcm_dev->irq_info.gpio);
+	} else
+		dev_err(pcm_dev->dev, "Looking up irq-gpio failed %d\n",
+			pcm_dev->irq_info.gpio);
+
+
+skip_interrupt:
+	mutex_init(&pcm_dev->codec_lock);
+
+	i2c_set_clientdata(i2c, pcm_dev);
+
+	ret = devm_snd_soc_register_component(&i2c->dev,
+		&soc_codec_driver_pcmdevice, pcmdevice_dai_driver,
+		ARRAY_SIZE(pcmdevice_dai_driver));
+	if (ret < 0)
+		dev_err(&i2c->dev, "probe register comp failed %d\n", ret);
+
+out:
+	if (ret < 0)
+		pcmdevice_remove(pcm_dev);
+	return ret;
+}
+
+static void pcmdevice_i2c_remove(struct i2c_client *i2c)
+{
+	struct pcmdevice_priv *pcm_dev = i2c_get_clientdata(i2c);
+
+	pcmdevice_remove(pcm_dev);
+}
+
+static struct i2c_driver pcmdevice_i2c_driver = {
+	.driver = {
+		.name = "pcmdevice-codec",
+		.of_match_table = of_match_ptr(pcmdevice_of_match),
+	},
+	.probe	= pcmdevice_i2c_probe,
+	.remove = pcmdevice_i2c_remove,
+	.id_table = pcmdevice_i2c_id,
+};
+
+module_i2c_driver(pcmdevice_i2c_driver);
+
+MODULE_AUTHOR("Shenghao Ding <shenghao-ding@ti.com>");
+MODULE_DESCRIPTION("ASoC PCM6240 Family Audio ADC/DAC/Router Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


