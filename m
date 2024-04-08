Return-Path: <linux-kernel+bounces-135544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6F89C75A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BA31C21E66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E628E13FD94;
	Mon,  8 Apr 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H74lTzvK"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C013F420
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587572; cv=none; b=JiwqlNcTBLpaRERptPAaZntvSlG7xpN5h9k6CIqLthlL69cqNR9p5os8MgJ+bpxqZelEMLqE2yecehPafu6xihLv2vzOMkirxA4w8xt4vsILgXcW2zsEr/bxRL9gPmecQeENKYUZBB6gw+axA1ztsrbTC0bTg0Gm89Iff7ZLV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587572; c=relaxed/simple;
	bh=GO1OoZGWDRTEwcFH8XTLGDXGIOV1ef3rocNaVIpdxhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8o0Gs+0b88/ZB3ZOw4JSCkAEa2hGxDJLB4bMPHyR/SHlVqer/w1gDy8BGVtSfFw1gFUEG7guN2QLqCbd9iQGg+fwDFxGpE9nRDi5No2YH2Ff5xddutkAT4kOq/+7C1jGUH5jJgmv6Wqdxgz9hdbDpe1y/o9PnpVrwSuvjmHL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H74lTzvK; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hvQo026412;
	Mon, 8 Apr 2024 09:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=0LY4PRZr8+qXm6jOmCuGT0UJIVWVwZ1VbCI2U4t5SsY=; b=
	H74lTzvK3ahkmbObbRg8nOkVOAztQWtcw2XWDRJOb7VM/BZqUd5409EKEDGNrU7i
	rksQZhfRtCpGazRmY4hIbS8nvTbPskxMSKAqwHPNnxej+2uFRUIIDCcLbMIdK8xT
	DGUII39ydErl7wmGk8GI+HkbjrJZieXUBsDog4+G8JEP1eLRscDnJ+zMyC5tHyat
	Fx6RiCVZaQ+2NY4qJGTCoM6hG0le1Qm6POV0ctJVZE8jOJ24A9JVlIrkE56ZA00K
	hUDgeDBQMU7Nlw2R1vDrLFezNdd8LMHZDnncx3q3/u/kbdfobyB1QT9HvZSp0nFN
	2/Q7O/uIBR765uHK74JYEg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp8-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:05 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BC0E082026B;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 06/11] regmap: kunit: Add more cache-drop tests
Date: Mon, 8 Apr 2024 15:45:55 +0100
Message-ID: <20240408144600.230848-7-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: oNtyoB8tJDkEET3ddTO-w9VcB-TQxlDY
X-Proofpoint-GUID: oNtyoB8tJDkEET3ddTO-w9VcB-TQxlDY
X-Proofpoint-Spam-Reason: safe

Extend the testing of cache-drop.

- Added cache_drop_all_and_sync_marked_dirty(). If all registers are
  dropped from the cache a regcache_mark_dirty() followed by
  regcache_sync() should not write anything because the cache is empty.

- Added cache_drop_all_and_sync_no_defaults(). This is similar to
  cache_drop_all_and_sync_marked_dirty() except that regcache_mark_dirty()
  is NOT called. All registers were dropped so regcache_sync() should not
  write anything.

- Added cache_drop_all_and_sync_has_defaults(). This is the same as
  cache_drop_all_and_sync_no_defaults() except that the regmap has a
  table of default values.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 135 +++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 873161b58de9..3201f5f6406b 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -920,6 +920,138 @@ static void cache_drop(struct kunit *test)
 	regmap_exit(map);
 }
 
+static void cache_drop_all_and_sync_marked_dirty(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval[BLOCK_TEST_SIZE];
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
+	/* Ensure the data is read from the cache */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->read[param->from_reg + i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, param->from_reg, rval,
+						  BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
+
+	/* Change all values in cache from defaults */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg + i, rval[i] + 1));
+
+	/* Drop all registers */
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, 0, config.max_register));
+
+	/* Mark dirty and cache sync should not write anything. */
+	regcache_mark_dirty(map);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+	for (i = 0; i <= config.max_register; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[i]);
+
+	regmap_exit(map);
+}
+
+static void cache_drop_all_and_sync_no_defaults(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Ensure the data is read from the cache */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->read[param->from_reg + i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, param->from_reg, rval,
+						  BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
+
+	/* Change all values in cache */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg + i, rval[i] + 1));
+
+	/* Drop all registers */
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, 0, config.max_register));
+
+	/*
+	 * Sync cache without marking it dirty. All registers were dropped
+	 * so the cache should not have any entries to write out.
+	 */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+	for (i = 0; i <= config.max_register; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[i]);
+
+	regmap_exit(map);
+}
+
+static void cache_drop_all_and_sync_has_defaults(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int rval[BLOCK_TEST_SIZE];
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
+	/* Ensure the data is read from the cache */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->read[param->from_reg + i] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_read(map, param->from_reg, rval,
+						  BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
+
+	/* Change all values in cache from defaults */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, param->from_reg + i, rval[i] + 1));
+
+	/* Drop all registers */
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, 0, config.max_register));
+
+	/*
+	 * Sync cache without marking it dirty. All registers were dropped
+	 * so the cache should not have any entries to write out.
+	 */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->written[param->from_reg + i] = false;
+
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+	for (i = 0; i <= config.max_register; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[i]);
+
+	regmap_exit(map);
+}
+
 static void cache_present(struct kunit *test)
 {
 	const struct regmap_test_param *param = test->param_value;
@@ -1463,6 +1595,9 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_sync_readonly, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_drop_all_and_sync_marked_dirty, sparse_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_drop_all_and_sync_no_defaults, sparse_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_drop_all_and_sync_has_defaults, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_present, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_range_window_reg, real_cache_types_only_gen_params),
 
-- 
2.39.2


