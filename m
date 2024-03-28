Return-Path: <linux-kernel+bounces-102096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8687AE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DA01F2DDF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386018DC9B;
	Wed, 13 Mar 2024 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to4VCg57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91218D3FC;
	Wed, 13 Mar 2024 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348480; cv=none; b=TKbmTeSLYi5o/7P23tGl/dTGvpMIiCQUc0lrswWm4mzTwrGpaQ+sKfzNtkfrJUgUE2+pRyroQpA+wQ+VbAwOvUbzlwPD9kTBcoa/UfzqEF7P2+3iv7A7IdydBpf/u5SMPVXM3sTVRxZNAfI0UG+rb+RPmPxe4+j0CUVJ8IthhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348480; c=relaxed/simple;
	bh=LJY5AinarXB+c+JK7G+QroadqR6FgM/S3F7mni6LNL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9rsXtwM5uF2ncxbL6e2jyvIW10sLuDltme/URm7Fy/3sRvEQTD2pUaWPf76x7YIdUgdpdsTZxpW7uXTnNEe5YCqPJ+5RFwtAg31NV7LV8e1ZeG3THhmfTRG7VbaFFtacaJlediQIEfUxehmMqW08nBD2yEbF0AciDGQEC8mYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to4VCg57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F94C433C7;
	Wed, 13 Mar 2024 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348480;
	bh=LJY5AinarXB+c+JK7G+QroadqR6FgM/S3F7mni6LNL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=to4VCg57jZ7U8GlGM8TCp/WtgE1TpqI3KhpEok73jTkgunhxIuZ8E1MhDrC1OXmES
	 UnKHlJFZYUClmkaLeUi01Gwf6z99nswPlrxzXyCKJuwv4U8hK/iQI388YYEdvrF071
	 R1L3xNPcJ42N58BHSqvicWTSqP8oxMdzJlUTQo8x07BQgdqquwgqJuDmVAr73nxKTX
	 EiGqkYcqPfTzaYRavJ/pA7PTL+7kLkbWXRYv5W3kCaI5LnMOxPvjmAE8bSUcj5JHtO
	 V5RaL6gbZ6GEETcpkzgtgb71aGu4mgcRTgDIihb9jxQItc5r7aEHUh8XIgLHZGtjZp
	 vTjaSC4TIHs+w==
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
Subject: [PATCH 5.10 69/73] regmap: Add bulk read/write callbacks into regmap_config
Date: Wed, 13 Mar 2024 12:46:36 -0400
Message-ID: <20240313164640.616049-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 0097696c31de2..2720d8d7bbfc9 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -104,6 +104,10 @@ struct regmap {
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
 	int (*reg_update_bits)(void *context, unsigned int reg,
 			       unsigned int mask, unsigned int val);
+	/* Bulk read/write */
+	int (*read)(void *context, const void *reg_buf, size_t reg_size,
+		    void *val_buf, size_t val_size);
+	int (*write)(void *context, const void *data, size_t count);
 
 	bool defer_caching;
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8f39aacdad0dc..2dfd6aa600450 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -800,12 +800,15 @@ struct regmap *__regmap_init(struct device *dev,
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
@@ -839,7 +842,16 @@ struct regmap *__regmap_init(struct device *dev,
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
@@ -856,10 +868,13 @@ struct regmap *__regmap_init(struct device *dev,
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
@@ -1628,8 +1643,6 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	size_t len;
 	int i;
 
-	WARN_ON(!map->bus);
-
 	/* Check for unwritable or noinc registers in range
 	 * before we start
 	 */
@@ -1711,7 +1724,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		val = work_val;
 	}
 
-	if (map->async && map->bus->async_write) {
+	if (map->async && map->bus && map->bus->async_write) {
 		struct regmap_async *async;
 
 		trace_regmap_async_write_start(map, reg, val_len);
@@ -1779,10 +1792,10 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
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
@@ -1801,7 +1814,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 		memcpy(buf, map->work_buf, map->format.reg_bytes);
 		memcpy(buf + map->format.reg_bytes + map->format.pad_bytes,
 		       val, val_len);
-		ret = map->bus->write(map->bus_context, buf, len);
+		ret = map->write(map->bus_context, buf, len);
 
 		kfree(buf);
 	} else if (ret != 0 && !map->cache_bypass && map->format.parse_val) {
@@ -1858,7 +1871,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 	struct regmap_range_node *range;
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_write);
+	WARN_ON(!map->format.format_write);
 
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
@@ -1871,8 +1884,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
 
 	trace_regmap_hw_write_start(map, reg, 1);
 
-	ret = map->bus->write(map->bus_context, map->work_buf,
-			      map->format.buf_size);
+	ret = map->write(map->bus_context, map->work_buf, map->format.buf_size);
 
 	trace_regmap_hw_write_done(map, reg, 1);
 
@@ -1892,7 +1904,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 {
 	struct regmap *map = context;
 
-	WARN_ON(!map->bus || !map->format.format_val);
+	WARN_ON(!map->format.format_val);
 
 	map->format.format_val(map->work_buf + map->format.reg_bytes
 			       + map->format.pad_bytes, val, 0);
@@ -1906,7 +1918,7 @@ static int _regmap_bus_raw_write(void *context, unsigned int reg,
 
 static inline void *_regmap_map_get_context(struct regmap *map)
 {
-	return (map->bus) ? map : map->bus_context;
+	return (map->bus || (!map->bus && map->read)) ? map : map->bus_context;
 }
 
 int _regmap_write(struct regmap *map, unsigned int reg,
@@ -2313,7 +2325,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 	u8 = buf;
 	*u8 |= map->write_flag_mask;
 
-	ret = map->bus->write(map->bus_context, buf, len);
+	ret = map->write(map->bus_context, buf, len);
 
 	kfree(buf);
 
@@ -2619,9 +2631,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	struct regmap_range_node *range;
 	int ret;
 
-	WARN_ON(!map->bus);
-
-	if (!map->bus || !map->bus->read)
+	if (!map->read)
 		return -EINVAL;
 
 	range = _regmap_range_lookup(map, reg);
@@ -2637,9 +2647,9 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 				      map->read_flag_mask);
 	trace_regmap_hw_read_start(map, reg, val_len / map->format.val_bytes);
 
-	ret = map->bus->read(map->bus_context, map->work_buf,
-			     map->format.reg_bytes + map->format.pad_bytes,
-			     val, val_len);
+	ret = map->read(map->bus_context, map->work_buf,
+			map->format.reg_bytes + map->format.pad_bytes,
+			val, val_len);
 
 	trace_regmap_hw_read_done(map, reg, val_len / map->format.val_bytes);
 
@@ -2750,8 +2760,6 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	unsigned int v;
 	int ret, i;
 
-	if (!map->bus)
-		return -EINVAL;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2766,7 +2774,7 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 		size_t chunk_count, chunk_bytes;
 		size_t chunk_regs = val_count;
 
-		if (!map->bus->read) {
+		if (!map->read) {
 			ret = -ENOTSUPP;
 			goto out;
 		}
@@ -2826,7 +2834,7 @@ EXPORT_SYMBOL_GPL(regmap_raw_read);
  * @val: Pointer to data buffer
  * @val_len: Length of output buffer in bytes.
  *
- * The regmap API usually assumes that bulk bus read operations will read a
+ * The regmap API usually assumes that bulk read operations will read a
  * range of registers. Some devices have certain registers for which a read
  * operation read will read from an internal FIFO.
  *
@@ -2844,10 +2852,6 @@ int regmap_noinc_read(struct regmap *map, unsigned int reg,
 	size_t read_len;
 	int ret;
 
-	if (!map->bus)
-		return -EINVAL;
-	if (!map->bus->read)
-		return -ENOTSUPP;
 	if (val_len % map->format.val_bytes)
 		return -EINVAL;
 	if (!IS_ALIGNED(reg, map->reg_stride))
@@ -2961,7 +2965,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 	if (val_count == 0)
 		return -EINVAL;
 
-	if (map->bus && map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
+	if (map->format.parse_inplace && (vol || map->cache_type == REGCACHE_NONE)) {
 		ret = regmap_raw_read(map, reg, val, val_bytes * val_count);
 		if (ret != 0)
 			return ret;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d6f0d876fa424..83a7485de78fb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -294,6 +294,12 @@ typedef void (*regmap_unlock)(void *);
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
@@ -373,6 +379,12 @@ struct regmap_config {
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


