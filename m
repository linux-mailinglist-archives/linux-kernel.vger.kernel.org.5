Return-Path: <linux-kernel+bounces-87697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081986D7E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC32BB22AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B417A15D;
	Thu, 29 Feb 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MWUeH5bq"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F470200A6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249733; cv=none; b=LwRfeumlEZ7Cx1ng5SaB1ziccFx3UYNnzMEspvEF6TvSjJl6o30vBzFfdLthc8dHoaxzSEJ0zXwdWU4L+MM6Y96/jbNqVaFq7hiUDSXyKcZ6YsVXXZE+uqD1eeFXZil7flKKowo7HivQ1tmZwFPPCt7X93sP249ZVTbBjH2hdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249733; c=relaxed/simple;
	bh=55xyn8zKO4nNH9Rvcx8r5OPu2ble/KrvXCx28GmYr8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNijQQnLf5Kc8PEdfz/RKP2eVS24SC5FlBTIRuHwVmd9W3hwdUU3HHJCDj1A/+pnUF6keM7IWHU95Qm+o53/lqxucRiKgnyiuyGM2Dfln2bxIuklLNT/wa39QUCPjoHBg1QGusj23saBhzg1Ng3xQcDIrWq/Q4isqEbmkEOa5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MWUeH5bq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e55731af5cso1210770b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709249730; x=1709854530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhQN8lEo47C06uFL3UK+82WnUqWmwbabHP0lvyxYyyI=;
        b=MWUeH5bqL9/Ul2XrQYRTSjP/kmPVZs8DroOonYBj/G65jwn2+YYTnCDRyFGJTIqfv/
         +pB9N43bSbG49py5ovHsgTrUlSdNpxL3kKvQR9AK2MSc657leOkDD97cTIfhlSzd22vp
         92ygbaUcaz6642iFmP11kcdYhnO0Dlyckhhzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249730; x=1709854530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhQN8lEo47C06uFL3UK+82WnUqWmwbabHP0lvyxYyyI=;
        b=AeP8xyDbEjUVGvxYfLJIsvf4+9KvaLHr8CQjKTkFX95yH/WUh1TdB6FeCX314i+nQZ
         R98/bPY/B74g9pzvTz+V/iZko3+uc5JtuVJPLIq3B26FW2QEi3mEWZi2qJu2o+Jlv0nw
         cPRqBEs+UAY07UX6k5UhXdJcxZFbG2nGERifptZW5w2zFL4bIEHdRBUJoEzFnrrw35lK
         GSAvCwmx46zRF/Izyd5sml6bUlloKXrShURUbU6rTzuKtqiF56gpM81pfmIHmwyLj5k8
         fmWc4sS5Ogj3Ka+55U4IYMa4PMFnLYkjZ7DaU+KLieeDGXucKmD+ks+hu3h2cb2QGP52
         7nQg==
X-Forwarded-Encrypted: i=1; AJvYcCVp9E4umJqvw6f1N/kqZ7rH6wIS4c+azoxRg0zhoVScuYgyWlyEJMjhrMUj1E0cHQq+lwDEfd2iDVSasCCMsdu39t5EZPt+4KKwHFqL
X-Gm-Message-State: AOJu0YyO3IrSm3EGb4wyd0SecXppYRrn8hpOSF5HKfskenchomuN94WP
	7SqXAah8Wb0gA9or1fWD4PmrX2pqmlQF+4FPgYLv6n4JnxUvdGflvkqG6LYRzA==
X-Google-Smtp-Source: AGHT+IFXf8sk8MCFBGiYygI8pUL24odr2qCvV71Nsos4dYBMV8uMj+9uSEv4M0R4s4F32eF0SNKH7A==
X-Received: by 2002:a05:6a21:9214:b0:1a0:e811:f521 with SMTP id tl20-20020a056a21921400b001a0e811f521mr4436711pzb.41.1709249730383;
        Thu, 29 Feb 2024 15:35:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y33-20020a17090a53a400b0029ab5abcbe1sm4525268pjh.20.2024.02.29.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:35:29 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] string: Convert selftest to KUnit
Date: Thu, 29 Feb 2024 15:35:23 -0800
Message-Id: <20240229233528.1538803-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229233432.work.675-kees@kernel.org>
References: <20240229233432.work.675-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9530; i=keescook@chromium.org;
 h=from:subject; bh=55xyn8zKO4nNH9Rvcx8r5OPu2ble/KrvXCx28GmYr8o=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4RS8k3eOcod2ISKCbrONdo52S/cd/eKMgfWDU
 72HZYnkRyCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEUvAAKCRCJcvTf3G3A
 JmefD/4jXek21dq0rQfcpU5sZMPfGkZ2PvtC9C0Uy0KOh6pmovBev0Ivjks2Z6SpW47h3c09z34
 DgkYNmGDRkIE9VCM/CHRvzvav7uYL6zfqLHyeNPBapvyffYdJfspW3pB6qcmeal3zbjxCFcWSek
 kis86eJ673hvtdswv3svQDbK4hzgxrXNX1OmwiWN6S6W35ATi0SxhYLIX9N9KhEv3bx/AM2RBxI
 pBjl98YVpsiVeMYi59vo5nfCGVzFkfCEtikmlQF9hIYP3i7YnJnqSASEClXy6KOgGh6/xMC7fud
 i8c8EuUxWSslw8LsDku7LjcnNipkZ/uZq1qp5Ck0BLg1A+JBxigXKMHxX/fsuCYdvWkEkO6iFzd
 xD++6EZH4KIbGNellQt1Us4MpGkpfTPf20mLCmJ310kI6pUCMDuAVaTtYO/Lh3nrH3KuiuE3Rtg
 Fd03eNITa0TDD+x9uRbHss3qfKxSZLYI2cWadQldWdtqqg/91G6zCWZDsiLQVyQxyOkrT8zwLRK
 IALTapgqbhFN+dmplRXW2bnCgUIGYq2twgHH+swXzqtwqcQKkn7/YpgWbqNXNCmsiNkISMA5a+Z
 30Z5eMplrALcW/tREZY7/9an5/nTNQ69j2bJnBS9qAbUifQMP8AixAtfy1KiCYHnjipBK4JoIma JE5sTgvPNR4jcjw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert test_string.c to KUnit so it can be easily run with everything
else.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS                           |   2 +-
 lib/Kconfig.debug                     |   6 +-
 lib/Makefile                          |   2 +-
 lib/{test_string.c => string_kunit.c} | 166 +++++++++-----------------
 4 files changed, 61 insertions(+), 115 deletions(-)
 rename lib/{test_string.c => string_kunit.c} (54%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd651c4df019..9f1f68cccd6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8976,9 +8976,9 @@ F:	include/linux/string.h
 F:	include/linux/string_choices.h
 F:	include/linux/string_helpers.h
 F:	lib/string.c
+F:	lib/string_kunit.c
 F:	lib/string_helpers.c
 F:	lib/test-string_helpers.c
-F:	lib/test_string.c
 F:	scripts/coccinelle/api/string_choices.cocci
 
 GENERIC UIO DRIVER FOR PCI DEVICES
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4e2febe3b568..406cdf353488 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2352,8 +2352,10 @@ config ASYNC_RAID6_TEST
 config TEST_HEXDUMP
 	tristate "Test functions located in the hexdump module at runtime"
 
-config STRING_SELFTEST
-	tristate "Test string functions at runtime"
+config STRING_KUNIT_TEST
+	tristate "KUnit test string functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config TEST_STRING_HELPERS
 	tristate "Test functions located in the string_helpers module at runtime"
diff --git a/lib/Makefile b/lib/Makefile
index eae87c41b22b..946277c37831 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -49,7 +49,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o bitmap-str.o
-obj-$(CONFIG_STRING_SELFTEST) += test_string.o
+obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
diff --git a/lib/test_string.c b/lib/string_kunit.c
similarity index 54%
rename from lib/test_string.c
rename to lib/string_kunit.c
index c5cb92fb710e..bbb54ac11f7b 100644
--- a/lib/test_string.c
+++ b/lib/string_kunit.c
@@ -1,17 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test cases for string functions.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
-static __init int memset16_selftest(void)
+static void test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
 	u16 v, *p;
 
 	p = kmalloc(256 * 2 * 2, GFP_KERNEL);
-	if (!p)
-		return -1;
+	KUNIT_ASSERT_NOT_NULL(test, p);
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
@@ -20,34 +26,28 @@ static __init int memset16_selftest(void)
 			for (k = 0; k < 512; k++) {
 				v = p[k];
 				if (k < i) {
-					if (v != 0xa1a1)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xa1a1);
 				} else if (k < i + j) {
-					if (v != 0xb1b2)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xb1b2);
 				} else {
-					if (v != 0xa1a1)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xa1a1);
 				}
 			}
 		}
 	}
 
-fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k | 0x8000;
-	return 0;
+		KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x8000);
 }
 
-static __init int memset32_selftest(void)
+static void test_memset32(struct kunit *test)
 {
 	unsigned i, j, k;
 	u32 v, *p;
 
 	p = kmalloc(256 * 2 * 4, GFP_KERNEL);
-	if (!p)
-		return -1;
+	KUNIT_ASSERT_NOT_NULL(test, p);
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
@@ -56,34 +56,28 @@ static __init int memset32_selftest(void)
 			for (k = 0; k < 512; k++) {
 				v = p[k];
 				if (k < i) {
-					if (v != 0xa1a1a1a1)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xa1a1a1a1);
 				} else if (k < i + j) {
-					if (v != 0xb1b2b3b4)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xb1b2b3b4);
 				} else {
-					if (v != 0xa1a1a1a1)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xa1a1a1a1);
 				}
 			}
 		}
 	}
 
-fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k | 0x8000;
-	return 0;
+		KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x8000);
 }
 
-static __init int memset64_selftest(void)
+static void test_memset64(struct kunit *test)
 {
 	unsigned i, j, k;
 	u64 v, *p;
 
 	p = kmalloc(256 * 2 * 8, GFP_KERNEL);
-	if (!p)
-		return -1;
+	KUNIT_ASSERT_NOT_NULL(test, p);
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
@@ -92,27 +86,22 @@ static __init int memset64_selftest(void)
 			for (k = 0; k < 512; k++) {
 				v = p[k];
 				if (k < i) {
-					if (v != 0xa1a1a1a1a1a1a1a1ULL)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xa1a1a1a1a1a1a1a1ULL);
 				} else if (k < i + j) {
-					if (v != 0xb1b2b3b4b5b6b7b8ULL)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xb1b2b3b4b5b6b7b8ULL);
 				} else {
-					if (v != 0xa1a1a1a1a1a1a1a1ULL)
-						goto fail;
+					KUNIT_EXPECT_EQ(test, v, 0xa1a1a1a1a1a1a1a1ULL);
 				}
 			}
 		}
 	}
 
-fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k | 0x8000;
-	return 0;
+		KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x8000);
 }
 
-static __init int strchr_selftest(void)
+static void test_strchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
 	const char *empty_string = "";
@@ -121,26 +110,20 @@ static __init int strchr_selftest(void)
 
 	for (i = 0; i < strlen(test_string) + 1; i++) {
 		result = strchr(test_string, test_string[i]);
-		if (result - test_string != i)
-			return i + 'a';
+		KUNIT_ASSERT_EQ(test, result - test_string, i);
 	}
 
 	result = strchr(empty_string, '\0');
-	if (result != empty_string)
-		return 0x101;
+	KUNIT_ASSERT_PTR_EQ(test, result, empty_string);
 
 	result = strchr(empty_string, 'a');
-	if (result)
-		return 0x102;
+	KUNIT_ASSERT_NULL(test, result);
 
 	result = strchr(test_string, 'z');
-	if (result)
-		return 0x103;
-
-	return 0;
+	KUNIT_ASSERT_NULL(test, result);
 }
 
-static __init int strnchr_selftest(void)
+static void test_strnchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
 	const char *empty_string = "";
@@ -153,33 +136,27 @@ static __init int strnchr_selftest(void)
 			if (j <= i) {
 				if (!result)
 					continue;
-				return ((i + 'a') << 8) | j;
+				KUNIT_ASSERT_EQ(test, 0, 1);
 			}
 			if (result - test_string != i)
-				return ((i + 'a') << 8) | j;
+				KUNIT_ASSERT_EQ(test, 0, 1);
 		}
 	}
 
 	result = strnchr(empty_string, 0, '\0');
-	if (result)
-		return 0x10001;
+	KUNIT_ASSERT_NULL(test, result);
 
 	result = strnchr(empty_string, 1, '\0');
-	if (result != empty_string)
-		return 0x10002;
+	KUNIT_ASSERT_PTR_EQ(test, result, empty_string);
 
 	result = strnchr(empty_string, 1, 'a');
-	if (result)
-		return 0x10003;
+	KUNIT_ASSERT_NULL(test, result);
 
 	result = strnchr(NULL, 0, '\0');
-	if (result)
-		return 0x10004;
-
-	return 0;
+	KUNIT_ASSERT_NULL(test, result);
 }
 
-static __init int strspn_selftest(void)
+static void test_strspn(struct kunit *test)
 {
 	static const struct strspn_test {
 		const char str[16];
@@ -187,7 +164,7 @@ static __init int strspn_selftest(void)
 		const char reject[16];
 		unsigned a;
 		unsigned r;
-	} tests[] __initconst = {
+	} tests[] = {
 		{ "foobar", "", "", 0, 6 },
 		{ "abba", "abc", "ABBA", 4, 4 },
 		{ "abba", "a", "b", 1, 1 },
@@ -198,60 +175,27 @@ static __init int strspn_selftest(void)
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i, ++s) {
 		res = strspn(s->str, s->accept);
-		if (res != s->a)
-			return 0x100 + 2*i;
+		KUNIT_ASSERT_EQ(test, res, s->a);
 		res = strcspn(s->str, s->reject);
-		if (res != s->r)
-			return 0x100 + 2*i + 1;
+		KUNIT_ASSERT_EQ(test, res, s->r);
 	}
-	return 0;
-}
-
-static __exit void string_selftest_remove(void)
-{
 }
 
-static __init int string_selftest_init(void)
-{
-	int test, subtest;
-
-	test = 1;
-	subtest = memset16_selftest();
-	if (subtest)
-		goto fail;
-
-	test = 2;
-	subtest = memset32_selftest();
-	if (subtest)
-		goto fail;
-
-	test = 3;
-	subtest = memset64_selftest();
-	if (subtest)
-		goto fail;
+static struct kunit_case string_test_cases[] = {
+	KUNIT_CASE(test_memset16),
+	KUNIT_CASE(test_memset32),
+	KUNIT_CASE(test_memset64),
+	KUNIT_CASE(test_strchr),
+	KUNIT_CASE(test_strnchr),
+	KUNIT_CASE(test_strspn),
+	{}
+};
 
-	test = 4;
-	subtest = strchr_selftest();
-	if (subtest)
-		goto fail;
+static struct kunit_suite string_test_suite = {
+	.name = "string",
+	.test_cases = string_test_cases,
+};
 
-	test = 5;
-	subtest = strnchr_selftest();
-	if (subtest)
-		goto fail;
-
-	test = 6;
-	subtest = strspn_selftest();
-	if (subtest)
-		goto fail;
-
-	pr_info("String selftests succeeded\n");
-	return 0;
-fail:
-	pr_crit("String selftest failure %d.%08x\n", test, subtest);
-	return 0;
-}
+kunit_test_suites(&string_test_suite);
 
-module_init(string_selftest_init);
-module_exit(string_selftest_remove);
 MODULE_LICENSE("GPL v2");
-- 
2.34.1


