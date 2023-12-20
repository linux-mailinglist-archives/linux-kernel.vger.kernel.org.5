Return-Path: <linux-kernel+bounces-7106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9621281A1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0251C1F23741
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BCB41212;
	Wed, 20 Dec 2023 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jmkLz3pe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BE41741;
	Wed, 20 Dec 2023 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKAKkOd026644;
	Wed, 20 Dec 2023 15:59:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=27s5gqZ8CpISwz9sEJ9KmbSXmWANFBZJ5F5PfijotM8=; b=jm
	kLz3peXIJp5C6TZiOexzA+OZKxXTWuRGD8rCxAQxXFjuptl+CrFh4AWQ+i0RvL5f
	LtLMEDhYcILupjq9+azz3zwCBpTM0NxT2GjIsw0FxWnfYj70X4OmLTSSU/AG/ouA
	QiMLglJGLQtINcCxhFQECmelzV4AKgRNsGZ5sm4+mGHP3MlFT1F5esfAxwYC8bCQ
	W8vdReyTzSRT+fo6BC2vDcC4pOnwQ0gQmIkdS5qZYzCQgHNWV1dtRf5dMgdj8O01
	fRpv6Sc0PUIzXNRhMmaJrZ9c0X2F8FT5DwwUhXv5waS+CqCwHpVFzLa+19k5NUHr
	ni/7Mjhr6ObDm7DEpd+g==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v11w91wfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:59:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0DDD3100059;
	Wed, 20 Dec 2023 15:59:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 00A9421B51D;
	Wed, 20 Dec 2023 15:59:08 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:59:07 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/10] counter: stm32-timer-cnt: add counter prescaler extension
Date: Wed, 20 Dec 2023 15:57:21 +0100
Message-ID: <20231220145726.640627-6-fabrice.gasnier@foss.st.com>
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

There's a prescaler in between the selected input signal used for
counting (CK_PSC), and the counter input (CK_CNT).
So add the "prescaler" extension to the counter.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- New patch split from "counter: stm32-timer-cnt: introduce clock signal"
---
 drivers/counter/stm32-timer-cnt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 21a9c20c4281..bf2726dd7f12 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -220,11 +220,40 @@ static int stm32_count_enable_write(struct counter_device *counter,
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
 };
 
 static const enum counter_synapse_action stm32_clock_synapse_actions[] = {
-- 
2.25.1


