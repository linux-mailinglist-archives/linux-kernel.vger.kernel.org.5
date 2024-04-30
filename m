Return-Path: <linux-kernel+bounces-163210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB248B673D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD65EB2247D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F7720EB;
	Tue, 30 Apr 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2rLBRUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476291870
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439688; cv=none; b=Mpfa1ym/gMh8TZyII7xlQxpkfpshcPHvQwKpH4rTrdEKcOaV9BeRvz3WEePWuSmb9Mpv8AqxFC6ashEelzdbgEHxilwdsmt3t+TqTzU+7pfxdgZCP+MwQxaVYsLgmYQmODVWU/einAz49ELQsZl3ZWrREgWqpuKANStbImkPPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439688; c=relaxed/simple;
	bh=8J0qweWKPI2qSY7aVbqXXKii2wzAW9xiIZPhy3dnyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPmmj8lWcSN3sdapuLBOa1x+ISkr6B6HnKgg/vn1Sn+vOyOMBbduxw/JarY1fy9LwXkGhw3ZqbpZ5Tngwcduj14V0uy0noC0vWEOeuHhLkHQMEZ8qrhMGtOUCQ2g3hDp4krPFP4GV365khmUndPRHnfZypwODzLhC76RY/Mj3es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2rLBRUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38096C113CD;
	Tue, 30 Apr 2024 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714439687;
	bh=8J0qweWKPI2qSY7aVbqXXKii2wzAW9xiIZPhy3dnyfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=f2rLBRUZ8q95v9pN0mAu9T3AXQCIXMlpuJCzWVfZ2qv7QN4TpECelLSXrljMtH06H
	 qsDMvuE3b2lRHn6wTMc5cIg3u4IQSFJjY3ZZ2YXt+7obYIHJR1W6raDjPQO3hzDjNa
	 X+j2FZ+JodyRVLtOab1welxqI8jB8bUckpuFbgaQ+RYWY/rPvCezXIFwxS4m2srs8R
	 91U/yC6azHI4DpAGtcqxqlgXQCJ0gAq/LMM5fcF7kaFO2Wh8JX4DBXVzgX4AWVpPY0
	 2Ugwb1s/zPLPg8nO8rFVWj5pbmxySj0juuWNIuSwBBYNcPgohoK2Vy0mpbTbEnUpGq
	 dcuvbtNf5GHDQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps6287x: Enable REGCACHE_FLAT
Date: Tue, 30 Apr 2024 09:01:08 +0800
Message-ID: <20240430010108.2004-1-jszhang@kernel.org>
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
 drivers/regulator/tps6287x-regulator.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index 9b7c3d77789e..d4dffb87e858 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -26,11 +26,44 @@
 #define TPS6287X_CTRL2_VRANGE	GENMASK(3, 2)
 #define TPS6287X_CTRL3		0x03
 #define TPS6287X_STATUS		0x04
+#define TPS6287X_MAX_REGS	(TPS6287X_STATUS + 1)
+
+static bool tps6287x_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TPS6287X_VSET ... TPS6287X_CTRL3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tps6287x_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TPS6287X_VSET ... TPS6287X_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tps6287x_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == TPS6287X_STATUS)
+		return true;
+	return false;
+}
 
 static const struct regmap_config tps6287x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = TPS6287X_STATUS,
+	.num_reg_defaults_raw = TPS6287X_MAX_REGS,
+	.cache_type = REGCACHE_FLAT,
+	.writeable_reg = tps6287x_writeable_reg,
+	.readable_reg = tps6287x_readable_reg,
+	.volatile_reg = tps6287x_volatile_reg,
 };
 
 static const struct linear_range tps6287x_voltage_ranges[] = {
-- 
2.43.0


