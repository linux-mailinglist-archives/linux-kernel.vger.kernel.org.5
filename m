Return-Path: <linux-kernel+bounces-80113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76678862AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EDC1C203E4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8AE17591;
	Sun, 25 Feb 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A11XjbBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0717551
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873210; cv=none; b=RiHSSKwZQzVjX07WEnNcGuiC4eBltDdMyLsUdhYCd7mInON0i6Cd00vY0rfedX1kN3Bygp7O03/KPmIC6OokF+B0hkGbAHW7jYgbbTnr09KA78LZZ0/c5wVMr2w8Mgf5isqppiVQdhzabCPqg5KGma2ga9EIUSpb82PZJlEbtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873210; c=relaxed/simple;
	bh=nIY3jsVvUGsi7oIbCNHSZsH+xPsRMAgDN59hh2ZbHE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZ4dZuL63n4/3u7cRbier89p15Jvk6ltj/Rtzkiq9j0WNVPgpcSWMO/XXz6vpVmKF4RBcrz0i1+c5WGgMTkRRCXnsrbGjvTqU3pGFNZKrlZ9mIOvSJ6/dj5jQ/8sGll3kuWUXYadwNsNByH0Znn7zbk3im5tFHrTRFAOsLgkHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A11XjbBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CCBC43399;
	Sun, 25 Feb 2024 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873209;
	bh=nIY3jsVvUGsi7oIbCNHSZsH+xPsRMAgDN59hh2ZbHE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A11XjbBTHdWE/A+lOssOXEVwBeUX5K5z6tTQgnPwCU8cun14IkwfBcBfgf7bVTxPh
	 swEPLL+zh+tNSt93/8MINSA8bSdjjkBABctQ90r9zImnJj2c21ortddKG/6NxBijDj
	 /F95/WnQOeJMQZiBDugoIbKr3v42qi3OtjKhAWITd2nbDJHljJwQr+l37pLONXNTgw
	 i++XU0MXINEoK/lPAjEit5MEqO8dnoBq6q4BR+BkPV325nNOo/mPpbpozYb4lzj3kb
	 en2sSr2QcJNtwY274uu/3dQBWYrnH/YIc6J1DT3Y0e981cgd5FT93eY+QwROmhwxq1
	 8nMze8oSkZa+g==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:29 +0000
Subject: [PATCH 3/8] regulator: mp8859: Support enable control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-3-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nIY3jsVvUGsi7oIbCNHSZsH+xPsRMAgDN59hh2ZbHE8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21XsUfGsQV9TSfIj/NHZzgGvZfd2Cz/Q9Hqkk
 GV4vIwR7PWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV7AAKCRAk1otyXVSH
 0JXyB/wNxcohOjIM7Go3L7hry02cxHPCEeY/ZPx7hw2n2xsBfSv5VCciD/zhEGafn/1Bdyz+4E9
 CfvmYGel4C663PHdNh9OvLUKbX4t0OtRKxnEgcKnoSofa2dRr0ph8YHKqnR8F5Jfrak4bHkKHcz
 oG/rtlmvCWYaB8WiOnJv4QN3DJwCencih4hLWm2VH4QdML5AIhX9N+LIHSbrEiGcbskYLgdDq9U
 EaXNN2nwgbA3AFmxr7dtpQOC5jOJd7WiY2gJo4s1Lkcd81H/g2KBDRmZhTiiSBcsBQHlLEsBfkk
 8DGZvrcIUBrvYO+j+QxbROXA8VDYtIFL8IJCHpGJxKDVRbrW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The MP8859 provides a software enable control, support it in the
regulator driver.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index b07bc63a25cb..a443ebe927c5 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -35,6 +35,7 @@
 
 #define MP8859_GO_BIT			0x01
 
+#define MP8859_ENABLE_MASK		0x80
 
 static int mp8859_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
 {
@@ -124,6 +125,9 @@ static const struct regulator_ops mp8859_ops = {
 	.set_voltage_sel = mp8859_set_voltage_sel,
 	.get_voltage_sel = mp8859_get_voltage_sel,
 	.list_voltage = regulator_list_voltage_linear_range,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
 };
 
 static const struct regulator_desc mp8859_regulators[] = {
@@ -136,6 +140,9 @@ static const struct regulator_desc mp8859_regulators[] = {
 		.n_voltages = VOL_MAX_IDX + 1,
 		.linear_ranges = mp8859_dcdc_ranges,
 		.n_linear_ranges = 1,
+		.enable_reg = MP8859_CTL1_REG,
+		.enable_mask = MP8859_ENABLE_MASK,
+		.enable_val = MP8859_ENABLE_MASK,
 		.ops = &mp8859_ops,
 		.owner = THIS_MODULE,
 	},

-- 
2.39.2


