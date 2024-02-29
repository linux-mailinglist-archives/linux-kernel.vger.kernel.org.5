Return-Path: <linux-kernel+bounces-86989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235FB86CDF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5C7287BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254181428EC;
	Thu, 29 Feb 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcTG9dIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961A14127B;
	Thu, 29 Feb 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221813; cv=none; b=LU2jyxDoxTQY+MItfYCKjKLKcLlY0MRXlaFQDV+O9BU7FIlMvwpySQZ4kbe2eP6kPmGaNUaLx0tGt7TLv0z6i42rW6sSy8gnIUPoEnEkQRxZB9Ou5T73qLgUPSj2Lzswd7F7w1PPmgEskXddD3/tYDSlStzcNRfRR0QJQ4p+4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221813; c=relaxed/simple;
	bh=nFdvnctb3HwjwC3YYHCe4RQV74wIoxZXlt0S3wnnHOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxpnZMtiqf7jJ+gw/6wW1I08EsQGhNGqGJ3uHiMJXUQyQrN4co+eBNk6WxdECy2L2whI8l6R7winIzXpiuIaA9VPWSNgwhMWFj1W1632REo5VivHndr85W5ma9Xa1Gan/0awA8AfzuVkk1nMLsqkssZ6Wuav5KEtqjV16RA5ncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcTG9dIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8650C433F1;
	Thu, 29 Feb 2024 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221812;
	bh=nFdvnctb3HwjwC3YYHCe4RQV74wIoxZXlt0S3wnnHOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcTG9dIJE+0I5eofDC8mHfEnUvX7SvCfcg+m+EK//yqpek+2TyrsjtO1rjphnboiB
	 W/+2jQF2DGPjDll2zF2ZatFVOgwHPMm+xVd3wKoNfcTm/NtNFWkodw6jveza6MO4ci
	 EoiMbKFG2iDRpLj+8dV2KhIgtv2dHkQd3YvQgr5bNdFZuy9ceg+760YVuyxyFeiC6j
	 PmffonktBsNVkqR6XYCHiHE/fIAOVXaZLYmYE1SoDvtVZv/xgV5erGzDqSP312ir+Z
	 pVK7ylujEWQl/mg3R+4QgFOZ60i58kBGCw0gmXv/zbZhu5VjBxZEtfQw5h5ZOLRYT/
	 tcSXldQTax4AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.6 14/21] regmap: kunit: Ensure that changed bytes are actually different
Date: Thu, 29 Feb 2024 10:49:34 -0500
Message-ID: <20240229154946.2850012-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index 264d29b3fced0..5f1e914646cd9 100644
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
@@ -1131,7 +1148,7 @@ static void raw_sync(struct kunit *test)
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
-	u16 val[2];
+	u16 val[3];
 	u16 *hw_buf;
 	unsigned int rval;
 	int i;
@@ -1145,17 +1162,13 @@ static void raw_sync(struct kunit *test)
 
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
@@ -1164,24 +1177,34 @@ static void raw_sync(struct kunit *test)
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
@@ -1192,8 +1215,7 @@ static void raw_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* The values should now appear in the "hardware" */
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[6], val, sizeof(u16));
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], &val[0], sizeof(val));
 
 	regmap_exit(map);
 }
-- 
2.43.0


