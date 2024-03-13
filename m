Return-Path: <linux-kernel+bounces-102167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9A87AEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098BD1F2B20A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE50150184;
	Wed, 13 Mar 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi4mHtt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D81948E8;
	Wed, 13 Mar 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349385; cv=none; b=nIza4mt2alLtFlIdrw7c+gfBojI4W5QuNSFNcBWHT2PRYlv1A8ds72KUceJt8zUvXnhwqWFipXyQJNjShUF7FxPuT6NEsIffAIeGnRl+hlqBU1h1hd/71a0HjTJO11S9YHGg6CelwHzb8tr6ZwhyozNkhfVF2QtgaiMNT7sTRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349385; c=relaxed/simple;
	bh=kE9+QqxKLyG/z+AHHzlifXJCx6VFUdBM6AknG8lcGe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnXUmFTbE3/lVwSNej2AsCmkXq6dsylTNM+ajCj/Kg2vGxtIzv3dBh5qapYUHvO5ylh/l2ZjxAi/jT4eg/g2zai1Zrjdu6EoIOY+WUf1XNhFwVMBUwHINDpS26RcHAll29OLsXBBiZ9IxMRvzy0m46zCvch3L5G25oSbz88Uu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi4mHtt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CECFC433C7;
	Wed, 13 Mar 2024 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349385;
	bh=kE9+QqxKLyG/z+AHHzlifXJCx6VFUdBM6AknG8lcGe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gi4mHtt5TSmmcxA8H/CB9XVSok1y/Ge2OX7zAdRSbvnUnLZUfQDu/rkjIUsTGphnj
	 Zlhp8miIIRDvv5ZPoP8uhOloY7CQOd0a1GANI8KdLcuFf49QplyGYPemzeelbIr7sd
	 HU43DpgKWp2+awaBWfWJp7bdkirl9VaEfAmTR2oKsNqlT5l5rgMes6q3QaUn3+0LTv
	 MvPdNDRNOoBbUGN92xrB6SoqmLXMjx6ECaeWARZL2eghIS9gRWAPPHEwssdFrg5W3M
	 ccdEJ0OgXJ1MlLh0uVTigwLr81ux9rGRpjRRIHwENen+Y3keoJsvbzRItQeNrwErpB
	 I+AHEnjJLC2Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ansuel Smith <ansuelsmth@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 46/51] regmap: allow to define reg_update_bits for no bus configuration
Date: Wed, 13 Mar 2024 13:02:07 -0400
Message-ID: <20240313170212.616443-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ansuel Smith <ansuelsmth@gmail.com>

[ Upstream commit 02d6fdecb9c38de19065f6bed8d5214556fd061d ]

Some device requires a special handling for reg_update_bits and can't use
the normal regmap read write logic. An example is when locking is
handled by the device and rmw operations requires to do atomic operations.
Allow to declare a dedicated function in regmap_config for
reg_update_bits in no bus configuration.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20211104150040.1260-1-ansuelsmth@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 1 +
 include/linux/regmap.h       | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 23574c328616f..961b206f6ab2d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -813,6 +813,7 @@ struct regmap *__regmap_init(struct device *dev,
 	if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
+		map->reg_update_bits = config->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index dfe493ac692d2..29661bbd137d7 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -295,6 +295,11 @@ typedef void (*regmap_unlock)(void *);
  *		  read operation on a bus such as SPI, I2C, etc. Most of the
  *		  devices do not need this.
  * @reg_write:	  Same as above for writing.
+ * @reg_update_bits: Optional callback that if filled will be used to perform
+ *		     all the update_bits(rmw) operation. Should only be provided
+ *		     if the function require special handling with lock and reg
+ *		     handling and the operation cannot be represented as a simple
+ *		     update_bits operation on a bus such as SPI, I2C, etc.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -371,6 +376,8 @@ struct regmap_config {
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
+	int (*reg_update_bits)(void *context, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 
 	bool fast_io;
 
-- 
2.43.0


