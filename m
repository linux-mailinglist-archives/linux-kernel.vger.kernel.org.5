Return-Path: <linux-kernel+bounces-60871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89091850A64
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1673D1F22197
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C225C917;
	Sun, 11 Feb 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVkW+HLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51133F1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670740; cv=none; b=hNPA2MdV/NFCihXdvH7+sCjcTqd4/dQlwfd+wRB2RG6teqzMfP9iSfpAoA/vGV1f2RguicPFKGt0CKwt4yuJzXXuVbLYiu4iSbyBWj75PBqu/F4G20dYYKJcagU6oIcLvfCNHMemg6KaQdo5i8fm7R1fJ4HWw8RJe4SxveVUT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670740; c=relaxed/simple;
	bh=CvdWnuanRHybTGbAyqYC8Et7GWVMQNQsVjSWpoXGYXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LWhycXz5b+ltjgd9zH2spt9ubKWAHZDDN+NdOPmqXh+kwHANVHga5YtZPYGa6ydr/ePJjTfdHHyRAIGsw4b6VcVCSW2eG+MCF8XnkBnYo0Ciqq3UFOUXuf8WHyFMPqXVooyRFBPIrG/8UC7ahe6sIvtCfnCKW57RZQlLc3IW87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVkW+HLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96381C433F1;
	Sun, 11 Feb 2024 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707670739;
	bh=CvdWnuanRHybTGbAyqYC8Et7GWVMQNQsVjSWpoXGYXw=;
	h=From:Date:Subject:To:Cc:From;
	b=rVkW+HLGCbZckPNtgWWQoRTCxsWLjqxID7FAZTR9U4fBOkMpLF5kqiWpzPjV6TaSI
	 9vh6nD1N1NPqo0GpeFVT0fp8Vg24CWCaiL97Dqq8n1m7TyYL4xlFbC5l8ZHwTP0+5T
	 vfd7vgmcXm6Evh1rPua9uGNgTicn6f5xkL+Wp8KMIwHUPubJlqWkpqtplTz3tYPcdp
	 BbdbdUE94/LoI5T6eFT4Tf1/bHOnC4aiKTrxvQ05dqZalORX0Mf/KbFolwCWtQZ+Ne
	 nLQDqTOXFuOZq3Pm2OWh3PxWVjG+p/krdd9BFo0QRD+GxMmaIdUaWp5Ca2kSJWl3on
	 qFgZSwjWyPr8Q==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 11 Feb 2024 16:58:17 +0000
Subject: [PATCH v3] regmap: kunit: Ensure that changed bytes are actually
 different
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKj8yGUC/43NQQ7CIBCF4asY1mKAtlJceQ/jAsrYklpohko0T
 e8ubdy46/J/mXwzkwjoIJLLYSYIyUUXfI7ieCBNp30L1NncRDBRMsEURWgHPdL+5d1EUXsbBvq
 75LI2liujuKlIBkaEh3tv+O2eu3NxCvjZfiW+rrvYxCmn2gorz7KSVV1ce0APz1PAlqxuEvstk
 S0DTJelbESt+J+1LMsX6kywqREBAAA=
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4920; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CvdWnuanRHybTGbAyqYC8Et7GWVMQNQsVjSWpoXGYXw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlyPzQib9bZzUEjRFtl4E27XcYxbp7cluJ4SGub
 5UX7x4DrFqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcj80AAKCRAk1otyXVSH
 0MuvB/4ovKhYvKE8QXQBxAcTYzcWqhjlSDa3oGMICsehIvcMS1xP1i6U3Ii5mZqB3lQ4IuXFb2v
 Y2ZPrLm4NwSwn/AebDGZXKn3YICiJZKFdjxUc2TH15JBLrZiSbnKckJ9+XlRhYWTwguOqvkDLhf
 MO2TjxpCuUxMw81yNLfR/yE59b02Zysh0C93X8FNTNWCh7GBdijuIlAbOoZUmjV0CyX/eqbMP4T
 wdypK3KAE4rMCFY5Yiv1XZdyjPdGtSzkMquYl2JL4Otuea656G/P/g8xq9u/L5QgW9wCoFqIVY4
 M9AYxrqNYSxxF8+8v86vZoWrGDr30s+ITtkbXsQOyZ7e7Fme
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Use 3 separate test values rather than attempting to reuse one of them
  for raw and regular writes.
- Link to v2: https://lore.kernel.org/r/20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org

Changes in v2:
- Check the whole change in.
- Link to v1: https://lore.kernel.org/r/20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org
---
 drivers/base/regmap/regmap-kunit.c | 54 +++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 026bdcb45127..3da34ed1412a 100644
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
@@ -1251,7 +1268,7 @@ static void raw_sync(struct kunit *test)
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
-	u16 val[2];
+	u16 val[3];
 	u16 *hw_buf;
 	unsigned int rval;
 	int i;
@@ -1265,17 +1282,13 @@ static void raw_sync(struct kunit *test)
 
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
@@ -1284,24 +1297,34 @@ static void raw_sync(struct kunit *test)
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
@@ -1312,8 +1335,7 @@ static void raw_sync(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, regcache_sync(map));
 
 	/* The values should now appear in the "hardware" */
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[6], val, sizeof(u16));
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], &val[0], sizeof(val));
 
 	regmap_exit(map);
 }

---
base-commit: 3b201c9af7c0cad2e8311d96c0c1b399606c70fa
change-id: 20240209-regmap-kunit-random-change-178bd19b91b5

Best regards,
-- 
Mark Brown <broonie@kernel.org>


