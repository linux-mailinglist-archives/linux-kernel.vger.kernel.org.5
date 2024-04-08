Return-Path: <linux-kernel+bounces-135550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6889C75F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5557B26A2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C491420A0;
	Mon,  8 Apr 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nIYEutBv"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C35613EFF4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587574; cv=none; b=nxRl0w6azTO1oV8lFRBu3dOGLPc3iGFTcydYHDnJThnw1VD0Ifyo86M8vzk9GES+0MhPg670cwASfsUM8RDhG2fyNof0QqgsPWYtmiLpUpG3VOEzlxrFVk3n779XnUsRhzyfcae94xIvXk/pxKltfJK2MgPJJEuKIOzG9ko/GDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587574; c=relaxed/simple;
	bh=2SVurQAbEqc0jAne35943NOeGvQcOWlmtHKJaIsGM/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzDUc7XxnQJ8k5xoFGXx3fs52YJHhYdrZV7Mkac9wCGIlKh6osB3P7LA0Ati9hxv5aGPyYKpx7K5jFKVPUX0IJI4+rQJ93QAdniDlo8ZDTJbopbjRFoYrFgt/d1rh4eATNgPurOjYf3iXOfTpsX3Ou092coDl//zTOBVRCfy7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nIYEutBv; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlL1032409;
	Mon, 8 Apr 2024 09:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=gnoAedlYftAvk2qQw1KtAvPKxhOnRMJ/9uKbfEPGO4I=; b=
	nIYEutBvxRl7/hpjlWAuVmE6KqtqF59c/2HYKNiCa7/XPqTmdrW3xx+caa2sSdjx
	PIgFeYjpqBCeB5+G5pl4G5o6e7IvnLzyspBmE6JhF/tXNfgurlw9y7JiqblvzY2Q
	USHrB9KCLjDZUAkp8r2Lw3z+ESDGxiVN6nh4j/XR/rf/cFylPUD5xfDouYQ+88OX
	5x0u0xyfMRGlgwhGtDQqN9h6I80C7lA2hhktOnJTfcf3vzYGoEKe0UHBc/uGdQPW
	39LTvGCK9oBkWbqGeNLonxUheWqZtxn/Vj7i8jTbRgwKowmm+sIZOemKqONXBCmd
	9TVoxWYTd9z7efhynOVh4A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B159F82024B;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 02/11] regmap: kunit: Create a struct device for the regmap
Date: Mon, 8 Apr 2024 15:45:51 +0100
Message-ID: <20240408144600.230848-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408144600.230848-1-rf@opensource.cirrus.com>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P5P6Otb-aFgfVs2yXq7ZN638xyo6jHdR
X-Proofpoint-GUID: P5P6Otb-aFgfVs2yXq7ZN638xyo6jHdR
X-Proofpoint-Spam-Reason: safe

Use kunit_device_register() to create a real struct device for the
regmap instead of leaving it at NULL.

The main reason for this is that it allows context data to be passed
into the readable_reg/writable_reg/volatile_reg functions by attaching
it to the struct device with dev_set_drvdata().

The gen_regmap() and gen_raw_regmap() functions are updated to take a
struct kunit * argument.

A new struct regmap_test_priv has been created to hold the struct device
created by kunit_device_register(). This allows the struct to be
extended in the future to hold more private data for the test suite.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/internal.h       |  14 ++--
 drivers/base/regmap/regmap-kunit.c   | 105 +++++++++++++++++++--------
 drivers/base/regmap/regmap-ram.c     |   5 +-
 drivers/base/regmap/regmap-raw-ram.c |   5 +-
 4 files changed, 87 insertions(+), 42 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index bcdb25bec77c..83acccdc1008 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -326,20 +326,22 @@ struct regmap_ram_data {
  * Create a test register map with data stored in RAM, not intended
  * for practical use.
  */
-struct regmap *__regmap_init_ram(const struct regmap_config *config,
+struct regmap *__regmap_init_ram(struct device *dev,
+				 const struct regmap_config *config,
 				 struct regmap_ram_data *data,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
 
-#define regmap_init_ram(config, data)					\
-	__regmap_lockdep_wrapper(__regmap_init_ram, #config, config, data)
+#define regmap_init_ram(dev, config, data)					\
+	__regmap_lockdep_wrapper(__regmap_init_ram, #dev, dev, config, data)
 
-struct regmap *__regmap_init_raw_ram(const struct regmap_config *config,
+struct regmap *__regmap_init_raw_ram(struct device *dev,
+				     const struct regmap_config *config,
 				     struct regmap_ram_data *data,
 				     struct lock_class_key *lock_key,
 				     const char *lock_name);
 
-#define regmap_init_raw_ram(config, data)				\
-	__regmap_lockdep_wrapper(__regmap_init_raw_ram, #config, config, data)
+#define regmap_init_raw_ram(dev, config, data)				\
+	__regmap_lockdep_wrapper(__regmap_init_raw_ram, #dev, dev, config, data)
 
 #endif
diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index b46a4f28c1a1..3bc2028fbef7 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -4,11 +4,16 @@
 //
 // Copyright 2023 Arm Ltd
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include "internal.h"
 
 #define BLOCK_TEST_SIZE 12
 
+struct regmap_test_priv {
+	struct device *dev;
+};
+
 static void get_changed_bytes(void *orig, void *new, size_t size)
 {
 	char *o = orig;
@@ -66,9 +71,11 @@ static const struct regcache_types sparse_cache_types_list[] = {
 
 KUNIT_ARRAY_PARAM(sparse_cache_types, sparse_cache_types_list, case_to_desc);
 
-static struct regmap *gen_regmap(struct regmap_config *config,
+static struct regmap *gen_regmap(struct kunit *test,
+				 struct regmap_config *config,
 				 struct regmap_ram_data **data)
 {
+	struct regmap_test_priv *priv = test->priv;
 	unsigned int *buf;
 	struct regmap *ret;
 	size_t size = (config->max_register + 1) * sizeof(unsigned int);
@@ -103,7 +110,7 @@ static struct regmap *gen_regmap(struct regmap_config *config,
 		}
 	}
 
-	ret = regmap_init_ram(config, *data);
+	ret = regmap_init_ram(priv->dev, config, *data);
 	if (IS_ERR(ret)) {
 		kfree(buf);
 		kfree(*data);
@@ -128,7 +135,7 @@ static void basic_read_write(struct kunit *test)
 	config = test_regmap_config;
 	config.cache_type = t->type;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -158,7 +165,7 @@ static void bulk_write(struct kunit *test)
 	config = test_regmap_config;
 	config.cache_type = t->type;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -195,7 +202,7 @@ static void bulk_read(struct kunit *test)
 	config = test_regmap_config;
 	config.cache_type = t->type;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -230,7 +237,7 @@ static void write_readonly(struct kunit *test)
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 	config.writeable_reg = reg_5_false;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -264,7 +271,7 @@ static void read_writeonly(struct kunit *test)
 	config.cache_type = t->type;
 	config.readable_reg = reg_5_false;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -304,7 +311,7 @@ static void reg_defaults(struct kunit *test)
 	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -332,7 +339,7 @@ static void reg_defaults_read_dev(struct kunit *test)
 	config.cache_type = t->type;
 	config.num_reg_defaults_raw = BLOCK_TEST_SIZE;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -368,7 +375,7 @@ static void register_patch(struct kunit *test)
 	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -419,7 +426,7 @@ static void stride(struct kunit *test)
 	config.reg_stride = 2;
 	config.num_reg_defaults = BLOCK_TEST_SIZE / 2;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -495,7 +502,7 @@ static void basic_ranges(struct kunit *test)
 	config.num_ranges = 1;
 	config.max_register = test_range.range_max;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -565,7 +572,7 @@ static void stress_insert(struct kunit *test)
 	config.cache_type = t->type;
 	config.max_register = 300;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -616,7 +623,7 @@ static void cache_bypass(struct kunit *test)
 	config = test_regmap_config;
 	config.cache_type = t->type;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -655,7 +662,7 @@ static void cache_sync(struct kunit *test)
 	config = test_regmap_config;
 	config.cache_type = t->type;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -694,7 +701,7 @@ static void cache_sync_defaults(struct kunit *test)
 	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -730,7 +737,7 @@ static void cache_sync_readonly(struct kunit *test)
 	config.cache_type = t->type;
 	config.writeable_reg = reg_5_false;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -773,7 +780,7 @@ static void cache_sync_patch(struct kunit *test)
 	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -832,7 +839,7 @@ static void cache_drop(struct kunit *test)
 	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -873,7 +880,7 @@ static void cache_present(struct kunit *test)
 	config = test_regmap_config;
 	config.cache_type = t->type;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -917,7 +924,7 @@ static void cache_range_window_reg(struct kunit *test)
 	config.num_ranges = 1;
 	config.max_register = test_range.range_max;
 
-	map = gen_regmap(&config, &data);
+	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -997,10 +1004,12 @@ static const struct regmap_config raw_regmap_config = {
 	.val_bits = 16,
 };
 
-static struct regmap *gen_raw_regmap(struct regmap_config *config,
+static struct regmap *gen_raw_regmap(struct kunit *test,
+				     struct regmap_config *config,
 				     struct raw_test_types *test_type,
 				     struct regmap_ram_data **data)
 {
+	struct regmap_test_priv *priv = test->priv;
 	u16 *buf;
 	struct regmap *ret;
 	size_t size = (config->max_register + 1) * config->reg_bits / 8;
@@ -1052,7 +1061,7 @@ static struct regmap *gen_raw_regmap(struct regmap_config *config,
 	if (config->cache_type == REGCACHE_NONE)
 		config->num_reg_defaults = 0;
 
-	ret = regmap_init_raw_ram(config, *data);
+	ret = regmap_init_raw_ram(priv->dev, config, *data);
 	if (IS_ERR(ret)) {
 		kfree(buf);
 		kfree(*data);
@@ -1072,7 +1081,7 @@ static void raw_read_defaults_single(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1099,7 +1108,7 @@ static void raw_read_defaults(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1109,7 +1118,7 @@ static void raw_read_defaults(struct kunit *test)
 	KUNIT_ASSERT_TRUE(test, rval != NULL);
 	if (!rval)
 		return;
-	
+
 	/* Check that we can read the defaults via the API */
 	KUNIT_EXPECT_EQ(test, 0, regmap_raw_read(map, 0, rval, val_len));
 	for (i = 0; i < config.max_register + 1; i++) {
@@ -1136,7 +1145,7 @@ static void raw_write_read_single(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1164,7 +1173,7 @@ static void raw_write(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1228,7 +1237,7 @@ static void raw_noinc_write(struct kunit *test)
 	config.writeable_noinc_reg = reg_zero;
 	config.readable_noinc_reg = reg_zero;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1276,7 +1285,7 @@ static void raw_sync(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1323,7 +1332,7 @@ static void raw_sync(struct kunit *test)
 		val[2] = cpu_to_be16(val[2]);
 	else
 		val[2] = cpu_to_le16(val[2]);
-	
+
 	/* The values should not appear in the "hardware" */
 	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], &val[0], sizeof(val));
 
@@ -1356,7 +1365,7 @@ static void raw_ranges(struct kunit *test)
 	config.num_ranges = 1;
 	config.max_register = test_range.range_max;
 
-	map = gen_raw_regmap(&config, t, &data);
+	map = gen_raw_regmap(test, &config, t, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1437,8 +1446,40 @@ static struct kunit_case regmap_test_cases[] = {
 	{}
 };
 
+static int regmap_test_init(struct kunit *test)
+{
+	struct regmap_test_priv *priv;
+	struct device *dev;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	test->priv = priv;
+
+	dev = kunit_device_register(test, "regmap_test");
+	priv->dev = get_device(dev);
+	if (!priv->dev)
+		return -ENODEV;
+
+	dev_set_drvdata(dev, test);
+
+	return 0;
+}
+
+static void regmap_test_exit(struct kunit *test)
+{
+	struct regmap_test_priv *priv = test->priv;
+
+	/* Destroy the dummy struct device */
+	if (priv && priv->dev)
+		put_device(priv->dev);
+}
+
 static struct kunit_suite regmap_test_suite = {
 	.name = "regmap",
+	.init = regmap_test_init,
+	.exit = regmap_test_exit,
 	.test_cases = regmap_test_cases,
 };
 kunit_test_suite(regmap_test_suite);
diff --git a/drivers/base/regmap/regmap-ram.c b/drivers/base/regmap/regmap-ram.c
index 192d6b131dff..5b4cbf982a11 100644
--- a/drivers/base/regmap/regmap-ram.c
+++ b/drivers/base/regmap/regmap-ram.c
@@ -53,7 +53,8 @@ static const struct regmap_bus regmap_ram = {
 	.free_context = regmap_ram_free_context,
 };
 
-struct regmap *__regmap_init_ram(const struct regmap_config *config,
+struct regmap *__regmap_init_ram(struct device *dev,
+				 const struct regmap_config *config,
 				 struct regmap_ram_data *data,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name)
@@ -75,7 +76,7 @@ struct regmap *__regmap_init_ram(const struct regmap_config *config,
 	if (!data->written)
 		return ERR_PTR(-ENOMEM);
 
-	map = __regmap_init(NULL, &regmap_ram, data, config,
+	map = __regmap_init(dev, &regmap_ram, data, config,
 			    lock_key, lock_name);
 
 	return map;
diff --git a/drivers/base/regmap/regmap-raw-ram.c b/drivers/base/regmap/regmap-raw-ram.c
index 93ae07b503fd..69eabfb89eda 100644
--- a/drivers/base/regmap/regmap-raw-ram.c
+++ b/drivers/base/regmap/regmap-raw-ram.c
@@ -107,7 +107,8 @@ static const struct regmap_bus regmap_raw_ram = {
 	.free_context = regmap_raw_ram_free_context,
 };
 
-struct regmap *__regmap_init_raw_ram(const struct regmap_config *config,
+struct regmap *__regmap_init_raw_ram(struct device *dev,
+				     const struct regmap_config *config,
 				     struct regmap_ram_data *data,
 				     struct lock_class_key *lock_key,
 				     const char *lock_name)
@@ -134,7 +135,7 @@ struct regmap *__regmap_init_raw_ram(const struct regmap_config *config,
 
 	data->reg_endian = config->reg_format_endian;
 
-	map = __regmap_init(NULL, &regmap_raw_ram, data, config,
+	map = __regmap_init(dev, &regmap_raw_ram, data, config,
 			    lock_key, lock_name);
 
 	return map;
-- 
2.39.2


