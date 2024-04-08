Return-Path: <linux-kernel+bounces-135548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF67489C75E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22433B26972
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799681411E4;
	Mon,  8 Apr 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cKy1kiZf"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238C13F43E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587573; cv=none; b=ZYu0cLLO5I1I93fx5uk/beYMEorh4k7qSf7itfWE4NBWT+gVLNktTKIQfTBSgVaTVPwDhIouhgkkRLA+DaBt546PjD3y4LYcQOwd2cmroyXcLJcfLH9T3TZLSui81dQVCFLbobOfvll9qvJ13Bh2bZ95fGyO7Rj4c8ch4KgrKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587573; c=relaxed/simple;
	bh=COZHVF2HGyQQYVJGe7MkMo7N1Abu2Fm088yJ84SwZhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9K4D/INIg6ozXLH9p6u7HXaF8QjOkkFXxI/sZ7FjR69qC1p0i2cWdTAIK4MDFyH4m3yuB3m4qIFKTZX2tfwUd8WIHGdH3lEXZyz+PLFZqlJ4qVqs0Dc2LO6c4LVMjRgpFWy16mzDg1ron55TndB+f8DOFil3I/SkfKhxxmvjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cKy1kiZf; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hvQp026412;
	Mon, 8 Apr 2024 09:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=JUi1w4/+xFgNZjiUW1asMxbA8ooC2n7RN58GfWZQbG4=; b=
	cKy1kiZf3S8FpdyGYPRG11OexniJmowkIS3gkuBZodMP/Pzou5PHKDqFo+cfZcNy
	A1j82FTnxuNj1uXrjnANssRODx+4egfe7SEypfB/RZDBpTuXbmTOek4YAPi9hraE
	3Mu72qwmWskNRCkWFladcuUNY/tLOis8cq6AHB9lNoC5VFTvIFSBkjw8mtYdKV1U
	XPPxsOqYu0/txtWWI5bBY4PnR14NuUeEN/Mn/QGlPBmWs+J6+/qOLYy7XIVGqs+e
	ofmxlOEJx7mrr/e3TLaXgWGLWXbpoFBXWstEd9BTEzLA7/CCnhWd3cFp6HyOHr1i
	ER7I+0q4l4yRm6arkkbjsA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp8-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B7D21820259;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 04/11] regmap: kunit: Run sparse cache tests at non-zero register addresses
Date: Mon, 8 Apr 2024 15:45:53 +0100
Message-ID: <20240408144600.230848-5-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: SK9BTxTVQ8APNOKFdF3VLeqdJHh-4IWV
X-Proofpoint-GUID: SK9BTxTVQ8APNOKFdF3VLeqdJHh-4IWV
X-Proofpoint-Spam-Reason: safe

Run the cache_drop() and cache_present() tests at blocks of addresses
that don't start at zero.

This adds a from_reg parameter to struct regmap_test_param. This is
used to set the base address of the register defaults created by
gen_regmap().

Extra entries are added to sparse_cache_types_list[] to test at non-zero
from_reg values. The cache_drop() and cache_present() tests are updated
to test at the given offset.

The aim here is to add test cases to cache_drop() for the bug fixed by
commit 00bb549d7d63 ("regmap: maple: Fix cache corruption in
regcache_maple_drop()")

But the same parameter table is used by the cache_present() test so
let's also update that to use from_reg.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 67 ++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 2029135f68fb..ae147fc8509b 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -17,6 +17,8 @@ struct regmap_test_priv {
 struct regmap_test_param {
 	enum regcache_type cache;
 	enum regmap_endian val_endian;
+
+	unsigned int from_reg;
 };
 
 static void get_changed_bytes(void *orig, void *new, size_t size)
@@ -37,7 +39,6 @@ static void get_changed_bytes(void *orig, void *new, size_t size)
 }
 
 static const struct regmap_config test_regmap_config = {
-	.max_register = BLOCK_TEST_SIZE,
 	.reg_stride = 1,
 	.val_bits = sizeof(unsigned int) * 8,
 };
@@ -76,9 +77,10 @@ static const char *regmap_endian_name(enum regmap_endian endian)
 
 static void param_to_desc(const struct regmap_test_param *param, char *desc)
 {
-	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s-%s",
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s-%s @%#x",
 		 regcache_type_name(param->cache),
-		 regmap_endian_name(param->val_endian));
+		 regmap_endian_name(param->val_endian),
+		 param->from_reg);
 }
 
 static const struct regmap_test_param regcache_types_list[] = {
@@ -99,8 +101,16 @@ static const struct regmap_test_param real_cache_types_list[] = {
 KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, param_to_desc);
 
 static const struct regmap_test_param sparse_cache_types_list[] = {
-	{ .cache = REGCACHE_RBTREE },
-	{ .cache = REGCACHE_MAPLE },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2001 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2002 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2003 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2004 },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0 },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2001 },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2002 },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2003 },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2004 },
 };
 
 KUNIT_ARRAY_PARAM(sparse_cache_types, sparse_cache_types_list, param_to_desc);
@@ -113,7 +123,7 @@ static struct regmap *gen_regmap(struct kunit *test,
 	struct regmap_test_priv *priv = test->priv;
 	unsigned int *buf;
 	struct regmap *ret;
-	size_t size = (config->max_register + 1) * sizeof(unsigned int);
+	size_t size;
 	int i;
 	struct reg_default *defaults;
 
@@ -121,6 +131,16 @@ static struct regmap *gen_regmap(struct kunit *test,
 	config->disable_locking = config->cache_type == REGCACHE_RBTREE ||
 					config->cache_type == REGCACHE_MAPLE;
 
+	if (config->max_register == 0) {
+		config->max_register = param->from_reg;
+		if (config->num_reg_defaults)
+			config->max_register += (config->num_reg_defaults - 1) *
+						config->reg_stride;
+		else
+			config->max_register += (BLOCK_TEST_SIZE * config->reg_stride);
+	}
+
+	size = (config->max_register + 1) * sizeof(unsigned int);
 	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
@@ -141,8 +161,8 @@ static struct regmap *gen_regmap(struct kunit *test,
 		config->reg_defaults = defaults;
 
 		for (i = 0; i < config->num_reg_defaults; i++) {
-			defaults[i].reg = i * config->reg_stride;
-			defaults[i].def = buf[i * config->reg_stride];
+			defaults[i].reg = param->from_reg + (i * config->reg_stride);
+			defaults[i].def = buf[param->from_reg + (i * config->reg_stride)];
 		}
 	}
 
@@ -832,6 +852,7 @@ static void cache_sync_patch(struct kunit *test)
 
 static void cache_drop(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -848,30 +869,32 @@ static void cache_drop(struct kunit *test)
 
 	/* Ensure the data is read from the cache */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		data->read[i] = false;
-	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+		data->read[param->from_reg + i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, param->from_reg, rval,
 						  BLOCK_TEST_SIZE));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
-		KUNIT_EXPECT_FALSE(test, data->read[i]);
-		data->read[i] = false;
+		KUNIT_EXPECT_FALSE(test, data->read[param->from_reg + i]);
+		data->read[param->from_reg + i] = false;
 	}
-	KUNIT_EXPECT_MEMEQ(test, data->vals, rval, sizeof(rval));
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
 
 	/* Drop some registers */
-	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, 3, 5));
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, param->from_reg + 3,
+						      param->from_reg + 5));
 
 	/* Reread and check only the dropped registers hit the device. */
-	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, param->from_reg, rval,
 						  BLOCK_TEST_SIZE));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, data->read[i], i >= 3 && i <= 5);
-	KUNIT_EXPECT_MEMEQ(test, data->vals, rval, sizeof(rval));
+		KUNIT_EXPECT_EQ(test, data->read[param->from_reg + i], i >= 3 && i <= 5);
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
 
 	regmap_exit(map);
 }
 
 static void cache_present(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -886,23 +909,23 @@ static void cache_present(struct kunit *test)
 		return;
 
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		data->read[i] = false;
+		data->read[param->from_reg + i] = false;
 
 	/* No defaults so no registers cached. */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_ASSERT_FALSE(test, regcache_reg_cached(map, i));
+		KUNIT_ASSERT_FALSE(test, regcache_reg_cached(map, param->from_reg + i));
 
 	/* We didn't trigger any reads */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_ASSERT_FALSE(test, data->read[i]);
+		KUNIT_ASSERT_FALSE(test, data->read[param->from_reg + i]);
 
 	/* Fill the cache */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &val));
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg + i, &val));
 
 	/* Now everything should be cached */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_ASSERT_TRUE(test, regcache_reg_cached(map, i));
+		KUNIT_ASSERT_TRUE(test, regcache_reg_cached(map, param->from_reg + i));
 
 	regmap_exit(map);
 }
-- 
2.39.2


