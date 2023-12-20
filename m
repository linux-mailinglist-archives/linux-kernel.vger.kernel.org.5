Return-Path: <linux-kernel+bounces-7109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDF81A1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14031C2494E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74F3DBBA;
	Wed, 20 Dec 2023 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ePcAbV5x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C1405D6;
	Wed, 20 Dec 2023 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKA44JO026222;
	Wed, 20 Dec 2023 16:00:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=VX1e1MqWUsqC3HC2njjApU0jyW7yAkL6duCodzEeM5Q=; b=eP
	cAbV5xk+x3Qo7PibNPS/EaLbPsy+ycxKxli2tbC2A2N05VXoSMvsH577BvcGHBVw
	WmKTJpAAvFE7m8wPJXpNNlR0RWJDwbdjwXXOFXpAsQEtUMB7XM7VXF67ylO5USG6
	jR2Nr77V6kBeSxri7RlTLM7I/aR06+CQ2es6myuIDap8kXmneZVSLTNKcTf32mh6
	jm3P6fBRzzSkGEKWH9wao+gUnnosz2SJ28qYNok3mUDcezVW8pVJ+48cMgisXYiw
	8TbA9UStW4rqxxVahkvAH+eHmjBKJ5FZuY3p5c2Oi/Iixk13lFvZTtH1CULAZC9u
	fW87KI2+LKPlL9FMrTyQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v126m2j86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 16:00:23 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C5C85100057;
	Wed, 20 Dec 2023 16:00:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B804321ADA0;
	Wed, 20 Dec 2023 16:00:22 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 16:00:21 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/10] counter: stm32-timer-cnt: add support for capture events
Date: Wed, 20 Dec 2023 15:57:26 +0100
Message-ID: <20231220145726.640627-11-fabrice.gasnier@foss.st.com>
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

Add support for capture events. Captured counter value for each channel
can be retrieved through CCRx register.
STM32 timers can have up to 4 capture channels (on input channel 1 to
channel 4), hence need to check the number of channels before reading
the capture data.
The capture configuration is hard-coded to capture signals on both edges
(non-inverted). Interrupts are used to report events independently for
each channel.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- patch split from: "counter: stm32-timer-cnt: add support for events", to
  focus on the capture events only here.
- only get relevant interrupt line
---
 drivers/counter/stm32-timer-cnt.c | 134 +++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index d13e4c427965..0b131ca71de6 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -263,6 +263,40 @@ static int stm32_count_prescaler_write(struct counter_device *counter,
 	return regmap_write(priv->regmap, TIM_PSC, psc);
 }
 
+static int stm32_count_cap_read(struct counter_device *counter,
+				struct counter_count *count,
+				size_t ch, u64 *cap)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 ccrx;
+
+	if (ch >= priv->nchannels)
+		return -EOPNOTSUPP;
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
+	dev_dbg(counter->parent, "CCR%zu: 0x%08x\n", ch + 1, ccrx);
+
+	*cap = ccrx;
+
+	return 0;
+}
+
 static int stm32_count_nb_ovf_read(struct counter_device *counter,
 				   struct counter_count *count, u64 *val)
 {
@@ -286,6 +320,8 @@ static int stm32_count_nb_ovf_write(struct counter_device *counter,
 	return 0;
 }
 
+static DEFINE_COUNTER_ARRAY_CAPTURE(stm32_count_cap_array, 4);
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
@@ -293,6 +329,7 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
 			       stm32_count_prescaler_write),
+	COUNTER_COMP_ARRAY_CAPTURE(stm32_count_cap_read, NULL, stm32_count_cap_array),
 	COUNTER_COMP_COUNT_U64("num_overflows", stm32_count_nb_ovf_read, stm32_count_nb_ovf_write),
 };
 
@@ -351,11 +388,68 @@ static int stm32_action_read(struct counter_device *counter,
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
+	if (ch >= ARRAY_SIZE(stm32_cc) || ch >= priv->nchannels) {
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
 static int stm32_count_events_configure(struct counter_device *counter)
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	struct counter_event_node *event_node;
 	u32 val, dier = 0;
+	int i, ret;
 
 	list_for_each_entry(event_node, &counter->events_list, l) {
 		switch (event_node->event) {
@@ -366,6 +460,12 @@ static int stm32_count_events_configure(struct counter_device *counter)
 				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
 			dier |= TIM_DIER_UIE;
 			break;
+		case COUNTER_EVENT_CAPTURE:
+			ret = stm32_count_capture_configure(counter, event_node->channel, true);
+			if (ret)
+				return ret;
+			dier |= TIM_DIER_CC_IE(event_node->channel);
+			break;
 		default:
 			/* should never reach this path */
 			return -EINVAL;
@@ -374,6 +474,15 @@ static int stm32_count_events_configure(struct counter_device *counter)
 
 	regmap_write(priv->regmap, TIM_DIER, dier);
 
+	/* check for disabled capture events */
+	for (i = 0 ; i < priv->nchannels; i++) {
+		if (!(dier & TIM_DIER_CC_IE(i))) {
+			ret = stm32_count_capture_configure(counter, i, false);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -387,6 +496,12 @@ static int stm32_count_watch_validate(struct counter_device *counter,
 		return -EOPNOTSUPP;
 
 	switch (watch->event) {
+	case COUNTER_EVENT_CAPTURE:
+		if (watch->channel >= priv->nchannels) {
+			dev_err(counter->parent, "Invalid channel %d\n", watch->channel);
+			return -EINVAL;
+		}
+		return 0;
 	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
 		return 0;
 	default:
@@ -497,6 +612,7 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 clr = GENMASK(31, 0); /* SR flags can be cleared by writing 0 (wr 1 has no effect) */
 	u32 sr, dier;
+	int i;
 
 	regmap_read(priv->regmap, TIM_SR, &sr);
 	regmap_read(priv->regmap, TIM_DIER, &dier);
@@ -504,7 +620,7 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
 	 * Some status bits in SR don't match with the enable bits in DIER. Only take care of
 	 * the possibly enabled bits in DIER (that matches in between SR and DIER).
 	 */
-	dier &= TIM_DIER_UIE;
+	dier &= (TIM_DIER_UIE | TIM_DIER_CC1IE | TIM_DIER_CC2IE | TIM_DIER_CC3IE | TIM_DIER_CC4IE);
 	sr &= dier;
 
 	if (sr & TIM_SR_UIF) {
@@ -515,6 +631,15 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void *ptr)
 		clr &= ~TIM_SR_UIF;
 	}
 
+	/* Check capture events */
+	for (i = 0 ; i < priv->nchannels; i++) {
+		if (sr & TIM_SR_CC_IF(i)) {
+			counter_push_event(counter, COUNTER_EVENT_CAPTURE, i);
+			clr &= ~TIM_SR_CC_IF(i);
+			dev_dbg(counter->parent, "COUNTER_EVENT_CAPTURE, %d\n", i);
+		}
+	}
+
 	regmap_write(priv->regmap, TIM_SR, clr);
 
 	return IRQ_HANDLED;
@@ -627,8 +752,11 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 		}
 	} else {
 		for (i = 0; i < priv->nr_irqs; i++) {
-			/* Only take care of update IRQ for overflow events */
-			if (i != STM32_TIMERS_IRQ_UP)
+			/*
+			 * Only take care of update IRQ for overflow events, and cc for
+			 * capture events.
+			 */
+			if (i != STM32_TIMERS_IRQ_UP && i != STM32_TIMERS_IRQ_CC)
 				continue;
 
 			ret = devm_request_irq(&pdev->dev, priv->irq[i], stm32_timer_cnt_isr,
-- 
2.25.1


