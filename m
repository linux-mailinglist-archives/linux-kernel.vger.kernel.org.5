Return-Path: <linux-kernel+bounces-163211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF98B673E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8241F230AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D51FB2;
	Tue, 30 Apr 2024 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz3G6uQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B217F5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439712; cv=none; b=lGZQb64gFuc6I95Bp3B5ed/eIhngDjY9Z+cF/yN0dNvTI8UPLSmmS42xaKAne90Zj9eu/R0GUhQbJ+oZqKp6XFXdC1CPKpXTjBQcLbxFo3W+VFEN3AOFCS06416k+40pE45RuJQxkwSGt94610JXaLL4GkAlgaJCCoBrVtUO88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439712; c=relaxed/simple;
	bh=gQYHXdjYcm9SnzVQ18TbG2wPyA/Wtk9x8tzzwzKjkE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgKmEvwIGZa865R5YgAJMJRmIfDZ6HsFSmpSWMaEAwvHXR27w/v5ndWS9qjHCi5p5mtZ08tKu1rF+ekmKmBkA/vMncIcRY9AUFMde0pIYc7+/l+qfUzkULgXZLAmre22F11os946t4w4zVLsgPNUgLQG1fjkderjvLszW38VwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz3G6uQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A4C113CD;
	Tue, 30 Apr 2024 01:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714439710;
	bh=gQYHXdjYcm9SnzVQ18TbG2wPyA/Wtk9x8tzzwzKjkE8=;
	h=From:To:Cc:Subject:Date:From;
	b=sz3G6uQoo+dXL/o10QUko0rSzSmyUBJqE/A4kr7Z1Gm5h5H7Tnd5CkjOWlSJhnq2L
	 eLBeuv020xBXOlvMtEVIRlfMEn9BVi8Wjre3VabwRe0ltUCe7z25ppMwxLui2LGRsN
	 5Xdv3WPz2ecJvvaN6sjH9ocR+XqxApOrqJm7mkztWD8xMAy+Gj3jk2hf36gyEacayV
	 fJrU3sZn6EiO1NWwQ2K2ZO3137N1bcGXiG2/LRyoP8jYRz9eeL2GQg0jZqDuupRICb
	 OhiJGmfNS6AXnGPapd9QrCVWYG6MFSm+Oltc0HyrDecDdlWEWzU5bGwbOhGGsfXg0N
	 Fook4ARNfV69A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rt5739: Enable REGCACHE_FLAT
Date: Tue, 30 Apr 2024 09:01:40 +0800
Message-ID: <20240430010140.2027-1-jszhang@kernel.org>
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
 drivers/regulator/rt5739.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/regulator/rt5739.c b/drivers/regulator/rt5739.c
index 91412c905ce6..47172b11301c 100644
--- a/drivers/regulator/rt5739.c
+++ b/drivers/regulator/rt5739.c
@@ -24,8 +24,11 @@
 #define RT5739_REG_NSEL1	0x01
 #define RT5739_REG_CNTL1	0x02
 #define RT5739_REG_ID1		0x03
+#define RT5739_REG_ID2		0x04
+#define RT5739_REG_MON		0x05
 #define RT5739_REG_CNTL2	0x06
 #define RT5739_REG_CNTL4	0x08
+#define RT5739_MAX_REGS		(RT5739_REG_CNTL4 + 1)
 
 #define RT5739_VSEL_MASK	GENMASK(7, 0)
 #define RT5739_MODEVSEL1_MASK	BIT(1)
@@ -236,11 +239,46 @@ static void rt5739_init_regulator_desc(struct regulator_desc *desc,
 	}
 }
 
+static bool rt5739_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT5739_REG_NSEL0 ... RT5739_REG_CNTL1:
+	case RT5739_REG_CNTL2:
+	case RT5739_REG_CNTL4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt5739_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RT5739_REG_NSEL0 ... RT5739_REG_CNTL2:
+	case RT5739_REG_CNTL4:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rt5739_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == RT5739_REG_MON)
+		return true;
+	return false;
+}
+
 static const struct regmap_config rt5739_regmap_config = {
 	.name = "rt5739",
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = RT5739_REG_CNTL4,
+	.num_reg_defaults_raw = RT5739_MAX_REGS,
+	.cache_type = REGCACHE_FLAT,
+	.writeable_reg = rt5739_writeable_reg,
+	.readable_reg = rt5739_readable_reg,
+	.volatile_reg = rt5739_volatile_reg,
 };
 
 static int rt5739_probe(struct i2c_client *i2c)
-- 
2.43.0


