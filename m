Return-Path: <linux-kernel+bounces-135549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5D89C75C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE15E1C22420
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671CA1411DD;
	Mon,  8 Apr 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YdAtm19b"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DC13F443
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587573; cv=none; b=htesQEUyilAuAhDk2KYaWOH0sBmzP/3RU2APsxCX0vCEt7xPm0/l2RDq66iT1ctZcoYvqye3C9H8stdNPE5QGq94f0k0c5ZMBkp6P/kW1Ysc2+3sM4kwnlxqwi8kBrvOkCvKmqkL/bU457enznOzs0CC7nIfkzhnxMhPgbVBxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587573; c=relaxed/simple;
	bh=1tZf6ntL+ZBT5VbnOA4amHONxR7tyFNpQjcDjtHoN3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRaGYDN7GHDoJXEn+hStYhOIENUuR5GAkZIjMVFPfSz7MVEortIrYEb/NddUjWSRvUHRDvU+iTugkxqw0rBxFvdu9YCckAH058WC5HQabKg7S078BjxXAkZLhjVrRWYYre4MTsnplLCjn9ScJLbTJHEEszscJM+1hiqrcha5WZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YdAtm19b; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hvQq026412;
	Mon, 8 Apr 2024 09:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=O5fCzEJa1jx4fBDOGZmOfideFG5tZrN1thyOmxVVxFs=; b=
	YdAtm19biTeZDVywcJqveGuJXhv7tTGys2ByKOCiT/vBpYM92yXnQz2de2qTJHj1
	ry/8pMOX4hImFLhtSFH6t5KX9ZgdzX3BreGtvXOEyFBJcic60HcdByFw5GZ/kiCD
	mSlOwUDmVu6QwJmxeoyWt9vys/RDasBcrBHRjJQFUD35EQXtFH028EVHFEk5rdEC
	C/V+rQBP8NbCWoZvV+MsImWB3GF6dFbHbsTBJkUCH81B4qU/nx8N29QvujlqMlHa
	OoWuxNRQeYnrSawRMGS1wh09jCclbSs6eHgNexiU4LncQj23vZthFoC684MZ7B0D
	XMFe02DYq/bJnkcauRUbbg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp8-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:07 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DC2DC820273;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 11/11] regmap: kunit: Add test cases for regmap_read_bypassed()
Date: Mon, 8 Apr 2024 15:46:00 +0100
Message-ID: <20240408144600.230848-12-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: sDJSNYLX5NYFZ7OwIQWJN-ot2LaQAd2l
X-Proofpoint-GUID: sDJSNYLX5NYFZ7OwIQWJN-ot2LaQAd2l
X-Proofpoint-Spam-Reason: safe

This adds test cases to prove that regmap_read_bypassed() reads
the hardware value while the regmap is in cache-only.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
This depends on pending commit ("regmap: Add regmap_read_bypassed()")
https://lore.kernel.org/linux-sound/20240408101803.43183-1-rf@opensource.cirrus.com/T/#m2b99b1e01872bfc3597e89dee57dcdd5dbaf1b55
---
 drivers/base/regmap/regmap-kunit.c | 131 +++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 6e469609c82c..44265dc2313d 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -295,6 +295,135 @@ static void bulk_read(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 }
 
+static void read_bypassed(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[BLOCK_TEST_SIZE], rval;
+	int i;
+
+	config = test_regmap_config;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	KUNIT_EXPECT_FALSE(test, map->cache_bypass);
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Write some test values */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, param->from_reg, val, ARRAY_SIZE(val)));
+
+	regcache_cache_only(map, true);
+
+	/*
+	 * While in cache-only regmap_read_bypassed() should return the register
+	 * value and leave the map in cache-only.
+	 */
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		/* Put inverted bits in rval to prove we really read the value */
+		rval = ~val[i];
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg + i, &rval));
+		KUNIT_EXPECT_EQ(test, val[i], rval);
+
+		rval = ~val[i];
+		KUNIT_EXPECT_EQ(test, 0, regmap_read_bypassed(map, param->from_reg + i, &rval));
+		KUNIT_EXPECT_EQ(test, val[i], rval);
+		KUNIT_EXPECT_TRUE(test, map->cache_only);
+		KUNIT_EXPECT_FALSE(test, map->cache_bypass);
+	}
+
+	/*
+	 * Change the underlying register values to prove it is returning
+	 * real values not cached values.
+	 */
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		val[i] = ~val[i];
+		data->vals[param->from_reg + i] = val[i];
+	}
+
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		rval = ~val[i];
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, param->from_reg + i, &rval));
+		KUNIT_EXPECT_NE(test, val[i], rval);
+
+		rval = ~val[i];
+		KUNIT_EXPECT_EQ(test, 0, regmap_read_bypassed(map, param->from_reg + i, &rval));
+		KUNIT_EXPECT_EQ(test, val[i], rval);
+		KUNIT_EXPECT_TRUE(test, map->cache_only);
+		KUNIT_EXPECT_FALSE(test, map->cache_bypass);
+	}
+}
+
+static void read_bypassed_volatile(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val[BLOCK_TEST_SIZE], rval;
+	int i;
+
+	config = test_regmap_config;
+	/* All registers except #5 volatile */
+	config.volatile_reg = reg_5_false;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	KUNIT_EXPECT_FALSE(test, map->cache_bypass);
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Write some test values */
+	KUNIT_EXPECT_EQ(test, 0, regmap_bulk_write(map, param->from_reg, val, ARRAY_SIZE(val)));
+
+	regcache_cache_only(map, true);
+
+	/*
+	 * While in cache-only regmap_read_bypassed() should return the register
+	 * value and leave the map in cache-only.
+	 */
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		/* Register #5 is non-volatile so should read from cache */
+		KUNIT_EXPECT_EQ(test, (i == 5) ? 0 : -EBUSY,
+				regmap_read(map, param->from_reg + i, &rval));
+
+		/* Put inverted bits in rval to prove we really read the value */
+		rval = ~val[i];
+		KUNIT_EXPECT_EQ(test, 0, regmap_read_bypassed(map, param->from_reg + i, &rval));
+		KUNIT_EXPECT_EQ(test, val[i], rval);
+		KUNIT_EXPECT_TRUE(test, map->cache_only);
+		KUNIT_EXPECT_FALSE(test, map->cache_bypass);
+	}
+
+	/*
+	 * Change the underlying register values to prove it is returning
+	 * real values not cached values.
+	 */
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		val[i] = ~val[i];
+		data->vals[param->from_reg + i] = val[i];
+	}
+
+	for (i = 0; i < ARRAY_SIZE(val); i++) {
+		if (i == 5)
+			continue;
+
+		rval = ~val[i];
+		KUNIT_EXPECT_EQ(test, 0, regmap_read_bypassed(map, param->from_reg + i, &rval));
+		KUNIT_EXPECT_EQ(test, val[i], rval);
+		KUNIT_EXPECT_TRUE(test, map->cache_only);
+		KUNIT_EXPECT_FALSE(test, map->cache_bypass);
+	}
+}
+
 static void write_readonly(struct kunit *test)
 {
 	struct regmap *map;
@@ -1747,6 +1876,8 @@ static void raw_ranges(struct kunit *test)
 
 static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(read_bypassed, real_cache_types_gen_params),
+	KUNIT_CASE_PARAM(read_bypassed_volatile, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_read, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(write_readonly, regcache_types_gen_params),
-- 
2.39.2


