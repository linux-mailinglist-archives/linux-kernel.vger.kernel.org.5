Return-Path: <linux-kernel+bounces-135546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7FC89C75D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF41C220C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02B1411DC;
	Mon,  8 Apr 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GCV1EwsQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9213F011
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587572; cv=none; b=JgDQPEVUfXoJBjlpl/synasZknVHXUqeDvuQpT1PMXIkg7Nra85McRk4WMhWNzoGXqBY/Ud22jyr/JQpwVcM9ivVNj89DOGedDk+q0Hy3tvYrYXmHoecufDsqL3uHwP5TGSX4vPlfWKbMgabXDMm3LihODFMGqlVkiIueQhZozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587572; c=relaxed/simple;
	bh=a/4rn5jp1lTaSk2oH7N9JuuOQl9kivHIfztegQlaYlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHOvtVOzlCytAI+tOB/XnnbvHkV71q1aUBz9Ln2AEhbWV8mjobEVp21vq1j4MgPypa23L5aIThHfn/yo7Q0ioiyQJUqVjXjOocBUHvTQW+AESQIuOBlntDpeDRxOQSSbdFHkSm4XJkHYiEHyUxxaWihN4JRF8Ath1pmAoS9JM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GCV1EwsQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlL3032409;
	Mon, 8 Apr 2024 09:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=VbIW8qyKsPALaQgVoa+RAMMxAtYXggZ0eRdcwQ4xLQo=; b=
	GCV1EwsQsQ3xRdOVkysN2+Geg1UCVqrzvc0jNYNP4K6hqNQ/Qij93UN6f95mRmXJ
	52g/eoNK/G7/1105KtsizbCwG5BsDRapHgJt8qUwEJ+Vwk6/7irOsXsdSampULjm
	recvqhjXI7XaA224gpkxw7maoaJOnh+HAPHFjpVq9OHAGVZyw6z2q4G+2UkyQFwy
	YoQJSIcNajonkZ8QkrPo48AtkIJ6rYBRlcOhzLeZDXKd98vTkKOOXZRlbfM/Njse
	xrXW8ZUr6FagM0mXiibpE93A4836v/BbHvsRob4uJDDiL2BPjKAJ5bk5tBmsVt9r
	Uk9DrlU0X7t35LGhBrLjDg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:05 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B4CFA820258;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 03/11] regmap: kunit: Introduce struct for test case parameters
Date: Mon, 8 Apr 2024 15:45:52 +0100
Message-ID: <20240408144600.230848-4-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: SQ8jyYcxzy7k9V6c87uDxaikxc41bDA6
X-Proofpoint-GUID: SQ8jyYcxzy7k9V6c87uDxaikxc41bDA6
X-Proofpoint-Spam-Reason: safe

Add a struct regmap_test_param and use it for all test cases
instead of passing various different types of param object
depending on the test case.

This makes it much easier and cleaner to expand what can be
parameterized.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 213 +++++++++++++----------------
 1 file changed, 96 insertions(+), 117 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 3bc2028fbef7..2029135f68fb 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -14,6 +14,11 @@ struct regmap_test_priv {
 	struct device *dev;
 };
 
+struct regmap_test_param {
+	enum regcache_type cache;
+	enum regmap_endian val_endian;
+};
+
 static void get_changed_bytes(void *orig, void *new, size_t size)
 {
 	char *o = orig;
@@ -37,44 +42,74 @@ static const struct regmap_config test_regmap_config = {
 	.val_bits = sizeof(unsigned int) * 8,
 };
 
-struct regcache_types {
-	enum regcache_type type;
-	const char *name;
-};
-
-static void case_to_desc(const struct regcache_types *t, char *desc)
+static const char *regcache_type_name(enum regcache_type type)
 {
-	strcpy(desc, t->name);
+	switch (type) {
+	case REGCACHE_NONE:
+		return "none";
+	case REGCACHE_FLAT:
+		return "flat";
+	case REGCACHE_RBTREE:
+		return "rbtree";
+	case REGCACHE_MAPLE:
+		return "maple";
+	default:
+		return NULL;
+	}
 }
 
-static const struct regcache_types regcache_types_list[] = {
-	{ REGCACHE_NONE, "none" },
-	{ REGCACHE_FLAT, "flat" },
-	{ REGCACHE_RBTREE, "rbtree" },
-	{ REGCACHE_MAPLE, "maple" },
+static const char *regmap_endian_name(enum regmap_endian endian)
+{
+	switch (endian) {
+	case REGMAP_ENDIAN_BIG:
+		return "big";
+	case REGMAP_ENDIAN_LITTLE:
+		return "little";
+	case REGMAP_ENDIAN_DEFAULT:
+		return "default";
+	case REGMAP_ENDIAN_NATIVE:
+		return "native";
+	default:
+		return NULL;
+	}
+}
+
+static void param_to_desc(const struct regmap_test_param *param, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s-%s",
+		 regcache_type_name(param->cache),
+		 regmap_endian_name(param->val_endian));
+}
+
+static const struct regmap_test_param regcache_types_list[] = {
+	{ .cache = REGCACHE_NONE },
+	{ .cache = REGCACHE_FLAT },
+	{ .cache = REGCACHE_RBTREE },
+	{ .cache = REGCACHE_MAPLE },
 };
 
-KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, case_to_desc);
+KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, param_to_desc);
 
-static const struct regcache_types real_cache_types_list[] = {
-	{ REGCACHE_FLAT, "flat" },
-	{ REGCACHE_RBTREE, "rbtree" },
-	{ REGCACHE_MAPLE, "maple" },
+static const struct regmap_test_param real_cache_types_list[] = {
+	{ .cache = REGCACHE_FLAT },
+	{ .cache = REGCACHE_RBTREE },
+	{ .cache = REGCACHE_MAPLE },
 };
 
-KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, case_to_desc);
+KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, param_to_desc);
 
-static const struct regcache_types sparse_cache_types_list[] = {
-	{ REGCACHE_RBTREE, "rbtree" },
-	{ REGCACHE_MAPLE, "maple" },
+static const struct regmap_test_param sparse_cache_types_list[] = {
+	{ .cache = REGCACHE_RBTREE },
+	{ .cache = REGCACHE_MAPLE },
 };
 
-KUNIT_ARRAY_PARAM(sparse_cache_types, sparse_cache_types_list, case_to_desc);
+KUNIT_ARRAY_PARAM(sparse_cache_types, sparse_cache_types_list, param_to_desc);
 
 static struct regmap *gen_regmap(struct kunit *test,
 				 struct regmap_config *config,
 				 struct regmap_ram_data **data)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap_test_priv *priv = test->priv;
 	unsigned int *buf;
 	struct regmap *ret;
@@ -82,6 +117,7 @@ static struct regmap *gen_regmap(struct kunit *test,
 	int i;
 	struct reg_default *defaults;
 
+	config->cache_type = param->cache;
 	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
 					config->cache_type == REGCACHE_MAPLE;
 
@@ -126,14 +162,12 @@ static bool reg_5_false(struct device *context, unsigned int reg)
 
 static void basic_read_write(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
 	unsigned int val, rval;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
@@ -148,14 +182,13 @@ static void basic_read_write(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, val, rval);
 
 	/* If using a cache the cache satisfied the read */
-	KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[0]);
+	KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[0]);
 
 	regmap_exit(map);
 }
 
 static void bulk_write(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -163,7 +196,6 @@ static void bulk_write(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
@@ -185,14 +217,13 @@ static void bulk_write(struct kunit *test)
 
 	/* If using a cache the cache satisfied the read */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 
 	regmap_exit(map);
 }
 
 static void bulk_read(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -200,7 +231,6 @@ static void bulk_read(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
@@ -218,14 +248,13 @@ static void bulk_read(struct kunit *test)
 
 	/* If using a cache the cache satisfied the read */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 
 	regmap_exit(map);
 }
 
 static void write_readonly(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -233,7 +262,6 @@ static void write_readonly(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 	config.writeable_reg = reg_5_false;
 
@@ -260,7 +288,6 @@ static void write_readonly(struct kunit *test)
 
 static void read_writeonly(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -268,7 +295,6 @@ static void read_writeonly(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.readable_reg = reg_5_false;
 
 	map = gen_regmap(test, &config, &data);
@@ -284,7 +310,7 @@ static void read_writeonly(struct kunit *test)
 	 * fail if we aren't using the flat cache.
 	 */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
-		if (t->type != REGCACHE_FLAT) {
+		if (config.cache_type != REGCACHE_FLAT) {
 			KUNIT_EXPECT_EQ(test, i != 5,
 					regmap_read(map, i, &val) == 0);
 		} else {
@@ -300,7 +326,6 @@ static void read_writeonly(struct kunit *test)
 
 static void reg_defaults(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -308,7 +333,6 @@ static void reg_defaults(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
 	map = gen_regmap(test, &config, &data);
@@ -323,12 +347,11 @@ static void reg_defaults(struct kunit *test)
 
 	/* The data should have been read from cache if there was one */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 }
 
 static void reg_defaults_read_dev(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -336,7 +359,6 @@ static void reg_defaults_read_dev(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults_raw = BLOCK_TEST_SIZE;
 
 	map = gen_regmap(test, &config, &data);
@@ -346,7 +368,7 @@ static void reg_defaults_read_dev(struct kunit *test)
 
 	/* We should have read the cache defaults back from the map */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
-		KUNIT_EXPECT_EQ(test, t->type != REGCACHE_NONE, data->read[i]);
+		KUNIT_EXPECT_EQ(test, config.cache_type != REGCACHE_NONE, data->read[i]);
 		data->read[i] = false;
 	}
 
@@ -357,12 +379,11 @@ static void reg_defaults_read_dev(struct kunit *test)
 
 	/* The data should have been read from cache if there was one */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 }
 
 static void register_patch(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -372,7 +393,6 @@ static void register_patch(struct kunit *test)
 
 	/* We need defaults so readback works */
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
 	map = gen_regmap(test, &config, &data);
@@ -414,7 +434,6 @@ static void register_patch(struct kunit *test)
 
 static void stride(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -422,7 +441,6 @@ static void stride(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.reg_stride = 2;
 	config.num_reg_defaults = BLOCK_TEST_SIZE / 2;
 
@@ -444,7 +462,7 @@ static void stride(struct kunit *test)
 		} else {
 			KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
 			KUNIT_EXPECT_EQ(test, data->vals[i], rval);
-			KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE,
+			KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE,
 					data->read[i]);
 
 			KUNIT_EXPECT_EQ(test, 0, regmap_write(map, i, rval));
@@ -488,7 +506,6 @@ static bool test_range_all_volatile(struct device *dev, unsigned int reg)
 
 static void basic_ranges(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -496,7 +513,6 @@ static void basic_ranges(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.volatile_reg = test_range_all_volatile;
 	config.ranges = &test_range;
 	config.num_ranges = 1;
@@ -560,7 +576,6 @@ static void basic_ranges(struct kunit *test)
 /* Try to stress dynamic creation of cache data structures */
 static void stress_insert(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -569,7 +584,6 @@ static void stress_insert(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.max_register = 300;
 
 	map = gen_regmap(test, &config, &data);
@@ -606,7 +620,7 @@ static void stress_insert(struct kunit *test)
 	for (i = 0; i < config.max_register; i ++) {
 		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval));
 		KUNIT_EXPECT_EQ(test, rval, vals[i]);
-		KUNIT_EXPECT_EQ(test, t->type == REGCACHE_NONE, data->read[i]);
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 	}
 
 	regmap_exit(map);
@@ -614,14 +628,12 @@ static void stress_insert(struct kunit *test)
 
 static void cache_bypass(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
 	unsigned int val, rval;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
@@ -652,7 +664,6 @@ static void cache_bypass(struct kunit *test)
 
 static void cache_sync(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -660,7 +671,6 @@ static void cache_sync(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
@@ -690,7 +700,6 @@ static void cache_sync(struct kunit *test)
 
 static void cache_sync_defaults(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -698,7 +707,6 @@ static void cache_sync_defaults(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
 	map = gen_regmap(test, &config, &data);
@@ -726,7 +734,6 @@ static void cache_sync_defaults(struct kunit *test)
 
 static void cache_sync_readonly(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -734,7 +741,6 @@ static void cache_sync_readonly(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.writeable_reg = reg_5_false;
 
 	map = gen_regmap(test, &config, &data);
@@ -767,7 +773,6 @@ static void cache_sync_readonly(struct kunit *test)
 
 static void cache_sync_patch(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -777,7 +782,6 @@ static void cache_sync_patch(struct kunit *test)
 
 	/* We need defaults so readback works */
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
 	map = gen_regmap(test, &config, &data);
@@ -828,7 +832,6 @@ static void cache_sync_patch(struct kunit *test)
 
 static void cache_drop(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -836,7 +839,6 @@ static void cache_drop(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.num_reg_defaults = BLOCK_TEST_SIZE;
 
 	map = gen_regmap(test, &config, &data);
@@ -870,7 +872,6 @@ static void cache_drop(struct kunit *test)
 
 static void cache_present(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -878,7 +879,6 @@ static void cache_present(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
@@ -910,7 +910,6 @@ static void cache_present(struct kunit *test)
 /* Check that caching the window register works with sync */
 static void cache_range_window_reg(struct kunit *test)
 {
-	struct regcache_types *t = (struct regcache_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -918,7 +917,6 @@ static void cache_range_window_reg(struct kunit *test)
 	int i;
 
 	config = test_regmap_config;
-	config.cache_type = t->type;
 	config.volatile_reg = test_range_window_volatile;
 	config.ranges = &test_range;
 	config.num_ranges = 1;
@@ -960,41 +958,29 @@ static void cache_range_window_reg(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, val, 2);
 }
 
-struct raw_test_types {
-	const char *name;
-
-	enum regcache_type cache_type;
-	enum regmap_endian val_endian;
+static const struct regmap_test_param raw_types_list[] = {
+	{ .cache = REGCACHE_NONE,   .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_NONE,   .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_MAPLE,  .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_MAPLE,  .val_endian = REGMAP_ENDIAN_BIG },
 };
 
-static void raw_to_desc(const struct raw_test_types *t, char *desc)
-{
-	strcpy(desc, t->name);
-}
+KUNIT_ARRAY_PARAM(raw_test_types, raw_types_list, param_to_desc);
 
-static const struct raw_test_types raw_types_list[] = {
-	{ "none-little",   REGCACHE_NONE,   REGMAP_ENDIAN_LITTLE },
-	{ "none-big",      REGCACHE_NONE,   REGMAP_ENDIAN_BIG },
-	{ "flat-little",   REGCACHE_FLAT,   REGMAP_ENDIAN_LITTLE },
-	{ "flat-big",      REGCACHE_FLAT,   REGMAP_ENDIAN_BIG },
-	{ "rbtree-little", REGCACHE_RBTREE, REGMAP_ENDIAN_LITTLE },
-	{ "rbtree-big",    REGCACHE_RBTREE, REGMAP_ENDIAN_BIG },
-	{ "maple-little",  REGCACHE_MAPLE,  REGMAP_ENDIAN_LITTLE },
-	{ "maple-big",     REGCACHE_MAPLE,  REGMAP_ENDIAN_BIG },
+static const struct regmap_test_param raw_cache_types_list[] = {
+	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_FLAT,   .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_RBTREE, .val_endian = REGMAP_ENDIAN_BIG },
+	{ .cache = REGCACHE_MAPLE,  .val_endian = REGMAP_ENDIAN_LITTLE },
+	{ .cache = REGCACHE_MAPLE,  .val_endian = REGMAP_ENDIAN_BIG },
 };
 
-KUNIT_ARRAY_PARAM(raw_test_types, raw_types_list, raw_to_desc);
-
-static const struct raw_test_types raw_cache_types_list[] = {
-	{ "flat-little",   REGCACHE_FLAT,   REGMAP_ENDIAN_LITTLE },
-	{ "flat-big",      REGCACHE_FLAT,   REGMAP_ENDIAN_BIG },
-	{ "rbtree-little", REGCACHE_RBTREE, REGMAP_ENDIAN_LITTLE },
-	{ "rbtree-big",    REGCACHE_RBTREE, REGMAP_ENDIAN_BIG },
-	{ "maple-little",  REGCACHE_MAPLE,  REGMAP_ENDIAN_LITTLE },
-	{ "maple-big",     REGCACHE_MAPLE,  REGMAP_ENDIAN_BIG },
-};
-
-KUNIT_ARRAY_PARAM(raw_test_cache_types, raw_cache_types_list, raw_to_desc);
+KUNIT_ARRAY_PARAM(raw_test_cache_types, raw_cache_types_list, param_to_desc);
 
 static const struct regmap_config raw_regmap_config = {
 	.max_register = BLOCK_TEST_SIZE,
@@ -1006,18 +992,18 @@ static const struct regmap_config raw_regmap_config = {
 
 static struct regmap *gen_raw_regmap(struct kunit *test,
 				     struct regmap_config *config,
-				     struct raw_test_types *test_type,
 				     struct regmap_ram_data **data)
 {
 	struct regmap_test_priv *priv = test->priv;
+	const struct regmap_test_param *param = test->param_value;
 	u16 *buf;
 	struct regmap *ret;
 	size_t size = (config->max_register + 1) * config->reg_bits / 8;
 	int i;
 	struct reg_default *defaults;
 
-	config->cache_type = test_type->cache_type;
-	config->val_format_endian = test_type->val_endian;
+	config->cache_type = param->cache;
+	config->val_format_endian = param->val_endian;
 	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
 					config->cache_type == REGCACHE_MAPLE;
 
@@ -1042,7 +1028,7 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 
 	for (i = 0; i < config->num_reg_defaults; i++) {
 		defaults[i].reg = i;
-		switch (test_type->val_endian) {
+		switch (param->val_endian) {
 		case REGMAP_ENDIAN_LITTLE:
 			defaults[i].def = le16_to_cpu(buf[i]);
 			break;
@@ -1072,7 +1058,6 @@ static struct regmap *gen_raw_regmap(struct kunit *test,
 
 static void raw_read_defaults_single(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1081,7 +1066,7 @@ static void raw_read_defaults_single(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1097,7 +1082,6 @@ static void raw_read_defaults_single(struct kunit *test)
 
 static void raw_read_defaults(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1108,7 +1092,7 @@ static void raw_read_defaults(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1136,7 +1120,6 @@ static void raw_read_defaults(struct kunit *test)
 
 static void raw_write_read_single(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1145,7 +1128,7 @@ static void raw_write_read_single(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1162,7 +1145,6 @@ static void raw_write_read_single(struct kunit *test)
 
 static void raw_write(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1173,7 +1155,7 @@ static void raw_write(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1224,7 +1206,6 @@ static bool ram_reg_zero(struct regmap_ram_data *data, unsigned int reg)
 
 static void raw_noinc_write(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1237,7 +1218,7 @@ static void raw_noinc_write(struct kunit *test)
 	config.writeable_noinc_reg = reg_zero;
 	config.readable_noinc_reg = reg_zero;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1274,7 +1255,6 @@ static void raw_noinc_write(struct kunit *test)
 
 static void raw_sync(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1285,7 +1265,7 @@ static void raw_sync(struct kunit *test)
 
 	config = raw_regmap_config;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
@@ -1352,7 +1332,6 @@ static void raw_sync(struct kunit *test)
 
 static void raw_ranges(struct kunit *test)
 {
-	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -1365,7 +1344,7 @@ static void raw_ranges(struct kunit *test)
 	config.num_ranges = 1;
 	config.max_register = test_range.range_max;
 
-	map = gen_raw_regmap(test, &config, t, &data);
+	map = gen_raw_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
-- 
2.39.2


