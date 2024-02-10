Return-Path: <linux-kernel+bounces-60419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C328504A2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED61283A05
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CAB54BCA;
	Sat, 10 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="7eEW7knG"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4B53E0D;
	Sat, 10 Feb 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574409; cv=none; b=l8VjquMWK98bGnX6ek7SdO2Qy043aAkU9PVCtOdiZm7f2ggLeALqNImNhqwBFo6VKTZd6XUNFSTj1/HcDPbRhOUyR5d3LNCrfJ9zM6lFhQNBeV0+GHvbu/+nsNWouiH0FHozJieavq3SvjrBJ5N/ClGG6BxQtcme6zJG+77iF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574409; c=relaxed/simple;
	bh=pEbjMkaG6aytDHCPfPUMYKbhop5aoAakU84obp67bv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pcgr3T0O9nAjCE7IA45cCvO96W1T+EkQF+I4CpbDRCQw/xCdxqEgSAkqQqHTmCgpnju+6g5qlZxDWz51VYoxR8V9bzUrG+nwdD/MeOVgpgDvQOO+w2YKrAOM/FGnbD0ZdpEwhRKkNlUa6/3Hro3ZLUKqak1sa7uJzDfQ9RyNHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=7eEW7knG; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707574399; bh=pEbjMkaG6aytDHCPfPUMYKbhop5aoAakU84obp67bv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=7eEW7knG3Kt1XQZsTi0b2jkYMBHrEzKaJa5SRfZoehy1mNBUxZPOXS2y+ARlkUB50
	 zxa56jZICMKwcoO4qms09bGrpCwezCoEXgMXvZIiCsiup3xnhgDtFnu4M4+S9mfFDa
	 X81E0fyxtYOa+8w8XTyfeerK9utVDGoMjfAXOHDA=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 15:12:57 +0100
Subject: [PATCH 3/3] pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084 power
 domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-rpmpd-v1-3-de9355e6842a@z3ntu.xyz>
References: <20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz>
In-Reply-To: <20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=pEbjMkaG6aytDHCPfPUMYKbhop5aoAakU84obp67bv8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx4R9DAmzORdeYJsmHQwKQRAjHJYEVq2+bwQ/T
 nGIpX0bUZeJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZceEfQAKCRBy2EO4nU3X
 Voi6D/95TvGZpv+6L56HIuBJv4E50X1zBarD4qhAMgxdQdh/qkeBRwI68dhKWRIa7IK4CS4Vmi/
 QZXdFFxCIb6vtX4pWAceyaTVarcPpLW69+PUAws93WTtyeVTvNbs+ujsTZdslfVcjE+7uJPQZah
 gzSMg2QGBG2AmvgScPsyNCaP4hIFWrnfUf7KMKS5hRJx71YMLO+9L7rMUO8/yfgFnI722wJMf2r
 yoT4OE0KpdyfIFVOP7e5maYVEAUFYmm+oo0ZFKPBlPlIadOjhCbVtk2JHz30Jb1j9WbOrSh76Jr
 iegovPxfvv6tbZpOZFNCcNxXcblzFbLdULy5FACgUdoYbu/sZrjwMEBq+U2ogQSrfZFgGCfFVbl
 3Ah4sYELgzB/OKtTmNvdP8aH/8swUJ84AQfWPeMzt2mdOzex7n+I6NTg9Q+zYRxfzi5EbK7uU0H
 1Ndy0iw0Alhyrnw43/BzDRD+14PuRZ4nM4sYUZHcyH5kHbfAyULikJCTySkJoFkAwrmwA3T9RPf
 cXmHKTbR90Z5AFuvNxV2fF8fddYR6ywpnQrnBB5XPQGLthJqrqjGq/PPRAv9TxK8AZENJarDYT7
 VWtRFF6OHV0K+LWpvdr0FyHU4ejz41NyPMvEnp28UKLqg08CZNv6AO9sIcD2V0hssYGbHRw+FI7
 o7hvExQLT0/jX3g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the power domains CX & GFX found on MSM8974 devices that use PMA8084
instead of the standard PM8841+PM8941 combo.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pmdomain/qcom/rpmpd.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index bb28a7319bed..3cd0d1ad6188 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -252,6 +252,31 @@ static struct rpmpd cx_s2b_vfc = {
 };
 
 /* G(F)X */
+static struct rpmpd gfx_s7a_corner_ao;
+static struct rpmpd gfx_s7a_corner = {
+	.pd = { .name = "gfx", },
+	.peer = &gfx_s7a_corner_ao,
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd gfx_s7a_corner_ao = {
+	.pd = { .name = "gfx_ao", },
+	.peer = &gfx_s7a_corner,
+	.active_only = true,
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd gfx_s7a_vfc = {
+	.pd = { .name = "gfx_vfc", },
+	.res_type = RPMPD_SMPA,
+	.res_id = 7,
+	.key = KEY_FLOOR_CORNER,
+};
+
 static struct rpmpd gfx_s2b_corner = {
 	.pd = { .name = "gfx", },
 	.res_type = RPMPD_SMPB,
@@ -728,6 +753,21 @@ static const struct rpmpd_desc msm8974_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
+static struct rpmpd *msm8974pro_pma8084_rpmpds[] = {
+	[MSM8974_VDDCX] =	&cx_s2a_corner,
+	[MSM8974_VDDCX_AO] =	&cx_s2a_corner_ao,
+	[MSM8974_VDDCX_VFC] =	&cx_s2a_vfc,
+	[MSM8974_VDDGFX] =	&gfx_s7a_corner,
+	[MSM8974_VDDGFX_AO] =	&gfx_s7a_corner_ao,
+	[MSM8974_VDDGFX_VFC] =	&gfx_s7a_vfc,
+};
+
+static const struct rpmpd_desc msm8974pro_pma8084_desc = {
+	.rpmpds = msm8974pro_pma8084_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8974pro_pma8084_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&cx_s2a_lvl,
 	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
@@ -922,6 +962,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
 	{ .compatible = "qcom,msm8974-rpmpd", .data = &msm8974_desc },
+	{ .compatible = "qcom,msm8974pro-pma8084-rpmpd", .data = &msm8974pro_pma8084_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
 	{ .compatible = "qcom,msm8994-rpmpd", .data = &msm8994_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },

-- 
2.43.0


