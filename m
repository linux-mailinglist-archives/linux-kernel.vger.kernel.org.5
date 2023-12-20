Return-Path: <linux-kernel+bounces-7100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D981A1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8371F21C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476C3DB9B;
	Wed, 20 Dec 2023 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4cemLYBa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBB3E478;
	Wed, 20 Dec 2023 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKDtBEe023361;
	Wed, 20 Dec 2023 15:59:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=aGDnZpzUU9Vo6OuENOZWDVj2oc7Tl0EGM7EnZev4dXU=; b=4c
	emLYBaEC2mX8oz16/LzVpsbSEJ5MSpNHZSfbXQaCcWEYY1Vp+UUf++1fqm9Zl5Jz
	XeYMFpWbKTkTu2KqKI9S8/Rs2BLkYvC8lB3SGv9rOWfGIV67+Om3+DTuyHIZHkUl
	7dyTKY1vGCz0t6Pk2NgUEtGv4FYJ1UhXRD9MOJ+5VVsvtGw6CLLqc7cqaMc0Tl0R
	9qhwV/2rf2r9OC45Hcut90mR342M4co1F5FlRy/zeHW1YsvZZgb7yZfBK1zMEB4N
	7j2OviSc/teIgDU16+0UlGGndAHcvssR2ZRgzd/zArtrcSQcQ8HfrLUCa455zmrO
	ov1IGVogcQFVf4FH9pTg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v3q80u4k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:59:09 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D90B9100063;
	Wed, 20 Dec 2023 15:59:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCD7121B51D;
	Wed, 20 Dec 2023 15:59:08 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:59:08 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/10] counter: stm32-timer-cnt: add checks on quadrature encoder capability
Date: Wed, 20 Dec 2023 15:57:22 +0100
Message-ID: <20231220145726.640627-7-fabrice.gasnier@foss.st.com>
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

This is a precursor patch to support capture channels on all possible
channels and stm32 timer types. Original driver was intended to be used
only as quadrature encoder and simple counter on internal clock.

So, add a check on encoder capability, so the driver may be probed for
timer instances without encoder feature. This way, all timers may be used
as simple counter on internal clock, starting from here.

Encoder capability is retrieved by using the timer index (originally in
stm32-timer-trigger driver and dt-bindings). The need to keep backward
compatibility with existing device tree lead to parse aside trigger node.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- New patch split from:
  "counter: stm32-timer-cnt: populate capture channels and check encoder"
- return -EOPNOTSUPP when encoder function isn't supported by the timer
  instance.
---
 drivers/counter/stm32-timer-cnt.c | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index bf2726dd7f12..6933d42b16bf 100644
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
@@ -38,6 +39,8 @@ struct stm32_timer_cnt {
 	u32 max_arr;
 	bool enabled;
 	struct stm32_timer_regs bak;
+	bool has_encoder;
+	u32 idx;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -111,12 +114,18 @@ static int stm32_count_function_write(struct counter_device *counter,
 		sms = TIM_SMCR_SMS_SLAVE_MODE_DISABLED;
 		break;
 	case COUNTER_FUNCTION_QUADRATURE_X2_A:
+		if (!priv->has_encoder)
+			return -EOPNOTSUPP;
 		sms = TIM_SMCR_SMS_ENCODER_MODE_1;
 		break;
 	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		if (!priv->has_encoder)
+			return -EOPNOTSUPP;
 		sms = TIM_SMCR_SMS_ENCODER_MODE_2;
 		break;
 	case COUNTER_FUNCTION_QUADRATURE_X4:
+		if (!priv->has_encoder)
+			return -EOPNOTSUPP;
 		sms = TIM_SMCR_SMS_ENCODER_MODE_3;
 		break;
 	default:
@@ -388,6 +397,48 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
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
@@ -409,6 +460,10 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 
+	ret = stm32_timer_cnt_probe_encoder(pdev, priv);
+	if (ret)
+		return ret;
+
 	counter->name = dev_name(dev);
 	counter->parent = dev;
 	counter->ops = &stm32_timer_cnt_ops;
-- 
2.25.1


