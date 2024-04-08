Return-Path: <linux-kernel+bounces-135542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6920289C757
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4011C21DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399D13F450;
	Mon,  8 Apr 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YtAtpVoQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8C13EFE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587570; cv=none; b=uTXq/1A/RK5uuw6DKa1svrKMXlYgqjDcv4CwnyzVOIVFfl0yudsqRigh8zL6fjnkVk2vwpRBe+TGbqsid0R7OCLvG74b6oSCYxq+u8wdGYVSBrV1DaFUJQcohCW4g2/3sMr0+tQ2/vgGQ1VYKTjiD7/jYU4ua1BhuDM3Skr51xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587570; c=relaxed/simple;
	bh=FM2gvVgm7RdhrzrYFYSBZ0ve0s4cFxkKJ15yIebtVMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZKn/sRdkjkwW4R397HWM1R5syycTKUyCyoLBKHy2nv/RyhFqre6mEgZOwtajjqdEKTeM0rABbKLdFnPyrhPbAIxSA1O6Gwd8FqOG9sSgzkVUTx+oCECAffcMInwJbYLYS+Odp0+9ltacvOuYDPB/QrsacZP0m64+XQToNwdUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YtAtpVoQ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlL2032409;
	Mon, 8 Apr 2024 09:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=zJj6P9Rx4Hs4xzBtc9SKUtoj1zh3064v3eFHWXurk+8=; b=
	YtAtpVoQ/Kaz45TJMys57oIg7u81roRqOqivYv7lvQE9X1oAoSSTi7xMCOvjVAGV
	f5q1HWctE5PhENkq0/YdGyhyzjCxAmPWjKWMVwkMmoI03O/sz1oB23Sq5emfoOUK
	kyLVsRQxBhuyQBNcC80oEtNeS0xC7W4FsunvuL0iI4qmKM54zvl8nM+r5C40W5ST
	zkMQCjUQ1JK3DajDNOvl2VlLnrMH9n4RqBB4jvpjLfoQ38EE38R2OXHTfXXAAyqP
	WgYxZ084hpGD/0Eabe5f1aFpBoC6W6PO8ZBpSoUgC8OTKFenfxRWYZDwHqNzRLEC
	AwJmObxWUlgkM5PMIj2UIw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:04 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B9E0F82025A;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 05/11] regmap: kunit: Run non-sparse cache tests at non-zero register addresses
Date: Mon, 8 Apr 2024 15:45:54 +0100
Message-ID: <20240408144600.230848-6-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: U9YWUhz0a7Q2Cf8aRX6I-aWCKUFk6Q6O
X-Proofpoint-GUID: U9YWUhz0a7Q2Cf8aRX6I-aWCKUFk6Q6O
X-Proofpoint-Spam-Reason: safe

Change the tests parameterized by real_cache_types_list[] to test at some
register addresses that are not 0.

The cache_range_window_reg() test has hardcoded address assumptions that
are not present in any other tests using real_cache_types_list[] table. So
it has been given a separate parameter table, real_cache_types_only_list[],
that preserves the original parameterization.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 86 ++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index ae147fc8509b..873161b58de9 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -92,12 +92,32 @@ static const struct regmap_test_param regcache_types_list[] = {
 
 KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, param_to_desc);
 
-static const struct regmap_test_param real_cache_types_list[] = {
+static const struct regmap_test_param real_cache_types_only_list[] = {
 	{ .cache = REGCACHE_FLAT },
 	{ .cache = REGCACHE_RBTREE },
 	{ .cache = REGCACHE_MAPLE },
 };
 
+KUNIT_ARRAY_PARAM(real_cache_types_only, real_cache_types_only_list, param_to_desc);
+
+static const struct regmap_test_param real_cache_types_list[] = {
+	{ .cache = REGCACHE_FLAT,   .from_reg = 0 },
+	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2001 },
+	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2002 },
+	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2003 },
+	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2004 },
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
+};
+
 KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, param_to_desc);
 
 static const struct regmap_test_param sparse_cache_types_list[] = {
@@ -175,9 +195,12 @@ static struct regmap *gen_regmap(struct kunit *test,
 	return ret;
 }
 
-static bool reg_5_false(struct device *context, unsigned int reg)
+static bool reg_5_false(struct device *dev, unsigned int reg)
 {
-	return reg != 5;
+	struct kunit *test = dev_get_drvdata(dev);
+	const struct regmap_test_param *param = test->param_value;
+
+	return reg != (param->from_reg + 5);
 }
 
 static void basic_read_write(struct kunit *test)
@@ -648,6 +671,7 @@ static void stress_insert(struct kunit *test)
 
 static void cache_bypass(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -663,20 +687,20 @@ static void cache_bypass(struct kunit *test)
 	get_random_bytes(&val, sizeof(val));
 
 	/* Ensure the cache has a value in it */
-	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val));
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg, val));
 
 	/* Bypass then write a different value */
 	regcache_cache_bypass(map, true);
-	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, val + 1));
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg, val + 1));
 
 	/* Read the bypassed value */
-	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg, &rval));
 	KUNIT_EXPECT_EQ(test, val + 1, rval);
-	KUNIT_EXPECT_EQ(test, data->vals[0], rval);
+	KUNIT_EXPECT_EQ(test, data->vals[param->from_reg], rval);
 
 	/* Disable bypass, the cache should still return the original value */
 	regcache_cache_bypass(map, false);
-	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg, &rval));
 	KUNIT_EXPECT_EQ(test, val, rval);
 
 	regmap_exit(map);
@@ -684,6 +708,7 @@ static void cache_bypass(struct kunit *test)
 
 static void cache_sync(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -700,10 +725,10 @@ static void cache_sync(struct kunit *test)
 	get_random_bytes(&val, sizeof(val));
 
 	/* Put some data into the cache */
-	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, 0, val,
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, param->from_reg, val,
 						   BLOCK_TEST_SIZE));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		data->written[i] = false;
+		data->written[param->from_reg + i] = false;
 
 	/* Trash the data on the device itself then resync */
 	regcache_mark_dirty(map);
@@ -711,15 +736,16 @@ static void cache_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* Did we just write the correct data out? */
-	KUNIT_EXPECT_MEMEQ(test, data->vals, val, sizeof(val));
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], val, sizeof(val));
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, true, data->written[i]);
+		KUNIT_EXPECT_EQ(test, true, data->written[param->from_reg + i]);
 
 	regmap_exit(map);
 }
 
 static void cache_sync_defaults(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -737,23 +763,24 @@ static void cache_sync_defaults(struct kunit *test)
 	get_random_bytes(&val, sizeof(val));
 
 	/* Change the value of one register */
-	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 2, val));
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg + 2, val));
 
 	/* Resync */
 	regcache_mark_dirty(map);
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		data->written[i] = false;
+		data->written[param->from_reg + i] = false;
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* Did we just sync the one register we touched? */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, i == 2, data->written[i]);
+		KUNIT_EXPECT_EQ(test, i == 2, data->written[param->from_reg + i]);
 
 	regmap_exit(map);
 }
 
 static void cache_sync_readonly(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -770,29 +797,30 @@ static void cache_sync_readonly(struct kunit *test)
 
 	/* Read all registers to fill the cache */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &val));
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg + i, &val));
 
 	/* Change the value of all registers, readonly should fail */
 	get_random_bytes(&val, sizeof(val));
 	regcache_cache_only(map, true);
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, i != 5, regmap_write(map, i, val) == 0);
+		KUNIT_EXPECT_EQ(test, i != 5, regmap_write(map, param->from_reg + i, val) == 0);
 	regcache_cache_only(map, false);
 
 	/* Resync */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		data->written[i] = false;
+		data->written[param->from_reg + i] = false;
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* Did that match what we see on the device? */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		KUNIT_EXPECT_EQ(test, i != 5, data->written[i]);
+		KUNIT_EXPECT_EQ(test, i != 5, data->written[param->from_reg + i]);
 
 	regmap_exit(map);
 }
 
 static void cache_sync_patch(struct kunit *test)
 {
+	const struct regmap_test_param *param = test->param_value;
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
@@ -810,14 +838,14 @@ static void cache_sync_patch(struct kunit *test)
 		return;
 
 	/* Stash the original values */
-	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, 0, rval,
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, param->from_reg, rval,
 						  BLOCK_TEST_SIZE));
 
 	/* Patch a couple of values */
-	patch[0].reg = 2;
+	patch[0].reg = param->from_reg + 2;
 	patch[0].def = rval[2] + 1;
 	patch[0].delay_us = 0;
-	patch[1].reg = 5;
+	patch[1].reg = param->from_reg + 5;
 	patch[1].def = rval[5] + 1;
 	patch[1].delay_us = 0;
 	KUNIT_EXPECT_EQ(test, 0, regmap_register_patch(map, patch,
@@ -826,23 +854,23 @@ static void cache_sync_patch(struct kunit *test)
 	/* Sync the cache */
 	regcache_mark_dirty(map);
 	for (i = 0; i < BLOCK_TEST_SIZE; i++)
-		data->written[i] = false;
+		data->written[param->from_reg + i] = false;
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* The patch should be on the device but not in the cache */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
-		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &val));
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg + i, &val));
 		KUNIT_EXPECT_EQ(test, val, rval[i]);
 
 		switch (i) {
 		case 2:
 		case 5:
-			KUNIT_EXPECT_EQ(test, true, data->written[i]);
-			KUNIT_EXPECT_EQ(test, data->vals[i], rval[i] + 1);
+			KUNIT_EXPECT_EQ(test, true, data->written[param->from_reg + i]);
+			KUNIT_EXPECT_EQ(test, data->vals[param->from_reg + i], rval[i] + 1);
 			break;
 		default:
-			KUNIT_EXPECT_EQ(test, false, data->written[i]);
-			KUNIT_EXPECT_EQ(test, data->vals[i], rval[i]);
+			KUNIT_EXPECT_EQ(test, false, data->written[param->from_reg + i]);
+			KUNIT_EXPECT_EQ(test, data->vals[param->from_reg + i], rval[i]);
 			break;
 		}
 	}
@@ -1436,7 +1464,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_present, sparse_cache_types_gen_params),
-	KUNIT_CASE_PARAM(cache_range_window_reg, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_range_window_reg, real_cache_types_only_gen_params),
 
 	KUNIT_CASE_PARAM(raw_read_defaults_single, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_read_defaults, raw_test_types_gen_params),
-- 
2.39.2


