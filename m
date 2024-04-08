Return-Path: <linux-kernel+bounces-135541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2889C756
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A78B25CC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485513F44B;
	Mon,  8 Apr 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SJ/MbSbM"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4613EFE3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587570; cv=none; b=VANd6xh0d0vnncSxHTf7v6xz8b9YqRfkC8XsIhi2NfkX5pm/I6qcRENr2ISBDBi77i5KFjbw8BfwCTsjs7h+pfbBe/DJI6spsrB8FANqySialur3wWl3EYidN5R0N5R2cjPPOAZnMtGhXDfj+0IPIdar2KrBLQuszl0Ixyxbi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587570; c=relaxed/simple;
	bh=KHlvJWsbeMu59kzQUhqgufoGLgCPogqNvZHlzzE3PHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHWd2XO44fMShDyfqmLa3Ylu9eeZ3KRUxuTc4rEDEA0pqRE5FgD3jCW1MH2jzyUHXqBxIgUq7EcbIfkvkalnjjhv+tjR8RajXDG5mU0mW8opp0kRqlXZQHavzqOncCicwbcu+rBTyR7nITDsS/HS9lIJF0t1ecss+7MliovaYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SJ/MbSbM; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hvQn026412;
	Mon, 8 Apr 2024 09:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=ztAgntGbfvSuq2sHS6V7+FZxdEZkOYXsd9acqSxg14g=; b=
	SJ/MbSbMKeDr8nYr66UzdEaO8Pz5WGtMb4qD9cZ4Eyd5LjHKFG4rJGyRSpAb3i71
	h/b/EFUPJ7HzvgYZ2m2TbdohDDekuEj7N1b7PsHHO+J8OEVe6DVt5HPsPpDqEH5j
	cUQeoZ+B1QZ76tut4U71lCE5XU+ANHE1UBIE/EZeEBL95JIteDff4H/oXVsDIFuI
	Xath78EM0zH30T3bAt0h9FaodPx7JqHQ3ejcuiHi7rkcJgX6CnBEtPpLogPFRMii
	XGJbTkJI3bYZMghQQKouvKRajF+m5hCFLe7R1vR9i30qPDfJo6tgtZyzwAjjImEG
	tTuAvz/peJ84KqJul5rQ7Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:04 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BE18582026C;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 07/11] regmap: kunit: Add more cache-sync tests
Date: Mon, 8 Apr 2024 15:45:56 +0100
Message-ID: <20240408144600.230848-8-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: rSIIfgjYbeRV6_BpDjYx3wj2xOzdvTp7
X-Proofpoint-GUID: rSIIfgjYbeRV6_BpDjYx3wj2xOzdvTp7
X-Proofpoint-Spam-Reason: safe

Extend the testing of cache-sync.

- cache_sync() renamed cache_sync_marked_dirty() for clarity of
  what conditions it is testing.

- cache_sync_defaults() renamed cache_sync_defaults_marked_dirty()
  for clarity. Added code to write the register back to its default
  value to check that a dirty sync doesn't write out the default value.

- Added cache_sync_after_cache_only(). Tests syncing the cache without
  calling regcache_mark_dirty(). A register written while in cache-only
  should be written out by regcache_sync().

- Added cache_sync_default_after_cache_only. This is similar to
  cache_sync_after_cache_only(), but the register is changed to its
  default value while in cache-only. Because regcache_mark_dirty() was
  NOT called, regacache_sync() should write out the register.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 126 ++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 3201f5f6406b..1b34f92b1aaf 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -706,7 +706,7 @@ static void cache_bypass(struct kunit *test)
 	regmap_exit(map);
 }
 
-static void cache_sync(struct kunit *test)
+static void cache_sync_marked_dirty(struct kunit *test)
 {
 	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
@@ -743,7 +743,58 @@ static void cache_sync(struct kunit *test)
 	regmap_exit(map);
 }
 
-static void cache_sync_defaults(struct kunit *test)
+static void cache_sync_after_cache_only(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[BLOCK_TEST_SIZE];
+	unsigned int val_mask;
+	int i;
+
+	config = test_regmap_config;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	val_mask = GENMASK(config.val_bits - 1, 0);
+	get_random_bytes(&val, sizeof(val));
+
+	/* Put some data into the cache */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, param->from_reg, val,
+						   BLOCK_TEST_SIZE));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+
+	/* Set cache-only and change the values */
+	regcache_cache_only(map, true);
+	for (i = 0; i < ARRAY_SIZE(val); ++i)
+		val[i] = ~val[i] & val_mask;
+
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, param->from_reg, val,
+						   BLOCK_TEST_SIZE));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[param->from_reg + i]);
+
+	KUNIT_EXPECT_MEMNEQ(test, &data->vals[param->from_reg], val, sizeof(val));
+
+	/* Exit cache-only and sync the cache without marking hardware registers dirty */
+	regcache_cache_only(map, false);
+
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* Did we just write the correct data out? */
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], val, sizeof(val));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_TRUE(test, data->written[param->from_reg + i]);
+
+	regmap_exit(map);
+}
+
+static void cache_sync_defaults_marked_dirty(struct kunit *test)
 {
 	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
@@ -775,6 +826,71 @@ static void cache_sync_defaults(struct kunit *test)
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
 		KUNIT_EXPECT_EQ(test, i == 2, data->written[param->from_reg + i]);
 
+	/* Rewrite registers back to their defaults */
+	for (i = 0; i < config.num_reg_defaults; ++i)
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, config.reg_defaults[i].reg,
+						      config.reg_defaults[i].def));
+
+	/*
+	 * Resync after regcache_mark_dirty() should not write out registers
+	 * that are at default value
+	 */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+	regcache_mark_dirty(map);
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[param->from_reg + i]);
+
+	regmap_exit(map);
+}
+
+static void cache_sync_default_after_cache_only(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int orig_val;
+	int i;
+
+	config = test_regmap_config;
+	config.num_reg_defaults = BLOCK_TEST_SIZE;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg + 2, &orig_val));
+
+	/* Enter cache-only and change the value of one register */
+	regcache_cache_only(map, true);
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg + 2, orig_val + 1));
+
+	/* Exit cache-only and resync, should write out the changed register */
+	regcache_cache_only(map, false);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* Was the register written out? */
+	KUNIT_EXPECT_TRUE(test, data->written[param->from_reg + 2]);
+	KUNIT_EXPECT_EQ(test, data->vals[param->from_reg + 2], orig_val + 1);
+
+	/* Enter cache-only and write register back to its default value */
+	regcache_cache_only(map, true);
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg + 2, orig_val));
+
+	/* Resync should write out the new value */
+	regcache_cache_only(map, false);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+	KUNIT_EXPECT_TRUE(test, data->written[param->from_reg + 2]);
+	KUNIT_EXPECT_EQ(test, data->vals[param->from_reg + 2], orig_val);
+
 	regmap_exit(map);
 }
 
@@ -1590,8 +1706,10 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_ranges, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(stress_insert, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_bypass, real_cache_types_gen_params),
-	KUNIT_CASE_PARAM(cache_sync, real_cache_types_gen_params),
-	KUNIT_CASE_PARAM(cache_sync_defaults, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_marked_dirty, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_after_cache_only, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_defaults_marked_dirty, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_sync_default_after_cache_only, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_readonly, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
-- 
2.39.2


