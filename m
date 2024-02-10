Return-Path: <linux-kernel+bounces-60465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4D085054F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F931C236DA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78F5D46B;
	Sat, 10 Feb 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="UG9Ug/JA"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97C53815;
	Sat, 10 Feb 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583152; cv=none; b=aSqMAflbNExa7MB9Z8muCTPaXKjUausSUeNiVsEJwzTgxbdIcAXMViMHGINdVQYDfg8RoTLr0aNSGDR3kPPfC+CH/ixNyWQ4d5IbolPFBpIPxyAFlTJ8AwvaaO4m8beBwIkahWoyGGsJYqF7OOILb89Z3R14pMTWbDLYR+WVeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583152; c=relaxed/simple;
	bh=Bqe9nG5QIKCNWmQCfAYO31zIO0yKG5ihxkdZCTLqWYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdC4866uSZFCQarRpBhdGiOR9yy2rFm8bwHh1YoasKNwPECeQPhsaDfI5CXudOBgZ4SX8j5q/DVwXW1z8QeJBa1jMULbuOxXRV/DWsjMHZakLUF15feOabGdUcIhBGdVrvzZfVbo0UvWGRX3T9IwFBKBKqVU9u49+L2QG8cjW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=UG9Ug/JA; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707583148; bh=Bqe9nG5QIKCNWmQCfAYO31zIO0yKG5ihxkdZCTLqWYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UG9Ug/JAnOhN5Ov4y323kq3XqF/g58hbJLSRxos6ZDplGYRlA2WDxtCT5M/APBPdF
	 WM8LVQG4jiZS5xN3F75oaPn4G1AzZQQUmJaf7UjmLDJzmJavR2aN2R96rbVGn3S8gP
	 8wwvJVo9vPDuqXuG4PBrv3kAf/pQ1/GybOQVc/Ok=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:38:57 +0100
Subject: [PATCH v2 2/3] pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power
 domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-rpmpd-v2-2-595e2ff80ea1@z3ntu.xyz>
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
In-Reply-To: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Bqe9nG5QIKCNWmQCfAYO31zIO0yKG5ihxkdZCTLqWYs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6apKNOxSZtGrGubtN7TRkNBkuCcJ0dkuvwbF
 sw9uXC91aKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZcemqQAKCRBy2EO4nU3X
 VlKPD/wP7/T6WcgMkLn0WtjB6eKyxmg7YHynQTAIEvChvqmTX3W5e8WQlZC3s8OBtOM/kXwkcJx
 NoV2gMltS/xBlW+dGknr4W8rGby86u1yR+xOZtYCP0nSNR+efA6A2gvcniAko9RehADl14FSpSK
 7rrkpNlmpbXua1t9fbK70XnZjVNXNGzayYxNE1X4aVQz+MnT8WaG9RkhP3/KWV1aRGOsFEAmRsP
 I7b11vmdS/GR7kpBp6T1BnYp6NtGvHkwPUauHdSCrQZNaAq9WAIrhsgHrHJLUKJqnnI2zhfflA/
 JTWtZhxIlERjhLjUfZInQUHNzVrC7AvY0GHHI9BHTM29JnZU2EED1ZI4O8VJPsBoop7flAkFqXm
 tsPWVkZfmk8uhj1dD5idBYCcyGDGhRL8maPuHGnUgpi48QeQ4xyFrPlSBaQlokKtxL/4XGJH+4x
 gob5vasz/6yL22Sb7lWBL0qEDulhZ27wD2UiN5ehX2yEHXIfF9FIxSdv+Xc5xtDmRNdgwqoss6N
 yiHtAwiGVZQc/jLgHW6/nMOuYkDnZdcx8kMxWcZdc2U+3Y7pJl6Nw9fDUd/aHxORDRrLjj173YP
 nL4iCwwvagJqtDmqW2tJKNrH2oHa7m55ATU8iQjNaUTw4ViM1/18n3D2UTK2H+K96Wz+blqhVnw
 b4FYXMVtsA2ptpQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the power domains CX & GFX found on devices with MSM8974 and PM8841.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pmdomain/qcom/rpmpd.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 7796d65f96e8..3fa6a0325fc0 100644
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
@@ -241,6 +266,20 @@ static struct rpmpd gfx_s2b_vfc = {
 	.key = KEY_FLOOR_CORNER,
 };
 
+static struct rpmpd gfx_s4b_corner = {
+	.pd = { .name = "gfx", },
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
@@ -663,6 +702,20 @@ static const struct rpmpd_desc msm8953_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+static struct rpmpd *msm8974_rpmpds[] = {
+	[MSM8974_VDDCX] =	&cx_s2b_corner,
+	[MSM8974_VDDCX_AO] =	&cx_s2b_corner_ao,
+	[MSM8974_VDDCX_VFC] =	&cx_s2b_vfc,
+	[MSM8974_VDDGFX] =	&gfx_s4b_corner,
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
@@ -856,6 +909,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8917-rpmpd", .data = &msm8917_desc },
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
+	{ .compatible = "qcom,msm8974-rpmpd", .data = &msm8974_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
 	{ .compatible = "qcom,msm8994-rpmpd", .data = &msm8994_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },

-- 
2.43.0


