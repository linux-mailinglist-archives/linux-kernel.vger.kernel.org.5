Return-Path: <linux-kernel+bounces-59915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794684FD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4CD1F2201D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6A58564E;
	Fri,  9 Feb 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzdf3qi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B407FBBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508961; cv=none; b=R5bDisfDTFJO6ydrbyrH4OnBy+66YFHuXzeYHFsA2EylrtDFpyl4mJ4AIcfuo76vbyvXWXkNEvCpbXs0wyuscJHCbxF2EPMPJ4985Ti0NTps6EzWCl9ghzXTUvFrOGjAtFlraC5eidpseYbIJ892dDRpamlO+WkgX1ElaUDwxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508961; c=relaxed/simple;
	bh=45qZWquQsz94OHCPWBfGpqjJ4oI4FBMtt8Q/UctkUiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bRtbaJI/uUi3Gi3zm1kNjDN8ELaXnmjbwFpYY4LMzqTrfqUtf66Clupe3NSTq/Nm9K17z+Kt2v/qg/z5chRyIoYdNuALcZy4aM7E0yhD0S7lSiu22WO2x0mI1OUHWUVYSs5r8hynHLpZPg0EVu+pUfL4TmdtfIRJ6BSToTEAl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzdf3qi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF146C433F1;
	Fri,  9 Feb 2024 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707508960;
	bh=45qZWquQsz94OHCPWBfGpqjJ4oI4FBMtt8Q/UctkUiw=;
	h=From:Date:Subject:To:Cc:From;
	b=Vzdf3qi6mHAe/6z4cT80Bhb0UAkubccSF+FKYhhaAp5Dqk+toZ84IFfYtK1F2tEMJ
	 2Dc1zLceuZWj6Sq9UQ50sfEWL3Uy3Le+4yHWVT124fG0Q1vc6uNfcao0CHGe7HActv
	 gAwDWakfelqeeze2Xmq/gdWJlZGsUK/va5ALAOed10jfbSLxkyXK9WkkDm8WipkKpb
	 4L3HLOOp7N2ARh5Sxx1PX1R12V7XNH4ERPENewDHZwn6a4vobdmP4JKbLXZmD/Mkd0
	 yps+096WcEdSY9qu8ae/2ZEJSs3AOxB7tn2Vb3Nsj62pqT5a7CdhLu22xySPzPdc1H
	 IKNjYFtOzNgxw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Feb 2024 20:02:27 +0000
Subject: [PATCH] regmap: kunit: Ensure that changed bytes are actually
 different
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regmap-kunit-random-change-v1-1-ad2d76757583@kernel.org>
X-B4-Tracking: v=1; b=H4sIANKExmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwNL3aLU9NzEAt3s0rzMEt2ixLyU/FxdqEpDc4ukFEPLJEvDJFMloAE
 FRalpmRVgw6Nja2sBfkT/8mwAAAA=
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067; i=broonie@kernel.org;
 h=from:subject:message-id; bh=45qZWquQsz94OHCPWBfGpqjJ4oI4FBMtt8Q/UctkUiw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxoTbvvKBumOj4LwrfMuanWmld+IdMtEQ69qDI
 /+0gHRkkqaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcaE2wAKCRAk1otyXVSH
 0GvRB/0Q7IK09ketPxFRbXKyUeFhu2Gw3fJRbC4EzD5aoRGP0n10/b/9DqruLrQLlNEi7f0K4A6
 TfoxakCky6i7oOIjBXe9Ml0wakU+PsTeMBN21BLlA6Pa7HXWkkeK6YcWkJUPNzH5a280+2uWpKS
 yMWqTa/JAVHe5UdPJAtzZfWeOeeC3/7mCtIBPkC4l9jOaqxYqApwX/sS9kcYD5oCw62Xe81MTb0
 eGK+VHk4AYIzzeDB/qL1PXqxwJ9yNyAShRMRV6tEWzcz6OjwutoANrhWjuToXTisXC5dCmak7dN
 Piu5HTdMvADc7iSm159HbpFyU21dRQVsmUvUrvRxNo/B9oIP
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
 drivers/base/regmap/regmap-kunit.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 026bdcb45127..59a672e2fb01 100644
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

---
base-commit: 3b201c9af7c0cad2e8311d96c0c1b399606c70fa
change-id: 20240209-regmap-kunit-random-change-178bd19b91b5

Best regards,
-- 
Mark Brown <broonie@kernel.org>


