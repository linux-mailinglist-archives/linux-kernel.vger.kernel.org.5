Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359A7B1147
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjI1Dlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Dll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:41:41 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBDB110A;
        Wed, 27 Sep 2023 20:41:37 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(1978095:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 28 Sep 2023 11:41:10 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 28 Sep
 2023 11:41:10 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 28 Sep 2023 11:41:10 +0800
From:   <cy_huang@richtek.com>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Allen Lin <allen_lin@richtek.com>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: codecs: rtq9128: Add TDM input source select
Date:   Thu, 28 Sep 2023 11:41:08 +0800
Message-ID: <1695872468-24433-3-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
References: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Pase the property to decide the TDM input source comes from 'DATA1' or
'DATA2 pin.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 sound/soc/codecs/rtq9128.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rtq9128.c b/sound/soc/codecs/rtq9128.c
index 926b79ed8078..371d622c6214 100644
--- a/sound/soc/codecs/rtq9128.c
+++ b/sound/soc/codecs/rtq9128.c
@@ -14,6 +14,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -41,6 +42,7 @@
 
 #define RTQ9128_CHSTAT_VAL_MASK	GENMASK(1, 0)
 #define RTQ9128_DOLEN_MASK	GENMASK(7, 6)
+#define RTQ9128_TDMSRCIN_MASK	GENMASK(5, 4)
 #define RTQ9128_AUDBIT_MASK	GENMASK(5, 4)
 #define RTQ9128_AUDFMT_MASK	GENMASK(3, 0)
 #define RTQ9128_MSMUTE_MASK	BIT(0)
@@ -59,6 +61,7 @@ struct rtq9128_data {
 	struct gpio_desc *enable;
 	int tdm_slots;
 	int tdm_slot_width;
+	bool tdm_input_data2_select;
 };
 
 struct rtq9128_init_reg {
@@ -484,7 +487,7 @@ static int rtq9128_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mas
 	struct rtq9128_data *data = snd_soc_dai_get_drvdata(dai);
 	struct snd_soc_component *comp = dai->component;
 	struct device *dev = dai->dev;
-	unsigned int mask, start_loc;
+	unsigned int mask, start_loc, srcin_select;
 	int i, frame_length, ret;
 
 	dev_dbg(dev, "%s: slot %d slot_width %d, tx/rx mask 0x%x 0x%x\n", __func__, slots,
@@ -530,6 +533,14 @@ static int rtq9128_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mas
 		}
 	}
 
+	srcin_select = data->tdm_input_data2_select ? RTQ9128_TDMSRCIN_MASK : 0;
+	ret = snd_soc_component_update_bits(comp, RTQ9128_REG_SDO_SEL, RTQ9128_TDMSRCIN_MASK,
+					    srcin_select);
+	if (ret < 0) {
+		dev_err(dev, "Failed to configure TDM source input select\n");
+		return ret;
+	}
+
 	data->tdm_slots = slots;
 	data->tdm_slot_width = slot_width;
 
@@ -672,6 +683,9 @@ static int rtq9128_probe(struct i2c_client *i2c)
 	else if (data->enable)
 		usleep_range(10000, 11000);
 
+	data->tdm_input_data2_select = device_property_read_bool(dev,
+								 "richtek,tdm-input-data2-select");
+
 	i2c_set_clientdata(i2c, data);
 
 	/*
-- 
2.34.1

