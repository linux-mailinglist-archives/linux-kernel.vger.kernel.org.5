Return-Path: <linux-kernel+bounces-7099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7793081A1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AA61F22A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773F40BE9;
	Wed, 20 Dec 2023 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="L6DX30we"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE923E46E;
	Wed, 20 Dec 2023 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKAmXS3012278;
	Wed, 20 Dec 2023 15:57:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=g6KFG95QTDX3DDGTxlBut801yEYbV9MUDWmT6tLu8gg=; b=L6
	DX30weht13vT7o/awcBqMslP7ZyeQPGDxQ7Z55Tlm2yTiFzPVUsT2NYZLFL5Luj/
	WT6yHTIPp4v5XcZX+vIQTXXkfQ2OvW/qlDbxNGTrS2SUPrf9R3XNvYiS9VARyMve
	J/KyQPQ2mtzg+K7jPutJQYrsmvLIDH+/W7mUe5hQ43kvQS1wKvjHmp4V94N+PZhT
	ocVsemEA+Ikg5sjimxmGqZGMLwVlYuFhmKlk7pnZlprCbxVI7Yf1ym7ZYSvMxcad
	/DouPyutjeVuUYiQl9NgGxAz0LeZlmskry1v1fhlC4DkRar0lWJbQ+y1QVSrFFER
	dCsUKuhGTi8+IOmikxbw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v13nhhqt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:57:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37102100059;
	Wed, 20 Dec 2023 15:57:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E31421B512;
	Wed, 20 Dec 2023 15:57:57 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:57:56 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/10] counter: stm32-timer-cnt: introduce clock signal
Date: Wed, 20 Dec 2023 15:57:20 +0100
Message-ID: <20231220145726.640627-5-fabrice.gasnier@foss.st.com>
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
 definitions=2023-12-20_08,2023-12-20_01,2023-05-22_02

Introduce the internal clock signal, used to count when in simple rising
function. Also add the "frequency" extension to the clock signal.

With this patch, signal action reports a consistent state when "increase"
function is used, and the counting frequency:
    $ echo increase > function
    $ grep -H "" signal*_action
    signal0_action:none
    signal1_action:none
    signal2_action:rising edge
    $ echo 1 > enable
    $ cat count
    25425
    $ cat count
    44439
    $ cat ../signal2/frequency
    208877930

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- split the patch in 3 parts: signal definition becomes a pre-cursor patch,
  add the "prescaler" extension in its own patch.
- Move the clock signal at the end of the signals array, so existing
  userspace programs that may rely on signal0 being "Channel 1" for
  example will remain compatible.
---
 drivers/counter/stm32-timer-cnt.c | 53 ++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index c34747d7857e..21a9c20c4281 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -23,6 +23,7 @@
 
 #define STM32_CH1_SIG		0
 #define STM32_CH2_SIG		1
+#define STM32_CLOCK_SIG		2
 
 struct stm32_timer_regs {
 	u32 cr1;
@@ -226,6 +227,10 @@ static struct counter_comp stm32_count_ext[] = {
 			     stm32_count_ceiling_write),
 };
 
+static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
 static const enum counter_synapse_action stm32_synapse_actions[] = {
 	COUNTER_SYNAPSE_ACTION_NONE,
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
@@ -246,7 +251,10 @@ static int stm32_action_read(struct counter_device *counter,
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
@@ -264,7 +272,10 @@ static int stm32_action_read(struct counter_device *counter,
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
@@ -279,7 +290,30 @@ static const struct counter_ops stm32_timer_cnt_ops = {
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
+	/*
+	 * Need to declare all the signals as a static array, and keep the signals order here,
+	 * even if they're unused or unexisting on some timer instances. It's an abstraction,
+	 * e.g. high level view of the counter features.
+	 *
+	 * Userspace programs may rely on signal0 to be "Channel 1", signal1 to be "Channel 2",
+	 * and so on. When a signal is unexisting, the COUNTER_SYNAPSE_ACTION_NONE can be used,
+	 * to indicate that a signal doesn't affect the counter.
+	 */
 	{
 		.id = STM32_CH1_SIG,
 		.name = "Channel 1"
@@ -287,7 +321,13 @@ static struct counter_signal stm32_signals[] = {
 	{
 		.id = STM32_CH2_SIG,
 		.name = "Channel 2"
-	}
+	},
+	{
+		.id = STM32_CLOCK_SIG,
+		.name = "Clock Signal",
+		.ext = stm32_count_clock_ext,
+		.num_ext = ARRAY_SIZE(stm32_count_clock_ext),
+	},
 };
 
 static struct counter_synapse stm32_count_synapses[] = {
@@ -300,7 +340,12 @@ static struct counter_synapse stm32_count_synapses[] = {
 		.actions_list = stm32_synapse_actions,
 		.num_actions = ARRAY_SIZE(stm32_synapse_actions),
 		.signal = &stm32_signals[STM32_CH2_SIG]
-	}
+	},
+	{
+		.actions_list = stm32_clock_synapse_actions,
+		.num_actions = ARRAY_SIZE(stm32_clock_synapse_actions),
+		.signal = &stm32_signals[STM32_CLOCK_SIG]
+	},
 };
 
 static struct counter_count stm32_counts = {
-- 
2.25.1


