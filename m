Return-Path: <linux-kernel+bounces-80257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B85862CA3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C7C281981
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE79A199BE;
	Sun, 25 Feb 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+HUjWK2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E51759F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708890575; cv=none; b=j6RpAKtIx5mO7mfsiarANiHacezl4djiJ4zvo+rSIH0IU3G9XAbW/0jJNmFEiG/5wRspRm2svk3PpugUpit2WiB4jszaiqoTpaZfcssAlbxfHsfthsg4KMG4BdFEicHkrNEXQOnWQSJK6esXHaI1OzBwI4G4VuDMk8MkRRnCe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708890575; c=relaxed/simple;
	bh=ZENVKkATzJXVRSZ2EC/+wfI5KUHwIHxTOQcJjOk7iBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UE0fSwqNdWq7h3xTHaIBjp7kVKGmw2aSU14u2MididaCa0W3gPTKSUULXErgRff9wYzEYVjFCl6ZI9Z/ngbsmL9k26EO5YQm+Gx9D0Kj2grQXbMAQCILPSEv1Cmxs8EKedAP/8K+xt4HbDvn48uBPZhUzggYS1RAABwFGKk5rhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+HUjWK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DCAC433F1;
	Sun, 25 Feb 2024 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708890574;
	bh=ZENVKkATzJXVRSZ2EC/+wfI5KUHwIHxTOQcJjOk7iBk=;
	h=From:Date:Subject:To:Cc:From;
	b=U+HUjWK2OJGWfAOVNmPigJyjFa8nmpV1QQqSE8159YNGyVB5xr+znnAyinLqEAY5i
	 eIhL1f1BXaTbWkR/GH4a2HYYI8LrFiHz5P7VXEPOsQitvAmPtHWWOCLqvrQYCpkRCn
	 75PDyxV9CRt+q3vBsFcwmhPX8tpaK9yYVR3MrWK0uE4J+ruNasqk2YCP2jcW/qT5QK
	 IuJdJ1BGacm4d6pkfPG5guAI8T9ZuY7hHa78EufWSweEOIJvJOi7MhCk4RYaPnSV8L
	 xUJwSSURv9NG9q11L8UXKDL8i7QvI0xZxpNq+gJufMlpfGv01aEbMH2vD3Xu8UkJCD
	 8EayjNI3ae4kA==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 25 Feb 2024 19:49:25 +0000
Subject: [PATCH] regmap: kunit: Add a test for ranges in combination with
 windows
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-regmap-test-format-v1-1-41e4fdfb1c1f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMSZ22UC/x3MMQqAMAxA0atIZgNtlaJeRRxKjJpBLWkRQby7x
 fEN/z+QWIUTDNUDypckOY8CW1dAWzhWRpmLwRnXGucaVF73EDFzyricuoeM5Il8T30zdxZKGJU
 Xuf/pOL3vB+oCkJRkAAAA
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3866; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZENVKkATzJXVRSZ2EC/+wfI5KUHwIHxTOQcJjOk7iBk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl25nKNzlmvoPJ6figOdDr6GMlWlk1sy8WRRRfE
 bBnn6ElaoeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZduZygAKCRAk1otyXVSH
 0FwBB/93ssYq/0SdSsyTqz7rb1eTTCY9d5DutSf4NYVmTa+l07nxq9aCj8YzZHaDRSejg/k0Qf+
 Gaz325HVN9BA5xTeA17G4NNR30Km/29iy90oWOvnhJlvXq/XMcHOvdoapUY8YlaGudZnL84lrNx
 ZXoqKDTiPjWRKAmWrvH+TSyZkQztKA/vJS7SH3wTT8i6L3ZPyQja3YFCzaB6XJ6yksGH4ZpTD9R
 9s1AYWo7P79ENT6K/hUk1LuAO2+ijwy4xMA21NlkNeIcfiYo6sSpWyQw7vNDbTewAblQzCtqKfL
 JE6P1QXAq6OBevNgdqkbdszyFh5FS9vwQR8MiEU5MMbuTvSj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for taking advantage of the SPI support for pre-coooked
messages add a test case covering the use of windows on a raw regmap,
unfortunately the parameterisation prevents direct reuse and we will
want to add some raw specific coverage anyway.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 66 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 0d957c5f1bcc..bb2ab6129f38 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1341,6 +1341,71 @@ static void raw_sync(struct kunit *test)
 	regmap_exit(map);
 }
 
+static void raw_ranges(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val;
+	int i;
+
+	config = raw_regmap_config;
+	config.volatile_reg = test_range_all_volatile;
+	config.ranges = &test_range;
+	config.num_ranges = 1;
+	config.max_register = test_range.range_max;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	/* Reset the page to a non-zero value to trigger a change */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, test_range.selector_reg,
+					      test_range.range_max));
+
+	/* Check we set the page and use the window for writes */
+	data->written[test_range.selector_reg] = false;
+	data->written[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, test_range.range_min, 0));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.window_start]);
+
+	data->written[test_range.selector_reg] = false;
+	data->written[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map,
+					      test_range.range_min +
+					      test_range.window_len,
+					      0));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.window_start]);
+
+	/* Same for reads */
+	data->written[test_range.selector_reg] = false;
+	data->read[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, test_range.range_min, &val));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->read[test_range.window_start]);
+
+	data->written[test_range.selector_reg] = false;
+	data->read[test_range.window_start] = false;
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map,
+					     test_range.range_min +
+					     test_range.window_len,
+					     &val));
+	KUNIT_EXPECT_TRUE(test, data->written[test_range.selector_reg]);
+	KUNIT_EXPECT_TRUE(test, data->read[test_range.window_start]);
+
+	/* No physical access triggered in the virtual range */
+	for (i = test_range.range_min; i < test_range.range_max; i++) {
+		KUNIT_EXPECT_FALSE(test, data->read[i]);
+		KUNIT_EXPECT_FALSE(test, data->written[i]);
+	}
+
+	regmap_exit(map);
+}
+
 static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(basic_read_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
@@ -1368,6 +1433,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(raw_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_noinc_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_sync, raw_test_cache_types_gen_params),
+	KUNIT_CASE_PARAM(raw_ranges, raw_test_cache_types_gen_params),
 	{}
 };
 

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240223-regmap-test-format-c6cc69c93d81

Best regards,
-- 
Mark Brown <broonie@kernel.org>


