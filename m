Return-Path: <linux-kernel+bounces-135545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951DC89C759
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9581F2177B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB413FD92;
	Mon,  8 Apr 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mUiUIxyA"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0713F422
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587572; cv=none; b=R0ZpIh0DnTK9I6yZ7VdDxDnWkwhTE3mvYBeiPGuW/ummw2xuD6S5Ojv70qwqssE3lh9j28DzMEC/OxLLKGuxY9elutuWrW00YbyL3gxv6ulZN5DbtBfoTfSYZapDH02xlaCDMb+7giVmFSECIyaOjOsTg/R6I2mhOeEMu2vqacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587572; c=relaxed/simple;
	bh=eDvp6K11cMH7ZeRo86qAQ4f/YoRCcezmFzs6qkUyKl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uyk8inFwR19l1gB0Gc3hKCc6OnJKn4/L8EmnNLIszzz5q+z58AmtHTs3XHYvwso/VfWnBHvhRKP4D0Awkul7l2FnRhZ1lQBbvsf5hYB1bmLcChJXqMb85XNsdqDLa8EiQ8EYU/D0MVdw/U+Hto+cxfHQAXkrqGpefkXEk/VGLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mUiUIxyA; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlL6032409;
	Mon, 8 Apr 2024 09:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=IX8CS77Gqrx9rfQ9aGTQRO7O3rl9XIcbraG56WMDCrM=; b=
	mUiUIxyAY+hUkOPw8eozYg+3d2xpV86/pGhE+pD6tV8/9HIqa8e0HjG8yP0qLc14
	/KMgaYfnjH8gYsoxXdgNA4soQJr3U0zmgUr2GGibhI1djf9TbEsv9DAXk5RYK2iw
	WOljqNXVCrNx58idjJJumwlW0V7952Eo1/3GtJB3//QhbshYfwjyIo8HdDM4eJc1
	cs8t2FBpZlXhXjns+eLymNePNHNUFew7RsJxFupiXmbsB7uEDrmB/36xo0fLMRAW
	o8Aq99a3Kd/aoxJshTXtCZeU+HTdrrXKDciCZ4wlORZdk0RLtrYUgwzzERaZViwL
	CG3zWnikNGYSJZZkniOPpA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp7-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:08 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CF389820272;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 10/11] regmap: kunit: Add cache-drop test with multiple cache blocks
Date: Mon, 8 Apr 2024 15:45:59 +0100
Message-ID: <20240408144600.230848-11-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: 2OyrwQY9FVWEi1ck1gLJsdCFIygW8_GX
X-Proofpoint-GUID: 2OyrwQY9FVWEi1ck1gLJsdCFIygW8_GX
X-Proofpoint-Spam-Reason: safe

Add a test case for dropping only some cache blocks and leaving others
unchanged.

The regmap is divided into 8 register ranges, and only 4 of these are
written with values. This creates 4 non-contiguous ranges of registers
with cached values.

One whole range is then dropped, and part of another range. A cache
sync is then performed to check that the correct registers were written,
and the correct values were written to these registers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 103 +++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 4c29d2db4d20..6e469609c82c 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1007,6 +1007,108 @@ static void cache_drop(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, &data->vals[param->from_reg], rval, sizeof(rval));
 }
 
+static void cache_drop_with_non_contiguous_ranges(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[4][BLOCK_TEST_SIZE];
+	unsigned int reg;
+	const int num_ranges = ARRAY_SIZE(val) * 2;
+	int rangeidx, i;
+
+	static_assert(ARRAY_SIZE(val) == 4);
+
+	config = test_regmap_config;
+	config.max_register = param->from_reg + (num_ranges * BLOCK_TEST_SIZE);
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	for (i = 0; i < config.max_register + 1; i++)
+		data->written[i] = false;
+
+	/* Create non-contiguous cache blocks by writing every other range */
+	get_random_bytes(&val, sizeof(val));
+	for (rangeidx = 0; rangeidx < num_ranges; rangeidx += 2) {
+		reg = param->from_reg + (rangeidx * BLOCK_TEST_SIZE);
+		KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, reg,
+							   &val[rangeidx / 2],
+							   BLOCK_TEST_SIZE));
+		KUNIT_EXPECT_MEMEQ(test, &data->vals[reg],
+				   &val[rangeidx / 2], sizeof(val[rangeidx / 2]));
+	}
+
+	/* Check that odd ranges weren't written */
+	for (rangeidx = 1; rangeidx < num_ranges; rangeidx += 2) {
+		reg = param->from_reg + (rangeidx * BLOCK_TEST_SIZE);
+		for (i = 0; i < BLOCK_TEST_SIZE; i++)
+			KUNIT_EXPECT_FALSE(test, data->written[reg + i]);
+	}
+
+	/* Drop range 2 */
+	reg = param->from_reg + (2 * BLOCK_TEST_SIZE);
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, reg, reg + BLOCK_TEST_SIZE - 1));
+
+	/* Drop part of range 4 */
+	reg = param->from_reg + (4 * BLOCK_TEST_SIZE);
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, reg + 3, reg + 5));
+
+	/* Mark dirty and reset mock registers to 0 */
+	regcache_mark_dirty(map);
+	for (i = 0; i < config.max_register + 1; i++) {
+		data->vals[i] = 0;
+		data->written[i] = false;
+	}
+
+	/* The registers that were dropped from range 4 should now remain at 0 */
+	val[4 / 2][3] = 0;
+	val[4 / 2][4] = 0;
+	val[4 / 2][5] = 0;
+
+	/* Sync and check that the expected register ranges were written */
+	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
+
+	/* Check that odd ranges weren't written */
+	for (rangeidx = 1; rangeidx < num_ranges; rangeidx += 2) {
+		reg = param->from_reg + (rangeidx * BLOCK_TEST_SIZE);
+		for (i = 0; i < BLOCK_TEST_SIZE; i++)
+			KUNIT_EXPECT_FALSE(test, data->written[reg + i]);
+	}
+
+	/* Check that even ranges (except 2 and 4) were written */
+	for (rangeidx = 0; rangeidx < num_ranges; rangeidx += 2) {
+		if ((rangeidx == 2) || (rangeidx == 4))
+			continue;
+
+		reg = param->from_reg + (rangeidx * BLOCK_TEST_SIZE);
+		for (i = 0; i < BLOCK_TEST_SIZE; i++)
+			KUNIT_EXPECT_TRUE(test, data->written[reg + i]);
+
+		KUNIT_EXPECT_MEMEQ(test, &data->vals[reg],
+				   &val[rangeidx / 2], sizeof(val[rangeidx / 2]));
+	}
+
+	/* Check that range 2 wasn't written */
+	reg = param->from_reg + (2 * BLOCK_TEST_SIZE);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[reg + i]);
+
+	/* Check that range 4 was partially written */
+	reg = param->from_reg + (4 * BLOCK_TEST_SIZE);
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, data->written[reg + i], i < 3 || i > 5);
+
+	KUNIT_EXPECT_MEMEQ(test, &data->vals[reg], &val[4 / 2], sizeof(val[4 / 2]));
+
+	/* Nothing before param->from_reg should have been written */
+	for (i = 0; i < param->from_reg; i++)
+		KUNIT_EXPECT_FALSE(test, data->written[i]);
+}
+
 static void cache_drop_all_and_sync_marked_dirty(struct kunit *test)
 {
 	const struct regmap_test_param *param = test->param_value;
@@ -1663,6 +1765,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_sync_readonly, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_drop_with_non_contiguous_ranges, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop_all_and_sync_marked_dirty, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop_all_and_sync_no_defaults, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop_all_and_sync_has_defaults, sparse_cache_types_gen_params),
-- 
2.39.2


