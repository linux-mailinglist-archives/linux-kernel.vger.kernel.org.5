Return-Path: <linux-kernel+bounces-102014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C787AD97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5D92810D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A614EA53;
	Wed, 13 Mar 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjwnR2cS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5714EA31;
	Wed, 13 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348228; cv=none; b=lQVziIiEON+Kr0KQJy+oTKEooW00JYRuna9beJgoHCJE9Z9UllMX9jQUGg0Wt3T/0ABrAGBwXqPPDP+B+tygI4MBvaxA+vqpEAaXR5jP9sUUxZKK36KR0QYz8ufG7j2LGg77xIyt1ioYnK0CeqqQAvzIj6X/jxPgWKt4Ngt79Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348228; c=relaxed/simple;
	bh=51XAzNGg8gzGapu9s6Ag8EJfxhvD/5hMAB4MTW0nNPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdZTZ2pJeZlgcAOZcCdY20HsRIFcystaFc0iLuEzLSTTsFHsOVk0A2uKlzSczGo8mzAfP5spKPVHL8FDycr5iI7sfTZL49lXDbm59pTRCAEifUSo+CfpqYydvS5AmnVkQI3cvledIfDBkDQul8SX1YhN2URh6cQiKm9s9vzCz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjwnR2cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8045BC43394;
	Wed, 13 Mar 2024 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348227;
	bh=51XAzNGg8gzGapu9s6Ag8EJfxhvD/5hMAB4MTW0nNPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjwnR2cSgpShXjh+pSVCwUpakzgaVvI+J/i8vaxWoq9Im9DpbQbnW6S8RKbAgOf6s
	 Ta3LM7ZZvTcqdjPLjgZDILBp+DnVQ7loE2IOjC8p5SAsLRE4h54L5u8mUM96L9Y+ub
	 /zYdY1eY1993+LWPIBb+oV2ekWkDcdnH+WJEzRcu/QyIDXp8I5JLsmKtcETkVemGgs
	 EshLP4ufqo1CZZow3ZeM0/TjMRa+ZcdZTrLR64zBhRp2Zm4zAVSi/64SprRvn/Dj9X
	 Vng3td0G0BNDyHOjTZbu2CYUBEjl+AhT4DV0908YKAyNU/lcmtDN6w5ip2h7wkNNMl
	 jXCpqh1yRdawA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Robert Foss <robert.foss@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 73/76] regmap: Add bulk read/write callbacks into regmap_config
Date: Wed, 13 Mar 2024 12:42:20 -0400
Message-ID: <20240313164223.615640-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit d77e745613680c54708470402e2b623dcd769681 ]

Currently the regmap_config structure only allows the user to implement
single element register read/write using .reg_read/.reg_write callbacks.
The regmap_bus already implements bulk counterparts of both, and is being
misused as a workaround for the missing bulk read/write callbacks in
regmap_config by a couple of drivers. To stop this misuse, add the bulk
read/write callbacks to regmap_config and call them from the regmap core
code.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
To: dri-devel@lists.freedesktop.org
Link: https://lore.kernel.org/r/20220430025145.640305-1-marex@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/internal.h |  4 ++
 drivers/base/regmap/regmap.c   | 76 ++++++++++++++++++----------------
 include/linux/regmap.h         | 12 ++++++
 3 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index b1905916f7af8..93e028445dade 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -108,6 +108,10 @@ struct regmap {
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
 	int (*reg_update_bits)(void *context, unsigned int reg,
 			       unsigned int mask, unsigned int val);
+	/* Bulk read/write */
+	int (*read)(void *context, const void *reg_buf, size_t reg_size,
+		    void *val_buf, size_t val_size);
+	int (*write)(void *context, const void *data, size_t count);
 
 	bool defer_caching;
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ab924127e0aef..6adb345866610 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -835,12 +835,15 @@ struct regmap *__regmap_init(struct device *dev,
 		map->reg_stride_order = ilog2(map->reg_stride);
 	else
 		map->reg_stride_order = -1;
-	map->use_single_read = config->use_single_read || !bus || !bus->read;
-	map->use_single_write = config->use_single_write || !bus || !bus->write;
-	map->can_multi_write = config->can_multi_write && bus && bus->write;
+	map->use_single_read = config->use_single_read || !(config->read || (bus && bus->read));
+	map->use_single_write = config->use_single_write || !(config->write || (bus && bus->write));
+	map->can_multi_write = config->can_multi_write && (config->write || (bus && bus->write));
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
 		map->max_raw_write = bus->max_raw_write;
+	} else if (config->max_raw_read && config->max_raw_write) {
+		map->max_raw_read = config->max_raw_read;
+		map->max_raw_write = config->max_raw_write;
 	}
 	map->dev = dev;
 	map->bus = bus;
@@ -874,7 +877,16 @@ struct regmap *__regmap_init(struct device *dev,
 		map->read_flag_mask = bus->read_flag_mask;
 	}
 
-	if (!bus) {
+	if (config && config->read && config->write) {
+		map->reg_read  = _regmap_bus_read;
+
+		/* Bulk read/write */
+		map->read = config->read;
+		map->write = config->write;
+
+		reg_endian = REGMAP_ENDIAN_NATIVE;
+		val_endian = REGMAP_ENDIAN_NATIVE;
+	} else if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
 		map->reg_update_bits = config->reg_update_bits;
@@ -891,10 +903,13 @@ struct regmap *__regmap_init(struct device *dev,
 	} else {
 		map->reg_read  = _regmap_bus_read;
 		map->reg_update_bits = bus->reg_update_bits;
-	}
+		/* Bulk read/write */
+		map->read = bus->read;
+		map->write = bus->write;
 
-	reg_endian = regmap_get_reg_endian(bus, config);
-	val_endian = regmap_get_val_endian(dev, bus, config);
+		reg_endian = regmap_get_reg_endian(bus, config);
+		val_endian = regmap_get_val_endian(dev, bus, config);
+	}
 
 	switch (config->reg_bits + map->reg_shift) {
 	case 2:
@@ -1668,8 +1683,6 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	size_t len;
 	int i;
 
-	WARN_ON(!map->bus);
-
 	/* Check for unwritable or noinc registers in range
 	 * before we start
 	 */
@@ -1751,7 +1764,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		val = work_val;
 	}
 
-	if (map->async && map->bus->async_write) {
+	if (map->async && map->bus && map->bus->async_write) {
 		struct regmap_async *async;
 
 		trace_regmap_async_write_start(map, reg, val_len);
@@ -1819,10 +1832,10 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	 * write.
 	 */
 	if (val == work_val)
-		ret = map->bus->write(map->bus_context, map->work_buf,
-				      map->format.reg_bytes +
-				      map->format.pad_bytes +
-				      val_len);
+		ret = map->write(map->bus_context, map->work_buf,
+				 map->format.reg_bytes +
+				 map->format.pad_bytes +
+				 val_len);
 	else if (map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
@@ -1841,7 +1854,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		memcpy(buf, map->work_buf, map->format.reg_bytes);
 		memcpy(buf + map->format.reg_bytes + map->format.pad_bytes,
 		       val, val_len);
-		ret = map->bus->write(map->bus_context, buf, len);
+		ret = map->write(map->bus_context, buf, len);
 
 		kfree(buf);
 	} else if (ret != 0 && !map->cache_bypass && map->format.parse_val) {
@@ -1898,7 +1911,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 	struct regmap_range_node *range;
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_write);
+	WARN_ON(!map->format.format_write);
 
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
@@ -1911,8 +1924,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	trace_regmap_hw_write_start(map, reg, 1);
 
-	ret = map->bus->write(map->bus_context, map->work_buf,
-			      map->format.buf_size);
+	ret = map->write(map->bus_context, map->work_buf, map->format.buf_size);
 
 	trace_regmap_hw_write_done(map, reg, 1);
 
@@ -1932,7 +1944,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 {
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_val);
+	WARN_ON(!map->format.format_val);
 
 	map->format.format_val(map->work_buf + map->format.reg_bytes
 			       + map->format.pad_bytes, val, 0);
@@ -1946,7 +1958,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 
 static inline void *_regmap_map_get_context(struct regmap *map)
 {
-	return (map->bus) ? map : map->bus_context;
+	return (map->bus || (!map->bus && map->read)) ? map : map->bus_context;
 }
 
 int _regmap_write(struct regmap *map, unsigned int reg,
@@ -2356,7 +2368,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 	u8 = buf;
 	*u8 |= map->write_flag_mask;
 
-	ret = map->bus->write(map->bus_context, buf, len);
+	ret = map->write(map->bus_context, buf, len);
 
 	kfree(buf);
 
@@ -2662,9 +2674,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	struct regmap_range_node *range;
 	int ret;
 
-	WARN_ON(!map->bus);
-
-	if (!map->bus || !map->bus->read)
+	if (!map->read)
 		return -EINVAL;
 
 	range = _regmap_range_lookup(map, reg);
@@ -2680,9 +2690,9 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 				      map->read_flag_mask);
 	trace_regmap_hw_read_start(map, reg, val_len / map->format.val_bytes);
 
-	ret = map->bus->read(map->bus_context, map->work_buf,
-			     map->format.reg_bytes + map->format.pad_bytes,
-			     val, val_len);
+	ret = map->read(map->bus_context, map->work_buf,
+			map->format.reg_bytes + map->format.pad_bytes,
+			val, val_len);
 
 	trace_regmap_hw_read_done(map, reg, val_len / map->format.val_bytes);
 
@@ -2793,8 +2803,6 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	unsigned int v;
 	int ret, i;
 
-	if (!map->bus)
-		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2809,7 +2817,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 		size_t chunk_count, chunk_bytes;
 		size_t chunk_regs = val_count;
 
-		if (!map->bus->read) {
+		if (!map->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
@@ -2869,7 +2877,7 @@ EXPORT_SYMBOL_GPL(regmap_raw_read);
  * @val: Pointer to data buffer
  * @val_len: Length of output buffer in bytes.
  *
- * The regmap API usually assumes that bulk bus read operations will read a
+ * The regmap API usually assumes that bulk read operations will read a
  * range of registers. Some devices have certain registers for which a read
  * operation read will read from an internal FIFO.
  *
@@ -2887,10 +2895,6 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 	size_t read_len;
 	int ret;
 
-	if (!map->bus)
-		return -EINVAL;
-	if (!map->bus->read)
-		return -ENOTSUPP;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -3004,7 +3008,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 	if (val_count == 0)
 		return -EINVAL;
 
-	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
+	if (map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
 		if (ret != 0)
 			return ret;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 22652e5fbc380..f74e543fadc07 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -295,6 +295,12 @@ typedef void (*regmap_unlock)(void *);
  *		     if the function require special handling with lock and reg
  *		     handling and the operation cannot be represented as a simple
  *		     update_bits operation on a bus such as SPI, I2C, etc.
+ * @read: Optional callback that if filled will be used to perform all the
+ *        bulk reads from the registers. Data is returned in the buffer used
+ *        to transmit data.
+ * @write: Same as above for writing.
+ * @max_raw_read: Max raw read size that can be used on the device.
+ * @max_raw_write: Max raw write size that can be used on the device.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -379,6 +385,12 @@ struct regmap_config {
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
 	int (*reg_update_bits)(void *context, unsigned int reg,
 			       unsigned int mask, unsigned int val);
+	/* Bulk read/write */
+	int (*read)(void *context, const void *reg_buf, size_t reg_size,
+		    void *val_buf, size_t val_size);
+	int (*write)(void *context, const void *data, size_t count);
+	size_t max_raw_read;
+	size_t max_raw_write;
 
 	bool fast_io;
 
-- 
2.43.0


