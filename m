Return-Path: <linux-kernel+bounces-39322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC41E83CEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE4B23C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEFD13B791;
	Thu, 25 Jan 2024 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="QtWY3TlF"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BE1386DA;
	Thu, 25 Jan 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218542; cv=none; b=cIv56lE3jjK/OfkcKnBOvuwfa5KiQ/L1jUx+5D5/7o1sV3aCC9b3adxu5p182gFvYytYylsNkaf94qD2KtDCKX1Uc0O9i2/RcCRq+VRnC31fUQ7gODwtzZqLC1bexeSot/x8P2FEHvrdDHGio+rDC5p3XtH3UgPioPDKFRVrEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218542; c=relaxed/simple;
	bh=FK+L8LgnkcrpzitQ1T/eo/BRxUMyYXtYZKulFp8jUQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lj5TdPzwD6b2ntjtLpLiTYExHyKspJCfPJqo0enbP+cwygHlCHP43AaFCo/RmuJnbuJRiZhfvlcmlP49yj6tZJa23IGngn9cDHiAU72kw17PAeOYr9qy77c9qThrmNAZv8Thx9iJEm9D0Pe5KQ9clZPs9OwoD5wP2njqmkq8xSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=QtWY3TlF; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706218538; bh=FK+L8LgnkcrpzitQ1T/eo/BRxUMyYXtYZKulFp8jUQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QtWY3TlFVMGLuC2uIA8n8bKW1pBNOI7wltw9gRQOZ+34cTk07B9xIss6qog2hibcA
	 Nq/j8U+mr3NPemDrMBOrlHYwGWof3Z6ieqW9GGPZh1BkFZmnQwehMd0Un5Atd+daea
	 XPMFrmDpU03YnjMPF8MlDTuzAf33FoRLAc6Nweac=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Jan 2024 22:35:13 +0100
Subject: [PATCH v2 2/3] clk: qcom: gcc-msm8953: add more resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-msm8953-mdss-reset-v2-2-fd7824559426@z3ntu.xyz>
References: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
In-Reply-To: <20240125-msm8953-mdss-reset-v2-0-fd7824559426@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=r1BPJQPZkawQ6cFOzFDI5AEkOrpUf7EO3bhDtyAamxM=;
 b=kA0DAAgBcthDuJ1N11YByyZiAGWy1CeiLyJaLPECWcMyp3ramZhs2rrDRfuQpXiZgOg5fmb+g
 YkCMwQAAQgAHRYhBDm60i8ILNqRuhWP+nLYQ7idTddWBQJlstQnAAoJEHLYQ7idTddWvxMP/1wV
 ZXykMiFTPRh22kggE/SmsO/EoTVupX3OTnw7ag7Xyqh2FVJ1QboXJqEc3vzpnO8pPh9BP0P9ZjN
 dk7CKQr5V1J0XQ4Bn6VcroyDBbJhaZsjt0PoXMRFS6M6utbX3zlNdKeG3aj5oeEhXneboFt57Xd
 qUQg7UdTbBX+TPtb5c+BKcVU1GXBoKnnCeK3CBcRvtrTuIZLHz+jdKVXmFvdI7v7rTb3Xp3WUyg
 pRsdRHLyTmHyq2iW/NWMV8GRr4g+LdKjG3LX5tPPRh+W4qC5wmqcqtfizuUP2icY/qQldidUcPG
 ZH05ebkv/Cv9sjH8eBOs276b+k6ZYC3G6S9txcrby87pWIlwFTq6a8N0ktpX5ge6S9qDXqiccNS
 Fx1G1EVe25c+UFtmYrDp/Mp/sxF10TsSbZLI6/zWvGMQWkFg2DussTxNXFxQMUrJaD+Ivc3vo2e
 pxq1NsyUS6SXnsp825rQipBGhQWI9Y67uQMa906hKcgfuJtjfJU+ABuZs8R4cFR8rIUQQtl31Qt
 MVQrkkg0eLSLLSDnSFC5A0019uNcJC2nrjtwQxT1TqfYGHHy1s4pohJQjoFwipybsHeJ4kD8YSB
 OKlWKeGrRTP3EP9+oWhXi91lLneIOdemj1nGSJvrcCoDyrUSr5QDYHmn3fAQBCfxl17lLUVhzyi
 dLCWh
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add new entries in the gcc driver for some more resets found on MSM8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
[luca: expand commit message, move entry, add more entries]
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/gcc-msm8953.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 3e5a8cb14d4d..68359534ff25 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -4171,6 +4171,10 @@ static const struct qcom_reset_map gcc_msm8953_resets[] = {
 	[GCC_USB3PHY_PHY_BCR]	= { 0x3f03c },
 	[GCC_USB3_PHY_BCR]	= { 0x3f034 },
 	[GCC_USB_30_BCR]	= { 0x3f070 },
+	[GCC_MDSS_BCR]		= { 0x4d074 },
+	[GCC_CRYPTO_BCR]	= { 0x16000 },
+	[GCC_SDCC1_BCR]		= { 0x42000 },
+	[GCC_SDCC2_BCR]		= { 0x43000 },
 };
 
 static const struct regmap_config gcc_msm8953_regmap_config = {

-- 
2.43.0


