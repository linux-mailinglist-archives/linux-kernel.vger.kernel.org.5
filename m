Return-Path: <linux-kernel+bounces-113621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E79888E16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D8D1C2A96E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A721422C2;
	Sun, 24 Mar 2024 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3llHeKA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABD76405;
	Sun, 24 Mar 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320455; cv=none; b=gTUuXvp6FDgQXOTh/XxELnNP88Ce1oHTKfSNGXTsD/egpGyxmjRbBTwWDwpkqy7Y340wQ6V1LPqzDSPCZMCSJH7mEM45i420gTW6Ze7X8oHgF+APSt+F4K2dghoeQzhIMDIkctIF5lkc+EtBnhBTo0EEQz4ih2TmsbEMt+9SXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320455; c=relaxed/simple;
	bh=NWmTVAKYq8v6gN3EBr0vzjfVCXygas9fWX9Hme0A/jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os4OHmIAMOs+5tCUwzRBw5y6kNR7xu6e1TajX9KZxFNXkToSZf+476WF6zgwq0Srs110d3dZYRSP0MIWhY6KTUeev9g2UPQQQtNbOkV5qbkYgwZHMTD5sQYOtHu1fcwvcDmJdj/CBUy0e9wYlyPHLoCirXgvoHjwFaJbc2KtQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3llHeKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A332C433C7;
	Sun, 24 Mar 2024 22:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320455;
	bh=NWmTVAKYq8v6gN3EBr0vzjfVCXygas9fWX9Hme0A/jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3llHeKAIQgk3pJ/hrngQYbbl2qJ5Wap//3TRQG05bN0v5Y80mDoLDHfPz1xOBIyd
	 nR3lYburjD2nYOtt/a8zVzfzOrtM4sqDfQhuMVvr0baMZ4BJq/aHQVw2IWhuX4j2Oi
	 /qKMh2fwOTKxn0OmbgeZVUh6jaJnzHcWCHNINvbeDJQHGU+GA9ou4mqHIjQdaufdU4
	 kz6UJ0dijB2fof61Gmz0kLyguDu0P429TrYq+JqwyJ1FacEsbYnOTsdoLxMudxBtlU
	 HDp5O+pdfU21h5gEjf9ISg7NwUyW0hXXwtFB5Nr+fryFKkR6PH+gxvJlt7krgKDApq
	 xBvx0myb0gxXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 014/713] regmap: kunit: Ensure that changed bytes are actually different
Date: Sun, 24 Mar 2024 18:35:40 -0400
Message-ID: <20240324224720.1345309-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 2f0dbb24f78a333433a2b875c0b76bf55c119cd4 ]

During the cache sync test we verify that values we expect to have been
written only to the cache do not appear in the hardware. This works most
of the time but since we randomly generate both the original and new values
there is a low probability that these values may actually be the same.
Wrap get_random_bytes() to ensure that the values are different, there
are other tests which should have similar verification that we actually
changed something.

While we're at it refactor the test to use three changed values rather
than attempting to use one of them twice, that just complicates checking
that our new values are actually new.

We use random generation to try to avoid data dependencies in the tests.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://msgid.link/r/20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 54 +++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index e14cc03a17f6c..4c9e38ead5c56 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -9,6 +9,23 @@
 
 #define BLOCK_TEST_SIZE 12
 
+static void get_changed_bytes(void *orig, void *new, size_t size)
+{
+	char *o = orig;
+	char *n = new;
+	int i;
+
+	get_random_bytes(new, size);
+
+	/*
+	 * This could be nicer and more efficient but we shouldn't
+	 * super care.
+	 */
+	for (i = 0; i < size; i++)
+		while (n[i] == o[i])
+			get_random_bytes(&n[i], 1);
+}
+
 static const struct regmap_config test_regmap_config = {
 	.max_register = BLOCK_TEST_SIZE,
 	.reg_stride = 1,
@@ -1192,7 +1209,7 @@ static void raw_sync(struct kunit *test)
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
-	u16 val[2];
+	u16 val[3];
 	u16 *hw_buf;
 	unsigned int rval;
 	int i;
@@ -1206,17 +1223,13 @@ static void raw_sync(struct kunit *test)
 
 	hw_buf = (u16 *)data->vals;
 
-	get_random_bytes(&val, sizeof(val));
+	get_changed_bytes(&hw_buf[2], &val[0], sizeof(val));
 
 	/* Do a regular write and a raw write in cache only mode */
 	regcache_cache_only(map, true);
-	KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val, sizeof(val)));
-	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
-		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 6,
-						      be16_to_cpu(val[0])));
-	else
-		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 6,
-						      le16_to_cpu(val[0])));
+	KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val,
+						  sizeof(u16) * 2));
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 4, val[2]));
 
 	/* We should read back the new values, and defaults for the rest */
 	for (i = 0; i < config.max_register + 1; i++) {
@@ -1225,24 +1238,34 @@ static void raw_sync(struct kunit *test)
 		switch (i) {
 		case 2:
 		case 3:
-		case 6:
 			if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
 				KUNIT_EXPECT_EQ(test, rval,
-						be16_to_cpu(val[i % 2]));
+						be16_to_cpu(val[i - 2]));
 			} else {
 				KUNIT_EXPECT_EQ(test, rval,
-						le16_to_cpu(val[i % 2]));
+						le16_to_cpu(val[i - 2]));
 			}
 			break;
+		case 4:
+			KUNIT_EXPECT_EQ(test, rval, val[i - 2]);
+			break;
 		default:
 			KUNIT_EXPECT_EQ(test, config.reg_defaults[i].def, rval);
 			break;
 		}
 	}
+
+	/*
+	 * The value written via _write() was translated by the core,
+	 * translate the original copy for comparison purposes.
+	 */
+	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
+		val[2] = cpu_to_be16(val[2]);
+	else
+		val[2] = cpu_to_le16(val[2]);
 	
 	/* The values should not appear in the "hardware" */
-	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], val, sizeof(val));
-	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[6], val, sizeof(u16));
+	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], &val[0], sizeof(val));
 
 	for (i = 0; i < config.max_register + 1; i++)
 		data->written[i] = false;
@@ -1253,8 +1276,7 @@ static void raw_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* The values should now appear in the "hardware" */
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[6], val, sizeof(u16));
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], &val[0], sizeof(val));
 
 	regmap_exit(map);
 }
-- 
2.43.0


