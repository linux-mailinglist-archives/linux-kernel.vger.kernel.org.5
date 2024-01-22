Return-Path: <linux-kernel+bounces-32500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A71B835C67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DA3285179
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FA20DF6;
	Mon, 22 Jan 2024 08:18:27 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AC20DE1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911507; cv=none; b=mPKYxeDfaWdrAokb/XSam4voUx7zVHpjjNlCMIQAV0e+hE72XOWdRYqm0vwcLuDLu062rVwLHBfhShdLiGkXR0xYCZOOKdX/E9NPJHI7gZ8kGFxmg/lwqakZIsvHgNKAsHLFE8M5alX9PUBOszSgp1vlvCTufchcJwetbwM48zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911507; c=relaxed/simple;
	bh=ucncD4LgxTJrxIeRTuDJbk8/gy62TUU+zwKtbsZDx/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhiiFg3xLjYIxh2lqbWprdbqAcCaCUiJrrugpJfQwvDBUC5ZJdj4rr9FvoFYlkuZU+Hu/C5jSrbo1srW0DRt5ZQqVgdfz0ZTKT4bPwuk13tg+FxBCI4creSpmk4ilI24Ay1jQuGOGsl8MzhrFxhgutNnIeWmf+d8UaL8G7G0IFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40M8I4kT055344;
	Mon, 22 Jan 2024 16:18:04 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJNFd1Jnrz2Rb68b;
	Mon, 22 Jan 2024 16:10:45 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 22 Jan
 2024 16:18:02 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        zhaochen su <zhaochen.su29@gmail.com>,
        Zhaochen Su
	<Zhaochen.Su@unisoc.com>,
        Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH 1/6] pwm: sprd: Add support for UMS9620
Date: Mon, 22 Jan 2024 16:17:49 +0800
Message-ID: <20240122081754.17058-2-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
References: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40M8I4kT055344

The PMW unit on the current Unisoc's SoCs has 4 channels but has different
address offsets. On UMS512, they are 0x0, 0x20, 0x40, 0x60 respectively,
while are 0x0, 0x4000, 0x8000, 0xC000 on UMS9620.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 drivers/pwm/pwm-sprd.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 77939e161006..bc1e3ed13528 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -9,6 +9,7 @@
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
@@ -23,7 +24,6 @@
 #define SPRD_PWM_ENABLE_BIT	BIT(0)
 
 #define SPRD_PWM_CHN_NUM	4
-#define SPRD_PWM_REGS_SHIFT	5
 #define SPRD_PWM_CHN_CLKS_NUM	2
 #define SPRD_PWM_CHN_OUTPUT_CLK	1
 
@@ -32,14 +32,27 @@ struct sprd_pwm_chn {
 	u32 clk_rate;
 };
 
+struct sprd_pwm_data {
+	int reg_shift;
+};
+
 struct sprd_pwm_chip {
 	void __iomem *base;
 	struct device *dev;
 	struct pwm_chip chip;
+	const struct sprd_pwm_data *pdata;
 	int num_pwms;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
 
+static const struct sprd_pwm_data ums512_data = {
+	.reg_shift = 5,
+};
+
+static const struct sprd_pwm_data ums9620_data = {
+	.reg_shift = 14,
+};
+
 static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct sprd_pwm_chip, chip);
@@ -58,7 +71,7 @@ static const char * const sprd_pwm_clks[] = {
 
 static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32 hwid, u32 reg)
 {
-	u32 offset = reg + (hwid << SPRD_PWM_REGS_SHIFT);
+	u32 offset = reg + (hwid << spc->pdata->reg_shift);
 
 	return readl_relaxed(spc->base + offset);
 }
@@ -66,7 +79,7 @@ static u32 sprd_pwm_read(struct sprd_pwm_chip *spc, u32 hwid, u32 reg)
 static void sprd_pwm_write(struct sprd_pwm_chip *spc, u32 hwid,
 			   u32 reg, u32 val)
 {
-	u32 offset = reg + (hwid << SPRD_PWM_REGS_SHIFT);
+	u32 offset = reg + (hwid << spc->pdata->reg_shift);
 
 	writel_relaxed(val, spc->base + offset);
 }
@@ -253,6 +266,7 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
 static int sprd_pwm_probe(struct platform_device *pdev)
 {
 	struct sprd_pwm_chip *spc;
+	const void *priv;
 	int ret;
 
 	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
@@ -263,6 +277,11 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(spc->base))
 		return PTR_ERR(spc->base);
 
+	priv = of_device_get_match_data(&pdev->dev);
+	if (!priv)
+		return dev_err_probe(&pdev->dev, -EINVAL, "get regs shift failed!\n");
+	spc->pdata = priv;
+
 	spc->dev = &pdev->dev;
 
 	ret = sprd_pwm_clk_init(spc);
@@ -281,7 +300,8 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_pwm_of_match[] = {
-	{ .compatible = "sprd,ums512-pwm", },
+	{ .compatible = "sprd,ums512-pwm",	.data = (void *)&ums512_data},
+	{ .compatible = "sprd,ums9620-pwm",	.data = (void *)&ums9620_data},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sprd_pwm_of_match);
-- 
2.17.1


