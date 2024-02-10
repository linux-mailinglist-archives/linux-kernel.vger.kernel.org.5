Return-Path: <linux-kernel+bounces-60418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE468504A3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7207E1F22843
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602B54BC9;
	Sat, 10 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="VZeo3wao"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8D53E0E;
	Sat, 10 Feb 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574409; cv=none; b=tctnYE8pqNXgp+FQI1UYf+O8lt3gegkw3lNfIPea0VE8JhAsppFqSag1y/zfocABYf4oDwU8wiCD8y799huuZoqmx3BFrFh/hSs1MWyPNmnS+u5Wh3nr8cGyeJDX4z24UbLAhF++5bl3y4AdKvHa1j1Tdxj9WOx3y7GJJnHhvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574409; c=relaxed/simple;
	bh=wz9Hx+L8dYOlOuz76qShV9ngNnFo+4/s9GVAgaEKMWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7212qISVoDO/51vWRF6TGLg/5VhcS8+n5nWRs8awIuMN3aoUUV1f2eV7Mh1kAbygs9ys/yUqogMD/LXgajH7u3xmJuClHt1ALIse7GbBlBOtSOCDi3CEGEul9GQANQ/scA5QiQpRx2z5aBo3Awb37AJEbFbvdW9zlT9cImL9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=VZeo3wao; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707574399; bh=wz9Hx+L8dYOlOuz76qShV9ngNnFo+4/s9GVAgaEKMWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VZeo3waor+yHZ57u4x/f+55T44jKYLUEf6eQ5yli+6xgCfrqiKhzMTnFnJCJvOpO4
	 +kjREj1a+9YS6xdm7/eOyZNXFBAGx8wu52NC0QbL2ESs4DZtuum9La00cToYE4NIr4
	 NVaS5SrAi98PhFeGqPyCO9t/3+Xs7MBdftVpHMIM=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 15:12:56 +0100
Subject: [PATCH 2/3] pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power
 domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-rpmpd-v1-2-de9355e6842a@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wz9Hx+L8dYOlOuz76qShV9ngNnFo+4/s9GVAgaEKMWo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx4R8zEFH8BbXvaPGHckFlMfDx9LVuBztodvmO
 IUb8j50zHaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZceEfAAKCRBy2EO4nU3X
 VlS4D/wKkK5qZXJPqUaMGSU8qcdyFRX1oj9HhIIYHmGeuydJbIMB9dZgFqbTgIFW/sVxgpYUnSt
 Gx0srIl/H+zXy/A3FX7dCRLg5/tQO4tOa6aA3nUWBYTydGg0okQmxzhzJ0WzcwNiWM9RBvHue6j
 kH4mmny5mv9gChV7cERESZ4GtD3iEj/wtklHPVPB+BRVL3olmJLtTKD4DvJG6SBALa0pXBLHldq
 HrZpVFfazuidFnl6spvWijXA79KnNPIFyd8oCXIVDn00eodS6xBrPKHpQD5iw4hYE2nkAExBmjE
 uLy5Ex145ogO7Z96wAtac5H4C4GtivRg72gUKHqn86eMtn4RdlKjLd79pqylkrb576fz6jCCqUw
 rKPCLakNG/LveeBH17aoHICT9ts9uo0AUq8eTnoljCKBwWZ/OkfoDgUKpDP4V2913HzQ/1tHkdo
 QQcxSiO71fdxB/AqXwuKbN9sHI7mJt1sJ2432aWqvpwKJM8+zS9blNLTVxEAvgzQ7Pfmks26luQ
 ZI8fEFiCiD0V9/ucgkrrkrsYy3M+2KgLOieVOm0iyTZyDtOSOvl8OSIbAcU1TxHyLO7nKNFvs4i
 IJqBolyhBv2Rzu/K7LISsabYJ91AM8WX+RJBvdexAN40P0/kpmqsTJHkUWjQurGZ3HpkYo8VSPd
 dQ/xLJhJW108o7Q==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the power domains CX & GFX found on devices with MSM8974 and PM8841.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pmdomain/qcom/rpmpd.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 7796d65f96e8..bb28a7319bed 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -226,6 +226,31 @@ static struct rpmpd cx_s3a_vfl = {
 	.key = KEY_FLOOR_LEVEL,
 };
 
+static struct rpmpd cx_s2b_corner_ao;
+static struct rpmpd cx_s2b_corner = {
+	.pd = { .name = "cx", },
+	.peer = &cx_s2b_corner_ao,
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd cx_s2b_corner_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &cx_s2b_corner,
+	.active_only = true,
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd cx_s2b_vfc = {
+	.pd = { .name = "cx_vfc", },
+	.res_type = RPMPD_SMPB,
+	.res_id = 2,
+	.key = KEY_FLOOR_CORNER,
+};
+
 /* G(F)X */
 static struct rpmpd gfx_s2b_corner = {
 	.pd = { .name = "gfx", },
@@ -241,6 +266,31 @@ static struct rpmpd gfx_s2b_vfc = {
 	.key = KEY_FLOOR_CORNER,
 };
 
+static struct rpmpd gfx_s4b_corner_ao;
+static struct rpmpd gfx_s4b_corner = {
+	.pd = { .name = "gfx", },
+	.peer = &gfx_s4b_corner_ao,
+	.res_type = RPMPD_SMPB,
+	.res_id = 4,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd gfx_s4b_corner_ao = {
+	.pd = { .name = "gfx_ao", },
+	.peer = &gfx_s4b_corner,
+	.active_only = true,
+	.res_type = RPMPD_SMPB,
+	.res_id = 4,
+	.key = KEY_CORNER,
+};
+
+static struct rpmpd gfx_s4b_vfc = {
+	.pd = { .name = "gfx_vfc", },
+	.res_type = RPMPD_SMPB,
+	.res_id = 4,
+	.key = KEY_FLOOR_CORNER,
+};
+
 static struct rpmpd mx_rwmx0_lvl;
 static struct rpmpd gx_rwgx0_lvl_ao;
 static struct rpmpd gx_rwgx0_lvl = {
@@ -663,6 +713,21 @@ static const struct rpmpd_desc msm8953_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+static struct rpmpd *msm8974_rpmpds[] = {
+	[MSM8974_VDDCX] =	&cx_s2b_corner,
+	[MSM8974_VDDCX_AO] =	&cx_s2b_corner_ao,
+	[MSM8974_VDDCX_VFC] =	&cx_s2b_vfc,
+	[MSM8974_VDDGFX] =	&gfx_s4b_corner,
+	[MSM8974_VDDGFX_AO] =	&gfx_s4b_corner_ao,
+	[MSM8974_VDDGFX_VFC] =	&gfx_s4b_vfc,
+};
+
+static const struct rpmpd_desc msm8974_desc = {
+	.rpmpds = msm8974_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8974_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
 static struct rpmpd *msm8976_rpmpds[] = {
 	[MSM8976_VDDCX] =	&cx_s2a_lvl,
 	[MSM8976_VDDCX_AO] =	&cx_s2a_lvl_ao,
@@ -856,6 +921,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8917-rpmpd", .data = &msm8917_desc },
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
+	{ .compatible = "qcom,msm8974-rpmpd", .data = &msm8974_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
 	{ .compatible = "qcom,msm8994-rpmpd", .data = &msm8994_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },

-- 
2.43.0


