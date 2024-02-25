Return-Path: <linux-kernel+bounces-80114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2D862AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD8FB2153C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254017993;
	Sun, 25 Feb 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoNhRcXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC81175B1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873212; cv=none; b=fgrxBL1mkPVzwacWpQti5CZ1jUxkMwiSyEobuLVjo93JfAZNTx81A1BXAFUCBIQZxuTxSmSKrA3ORhtED2wCOG+6Qwya2JNlAgo3XPBT+IaXgeTzR+a4zauY7S0itKS6VmnEPVYOch5N8mHqax+UH7J8fz9GV6qKvOfU8Y6ZNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873212; c=relaxed/simple;
	bh=/9Qtfrp2wXu5HlNPGVpCrKTCsuKq/bIXhE9SvbtyD4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKUKpGwJhls8O58Koo5sMbYqfv06NDj01UHfo2kfbbW7fUyANGoXOk2mijMbXy4AX3u6aSVXR+SHk9g+QaRl1LTzayiFwIFwyFbDKuwzTqk4yE108N2hc64sH1P22blp/RQ2JFwm5n+snRUXmBdOo1E6NDpl6IEP4Kv4OMXIweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoNhRcXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBFFC433C7;
	Sun, 25 Feb 2024 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873212;
	bh=/9Qtfrp2wXu5HlNPGVpCrKTCsuKq/bIXhE9SvbtyD4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DoNhRcXtsN75f2or3TYH3BLjp5iF/tLu7GknJSEa4wMqdgD0GHH58sOd5ZWgPCY/z
	 PXzOiMy6tkZZMay0W5OO2xTanT91YKUwrO7fQjQ0ertwh/ybEj+ZJ1RhuHtjMDX72l
	 Eiv2XMeMZCZHzVtSuZELPPpWfZYP/zVEAj2qGDFvAGGDpSycMIOs1YvEsArCy6hS52
	 glfnwpH9ocsy03eoNucdcs00SrSQqPhollPXuAtwLIPtZdV9Gh2yZ/KtYu48vNqklk
	 ydbUKCeWIZaERhwlLSCyYZa5Q35JQV/5H6thmMkfel8l3rBq70gWea06++dE0kfnNT
	 fmc0oR/YS+ilw==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:30 +0000
Subject: [PATCH 4/8] regulator: mp8859: Support mode operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-4-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/9Qtfrp2wXu5HlNPGVpCrKTCsuKq/bIXhE9SvbtyD4A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21XsfERsrSmC8mxkIIHybPnRxcTEutHbE1mEX
 YuwHuy1r8eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV7AAKCRAk1otyXVSH
 0IDXB/91va2SMLdhVzW2gjt5wz+97EDSXgKd6rSNHk+fKOyrJZiijRDqh+CjzGpZJJmafWRvC4b
 992Z6fH66uvv1tB0JdANlmqXKy5A5o7IVBBrA5HZHb8bnZQPDgGTdGPqGxFnhl/Xik+QxJIgsaU
 qxJ6JKPHlj8NVSCHqXNHHAzsnycLr9K88Z60igzE3qy4qsZi5S1GKhuUAxjLe+3JWmU2RXE3RxO
 x5gMpdoOPjxRGqHDv/tLsmBSxKWop8HH3JYMw2FhzrLL/uuo7dKw0W0b5AxqBCOOJpySgsdxd6s
 DyHG5XJpGbuyUVNnkPHBuMudFLcXmRrGy9Es4B4lAlMmgpzW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The MP8859 provides mode control, implement the relevant regulator API
operations.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index a443ebe927c5..b97c00097148 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -36,6 +36,7 @@
 #define MP8859_GO_BIT			0x01
 
 #define MP8859_ENABLE_MASK		0x80
+#define MP8859_MODE_MASK		0x08
 
 static int mp8859_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
 {
@@ -74,6 +75,42 @@ static int mp8859_get_voltage_sel(struct regulator_dev *rdev)
 	return val;
 }
 
+static unsigned int mp8859_get_mode(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MP8859_CTL1_REG, &val);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to read mode: %d\n", ret);
+		return 0;
+	}
+
+	if (val & MP8859_MODE_MASK)
+		return REGULATOR_MODE_FAST;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mp8859_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	unsigned int val;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = MP8859_MODE_MASK;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(rdev->regmap, MP8859_CTL1_REG,
+				  MP8859_MODE_MASK, val);
+}
+
 static const struct linear_range mp8859_dcdc_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, VOL_MIN_IDX, VOL_MAX_IDX, 10000),
 };
@@ -128,6 +165,8 @@ static const struct regulator_ops mp8859_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mp8859_set_mode,
+	.get_mode = mp8859_get_mode,
 };
 
 static const struct regulator_desc mp8859_regulators[] = {

-- 
2.39.2


