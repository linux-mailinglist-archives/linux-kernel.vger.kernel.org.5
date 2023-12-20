Return-Path: <linux-kernel+bounces-7103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220381A1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9158C1C23396
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C5405ED;
	Wed, 20 Dec 2023 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f73ksnNa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607733E499;
	Wed, 20 Dec 2023 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKE2HmD025268;
	Wed, 20 Dec 2023 15:59:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=x6nQQ71xtku6SiZZzFF5O30s9wsVUqCHS/O30UoRmzg=; b=f7
	3ksnNaRy7Z4lT6orLLWkkndDsFgTqvKTEieeOOhJr8VJSnO7zboXsII2lDOphp17
	45Gn2xDqRqbySut2TaoE2nbExxntKIRCH4tdpy1CneLc84PiSUiGG4i5zJsGp0l7
	6qa9CUrsZ7Xn732fweNVmbvM7jP1ev+od1N7sBL7cZQZ3l/nbTSJB+2WGHt6zk5N
	hiRG/wGNlEgJFXB0Udqq6xSS4nly+nd0ePhWUEujKLZBaaa++JlyEP+LYlIyJ50Q
	x4++lATqmBf/32xVXIsD+B7292fEP5vdBFyZY0xZVe1QTczIZV1HOQg5SOsXXnj/
	90RsSqgiksUtmkETrJxg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v3q80u4kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:59:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0041100063;
	Wed, 20 Dec 2023 15:59:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E493621B51F;
	Wed, 20 Dec 2023 15:59:11 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:59:11 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/10] counter: stm32-timer-cnt: add support for overflow events
Date: Wed, 20 Dec 2023 15:57:25 +0100
Message-ID: <20231220145726.640627-10-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_09,2023-12-20_01,2023-05-22_02

Add support overflow events. Also add the related validation and
configuration routine. Register and enable interrupts to push events.
STM32 Timers can have either 1 global interrupt, or 4 dedicated interrupt
lines. Request only the necessary interrupt, e.g. either global interrupt
that can report all event types, or update interrupt only for overflow
event.

Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- patch split from: "counter: stm32-timer-cnt: add support for events", to
  focus on the overflow events only here. Move the capture event support
  to a separate patch.
- simplify the patch, by removing diversity introduced by the number of
  possible channels. All channels are now exposed instead.
  Report an error when trying to access a channel that doesn't exist.

Changes in v2:
- fix warnings (kernel test robot)
- fix a typo
- add collected ack from Lee
---
 drivers/counter/stm32-timer-cnt.c | 132 +++++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h  |  13 +++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index b5dc4378fecf..d13e4c427965 100644
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
@@ -44,6 +45,9 @@ struct stm32_timer_cnt {
 	bool has_encoder;
 	u32 idx;
 	unsigned int nchannels;
+	unsigned int nr_irqs;
+	u32 *irq;
+	atomic_t nb_ovf;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -259,6 +263,29 @@ static int stm32_count_prescaler_write(struct counter_device *counter,
 	return regmap_write(priv->regmap, TIM_PSC, psc);
 }
 
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
+	if (val != (typeof(priv->nb_ovf.counter))val)
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
@@ -266,6 +293,7 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
 			       stm32_count_prescaler_write),
+	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
 };
 
 static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
@@ -323,12 +351,57 @@ static int stm32_action_read(struct counter_device *counter,
 	}
 }
 
+static int stm32_count_events_configure(struct counter_device *counter)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	struct counter_event_node *event_node;
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
+		default:
+			/* should never reach this path */
+			return -EINVAL;
+		}
+	}
+
+	regmap_write(priv->regmap, TIM_DIER, dier);
+
+	return 0;
+}
+
+static int stm32_count_watch_validate(struct counter_device *counter,
+				      const struct counter_watch *watch)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	/* Interrupts are optional */
+	if (!priv->nr_irqs)
+		return -EOPNOTSUPP;
+
+	switch (watch->event) {
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
@@ -418,6 +491,35 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
+static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
+{
+	struct counter_device *counter = ptr;
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 clr = GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr 1 has no effect) */
+	u32 sr, dier;
+
+	regmap_read(priv->regmap, TIM_SR, &sr);
+	regmap_read(priv->regmap, TIM_DIER, &dier);
+	/*
+	 * Some status bits in SR don't match with the enable bits in DIER. Only take care of
+	 * the possibly enabled bits in DIER (that matches in between SR and DIER).
+	 */
+	dier &= TIM_DIER_UIE;
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
+	regmap_write(priv->regmap, TIM_SR, clr);
+
+	return IRQ_HANDLED;
+};
+
 static void stm32_timer_cnt_detect_channels(struct platform_device *pdev,
 					    struct stm32_timer_cnt *priv)
 {
@@ -480,7 +582,7 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct stm32_timer_cnt *priv;
 	struct counter_device *counter;
-	int ret;
+	int i, ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
@@ -494,6 +596,8 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
+	priv->nr_irqs = ddata->nr_irqs;
+	priv->irq = ddata->irq;
 
 	ret = stm32_timer_cnt_probe_encoder(pdev, priv);
 	if (ret)
@@ -511,6 +615,32 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	/* STM32 Timers can have either 1 global, or 4 dedicated interrupts (optional) */
+	if (priv->nr_irqs == 1) {
+		/* All events reported through the global interrupt */
+		ret = devm_request_irq(&pdev->dev, priv->irq[0], stm32_timer_cnt_isr,
+				       0, dev_name(dev), counter);
+		if (ret) {
+			dev_err(dev, "Failed to request irq %d (err %d)\n",
+				priv->irq[i], ret);
+			return ret;
+		}
+	} else {
+		for (i = 0; i < priv->nr_irqs; i++) {
+			/* Only take care of update IRQ for overflow events */
+			if (i != STM32_TIMERS_IRQ_UP)
+				continue;
+
+			ret = devm_request_irq(&pdev->dev, priv->irq[i], stm32_timer_cnt_isr,
+					       0, dev_name(dev), counter);
+			if (ret) {
+				dev_err(dev, "Failed to request irq %d (err %d)\n",
+					priv->irq[i], ret);
+				return ret;
+			}
+		}
+	}
+
 	/* Reset input selector to its default input */
 	regmap_write(priv->regmap, TIM_TISEL, 0x0);
 
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index ca35af30745f..9eb17481b07f 100644
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
-- 
2.25.1


