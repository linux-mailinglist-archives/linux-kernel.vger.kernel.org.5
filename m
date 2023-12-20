Return-Path: <linux-kernel+bounces-7101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C918381A1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FE31C24342
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800C3F8D0;
	Wed, 20 Dec 2023 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ow37LzVW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9413E466;
	Wed, 20 Dec 2023 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BKAQ6fK020548;
	Wed, 20 Dec 2023 15:59:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=xp/c+t2tNZhdwFtDsDw7WOFKDiPnT7aLbJzsg/uPGbU=; b=ow
	37LzVWvaya8fQSmAHh7y02MQed+lC2CFI1uTwI/U68pNoCr7Zm0vdlvWzlokKF6n
	V7ujIqtCFKdDHMMHux+lXMaU/PR7eZa63qgpfiYyyWdP90Czlqm9AfGipIXK9qRJ
	t/gg4nDLRSn3q1pio+WKI8Nr2SsHWgf97X34YtDbccG/qn//X7pctkk5X1Uxdohy
	MjVRwj6KW+FC1QJshx1u4p97a4ajVEVr0nI3zausHHhPbWmef8tP57WeCjLh1MQf
	sm2rcg0u9NqzK2wZEaO+ggbIv6d3hINwuZdb2cjqaCkXLCre6GN14b453nIWNEc8
	2YgBziwRiUoDjUKHbiMA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v144225p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 15:59:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20886100057;
	Wed, 20 Dec 2023 15:59:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 153DC21B51F;
	Wed, 20 Dec 2023 15:59:11 +0100 (CET)
Received: from localhost (10.201.20.59) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Dec
 2023 15:59:10 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/10] counter: stm32-timer-cnt: probe number of channels from registers
Date: Wed, 20 Dec 2023 15:57:24 +0100
Message-ID: <20231220145726.640627-9-fabrice.gasnier@foss.st.com>
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

Probe the number of capture compare channels, by writing CCER register bits
and read them back. Take care to restore the register original value.

This is a precursor patch to support capture channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- New patch split from:
  "counter: stm32-timer-cnt: populate capture channels and check encoder"
---
 drivers/counter/stm32-timer-cnt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 55eb6af34750..b5dc4378fecf 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -43,6 +43,7 @@ struct stm32_timer_cnt {
 	struct stm32_timer_regs bak;
 	bool has_encoder;
 	u32 idx;
+	unsigned int nchannels;
 };
 
 static const enum counter_function stm32_count_functions[] = {
@@ -417,6 +418,20 @@ static struct counter_count stm32_counts = {
 	.num_ext = ARRAY_SIZE(stm32_count_ext)
 };
 
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
 /* encoder supported on TIM1 TIM2 TIM3 TIM4 TIM5 TIM8 */
 #define STM32_TIM_ENCODER_SUPPORTED	(BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(7))
 
@@ -484,6 +499,8 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	stm32_timer_cnt_detect_channels(pdev, priv);
+
 	counter->name = dev_name(dev);
 	counter->parent = dev;
 	counter->ops = &stm32_timer_cnt_ops;
-- 
2.25.1


