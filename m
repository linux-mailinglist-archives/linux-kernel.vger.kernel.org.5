Return-Path: <linux-kernel+bounces-80116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B137862AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A151C20D20
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43724182DF;
	Sun, 25 Feb 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amKrzuOr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C31804F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873217; cv=none; b=Q5T+H9zZ4v0J+5jxFSdTKpT+FwuBY8u+0dS7LRwBctqDCWHxIF0ADeCej9O9N41CgEDOcGVeWaLx8XB1+smK2OUyaq1mPGiqBFxHwvKqsTMPXtQf2SLLo9pN+8xWP1BfavbcRMUJ2vRz6W5DWcPdgRNPbU4v8+8Gvyk4+ncSwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873217; c=relaxed/simple;
	bh=hQozOQk8vKGJhYP2wxfoB44e0P7uPH2YR9fKCY4VQYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiVEabEghTViR5hTFKfPvJggFnhyIaQLbI4kBhsJ3sAJUeOMeunoq4KNcS0HJaIdCf6VrLb8M5tyaiwxl4VG46152iU0crXUss4n8jdvgm5tmwJfaj0codlKIQVKuoIOFm4J6u5152WLGZrT3x7pXjwnhbb8Bxf124WE94/mVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amKrzuOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D740C43394;
	Sun, 25 Feb 2024 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873217;
	bh=hQozOQk8vKGJhYP2wxfoB44e0P7uPH2YR9fKCY4VQYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=amKrzuOrRLysty+N0ooO1Z6v8k8BG468ny/Pe7/1ktHSv6YE+XkOsSK27CKbdoPZy
	 IwQ7g9xhGqsYlo+Z7Bj231pT7zP1VeBLEVW1AUeGQaoOUMyMalg3FyZbJLF0GI9bBL
	 xltgsL9YX35Q9nGWl1AAYVUUVDAJw0VqB/KCBi75u0OaIUChd8BXsX++Z0Bv/ORVdw
	 uQCMpu25ac8XM6Bkew96hw+LUuCwb9tDLfqv4ShiPF28D++eibv5TIy6x7osgrJuB1
	 FRthzD4X4ogQHEE40u0sUlgEHZ/CGGcG2Q+JYENmeQEhuOA2VJvVAvocfXobonnsFG
	 8eYU9RKbIyAbw==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 14:59:32 +0000
Subject: [PATCH 6/8] regulator: mp8859: Support status and error readback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regulator-mp8859-v1-6-68ee2c839ded@kernel.org>
References: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
In-Reply-To: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hQozOQk8vKGJhYP2wxfoB44e0P7uPH2YR9fKCY4VQYs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21Xuto4KgtyF5tu6sqD6TDenynqoZDSUQ+jXR
 PayVsdHsXWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV7gAKCRAk1otyXVSH
 0OAeCACG62FfYCMT432Vtz/tUWvc0+pvEUbN+QU7mgupuVXBZ7sS1cEG7Hsv2gIdgRhHqHiCac4
 OtYif6EAf5j3QTMwxPIWvSAwRJd9AAItJuv1GSRyH8abiqSbyMwNfWXRGu8TLss8N9rc6BQkT5n
 NTh3qOaHxv49Jw0VBEvVglobKfteHmhJejn9+4mli5CnzOKxQ/H9wklvp/TA5vVYG9UQQ7eqIgV
 WrzY/f43p84lDKM1jIYE49h9TJiOMUeB/VkXxJGLOfGM5FVnb0qpVSZ9l32NqDSRq3rXx4zATbe
 AX/7Ahy+/1KpMlxzsVpHeplUqXIzxOR2FSNvS5HTJNU3y4C/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The MP8859 can report if it is in regulation and detect over temperature
conditions, report this information via the relevant regulator API
calls.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mp8859.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index 87ef34875be1..fc1636d69bca 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -39,6 +39,11 @@
 #define MP8859_DISCHG_EN_MASK		0x10
 #define MP8859_MODE_MASK		0x08
 
+#define MP8859_PG_MASK			0x80
+#define MP8859_OTP_MASK			0x40
+#define MP8859_OTW_MASK			0x20
+#define MP8859_CC_CV_MASK		0x10
+
 static int mp8859_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
 {
 	int ret;
@@ -112,6 +117,58 @@ static int mp8859_set_mode(struct regulator_dev *rdev, unsigned int mode)
 				  MP8859_MODE_MASK, val);
 }
 
+static int mp8859_get_status(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	/* Output status is only meaingful when enabled */
+	ret = regmap_read(rdev->regmap, MP8859_CTL1_REG, &val);
+	if (ret != 0)
+		return ret;
+	if (!(val & MP8859_ENABLE_MASK))
+		return REGULATOR_STATUS_UNDEFINED;
+
+	ret = regmap_read(rdev->regmap, MP8859_STATUS_REG, &val);
+	if (ret != 0)
+		return ret;
+
+	if (val & MP8859_PG_MASK)
+		return REGULATOR_STATUS_ON;
+	else
+		return REGULATOR_STATUS_ERROR;
+}
+
+static int mp8859_get_error_flags(struct regulator_dev *rdev,
+				  unsigned int *flags)
+{
+	unsigned int status, enabled;
+	int ret;
+
+	*flags = 0;
+
+	/* Output status is only meaingful when enabled */
+	ret = regmap_read(rdev->regmap, MP8859_CTL1_REG, &enabled);
+	if (ret != 0)
+		return ret;
+	enabled &= MP8859_ENABLE_MASK;
+
+	ret = regmap_read(rdev->regmap, MP8859_STATUS_REG, &status);
+	if (ret != 0)
+		return ret;
+
+	if (enabled && !(status & MP8859_PG_MASK))
+		status |= REGULATOR_ERROR_FAIL;
+	if (status & MP8859_OTP_MASK)
+		status |= REGULATOR_ERROR_OVER_TEMP;
+	if (status & MP8859_OTW_MASK)
+		status |= REGULATOR_ERROR_OVER_TEMP_WARN;
+	if (status & MP8859_CC_CV_MASK)
+		status |= REGULATOR_ERROR_OVER_CURRENT;
+
+	return 0;
+}
+
 static const struct linear_range mp8859_dcdc_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, VOL_MIN_IDX, VOL_MAX_IDX, 10000),
 };
@@ -169,6 +226,8 @@ static const struct regulator_ops mp8859_ops = {
 	.set_mode = mp8859_set_mode,
 	.get_mode = mp8859_get_mode,
 	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.get_status = mp8859_get_status,
+	.get_error_flags = mp8859_get_error_flags,
 };
 
 static const struct regulator_desc mp8859_regulators[] = {

-- 
2.39.2


