Return-Path: <linux-kernel+bounces-163208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F68B6738
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC31F2311D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86421FB2;
	Tue, 30 Apr 2024 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RY/Oe6je"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0E17F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439645; cv=none; b=kas9wq4NN1DL1SbYRIXFfGdqs2A/8ZM0bR4AHovi67Ue9N3mwx54+9mS1JW10t1iBhDe2ApZIbZfWicwC1MxC8Oa+FsgNcfHNJCTPSl4opdPsfA5mPGjuMIyM4sgt58hlLuImZDCDJEHShu7rLjJhqhwD7s7IU/fkahxJDCW3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439645; c=relaxed/simple;
	bh=9MnlGl0zcfF4okBZbEu5Jw7xYOCa4VEdKmUbyb/tXIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H14x+Js7RpGJs0ja3HQno/tLYvBnqU0/DR2gxCr77KfMbxvfBv2lBuV+Gl1/gzAFeOo6Dkuq8jz/bnvKW7K5Gznl1CPXbv1mSqQtJOZgssqgAW5lVm1qegyDNYfTLAXarIzIVfJI9MfzUM2R79izSmFR+0lw4vsGmrKXxw/4E8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RY/Oe6je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E539DC113CD;
	Tue, 30 Apr 2024 01:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714439644;
	bh=9MnlGl0zcfF4okBZbEu5Jw7xYOCa4VEdKmUbyb/tXIc=;
	h=From:To:Cc:Subject:Date:From;
	b=RY/Oe6jeh3VtfvhYgAfb1pFe16xIGBgby9Q0xf6m2mgH8aLN4fp64DjenoU05B2jY
	 nUCXMDUQ+4psjkVy0U5i4SqZGlRRicaRdoGPgTGN5UXM8l1c96HiSsmPe4KkTiXANO
	 BPD7/3Vj+EMexTSSlFiNZHrtXHCyhmxxx3+yrnXQaKFsdDtB2Lra2wnI8w1b+aS+Pw
	 GpwgOIHID2MLnQP3tEfVWOdLU72rN9neLYj4XhUo8919ER8PrNNZWMX+O/AALupybT
	 xJ78e0dAuzyZQ4vXPHiibne/xN47x8BQ3j9RyW5uK8f7tpMctUCmM5wmiaF3ZjNtfG
	 ibA02Uv8YS5WQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps6286x-regulator: Enable REGCACHE_FLAT
Date: Tue, 30 Apr 2024 09:00:19 +0800
Message-ID: <20240430010019.1980-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable regmap cache to reduce i2c transactions and corresponding
interrupts if regulator is accessed frequently. Since the register map
is small, we use a FLAT regmap cache.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/regulator/tps6286x-regulator.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index 758c70269653..adef970972a7 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -19,13 +19,49 @@
 #define TPS6286X_CONTROL_FPWM	BIT(4)
 #define TPS6286X_CONTROL_SWEN	BIT(5)
 
+#define TPS6286X_STATUS		0x05
+#define TPS6286X_MAX_REGS	(TPS6286X_STATUS + 1)
+
 #define TPS6286X_MIN_MV		400
 #define TPS6286X_MAX_MV		1675
 #define TPS6286X_STEP_MV	5
 
+static bool tps6286x_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TPS6286X_VOUT1 ... TPS6286X_CONTROL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tps6286x_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TPS6286X_VOUT1 ... TPS6286X_CONTROL:
+	case TPS6286X_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tps6286x_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == TPS6286X_STATUS)
+		return true;
+	return false;
+}
+
 static const struct regmap_config tps6286x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.num_reg_defaults_raw = TPS6286X_MAX_REGS,
+	.cache_type = REGCACHE_FLAT,
+	.writeable_reg = tps6286x_writeable_reg,
+	.readable_reg = tps6286x_readable_reg,
+	.volatile_reg = tps6286x_volatile_reg,
 };
 
 static int tps6286x_set_mode(struct regulator_dev *rdev, unsigned int mode)
-- 
2.43.0


