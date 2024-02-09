Return-Path: <linux-kernel+bounces-60036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 013AD84FEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B541F24CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D018623;
	Fri,  9 Feb 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmngzNo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9F17570
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514425; cv=none; b=caDmXuC+4/EzRfqzfS3NMUSGPrPCL7ZHUC5hyWqR6XQ3z4Roaslen3JBTeSHs3piUW+rIHduzXBQ6I+hGykF3klW0GXyjVAvNl7J6yy8dzA8fG+hAsSCOGkJkmJUBaf9McjhWE0bWZ+ztdKGXJtbt6gV81o5dpy5xTGmYl5UCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514425; c=relaxed/simple;
	bh=NlXZqaKkhXz9tvOQze70I37khCbmxb0wOBoeUVbkFGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jzR1ifCoNfag4iZ6rdic/4tP7kaP4yUQbZixz6Gff+2pPRTIwXTBpXkDtxYDTw4fs4cxQtmCwcTAjBDnN9IPK8DiXB0FjbhB6AqGjvO9qR4BASq9uoyAyoY0j1VzRsCo86obuQ+hefPwZ+UYUzGwcWZcLWIuPugtP455YHE0do0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmngzNo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6305EC433F1;
	Fri,  9 Feb 2024 21:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707514425;
	bh=NlXZqaKkhXz9tvOQze70I37khCbmxb0wOBoeUVbkFGg=;
	h=From:Date:Subject:To:Cc:From;
	b=TmngzNo5wZ0QZDN0n0nxZJxYGyzo/jKf5h8tldRMwbGfxdmkSC9X+xQUKX6pZ/Hrb
	 /ftlLUDFasxuXWh2bGRnoylXNChFGQW4uAobEry6p89vZhzVTlXEpEIqQriKsf/lAn
	 Uphv+vDe3v9mmuzZ4pqqrjjnqqwm6nyKze1dKAkJR3ZnjY7jNp6rZCBqotXWus52Fo
	 h2+Q9YJIw/I8eflcAHUxxiKZbvXCEwU/jq73+beJ27soc/RYKSvhTRtxY2WwMzyIJg
	 HRqYlELVoEU+gwVEgzYD2Co/H9oht+zRx+Kwr797+8lPHK1cgulM35l12OvkfMHinp
	 AbH9rR6PEx5yQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Feb 2024 21:33:32 +0000
Subject: [PATCH v2] regmap: kunit: Ensure that changed bytes are actually
 different
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regmap-kunit-random-change-v2-1-be0a447c2891@kernel.org>
X-B4-Tracking: v=1; b=H4sIACuaxmUC/42NQQ6CMBBFr0Jm7RhaxYIr72FYFDvCBGnJFImGc
 Hcr8QAu38vP+wtEEqYI52wBoZkjB59A7zK4dda3hOwSg871Mdd5hULtYEfsn54nFOtdGPC3VKZ
 snKqaSjUFpMAodOfXFr/WiTuOU5D39jWrr/0rOytUaJ125mQKU5SHS0/i6bEP0kK9rusHxJhiY
 cUAAAA=
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3554; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NlXZqaKkhXz9tvOQze70I37khCbmxb0wOBoeUVbkFGg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxpo37uV6HyHhh/cFp4ovSyuJmtbJ47ESPT3PZ
 mP6lnnd7dmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcaaNwAKCRAk1otyXVSH
 0O9OB/9TOf/Dgma/o0au9mrFdZIIhmRl0Pqjand++JcpqWRMlbfDVHKAGP2oT2vHxpGsBuYImAn
 HTI+w/qLT8UBYJOeIqBqtcG+Ic3Mr3gwAdWXdb2e9y7iQAxbTyAo1v/RpcbpvyS8b7R/mmut+b5
 PeiZ+lNeMW9dFv9AirjdFZB0g62Hg61SD/dOHRzIJzJypUsyRPnOUTjbGCmlRR3BIdWIVNp+45B
 CRarnTD6tyF5eTneNnw2NxjcqjzLJHSZ7WHzlLcXP30tH6N92im759xtXbmTsL3NVwm+CMsAlFI
 5ONAr2g8LaIIlxaio98PqNtTn5T4bZTKK0DrSpTwHUJFcqGT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

During the cache sync test we verify that values we expect to have been
written only to the cache do not appear in the hardware. This works most
of the time but since we randomly generate both the original and new values
there is a low probability that these values may actually be the same.
Wrap get_random_bytes() to ensure that the values are different, it is
likely we will want a similar pattern for other tests in the future.

We use random generation to try to avoid data dependencies in the tests.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Check the whole change in.
- Link to v1: https://lore.kernel.org/r/20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org
---
 drivers/base/regmap/regmap-kunit.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 026bdcb45127..e149b12d0d4a 100644
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
@@ -1265,16 +1282,16 @@ static void raw_sync(struct kunit *test)
 
 	hw_buf = (u16 *)data->vals;
 
-	get_random_bytes(&val, sizeof(val));
+	get_changed_bytes(&hw_buf[6], &val[0], sizeof(val));
 
 	/* Do a regular write and a raw write in cache only mode */
 	regcache_cache_only(map, true);
 	KUNIT_EXPECT_EQ(test, 0, regmap_raw_write(map, 2, val, sizeof(val)));
 	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
-		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 6,
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 4,
 						      be16_to_cpu(val[0])));
 	else
-		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 6,
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 4,
 						      le16_to_cpu(val[0])));
 
 	/* We should read back the new values, and defaults for the rest */
@@ -1284,7 +1301,7 @@ static void raw_sync(struct kunit *test)
 		switch (i) {
 		case 2:
 		case 3:
-		case 6:
+		case 4:
 			if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
 				KUNIT_EXPECT_EQ(test, rval,
 						be16_to_cpu(val[i % 2]));
@@ -1301,7 +1318,7 @@ static void raw_sync(struct kunit *test)
 	
 	/* The values should not appear in the "hardware" */
 	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[2], val, sizeof(val));
-	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[6], val, sizeof(u16));
+	KUNIT_EXPECT_MEMNEQ(test, &hw_buf[4], val, sizeof(u16));
 
 	for (i = 0; i < config.max_register + 1; i++)
 		data->written[i] = false;
@@ -1313,7 +1330,7 @@ static void raw_sync(struct kunit *test)
 
 	/* The values should now appear in the "hardware" */
 	KUNIT_EXPECT_MEMEQ(test, &hw_buf[2], val, sizeof(val));
-	KUNIT_EXPECT_MEMEQ(test, &hw_buf[6], val, sizeof(u16));
+	KUNIT_EXPECT_MEMEQ(test, &hw_buf[4], val, sizeof(u16));
 
 	regmap_exit(map);
 }

---
base-commit: 3b201c9af7c0cad2e8311d96c0c1b399606c70fa
change-id: 20240209-regmap-kunit-random-change-178bd19b91b5

Best regards,
-- 
Mark Brown <broonie@kernel.org>


