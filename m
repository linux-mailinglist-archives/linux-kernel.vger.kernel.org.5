Return-Path: <linux-kernel+bounces-37911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72883B78B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FD31F2547B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9991163DD;
	Thu, 25 Jan 2024 03:08:57 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562911FAD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152137; cv=none; b=urTBx/2xMWNBkhhlNQSZ8cxC6l7nVjdNdhV0/hOrhseKhNL1zYXQT2mTz4d8KFxcZUUn1J9i0HL4En4o8hQ8ijpAiGqomqJHg0wiOu+vsrK07Jbx2diMYpu3ENHl7KnuQDC2pvVRzcRcKmkxsaA0ULphm3Dd0YcDnxDCBpjprHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152137; c=relaxed/simple;
	bh=ucncD4LgxTJrxIeRTuDJbk8/gy62TUU+zwKtbsZDx/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF2V7TCAqrqFUR9rSNbW4MgfWEVD0YeMIdSxjdwAqBrrPQJtDLelUA06X9lIKUh6LBhGp/+K6uIiMnmtLsIPm/eDsGAh0KFXYN4RYZj8+w0md9I0kByHjhMoTjbEPIR/Ey6hcaeS5i0QmVGlK3XkLP1FIcpBwCUB7A5QOuPR5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40P38baV061394;
	Thu, 25 Jan 2024 11:08:37 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TL5F40rjCz2Rq2lv;
	Thu, 25 Jan 2024 11:01:12 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 25 Jan
 2024 11:08:35 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        zhaochen
 su <zhaochen.su29@gmail.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Xiaolong
 Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH V2 1/6] pwm: sprd: Add support for UMS9620
Date: Thu, 25 Jan 2024 10:55:28 +0800
Message-ID: <20240125025533.10315-2-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40P38baV061394

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


