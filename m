Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAB7D3D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjJWRTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjJWRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:19:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1044127
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:19:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651BC433C9;
        Mon, 23 Oct 2023 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081572;
        bh=YarUf8JzH0m+8mKuF6IeA2TX1qmsI708HiQom93t2rU=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=GGSZq4RRNeBJvKTvHVRhPVxF3jXXDni+TTHmjaGG4HMh2JZdW0qgW7eANwwXk/1BE
         dNE73OOqwbuxP5zb6HWd2x2nMJtkV3aOYtcEwPzfaK7jgD1oJhim8Iq15b63KM+Ioc
         Y4k9MAoeB4oSrr2HszEVhuDO1lH8F4GrRsxjfQPhIOHQ048QQRHjfidsq+QREE614F
         Onlq/D2Xot1tqs2BoC+ZjeeyjBfdrgRuaFOENyDsw+qdFNqLJZ4lkO2UiCocVrcq6T
         SqytOQDAZ1Biy+XPcPvwIE2jhipO1PU7NNJn3oCAtPPNy6p0VA4KlyObj04bO2zKJv
         wypHHvxtjbUWg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 18:19:12 +0100
Subject: [PATCH 2/2] regmap: kunit: Add test for cache sync interaction
 with ranges
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-regmap-test-window-cache-v1-2-d8a71f441968@kernel.org>
References: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
In-Reply-To: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4364; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YarUf8JzH0m+8mKuF6IeA2TX1qmsI708HiQom93t2rU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNqsgK2ogdGdNOn6zokqRT1/357Pz0JXLVyxY738w
 JcO4oUyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTarIAAKCRAk1otyXVSH0B0ZB/
 94+ibWn53TrlVouSAixdyi2I5P/7OGPof95e0tKEPFQWb2winnV4119TAO99Gb7pEfMgqn6EOMxBuN
 1+HS38296dpceaODMJ6azbJKtbEvUQmsQrKkFQ8Oue6qZPCn6FbwAGStITpH9LE+CCho1fyFssIGtB
 GS9mUxNFRLvpRBpCZlvopkkNAsVrqEvOWqrAnSiWk2QuVHyJcGifpbJySltp7nhGKk0mJS+1rVDOA7
 E/SW+VrhG7fOWhquP3TrG2irCekdc5+Y6XDSQklSUmVXbmFkc1FCnjohUd+Zl86x9RLxLLsjkZYOCr
 NVlu7RGJRShF1kiiItC1+xZCUkMYlU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hector Martin reports that since when doing a cache sync we enable cache
bypass if the selector register for a range is cached then we might leave
the physical selector register pointing to a different value to that which
we have in the cache. If we then try to write to the page that our cache
tells us is selected we will not update the selector register and write to
the wrong page. Add a test case covering this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index f79fd5ec187e..e14cc03a17f6 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -442,12 +442,20 @@ static struct regmap_range_cfg test_range = {
 	.range_max = 40,
 };
 
-static bool test_range_volatile(struct device *dev, unsigned int reg)
+static bool test_range_window_volatile(struct device *dev, unsigned int reg)
 {
 	if (reg >= test_range.window_start &&
 	    reg <= test_range.window_start + test_range.window_len)
 		return true;
 
+	return false;
+}
+
+static bool test_range_all_volatile(struct device *dev, unsigned int reg)
+{
+	if (test_range_window_volatile(dev, reg))
+		return true;
+
 	if (reg >= test_range.range_min && reg <= test_range.range_max)
 		return true;
 
@@ -465,7 +473,7 @@ static void basic_ranges(struct kunit *test)
 
 	config = test_regmap_config;
 	config.cache_type = t->type;
-	config.volatile_reg = test_range_volatile;
+	config.volatile_reg = test_range_all_volatile;
 	config.ranges = &test_range;
 	config.num_ranges = 1;
 	config.max_register = test_range.range_max;
@@ -875,6 +883,59 @@ static void cache_present(struct kunit *test)
 	regmap_exit(map);
 }
 
+/* Check that caching the window register works with sync */
+static void cache_range_window_reg(struct kunit *test)
+{
+	struct regcache_types *t = (struct regcache_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val;
+	int i;
+
+	config = test_regmap_config;
+	config.cache_type = t->type;
+	config.volatile_reg = test_range_window_volatile;
+	config.ranges = &test_range;
+	config.num_ranges = 1;
+	config.max_register = test_range.range_max;
+
+	map = gen_regmap(&config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Write new values to the entire range */
+	for (i = test_range.range_min; i <= test_range.range_max; i++)
+		KUNIT_ASSERT_EQ(test, 0, regmap_write(map, i, 0));
+
+	val = data->vals[test_range.selector_reg] & test_range.selector_mask;
+	KUNIT_ASSERT_EQ(test, val, 2);
+
+	/* Write to the first register in the range to reset the page */
+	KUNIT_ASSERT_EQ(test, 0, regmap_write(map, test_range.range_min, 0));
+	val = data->vals[test_range.selector_reg] & test_range.selector_mask;
+	KUNIT_ASSERT_EQ(test, val, 0);
+
+	/* Trigger a cache sync */
+	regcache_mark_dirty(map);
+	KUNIT_ASSERT_EQ(test, 0, regcache_sync(map));
+
+	/* Write to the first register again, the page should be reset */
+	KUNIT_ASSERT_EQ(test, 0, regmap_write(map, test_range.range_min, 0));
+	val = data->vals[test_range.selector_reg] & test_range.selector_mask;
+	KUNIT_ASSERT_EQ(test, val, 0);
+
+	/* Trigger another cache sync */
+	regcache_mark_dirty(map);
+	KUNIT_ASSERT_EQ(test, 0, regcache_sync(map));
+
+	/* Write to the last register again, the page should be reset */
+	KUNIT_ASSERT_EQ(test, 0, regmap_write(map, test_range.range_max, 0));
+	val = data->vals[test_range.selector_reg] & test_range.selector_mask;
+	KUNIT_ASSERT_EQ(test, val, 2);
+}
+
 struct raw_test_types {
 	const char *name;
 
@@ -1217,6 +1278,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_sync_patch, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_present, sparse_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_range_window_reg, real_cache_types_gen_params),
 
 	KUNIT_CASE_PARAM(raw_read_defaults_single, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_read_defaults, raw_test_types_gen_params),

-- 
2.30.2

