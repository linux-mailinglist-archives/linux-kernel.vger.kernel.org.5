Return-Path: <linux-kernel+bounces-80118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA75862AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539D31F21883
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158D1B7F7;
	Sun, 25 Feb 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvcgrCxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600A1AACD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873220; cv=none; b=PNyaQAAicThiF2ML56Wjyt9rMJN80oHGPO4rLeUYm86CFiVA5vf/59sBbsSP0/ZwzwMQ2T5srPgDqnwL8GgDTeMQU6Wb04G8Kw5ps3EMt9FGOwJlkv97Ci6Gt4w66YDAvDAU01XhC2kzC03WGSxrQhw7WhYsSIq2xgjjaxKJK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873220; c=relaxed/simple;
	bh=RzDZHw2Jmq0oML0An+44XMs3/ybJDt8lUM/JUMitUeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFa/zKbN7T/w4QDfhc+QBq9FJPmgsPmxxEmQYei9/o1lcWIDPfTo2QKqxDdeLz8i+tGdt4qOFfuRTWO895Qiudg5HZtRXQgjyHfQDiN8nVj+9Wtm7F8j4lnkmqFHznjqWePACg0wOtlhlsMO+N9oA5yQRUtgSLBtlIjt2fnb2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvcgrCxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2828EC43390;
	Sun, 25 Feb 2024 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873220;
	bh=RzDZHw2Jmq0oML0An+44XMs3/ybJDt8lUM/JUMitUeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZvcgrCxCOKIOPTPjnW8rkIYP92XdjC+BAApOUz37Ri5jflvVlspD5E4woP/7FNK6T
	 cflfOPsMhOFIS3ypSa3rJVDilEHsx0zSyvk/RsodHUH9Ur0vOgQc8iVSdNt457pge/
	 eXp1HZbnrV4+dhwoevQ6wLID3VNROH84HTWHFEiJW9XJDZgSABxT720aO901xXWWy6
	 KVwbMDK0J7qU1z70vPlNOvL49zrgQ1DyIfeZlaz87rDx1Ku2pxcfVjJsm8tdK2vH1l
	 wOGH04n7dzA1Bmzjn0ngVHNF56P0A/Z4AIirOiO3Jpeh4Jv4H++TXh+6rQTTIZn5oM
	 ufN0Lyqrw4mzQ==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:34 +0000
Subject: [PATCH 8/8] regulator: mp8859: Implement set_current_limit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-8-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RzDZHw2Jmq0oML0An+44XMs3/ybJDt8lUM/JUMitUeI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21Xvkt3AbnJVC6B0dHO28eGIbra9Sc76Lh9gJ
 zR9FxqpNpSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV7wAKCRAk1otyXVSH
 0GoxB/98FJyvogRK3pcXMl2VX2fZJ8Ub/CWKFeTbfdGIfbEauyO98V8AnaBngAZcL5JvXrwv1dw
 fJeJ2Gmb4W42jCIa7Rl+Wi4vbQdQ1WB/ktTDCHq8QX+m9SID3TP5FuuNmTlEwKIFgX+r1aRSoXl
 jisVEb3MpARO1oEinEruiStMBr9N3Kxy2p5xL2jFJMxWIPmcnpDnSG8Gc8vQgiN/G/ztBW3t78V
 8ATSp0sk71pQdPihErxZnpkhc/dtRfpDK87MawPVov0GDvGo+KqJcZdKBNOcp7OElFGBbpn1OCP
 I1lfg5m1lAGOfHyAPDRTXRTddpkATtXvxFweD8/JkrBZ8yOo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The mp8859 implements support for current limiting, provide support for
configuring this via the driver. The datasheet recommends that if the
device has hit the current limit then any changes should be implemented
via a ramp so we do so in the driver.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index 3e849e1a172f..ab105ffd6a2e 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -35,6 +35,8 @@
 
 #define MP8859_GO_BIT			0x01
 
+#define MP8859_IOUT_LIM_MASK		0x7f
+
 #define MP8859_ENABLE_MASK		0x80
 #define MP8859_DISCHG_EN_MASK		0x10
 #define MP8859_MODE_MASK		0x08
@@ -131,6 +133,58 @@ static int mp8859_set_mode(struct regulator_dev *rdev, unsigned int mode)
 				  MP8859_MODE_MASK, val);
 }
 
+static int mp8859_set_current_limit(struct regulator_dev *rdev,
+				    int min_uA, int max_uA)
+{
+	unsigned int cur_val, new_val;
+	int ret, i;
+
+	/* Steps of 50mA */
+	new_val = max_uA / 50000;
+	if (new_val > MP8859_IOUT_LIM_MASK)
+		return -EINVAL;
+	if (new_val == 0)
+		return -EINVAL;
+
+	/*
+	 * If the regulator is limiting then ramp gradually as per
+	 * datasheet, otherwise just set the value directly.
+	 */
+	ret = regmap_read(rdev->regmap, MP8859_STATUS_REG, &cur_val);
+	if (ret != 0)
+		return ret;
+	if (!(cur_val & MP8859_CC_CV_MASK)) {
+		return regmap_update_bits(rdev->regmap, MP8859_IOUT_LIM_REG,
+					  MP8859_IOUT_LIM_MASK, new_val);
+	}
+
+	ret = regmap_read(rdev->regmap, MP8859_IOUT_LIM_REG, &cur_val);
+	if (ret != 0)
+		return ret;
+
+	if (cur_val >= new_val) {
+		for (i = cur_val; i >= new_val; i--) {
+			ret = regmap_update_bits(rdev->regmap,
+						 MP8859_IOUT_LIM_REG,
+						 MP8859_IOUT_LIM_MASK,
+						 cur_val - i);
+			if (ret != 0)
+				return ret;
+		}
+	} else {
+		for (i = cur_val; i <= new_val; i++) {
+			ret = regmap_update_bits(rdev->regmap,
+						 MP8859_IOUT_LIM_REG,
+						 MP8859_IOUT_LIM_MASK,
+						 cur_val + i);
+			if (ret != 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int mp8859_get_status(struct regulator_dev *rdev)
 {
 	unsigned int val;
@@ -241,6 +295,7 @@ static const struct regulator_ops mp8859_ops = {
 	.set_mode = mp8859_set_mode,
 	.get_mode = mp8859_get_mode,
 	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_current_limit = mp8859_set_current_limit,
 	.get_status = mp8859_get_status,
 	.get_error_flags = mp8859_get_error_flags,
 };

-- 
2.39.2


