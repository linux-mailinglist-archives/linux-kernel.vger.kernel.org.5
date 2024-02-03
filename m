Return-Path: <linux-kernel+bounces-51287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3B8488BE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4141C227D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ABC10A12;
	Sat,  3 Feb 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3KcuJfs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2810A1B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706992994; cv=none; b=O7x2WYcRydJnA5YBhpexl2f6nOuNQopG7QRMuLQuqhLmq+5yXoaIfpa+AIuEoGGJRpYHDdT6McxXDEcI4eDkHJE99VMlYUA2KnZR4TUCoWf+U04H2d5aQCPzbv0Iay7zTjbtZpIGqRVHsEvjBjRPDFE7tN/N+7TMacY5YRrd+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706992994; c=relaxed/simple;
	bh=2lrfPDCqSS7NAJwXBEvAR94g/4G427g05mpape2ibPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K/l/4vM1Qsi0pDGRTGt8x6J5E4U6A2z/VFiP9S2GXwnE4CTaFxDOfCDkNluIKyhpNn7tL+L3/yGGjy/G3quXJaH3IphCbXwGPfluQqIgHcVsE+mYMeyY/7p8hshu7uTgr8uVyx1KKoOG7vJ+qsCVZ1XibchGu8pcOXVdhvrjo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3KcuJfs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fb63c40c0so28186415e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 12:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706992990; x=1707597790; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bMNDt0VF60A4vY0AmfUHHO2VBEaxyGHYhnhM3g2+/gw=;
        b=c3KcuJfsCIstl0YrJjcnud4vZKlnXg7ALWix3oISvGcNvYTSeUVHqPVzkw4KlX7ci/
         M2oUcc2ruqI1u9jMhA4OHY6T2YP7N/f3pU8axJWPSl7/Qn1EP+abV7vY1S/9oOW4g0Ud
         ImipJRYhFpf1VadIL8k1keqDcgW0wRHNqQne4nyHIGcv7ZYvGZ0DAY0pcyihd4d4tWVd
         GSfWsKfhhei5ROULHtTfceWOmU6S2xxOKNzpTMyEm+1jN//3Jvc/5Sxv2M20D5UKK2Ql
         tk5iXoXnY2CnX9LYIUu9jCrOm60VwEfqTtbsPUhritW+ue99LoH9B1FqfyPw9c7dnIn3
         VO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706992990; x=1707597790;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMNDt0VF60A4vY0AmfUHHO2VBEaxyGHYhnhM3g2+/gw=;
        b=snQMJ0tzmTSOBaNX8c+An+iqvuxhN0oJmhZJNB0zrNIwbO70QBRrQ94unvAjkyJ7tc
         lV1Nsi9mFpqJhh8gnpqDOjamFz2a7ToXd0etX8uXn2OUOKdP25F3rq4NoHrxqHXJWTAZ
         E6DAjHQZwZYlJTVrnsLDwCTJaRUWQDUkdW9Q5dOfGMqtVeK8T6L0otOmy7f9r2PnKrIO
         LskzIivb+sCFJxeQO6uG90RIksENQJnUS38NXmLw7+HuDTHpH5W+xtfsYFbmXEg/ua0f
         5O4i8+q+KO3Rtaz4H09UzFNLKsr4xwCOgIiKs2gAlhLOKITcPfLrQWaqLvnHT81ctvwh
         ZzjQ==
X-Gm-Message-State: AOJu0Yw5ZNIrKg24BD7IXNgw2sxwCsCXdhq6eCC2oP5v/RCCMlBUw9sQ
	SgbN0YmMh1BtmfqtvvtW/hohANWdv1avKHQWeqsZePPSycGQfZcUSL27N0K+Ros=
X-Google-Smtp-Source: AGHT+IFapDA83nP1CnYzAQCvfdU/0u/tlk1UCzimQhH/gsO2nslbT9UXBPTsz30etucR0eFEczyBFg==
X-Received: by 2002:a05:600c:2111:b0:40f:b33a:a6f8 with SMTP id u17-20020a05600c211100b0040fb33aa6f8mr1557375wml.18.1706992990460;
        Sat, 03 Feb 2024 12:43:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUWBOkiMTlKguz+uLn2QF3XaTQIw7z04b4wq0WCm+0hR6QiXj4UUHx779X5BlPGKkESrd69az9Njj82vZLunzdnQ9UdSSc/4owP1owkqTbeEKAINGAxsZpcq8DEPFspod1276I6l/Nueg2TgEBJiG+ODRqMEIZ5yGd7DDVtHP58jxg7dcqFT+oCQSM1yqd/x+Wp/PSIYO83gcMW1c486bO4oVIBld0n2T8QUKSCxs5WXBqVH54Cg5RNIXv01eryeEb4OrBcUYfTuDgJ2wv1wP3CfgkTo/O9xRY/J7S0ipSVcDJLMvDp8VuV5JoKCDVvlmSPZHFMFx+3TEaHMa1NcimVMtQ/
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b0040fd0c11bb0sm2565613wmo.40.2024.02.03.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 12:43:09 -0800 (PST)
From: neil.armstrong@linaro.org
Date: Sat, 03 Feb 2024 21:43:05 +0100
Subject: [PATCH v2] ASoC: codecs: va-macro: add npl clk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-topic-sm8x50-upstream-va-macro-npl-v2-1-f2db82ae3359@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFilvmUC/x3NywqDQAxA0V+RrBuYRmsfv1K6mI6xDXQeJFYE8
 d8dXJ7NvSsYq7DBo1lBeRaTnCro1ED4+vRhlKEayFHnyLU45SIBLd6Wi8N/sUnZR5w9Rh80Yyo
 /7M7ju+/vV2ppgBoqyqMsx+T52rYddkTxLHQAAAA=
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5914;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pbI+ApNRMSqb3DUJLNH/cJKajCRO5lHynlEoSBOrCw4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlvqVcXyhND2mBzamIR1UQn3/Q6t1l36JYyoWZ8dx9
 MHmbCfyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZb6lXAAKCRB33NvayMhJ0f7bEA
 Cf2yrIiOlGYBc7pBdBAKkhwSk414qGbUOa2PXJ002qvh1p6HWqVo5XStbS/AxEVk1x4YQ6ENCBaw8b
 le0N7bcVP5tXyq+X3Igdops7ylTviILWF9+6E1OerL8yAzO0IbMBO2lPWT7BfSnoBvE4IdnJ7jF+I0
 yYZxUE7Iy3mJ6JqaDAQTNimpu1XPTI2+soKCv9gMshiB/pLGfEWFTeclrC7mZRqRpYXHU+U+4SvEGd
 pV2lZEi7tbmf4iBdAL6pqgJ31y6WyT4CggJW3hDzKUJpSekpWmmv6D+MLSitKkay/BFr7RZG85Eq7D
 GK+cvmvaSpJ/4LVSa5f0RMy5c8IAjPmrnUfJj5b9NjV40AfgeJQ8SZlD2/oYwNzfIJ9BS5ON8c7Jto
 nhUz2UZe5l4EUQ6FpVBKTEtroEZ1dKuY09OxkRC636DGbdT8LmVyX/5zcDdW02wD0Px3QLd+pK/j1R
 roXGK2DlgJoDbllTBZ4TwoSb9nrpVSct+i5cqzkMq/W/qU/Kqnosvq8M4rqmrV32qWpU329OnCEYUf
 N7CL9ids5j1O7beQo4KLldMAfqV0KaNWnJ/9UwMpVvXw+vE4gwU0Qo/bqbk9BEeMT5Qrf4ImVrRWod
 zZucAbtjN4GhblpvINwitgv+jhKp2P44yBpU73i5xEpqvi8GgCD5cpK3GVOg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

New versions of VA Macro has soundwire integrated, so handle the soundwire npl
clock correctly in the codec driver.

Introduce has_npl_clk and handle the sm8550 case separately because
it has soundwire integrated but doesn't have an npl clock.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes since v2: 
- Dropped already applied/upstreamed patch 1
- Rebased on next-20240202
- Switch to has_npl_clk and add sm8550 compat using Krzysztof's changes
- Link to v2: https://lore.kernel.org/all/20221118071849.25506-1-srinivas.kandagatla@linaro.org/

Changes since v1:
- updated bindings as per Kryz comments.
- added error handling during npl and mclk enable.
- Link to v1: https://lore.kernel.org/all/20221115105541.16322-1-srinivas.kandagatla@linaro.org/
---
 sound/soc/codecs/lpass-va-macro.c | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b71ef03c4aef..6eceeff10bf6 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -201,10 +201,12 @@ struct va_macro {
 	unsigned long active_ch_cnt[VA_MACRO_MAX_DAIS];
 	u16 dmic_clk_div;
 	bool has_swr_master;
+	bool has_npl_clk;
 
 	int dec_mode[VA_MACRO_NUM_DECIMATORS];
 	struct regmap *regmap;
 	struct clk *mclk;
+	struct clk *npl;
 	struct clk *macro;
 	struct clk *dcodec;
 	struct clk *fsgen;
@@ -225,14 +227,22 @@ struct va_macro {
 
 struct va_macro_data {
 	bool has_swr_master;
+	bool has_npl_clk;
 };
 
 static const struct va_macro_data sm8250_va_data = {
 	.has_swr_master = false,
+	.has_npl_clk = false,
 };
 
 static const struct va_macro_data sm8450_va_data = {
 	.has_swr_master = true,
+	.has_npl_clk = true,
+};
+
+static const struct va_macro_data sm8550_va_data = {
+	.has_swr_master = true,
+	.has_npl_clk = false,
 };
 
 static bool va_is_volatile_register(struct device *dev, unsigned int reg)
@@ -1332,6 +1342,12 @@ static int fsgen_gate_enable(struct clk_hw *hw)
 	struct regmap *regmap = va->regmap;
 	int ret;
 
+	if (va->has_swr_master) {
+		ret = clk_prepare_enable(va->mclk);
+		if (ret)
+			return ret;
+	}
+
 	ret = va_macro_mclk_enable(va, true);
 	if (va->has_swr_master)
 		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
@@ -1350,6 +1366,8 @@ static void fsgen_gate_disable(struct clk_hw *hw)
 			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
 
 	va_macro_mclk_enable(va, false);
+	if (va->has_swr_master)
+		clk_disable_unprepare(va->mclk);
 }
 
 static int fsgen_gate_is_enabled(struct clk_hw *hw)
@@ -1378,6 +1396,9 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
 	struct clk_init_data init;
 	int ret;
 
+	if (va->has_npl_clk)
+		parent = va->npl;
+
 	parent_clk_name = __clk_get_name(parent);
 
 	of_property_read_string(np, "clock-output-names", &clk_name);
@@ -1500,10 +1521,21 @@ static int va_macro_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	va->has_swr_master = data->has_swr_master;
+	va->has_npl_clk = data->has_npl_clk;
 
 	/* mclk rate */
 	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
 
+	if (va->has_npl_clk) {
+		va->npl = devm_clk_get(dev, "npl");
+		if (IS_ERR(va->npl)) {
+			ret = PTR_ERR(va->npl);
+			goto err;
+		}
+
+		clk_set_rate(va->npl, 2 * VA_MACRO_MCLK_FREQ);
+	}
+
 	ret = clk_prepare_enable(va->macro);
 	if (ret)
 		goto err;
@@ -1516,6 +1548,12 @@ static int va_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_mclk;
 
+	if (va->has_npl_clk) {
+		ret = clk_prepare_enable(va->npl);
+		if (ret)
+			goto err_npl;
+	}
+
 	if (va->has_swr_master) {
 		/* Set default CLK div to 1 */
 		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
@@ -1564,6 +1602,9 @@ static int va_macro_probe(struct platform_device *pdev)
 	return 0;
 
 err_clkout:
+	if (va->has_npl_clk)
+		clk_disable_unprepare(va->npl);
+err_npl:
 	clk_disable_unprepare(va->mclk);
 err_mclk:
 	clk_disable_unprepare(va->dcodec);
@@ -1579,6 +1620,9 @@ static void va_macro_remove(struct platform_device *pdev)
 {
 	struct va_macro *va = dev_get_drvdata(&pdev->dev);
 
+	if (va->has_npl_clk)
+		clk_disable_unprepare(va->npl);
+
 	clk_disable_unprepare(va->mclk);
 	clk_disable_unprepare(va->dcodec);
 	clk_disable_unprepare(va->macro);
@@ -1593,6 +1637,9 @@ static int __maybe_unused va_macro_runtime_suspend(struct device *dev)
 	regcache_cache_only(va->regmap, true);
 	regcache_mark_dirty(va->regmap);
 
+	if (va->has_npl_clk)
+		clk_disable_unprepare(va->npl);
+
 	clk_disable_unprepare(va->mclk);
 
 	return 0;
@@ -1609,6 +1656,15 @@ static int __maybe_unused va_macro_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	if (va->has_npl_clk) {
+		ret = clk_prepare_enable(va->npl);
+		if (ret) {
+			clk_disable_unprepare(va->mclk);
+			dev_err(va->dev, "unable to prepare npl\n");
+			return ret;
+		}
+	}
+
 	regcache_cache_only(va->regmap, false);
 	regcache_sync(va->regmap);
 
@@ -1624,6 +1680,7 @@ static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-va-macro", .data = &sm8250_va_data },
 	{ .compatible = "qcom,sm8250-lpass-va-macro", .data = &sm8250_va_data },
 	{ .compatible = "qcom,sm8450-lpass-va-macro", .data = &sm8450_va_data },
+	{ .compatible = "qcom,sm8550-lpass-va-macro", .data = &sm8550_va_data },
 	{ .compatible = "qcom,sc8280xp-lpass-va-macro", .data = &sm8450_va_data },
 	{}
 };

---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20240203-topic-sm8x50-upstream-va-macro-npl-41fb6697232d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


