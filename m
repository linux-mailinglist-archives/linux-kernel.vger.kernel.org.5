Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5557978C78C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjH2OaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjH2O35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:29:57 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F3CC;
        Tue, 29 Aug 2023 07:29:53 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TC1taC012172;
        Tue, 29 Aug 2023 15:42:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=BOqZ2SyfNpjhUHOPbQ6ZP82OTT/+YcIGQszooI+OKnk=; b=HB
        hoEjWxS0W31OIt1aLskq2Qml/g1DKnpxjeoRJ4jqO9LsOS2Gk0rHRedARizHMmfN
        r4QAvJo7/5vtpV1wTpUuWJXviWsDo6vS+cKpmv9cHuXwEPRqfLkmnTugCaizeyjm
        tST0bw6+8ttIz3i+cJxcozfmoYMNojoshKNnzUiDOzQn0tbOMf30Me34Z0v1g22v
        hKWkFQMPSSGuNME+4V90PxDe0hv6FFwjE5uoo2DVzfs2HzRuHu7oIdPxOml1Jkff
        MtIdTaYJ1bI7Jn5ogzA55hqBG1HfMfwnOIJ7ysQZ8CLWrLyWsyfNvFSSRkeUCzkr
        YFoOkNTVZFi1XeZcSN4A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqvbha31n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:42:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5201A10005E;
        Tue, 29 Aug 2023 15:42:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4968722AFFD;
        Tue, 29 Aug 2023 15:42:09 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:42:08 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>, <lee@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] counter: stm32-timer-cnt: introduce clock signal
Date:   Tue, 29 Aug 2023 15:40:27 +0200
Message-ID: <20230829134029.2402868-7-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the internal clock signal, used to count when in simple rising
function. Define signal ids, to improve readability. Also add the
"frequency" attribute for the clock signal, and "prescaler" for the
counter.

Whit this patch, signal action reports consistent state when "increase"
function is used, and the counting frequency:
$ echo increase > function
$ grep -H "" signal*_action
signal0_action:rising edge
signal1_action:none
signal2_action:none
$ echo 1 > enable
$ cat count
25425
$ cat count
44439
$ cat ../signal0/frequency
208877930

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/counter/stm32-timer-cnt.c | 84 ++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index eae851f6db2c..b8d201383a64 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -21,6 +21,10 @@
 #define TIM_CCER_MASK	(TIM_CCER_CC1P | TIM_CCER_CC1NP | \
 			 TIM_CCER_CC2P | TIM_CCER_CC2NP)
 
+#define STM32_CLOCK_SIG		0
+#define STM32_CH1_SIG		1
+#define STM32_CH2_SIG		2
+
 struct stm32_timer_regs {
 	u32 cr1;
 	u32 cnt;
@@ -216,11 +220,44 @@ static int stm32_count_enable_write(struct counter_device *counter,
 	return 0;
 }
 
+static int stm32_count_prescaler_read(struct counter_device *counter,
+				      struct counter_count *count, u64 *prescaler)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 psc;
+
+	regmap_read(priv->regmap, TIM_PSC, &psc);
+
+	*prescaler = psc + 1;
+
+	return 0;
+}
+
+static int stm32_count_prescaler_write(struct counter_device *counter,
+				       struct counter_count *count, u64 prescaler)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+	u32 psc;
+
+	if (!prescaler || prescaler > MAX_TIM_PSC + 1)
+		return -ERANGE;
+
+	psc = prescaler - 1;
+
+	return regmap_write(priv->regmap, TIM_PSC, psc);
+}
+
 static struct counter_comp stm32_count_ext[] = {
 	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
 	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
 	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
 			     stm32_count_ceiling_write),
+	COUNTER_COMP_COUNT_U64("prescaler", stm32_count_prescaler_read,
+			       stm32_count_prescaler_write),
+};
+
+static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 };
 
 static const enum counter_synapse_action stm32_synapse_actions[] = {
@@ -243,25 +280,31 @@ static int stm32_action_read(struct counter_device *counter,
 	switch (function) {
 	case COUNTER_FUNCTION_INCREASE:
 		/* counts on internal clock when CEN=1 */
-		*action = COUNTER_SYNAPSE_ACTION_NONE;
+		if (synapse->signal->id == STM32_CLOCK_SIG)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X2_A:
 		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
-		if (synapse->signal->id == count->synapses[0].signal->id)
+		if (synapse->signal->id == STM32_CH1_SIG)
 			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		else
 			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X2_B:
 		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
-		if (synapse->signal->id == count->synapses[1].signal->id)
+		if (synapse->signal->id == STM32_CH2_SIG)
 			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		else
 			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	case COUNTER_FUNCTION_QUADRATURE_X4:
 		/* counts up/down on both TI1FP1 and TI2FP2 edges */
-		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		if (synapse->signal->id == STM32_CH1_SIG || synapse->signal->id == STM32_CH2_SIG)
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 		return 0;
 	default:
 		return -EINVAL;
@@ -276,27 +319,52 @@ static const struct counter_ops stm32_timer_cnt_ops = {
 	.action_read = stm32_action_read,
 };
 
+static int stm32_count_clk_get_freq(struct counter_device *counter,
+				    struct counter_signal *signal, u64 *freq)
+{
+	struct stm32_timer_cnt *const priv = counter_priv(counter);
+
+	*freq = clk_get_rate(priv->clk);
+
+	return 0;
+}
+
+static struct counter_comp stm32_count_clock_ext[] = {
+	COUNTER_COMP_SIGNAL_U64("frequency", stm32_count_clk_get_freq, NULL),
+};
+
 static struct counter_signal stm32_signals[] = {
 	{
-		.id = 0,
+		.id = STM32_CLOCK_SIG,
+		.name = "Clock Signal",
+		.ext = stm32_count_clock_ext,
+		.num_ext = ARRAY_SIZE(stm32_count_clock_ext),
+	},
+	{
+		.id = STM32_CH1_SIG,
 		.name = "Channel 1 Quadrature A"
 	},
 	{
-		.id = 1,
+		.id = STM32_CH2_SIG,
 		.name = "Channel 2 Quadrature B"
 	}
 };
 
 static struct counter_synapse stm32_count_synapses[] = {
+	{
+		.actions_list = stm32_clock_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_clock_synapse_actions),
+		.signal = &stm32_signals[STM32_CLOCK_SIG]
+	},
 	{
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
-		.signal = &stm32_signals[0]
+		.signal = &stm32_signals[STM32_CH1_SIG]
 	},
 	{
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
-		.signal = &stm32_signals[1]
+		.signal = &stm32_signals[STM32_CH2_SIG]
 	}
 };
 
-- 
2.25.1

