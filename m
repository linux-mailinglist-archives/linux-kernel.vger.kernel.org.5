Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495FC7AB3E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjIVOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIVOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:41:18 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C6100;
        Fri, 22 Sep 2023 07:41:11 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M9nFDX017250;
        Fri, 22 Sep 2023 16:40:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=KawZuSWRVccI0W5CBQPTZeJo7z6FFdlhAulsQVOR4f8=; b=oC
        DZQ18aCDYcal9l5X2EKaR6ppRUrDDkKVKL74fXeABBHkn1Io2ogcAxca3srv39i/
        47SJ5hmkdD/bl0szHboglMro5D/B/RDm5U/A/5Tn65JPHFi4K8bjNo58vDt3tKtm
        /I8dzw0JluSror7oX3r6s5VVymxNpqc8gtBS+tcR9UD49TPk9bpcxCgUTeyh5wAa
        7aQhnWP2n0Mo++D2H5uH6boQpJUrde7KUDqOSWnoSv6w3w0sJgusB4kxpjd7B13v
        lo2yzReRUjE38vi2qGfvuhVEOzwfH+9+iRNvMwJtx3nxjR2p+savPUYgxNxeyVxf
        0geiRutQlE+ahKv/4Fog==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt5uwba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 16:40:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95433100051;
        Fri, 22 Sep 2023 16:40:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B308235F22;
        Fri, 22 Sep 2023 16:40:56 +0200 (CEST)
Received: from localhost (10.252.14.82) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 16:40:56 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] counter: stm32-timer-cnt: populate capture channels and check encoder
Date:   Fri, 22 Sep 2023 16:39:19 +0200
Message-ID: <20230922143920.3144249-6-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.14.82]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a precursor patch to support capture channels on all possible
channels and stm32 timer types. Original driver was intended to be used
only as quadrature encoder and simple counter on internal clock.

So, add ch3 and ch4 definition. Also add a check on encoder capability,
so the driver may be probed for timer instances without encoder feature.
This way, all timers may be used as simple counter on internal clock,
starting from here.
Encoder capability is retrieved by using the timer index (originally in
stm32-timer-trigger driver and dt-bindings). The need to keep backward
compatibility with existing device tree lead to parse aside trigger node.
Add diversity as STM32 timers with capture feature may have either 4, 2,
1 or no cc (capture/compare) channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- rework to simplify since channel names has been updated.
---
 drivers/counter/stm32-timer-cnt.c | 204 +++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 11c66876b213..acde993891f5 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/stm32-timers.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
@@ -24,6 +25,8 @@
 #define STM32_CLOCK_SIG		0
 #define STM32_CH1_SIG		1
 #define STM32_CH2_SIG		2
+#define STM32_CH3_SIG		3
+#define STM32_CH4_SIG		4
 
 struct stm32_timer_regs {
 	u32 cr1;
@@ -38,6 +41,9 @@ struct stm32_timer_cnt {
 	u32 max_arr;
 	bool enabled;
 	struct stm32_timer_regs bak;
+	bool has_encoder;
+	u32 idx;
+	unsigned int nchannels;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -265,6 +271,10 @@ static const enum counter_synapse_action stm32_synapse_actions[] = {
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
 
+static const enum counter_synapse_action stm32_synapse_ch_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
 static int stm32_action_read(struct counter_device *counter,
 			     struct counter_count *count,
 			     struct counter_synapse *synapse,
@@ -347,10 +357,19 @@ static struct counter_signal stm32_signals[] = {
 	{
 		.id = STM32_CH2_SIG,
 		.name = "Channel 2"
+	},
+	{
+		.id = STM32_CH3_SIG,
+		.name = "Channel 3"
+	},
+	{
+		.id = STM32_CH4_SIG,
+		.name = "Channel 4"
 	}
 };
 
-static struct counter_synapse stm32_count_synapses[] = {
+/* STM32 Timer with 4 capture channels and quadrature encoder */
+static struct counter_synapse stm32_count_synapses_4ch_enc[] = {
 	{
 		.actions_list = stm32_clock_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_clock_synapse_actions),
@@ -365,20 +384,159 @@ static struct counter_synapse stm32_count_synapses[] = {
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
 		.signal = &stm32_signals[STM32_CH2_SIG]
-	}
+	},
+	{
+		.actions_list = stm32_synapse_ch_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_ch_actions),
+		.signal = &stm32_signals[STM32_CH3_SIG]
+	},
+	{
+		.actions_list = stm32_synapse_ch_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_ch_actions),
+		.signal = &stm32_signals[STM32_CH4_SIG]
+	},
 };
 
-static struct counter_count stm32_counts = {
+static struct counter_count stm32_counts_enc_4ch = {
 	.id = 0,
 	.name = "STM32 Timer Counter",
 	.functions_list = stm32_count_functions,
 	.num_functions = ARRAY_SIZE(stm32_count_functions),
+	.synapses = stm32_count_synapses_4ch_enc,
+	.num_synapses = ARRAY_SIZE(stm32_count_synapses_4ch_enc),
+	.ext = stm32_count_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_ext)
+};
+
+/* STM32 Timer with up to 4 capture channels */
+static struct counter_synapse stm32_count_synapses[] = {
+	{
+		.actions_list = stm32_clock_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_clock_synapse_actions),
+		.signal = &stm32_signals[STM32_CLOCK_SIG]
+	},
+	{
+		.actions_list = stm32_synapse_ch_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_ch_actions),
+		.signal = &stm32_signals[STM32_CH1_SIG]
+	},
+	{
+		.actions_list = stm32_synapse_ch_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_ch_actions),
+		.signal = &stm32_signals[STM32_CH2_SIG]
+	},
+	{
+		.actions_list = stm32_synapse_ch_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_ch_actions),
+		.signal = &stm32_signals[STM32_CH3_SIG]
+	},
+	{
+		.actions_list = stm32_synapse_ch_actions,
+		.num_actions = ARRAY_SIZE(stm32_synapse_ch_actions),
+		.signal = &stm32_signals[STM32_CH4_SIG]
+	},
+};
+
+static struct counter_count stm32_counts_4ch = {
+	.id = 0,
+	.name = "STM32 Timer Counter",
+	.functions_list = stm32_count_functions,
+	.num_functions = 1, /* increase */
 	.synapses = stm32_count_synapses,
 	.num_synapses = ARRAY_SIZE(stm32_count_synapses),
 	.ext = stm32_count_ext,
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
+static struct counter_count stm32_counts_2ch = {
+	.id = 0,
+	.name = "STM32 Timer Counter",
+	.functions_list = stm32_count_functions,
+	.num_functions = 1, /* increase */
+	.synapses = stm32_count_synapses,
+	.num_synapses = 3, /* clock, ch1 and ch2 */
+	.ext = stm32_count_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_ext)
+};
+
+static struct counter_count stm32_counts_1ch = {
+	.id = 0,
+	.name = "STM32 Timer Counter",
+	.functions_list = stm32_count_functions,
+	.num_functions = 1, /* increase */
+	.synapses = stm32_count_synapses,
+	.num_synapses = 2, /* clock, ch1 */
+	.ext = stm32_count_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_ext)
+};
+
+static struct counter_count stm32_counts = {
+	.id = 0,
+	.name = "STM32 Timer Counter",
+	.functions_list = stm32_count_functions,
+	.num_functions = 1, /* increase */
+	.synapses = stm32_count_synapses,
+	.num_synapses = 1, /* clock only */
+	.ext = stm32_count_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_ext)
+};
+
+static void stm32_timer_cnt_detect_channels(struct platform_device *pdev,
+					    struct stm32_timer_cnt *priv)
+{
+	u32 ccer, ccer_backup;
+
+	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
+	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
+	priv->nchannels = hweight32(ccer & TIM_CCER_CCXE);
+
+	dev_dbg(&pdev->dev, "has %d cc channels\n", priv->nchannels);
+}
+
+/* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 */
+#define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7))
+
+static const char * const stm32_timer_trigger_compat[] = {
+	"st,stm32-timer-trigger",
+	"st,stm32h7-timer-trigger",
+};
+
+static int stm32_timer_cnt_probe_encoder(struct platform_device *pdev,
+					 struct stm32_timer_cnt *priv)
+{
+	struct device *parent = pdev->dev.parent;
+	struct device_node *tnode = NULL, *pnode = parent->of_node;
+	int i, ret;
+
+	/*
+	 * Need to retrieve the trigger node index from DT, to be able
+	 * to determine if the counter supports encoder mode. It also
+	 * enforce backward compatibility, and allow to support other
+	 * counter modes in this driver (when the timer doesn't support
+	 * encoder).
+	 */
+	for (i = 0; i < ARRAY_SIZE(stm32_timer_trigger_compat) && !tnode; i++)
+		tnode = of_get_compatible_child(pnode, stm32_timer_trigger_compat[i]);
+	if (!tnode) {
+		dev_err(&pdev->dev, "Can't find trigger node\n");
+		return -ENODATA;
+	}
+
+	ret = of_property_read_u32(tnode, "reg", &priv->idx);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't get index (%d)\n", ret);
+		return ret;
+	}
+
+	priv->has_encoder = !!(STM32_TIM_ENCODER_SUPPORTED & BIT(priv->idx));
+
+	dev_dbg(&pdev->dev, "encoder support: %s\n", priv->has_encoder ? "yes" : "no");
+
+	return 0;
+}
+
 static int stm32_timer_cnt_probe(struct platform_device *pdev)
 {
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
@@ -400,13 +558,47 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 
+	ret = stm32_timer_cnt_probe_encoder(pdev, priv);
+	if (ret)
+		return ret;
+
+	stm32_timer_cnt_detect_channels(pdev, priv);
+
 	counter->name = dev_name(dev);
 	counter->parent = dev;
 	counter->ops = &stm32_timer_cnt_ops;
-	counter->counts = &stm32_counts;
 	counter->num_counts = 1;
-	counter->signals = stm32_signals;
-	counter->num_signals = ARRAY_SIZE(stm32_signals);
+
+	/*
+	 * Handle diversity for stm32 timers features. For now encoder is found with
+	 * advanced timers or gp timers with 4 channels. Timers with less channels
+	 * doesn't support encoder.
+	 */
+	switch (priv->nchannels) {
+	case 4:
+		if (priv->has_encoder)
+			counter->counts = &stm32_counts_enc_4ch;
+		else
+			counter->counts = &stm32_counts_4ch;
+		counter->signals = stm32_signals;
+		counter->num_signals = ARRAY_SIZE(stm32_signals);
+		break;
+	case 2:
+		counter->counts = &stm32_counts_2ch;
+		counter->signals = stm32_signals;
+		counter->num_signals = 3; /* clock, ch1 and ch2 */
+		break;
+	case 1:
+		counter->counts = &stm32_counts_1ch;
+		counter->signals = stm32_signals;
+		counter->num_signals = 2; /* clock, ch1 */
+		break;
+	default:
+		counter->counts = &stm32_counts;
+		counter->signals = stm32_signals;
+		counter->num_signals = 1; /* clock */
+		break;
+	}
 
 	platform_set_drvdata(pdev, priv);
 
-- 
2.25.1

