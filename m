Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471497AB3EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjIVOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjIVOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:41:20 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5E1194;
        Fri, 22 Sep 2023 07:41:13 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M9w09J012040;
        Fri, 22 Sep 2023 16:40:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=/h97/B4qukxhkFZg0Z5d4Altp8Ugvu3thWH/oppv3tk=; b=rI
        i3IdiASUhP9+rGiah8YJ6wNvnlne2uU/o+Teld0WdkkZO1fZVaA7Vt4TmT7DBtQX
        /wB7sM9p06jZAobEPDFTvJNXesN8i9fH8L4lW03ktsy40HxSF9aOF6Dnw+CosmqN
        BhsJKCzCyS5EXTYWJ5HePPzrrRleUC+DNW7i2BF/jvJ9K6kZGwKZb95Ujv2kZq5o
        Kd2M6VRJEruW7RSY3RLqH53dZdSMP1rtjPoc4tSbEqpgW6mA8X2KysdKRuG4vIV1
        wsQuNF9odalTbPSsYGTMx0CI27MUNUNa0/aKVY4nsIIlYxS/3Z8kE7kv3WiJ2YFo
        ixKERJK/ONE9U0qgzyfA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt43x9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 16:40:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30F30100056;
        Fri, 22 Sep 2023 16:40:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28891235F22;
        Fri, 22 Sep 2023 16:40:57 +0200 (CEST)
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
Subject: [PATCH v2 6/6] counter: stm32-timer-cnt: add support for events
Date:   Fri, 22 Sep 2023 16:39:20 +0200
Message-ID: <20230922143920.3144249-7-fabrice.gasnier@foss.st.com>
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
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for capture and overflow events. Also add the related
validation and configuration. Captured counter value can be retrieved
through CCRx register. Register and enable interrupts to push events.

Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- fix warnings (kernel test robot)
- fix a typo
- add collected ack from Lee
---
 drivers/counter/stm32-timer-cnt.c | 280 +++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h  |  15 ++
 2 files changed, 286 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index acde993891f5..baa6a2c0ccbf 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -8,6 +8,7 @@
  *
  */
 #include <linux/counter.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/stm32-timers.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -37,6 +38,7 @@ struct stm32_timer_regs {
 
 struct stm32_timer_cnt {
 	struct regmap *regmap;
+	atomic_t nb_ovf;
 	struct clk *clk;
 	u32 max_arr;
 	bool enabled;
@@ -44,6 +46,8 @@ struct stm32_timer_cnt {
 	bool has_encoder;
 	u32 idx;
 	unsigned int nchannels;
+	unsigned int nr_irqs;
+	u32 *irq;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -253,6 +257,60 @@ static int stm32_count_prescaler_write(struct counter_device *counter,
 	return regmap_write(priv->regmap, TIM_PSC, psc);
 }
 
+static int stm32_count_cap_read(struct counter_device *counter,
+				struct counter_count *count,
+				size_t ch, u64 *cap)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 ccrx;
+
+	switch (ch) {
+	case 0:
+		regmap_read(priv->regmap, TIM_CCR1, &ccrx);
+		break;
+	case 1:
+		regmap_read(priv->regmap, TIM_CCR2, &ccrx);
+		break;
+	case 2:
+		regmap_read(priv->regmap, TIM_CCR3, &ccrx);
+		break;
+	case 3:
+		regmap_read(priv->regmap, TIM_CCR4, &ccrx);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(counter->parent, "CCR%zu: 0x%08x\n", ch, ccrx);
+
+	*cap = ccrx;
+
+	return 0;
+}
+
+static int stm32_count_nb_ovf_read(struct counter_device *counter,
+				   struct counter_count *count, u64 *val)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	*val = atomic_read(&priv->nb_ovf);
+
+	return 0;
+}
+
+static int stm32_count_nb_ovf_write(struct counter_device *counter,
+				    struct counter_count *count, u64 val)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	atomic_set(&priv->nb_ovf, val);
+
+	return 0;
+}
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
@@ -260,6 +318,43 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
 			       stm32_count_prescaler_write),
+	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
+};
+
+static DEFINE_COUNTER_ARRAY_CAPTURE(stm32_count_cap_array_4ch, 4);
+static struct counter_comp stm32_count_4ch_ext[] = {
+	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
+	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
+	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
+			     stm32_count_ceiling_write),
+	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
+			       stm32_count_prescaler_write),
+	COUNTER_COMP_ARRAY_CAPTURE(stm32_count_cap_read, NULL, stm32_count_cap_array_4ch),
+	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
+};
+
+static DEFINE_COUNTER_ARRAY_CAPTURE(stm32_count_cap_array_2ch, 2);
+static struct counter_comp stm32_count_2ch_ext[] = {
+	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
+	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
+	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
+			     stm32_count_ceiling_write),
+	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
+			       stm32_count_prescaler_write),
+	COUNTER_COMP_ARRAY_CAPTURE(stm32_count_cap_read, NULL, stm32_count_cap_array_2ch),
+	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
+};
+
+static DEFINE_COUNTER_ARRAY_CAPTURE(stm32_count_cap_array_1ch, 1);
+static struct counter_comp stm32_count_1ch_ext[] = {
+	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
+	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
+	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
+			     stm32_count_ceiling_write),
+	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
+			       stm32_count_prescaler_write),
+	COUNTER_COMP_ARRAY_CAPTURE(stm32_count_cap_read, NULL, stm32_count_cap_array_1ch),
+	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
 };
 
 static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
@@ -321,12 +416,131 @@ static int stm32_action_read(struct counter_device *counter,
 	}
 }
 
+struct stm32_count_cc_regs {
+	u32 ccmr_reg;
+	u32 ccmr_mask;
+	u32 ccmr_bits;
+	u32 ccer_bits;
+};
+
+static const struct stm32_count_cc_regs stm32_cc[] = {
+	{ TIM_CCMR1, TIM_CCMR_CC1S, TIM_CCMR_CC1S_TI1,
+		TIM_CCER_CC1E | TIM_CCER_CC1P | TIM_CCER_CC1NP },
+	{ TIM_CCMR1, TIM_CCMR_CC2S, TIM_CCMR_CC2S_TI2,
+		TIM_CCER_CC2E | TIM_CCER_CC2P | TIM_CCER_CC2NP },
+	{ TIM_CCMR2, TIM_CCMR_CC3S, TIM_CCMR_CC3S_TI3,
+		TIM_CCER_CC3E | TIM_CCER_CC3P | TIM_CCER_CC3NP },
+	{ TIM_CCMR2, TIM_CCMR_CC4S, TIM_CCMR_CC4S_TI4,
+		TIM_CCER_CC4E | TIM_CCER_CC4P | TIM_CCER_CC4NP },
+};
+
+static int stm32_count_capture_configure(struct counter_device *counter, unsigned int ch,
+					 bool enable)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 ccmr, ccer, sr;
+
+	if (ch >= ARRAY_SIZE(stm32_cc)) {
+		dev_err(counter->parent, "invalid ch: %d\n", ch);
+		return -EINVAL;
+	}
+
+	/*
+	 * configure channel in input capture mode, map channel 1 on TI1, channel2 on TI2...
+	 * Select both edges / non-inverted to trigger a capture.
+	 */
+	if (enable) {
+		/* first clear possibly latched capture flag upon enabling */
+		regmap_read(priv->regmap, TIM_CCER, &ccer);
+		if (!(ccer & stm32_cc[ch].ccer_bits)) {
+			sr = ~TIM_SR_CC_IF(ch);
+			regmap_write(priv->regmap, TIM_SR, sr);
+		}
+		regmap_update_bits(priv->regmap, stm32_cc[ch].ccmr_reg, stm32_cc[ch].ccmr_mask,
+				   stm32_cc[ch].ccmr_bits);
+		regmap_set_bits(priv->regmap, TIM_CCER, stm32_cc[ch].ccer_bits);
+	} else {
+		regmap_clear_bits(priv->regmap, TIM_CCER, stm32_cc[ch].ccer_bits);
+		regmap_clear_bits(priv->regmap, stm32_cc[ch].ccmr_reg, stm32_cc[ch].ccmr_mask);
+	}
+
+	regmap_read(priv->regmap, stm32_cc[ch].ccmr_reg, &ccmr);
+	regmap_read(priv->regmap, TIM_CCER, &ccer);
+	dev_dbg(counter->parent, "%s(%s) ch%d 0x%08x 0x%08x\n", __func__, enable ? "ena" : "dis",
+		ch, ccmr, ccer);
+
+	return 0;
+}
+
+static int stm32_count_events_configure(struct counter_device *counter)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	struct counter_event_node *event_node;
+	int i, ret;
+	u32 val, dier = 0;
+
+	list_for_each_entry(event_node, &counter->events_list, l) {
+		switch (event_node->event) {
+		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
+			/* first clear possibly latched UIF before enabling */
+			regmap_read(priv->regmap, TIM_DIER, &val);
+			if (!(val & TIM_DIER_UIE))
+				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
+			dier |= TIM_DIER_UIE;
+			break;
+		case COUNTER_EVENT_CAPTURE:
+			ret = stm32_count_capture_configure(counter, event_node->channel, true);
+			if (ret)
+				return ret;
+			dier |= TIM_DIER_CC_IE(event_node->channel);
+			break;
+		default:
+			/* should never reach this path */
+			return -EINVAL;
+		}
+	}
+
+	regmap_write(priv->regmap, TIM_DIER, dier);
+
+	/* check for disabled capture events */
+	for (i = 0 ; i < priv->nchannels; i++) {
+		if (!(dier & TIM_DIER_CC_IE(i))) {
+			ret = stm32_count_capture_configure(counter, i, false);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int stm32_count_watch_validate(struct counter_device *counter,
+				      const struct counter_watch *watch)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	switch (watch->event) {
+	case COUNTER_EVENT_CAPTURE:
+		if (watch->channel >= priv->nchannels) {
+			dev_err(counter->parent, "Invalid channel %d\n", watch->channel);
+			return -EINVAL;
+		}
+		return 0;
+	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct counter_ops stm32_timer_cnt_ops = {
 	.count_read = stm32_count_read,
 	.count_write = stm32_count_write,
 	.function_read = stm32_count_function_read,
 	.function_write = stm32_count_function_write,
 	.action_read = stm32_action_read,
+	.events_configure = stm32_count_events_configure,
+	.watch_validate = stm32_count_watch_validate,
 };
 
 static int stm32_count_clk_get_freq(struct counter_device *counter,
@@ -404,8 +618,8 @@ static struct counter_count stm32_counts_enc_4ch = {
 	.num_functions = ARRAY_SIZE(stm32_count_functions),
 	.synapses = stm32_count_synapses_4ch_enc,
 	.num_synapses = ARRAY_SIZE(stm32_count_synapses_4ch_enc),
-	.ext = stm32_count_ext,
-	.num_ext = ARRAY_SIZE(stm32_count_ext)
+	.ext = stm32_count_4ch_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_4ch_ext)
 };
 
 /* STM32 Timer with up to 4 capture channels */
@@ -444,8 +658,8 @@ static struct counter_count stm32_counts_4ch = {
 	.num_functions = 1, /* increase */
 	.synapses = stm32_count_synapses,
 	.num_synapses = ARRAY_SIZE(stm32_count_synapses),
-	.ext = stm32_count_ext,
-	.num_ext = ARRAY_SIZE(stm32_count_ext)
+	.ext = stm32_count_4ch_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_4ch_ext)
 };
 
 static struct counter_count stm32_counts_2ch = {
@@ -455,8 +669,8 @@ static struct counter_count stm32_counts_2ch = {
 	.num_functions = 1, /* increase */
 	.synapses = stm32_count_synapses,
 	.num_synapses = 3, /* clock, ch1 and ch2 */
-	.ext = stm32_count_ext,
-	.num_ext = ARRAY_SIZE(stm32_count_ext)
+	.ext = stm32_count_2ch_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_2ch_ext)
 };
 
 static struct counter_count stm32_counts_1ch = {
@@ -466,8 +680,8 @@ static struct counter_count stm32_counts_1ch = {
 	.num_functions = 1, /* increase */
 	.synapses = stm32_count_synapses,
 	.num_synapses = 2, /* clock, ch1 */
-	.ext = stm32_count_ext,
-	.num_ext = ARRAY_SIZE(stm32_count_ext)
+	.ext = stm32_count_1ch_ext,
+	.num_ext = ARRAY_SIZE(stm32_count_1ch_ext)
 };
 
 static struct counter_count stm32_counts = {
@@ -481,6 +695,42 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
+static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
+{
+	struct counter_device *counter = ptr;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 clr = GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr 1 has no effect) */
+	u32 sr, dier;
+	int i;
+
+	regmap_read(priv->regmap, TIM_SR, &sr);
+	regmap_read(priv->regmap, TIM_DIER, &dier);
+	/* Only take care of enabled IRQs */
+	dier &= (TIM_DIER_UIE | TIM_DIER_CC1IE | TIM_DIER_CC2IE | TIM_DIER_CC3IE | TIM_DIER_CC4IE);
+	sr &= dier;
+
+	if (sr & TIM_SR_UIF) {
+		atomic_inc(&priv->nb_ovf);
+		counter_push_event(counter, COUNTER_EVENT_OVERFLOW_UNDERFLOW, 0);
+		dev_dbg(counter->parent, "COUNTER_EVENT_OVERFLOW_UNDERFLOW\n");
+		/* SR flags can be cleared by writing 0, only clear relevant flag */
+		clr &= ~TIM_SR_UIF;
+	}
+
+	/* Check capture events */
+	for (i = 0 ; i < priv->nchannels; i++) {
+		if (sr & TIM_SR_CC_IF(i)) {
+			counter_push_event(counter, COUNTER_EVENT_CAPTURE, i);
+			clr &= ~TIM_SR_CC_IF(i);
+			dev_dbg(counter->parent, "COUNTER_EVENT_CAPTURE, %d\n", i);
+		}
+	}
+
+	regmap_write(priv->regmap, TIM_SR, clr);
+
+	return IRQ_HANDLED;
+};
+
 static void stm32_timer_cnt_detect_channels(struct platform_device *pdev,
 					    struct stm32_timer_cnt *priv)
 {
@@ -543,7 +793,7 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_timer_cnt *priv;
 	struct counter_device *counter;
-	int ret;
+	int i, ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
@@ -557,6 +807,8 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
+	priv->nr_irqs = ddata->nr_irqs;
+	priv->irq = ddata->irq;
 
 	ret = stm32_timer_cnt_probe_encoder(pdev, priv);
 	if (ret)
@@ -602,6 +854,16 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	for (i = 0; i < priv->nr_irqs; i++) {
+		ret = devm_request_irq(&pdev->dev, priv->irq[i], stm32_timer_cnt_isr,
+				       0, dev_name(dev), counter);
+		if (ret) {
+			dev_err(dev, "Failed to request irq %d (err %d)\n",
+				priv->irq[i], ret);
+			return ret;
+		}
+	}
+
 	/* Reset input selector to its default input */
 	regmap_write(priv->regmap, TIM_TISEL, 0x0);
 
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index ca35af30745f..5291be74fba1 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -41,6 +41,11 @@
 #define TIM_SMCR_SMS	(BIT(0) | BIT(1) | BIT(2)) /* Slave mode selection */
 #define TIM_SMCR_TS	(BIT(4) | BIT(5) | BIT(6)) /* Trigger selection */
 #define TIM_DIER_UIE	BIT(0)	/* Update interrupt	   */
+#define TIM_DIER_CC1IE	BIT(1)  /* CC1 Interrupt Enable    */
+#define TIM_DIER_CC2IE	BIT(2)  /* CC2 Interrupt Enable    */
+#define TIM_DIER_CC3IE	BIT(3)  /* CC3 Interrupt Enable    */
+#define TIM_DIER_CC4IE	BIT(4)  /* CC4 Interrupt Enable    */
+#define TIM_DIER_CC_IE(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt enable */
 #define TIM_DIER_UDE	BIT(8)  /* Update DMA request Enable */
 #define TIM_DIER_CC1DE	BIT(9)  /* CC1 DMA request Enable  */
 #define TIM_DIER_CC2DE	BIT(10) /* CC2 DMA request Enable  */
@@ -49,6 +54,7 @@
 #define TIM_DIER_COMDE	BIT(13) /* COM DMA request Enable  */
 #define TIM_DIER_TDE	BIT(14) /* Trigger DMA request Enable */
 #define TIM_SR_UIF	BIT(0)	/* Update interrupt flag   */
+#define TIM_SR_CC_IF(x)	BIT((x) + 1) /* CC1, CC2, CC3, CC4 interrupt flag */
 #define TIM_EGR_UG	BIT(0)	/* Update Generation       */
 #define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
 #define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
@@ -60,16 +66,23 @@
 #define TIM_CCMR_CC1S_TI2	BIT(1)	/* IC1/IC3 selects TI2/TI4 */
 #define TIM_CCMR_CC2S_TI2	BIT(8)	/* IC2/IC4 selects TI2/TI4 */
 #define TIM_CCMR_CC2S_TI1	BIT(9)	/* IC2/IC4 selects TI1/TI3 */
+#define TIM_CCMR_CC3S		(BIT(0) | BIT(1)) /* Capture/compare 3 sel */
+#define TIM_CCMR_CC4S		(BIT(8) | BIT(9)) /* Capture/compare 4 sel */
+#define TIM_CCMR_CC3S_TI3	BIT(0)	/* IC3 selects TI3 */
+#define TIM_CCMR_CC4S_TI4	BIT(8)	/* IC4 selects TI4 */
 #define TIM_CCER_CC1E	BIT(0)	/* Capt/Comp 1  out Ena    */
 #define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
 #define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
 #define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
 #define TIM_CCER_CC2E	BIT(4)	/* Capt/Comp 2  out Ena    */
 #define TIM_CCER_CC2P	BIT(5)	/* Capt/Comp 2  Polarity   */
+#define TIM_CCER_CC2NP	BIT(7)	/* Capt/Comp 2N Polarity   */
 #define TIM_CCER_CC3E	BIT(8)	/* Capt/Comp 3  out Ena    */
 #define TIM_CCER_CC3P	BIT(9)	/* Capt/Comp 3  Polarity   */
+#define TIM_CCER_CC3NP	BIT(11)	/* Capt/Comp 3N Polarity   */
 #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
 #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
+#define TIM_CCER_CC4NP	BIT(15)	/* Capt/Comp 4N Polarity   */
 #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
 #define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
 #define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
@@ -91,6 +104,8 @@
 #define TIM_BDTR_BKF_MASK	0xF
 #define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
 
+#define MAX_TIM_IC_CHANNELS	4 /* Max number of input capture channels */
+
 enum stm32_timers_dmas {
 	STM32_TIMERS_DMA_CH1,
 	STM32_TIMERS_DMA_CH2,
-- 
2.25.1

