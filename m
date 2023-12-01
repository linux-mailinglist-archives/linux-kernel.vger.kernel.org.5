Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75613800E13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379342AbjLAPJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379341AbjLAPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:09:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A4D4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:09:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bc4fe8158so3175583e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443345; x=1702048145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhPMjCtprxFi7a17YhyqKbQ2csPluhr7s82UxzH6JIM=;
        b=gEUJeM31Ntph2b7BjIjHjiVonIISQHS/QCFrLZgk/yjDj9ttledTdMTtJ86rofLbqb
         r3phP3W8UVhmyCSmOcn6b6NEJUEcFrUxlEkyKm/tCBn4jDpDWLCGY06m1BZVQBgwFOVT
         7nCbU5855pJwdkuq/6HFJ9stPtvGCcLygi3zWj3S+CT1RIdLjcg49P3v/KEfDF9BaGsQ
         4PuqIzPzE6aZ7nudxUaNsDjlFIpBSNvtrZbptpr/qBzIgZs/C/EJ7dDwpyE9mgaCNzWw
         VDi5kFH4As9w3fsE9wUAUumj7CKn7kagvqfhCppUajC9PKGYbhc3pU0GuC58Ac3NJN0e
         bVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443345; x=1702048145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhPMjCtprxFi7a17YhyqKbQ2csPluhr7s82UxzH6JIM=;
        b=ZuxXmviYhGp0qkCJlkinw1TWUr8Apdf6hSl+K4WGdPwa3/xZPwKx3xF7TimcjD7egO
         LajV8F8DrltGpLD8S/LWSYSuvhZJDVz2t+XnFfg8UIfoKiyflMOXM4F0XWQi9T7k7Su9
         j/LR15PdmTx4EJ6I3ACqT+4nKiWEPUPiOuBFwXBuwsPxxB/LE9di/RuKn/4sJkPi8pIa
         JNRvPNOkT+jHqvmDVds4lsIa96LWmTdpPYCV5BuXee5r5VgHxkuul8pms3yIHAhT06JY
         vE20PE3GunBkt6nnh+ES9/7uKo0T7qrfZAQaLo4xRpBc1ZVahmBdigaaJB0WGeR8nzmI
         FtUA==
X-Gm-Message-State: AOJu0YzkrgDgl0gfXvapWcL+/naH88tzcocxDCDK/81qiKpXKAuVLb1P
        BK1JKCwXroDDqPwEGtxeibJf5g==
X-Google-Smtp-Source: AGHT+IFlG/jQNsvgVb6AbVBvNiJrjgG8LsxOaX+4IoRq6NjwQ7aHZlWkDzC0o/Jb307+3scovD54aw==
X-Received: by 2002:ac2:410d:0:b0:50b:c722:cff6 with SMTP id b13-20020ac2410d000000b0050bc722cff6mr905844lfi.19.1701443344371;
        Fri, 01 Dec 2023 07:09:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040b5517ae31sm8569539wmb.6.2023.12.01.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:09:03 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 01 Dec 2023 16:08:57 +0100
Subject: [PATCH v2 4/5] ASoC: codecs: Add WCD939x Soundwire devices driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-4-94ed814b25aa@linaro.org>
References: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org>
In-Reply-To: <20231201-topic-sm8650-upstream-wcd939x-codec-v2-0-94ed814b25aa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=106876;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PSdf+1G3vAAalZvPMfUyx3nbK2tT0sOm2bBq401TI3s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlafcJNvAlJgK0cyLrdawleHTq7Vd1S9ac+qddlsVh
 b+arc7aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWn3CQAKCRB33NvayMhJ0QdIEA
 CoHEQsGLRGmrwJRc/JsOfP7NbpqLYy4one6xHQqNWItnrAMM98TD5Z2FIGTHa3Dmh88Xu4Kc9M1wcy
 dgksPjmjahUXFPK0b0LU12FfCkT8GZK+1oavZrO2oMbpHxyifcn7Qfr0lN/UrB32wLJ1vs3zRUSbT/
 I0bQaS/hJdFyhIES9lkgwPFrCtj7s9FzoRsACy64q2+IJa87nvRbx4z49c+M8KUsBtdtGutVvoVIQh
 BXjEAmqcv8KKvfKSiWbhBjp4YTFMo+jwoqBFPAF/526FlxFlYyL2l8Vp3wHJI+laCOPKTqyzWJjCxB
 hUATyfRn9c81GGalCoCFEjpiHcA6U1RAac9yl/9mvVS9/1h7mDkMUEEGl6yUMSoMAU+QHsY6p4El9L
 qeEWa2woQO9KDxNiAg6j+T4RBqbNZ17N062N+RBT3iR4diGJeoPQeXk9e21X8a5+889p4YNE1y7Ap+
 FqU1qRmcBz8WXT1tNTj69Rm1VLsOL0ENhoXvfii173IKOggsjvqUzVS3qyh/mZAm5jeZX0Ixth7tZO
 pYv2KpaTbdPcUKt7/wacLD4caoXlD7SU2s6NOxLY5tSa0tve/edtJhfOVxeeyrs3hBlMfXgLd+Yx6+
 kBIgLAcJ6HVS9ddSSE662S9ULZiBdMRB64wgAuWDs2Wp0EtUL3w6RLPaDnMw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Soundwire Slave driver for the WCD9390/WCD9395 Audio Codec.

The WCD9390/WCD9395 Soundwire devices will be used by the
main WCD9390/WCD9395 Audio Codec driver to access registers
and configure Soundwire RX and TX ports.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/codecs/Kconfig       |   10 +
 sound/soc/codecs/Makefile      |    1 +
 sound/soc/codecs/wcd939x-sdw.c | 1584 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd939x.h     |  983 +++++++++++++++++++++++++
 4 files changed, 2578 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3429419ca694..1a29b38d4cb9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -276,6 +276,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_WCD9335
 	imply SND_SOC_WCD934X
 	imply SND_SOC_WCD938X_SDW
+	imply SND_SOC_WCD939X_SDW
 	imply SND_SOC_LPASS_MACRO_COMMON
 	imply SND_SOC_LPASS_RX_MACRO
 	imply SND_SOC_LPASS_TX_MACRO
@@ -2055,6 +2056,15 @@ config SND_SOC_WCD938X_SDW
 	  The WCD9380/9385 is a audio codec IC Integrated in
 	  Qualcomm SoCs like SM8250.
 
+config SND_SOC_WCD939X_SDW
+	tristate "WCD9390/WCD9395 Codec - SDW"
+	select REGMAP_IRQ
+	depends on SOUNDWIRE
+	select REGMAP_SOUNDWIRE
+	help
+	  The WCD9390/9395 is a audio codec IC Integrated in
+	  Qualcomm SoCs like SM8650.
+
 config SND_SOC_WL1273
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2078bb0d981e..c63e4c274ed4 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -312,6 +312,7 @@ snd-soc-wcd9335-objs := wcd9335.o
 snd-soc-wcd934x-objs := wcd934x.o
 snd-soc-wcd938x-objs := wcd938x.o
 snd-soc-wcd938x-sdw-objs := wcd938x-sdw.o
+snd-soc-wcd939x-sdw-objs := wcd939x-sdw.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm-adsp-objs := wm_adsp.o
 snd-soc-wm0010-objs := wm0010.o
diff --git a/sound/soc/codecs/wcd939x-sdw.c b/sound/soc/codecs/wcd939x-sdw.c
new file mode 100644
index 000000000000..d248b6c7d5ab
--- /dev/null
+++ b/sound/soc/codecs/wcd939x-sdw.c
@@ -0,0 +1,1584 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/component.h>
+#include <linux/pm_runtime.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include "wcd939x.h"
+
+#define SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(m) (0xE0 + 0x10 * (m))
+
+static struct wcd939x_sdw_ch_info wcd939x_sdw_rx_ch_info[] = {
+	WCD_SDW_CH(WCD939X_HPH_L, WCD939X_HPH_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_HPH_R, WCD939X_HPH_PORT, BIT(1)),
+	WCD_SDW_CH(WCD939X_CLSH, WCD939X_CLSH_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_COMP_L, WCD939X_COMP_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_COMP_R, WCD939X_COMP_PORT, BIT(1)),
+	WCD_SDW_CH(WCD939X_LO, WCD939X_LO_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_DSD_L, WCD939X_DSD_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_DSD_R, WCD939X_DSD_PORT, BIT(1)),
+	WCD_SDW_CH(WCD939X_HIFI_PCM_L, WCD939X_HIFI_PCM_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_HIFI_PCM_R, WCD939X_HIFI_PCM_PORT, BIT(1)),
+};
+
+static struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
+	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
+	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
+	WCD_SDW_CH(WCD939X_ADC4, WCD939X_ADC_1_4_PORT, BIT(3)),
+	WCD_SDW_CH(WCD939X_DMIC0, WCD939X_DMIC_0_3_MBHC_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_DMIC1, WCD939X_DMIC_0_3_MBHC_PORT, BIT(1)),
+	WCD_SDW_CH(WCD939X_MBHC, WCD939X_DMIC_0_3_MBHC_PORT, BIT(2)),
+	WCD_SDW_CH(WCD939X_DMIC2, WCD939X_DMIC_0_3_MBHC_PORT, BIT(2)),
+	WCD_SDW_CH(WCD939X_DMIC3, WCD939X_DMIC_0_3_MBHC_PORT, BIT(3)),
+	WCD_SDW_CH(WCD939X_DMIC4, WCD939X_DMIC_3_7_PORT, BIT(0)),
+	WCD_SDW_CH(WCD939X_DMIC5, WCD939X_DMIC_3_7_PORT, BIT(1)),
+	WCD_SDW_CH(WCD939X_DMIC6, WCD939X_DMIC_3_7_PORT, BIT(2)),
+	WCD_SDW_CH(WCD939X_DMIC7, WCD939X_DMIC_3_7_PORT, BIT(3)),
+};
+
+static struct sdw_dpn_prop wcd939x_rx_dpn_prop[WCD939X_MAX_RX_SWR_PORTS] = {
+	{
+		.num = WCD939X_HPH_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 2,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_CLSH_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 1,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_COMP_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 2,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_LO_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 1,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_DSD_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 2,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_HIFI_PCM_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 2,
+		.simple_ch_prep_sm = true,
+	}
+};
+
+static struct sdw_dpn_prop wcd939x_tx_dpn_prop[WCD939X_MAX_TX_SWR_PORTS] = {
+	{
+		.num = WCD939X_ADC_1_4_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_ADC_DMIC_1_2_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_DMIC_0_3_MBHC_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	},
+	{
+		.num = WCD939X_DMIC_3_7_PORT,
+		.type = SDW_DPN_SIMPLE,
+		.min_ch = 1,
+		.max_ch = 4,
+		.simple_ch_prep_sm = true,
+	}
+};
+
+struct device *wcd939x_sdw_device_get(struct device_node *np)
+{
+	return bus_find_device_by_of_node(&sdw_bus_type, np);
+}
+EXPORT_SYMBOL_GPL(wcd939x_sdw_device_get);
+
+unsigned int wcd939x_swr_get_current_bank(struct sdw_slave *sdev)
+{
+	return FIELD_GET(SDW_SCP_STAT_CURR_BANK,
+			 sdw_read(sdev, SDW_SCP_CTRL));
+}
+EXPORT_SYMBOL_GPL(wcd939x_swr_get_current_bank);
+
+int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai)
+{
+	struct sdw_port_config port_config[WCD939X_MAX_SWR_PORTS];
+	unsigned long ch_mask;
+	int i, j;
+
+	wcd->sconfig.ch_count = 1;
+	wcd->active_ports = 0;
+	for (i = 0; i < WCD939X_MAX_SWR_PORTS; i++) {
+		ch_mask = wcd->port_config[i].ch_mask;
+
+		if (!ch_mask)
+			continue;
+
+		for_each_set_bit(j, &ch_mask, 4)
+			wcd->sconfig.ch_count++;
+
+		port_config[wcd->active_ports] = wcd->port_config[i];
+		wcd->active_ports++;
+	}
+
+	wcd->sconfig.bps = 1;
+	wcd->sconfig.frame_rate = params_rate(params);
+	if (wcd->is_tx)
+		wcd->sconfig.direction = SDW_DATA_DIR_TX;
+	else
+		wcd->sconfig.direction = SDW_DATA_DIR_RX;
+
+	wcd->sconfig.type = SDW_STREAM_PCM;
+
+	return sdw_stream_add_slave(wcd->sdev, &wcd->sconfig, &port_config[0],
+				    wcd->active_ports, wcd->sruntime);
+}
+EXPORT_SYMBOL_GPL(wcd939x_sdw_hw_params);
+
+int wcd939x_sdw_free(struct wcd939x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai)
+{
+	sdw_stream_remove_slave(wcd->sdev, wcd->sruntime);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd939x_sdw_free);
+
+int wcd939x_sdw_set_sdw_stream(struct wcd939x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai, void *stream,
+			       int direction)
+{
+	wcd->sruntime = stream;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wcd939x_sdw_set_sdw_stream);
+
+static int wcd9390_update_status(struct sdw_slave *slave,
+				 enum sdw_slave_status status)
+{
+	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+
+	if (wcd->regmap && status == SDW_SLAVE_ATTACHED) {
+		/* Write out any cached changes that happened between probe and attach */
+		regcache_cache_only(wcd->regmap, false);
+		return regcache_sync(wcd->regmap);
+	}
+
+	return 0;
+}
+
+static int wcd9390_bus_config(struct sdw_slave *slave,
+			      struct sdw_bus_params *params)
+{
+	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank),
+		  0x01);
+
+	return 0;
+}
+
+/*
+ * Handle Soundwire out-of-band interrupt event by triggering
+ * the first irq of the slave_irq irq domain, which then will
+ * be handled by the regmap_irq threaded irq.
+ * Looping is to ensure no interrupts were missed in the process.
+ */
+static int wcd9390_interrupt_callback(struct sdw_slave *slave,
+				      struct sdw_slave_intr_status *status)
+{
+	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+	struct irq_domain *slave_irq = wcd->slave_irq;
+	u32 sts1, sts2, sts3;
+
+	do {
+		handle_nested_irq(irq_find_mapping(slave_irq, 0));
+		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_0, &sts1);
+		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_1, &sts2);
+		regmap_read(wcd->regmap, WCD939X_DIGITAL_INTR_STATUS_2, &sts3);
+
+	} while (sts1 || sts2 || sts3);
+
+	return IRQ_HANDLED;
+}
+
+static const struct reg_default wcd939x_defaults[] = {
+	{ WCD939X_ANA_PAGE, 0x00 },
+	{ WCD939X_ANA_BIAS, 0x00 },
+	{ WCD939X_ANA_RX_SUPPLIES, 0x00 },
+	{ WCD939X_ANA_HPH, 0x0c },
+	{ WCD939X_ANA_EAR, 0x00 },
+	{ WCD939X_ANA_EAR_COMPANDER_CTL, 0x02 },
+	{ WCD939X_ANA_TX_CH1, 0x20 },
+	{ WCD939X_ANA_TX_CH2, 0x00 },
+	{ WCD939X_ANA_TX_CH3, 0x20 },
+	{ WCD939X_ANA_TX_CH4, 0x00 },
+	{ WCD939X_ANA_MICB1_MICB2_DSP_EN_LOGIC, 0x00 },
+	{ WCD939X_ANA_MICB3_DSP_EN_LOGIC, 0x00 },
+	{ WCD939X_ANA_MBHC_MECH, 0x39 },
+	{ WCD939X_ANA_MBHC_ELECT, 0x08 },
+	{ WCD939X_ANA_MBHC_ZDET, 0x00 },
+	{ WCD939X_ANA_MBHC_RESULT_1, 0x00 },
+	{ WCD939X_ANA_MBHC_RESULT_2, 0x00 },
+	{ WCD939X_ANA_MBHC_RESULT_3, 0x00 },
+	{ WCD939X_ANA_MBHC_BTN0, 0x00 },
+	{ WCD939X_ANA_MBHC_BTN1, 0x10 },
+	{ WCD939X_ANA_MBHC_BTN2, 0x20 },
+	{ WCD939X_ANA_MBHC_BTN3, 0x30 },
+	{ WCD939X_ANA_MBHC_BTN4, 0x40 },
+	{ WCD939X_ANA_MBHC_BTN5, 0x50 },
+	{ WCD939X_ANA_MBHC_BTN6, 0x60 },
+	{ WCD939X_ANA_MBHC_BTN7, 0x70 },
+	{ WCD939X_ANA_MICB1, 0x10 },
+	{ WCD939X_ANA_MICB2, 0x10 },
+	{ WCD939X_ANA_MICB2_RAMP, 0x00 },
+	{ WCD939X_ANA_MICB3, 0x00 },
+	{ WCD939X_ANA_MICB4, 0x00 },
+	{ WCD939X_BIAS_CTL, 0x2a },
+	{ WCD939X_BIAS_VBG_FINE_ADJ, 0x55 },
+	{ WCD939X_LDOL_VDDCX_ADJUST, 0x01 },
+	{ WCD939X_LDOL_DISABLE_LDOL, 0x00 },
+	{ WCD939X_MBHC_CTL_CLK, 0x00 },
+	{ WCD939X_MBHC_CTL_ANA, 0x00 },
+	{ WCD939X_MBHC_ZDET_VNEG_CTL, 0x00 },
+	{ WCD939X_MBHC_ZDET_BIAS_CTL, 0x46 },
+	{ WCD939X_MBHC_CTL_BCS, 0x00 },
+	{ WCD939X_MBHC_MOISTURE_DET_FSM_STATUS, 0x00 },
+	{ WCD939X_MBHC_TEST_CTL, 0x00 },
+	{ WCD939X_LDOH_MODE, 0x2b },
+	{ WCD939X_LDOH_BIAS, 0x68 },
+	{ WCD939X_LDOH_STB_LOADS, 0x00 },
+	{ WCD939X_LDOH_SLOWRAMP, 0x50 },
+	{ WCD939X_MICB1_TEST_CTL_1, 0x1a },
+	{ WCD939X_MICB1_TEST_CTL_2, 0x00 },
+	{ WCD939X_MICB1_TEST_CTL_3, 0xa4 },
+	{ WCD939X_MICB2_TEST_CTL_1, 0x1a },
+	{ WCD939X_MICB2_TEST_CTL_2, 0x00 },
+	{ WCD939X_MICB2_TEST_CTL_3, 0x24 },
+	{ WCD939X_MICB3_TEST_CTL_1, 0x9a },
+	{ WCD939X_MICB3_TEST_CTL_2, 0x80 },
+	{ WCD939X_MICB3_TEST_CTL_3, 0x24 },
+	{ WCD939X_MICB4_TEST_CTL_1, 0x1a },
+	{ WCD939X_MICB4_TEST_CTL_2, 0x80 },
+	{ WCD939X_MICB4_TEST_CTL_3, 0x24 },
+	{ WCD939X_TX_COM_ADC_VCM, 0x39 },
+	{ WCD939X_TX_COM_BIAS_ATEST, 0xe0 },
+	{ WCD939X_TX_COM_SPARE1, 0x00 },
+	{ WCD939X_TX_COM_SPARE2, 0x00 },
+	{ WCD939X_TX_COM_TXFE_DIV_CTL, 0x22 },
+	{ WCD939X_TX_COM_TXFE_DIV_START, 0x00 },
+	{ WCD939X_TX_COM_SPARE3, 0x00 },
+	{ WCD939X_TX_COM_SPARE4, 0x00 },
+	{ WCD939X_TX_1_2_TEST_EN, 0xcc },
+	{ WCD939X_TX_1_2_ADC_IB, 0xe9 },
+	{ WCD939X_TX_1_2_ATEST_REFCTL, 0x0b },
+	{ WCD939X_TX_1_2_TEST_CTL, 0x38 },
+	{ WCD939X_TX_1_2_TEST_BLK_EN1, 0xff },
+	{ WCD939X_TX_1_2_TXFE1_CLKDIV, 0x00 },
+	{ WCD939X_TX_1_2_SAR2_ERR, 0x00 },
+	{ WCD939X_TX_1_2_SAR1_ERR, 0x00 },
+	{ WCD939X_TX_3_4_TEST_EN, 0xcc },
+	{ WCD939X_TX_3_4_ADC_IB, 0xe9 },
+	{ WCD939X_TX_3_4_ATEST_REFCTL, 0x0b },
+	{ WCD939X_TX_3_4_TEST_CTL, 0x38 },
+	{ WCD939X_TX_3_4_TEST_BLK_EN3, 0xff },
+	{ WCD939X_TX_3_4_TXFE3_CLKDIV, 0x00 },
+	{ WCD939X_TX_3_4_SAR4_ERR, 0x00 },
+	{ WCD939X_TX_3_4_SAR3_ERR, 0x00 },
+	{ WCD939X_TX_3_4_TEST_BLK_EN2, 0xfb },
+	{ WCD939X_TX_3_4_TXFE2_CLKDIV, 0x00 },
+	{ WCD939X_TX_3_4_SPARE1, 0x00 },
+	{ WCD939X_TX_3_4_TEST_BLK_EN4, 0xfb },
+	{ WCD939X_TX_3_4_TXFE4_CLKDIV, 0x00 },
+	{ WCD939X_TX_3_4_SPARE2, 0x00 },
+	{ WCD939X_CLASSH_MODE_1, 0x40 },
+	{ WCD939X_CLASSH_MODE_2, 0x3a },
+	{ WCD939X_CLASSH_MODE_3, 0xf0 },
+	{ WCD939X_CLASSH_CTRL_VCL_1, 0x7c },
+	{ WCD939X_CLASSH_CTRL_VCL_2, 0x82 },
+	{ WCD939X_CLASSH_CTRL_CCL_1, 0x31 },
+	{ WCD939X_CLASSH_CTRL_CCL_2, 0x80 },
+	{ WCD939X_CLASSH_CTRL_CCL_3, 0x80 },
+	{ WCD939X_CLASSH_CTRL_CCL_4, 0x51 },
+	{ WCD939X_CLASSH_CTRL_CCL_5, 0x00 },
+	{ WCD939X_CLASSH_BUCK_TMUX_A_D, 0x00 },
+	{ WCD939X_CLASSH_BUCK_SW_DRV_CNTL, 0x77 },
+	{ WCD939X_CLASSH_SPARE, 0x80 },
+	{ WCD939X_FLYBACK_EN, 0x4e },
+	{ WCD939X_FLYBACK_VNEG_CTRL_1, 0x0b },
+	{ WCD939X_FLYBACK_VNEG_CTRL_2, 0x45 },
+	{ WCD939X_FLYBACK_VNEG_CTRL_3, 0x14 },
+	{ WCD939X_FLYBACK_VNEG_CTRL_4, 0xdb },
+	{ WCD939X_FLYBACK_VNEG_CTRL_5, 0x83 },
+	{ WCD939X_FLYBACK_VNEG_CTRL_6, 0x98 },
+	{ WCD939X_FLYBACK_VNEG_CTRL_7, 0xa9 },
+	{ WCD939X_FLYBACK_VNEG_CTRL_8, 0x68 },
+	{ WCD939X_FLYBACK_VNEG_CTRL_9, 0x66 },
+	{ WCD939X_FLYBACK_VNEGDAC_CTRL_1, 0xed },
+	{ WCD939X_FLYBACK_VNEGDAC_CTRL_2, 0xf8 },
+	{ WCD939X_FLYBACK_VNEGDAC_CTRL_3, 0xa6 },
+	{ WCD939X_FLYBACK_CTRL_1, 0x65 },
+	{ WCD939X_FLYBACK_TEST_CTL, 0x02 },
+	{ WCD939X_RX_AUX_SW_CTL, 0x00 },
+	{ WCD939X_RX_PA_AUX_IN_CONN, 0x01 },
+	{ WCD939X_RX_TIMER_DIV, 0x32 },
+	{ WCD939X_RX_OCP_CTL, 0x1f },
+	{ WCD939X_RX_OCP_COUNT, 0x77 },
+	{ WCD939X_RX_BIAS_EAR_DAC, 0xa0 },
+	{ WCD939X_RX_BIAS_EAR_AMP, 0xaa },
+	{ WCD939X_RX_BIAS_HPH_LDO, 0xa9 },
+	{ WCD939X_RX_BIAS_HPH_PA, 0xaa },
+	{ WCD939X_RX_BIAS_HPH_RDACBUFF_CNP2, 0xca },
+	{ WCD939X_RX_BIAS_HPH_RDAC_LDO, 0x88 },
+	{ WCD939X_RX_BIAS_HPH_CNP1, 0x82 },
+	{ WCD939X_RX_BIAS_HPH_LOWPOWER, 0x82 },
+	{ WCD939X_RX_BIAS_AUX_DAC, 0xa0 },
+	{ WCD939X_RX_BIAS_AUX_AMP, 0xaa },
+	{ WCD939X_RX_BIAS_VNEGDAC_BLEEDER, 0x50 },
+	{ WCD939X_RX_BIAS_MISC, 0x00 },
+	{ WCD939X_RX_BIAS_BUCK_RST, 0x08 },
+	{ WCD939X_RX_BIAS_BUCK_VREF_ERRAMP, 0x44 },
+	{ WCD939X_RX_BIAS_FLYB_ERRAMP, 0x40 },
+	{ WCD939X_RX_BIAS_FLYB_BUFF, 0xaa },
+	{ WCD939X_RX_BIAS_FLYB_MID_RST, 0x14 },
+	{ WCD939X_HPH_L_STATUS, 0x04 },
+	{ WCD939X_HPH_R_STATUS, 0x04 },
+	{ WCD939X_HPH_CNP_EN, 0x80 },
+	{ WCD939X_HPH_CNP_WG_CTL, 0x9a },
+	{ WCD939X_HPH_CNP_WG_TIME, 0x14 },
+	{ WCD939X_HPH_OCP_CTL, 0x28 },
+	{ WCD939X_HPH_AUTO_CHOP, 0x56 },
+	{ WCD939X_HPH_CHOP_CTL, 0x83 },
+	{ WCD939X_HPH_PA_CTL1, 0x46 },
+	{ WCD939X_HPH_PA_CTL2, 0x50 },
+	{ WCD939X_HPH_L_EN, 0x80 },
+	{ WCD939X_HPH_L_TEST, 0xe0 },
+	{ WCD939X_HPH_L_ATEST, 0x50 },
+	{ WCD939X_HPH_R_EN, 0x80 },
+	{ WCD939X_HPH_R_TEST, 0xe0 },
+	{ WCD939X_HPH_R_ATEST, 0x50 },
+	{ WCD939X_HPH_RDAC_CLK_CTL1, 0x80 },
+	{ WCD939X_HPH_RDAC_CLK_CTL2, 0x0b },
+	{ WCD939X_HPH_RDAC_LDO_CTL, 0x33 },
+	{ WCD939X_HPH_RDAC_CHOP_CLK_LP_CTL, 0x00 },
+	{ WCD939X_HPH_REFBUFF_UHQA_CTL, 0x00 },
+	{ WCD939X_HPH_REFBUFF_LP_CTL, 0x8e },
+	{ WCD939X_HPH_L_DAC_CTL, 0x20 },
+	{ WCD939X_HPH_R_DAC_CTL, 0x20 },
+	{ WCD939X_HPH_SURGE_COMP_SEL, 0x55 },
+	{ WCD939X_HPH_SURGE_EN, 0x19 },
+	{ WCD939X_HPH_SURGE_MISC1, 0xa0 },
+	{ WCD939X_HPH_SURGE_STATUS, 0x00 },
+	{ WCD939X_EAR_EN, 0x22 },
+	{ WCD939X_EAR_PA_CON, 0x44 },
+	{ WCD939X_EAR_SP_CON, 0xdb },
+	{ WCD939X_EAR_DAC_CON, 0x80 },
+	{ WCD939X_EAR_CNP_FSM_CON, 0xb2 },
+	{ WCD939X_EAR_TEST_CTL, 0x00 },
+	{ WCD939X_EAR_STATUS_REG_1, 0x00 },
+	{ WCD939X_EAR_STATUS_REG_2, 0x08 },
+	{ WCD939X_FLYBACK_NEW_CTRL_2, 0x00 },
+	{ WCD939X_FLYBACK_NEW_CTRL_3, 0x00 },
+	{ WCD939X_FLYBACK_NEW_CTRL_4, 0x44 },
+	{ WCD939X_ANA_NEW_PAGE, 0x00 },
+	{ WCD939X_HPH_NEW_ANA_HPH2, 0x00 },
+	{ WCD939X_HPH_NEW_ANA_HPH3, 0x00 },
+	{ WCD939X_SLEEP_CTL, 0x18 },
+	{ WCD939X_SLEEP_WATCHDOG_CTL, 0x00 },
+	{ WCD939X_MBHC_NEW_ELECT_REM_CLAMP_CTL, 0x00 },
+	{ WCD939X_MBHC_NEW_CTL_1, 0x02 },
+	{ WCD939X_MBHC_NEW_CTL_2, 0x05 },
+	{ WCD939X_MBHC_NEW_PLUG_DETECT_CTL, 0xe9 },
+	{ WCD939X_MBHC_NEW_ZDET_ANA_CTL, 0x0f },
+	{ WCD939X_MBHC_NEW_ZDET_RAMP_CTL, 0x00 },
+	{ WCD939X_MBHC_NEW_FSM_STATUS, 0x00 },
+	{ WCD939X_MBHC_NEW_ADC_RESULT, 0x00 },
+	{ WCD939X_TX_NEW_CH12_MUX, 0x11 },
+	{ WCD939X_TX_NEW_CH34_MUX, 0x23 },
+	{ WCD939X_DIE_CRACK_DET_EN, 0x00 },
+	{ WCD939X_DIE_CRACK_DET_OUT, 0x00 },
+	{ WCD939X_HPH_NEW_INT_RDAC_GAIN_CTL, 0x00 },
+	{ WCD939X_HPH_NEW_INT_PA_GAIN_CTL_L, 0x00 },
+	{ WCD939X_HPH_NEW_INT_RDAC_VREF_CTL, 0x08 },
+	{ WCD939X_HPH_NEW_INT_RDAC_OVERRIDE_CTL, 0x00 },
+	{ WCD939X_HPH_NEW_INT_PA_GAIN_CTL_R, 0x00 },
+	{ WCD939X_HPH_NEW_INT_PA_MISC1, 0x32 },
+	{ WCD939X_HPH_NEW_INT_PA_MISC2, 0x00 },
+	{ WCD939X_HPH_NEW_INT_PA_RDAC_MISC, 0x00 },
+	{ WCD939X_HPH_NEW_INT_TIMER1, 0xfe },
+	{ WCD939X_HPH_NEW_INT_TIMER2, 0x02 },
+	{ WCD939X_HPH_NEW_INT_TIMER3, 0x4e },
+	{ WCD939X_HPH_NEW_INT_TIMER4, 0x54 },
+	{ WCD939X_HPH_NEW_INT_PA_RDAC_MISC2, 0x0b },
+	{ WCD939X_HPH_NEW_INT_PA_RDAC_MISC3, 0x00 },
+	{ WCD939X_HPH_NEW_INT_RDAC_HD2_CTL_L, 0xa0 },
+	{ WCD939X_HPH_NEW_INT_RDAC_HD2_CTL_R, 0xa0 },
+	{ WCD939X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI, 0x64 },
+	{ WCD939X_RX_NEW_INT_HPH_RDAC_BIAS_ULP, 0x01 },
+	{ WCD939X_RX_NEW_INT_HPH_RDAC_LDO_LP, 0x11 },
+	{ WCD939X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL, 0x57 },
+	{ WCD939X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL, 0x01 },
+	{ WCD939X_MBHC_NEW_INT_MECH_DET_CURRENT, 0x00 },
+	{ WCD939X_MBHC_NEW_INT_ZDET_CLK_AND_MOISTURE_CTL_NEW, 0x47 },
+	{ WCD939X_EAR_INT_NEW_CHOPPER_CON, 0xa8 },
+	{ WCD939X_EAR_INT_NEW_CNP_VCM_CON1, 0x42 },
+	{ WCD939X_EAR_INT_NEW_CNP_VCM_CON2, 0x22 },
+	{ WCD939X_EAR_INT_NEW_DYNAMIC_BIAS, 0x00 },
+	{ WCD939X_SLEEP_INT_WATCHDOG_CTL_1, 0x0a },
+	{ WCD939X_SLEEP_INT_WATCHDOG_CTL_2, 0x0a },
+	{ WCD939X_DIE_CRACK_INT_DET_INT1, 0x02 },
+	{ WCD939X_DIE_CRACK_INT_DET_INT2, 0x60 },
+	{ WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L2, 0xff },
+	{ WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L1, 0x7f },
+	{ WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L0, 0x3f },
+	{ WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_ULP1P2M, 0x1f },
+	{ WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_ULP0P6M, 0x0f },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_L2L1, 0xd7 },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_L0, 0xc8 },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_ULP, 0xc6 },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_L2L1, 0x95 },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_L0, 0x6a },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_ULP, 0x05 },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2CASC_L2L1L0, 0xa5 },
+	{ WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2CASC_ULP, 0x13 },
+	{ WCD939X_TX_COM_NEW_INT_ADC_SCBIAS_L2L1, 0x88 },
+	{ WCD939X_TX_COM_NEW_INT_ADC_SCBIAS_L0ULP, 0x42 },
+	{ WCD939X_TX_COM_NEW_INT_ADC_INT_L2, 0xff },
+	{ WCD939X_TX_COM_NEW_INT_ADC_INT_L1, 0x64 },
+	{ WCD939X_TX_COM_NEW_INT_ADC_INT_L0, 0x64 },
+	{ WCD939X_TX_COM_NEW_INT_ADC_INT_ULP, 0x77 },
+	{ WCD939X_DIGITAL_PAGE, 0x00 },
+	{ WCD939X_DIGITAL_CHIP_ID0, 0x00 },
+	{ WCD939X_DIGITAL_CHIP_ID1, 0x00 },
+	{ WCD939X_DIGITAL_CHIP_ID2, 0x0e },
+	{ WCD939X_DIGITAL_CHIP_ID3, 0x01 },
+	{ WCD939X_DIGITAL_SWR_TX_CLK_RATE, 0x00 },
+	{ WCD939X_DIGITAL_CDC_RST_CTL, 0x03 },
+	{ WCD939X_DIGITAL_TOP_CLK_CFG, 0x00 },
+	{ WCD939X_DIGITAL_CDC_ANA_CLK_CTL, 0x00 },
+	{ WCD939X_DIGITAL_CDC_DIG_CLK_CTL, 0xf0 },
+	{ WCD939X_DIGITAL_SWR_RST_EN, 0x00 },
+	{ WCD939X_DIGITAL_CDC_PATH_MODE, 0x55 },
+	{ WCD939X_DIGITAL_CDC_RX_RST, 0x00 },
+	{ WCD939X_DIGITAL_CDC_RX0_CTL, 0xfc },
+	{ WCD939X_DIGITAL_CDC_RX1_CTL, 0xfc },
+	{ WCD939X_DIGITAL_CDC_RX2_CTL, 0xfc },
+	{ WCD939X_DIGITAL_CDC_TX_ANA_MODE_0_1, 0x00 },
+	{ WCD939X_DIGITAL_CDC_TX_ANA_MODE_2_3, 0x00 },
+	{ WCD939X_DIGITAL_CDC_COMP_CTL_0, 0x00 },
+	{ WCD939X_DIGITAL_CDC_ANA_TX_CLK_CTL, 0x1e },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A1_0, 0x00 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A1_1, 0x01 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A2_0, 0x63 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A2_1, 0x04 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A3_0, 0xac },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A3_1, 0x04 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A4_0, 0x1a },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A4_1, 0x03 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A5_0, 0xbc },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A5_1, 0x02 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A6_0, 0xc7 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_A7_0, 0xf8 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_C_0, 0x47 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_C_1, 0x43 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_C_2, 0xb1 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_C_3, 0x17 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R1, 0x4d },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R2, 0x29 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R3, 0x34 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R4, 0x59 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R5, 0x66 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R6, 0x87 },
+	{ WCD939X_DIGITAL_CDC_HPH_DSM_R7, 0x64 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A1_0, 0x00 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A1_1, 0x01 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A2_0, 0x96 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A2_1, 0x09 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A3_0, 0xab },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A3_1, 0x05 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A4_0, 0x1c },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A4_1, 0x02 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A5_0, 0x17 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A5_1, 0x02 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A6_0, 0xaa },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_A7_0, 0xe3 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_C_0, 0x69 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_C_1, 0x54 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_C_2, 0x02 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_C_3, 0x15 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R1, 0xa4 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R2, 0xb5 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R3, 0x86 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R4, 0x85 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R5, 0xaa },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R6, 0xe2 },
+	{ WCD939X_DIGITAL_CDC_EAR_DSM_R7, 0x62 },
+	{ WCD939X_DIGITAL_CDC_HPH_GAIN_RX_0, 0x55 },
+	{ WCD939X_DIGITAL_CDC_HPH_GAIN_RX_1, 0xa9 },
+	{ WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_0, 0x3d },
+	{ WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_1, 0x2e },
+	{ WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_2, 0x01 },
+	{ WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_0, 0x00 },
+	{ WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_1, 0xfc },
+	{ WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_2, 0x01 },
+	{ WCD939X_DIGITAL_CDC_HPH_GAIN_CTL, 0x00 },
+	{ WCD939X_DIGITAL_CDC_EAR_GAIN_CTL, 0x00 },
+	{ WCD939X_DIGITAL_CDC_EAR_PATH_CTL, 0x00 },
+	{ WCD939X_DIGITAL_CDC_SWR_CLH, 0x00 },
+	{ WCD939X_DIGITAL_SWR_CLH_BYP, 0x00 },
+	{ WCD939X_DIGITAL_CDC_TX0_CTL, 0x68 },
+	{ WCD939X_DIGITAL_CDC_TX1_CTL, 0x68 },
+	{ WCD939X_DIGITAL_CDC_TX2_CTL, 0x68 },
+	{ WCD939X_DIGITAL_CDC_TX_RST, 0x00 },
+	{ WCD939X_DIGITAL_CDC_REQ_CTL, 0x01 },
+	{ WCD939X_DIGITAL_CDC_RST, 0x00 },
+	{ WCD939X_DIGITAL_CDC_AMIC_CTL, 0x0f },
+	{ WCD939X_DIGITAL_CDC_DMIC_CTL, 0x04 },
+	{ WCD939X_DIGITAL_CDC_DMIC1_CTL, 0x01 },
+	{ WCD939X_DIGITAL_CDC_DMIC2_CTL, 0x01 },
+	{ WCD939X_DIGITAL_CDC_DMIC3_CTL, 0x01 },
+	{ WCD939X_DIGITAL_CDC_DMIC4_CTL, 0x01 },
+	{ WCD939X_DIGITAL_EFUSE_PRG_CTL, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_CTL, 0x2b },
+	{ WCD939X_DIGITAL_CDC_DMIC_RATE_1_2, 0x11 },
+	{ WCD939X_DIGITAL_CDC_DMIC_RATE_3_4, 0x11 },
+	{ WCD939X_DIGITAL_PDM_WD_CTL0, 0x00 },
+	{ WCD939X_DIGITAL_PDM_WD_CTL1, 0x00 },
+	{ WCD939X_DIGITAL_PDM_WD_CTL2, 0x00 },
+	{ WCD939X_DIGITAL_INTR_MODE, 0x00 },
+	{ WCD939X_DIGITAL_INTR_MASK_0, 0xff },
+	{ WCD939X_DIGITAL_INTR_MASK_1, 0xe7 },
+	{ WCD939X_DIGITAL_INTR_MASK_2, 0x0e },
+	{ WCD939X_DIGITAL_INTR_STATUS_0, 0x00 },
+	{ WCD939X_DIGITAL_INTR_STATUS_1, 0x00 },
+	{ WCD939X_DIGITAL_INTR_STATUS_2, 0x00 },
+	{ WCD939X_DIGITAL_INTR_CLEAR_0, 0x00 },
+	{ WCD939X_DIGITAL_INTR_CLEAR_1, 0x00 },
+	{ WCD939X_DIGITAL_INTR_CLEAR_2, 0x00 },
+	{ WCD939X_DIGITAL_INTR_LEVEL_0, 0x00 },
+	{ WCD939X_DIGITAL_INTR_LEVEL_1, 0x00 },
+	{ WCD939X_DIGITAL_INTR_LEVEL_2, 0x00 },
+	{ WCD939X_DIGITAL_INTR_SET_0, 0x00 },
+	{ WCD939X_DIGITAL_INTR_SET_1, 0x00 },
+	{ WCD939X_DIGITAL_INTR_SET_2, 0x00 },
+	{ WCD939X_DIGITAL_INTR_TEST_0, 0x00 },
+	{ WCD939X_DIGITAL_INTR_TEST_1, 0x00 },
+	{ WCD939X_DIGITAL_INTR_TEST_2, 0x00 },
+	{ WCD939X_DIGITAL_TX_MODE_DBG_EN, 0x00 },
+	{ WCD939X_DIGITAL_TX_MODE_DBG_0_1, 0x00 },
+	{ WCD939X_DIGITAL_TX_MODE_DBG_2_3, 0x00 },
+	{ WCD939X_DIGITAL_LB_IN_SEL_CTL, 0x00 },
+	{ WCD939X_DIGITAL_LOOP_BACK_MODE, 0x00 },
+	{ WCD939X_DIGITAL_SWR_DAC_TEST, 0x00 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_RX_0, 0x40 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_TX_0, 0x40 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_RX_1, 0x00 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_TX_1, 0x00 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_TX_2, 0x00 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_0, 0x00 },
+	{ WCD939X_DIGITAL_SWR_HM_TEST_1, 0x00 },
+	{ WCD939X_DIGITAL_PAD_CTL_SWR_0, 0x8f },
+	{ WCD939X_DIGITAL_PAD_CTL_SWR_1, 0x06 },
+	{ WCD939X_DIGITAL_I2C_CTL, 0x00 },
+	{ WCD939X_DIGITAL_CDC_TX_TANGGU_SW_MODE, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_TEST_CTL_0, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_TEST_CTL_1, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_T_DATA_0, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_T_DATA_1, 0x00 },
+	{ WCD939X_DIGITAL_PAD_CTL_PDM_RX0, 0xf1 },
+	{ WCD939X_DIGITAL_PAD_CTL_PDM_RX1, 0xf1 },
+	{ WCD939X_DIGITAL_PAD_CTL_PDM_TX0, 0xf1 },
+	{ WCD939X_DIGITAL_PAD_CTL_PDM_TX1, 0xf1 },
+	{ WCD939X_DIGITAL_PAD_CTL_PDM_TX2, 0xf1 },
+	{ WCD939X_DIGITAL_PAD_INP_DIS_0, 0x00 },
+	{ WCD939X_DIGITAL_PAD_INP_DIS_1, 0x00 },
+	{ WCD939X_DIGITAL_DRIVE_STRENGTH_0, 0x00 },
+	{ WCD939X_DIGITAL_DRIVE_STRENGTH_1, 0x00 },
+	{ WCD939X_DIGITAL_DRIVE_STRENGTH_2, 0x00 },
+	{ WCD939X_DIGITAL_RX_DATA_EDGE_CTL, 0x1f },
+	{ WCD939X_DIGITAL_TX_DATA_EDGE_CTL, 0x80 },
+	{ WCD939X_DIGITAL_GPIO_MODE, 0x00 },
+	{ WCD939X_DIGITAL_PIN_CTL_OE, 0x00 },
+	{ WCD939X_DIGITAL_PIN_CTL_DATA_0, 0x00 },
+	{ WCD939X_DIGITAL_PIN_CTL_DATA_1, 0x00 },
+	{ WCD939X_DIGITAL_PIN_STATUS_0, 0x00 },
+	{ WCD939X_DIGITAL_PIN_STATUS_1, 0x00 },
+	{ WCD939X_DIGITAL_DIG_DEBUG_CTL, 0x00 },
+	{ WCD939X_DIGITAL_DIG_DEBUG_EN, 0x00 },
+	{ WCD939X_DIGITAL_ANA_CSR_DBG_ADD, 0x00 },
+	{ WCD939X_DIGITAL_ANA_CSR_DBG_CTL, 0x48 },
+	{ WCD939X_DIGITAL_SSP_DBG, 0x00 },
+	{ WCD939X_DIGITAL_MODE_STATUS_0, 0x00 },
+	{ WCD939X_DIGITAL_MODE_STATUS_1, 0x00 },
+	{ WCD939X_DIGITAL_SPARE_0, 0x00 },
+	{ WCD939X_DIGITAL_SPARE_1, 0x00 },
+	{ WCD939X_DIGITAL_SPARE_2, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_0, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_1, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_2, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_3, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_4, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_5, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_6, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_7, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_8, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_9, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_10, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_11, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_12, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_13, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_14, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_15, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_16, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_17, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_18, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_19, 0xff },
+	{ WCD939X_DIGITAL_EFUSE_REG_20, 0x0e },
+	{ WCD939X_DIGITAL_EFUSE_REG_21, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_22, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_23, 0xf6 },
+	{ WCD939X_DIGITAL_EFUSE_REG_24, 0x18 },
+	{ WCD939X_DIGITAL_EFUSE_REG_25, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_26, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_27, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_28, 0x00 },
+	{ WCD939X_DIGITAL_EFUSE_REG_29, 0x0f },
+	{ WCD939X_DIGITAL_EFUSE_REG_30, 0x49 },
+	{ WCD939X_DIGITAL_EFUSE_REG_31, 0x00 },
+	{ WCD939X_DIGITAL_TX_REQ_FB_CTL_0, 0x88 },
+	{ WCD939X_DIGITAL_TX_REQ_FB_CTL_1, 0x88 },
+	{ WCD939X_DIGITAL_TX_REQ_FB_CTL_2, 0x88 },
+	{ WCD939X_DIGITAL_TX_REQ_FB_CTL_3, 0x88 },
+	{ WCD939X_DIGITAL_TX_REQ_FB_CTL_4, 0x88 },
+	{ WCD939X_DIGITAL_DEM_BYPASS_DATA0, 0x55 },
+	{ WCD939X_DIGITAL_DEM_BYPASS_DATA1, 0x55 },
+	{ WCD939X_DIGITAL_DEM_BYPASS_DATA2, 0x55 },
+	{ WCD939X_DIGITAL_DEM_BYPASS_DATA3, 0x01 },
+	{ WCD939X_DIGITAL_DEM_SECOND_ORDER, 0x03 },
+	{ WCD939X_DIGITAL_DSM_CTRL, 0x00 },
+	{ WCD939X_DIGITAL_DSM_0_STATIC_DATA_0, 0x00 },
+	{ WCD939X_DIGITAL_DSM_0_STATIC_DATA_1, 0x00 },
+	{ WCD939X_DIGITAL_DSM_0_STATIC_DATA_2, 0x00 },
+	{ WCD939X_DIGITAL_DSM_0_STATIC_DATA_3, 0x00 },
+	{ WCD939X_DIGITAL_DSM_1_STATIC_DATA_0, 0x00 },
+	{ WCD939X_DIGITAL_DSM_1_STATIC_DATA_1, 0x00 },
+	{ WCD939X_DIGITAL_DSM_1_STATIC_DATA_2, 0x00 },
+	{ WCD939X_DIGITAL_DSM_1_STATIC_DATA_3, 0x00 },
+	{ WCD939X_RX_TOP_PAGE, 0x00 },
+	{ WCD939X_RX_TOP_TOP_CFG0, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_COMP_WR_LSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_COMP_WR_MSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_COMP_LUT, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_COMP_RD_LSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_COMP_RD_MSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_COMP_WR_LSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_COMP_WR_MSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_COMP_LUT, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_COMP_RD_LSB, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_COMP_RD_MSB, 0x00 },
+	{ WCD939X_RX_TOP_DSD0_DEBUG_CFG1, 0x05 },
+	{ WCD939X_RX_TOP_DSD0_DEBUG_CFG2, 0x08 },
+	{ WCD939X_RX_TOP_DSD0_DEBUG_CFG3, 0x00 },
+	{ WCD939X_RX_TOP_DSD0_DEBUG_CFG4, 0x00 },
+	{ WCD939X_RX_TOP_DSD0_DEBUG_CFG5, 0x00 },
+	{ WCD939X_RX_TOP_DSD0_DEBUG_CFG6, 0x00 },
+	{ WCD939X_RX_TOP_DSD1_DEBUG_CFG1, 0x03 },
+	{ WCD939X_RX_TOP_DSD1_DEBUG_CFG2, 0x08 },
+	{ WCD939X_RX_TOP_DSD1_DEBUG_CFG3, 0x00 },
+	{ WCD939X_RX_TOP_DSD1_DEBUG_CFG4, 0x00 },
+	{ WCD939X_RX_TOP_DSD1_DEBUG_CFG5, 0x00 },
+	{ WCD939X_RX_TOP_DSD1_DEBUG_CFG6, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_PATH_CFG0, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_PATH_CFG1, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_PATH_CFG0, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_PATH_CFG1, 0x00 },
+	{ WCD939X_RX_TOP_PATH_CFG2, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_PATH_SEC0, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_PATH_SEC1, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_PATH_SEC2, 0x00 },
+	{ WCD939X_RX_TOP_HPHL_PATH_SEC3, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_PATH_SEC0, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_PATH_SEC1, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_PATH_SEC2, 0x00 },
+	{ WCD939X_RX_TOP_HPHR_PATH_SEC3, 0x00 },
+	{ WCD939X_RX_TOP_PATH_SEC4, 0x00 },
+	{ WCD939X_RX_TOP_PATH_SEC5, 0x00 },
+	{ WCD939X_COMPANDER_HPHL_CTL0, 0x60 },
+	{ WCD939X_COMPANDER_HPHL_CTL1, 0xdb },
+	{ WCD939X_COMPANDER_HPHL_CTL2, 0xff },
+	{ WCD939X_COMPANDER_HPHL_CTL3, 0x35 },
+	{ WCD939X_COMPANDER_HPHL_CTL4, 0xff },
+	{ WCD939X_COMPANDER_HPHL_CTL5, 0x00 },
+	{ WCD939X_COMPANDER_HPHL_CTL6, 0x01 },
+	{ WCD939X_COMPANDER_HPHL_CTL7, 0x08 },
+	{ WCD939X_COMPANDER_HPHL_CTL8, 0x00 },
+	{ WCD939X_COMPANDER_HPHL_CTL9, 0x00 },
+	{ WCD939X_COMPANDER_HPHL_CTL10, 0x06 },
+	{ WCD939X_COMPANDER_HPHL_CTL11, 0x12 },
+	{ WCD939X_COMPANDER_HPHL_CTL12, 0x1e },
+	{ WCD939X_COMPANDER_HPHL_CTL13, 0x2a },
+	{ WCD939X_COMPANDER_HPHL_CTL14, 0x36 },
+	{ WCD939X_COMPANDER_HPHL_CTL15, 0x3c },
+	{ WCD939X_COMPANDER_HPHL_CTL16, 0xc4 },
+	{ WCD939X_COMPANDER_HPHL_CTL17, 0x00 },
+	{ WCD939X_COMPANDER_HPHL_CTL18, 0x0c },
+	{ WCD939X_COMPANDER_HPHL_CTL19, 0x16 },
+	{ WCD939X_R_CTL0, 0x60 },
+	{ WCD939X_R_CTL1, 0xdb },
+	{ WCD939X_R_CTL2, 0xff },
+	{ WCD939X_R_CTL3, 0x35 },
+	{ WCD939X_R_CTL4, 0xff },
+	{ WCD939X_R_CTL5, 0x00 },
+	{ WCD939X_R_CTL6, 0x01 },
+	{ WCD939X_R_CTL7, 0x08 },
+	{ WCD939X_R_CTL8, 0x00 },
+	{ WCD939X_R_CTL9, 0x00 },
+	{ WCD939X_R_CTL10, 0x06 },
+	{ WCD939X_R_CTL11, 0x12 },
+	{ WCD939X_R_CTL12, 0x1e },
+	{ WCD939X_R_CTL13, 0x2a },
+	{ WCD939X_R_CTL14, 0x36 },
+	{ WCD939X_R_CTL15, 0x3c },
+	{ WCD939X_R_CTL16, 0xc4 },
+	{ WCD939X_R_CTL17, 0x00 },
+	{ WCD939X_R_CTL18, 0x0c },
+	{ WCD939X_R_CTL19, 0x16 },
+	{ WCD939X_E_PATH_CTL, 0x00 },
+	{ WCD939X_E_CFG0, 0x07 },
+	{ WCD939X_E_CFG1, 0x3c },
+	{ WCD939X_E_CFG2, 0x00 },
+	{ WCD939X_E_CFG3, 0x00 },
+	{ WCD939X_DSD_HPHL_PATH_CTL, 0x00 },
+	{ WCD939X_DSD_HPHL_CFG0, 0x00 },
+	{ WCD939X_DSD_HPHL_CFG1, 0x00 },
+	{ WCD939X_DSD_HPHL_CFG2, 0x22 },
+	{ WCD939X_DSD_HPHL_CFG3, 0x00 },
+	{ WCD939X_DSD_HPHL_CFG4, 0x1a },
+	{ WCD939X_DSD_HPHL_CFG5, 0x00 },
+	{ WCD939X_DSD_HPHR_PATH_CTL, 0x00 },
+	{ WCD939X_DSD_HPHR_CFG0, 0x00 },
+	{ WCD939X_DSD_HPHR_CFG1, 0x00 },
+	{ WCD939X_DSD_HPHR_CFG2, 0x22 },
+	{ WCD939X_DSD_HPHR_CFG3, 0x00 },
+	{ WCD939X_DSD_HPHR_CFG4, 0x1a },
+	{ WCD939X_DSD_HPHR_CFG5, 0x00 },
+};
+
+static bool wcd939x_rdwr_register(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case WCD939X_ANA_PAGE:
+	case WCD939X_ANA_BIAS:
+	case WCD939X_ANA_RX_SUPPLIES:
+	case WCD939X_ANA_HPH:
+	case WCD939X_ANA_EAR:
+	case WCD939X_ANA_EAR_COMPANDER_CTL:
+	case WCD939X_ANA_TX_CH1:
+	case WCD939X_ANA_TX_CH2:
+	case WCD939X_ANA_TX_CH3:
+	case WCD939X_ANA_TX_CH4:
+	case WCD939X_ANA_MICB1_MICB2_DSP_EN_LOGIC:
+	case WCD939X_ANA_MICB3_DSP_EN_LOGIC:
+	case WCD939X_ANA_MBHC_MECH:
+	case WCD939X_ANA_MBHC_ELECT:
+	case WCD939X_ANA_MBHC_ZDET:
+	case WCD939X_ANA_MBHC_BTN0:
+	case WCD939X_ANA_MBHC_BTN1:
+	case WCD939X_ANA_MBHC_BTN2:
+	case WCD939X_ANA_MBHC_BTN3:
+	case WCD939X_ANA_MBHC_BTN4:
+	case WCD939X_ANA_MBHC_BTN5:
+	case WCD939X_ANA_MBHC_BTN6:
+	case WCD939X_ANA_MBHC_BTN7:
+	case WCD939X_ANA_MICB1:
+	case WCD939X_ANA_MICB2:
+	case WCD939X_ANA_MICB2_RAMP:
+	case WCD939X_ANA_MICB3:
+	case WCD939X_ANA_MICB4:
+	case WCD939X_BIAS_CTL:
+	case WCD939X_BIAS_VBG_FINE_ADJ:
+	case WCD939X_LDOL_VDDCX_ADJUST:
+	case WCD939X_LDOL_DISABLE_LDOL:
+	case WCD939X_MBHC_CTL_CLK:
+	case WCD939X_MBHC_CTL_ANA:
+	case WCD939X_MBHC_ZDET_VNEG_CTL:
+	case WCD939X_MBHC_ZDET_BIAS_CTL:
+	case WCD939X_MBHC_CTL_BCS:
+	case WCD939X_MBHC_TEST_CTL:
+	case WCD939X_LDOH_MODE:
+	case WCD939X_LDOH_BIAS:
+	case WCD939X_LDOH_STB_LOADS:
+	case WCD939X_LDOH_SLOWRAMP:
+	case WCD939X_MICB1_TEST_CTL_1:
+	case WCD939X_MICB1_TEST_CTL_2:
+	case WCD939X_MICB1_TEST_CTL_3:
+	case WCD939X_MICB2_TEST_CTL_1:
+	case WCD939X_MICB2_TEST_CTL_2:
+	case WCD939X_MICB2_TEST_CTL_3:
+	case WCD939X_MICB3_TEST_CTL_1:
+	case WCD939X_MICB3_TEST_CTL_2:
+	case WCD939X_MICB3_TEST_CTL_3:
+	case WCD939X_MICB4_TEST_CTL_1:
+	case WCD939X_MICB4_TEST_CTL_2:
+	case WCD939X_MICB4_TEST_CTL_3:
+	case WCD939X_TX_COM_ADC_VCM:
+	case WCD939X_TX_COM_BIAS_ATEST:
+	case WCD939X_TX_COM_SPARE1:
+	case WCD939X_TX_COM_SPARE2:
+	case WCD939X_TX_COM_TXFE_DIV_CTL:
+	case WCD939X_TX_COM_TXFE_DIV_START:
+	case WCD939X_TX_COM_SPARE3:
+	case WCD939X_TX_COM_SPARE4:
+	case WCD939X_TX_1_2_TEST_EN:
+	case WCD939X_TX_1_2_ADC_IB:
+	case WCD939X_TX_1_2_ATEST_REFCTL:
+	case WCD939X_TX_1_2_TEST_CTL:
+	case WCD939X_TX_1_2_TEST_BLK_EN1:
+	case WCD939X_TX_1_2_TXFE1_CLKDIV:
+	case WCD939X_TX_3_4_TEST_EN:
+	case WCD939X_TX_3_4_ADC_IB:
+	case WCD939X_TX_3_4_ATEST_REFCTL:
+	case WCD939X_TX_3_4_TEST_CTL:
+	case WCD939X_TX_3_4_TEST_BLK_EN3:
+	case WCD939X_TX_3_4_TXFE3_CLKDIV:
+	case WCD939X_TX_3_4_TEST_BLK_EN2:
+	case WCD939X_TX_3_4_TXFE2_CLKDIV:
+	case WCD939X_TX_3_4_SPARE1:
+	case WCD939X_TX_3_4_TEST_BLK_EN4:
+	case WCD939X_TX_3_4_TXFE4_CLKDIV:
+	case WCD939X_TX_3_4_SPARE2:
+	case WCD939X_CLASSH_MODE_1:
+	case WCD939X_CLASSH_MODE_2:
+	case WCD939X_CLASSH_MODE_3:
+	case WCD939X_CLASSH_CTRL_VCL_1:
+	case WCD939X_CLASSH_CTRL_VCL_2:
+	case WCD939X_CLASSH_CTRL_CCL_1:
+	case WCD939X_CLASSH_CTRL_CCL_2:
+	case WCD939X_CLASSH_CTRL_CCL_3:
+	case WCD939X_CLASSH_CTRL_CCL_4:
+	case WCD939X_CLASSH_CTRL_CCL_5:
+	case WCD939X_CLASSH_BUCK_TMUX_A_D:
+	case WCD939X_CLASSH_BUCK_SW_DRV_CNTL:
+	case WCD939X_CLASSH_SPARE:
+	case WCD939X_FLYBACK_EN:
+	case WCD939X_FLYBACK_VNEG_CTRL_1:
+	case WCD939X_FLYBACK_VNEG_CTRL_2:
+	case WCD939X_FLYBACK_VNEG_CTRL_3:
+	case WCD939X_FLYBACK_VNEG_CTRL_4:
+	case WCD939X_FLYBACK_VNEG_CTRL_5:
+	case WCD939X_FLYBACK_VNEG_CTRL_6:
+	case WCD939X_FLYBACK_VNEG_CTRL_7:
+	case WCD939X_FLYBACK_VNEG_CTRL_8:
+	case WCD939X_FLYBACK_VNEG_CTRL_9:
+	case WCD939X_FLYBACK_VNEGDAC_CTRL_1:
+	case WCD939X_FLYBACK_VNEGDAC_CTRL_2:
+	case WCD939X_FLYBACK_VNEGDAC_CTRL_3:
+	case WCD939X_FLYBACK_CTRL_1:
+	case WCD939X_FLYBACK_TEST_CTL:
+	case WCD939X_RX_AUX_SW_CTL:
+	case WCD939X_RX_PA_AUX_IN_CONN:
+	case WCD939X_RX_TIMER_DIV:
+	case WCD939X_RX_OCP_CTL:
+	case WCD939X_RX_OCP_COUNT:
+	case WCD939X_RX_BIAS_EAR_DAC:
+	case WCD939X_RX_BIAS_EAR_AMP:
+	case WCD939X_RX_BIAS_HPH_LDO:
+	case WCD939X_RX_BIAS_HPH_PA:
+	case WCD939X_RX_BIAS_HPH_RDACBUFF_CNP2:
+	case WCD939X_RX_BIAS_HPH_RDAC_LDO:
+	case WCD939X_RX_BIAS_HPH_CNP1:
+	case WCD939X_RX_BIAS_HPH_LOWPOWER:
+	case WCD939X_RX_BIAS_AUX_DAC:
+	case WCD939X_RX_BIAS_AUX_AMP:
+	case WCD939X_RX_BIAS_VNEGDAC_BLEEDER:
+	case WCD939X_RX_BIAS_MISC:
+	case WCD939X_RX_BIAS_BUCK_RST:
+	case WCD939X_RX_BIAS_BUCK_VREF_ERRAMP:
+	case WCD939X_RX_BIAS_FLYB_ERRAMP:
+	case WCD939X_RX_BIAS_FLYB_BUFF:
+	case WCD939X_RX_BIAS_FLYB_MID_RST:
+	case WCD939X_HPH_CNP_EN:
+	case WCD939X_HPH_CNP_WG_CTL:
+	case WCD939X_HPH_CNP_WG_TIME:
+	case WCD939X_HPH_OCP_CTL:
+	case WCD939X_HPH_AUTO_CHOP:
+	case WCD939X_HPH_CHOP_CTL:
+	case WCD939X_HPH_PA_CTL1:
+	case WCD939X_HPH_PA_CTL2:
+	case WCD939X_HPH_L_EN:
+	case WCD939X_HPH_L_TEST:
+	case WCD939X_HPH_L_ATEST:
+	case WCD939X_HPH_R_EN:
+	case WCD939X_HPH_R_TEST:
+	case WCD939X_HPH_R_ATEST:
+	case WCD939X_HPH_RDAC_CLK_CTL1:
+	case WCD939X_HPH_RDAC_CLK_CTL2:
+	case WCD939X_HPH_RDAC_LDO_CTL:
+	case WCD939X_HPH_RDAC_CHOP_CLK_LP_CTL:
+	case WCD939X_HPH_REFBUFF_UHQA_CTL:
+	case WCD939X_HPH_REFBUFF_LP_CTL:
+	case WCD939X_HPH_L_DAC_CTL:
+	case WCD939X_HPH_R_DAC_CTL:
+	case WCD939X_HPH_SURGE_COMP_SEL:
+	case WCD939X_HPH_SURGE_EN:
+	case WCD939X_HPH_SURGE_MISC1:
+	case WCD939X_EAR_EN:
+	case WCD939X_EAR_PA_CON:
+	case WCD939X_EAR_SP_CON:
+	case WCD939X_EAR_DAC_CON:
+	case WCD939X_EAR_CNP_FSM_CON:
+	case WCD939X_EAR_TEST_CTL:
+	case WCD939X_FLYBACK_NEW_CTRL_2:
+	case WCD939X_FLYBACK_NEW_CTRL_3:
+	case WCD939X_FLYBACK_NEW_CTRL_4:
+	case WCD939X_ANA_NEW_PAGE:
+	case WCD939X_HPH_NEW_ANA_HPH2:
+	case WCD939X_HPH_NEW_ANA_HPH3:
+	case WCD939X_SLEEP_CTL:
+	case WCD939X_SLEEP_WATCHDOG_CTL:
+	case WCD939X_MBHC_NEW_ELECT_REM_CLAMP_CTL:
+	case WCD939X_MBHC_NEW_CTL_1:
+	case WCD939X_MBHC_NEW_CTL_2:
+	case WCD939X_MBHC_NEW_PLUG_DETECT_CTL:
+	case WCD939X_MBHC_NEW_ZDET_ANA_CTL:
+	case WCD939X_MBHC_NEW_ZDET_RAMP_CTL:
+	case WCD939X_TX_NEW_CH12_MUX:
+	case WCD939X_TX_NEW_CH34_MUX:
+	case WCD939X_DIE_CRACK_DET_EN:
+	case WCD939X_HPH_NEW_INT_RDAC_GAIN_CTL:
+	case WCD939X_HPH_NEW_INT_PA_GAIN_CTL_L:
+	case WCD939X_HPH_NEW_INT_RDAC_VREF_CTL:
+	case WCD939X_HPH_NEW_INT_RDAC_OVERRIDE_CTL:
+	case WCD939X_HPH_NEW_INT_PA_GAIN_CTL_R:
+	case WCD939X_HPH_NEW_INT_PA_MISC1:
+	case WCD939X_HPH_NEW_INT_PA_MISC2:
+	case WCD939X_HPH_NEW_INT_PA_RDAC_MISC:
+	case WCD939X_HPH_NEW_INT_TIMER1:
+	case WCD939X_HPH_NEW_INT_TIMER2:
+	case WCD939X_HPH_NEW_INT_TIMER3:
+	case WCD939X_HPH_NEW_INT_TIMER4:
+	case WCD939X_HPH_NEW_INT_PA_RDAC_MISC2:
+	case WCD939X_HPH_NEW_INT_PA_RDAC_MISC3:
+	case WCD939X_HPH_NEW_INT_RDAC_HD2_CTL_L:
+	case WCD939X_HPH_NEW_INT_RDAC_HD2_CTL_R:
+	case WCD939X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI:
+	case WCD939X_RX_NEW_INT_HPH_RDAC_BIAS_ULP:
+	case WCD939X_RX_NEW_INT_HPH_RDAC_LDO_LP:
+	case WCD939X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL:
+	case WCD939X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL:
+	case WCD939X_MBHC_NEW_INT_MECH_DET_CURRENT:
+	case WCD939X_MBHC_NEW_INT_ZDET_CLK_AND_MOISTURE_CTL_NEW:
+	case WCD939X_EAR_INT_NEW_CHOPPER_CON:
+	case WCD939X_EAR_INT_NEW_CNP_VCM_CON1:
+	case WCD939X_EAR_INT_NEW_CNP_VCM_CON2:
+	case WCD939X_EAR_INT_NEW_DYNAMIC_BIAS:
+	case WCD939X_SLEEP_INT_WATCHDOG_CTL_1:
+	case WCD939X_SLEEP_INT_WATCHDOG_CTL_2:
+	case WCD939X_DIE_CRACK_INT_DET_INT1:
+	case WCD939X_DIE_CRACK_INT_DET_INT2:
+	case WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L2:
+	case WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L1:
+	case WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L0:
+	case WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_ULP1P2M:
+	case WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_ULP0P6M:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_L2L1:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_L0:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_ULP:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_L2L1:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_L0:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_ULP:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2CASC_L2L1L0:
+	case WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2CASC_ULP:
+	case WCD939X_TX_COM_NEW_INT_ADC_SCBIAS_L2L1:
+	case WCD939X_TX_COM_NEW_INT_ADC_SCBIAS_L0ULP:
+	case WCD939X_TX_COM_NEW_INT_ADC_INT_L2:
+	case WCD939X_TX_COM_NEW_INT_ADC_INT_L1:
+	case WCD939X_TX_COM_NEW_INT_ADC_INT_L0:
+	case WCD939X_TX_COM_NEW_INT_ADC_INT_ULP:
+	case WCD939X_DIGITAL_PAGE:
+	case WCD939X_DIGITAL_SWR_TX_CLK_RATE:
+	case WCD939X_DIGITAL_CDC_RST_CTL:
+	case WCD939X_DIGITAL_TOP_CLK_CFG:
+	case WCD939X_DIGITAL_CDC_ANA_CLK_CTL:
+	case WCD939X_DIGITAL_CDC_DIG_CLK_CTL:
+	case WCD939X_DIGITAL_SWR_RST_EN:
+	case WCD939X_DIGITAL_CDC_PATH_MODE:
+	case WCD939X_DIGITAL_CDC_RX_RST:
+	case WCD939X_DIGITAL_CDC_RX0_CTL:
+	case WCD939X_DIGITAL_CDC_RX1_CTL:
+	case WCD939X_DIGITAL_CDC_RX2_CTL:
+	case WCD939X_DIGITAL_CDC_TX_ANA_MODE_0_1:
+	case WCD939X_DIGITAL_CDC_TX_ANA_MODE_2_3:
+	case WCD939X_DIGITAL_CDC_COMP_CTL_0:
+	case WCD939X_DIGITAL_CDC_ANA_TX_CLK_CTL:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A1_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A1_1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A2_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A2_1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A3_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A3_1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A4_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A4_1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A5_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A5_1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A6_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_A7_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_C_0:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_C_1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_C_2:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_C_3:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R1:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R2:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R3:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R4:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R5:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R6:
+	case WCD939X_DIGITAL_CDC_HPH_DSM_R7:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A1_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A1_1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A2_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A2_1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A3_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A3_1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A4_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A4_1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A5_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A5_1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A6_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_A7_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_C_0:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_C_1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_C_2:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_C_3:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R1:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R2:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R3:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R4:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R5:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R6:
+	case WCD939X_DIGITAL_CDC_EAR_DSM_R7:
+	case WCD939X_DIGITAL_CDC_HPH_GAIN_RX_0:
+	case WCD939X_DIGITAL_CDC_HPH_GAIN_RX_1:
+	case WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_0:
+	case WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_1:
+	case WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_2:
+	case WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_0:
+	case WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_1:
+	case WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_2:
+	case WCD939X_DIGITAL_CDC_HPH_GAIN_CTL:
+	case WCD939X_DIGITAL_CDC_EAR_GAIN_CTL:
+	case WCD939X_DIGITAL_CDC_EAR_PATH_CTL:
+	case WCD939X_DIGITAL_CDC_SWR_CLH:
+	case WCD939X_DIGITAL_SWR_CLH_BYP:
+	case WCD939X_DIGITAL_CDC_TX0_CTL:
+	case WCD939X_DIGITAL_CDC_TX1_CTL:
+	case WCD939X_DIGITAL_CDC_TX2_CTL:
+	case WCD939X_DIGITAL_CDC_TX_RST:
+	case WCD939X_DIGITAL_CDC_REQ_CTL:
+	case WCD939X_DIGITAL_CDC_RST:
+	case WCD939X_DIGITAL_CDC_AMIC_CTL:
+	case WCD939X_DIGITAL_CDC_DMIC_CTL:
+	case WCD939X_DIGITAL_CDC_DMIC1_CTL:
+	case WCD939X_DIGITAL_CDC_DMIC2_CTL:
+	case WCD939X_DIGITAL_CDC_DMIC3_CTL:
+	case WCD939X_DIGITAL_CDC_DMIC4_CTL:
+	case WCD939X_DIGITAL_EFUSE_PRG_CTL:
+	case WCD939X_DIGITAL_EFUSE_CTL:
+	case WCD939X_DIGITAL_CDC_DMIC_RATE_1_2:
+	case WCD939X_DIGITAL_CDC_DMIC_RATE_3_4:
+	case WCD939X_DIGITAL_PDM_WD_CTL0:
+	case WCD939X_DIGITAL_PDM_WD_CTL1:
+	case WCD939X_DIGITAL_PDM_WD_CTL2:
+	case WCD939X_DIGITAL_INTR_MODE:
+	case WCD939X_DIGITAL_INTR_MASK_0:
+	case WCD939X_DIGITAL_INTR_MASK_1:
+	case WCD939X_DIGITAL_INTR_MASK_2:
+	case WCD939X_DIGITAL_INTR_CLEAR_0:
+	case WCD939X_DIGITAL_INTR_CLEAR_1:
+	case WCD939X_DIGITAL_INTR_CLEAR_2:
+	case WCD939X_DIGITAL_INTR_LEVEL_0:
+	case WCD939X_DIGITAL_INTR_LEVEL_1:
+	case WCD939X_DIGITAL_INTR_LEVEL_2:
+	case WCD939X_DIGITAL_INTR_SET_0:
+	case WCD939X_DIGITAL_INTR_SET_1:
+	case WCD939X_DIGITAL_INTR_SET_2:
+	case WCD939X_DIGITAL_INTR_TEST_0:
+	case WCD939X_DIGITAL_INTR_TEST_1:
+	case WCD939X_DIGITAL_INTR_TEST_2:
+	case WCD939X_DIGITAL_TX_MODE_DBG_EN:
+	case WCD939X_DIGITAL_TX_MODE_DBG_0_1:
+	case WCD939X_DIGITAL_TX_MODE_DBG_2_3:
+	case WCD939X_DIGITAL_LB_IN_SEL_CTL:
+	case WCD939X_DIGITAL_LOOP_BACK_MODE:
+	case WCD939X_DIGITAL_SWR_DAC_TEST:
+	case WCD939X_DIGITAL_SWR_HM_TEST_RX_0:
+	case WCD939X_DIGITAL_SWR_HM_TEST_TX_0:
+	case WCD939X_DIGITAL_SWR_HM_TEST_RX_1:
+	case WCD939X_DIGITAL_SWR_HM_TEST_TX_1:
+	case WCD939X_DIGITAL_SWR_HM_TEST_TX_2:
+	case WCD939X_DIGITAL_PAD_CTL_SWR_0:
+	case WCD939X_DIGITAL_PAD_CTL_SWR_1:
+	case WCD939X_DIGITAL_I2C_CTL:
+	case WCD939X_DIGITAL_CDC_TX_TANGGU_SW_MODE:
+	case WCD939X_DIGITAL_EFUSE_TEST_CTL_0:
+	case WCD939X_DIGITAL_EFUSE_TEST_CTL_1:
+	case WCD939X_DIGITAL_PAD_CTL_PDM_RX0:
+	case WCD939X_DIGITAL_PAD_CTL_PDM_RX1:
+	case WCD939X_DIGITAL_PAD_CTL_PDM_TX0:
+	case WCD939X_DIGITAL_PAD_CTL_PDM_TX1:
+	case WCD939X_DIGITAL_PAD_CTL_PDM_TX2:
+	case WCD939X_DIGITAL_PAD_INP_DIS_0:
+	case WCD939X_DIGITAL_PAD_INP_DIS_1:
+	case WCD939X_DIGITAL_DRIVE_STRENGTH_0:
+	case WCD939X_DIGITAL_DRIVE_STRENGTH_1:
+	case WCD939X_DIGITAL_DRIVE_STRENGTH_2:
+	case WCD939X_DIGITAL_RX_DATA_EDGE_CTL:
+	case WCD939X_DIGITAL_TX_DATA_EDGE_CTL:
+	case WCD939X_DIGITAL_GPIO_MODE:
+	case WCD939X_DIGITAL_PIN_CTL_OE:
+	case WCD939X_DIGITAL_PIN_CTL_DATA_0:
+	case WCD939X_DIGITAL_PIN_CTL_DATA_1:
+	case WCD939X_DIGITAL_DIG_DEBUG_CTL:
+	case WCD939X_DIGITAL_DIG_DEBUG_EN:
+	case WCD939X_DIGITAL_ANA_CSR_DBG_ADD:
+	case WCD939X_DIGITAL_ANA_CSR_DBG_CTL:
+	case WCD939X_DIGITAL_SSP_DBG:
+	case WCD939X_DIGITAL_SPARE_0:
+	case WCD939X_DIGITAL_SPARE_1:
+	case WCD939X_DIGITAL_SPARE_2:
+	case WCD939X_DIGITAL_TX_REQ_FB_CTL_0:
+	case WCD939X_DIGITAL_TX_REQ_FB_CTL_1:
+	case WCD939X_DIGITAL_TX_REQ_FB_CTL_2:
+	case WCD939X_DIGITAL_TX_REQ_FB_CTL_3:
+	case WCD939X_DIGITAL_TX_REQ_FB_CTL_4:
+	case WCD939X_DIGITAL_DEM_BYPASS_DATA0:
+	case WCD939X_DIGITAL_DEM_BYPASS_DATA1:
+	case WCD939X_DIGITAL_DEM_BYPASS_DATA2:
+	case WCD939X_DIGITAL_DEM_BYPASS_DATA3:
+	case WCD939X_DIGITAL_DEM_SECOND_ORDER:
+	case WCD939X_DIGITAL_DSM_CTRL:
+	case WCD939X_DIGITAL_DSM_0_STATIC_DATA_0:
+	case WCD939X_DIGITAL_DSM_0_STATIC_DATA_1:
+	case WCD939X_DIGITAL_DSM_0_STATIC_DATA_2:
+	case WCD939X_DIGITAL_DSM_0_STATIC_DATA_3:
+	case WCD939X_DIGITAL_DSM_1_STATIC_DATA_0:
+	case WCD939X_DIGITAL_DSM_1_STATIC_DATA_1:
+	case WCD939X_DIGITAL_DSM_1_STATIC_DATA_2:
+	case WCD939X_DIGITAL_DSM_1_STATIC_DATA_3:
+	case WCD939X_RX_TOP_PAGE:
+	case WCD939X_RX_TOP_TOP_CFG0:
+	case WCD939X_RX_TOP_HPHL_COMP_WR_LSB:
+	case WCD939X_RX_TOP_HPHL_COMP_WR_MSB:
+	case WCD939X_RX_TOP_HPHL_COMP_LUT:
+	case WCD939X_RX_TOP_HPHR_COMP_WR_LSB:
+	case WCD939X_RX_TOP_HPHR_COMP_WR_MSB:
+	case WCD939X_RX_TOP_HPHR_COMP_LUT:
+	case WCD939X_RX_TOP_DSD0_DEBUG_CFG1:
+	case WCD939X_RX_TOP_DSD0_DEBUG_CFG2:
+	case WCD939X_RX_TOP_DSD0_DEBUG_CFG3:
+	case WCD939X_RX_TOP_DSD0_DEBUG_CFG4:
+	case WCD939X_RX_TOP_DSD1_DEBUG_CFG1:
+	case WCD939X_RX_TOP_DSD1_DEBUG_CFG2:
+	case WCD939X_RX_TOP_DSD1_DEBUG_CFG3:
+	case WCD939X_RX_TOP_DSD1_DEBUG_CFG4:
+	case WCD939X_RX_TOP_HPHL_PATH_CFG0:
+	case WCD939X_RX_TOP_HPHL_PATH_CFG1:
+	case WCD939X_RX_TOP_HPHR_PATH_CFG0:
+	case WCD939X_RX_TOP_HPHR_PATH_CFG1:
+	case WCD939X_RX_TOP_PATH_CFG2:
+	case WCD939X_RX_TOP_HPHL_PATH_SEC0:
+	case WCD939X_RX_TOP_HPHL_PATH_SEC1:
+	case WCD939X_RX_TOP_HPHL_PATH_SEC2:
+	case WCD939X_RX_TOP_HPHL_PATH_SEC3:
+	case WCD939X_RX_TOP_HPHR_PATH_SEC0:
+	case WCD939X_RX_TOP_HPHR_PATH_SEC1:
+	case WCD939X_RX_TOP_HPHR_PATH_SEC2:
+	case WCD939X_RX_TOP_HPHR_PATH_SEC3:
+	case WCD939X_RX_TOP_PATH_SEC4:
+	case WCD939X_RX_TOP_PATH_SEC5:
+	case WCD939X_COMPANDER_HPHL_CTL0:
+	case WCD939X_COMPANDER_HPHL_CTL1:
+	case WCD939X_COMPANDER_HPHL_CTL2:
+	case WCD939X_COMPANDER_HPHL_CTL3:
+	case WCD939X_COMPANDER_HPHL_CTL4:
+	case WCD939X_COMPANDER_HPHL_CTL5:
+	case WCD939X_COMPANDER_HPHL_CTL7:
+	case WCD939X_COMPANDER_HPHL_CTL8:
+	case WCD939X_COMPANDER_HPHL_CTL9:
+	case WCD939X_COMPANDER_HPHL_CTL10:
+	case WCD939X_COMPANDER_HPHL_CTL11:
+	case WCD939X_COMPANDER_HPHL_CTL12:
+	case WCD939X_COMPANDER_HPHL_CTL13:
+	case WCD939X_COMPANDER_HPHL_CTL14:
+	case WCD939X_COMPANDER_HPHL_CTL15:
+	case WCD939X_COMPANDER_HPHL_CTL16:
+	case WCD939X_COMPANDER_HPHL_CTL17:
+	case WCD939X_COMPANDER_HPHL_CTL18:
+	case WCD939X_COMPANDER_HPHL_CTL19:
+	case WCD939X_R_CTL0:
+	case WCD939X_R_CTL1:
+	case WCD939X_R_CTL2:
+	case WCD939X_R_CTL3:
+	case WCD939X_R_CTL4:
+	case WCD939X_R_CTL5:
+	case WCD939X_R_CTL7:
+	case WCD939X_R_CTL8:
+	case WCD939X_R_CTL9:
+	case WCD939X_R_CTL10:
+	case WCD939X_R_CTL11:
+	case WCD939X_R_CTL12:
+	case WCD939X_R_CTL13:
+	case WCD939X_R_CTL14:
+	case WCD939X_R_CTL15:
+	case WCD939X_R_CTL16:
+	case WCD939X_R_CTL17:
+	case WCD939X_R_CTL18:
+	case WCD939X_R_CTL19:
+	case WCD939X_E_PATH_CTL:
+	case WCD939X_E_CFG0:
+	case WCD939X_E_CFG1:
+	case WCD939X_E_CFG2:
+	case WCD939X_E_CFG3:
+	case WCD939X_DSD_HPHL_PATH_CTL:
+	case WCD939X_DSD_HPHL_CFG0:
+	case WCD939X_DSD_HPHL_CFG1:
+	case WCD939X_DSD_HPHL_CFG2:
+	case WCD939X_DSD_HPHL_CFG3:
+	case WCD939X_DSD_HPHL_CFG4:
+	case WCD939X_DSD_HPHL_CFG5:
+	case WCD939X_DSD_HPHR_PATH_CTL:
+	case WCD939X_DSD_HPHR_CFG0:
+	case WCD939X_DSD_HPHR_CFG1:
+	case WCD939X_DSD_HPHR_CFG2:
+	case WCD939X_DSD_HPHR_CFG3:
+	case WCD939X_DSD_HPHR_CFG4:
+	case WCD939X_DSD_HPHR_CFG5:
+		return true;
+	}
+
+	return false;
+}
+
+static bool wcd939x_readonly_register(struct device *dev, unsigned int reg)
+{
+	if (reg <= WCD939X_BASE)
+		return false;
+
+	switch (reg) {
+	case WCD939X_ANA_MBHC_RESULT_1:
+	case WCD939X_ANA_MBHC_RESULT_2:
+	case WCD939X_ANA_MBHC_RESULT_3:
+	case WCD939X_MBHC_MOISTURE_DET_FSM_STATUS:
+	case WCD939X_TX_1_2_SAR2_ERR:
+	case WCD939X_TX_1_2_SAR1_ERR:
+	case WCD939X_TX_3_4_SAR4_ERR:
+	case WCD939X_TX_3_4_SAR3_ERR:
+	case WCD939X_HPH_L_STATUS:
+	case WCD939X_HPH_R_STATUS:
+	case WCD939X_HPH_SURGE_STATUS:
+	case WCD939X_EAR_STATUS_REG_1:
+	case WCD939X_EAR_STATUS_REG_2:
+	case WCD939X_MBHC_NEW_FSM_STATUS:
+	case WCD939X_MBHC_NEW_ADC_RESULT:
+	case WCD939X_DIE_CRACK_DET_OUT:
+	case WCD939X_DIGITAL_CHIP_ID0:
+	case WCD939X_DIGITAL_CHIP_ID1:
+	case WCD939X_DIGITAL_CHIP_ID2:
+	case WCD939X_DIGITAL_CHIP_ID3:
+	case WCD939X_DIGITAL_INTR_STATUS_0:
+	case WCD939X_DIGITAL_INTR_STATUS_1:
+	case WCD939X_DIGITAL_INTR_STATUS_2:
+	case WCD939X_DIGITAL_SWR_HM_TEST_0:
+	case WCD939X_DIGITAL_SWR_HM_TEST_1:
+	case WCD939X_DIGITAL_EFUSE_T_DATA_0:
+	case WCD939X_DIGITAL_EFUSE_T_DATA_1:
+	case WCD939X_DIGITAL_PIN_STATUS_0:
+	case WCD939X_DIGITAL_PIN_STATUS_1:
+	case WCD939X_DIGITAL_MODE_STATUS_0:
+	case WCD939X_DIGITAL_MODE_STATUS_1:
+	case WCD939X_DIGITAL_EFUSE_REG_0:
+	case WCD939X_DIGITAL_EFUSE_REG_1:
+	case WCD939X_DIGITAL_EFUSE_REG_2:
+	case WCD939X_DIGITAL_EFUSE_REG_3:
+	case WCD939X_DIGITAL_EFUSE_REG_4:
+	case WCD939X_DIGITAL_EFUSE_REG_5:
+	case WCD939X_DIGITAL_EFUSE_REG_6:
+	case WCD939X_DIGITAL_EFUSE_REG_7:
+	case WCD939X_DIGITAL_EFUSE_REG_8:
+	case WCD939X_DIGITAL_EFUSE_REG_9:
+	case WCD939X_DIGITAL_EFUSE_REG_10:
+	case WCD939X_DIGITAL_EFUSE_REG_11:
+	case WCD939X_DIGITAL_EFUSE_REG_12:
+	case WCD939X_DIGITAL_EFUSE_REG_13:
+	case WCD939X_DIGITAL_EFUSE_REG_14:
+	case WCD939X_DIGITAL_EFUSE_REG_15:
+	case WCD939X_DIGITAL_EFUSE_REG_16:
+	case WCD939X_DIGITAL_EFUSE_REG_17:
+	case WCD939X_DIGITAL_EFUSE_REG_18:
+	case WCD939X_DIGITAL_EFUSE_REG_19:
+	case WCD939X_DIGITAL_EFUSE_REG_20:
+	case WCD939X_DIGITAL_EFUSE_REG_21:
+	case WCD939X_DIGITAL_EFUSE_REG_22:
+	case WCD939X_DIGITAL_EFUSE_REG_23:
+	case WCD939X_DIGITAL_EFUSE_REG_24:
+	case WCD939X_DIGITAL_EFUSE_REG_25:
+	case WCD939X_DIGITAL_EFUSE_REG_26:
+	case WCD939X_DIGITAL_EFUSE_REG_27:
+	case WCD939X_DIGITAL_EFUSE_REG_28:
+	case WCD939X_DIGITAL_EFUSE_REG_29:
+	case WCD939X_DIGITAL_EFUSE_REG_30:
+	case WCD939X_DIGITAL_EFUSE_REG_31:
+	case WCD939X_RX_TOP_HPHL_COMP_RD_LSB:
+	case WCD939X_RX_TOP_HPHL_COMP_RD_MSB:
+	case WCD939X_RX_TOP_HPHR_COMP_RD_LSB:
+	case WCD939X_RX_TOP_HPHR_COMP_RD_MSB:
+	case WCD939X_RX_TOP_DSD0_DEBUG_CFG5:
+	case WCD939X_RX_TOP_DSD0_DEBUG_CFG6:
+	case WCD939X_RX_TOP_DSD1_DEBUG_CFG5:
+	case WCD939X_RX_TOP_DSD1_DEBUG_CFG6:
+	case WCD939X_COMPANDER_HPHL_CTL6:
+	case WCD939X_R_CTL6:
+		return true;
+	}
+	return false;
+}
+
+static bool wcd939x_readable_register(struct device *dev, unsigned int reg)
+{
+	bool ret;
+
+	ret = wcd939x_readonly_register(dev, reg);
+	if (!ret)
+		return wcd939x_rdwr_register(dev, reg);
+
+	return ret;
+}
+
+static bool wcd939x_writeable_register(struct device *dev, unsigned int reg)
+{
+	return wcd939x_rdwr_register(dev, reg);
+}
+
+static const struct regmap_config wcd939x_regmap_config = {
+	.name = "wcd939x_csr",
+	.reg_bits = 32,
+	.val_bits = 8,
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = wcd939x_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wcd939x_defaults),
+	.max_register = WCD939X_MAX_REGISTER,
+	.readable_reg = wcd939x_readable_register,
+	.writeable_reg = wcd939x_writeable_register,
+	/* Consider all readonly registers as volatile */
+	.volatile_reg = wcd939x_readonly_register,
+};
+
+static const struct sdw_slave_ops wcd9390_slave_ops = {
+	.update_status = wcd9390_update_status,
+	.interrupt_callback = wcd9390_interrupt_callback,
+	.bus_config = wcd9390_bus_config,
+};
+
+static int wcd939x_sdw_component_bind(struct device *dev, struct device *master,
+				      void *data)
+{
+	/* Bind is required by component framework */
+	return 0;
+}
+
+static void wcd939x_sdw_component_unbind(struct device *dev,
+					 struct device *master, void *data)
+{
+	/* Unbind is required by component framework */
+}
+
+static const struct component_ops wcd939x_sdw_component_ops = {
+	.bind = wcd939x_sdw_component_bind,
+	.unbind = wcd939x_sdw_component_unbind,
+};
+
+static int wcd9390_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct wcd939x_sdw_priv *wcd;
+	int ret;
+
+	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
+	if (!wcd)
+		return -ENOMEM;
+
+	/*
+	 * Port map index starts with 0, however the data port for this codec
+	 * are from index 1
+	 */
+	if (of_property_read_bool(dev->of_node, "qcom,tx-port-mapping")) {
+		wcd->is_tx = true;
+		ret = of_property_read_u32_array(dev->of_node,
+						 "qcom,tx-port-mapping",
+						 &pdev->m_port_map[1],
+						 WCD939X_MAX_TX_SWR_PORTS);
+	} else {
+		ret = of_property_read_u32_array(dev->of_node,
+						 "qcom,rx-port-mapping",
+						 &pdev->m_port_map[1],
+						 WCD939X_MAX_RX_SWR_PORTS);
+	}
+
+	if (ret < 0)
+		dev_info(dev, "Static Port mapping not specified\n");
+
+	wcd->sdev = pdev;
+	dev_set_drvdata(dev, wcd);
+
+	pdev->prop.scp_int1_mask = SDW_SCP_INT1_IMPL_DEF |
+				   SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	pdev->prop.lane_control_support = true;
+	pdev->prop.simple_clk_stop_capable = true;
+	if (wcd->is_tx) {
+		pdev->prop.source_ports = GENMASK(WCD939X_MAX_TX_SWR_PORTS, 0);
+		pdev->prop.src_dpn_prop = wcd939x_tx_dpn_prop;
+		wcd->ch_info = &wcd939x_sdw_tx_ch_info[0];
+		pdev->prop.wake_capable = true;
+	} else {
+		pdev->prop.sink_ports = GENMASK(WCD939X_MAX_RX_SWR_PORTS, 0);
+		pdev->prop.sink_dpn_prop = wcd939x_rx_dpn_prop;
+		wcd->ch_info = &wcd939x_sdw_rx_ch_info[0];
+	}
+
+	if (wcd->is_tx) {
+		wcd->regmap = devm_regmap_init_sdw(pdev, &wcd939x_regmap_config);
+		if (IS_ERR(wcd->regmap))
+			return dev_err_probe(dev, PTR_ERR(wcd->regmap),
+					     "Regmap init failed\n");
+
+		/* Start in cache-only until device is enumerated */
+		regcache_cache_only(wcd->regmap, true);
+	}
+
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = component_add(dev, &wcd939x_sdw_component_ops);
+	if (ret)
+		goto err_disable_rpm;
+
+	return 0;
+
+err_disable_rpm:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return ret;
+}
+
+static int wcd9390_remove(struct sdw_slave *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	component_del(dev, &wcd939x_sdw_component_ops);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+
+	return 0;
+}
+
+static const struct sdw_device_id wcd9390_slave_id[] = {
+	SDW_SLAVE_ENTRY(0x0217, 0x10e, 0), /* WCD9390 & WCD9390 RX/TX Device ID */
+	{},
+};
+MODULE_DEVICE_TABLE(sdw, wcd9390_slave_id);
+
+static int __maybe_unused wcd939x_sdw_runtime_suspend(struct device *dev)
+{
+	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(dev);
+
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, true);
+		regcache_mark_dirty(wcd->regmap);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused wcd939x_sdw_runtime_resume(struct device *dev)
+{
+	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(dev);
+
+	if (wcd->regmap) {
+		regcache_cache_only(wcd->regmap, false);
+		regcache_sync(wcd->regmap);
+	}
+
+	pm_runtime_mark_last_busy(dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops wcd939x_sdw_pm_ops = {
+	SET_RUNTIME_PM_OPS(wcd939x_sdw_runtime_suspend, wcd939x_sdw_runtime_resume, NULL)
+};
+
+static struct sdw_driver wcd9390_codec_driver = {
+	.probe = wcd9390_probe,
+	.remove = wcd9390_remove,
+	.ops = &wcd9390_slave_ops,
+	.id_table = wcd9390_slave_id,
+	.driver = {
+		.name = "wcd9390-codec",
+		.pm = &wcd939x_sdw_pm_ops,
+	}
+};
+module_sdw_driver(wcd9390_codec_driver);
+
+MODULE_DESCRIPTION("WCD939X SDW codec driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
new file mode 100644
index 000000000000..5febc48b5759
--- /dev/null
+++ b/sound/soc/codecs/wcd939x.h
@@ -0,0 +1,983 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2018-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __WCD939X_H__
+#define __WCD939X_H__
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+
+#define WCD939X_BASE					   (0x3000)
+#define WCD939X_ANA_PAGE				   (0x3000)
+#define WCD939X_ANA_BIAS				   (0x3001)
+#define WCD939X_BIAS_ANALOG_BIAS_EN	BIT(7)
+#define WCD939X_BIAS_PRECHRG_EN	BIT(6)
+#define WCD939X_BIAS_PRECHRG_CTL_MODE	BIT(5)
+#define WCD939X_ANA_RX_SUPPLIES				   (0x3008)
+#define WCD939X_RX_SUPPLIES_VPOS_EN	BIT(7)
+#define WCD939X_RX_SUPPLIES_VNEG_EN	BIT(6)
+#define WCD939X_RX_SUPPLIES_VPOS_PWR_LVL	BIT(3)
+#define WCD939X_RX_SUPPLIES_VNEG_PWR_LVL	BIT(2)
+#define WCD939X_RX_SUPPLIES_REGULATOR_MODE	BIT(1)
+#define WCD939X_RX_SUPPLIES_RX_BIAS_ENABLE	BIT(0)
+#define WCD939X_ANA_HPH					   (0x3009)
+#define WCD939X_HPH_HPHL_ENABLE	BIT(7)
+#define WCD939X_HPH_HPHR_ENABLE	BIT(6)
+#define WCD939X_HPH_HPHL_REF_ENABLE	BIT(5)
+#define WCD939X_HPH_HPHR_REF_ENABLE	BIT(4)
+#define WCD939X_HPH_PWR_LEVEL	GENMASK(3, 2)
+#define WCD939X_ANA_EAR					   (0x300a)
+#define WCD939X_ANA_EAR_COMPANDER_CTL			   (0x300b)
+#define WCD939X_EAR_COMPANDER_CTL_GAIN_OVRD_REG	BIT(7)
+#define WCD939X_EAR_COMPANDER_CTL_EAR_GAIN	GENMASK(6, 2)
+#define WCD939X_EAR_COMPANDER_CTL_COMP_DFF_BYP	BIT(1)
+#define WCD939X_EAR_COMPANDER_CTL_COMP_DFF_CLK_EDGE	BIT(0)
+#define WCD939X_ANA_TX_CH1				   (0x300e)
+#define WCD939X_ANA_TX_CH2				   (0x300f)
+#define WCD939X_TX_CH2_ENABLE	BIT(7)
+#define WCD939X_TX_CH2_HPF1_INIT	BIT(6)
+#define WCD939X_TX_CH2_HPF2_INIT	BIT(5)
+#define WCD939X_TX_CH2_GAIN	GENMASK(4, 0)
+#define WCD939X_ANA_TX_CH3				   (0x3010)
+#define WCD939X_ANA_TX_CH4				   (0x3011)
+#define WCD939X_TX_CH4_ENABLE	BIT(7)
+#define WCD939X_TX_CH4_HPF3_INIT	BIT(6)
+#define WCD939X_TX_CH4_HPF4_INIT	BIT(5)
+#define WCD939X_TX_CH4_GAIN	GENMASK(4, 0)
+#define WCD939X_ANA_MICB1_MICB2_DSP_EN_LOGIC		   (0x3012)
+#define WCD939X_ANA_MICB3_DSP_EN_LOGIC			   (0x3013)
+#define WCD939X_ANA_MBHC_MECH				   (0x3014)
+#define WCD939X_MBHC_MECH_L_DET_EN	BIT(7)
+#define WCD939X_MBHC_MECH_GND_DET_EN	BIT(6)
+#define WCD939X_MBHC_MECH_MECH_DETECT_TYPE	BIT(5)
+#define WCD939X_MBHC_MECH_HPHL_PLUG_TYPE	BIT(4)
+#define WCD939X_MBHC_MECH_GND_PLUG_TYPE	BIT(3)
+#define WCD939X_MBHC_MECH_MECH_HS_L_PULLUP_COMP_EN	BIT(2)
+#define WCD939X_MBHC_MECH_MECH_HS_G_PULLUP_COMP_EN	BIT(1)
+#define WCD939X_MBHC_MECH_SW_HPH_L_P_100K_TO_GND	BIT(0)
+#define WCD939X_ANA_MBHC_ELECT				   (0x3015)
+#define WCD939X_MBHC_ELECT_FSM_EN	BIT(7)
+#define WCD939X_MBHC_ELECT_BTNDET_ISRC_CTL	GENMASK(6, 4)
+#define WCD939X_MBHC_ELECT_ELECT_DET_TYPE	BIT(3)
+#define WCD939X_MBHC_ELECT_ELECT_SCHMT_ISRC_CTL	GENMASK(2, 1)
+#define WCD939X_MBHC_ELECT_BIAS_EN	BIT(0)
+#define WCD939X_ANA_MBHC_ZDET				   (0x3016)
+#define WCD939X_MBHC_ZDET_ZDET_L_MEAS_EN	BIT(7)
+#define WCD939X_MBHC_ZDET_ZDET_R_MEAS_EN	BIT(6)
+#define WCD939X_MBHC_ZDET_ZDET_CHG_EN	BIT(5)
+#define WCD939X_MBHC_ZDET_ZDET_ILEAK_COMP_EN	BIT(4)
+#define WCD939X_MBHC_ZDET_ELECT_ISRC_EN	BIT(1)
+#define WCD939X_ANA_MBHC_RESULT_1			   (0x3017)
+#define WCD939X_MBHC_RESULT_1_Z_RESULT_LSB	GENMASK(7, 0)
+#define WCD939X_ANA_MBHC_RESULT_2			   (0x3018)
+#define WCD939X_MBHC_RESULT_2_Z_RESULT_MSB	GENMASK(7, 0)
+#define WCD939X_ANA_MBHC_RESULT_3			   (0x3019)
+#define WCD939X_ANA_MBHC_BTN0				   (0x301a)
+#define WCD939X_MBHC_BTN0_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN1				   (0x301b)
+#define WCD939X_MBHC_BTN1_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN2				   (0x301c)
+#define WCD939X_MBHC_BTN2_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN3				   (0x301d)
+#define WCD939X_MBHC_BTN3_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN4				   (0x301e)
+#define WCD939X_MBHC_BTN4_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN5				   (0x301f)
+#define WCD939X_MBHC_BTN5_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN6				   (0x3020)
+#define WCD939X_MBHC_BTN6_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MBHC_BTN7				   (0x3021)
+#define WCD939X_MBHC_BTN7_VTH	GENMASK(7, 2)
+#define WCD939X_ANA_MICB1				   (0x3022)
+#define WCD939X_MICB1_ENABLE	GENMASK(7, 6)
+#define WCD939X_MICB1_VOUT_CTL	GENMASK(5, 0)
+#define WCD939X_ANA_MICB2				   (0x3023)
+#define WCD939X_MICB2_ENABLE	GENMASK(7, 6)
+#define WCD939X_MICB2_VOUT_CTL	GENMASK(5, 0)
+#define WCD939X_ANA_MICB2_RAMP				   (0x3024)
+#define WCD939X_MICB2_RAMP_RAMP_ENABLE	BIT(7)
+#define WCD939X_MICB2_RAMP_MB2_IN2P_SHORT_ENABLE	BIT(6)
+#define WCD939X_MICB2_RAMP_ALLSW_OVRD_ENABLE	BIT(5)
+#define WCD939X_MICB2_RAMP_SHIFT_CTL	GENMASK(4, 2)
+#define WCD939X_MICB2_RAMP_USB_MGDET_MICB2_RAMP	GENMASK(1, 0)
+#define WCD939X_ANA_MICB3				   (0x3025)
+#define WCD939X_MICB3_ENABLE	GENMASK(7, 6)
+#define WCD939X_MICB3_VOUT_CTL	GENMASK(5, 0)
+#define WCD939X_ANA_MICB4				   (0x3026)
+#define WCD939X_MICB4_ENABLE	GENMASK(7, 6)
+#define WCD939X_MICB4_VOUT_CTL	GENMASK(5, 0)
+#define WCD939X_BIAS_CTL				   (0x3028)
+#define WCD939X_BIAS_VBG_FINE_ADJ			   (0x3029)
+#define WCD939X_LDOL_VDDCX_ADJUST			   (0x3040)
+#define WCD939X_LDOL_DISABLE_LDOL			   (0x3041)
+#define WCD939X_MBHC_CTL_CLK				   (0x3056)
+#define WCD939X_MBHC_CTL_ANA				   (0x3057)
+#define WCD939X_MBHC_ZDET_VNEG_CTL			   (0x3058)
+#define WCD939X_MBHC_ZDET_BIAS_CTL			   (0x3059)
+#define WCD939X_MBHC_CTL_BCS				   (0x305a)
+#define WCD939X_MBHC_MOISTURE_DET_FSM_STATUS		   (0x305b)
+#define WCD939X_MBHC_TEST_CTL				   (0x305c)
+#define WCD939X_LDOH_MODE				   (0x3067)
+#define WCD939X_MODE_LDOH_EN	BIT(7)
+#define WCD939X_MODE_PWRDN_STATE	BIT(6)
+#define WCD939X_MODE_SLOWRAMP_EN	BIT(5)
+#define WCD939X_MODE_VOUT_ADJUST	GENMASK(4, 3)
+#define WCD939X_MODE_VOUT_COARSE_ADJ	GENMASK(2, 0)
+#define WCD939X_LDOH_BIAS				   (0x3068)
+#define WCD939X_LDOH_STB_LOADS				   (0x3069)
+#define WCD939X_LDOH_SLOWRAMP				   (0x306a)
+#define WCD939X_MICB1_TEST_CTL_1			   (0x306b)
+#define WCD939X_TEST_CTL_1_NOISE_FILT_RES_VAL	GENMASK(7, 5)
+#define WCD939X_TEST_CTL_1_EN_VREFGEN	BIT(4)
+#define WCD939X_TEST_CTL_1_EN_LDO	BIT(3)
+#define WCD939X_TEST_CTL_1_LDO_BLEEDER_I_CTRL	GENMASK(2, 0)
+#define WCD939X_MICB1_TEST_CTL_2			   (0x306c)
+#define WCD939X_TEST_CTL_2_IBIAS_VREFGEN	GENMASK(7, 6)
+#define WCD939X_TEST_CTL_2_INRUSH_CURRENT_FIX_DIS	BIT(5)
+#define WCD939X_TEST_CTL_2_IBIAS_LDO_DRIVER	GENMASK(2, 0)
+#define WCD939X_MICB1_TEST_CTL_3			   (0x306d)
+#define WCD939X_TEST_CTL_3_CFILT_REF_EN	BIT(7)
+#define WCD939X_TEST_CTL_3_RZ_LDO_VAL	GENMASK(6, 4)
+#define WCD939X_TEST_CTL_3_IBIAS_LDO_STG3	GENMASK(3, 2)
+#define WCD939X_TEST_CTL_3_ATEST_CTRL	GENMASK(1, 0)
+#define WCD939X_MICB2_TEST_CTL_1			   (0x306e)
+#define WCD939X_MICB2_TEST_CTL_2			   (0x306f)
+#define WCD939X_MICB2_TEST_CTL_3			   (0x3070)
+#define WCD939X_MICB3_TEST_CTL_1			   (0x3071)
+#define WCD939X_MICB3_TEST_CTL_2			   (0x3072)
+#define WCD939X_MICB3_TEST_CTL_3			   (0x3073)
+#define WCD939X_MICB4_TEST_CTL_1			   (0x3074)
+#define WCD939X_MICB4_TEST_CTL_2			   (0x3075)
+#define WCD939X_MICB4_TEST_CTL_3			   (0x3076)
+#define WCD939X_TX_COM_ADC_VCM				   (0x3077)
+#define WCD939X_TX_COM_BIAS_ATEST			   (0x3078)
+#define WCD939X_TX_COM_SPARE1				   (0x3079)
+#define WCD939X_TX_COM_SPARE2				   (0x307a)
+#define WCD939X_TX_COM_TXFE_DIV_CTL			   (0x307b)
+#define WCD939X_TX_COM_TXFE_DIV_START			   (0x307c)
+#define WCD939X_TX_COM_SPARE3				   (0x307d)
+#define WCD939X_TX_COM_SPARE4				   (0x307e)
+#define WCD939X_TX_1_2_TEST_EN				   (0x307f)
+#define WCD939X_TX_1_2_ADC_IB				   (0x3080)
+#define WCD939X_TX_1_2_ATEST_REFCTL			   (0x3081)
+#define WCD939X_TX_1_2_TEST_CTL				   (0x3082)
+#define WCD939X_TX_1_2_TEST_BLK_EN1			   (0x3083)
+#define WCD939X_TX_1_2_TXFE1_CLKDIV			   (0x3084)
+#define WCD939X_TX_1_2_SAR2_ERR				   (0x3085)
+#define WCD939X_TX_1_2_SAR1_ERR				   (0x3086)
+#define WCD939X_TX_3_4_TEST_EN				   (0x3087)
+#define WCD939X_TX_3_4_ADC_IB				   (0x3088)
+#define WCD939X_TX_3_4_ATEST_REFCTL			   (0x3089)
+#define WCD939X_TX_3_4_TEST_CTL				   (0x308a)
+#define WCD939X_TX_3_4_TEST_BLK_EN3			   (0x308b)
+#define WCD939X_TX_3_4_TXFE3_CLKDIV			   (0x308c)
+#define WCD939X_TX_3_4_SAR4_ERR				   (0x308d)
+#define WCD939X_TX_3_4_SAR3_ERR				   (0x308e)
+#define WCD939X_TX_3_4_TEST_BLK_EN2			   (0x308f)
+#define WCD939X_TEST_BLK_EN2_ADC2_INT1_EN	BIT(7)
+#define WCD939X_TEST_BLK_EN2_ADC2_INT2_EN	BIT(6)
+#define WCD939X_TEST_BLK_EN2_ADC2_SAR_EN	BIT(5)
+#define WCD939X_TEST_BLK_EN2_ADC2_CMGEN_EN	BIT(4)
+#define WCD939X_TEST_BLK_EN2_ADC2_CLKGEN_EN	BIT(3)
+#define WCD939X_TEST_BLK_EN2_ADC12_VREF_NONL2	GENMASK(2, 1)
+#define WCD939X_TEST_BLK_EN2_TXFE2_MBHC_CLKRST_EN	BIT(0)
+#define WCD939X_TX_3_4_TXFE2_CLKDIV			   (0x3090)
+#define WCD939X_TX_3_4_SPARE1				   (0x3091)
+#define WCD939X_TX_3_4_TEST_BLK_EN4			   (0x3092)
+#define WCD939X_TX_3_4_TXFE4_CLKDIV			   (0x3093)
+#define WCD939X_TX_3_4_SPARE2				   (0x3094)
+#define WCD939X_CLASSH_MODE_1				   (0x3097)
+#define WCD939X_CLASSH_MODE_2				   (0x3098)
+#define WCD939X_CLASSH_MODE_3				   (0x3099)
+#define WCD939X_CLASSH_CTRL_VCL_1			   (0x309a)
+#define WCD939X_CLASSH_CTRL_VCL_2			   (0x309b)
+#define WCD939X_CLASSH_CTRL_CCL_1			   (0x309c)
+#define WCD939X_CLASSH_CTRL_CCL_2			   (0x309d)
+#define WCD939X_CLASSH_CTRL_CCL_3			   (0x309e)
+#define WCD939X_CLASSH_CTRL_CCL_4			   (0x309f)
+#define WCD939X_CLASSH_CTRL_CCL_5			   (0x30a0)
+#define WCD939X_CLASSH_BUCK_TMUX_A_D			   (0x30a1)
+#define WCD939X_CLASSH_BUCK_SW_DRV_CNTL			   (0x30a2)
+#define WCD939X_CLASSH_SPARE				   (0x30a3)
+#define WCD939X_FLYBACK_EN				   (0x30a4)
+#define WCD939X_FLYBACK_VNEG_CTRL_1			   (0x30a5)
+#define WCD939X_FLYBACK_VNEG_CTRL_2			   (0x30a6)
+#define WCD939X_FLYBACK_VNEG_CTRL_3			   (0x30a7)
+#define WCD939X_FLYBACK_VNEG_CTRL_4			   (0x30a8)
+#define WCD939X_VNEG_CTRL_4_ILIM_SEL	GENMASK(7, 4)
+#define WCD939X_VNEG_CTRL_4_PW_BUF_POS	GENMASK(3, 2)
+#define WCD939X_VNEG_CTRL_4_PW_BUF_NEG	GENMASK(1, 0)
+#define WCD939X_FLYBACK_VNEG_CTRL_5			   (0x30a9)
+#define WCD939X_FLYBACK_VNEG_CTRL_6			   (0x30aa)
+#define WCD939X_FLYBACK_VNEG_CTRL_7			   (0x30ab)
+#define WCD939X_FLYBACK_VNEG_CTRL_8			   (0x30ac)
+#define WCD939X_FLYBACK_VNEG_CTRL_9			   (0x30ad)
+#define WCD939X_FLYBACK_VNEGDAC_CTRL_1			   (0x30ae)
+#define WCD939X_FLYBACK_VNEGDAC_CTRL_2			   (0x30af)
+#define WCD939X_FLYBACK_VNEGDAC_CTRL_3			   (0x30b0)
+#define WCD939X_FLYBACK_CTRL_1				   (0x30b1)
+#define WCD939X_FLYBACK_TEST_CTL			   (0x30b2)
+#define WCD939X_RX_AUX_SW_CTL				   (0x30b3)
+#define WCD939X_RX_PA_AUX_IN_CONN			   (0x30b4)
+#define WCD939X_RX_TIMER_DIV				   (0x30b5)
+#define WCD939X_RX_OCP_CTL				   (0x30b6)
+#define WCD939X_RX_OCP_COUNT				   (0x30b7)
+#define WCD939X_RX_BIAS_EAR_DAC				   (0x30b8)
+#define WCD939X_RX_BIAS_EAR_AMP				   (0x30b9)
+#define WCD939X_RX_BIAS_HPH_LDO				   (0x30ba)
+#define WCD939X_RX_BIAS_HPH_PA				   (0x30bb)
+#define WCD939X_RX_BIAS_HPH_RDACBUFF_CNP2		   (0x30bc)
+#define WCD939X_RX_BIAS_HPH_RDAC_LDO			   (0x30bd)
+#define WCD939X_RX_BIAS_HPH_CNP1			   (0x30be)
+#define WCD939X_RX_BIAS_HPH_LOWPOWER			   (0x30bf)
+#define WCD939X_RX_BIAS_AUX_DAC				   (0x30c0)
+#define WCD939X_RX_BIAS_AUX_AMP				   (0x30c1)
+#define WCD939X_RX_BIAS_VNEGDAC_BLEEDER			   (0x30c2)
+#define WCD939X_RX_BIAS_MISC				   (0x30c3)
+#define WCD939X_RX_BIAS_BUCK_RST			   (0x30c4)
+#define WCD939X_RX_BIAS_BUCK_VREF_ERRAMP		   (0x30c5)
+#define WCD939X_RX_BIAS_FLYB_ERRAMP			   (0x30c6)
+#define WCD939X_RX_BIAS_FLYB_BUFF			   (0x30c7)
+#define WCD939X_RX_BIAS_FLYB_MID_RST			   (0x30c8)
+#define WCD939X_HPH_L_STATUS				   (0x30c9)
+#define WCD939X_HPH_R_STATUS				   (0x30ca)
+#define WCD939X_HPH_CNP_EN				   (0x30cb)
+#define WCD939X_HPH_CNP_WG_CTL				   (0x30cc)
+#define WCD939X_HPH_CNP_WG_TIME				   (0x30cd)
+#define WCD939X_HPH_OCP_CTL				   (0x30ce)
+#define WCD939X_OCP_CTL_OCP_CURR_LIMIT	GENMASK(7, 5)
+#define WCD939X_OCP_CTL_OCP_FSM_EN	BIT(4)
+#define WCD939X_OCP_CTL_SPARE_BITS	BIT(3)
+#define WCD939X_OCP_CTL_SCD_OP_EN	BIT(1)
+#define WCD939X_HPH_AUTO_CHOP				   (0x30cf)
+#define WCD939X_HPH_CHOP_CTL				   (0x30d0)
+#define WCD939X_HPH_PA_CTL1				   (0x30d1)
+#define WCD939X_HPH_PA_CTL2				   (0x30d2)
+#define WCD939X_PA_CTL2_HPHPA_GND_R	BIT(6)
+#define WCD939X_PA_CTL2_HPHPA_GND_L	BIT(4)
+#define WCD939X_PA_CTL2_GM3_CASCODE_CTL_NORMAL	GENMASK(1, 0)
+#define WCD939X_HPH_L_EN				   (0x30d3)
+#define WCD939X_L_EN_CONST_SEL_L	GENMASK(7, 6)
+#define WCD939X_L_EN_GAIN_SOURCE_SEL	BIT(5)
+#define WCD939X_L_EN_SPARE_BITS	GENMASK(4, 0)
+#define WCD939X_HPH_L_TEST				   (0x30d4)
+#define WCD939X_HPH_L_ATEST				   (0x30d5)
+#define WCD939X_HPH_R_EN				   (0x30d6)
+#define WCD939X_R_EN_CONST_SEL_R	GENMASK(7, 6)
+#define WCD939X_R_EN_GAIN_SOURCE_SEL	BIT(5)
+#define WCD939X_R_EN_SPARE_BITS	GENMASK(4, 0)
+#define WCD939X_HPH_R_TEST				   (0x30d7)
+#define WCD939X_HPH_R_ATEST				   (0x30d8)
+#define WCD939X_R_ATEST_DACR_REF_ATEST1_CONN	BIT(7)
+#define WCD939X_R_ATEST_LDO1_R_ATEST2_CONN	BIT(6)
+#define WCD939X_R_ATEST_LDO_R_ATEST2_CAL	BIT(5)
+#define WCD939X_R_ATEST_LDO2_R_ATEST2_CONN	BIT(4)
+#define WCD939X_R_ATEST_LDO_1P65V_ATEST1_CONN	BIT(3)
+#define WCD939X_R_ATEST_HPH_GND_OVR	BIT(1)
+#define WCD939X_HPH_RDAC_CLK_CTL1			   (0x30d9)
+#define WCD939X_RDAC_CLK_CTL1_OPAMP_CHOP_CLK_EN	BIT(7)
+#define WCD939X_RDAC_CLK_CTL1_OPAMP_CHOP_CLK_DIV_CTRL	GENMASK(6, 4)
+#define WCD939X_RDAC_CLK_CTL1_SPARE_BITS	GENMASK(3, 0)
+#define WCD939X_HPH_RDAC_CLK_CTL2			   (0x30da)
+#define WCD939X_HPH_RDAC_LDO_CTL			   (0x30db)
+#define WCD939X_HPH_RDAC_CHOP_CLK_LP_CTL		   (0x30dc)
+#define WCD939X_HPH_REFBUFF_UHQA_CTL			   (0x30dd)
+#define WCD939X_REFBUFF_UHQA_CTL_SPARE_BITS	GENMASK(7, 6)
+#define WCD939X_REFBUFF_UHQA_CTL_HPH_VNEGREG2_COMP_CTL_OV	BIT(5)
+#define WCD939X_REFBUFF_UHQA_CTL_REFBUFN_RBIAS_ADJUST	BIT(4)
+#define WCD939X_REFBUFF_UHQA_CTL_REFBUFP_IOUT_CTL	GENMASK(3, 2)
+#define WCD939X_REFBUFF_UHQA_CTL_REFBUFN_IOUT_CTL	GENMASK(1, 0)
+#define WCD939X_HPH_REFBUFF_LP_CTL			   (0x30de)
+#define WCD939X_REFBUFF_LP_CTL_HPH_VNEGREG2_CURR_COMP	GENMASK(7, 6)
+#define WCD939X_REFBUFF_LP_CTL_SPARE_BITS	GENMASK(5, 4)
+#define WCD939X_REFBUFF_LP_CTL_EN_PREREF_FILT_STARTUP_CLKDIV	BIT(3)
+#define WCD939X_REFBUFF_LP_CTL_PREREF_FILT_STARTUP_CLKDIV_CTL	GENMASK(2, 1)
+#define WCD939X_REFBUFF_LP_CTL_PREREF_FILT_BYPASS	BIT(0)
+#define WCD939X_HPH_L_DAC_CTL				   (0x30df)
+#define WCD939X_HPH_R_DAC_CTL				   (0x30e0)
+#define WCD939X_HPH_SURGE_COMP_SEL			   (0x30e1)
+#define WCD939X_HPH_SURGE_EN				   (0x30e2)
+#define WCD939X_EN_EN_SURGE_PROTECTION_HPHL	BIT(7)
+#define WCD939X_EN_EN_SURGE_PROTECTION_HPHR	BIT(6)
+#define WCD939X_EN_SEL_SURGE_COMP_IQ	GENMASK(5, 4)
+#define WCD939X_EN_SURGE_VOLT_MODE_SHUTOFF_EN	BIT(3)
+#define WCD939X_EN_LATCH_INTR_OP_STG_HIZ_EN	BIT(2)
+#define WCD939X_EN_SURGE_LATCH_REG_RESET	BIT(1)
+#define WCD939X_EN_SWTICH_VN_VNDAC_NSURGE_EN	BIT(0)
+#define WCD939X_HPH_SURGE_MISC1				   (0x30e3)
+#define WCD939X_HPH_SURGE_STATUS			   (0x30e4)
+#define WCD939X_EAR_EN					   (0x30e9)
+#define WCD939X_EAR_PA_CON				   (0x30ea)
+#define WCD939X_EAR_SP_CON				   (0x30eb)
+#define WCD939X_EAR_DAC_CON				   (0x30ec)
+#define WCD939X_DAC_CON_DAC_SAMPLE_EDGE_SEL	BIT(7)
+#define WCD939X_DAC_CON_REF_DBG_EN	BIT(6)
+#define WCD939X_DAC_CON_REF_DBG_GAIN	GENMASK(5, 3)
+#define WCD939X_DAC_CON_GAIN_DAC	GENMASK(2, 1)
+#define WCD939X_DAC_CON_INV_DATA	BIT(0)
+#define WCD939X_EAR_CNP_FSM_CON				   (0x30ed)
+#define WCD939X_EAR_TEST_CTL				   (0x30ee)
+#define WCD939X_EAR_STATUS_REG_1			   (0x30ef)
+#define WCD939X_EAR_STATUS_REG_2			   (0x30f0)
+#define WCD939X_FLYBACK_NEW_CTRL_2			   (0x30f6)
+#define WCD939X_FLYBACK_NEW_CTRL_3			   (0x30f7)
+#define WCD939X_FLYBACK_NEW_CTRL_4			   (0x30f8)
+#define WCD939X_ANA_NEW_PAGE				   (0x3100)
+#define WCD939X_HPH_NEW_ANA_HPH2			   (0x3101)
+#define WCD939X_HPH_NEW_ANA_HPH3			   (0x3102)
+#define WCD939X_SLEEP_CTL				   (0x3103)
+#define WCD939X_SLEEP_WATCHDOG_CTL			   (0x3104)
+#define WCD939X_MBHC_NEW_ELECT_REM_CLAMP_CTL		   (0x311f)
+#define WCD939X_MBHC_NEW_CTL_1				   (0x3120)
+#define WCD939X_CTL_1_RCO_EN	BIT(7)
+#define WCD939X_CTL_1_ADC_MODE	BIT(4)
+#define WCD939X_CTL_1_ADC_ENABLE	BIT(3)
+#define WCD939X_CTL_1_DETECTION_DONE	BIT(2)
+#define WCD939X_CTL_1_BTN_DBNC_CTL	GENMASK(1, 0)
+#define WCD939X_MBHC_NEW_CTL_2				   (0x3121)
+#define WCD939X_CTL_2_MUX_CTL	GENMASK(6, 4)
+#define WCD939X_CTL_2_M_RTH_CTL	GENMASK(3, 2)
+#define WCD939X_CTL_2_HS_VREF_CTL	GENMASK(1, 0)
+#define WCD939X_MBHC_NEW_PLUG_DETECT_CTL		   (0x3122)
+#define WCD939X_MBHC_NEW_ZDET_ANA_CTL			   (0x3123)
+#define WCD939X_ZDET_ANA_CTL_AVERAGING_EN	BIT(7)
+#define WCD939X_ZDET_ANA_CTL_MAXV_CTL	GENMASK(6, 4)
+#define WCD939X_ZDET_ANA_CTL_RANGE_CTL	GENMASK(3, 0)
+#define WCD939X_MBHC_NEW_ZDET_RAMP_CTL			   (0x3124)
+#define WCD939X_ZDET_RAMP_CTL_ACC1_MIN_CTL	GENMASK(6, 4)
+#define WCD939X_ZDET_RAMP_CTL_TIME_CTL	GENMASK(3, 0)
+#define WCD939X_MBHC_NEW_FSM_STATUS			   (0x3125)
+#define WCD939X_FSM_STATUS_ADC_TIMEOUT	BIT(7)
+#define WCD939X_FSM_STATUS_ADC_COMPLETE	BIT(6)
+#define WCD939X_FSM_STATUS_HS_M_COMP_STATUS	BIT(5)
+#define WCD939X_FSM_STATUS_FAST_PRESS_FLAG_STATUS	BIT(4)
+#define WCD939X_FSM_STATUS_FAST_REMOVAL_FLAG_STATUS	BIT(3)
+#define WCD939X_FSM_STATUS_REMOVAL_FLAG_STATUS	BIT(2)
+#define WCD939X_FSM_STATUS_ELECT_REM_RT_STATUS	BIT(1)
+#define WCD939X_FSM_STATUS_BTN_STATUS	BIT(0)
+#define WCD939X_MBHC_NEW_ADC_RESULT			   (0x3126)
+#define WCD939X_ADC_RESULT_VALUE	GENMASK(7, 0)
+#define WCD939X_TX_NEW_CH12_MUX				   (0x3127)
+#define WCD939X_TX_NEW_CH34_MUX				   (0x3128)
+#define WCD939X_DIE_CRACK_DET_EN			   (0x312c)
+#define WCD939X_DIE_CRACK_DET_OUT			   (0x312d)
+#define WCD939X_HPH_NEW_INT_RDAC_GAIN_CTL		   (0x3132)
+#define WCD939X_HPH_NEW_INT_PA_GAIN_CTL_L		   (0x3133)
+#define WCD939X_PA_GAIN_CTL_L_EN_HPHPA_2VPK	BIT(7)
+#define WCD939X_PA_GAIN_CTL_L_RX_SUPPLY_LEVEL	BIT(6)
+#define WCD939X_PA_GAIN_CTL_L_DAC_DR_BOOST	BIT(5)
+#define WCD939X_PA_GAIN_CTL_L_VALUE	GENMASK(4, 0)
+#define WCD939X_HPH_NEW_INT_RDAC_VREF_CTL		   (0x3134)
+#define WCD939X_HPH_NEW_INT_RDAC_OVERRIDE_CTL		   (0x3135)
+#define WCD939X_HPH_NEW_INT_PA_GAIN_CTL_R		   (0x3136)
+#define WCD939X_PA_GAIN_CTL_R_D_RCO_CLK_EN	BIT(7)
+#define WCD939X_PA_GAIN_CTL_R_SPARE_BITS	GENMASK(6, 5)
+#define WCD939X_PA_GAIN_CTL_R_VALUE	GENMASK(4, 0)
+#define WCD939X_HPH_NEW_INT_PA_MISC1			   (0x3137)
+#define WCD939X_HPH_NEW_INT_PA_MISC2			   (0x3138)
+#define WCD939X_HPH_NEW_INT_PA_RDAC_MISC		   (0x3139)
+#define WCD939X_HPH_NEW_INT_TIMER1			   (0x313a)
+#define WCD939X_TIMER1_CURR_IDIV_CTL_CMPDR_OFF	GENMASK(7, 5)
+#define WCD939X_TIMER1_CURR_IDIV_CTL_AUTOCHOP	GENMASK(4, 2)
+#define WCD939X_TIMER1_AUTOCHOP_TIMER_CTL_EN	BIT(1)
+#define WCD939X_HPH_NEW_INT_TIMER2			   (0x313b)
+#define WCD939X_HPH_NEW_INT_TIMER3			   (0x313c)
+#define WCD939X_HPH_NEW_INT_TIMER4			   (0x313d)
+#define WCD939X_HPH_NEW_INT_PA_RDAC_MISC2		   (0x313e)
+#define WCD939X_HPH_NEW_INT_PA_RDAC_MISC3		   (0x313f)
+#define WCD939X_HPH_NEW_INT_RDAC_HD2_CTL_L		   (0x3140)
+#define WCD939X_RDAC_HD2_CTL_L_EN_HD2_RES_DIV_L	BIT(7)
+#define WCD939X_RDAC_HD2_CTL_L_HD2_RES_DIV_PULLGND_L	BIT(6)
+#define WCD939X_RDAC_HD2_CTL_L_HD2_RES_DIV_CTL_L	GENMASK(5, 0)
+#define WCD939X_HPH_NEW_INT_RDAC_HD2_CTL_R		   (0x3141)
+#define WCD939X_RDAC_HD2_CTL_R_EN_HD2_RES_DIV_R	BIT(7)
+#define WCD939X_RDAC_HD2_CTL_R_HD2_RES_DIV_PULLGND_L	BIT(6)
+#define WCD939X_RDAC_HD2_CTL_R_HD2_RES_DIV_CTL_R	GENMASK(5, 0)
+#define WCD939X_RX_NEW_INT_HPH_RDAC_BIAS_LOHIFI		   (0x3145)
+#define WCD939X_RX_NEW_INT_HPH_RDAC_BIAS_ULP		   (0x3146)
+#define WCD939X_RX_NEW_INT_HPH_RDAC_LDO_LP		   (0x3147)
+#define WCD939X_MBHC_NEW_INT_MOISTURE_DET_DC_CTRL	   (0x31af)
+#define WCD939X_MOISTURE_DET_DC_CTRL_ONCOUNT	GENMASK(6, 5)
+#define WCD939X_MOISTURE_DET_DC_CTRL_OFFCOUNT	GENMASK(4, 0)
+#define WCD939X_MBHC_NEW_INT_MOISTURE_DET_POLLING_CTRL	   (0x31b0)
+#define WCD939X_MOISTURE_DET_POLLING_CTRL_HPHL_PA_EN	BIT(6)
+#define WCD939X_MOISTURE_DET_POLLING_CTRL_DTEST_EN	GENMASK(5, 4)
+#define WCD939X_MOISTURE_DET_POLLING_CTRL_MOIST_OVRD_POLLING	BIT(3)
+#define WCD939X_MOISTURE_DET_POLLING_CTRL_MOIST_EN_POLLING	BIT(2)
+#define WCD939X_MOISTURE_DET_POLLING_CTRL_MOIST_DBNC_TIME	GENMASK(1, 0)
+#define WCD939X_MBHC_NEW_INT_MECH_DET_CURRENT		   (0x31b1)
+#define WCD939X_MECH_DET_CURRENT_HSDET_PULLUP_CTL	GENMASK(4, 0)
+#define WCD939X_MBHC_NEW_INT_ZDET_CLK_AND_MOISTURE_CTL_NEW (0x31b2)
+#define WCD939X_EAR_INT_NEW_CHOPPER_CON			   (0x31b7)
+#define WCD939X_EAR_INT_NEW_CNP_VCM_CON1		   (0x31b8)
+#define WCD939X_EAR_INT_NEW_CNP_VCM_CON2		   (0x31b9)
+#define WCD939X_EAR_INT_NEW_DYNAMIC_BIAS		   (0x31ba)
+#define WCD939X_SLEEP_INT_WATCHDOG_CTL_1		   (0x31d0)
+#define WCD939X_SLEEP_INT_WATCHDOG_CTL_2		   (0x31d1)
+#define WCD939X_DIE_CRACK_INT_DET_INT1			   (0x31d3)
+#define WCD939X_DIE_CRACK_INT_DET_INT2			   (0x31d4)
+#define WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L2		   (0x31d5)
+#define WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L1		   (0x31d6)
+#define WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_L0		   (0x31d7)
+#define WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_ULP1P2M	   (0x31d8)
+#define WCD939X_TX_COM_NEW_INT_FE_DIVSTOP_ULP0P6M	   (0x31d9)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_L2L1	   (0x31da)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_L0		   (0x31db)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG1_ULP	   (0x31dc)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_L2L1	   (0x31dd)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_L0	   (0x31de)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2MAIN_ULP	   (0x31df)
+#define WCD939X_FE_ICTRL_STG2MAIN_ULP_VALUE	GENMASK(4, 0)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2CASC_L2L1L0	   (0x31e0)
+#define WCD939X_TX_COM_NEW_INT_FE_ICTRL_STG2CASC_ULP	   (0x31e1)
+#define WCD939X_FE_ICTRL_STG2CASC_ULP_ICTRL_SCBIAS_ULP0P6M	GENMASK(7, 4)
+#define WCD939X_FE_ICTRL_STG2CASC_ULP_VALUE	GENMASK(3, 0)
+#define WCD939X_TX_COM_NEW_INT_ADC_SCBIAS_L2L1		   (0x31e2)
+#define WCD939X_TX_COM_NEW_INT_ADC_SCBIAS_L0ULP		   (0x31e3)
+#define WCD939X_TX_COM_NEW_INT_ADC_INT_L2		   (0x31e4)
+#define WCD939X_TX_COM_NEW_INT_ADC_INT_L1		   (0x31e5)
+#define WCD939X_TX_COM_NEW_INT_ADC_INT_L0		   (0x31e6)
+#define WCD939X_TX_COM_NEW_INT_ADC_INT_ULP		   (0x31e7)
+#define WCD939X_DIGITAL_PAGE				   (0x3400)
+#define WCD939X_DIGITAL_CHIP_ID0			   (0x3401)
+#define WCD939X_DIGITAL_CHIP_ID1			   (0x3402)
+#define WCD939X_DIGITAL_CHIP_ID2			   (0x3403)
+#define WCD939X_DIGITAL_CHIP_ID3			   (0x3404)
+#define WCD939X_DIGITAL_SWR_TX_CLK_RATE			   (0x3405)
+#define WCD939X_DIGITAL_CDC_RST_CTL			   (0x3406)
+#define WCD939X_DIGITAL_TOP_CLK_CFG			   (0x3407)
+#define WCD939X_DIGITAL_CDC_ANA_CLK_CTL			   (0x3408)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_TX_DIV4_CLK_EN	BIT(5)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_TX_DIV2_CLK_EN	BIT(4)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_TX_CLK_EN	BIT(3)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_RX_DIV4_CLK_EN	BIT(2)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_RX_DIV2_CLK_EN	BIT(1)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_RX_CLK_EN	BIT(0)
+#define WCD939X_CDC_ANA_CLK_CTL_ANA_TX_DIV2_CLK_EN	BIT(4)
+#define WCD939X_DIGITAL_CDC_DIG_CLK_CTL			   (0x3409)
+#define WCD939X_CDC_DIG_CLK_CTL_TXD3_CLK_EN	BIT(7)
+#define WCD939X_CDC_DIG_CLK_CTL_TXD2_CLK_EN	BIT(6)
+#define WCD939X_CDC_DIG_CLK_CTL_TXD1_CLK_EN	BIT(5)
+#define WCD939X_CDC_DIG_CLK_CTL_TXD0_CLK_EN	BIT(4)
+#define WCD939X_CDC_DIG_CLK_CTL_RXD2_CLK_EN	BIT(2)
+#define WCD939X_CDC_DIG_CLK_CTL_RXD1_CLK_EN	BIT(1)
+#define WCD939X_CDC_DIG_CLK_CTL_RXD0_CLK_EN	BIT(0)
+#define WCD939X_DIGITAL_SWR_RST_EN			   (0x340a)
+#define WCD939X_DIGITAL_CDC_PATH_MODE			   (0x340b)
+#define WCD939X_DIGITAL_CDC_RX_RST			   (0x340c)
+#define WCD939X_DIGITAL_CDC_RX0_CTL			   (0x340d)
+#define WCD939X_DIGITAL_CDC_RX1_CTL			   (0x340e)
+#define WCD939X_DIGITAL_CDC_RX2_CTL			   (0x340f)
+#define WCD939X_DIGITAL_CDC_TX_ANA_MODE_0_1		   (0x3410)
+#define WCD939X_CDC_TX_ANA_MODE_0_1_TXD1_MODE	GENMASK(7, 4)
+#define WCD939X_CDC_TX_ANA_MODE_0_1_TXD0_MODE	GENMASK(3, 0)
+#define WCD939X_DIGITAL_CDC_TX_ANA_MODE_2_3		   (0x3411)
+#define WCD939X_CDC_TX_ANA_MODE_2_3_TXD3_MODE	GENMASK(7, 4)
+#define WCD939X_CDC_TX_ANA_MODE_2_3_TXD2_MODE	GENMASK(3, 0)
+#define WCD939X_DIGITAL_CDC_COMP_CTL_0			   (0x3414)
+#define WCD939X_CDC_COMP_CTL_0_HPHL_COMP_EN	BIT(1)
+#define WCD939X_CDC_COMP_CTL_0_HPHR_COMP_EN	BIT(0)
+#define WCD939X_DIGITAL_CDC_ANA_TX_CLK_CTL		   (0x3417)
+#define WCD939X_CDC_ANA_TX_CLK_CTL_ANA_MBHC_1P2M_CLK_EN	BIT(5)
+#define WCD939X_CDC_ANA_TX_CLK_CTL_ANA_TX3_ADC_CLK_EN	BIT(4)
+#define WCD939X_CDC_ANA_TX_CLK_CTL_ANA_TX2_ADC_CLK_EN	BIT(3)
+#define WCD939X_CDC_ANA_TX_CLK_CTL_ANA_TX1_ADC_CLK_EN	BIT(2)
+#define WCD939X_CDC_ANA_TX_CLK_CTL_ANA_TX0_ADC_CLK_EN	BIT(1)
+#define WCD939X_CDC_ANA_TX_CLK_CTL_ANA_TXSCBIAS_CLK_EN	BIT(0)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A1_0		   (0x3418)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A1_1		   (0x3419)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A2_0		   (0x341a)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A2_1		   (0x341b)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A3_0		   (0x341c)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A3_1		   (0x341d)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A4_0		   (0x341e)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A4_1		   (0x341f)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A5_0		   (0x3420)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A5_1		   (0x3421)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A6_0		   (0x3422)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_A7_0		   (0x3423)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_C_0			   (0x3424)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_C_1			   (0x3425)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_C_2			   (0x3426)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_C_3			   (0x3427)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R1			   (0x3428)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R2			   (0x3429)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R3			   (0x342a)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R4			   (0x342b)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R5			   (0x342c)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R6			   (0x342d)
+#define WCD939X_DIGITAL_CDC_HPH_DSM_R7			   (0x342e)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A1_0		   (0x342f)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A1_1		   (0x3430)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A2_0		   (0x3431)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A2_1		   (0x3432)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A3_0		   (0x3433)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A3_1		   (0x3434)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A4_0		   (0x3435)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A4_1		   (0x3436)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A5_0		   (0x3437)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A5_1		   (0x3438)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A6_0		   (0x3439)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_A7_0		   (0x343a)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_C_0			   (0x343b)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_C_1			   (0x343c)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_C_2			   (0x343d)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_C_3			   (0x343e)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R1			   (0x343f)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R2			   (0x3440)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R3			   (0x3441)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R4			   (0x3442)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R5			   (0x3443)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R6			   (0x3444)
+#define WCD939X_DIGITAL_CDC_EAR_DSM_R7			   (0x3445)
+#define WCD939X_DIGITAL_CDC_HPH_GAIN_RX_0		   (0x3446)
+#define WCD939X_DIGITAL_CDC_HPH_GAIN_RX_1		   (0x3447)
+#define WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_0		   (0x3448)
+#define WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_1		   (0x3449)
+#define WCD939X_DIGITAL_CDC_HPH_GAIN_DSD_2		   (0x344a)
+#define WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_0		   (0x344b)
+#define WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_1		   (0x344c)
+#define WCD939X_DIGITAL_CDC_EAR_GAIN_DSD_2		   (0x344d)
+#define WCD939X_DIGITAL_CDC_HPH_GAIN_CTL		   (0x344e)
+#define WCD939X_CDC_HPH_GAIN_CTL_HPH_STEREO_EN	BIT(4)
+#define WCD939X_CDC_HPH_GAIN_CTL_HPHR_RX_EN	BIT(3)
+#define WCD939X_CDC_HPH_GAIN_CTL_HPHL_RX_EN	BIT(2)
+#define WCD939X_CDC_HPH_GAIN_CTL_HPHR_DSD_EN	BIT(1)
+#define WCD939X_CDC_HPH_GAIN_CTL_HPHL_DSD_EN	BIT(0)
+#define WCD939X_DIGITAL_CDC_EAR_GAIN_CTL		   (0x344f)
+#define WCD939X_CDC_EAR_GAIN_CTL_EAR_EN	BIT(0)
+#define WCD939X_DIGITAL_CDC_EAR_PATH_CTL		   (0x3450)
+#define WCD939X_DIGITAL_CDC_SWR_CLH			   (0x3451)
+#define WCD939X_CDC_SWR_CLH_CLH_CTL	GENMASK(7, 0)
+#define WCD939X_DIGITAL_SWR_CLH_BYP			   (0x3452)
+#define WCD939X_DIGITAL_CDC_TX0_CTL			   (0x3453)
+#define WCD939X_DIGITAL_CDC_TX1_CTL			   (0x3454)
+#define WCD939X_DIGITAL_CDC_TX2_CTL			   (0x3455)
+#define WCD939X_DIGITAL_CDC_TX_RST			   (0x3456)
+#define WCD939X_DIGITAL_CDC_REQ_CTL			   (0x3457)
+#define WCD939X_CDC_REQ_CTL_TX3_WIDE_BAND	BIT(5)
+#define WCD939X_CDC_REQ_CTL_TX2_WIDE_BAND	BIT(4)
+#define WCD939X_CDC_REQ_CTL_TX1_WIDE_BAND	BIT(3)
+#define WCD939X_CDC_REQ_CTL_TX0_WIDE_BAND	BIT(2)
+#define WCD939X_CDC_REQ_CTL_FS_RATE_4P8	BIT(1)
+#define WCD939X_CDC_REQ_CTL_NO_NOTCH	BIT(0)
+#define WCD939X_DIGITAL_CDC_RST				   (0x3458)
+#define WCD939X_DIGITAL_CDC_AMIC_CTL			   (0x345a)
+#define WCD939X_CDC_AMIC_CTL_AMIC5_IN_SEL	BIT(3)
+#define WCD939X_CDC_AMIC_CTL_AMIC4_IN_SEL	BIT(2)
+#define WCD939X_CDC_AMIC_CTL_AMIC3_IN_SEL	BIT(1)
+#define WCD939X_CDC_AMIC_CTL_AMIC1_IN_SEL	BIT(0)
+#define WCD939X_DIGITAL_CDC_DMIC_CTL			   (0x345b)
+#define WCD939X_CDC_DMIC_CTL_DMIC_LEGACY_SW_MODE	BIT(3)
+#define WCD939X_CDC_DMIC_CTL_DMIC_DIV_BAK_EN	BIT(2)
+#define WCD939X_CDC_DMIC_CTL_CLK_SCALE_EN	BIT(1)
+#define WCD939X_CDC_DMIC_CTL_SOFT_RESET	BIT(0)
+#define WCD939X_DIGITAL_CDC_DMIC1_CTL			   (0x345c)
+#define WCD939X_CDC_DMIC1_CTL_DMIC_CLK_SCALE_SEL	GENMASK(6, 4)
+#define WCD939X_CDC_DMIC1_CTL_DMIC_CLK_EN	BIT(3)
+#define WCD939X_CDC_DMIC1_CTL_DMIC_CLK_SEL	GENMASK(2, 0)
+#define WCD939X_DIGITAL_CDC_DMIC2_CTL			   (0x345d)
+#define WCD939X_CDC_DMIC2_CTL_DMIC_LEFT_EN	BIT(7)
+#define WCD939X_CDC_DMIC2_CTL_DMIC_CLK_SCALE_SEL	GENMASK(6, 4)
+#define WCD939X_CDC_DMIC2_CTL_DMIC_CLK_EN	BIT(3)
+#define WCD939X_CDC_DMIC2_CTL_DMIC_CLK_SEL	GENMASK(2, 0)
+#define WCD939X_DIGITAL_CDC_DMIC3_CTL			   (0x345e)
+#define WCD939X_CDC_DMIC3_CTL_DMIC_CLK_SCALE_SEL	GENMASK(6, 4)
+#define WCD939X_CDC_DMIC3_CTL_DMIC_CLK_EN	BIT(3)
+#define WCD939X_CDC_DMIC3_CTL_DMIC_CLK_SEL	GENMASK(2, 0)
+#define WCD939X_DIGITAL_CDC_DMIC4_CTL			   (0x345f)
+#define WCD939X_CDC_DMIC4_CTL_DMIC_CLK_SCALE_SEL	GENMASK(6, 4)
+#define WCD939X_CDC_DMIC4_CTL_DMIC_CLK_EN	BIT(3)
+#define WCD939X_CDC_DMIC4_CTL_DMIC_CLK_SEL	GENMASK(2, 0)
+#define WCD939X_DIGITAL_EFUSE_PRG_CTL			   (0x3460)
+#define WCD939X_DIGITAL_EFUSE_CTL			   (0x3461)
+#define WCD939X_DIGITAL_CDC_DMIC_RATE_1_2		   (0x3462)
+#define WCD939X_CDC_DMIC_RATE_1_2_DMIC2_RATE	GENMASK(7, 4)
+#define WCD939X_CDC_DMIC_RATE_1_2_DMIC1_RATE	GENMASK(3, 0)
+#define WCD939X_DIGITAL_CDC_DMIC_RATE_3_4		   (0x3463)
+#define WCD939X_CDC_DMIC_RATE_3_4_DMIC4_RATE	GENMASK(7, 4)
+#define WCD939X_CDC_DMIC_RATE_3_4_DMIC3_RATE	GENMASK(3, 0)
+#define WCD939X_DIGITAL_PDM_WD_CTL0			   (0x3465)
+#define WCD939X_PDM_WD_CTL0_HOLD_OFF	BIT(4)
+#define WCD939X_PDM_WD_CTL0_TIME_OUT_SEL	BIT(3)
+#define WCD939X_PDM_WD_CTL0_PDM_WD_EN	GENMASK(2, 0)
+#define WCD939X_DIGITAL_PDM_WD_CTL1			   (0x3466)
+#define WCD939X_PDM_WD_CTL1_HOLD_OFF	BIT(4)
+#define WCD939X_PDM_WD_CTL1_TIME_OUT_SEL	BIT(3)
+#define WCD939X_PDM_WD_CTL1_PDM_WD_EN	GENMASK(2, 0)
+#define WCD939X_DIGITAL_PDM_WD_CTL2			   (0x3467)
+#define WCD939X_DIGITAL_INTR_MODE			   (0x346a)
+#define WCD939X_DIGITAL_INTR_MASK_0			   (0x346b)
+#define WCD939X_DIGITAL_INTR_MASK_1			   (0x346c)
+#define WCD939X_DIGITAL_INTR_MASK_2			   (0x346d)
+#define WCD939X_DIGITAL_INTR_STATUS_0			   (0x346e)
+#define WCD939X_DIGITAL_INTR_STATUS_1			   (0x346f)
+#define WCD939X_DIGITAL_INTR_STATUS_2			   (0x3470)
+#define WCD939X_DIGITAL_INTR_CLEAR_0			   (0x3471)
+#define WCD939X_DIGITAL_INTR_CLEAR_1			   (0x3472)
+#define WCD939X_DIGITAL_INTR_CLEAR_2			   (0x3473)
+#define WCD939X_DIGITAL_INTR_LEVEL_0			   (0x3474)
+#define WCD939X_DIGITAL_INTR_LEVEL_1			   (0x3475)
+#define WCD939X_DIGITAL_INTR_LEVEL_2			   (0x3476)
+#define WCD939X_DIGITAL_INTR_SET_0			   (0x3477)
+#define WCD939X_DIGITAL_INTR_SET_1			   (0x3478)
+#define WCD939X_DIGITAL_INTR_SET_2			   (0x3479)
+#define WCD939X_DIGITAL_INTR_TEST_0			   (0x347a)
+#define WCD939X_DIGITAL_INTR_TEST_1			   (0x347b)
+#define WCD939X_DIGITAL_INTR_TEST_2			   (0x347c)
+#define WCD939X_DIGITAL_TX_MODE_DBG_EN			   (0x347f)
+#define WCD939X_DIGITAL_TX_MODE_DBG_0_1			   (0x3480)
+#define WCD939X_DIGITAL_TX_MODE_DBG_2_3			   (0x3481)
+#define WCD939X_DIGITAL_LB_IN_SEL_CTL			   (0x3482)
+#define WCD939X_DIGITAL_LOOP_BACK_MODE			   (0x3483)
+#define WCD939X_DIGITAL_SWR_DAC_TEST			   (0x3484)
+#define WCD939X_DIGITAL_SWR_HM_TEST_RX_0		   (0x3485)
+#define WCD939X_DIGITAL_SWR_HM_TEST_TX_0		   (0x3486)
+#define WCD939X_DIGITAL_SWR_HM_TEST_RX_1		   (0x3487)
+#define WCD939X_DIGITAL_SWR_HM_TEST_TX_1		   (0x3488)
+#define WCD939X_DIGITAL_SWR_HM_TEST_TX_2		   (0x3489)
+#define WCD939X_DIGITAL_SWR_HM_TEST_0			   (0x348a)
+#define WCD939X_DIGITAL_SWR_HM_TEST_1			   (0x348b)
+#define WCD939X_DIGITAL_PAD_CTL_SWR_0			   (0x348c)
+#define WCD939X_DIGITAL_PAD_CTL_SWR_1			   (0x348d)
+#define WCD939X_DIGITAL_I2C_CTL				   (0x348e)
+#define WCD939X_DIGITAL_CDC_TX_TANGGU_SW_MODE		   (0x348f)
+#define WCD939X_DIGITAL_EFUSE_TEST_CTL_0		   (0x3490)
+#define WCD939X_DIGITAL_EFUSE_TEST_CTL_1		   (0x3491)
+#define WCD939X_DIGITAL_EFUSE_T_DATA_0			   (0x3492)
+#define WCD939X_DIGITAL_EFUSE_T_DATA_1			   (0x3493)
+#define WCD939X_DIGITAL_PAD_CTL_PDM_RX0			   (0x3494)
+#define WCD939X_DIGITAL_PAD_CTL_PDM_RX1			   (0x3495)
+#define WCD939X_DIGITAL_PAD_CTL_PDM_TX0			   (0x3496)
+#define WCD939X_DIGITAL_PAD_CTL_PDM_TX1			   (0x3497)
+#define WCD939X_DIGITAL_PAD_CTL_PDM_TX2			   (0x3498)
+#define WCD939X_DIGITAL_PAD_INP_DIS_0			   (0x3499)
+#define WCD939X_DIGITAL_PAD_INP_DIS_1			   (0x349a)
+#define WCD939X_DIGITAL_DRIVE_STRENGTH_0		   (0x349b)
+#define WCD939X_DIGITAL_DRIVE_STRENGTH_1		   (0x349c)
+#define WCD939X_DIGITAL_DRIVE_STRENGTH_2		   (0x349d)
+#define WCD939X_DIGITAL_RX_DATA_EDGE_CTL		   (0x349e)
+#define WCD939X_DIGITAL_TX_DATA_EDGE_CTL		   (0x349f)
+#define WCD939X_DIGITAL_GPIO_MODE			   (0x34a0)
+#define WCD939X_DIGITAL_PIN_CTL_OE			   (0x34a1)
+#define WCD939X_DIGITAL_PIN_CTL_DATA_0			   (0x34a2)
+#define WCD939X_DIGITAL_PIN_CTL_DATA_1			   (0x34a3)
+#define WCD939X_DIGITAL_PIN_STATUS_0			   (0x34a4)
+#define WCD939X_DIGITAL_PIN_STATUS_1			   (0x34a5)
+#define WCD939X_DIGITAL_DIG_DEBUG_CTL			   (0x34a6)
+#define WCD939X_DIGITAL_DIG_DEBUG_EN			   (0x34a7)
+#define WCD939X_DIGITAL_ANA_CSR_DBG_ADD			   (0x34a8)
+#define WCD939X_DIGITAL_ANA_CSR_DBG_CTL			   (0x34a9)
+#define WCD939X_DIGITAL_SSP_DBG				   (0x34aa)
+#define WCD939X_DIGITAL_MODE_STATUS_0			   (0x34ab)
+#define WCD939X_DIGITAL_MODE_STATUS_1			   (0x34ac)
+#define WCD939X_DIGITAL_SPARE_0				   (0x34ad)
+#define WCD939X_DIGITAL_SPARE_1				   (0x34ae)
+#define WCD939X_DIGITAL_SPARE_2				   (0x34af)
+#define WCD939X_DIGITAL_EFUSE_REG_0			   (0x34b0)
+#define WCD939X_EFUSE_REG_0_WCD939X_ID	GENMASK(4, 1)
+#define WCD939X_EFUSE_REG_0_EFUSE_BLOWN	BIT(0)
+#define WCD939X_DIGITAL_EFUSE_REG_1			   (0x34b1)
+#define WCD939X_DIGITAL_EFUSE_REG_2			   (0x34b2)
+#define WCD939X_DIGITAL_EFUSE_REG_3			   (0x34b3)
+#define WCD939X_DIGITAL_EFUSE_REG_4			   (0x34b4)
+#define WCD939X_DIGITAL_EFUSE_REG_5			   (0x34b5)
+#define WCD939X_DIGITAL_EFUSE_REG_6			   (0x34b6)
+#define WCD939X_DIGITAL_EFUSE_REG_7			   (0x34b7)
+#define WCD939X_DIGITAL_EFUSE_REG_8			   (0x34b8)
+#define WCD939X_DIGITAL_EFUSE_REG_9			   (0x34b9)
+#define WCD939X_DIGITAL_EFUSE_REG_10			   (0x34ba)
+#define WCD939X_DIGITAL_EFUSE_REG_11			   (0x34bb)
+#define WCD939X_DIGITAL_EFUSE_REG_12			   (0x34bc)
+#define WCD939X_DIGITAL_EFUSE_REG_13			   (0x34bd)
+#define WCD939X_DIGITAL_EFUSE_REG_14			   (0x34be)
+#define WCD939X_DIGITAL_EFUSE_REG_15			   (0x34bf)
+#define WCD939X_DIGITAL_EFUSE_REG_16			   (0x34c0)
+#define WCD939X_DIGITAL_EFUSE_REG_17			   (0x34c1)
+#define WCD939X_DIGITAL_EFUSE_REG_18			   (0x34c2)
+#define WCD939X_DIGITAL_EFUSE_REG_19			   (0x34c3)
+#define WCD939X_DIGITAL_EFUSE_REG_20			   (0x34c4)
+#define WCD939X_DIGITAL_EFUSE_REG_21			   (0x34c5)
+#define WCD939X_DIGITAL_EFUSE_REG_22			   (0x34c6)
+#define WCD939X_DIGITAL_EFUSE_REG_23			   (0x34c7)
+#define WCD939X_DIGITAL_EFUSE_REG_24			   (0x34c8)
+#define WCD939X_DIGITAL_EFUSE_REG_25			   (0x34c9)
+#define WCD939X_DIGITAL_EFUSE_REG_26			   (0x34ca)
+#define WCD939X_DIGITAL_EFUSE_REG_27			   (0x34cb)
+#define WCD939X_DIGITAL_EFUSE_REG_28			   (0x34cc)
+#define WCD939X_DIGITAL_EFUSE_REG_29			   (0x34cd)
+#define WCD939X_DIGITAL_EFUSE_REG_30			   (0x34ce)
+#define WCD939X_DIGITAL_EFUSE_REG_31			   (0x34cf)
+#define WCD939X_DIGITAL_TX_REQ_FB_CTL_0			   (0x34d0)
+#define WCD939X_DIGITAL_TX_REQ_FB_CTL_1			   (0x34d1)
+#define WCD939X_DIGITAL_TX_REQ_FB_CTL_2			   (0x34d2)
+#define WCD939X_DIGITAL_TX_REQ_FB_CTL_3			   (0x34d3)
+#define WCD939X_DIGITAL_TX_REQ_FB_CTL_4			   (0x34d4)
+#define WCD939X_DIGITAL_DEM_BYPASS_DATA0		   (0x34d5)
+#define WCD939X_DIGITAL_DEM_BYPASS_DATA1		   (0x34d6)
+#define WCD939X_DIGITAL_DEM_BYPASS_DATA2		   (0x34d7)
+#define WCD939X_DIGITAL_DEM_BYPASS_DATA3		   (0x34d8)
+#define WCD939X_DIGITAL_DEM_SECOND_ORDER		   (0x34d9)
+#define WCD939X_DIGITAL_DSM_CTRL			   (0x34da)
+#define WCD939X_DIGITAL_DSM_0_STATIC_DATA_0		   (0x34db)
+#define WCD939X_DIGITAL_DSM_0_STATIC_DATA_1		   (0x34dc)
+#define WCD939X_DIGITAL_DSM_0_STATIC_DATA_2		   (0x34dd)
+#define WCD939X_DIGITAL_DSM_0_STATIC_DATA_3		   (0x34de)
+#define WCD939X_DIGITAL_DSM_1_STATIC_DATA_0		   (0x34df)
+#define WCD939X_DIGITAL_DSM_1_STATIC_DATA_1		   (0x34e0)
+#define WCD939X_DIGITAL_DSM_1_STATIC_DATA_2		   (0x34e1)
+#define WCD939X_DIGITAL_DSM_1_STATIC_DATA_3		   (0x34e2)
+#define WCD939X_RX_TOP_PAGE				   (0x3500)
+#define WCD939X_RX_TOP_TOP_CFG0				   (0x3501)
+#define WCD939X_TOP_CFG0_HPH_DAC_RATE_SEL	BIT(1)
+#define WCD939X_TOP_CFG0_PGA_UPDATE	BIT(0)
+#define WCD939X_RX_TOP_HPHL_COMP_WR_LSB			   (0x3502)
+#define WCD939X_RX_TOP_HPHL_COMP_WR_MSB			   (0x3503)
+#define WCD939X_RX_TOP_HPHL_COMP_LUT			   (0x3504)
+#define WCD939X_RX_TOP_HPHL_COMP_RD_LSB			   (0x3505)
+#define WCD939X_RX_TOP_HPHL_COMP_RD_MSB			   (0x3506)
+#define WCD939X_RX_TOP_HPHR_COMP_WR_LSB			   (0x3507)
+#define WCD939X_RX_TOP_HPHR_COMP_WR_MSB			   (0x3508)
+#define WCD939X_RX_TOP_HPHR_COMP_LUT			   (0x3509)
+#define WCD939X_RX_TOP_HPHR_COMP_RD_LSB			   (0x350a)
+#define WCD939X_RX_TOP_HPHR_COMP_RD_MSB			   (0x350b)
+#define WCD939X_RX_TOP_DSD0_DEBUG_CFG1			   (0x350c)
+#define WCD939X_RX_TOP_DSD0_DEBUG_CFG2			   (0x350d)
+#define WCD939X_RX_TOP_DSD0_DEBUG_CFG3			   (0x350e)
+#define WCD939X_RX_TOP_DSD0_DEBUG_CFG4			   (0x350f)
+#define WCD939X_RX_TOP_DSD0_DEBUG_CFG5			   (0x3510)
+#define WCD939X_RX_TOP_DSD0_DEBUG_CFG6			   (0x3511)
+#define WCD939X_RX_TOP_DSD1_DEBUG_CFG1			   (0x3512)
+#define WCD939X_RX_TOP_DSD1_DEBUG_CFG2			   (0x3513)
+#define WCD939X_RX_TOP_DSD1_DEBUG_CFG3			   (0x3514)
+#define WCD939X_RX_TOP_DSD1_DEBUG_CFG4			   (0x3515)
+#define WCD939X_RX_TOP_DSD1_DEBUG_CFG5			   (0x3516)
+#define WCD939X_RX_TOP_DSD1_DEBUG_CFG6			   (0x3517)
+#define WCD939X_RX_TOP_HPHL_PATH_CFG0			   (0x351c)
+#define WCD939X_HPHL_PATH_CFG0_INT_EN	BIT(1)
+#define WCD939X_HPHL_PATH_CFG0_DLY_ZN_EN	BIT(0)
+#define WCD939X_RX_TOP_HPHL_PATH_CFG1			   (0x351d)
+#define WCD939X_HPHL_PATH_CFG1_DSM_SOFT_RST	BIT(5)
+#define WCD939X_HPHL_PATH_CFG1_INT_SOFT_RST	BIT(4)
+#define WCD939X_HPHL_PATH_CFG1_FMT_CONV	BIT(3)
+#define WCD939X_HPHL_PATH_CFG1_IDLE_OVRD_EN	BIT(2)
+#define WCD939X_HPHL_PATH_CFG1_RX_DC_DROOP_COEFF_SEL	GENMASK(1, 0)
+#define WCD939X_RX_TOP_HPHR_PATH_CFG0			   (0x351e)
+#define WCD939X_HPHR_PATH_CFG0_INT_EN	BIT(2)
+#define WCD939X_HPHR_PATH_CFG0_DLY_ZN_EN	BIT(1)
+#define WCD939X_RX_TOP_HPHR_PATH_CFG1			   (0x351f)
+#define WCD939X_HPHR_PATH_CFG1_DSM_SOFT_RST	BIT(5)
+#define WCD939X_HPHR_PATH_CFG1_INT_SOFT_RST	BIT(4)
+#define WCD939X_HPHR_PATH_CFG1_FMT_CONV	BIT(3)
+#define WCD939X_HPHR_PATH_CFG1_IDLE_OVRD_EN	BIT(2)
+#define WCD939X_HPHR_PATH_CFG1_RX_DC_DROOP_COEFF_SEL	GENMASK(1, 0)
+#define WCD939X_RX_TOP_PATH_CFG2			   (0x3520)
+#define WCD939X_RX_TOP_HPHL_PATH_SEC0			   (0x3521)
+#define WCD939X_RX_TOP_HPHL_PATH_SEC1			   (0x3522)
+#define WCD939X_RX_TOP_HPHL_PATH_SEC2			   (0x3523)
+#define WCD939X_RX_TOP_HPHL_PATH_SEC3			   (0x3524)
+#define WCD939X_RX_TOP_HPHR_PATH_SEC0			   (0x3525)
+#define WCD939X_RX_TOP_HPHR_PATH_SEC1			   (0x3526)
+#define WCD939X_RX_TOP_HPHR_PATH_SEC2			   (0x3527)
+#define WCD939X_RX_TOP_HPHR_PATH_SEC3			   (0x3528)
+#define WCD939X_RX_TOP_PATH_SEC4			   (0x3529)
+#define WCD939X_RX_TOP_PATH_SEC5			   (0x352a)
+#define WCD939X_COMPANDER_HPHL_CTL0			   (0x3540)
+#define WCD939X_COMPANDER_HPHL_CTL1			   (0x3541)
+#define WCD939X_COMPANDER_HPHL_CTL2			   (0x3542)
+#define WCD939X_COMPANDER_HPHL_CTL3			   (0x3543)
+#define WCD939X_COMPANDER_HPHL_CTL4			   (0x3544)
+#define WCD939X_COMPANDER_HPHL_CTL5			   (0x3545)
+#define WCD939X_COMPANDER_HPHL_CTL6			   (0x3546)
+#define WCD939X_COMPANDER_HPHL_CTL7			   (0x3547)
+#define WCD939X_COMPANDER_HPHL_CTL8			   (0x3548)
+#define WCD939X_COMPANDER_HPHL_CTL9			   (0x3549)
+#define WCD939X_COMPANDER_HPHL_CTL10			   (0x354a)
+#define WCD939X_COMPANDER_HPHL_CTL11			   (0x354b)
+#define WCD939X_COMPANDER_HPHL_CTL12			   (0x354c)
+#define WCD939X_COMPANDER_HPHL_CTL13			   (0x354d)
+#define WCD939X_COMPANDER_HPHL_CTL14			   (0x354e)
+#define WCD939X_COMPANDER_HPHL_CTL15			   (0x354f)
+#define WCD939X_COMPANDER_HPHL_CTL16			   (0x3550)
+#define WCD939X_COMPANDER_HPHL_CTL17			   (0x3551)
+#define WCD939X_COMPANDER_HPHL_CTL18			   (0x3552)
+#define WCD939X_COMPANDER_HPHL_CTL19			   (0x3553)
+#define WCD939X_R_CTL0					   (0x3560)
+#define WCD939X_R_CTL1					   (0x3561)
+#define WCD939X_R_CTL2					   (0x3562)
+#define WCD939X_R_CTL3					   (0x3563)
+#define WCD939X_R_CTL4					   (0x3564)
+#define WCD939X_R_CTL5					   (0x3565)
+#define WCD939X_R_CTL6					   (0x3566)
+#define WCD939X_R_CTL7					   (0x3567)
+#define WCD939X_R_CTL8					   (0x3568)
+#define WCD939X_R_CTL9					   (0x3569)
+#define WCD939X_R_CTL10					   (0x356a)
+#define WCD939X_R_CTL11					   (0x356b)
+#define WCD939X_R_CTL12					   (0x356c)
+#define WCD939X_R_CTL13					   (0x356d)
+#define WCD939X_R_CTL14					   (0x356e)
+#define WCD939X_R_CTL15					   (0x356f)
+#define WCD939X_R_CTL16					   (0x3570)
+#define WCD939X_R_CTL17					   (0x3571)
+#define WCD939X_R_CTL18					   (0x3572)
+#define WCD939X_R_CTL19					   (0x3573)
+#define WCD939X_E_PATH_CTL				   (0x3580)
+#define WCD939X_E_CFG0					   (0x3581)
+#define WCD939X_CFG0_AUTO_DISABLE_ANC	BIT(2)
+#define WCD939X_CFG0_AUTO_DISABLE_DSD	BIT(1)
+#define WCD939X_CFG0_IDLE_STEREO	BIT(0)
+#define WCD939X_E_CFG1					   (0x3582)
+#define WCD939X_E_CFG2					   (0x3583)
+#define WCD939X_E_CFG3					   (0x3584)
+#define WCD939X_DSD_HPHL_PATH_CTL			   (0x3590)
+#define WCD939X_DSD_HPHL_CFG0				   (0x3591)
+#define WCD939X_DSD_HPHL_CFG1				   (0x3592)
+#define WCD939X_DSD_HPHL_CFG2				   (0x3593)
+#define WCD939X_DSD_HPHL_CFG3				   (0x3594)
+#define WCD939X_DSD_HPHL_CFG4				   (0x3595)
+#define WCD939X_DSD_HPHL_CFG5				   (0x3596)
+#define WCD939X_DSD_HPHR_PATH_CTL			   (0x35a0)
+#define WCD939X_DSD_HPHR_CFG0				   (0x35a1)
+#define WCD939X_DSD_HPHR_CFG1				   (0x35a2)
+#define WCD939X_DSD_HPHR_CFG2				   (0x35a3)
+#define WCD939X_DSD_HPHR_CFG3				   (0x35a4)
+#define WCD939X_DSD_HPHR_CFG4				   (0x35a5)
+#define WCD939X_DSD_HPHR_CFG5				   (0x35a6)
+#define WCD939X_MAX_REGISTER				   (WCD939X_DSD_HPHR_CFG5)
+
+#define WCD939X_MAX_SWR_PORTS		(6)
+#define WCD939X_MAX_RX_SWR_PORTS	(6)
+#define WCD939X_MAX_TX_SWR_PORTS	(4)
+#define WCD939X_MAX_SWR_CH_IDS		(15)
+
+struct wcd939x_sdw_ch_info {
+	int port_num;
+	unsigned int ch_mask;
+};
+
+#define WCD_SDW_CH(id, pn, cmask)	\
+	[id] = {			\
+		.port_num = pn,		\
+		.ch_mask = cmask,	\
+	}
+
+enum wcd939x_tx_sdw_ports {
+	WCD939X_ADC_1_4_PORT = 1,
+	WCD939X_ADC_DMIC_1_2_PORT,
+	WCD939X_DMIC_0_3_MBHC_PORT,
+	WCD939X_DMIC_3_7_PORT,
+};
+
+enum wcd939x_tx_sdw_channels {
+	WCD939X_ADC1,
+	WCD939X_ADC2,
+	WCD939X_ADC3,
+	WCD939X_ADC4,
+	WCD939X_DMIC0,
+	WCD939X_DMIC1,
+	WCD939X_MBHC,
+	WCD939X_DMIC2,
+	WCD939X_DMIC3,
+	WCD939X_DMIC4,
+	WCD939X_DMIC5,
+	WCD939X_DMIC6,
+	WCD939X_DMIC7,
+};
+
+enum wcd939x_rx_sdw_ports {
+	WCD939X_HPH_PORT = 1,
+	WCD939X_CLSH_PORT,
+	WCD939X_COMP_PORT,
+	WCD939X_LO_PORT,
+	WCD939X_DSD_PORT,
+	WCD939X_HIFI_PCM_PORT,
+};
+
+enum wcd939x_rx_sdw_channels {
+	WCD939X_HPH_L,
+	WCD939X_HPH_R,
+	WCD939X_CLSH,
+	WCD939X_COMP_L,
+	WCD939X_COMP_R,
+	WCD939X_LO,
+	WCD939X_DSD_L,
+	WCD939X_DSD_R,
+	WCD939X_HIFI_PCM_L,
+	WCD939X_HIFI_PCM_R,
+};
+
+enum {
+	WCD939X_SDW_DIR_RX,
+	WCD939X_SDW_DIR_TX,
+};
+
+struct wcd939x_priv;
+struct wcd939x_sdw_priv {
+	struct sdw_slave *sdev;
+	struct sdw_stream_config sconfig;
+	struct sdw_stream_runtime *sruntime;
+	struct sdw_port_config port_config[WCD939X_MAX_SWR_PORTS];
+	struct wcd939x_sdw_ch_info *ch_info;
+	bool port_enable[WCD939X_MAX_SWR_CH_IDS];
+	int active_ports;
+	int num_ports;
+	bool is_tx;
+	struct wcd939x_priv *wcd939x;
+	struct irq_domain *slave_irq;
+	struct regmap *regmap;
+};
+
+#if IS_ENABLED(CONFIG_SND_SOC_WCD939X_SDW)
+int wcd939x_sdw_free(struct wcd939x_sdw_priv *wcd,
+		     struct snd_pcm_substream *substream,
+		     struct snd_soc_dai *dai);
+int wcd939x_sdw_set_sdw_stream(struct wcd939x_sdw_priv *wcd,
+			       struct snd_soc_dai *dai,
+			       void *stream, int direction);
+int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params,
+			  struct snd_soc_dai *dai);
+
+struct device *wcd939x_sdw_device_get(struct device_node *np);
+unsigned int wcd939x_swr_get_current_bank(struct sdw_slave *sdev);
+
+#else
+
+static inline int wcd939x_sdw_free(struct wcd939x_sdw_priv *wcd,
+				   struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int wcd939x_sdw_set_sdw_stream(struct wcd939x_sdw_priv *wcd,
+					     struct snd_soc_dai *dai,
+					     void *stream, int direction)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int wcd939x_sdw_hw_params(struct wcd939x_sdw_priv *wcd,
+					struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params,
+					struct snd_soc_dai *dai)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct device *wcd939x_sdw_device_get(struct device_node *np)
+{
+	return NULL;
+}
+
+static inline unsigned int wcd939x_swr_get_current_bank(struct sdw_slave *sdev)
+{
+	return 0;
+}
+#endif /* CONFIG_SND_SOC_WCD939X_SDW */
+
+#endif /* __WCD939X_H__ */

-- 
2.34.1

