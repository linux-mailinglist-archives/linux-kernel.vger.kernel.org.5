Return-Path: <linux-kernel+bounces-87733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3BE86D84E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4791C20CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA91FA0;
	Fri,  1 Mar 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I966CMgw"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F72386
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252818; cv=none; b=IYNCEcUdeGshLhA0VUkJDVU9+AMWuF9c0Cmd2bx8HoGG7mFJ25XLB2ULhcJDDDWYyQUX1KzGGbdBmzzkqI+1VLHvEbPR/Lvd8T8ngIrNvM1t+9SSZpk8sFbFcCGGreXHaY0Vc0cxJXVVClwT5dGeZR0oORXBF9SyTUKE89HV8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252818; c=relaxed/simple;
	bh=55xyn8zKO4nNH9Rvcx8r5OPu2ble/KrvXCx28GmYr8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDnec9YKUgW598LJ5GozBF9aTB6pL9AfXFQSZh8Tek+n0pybFePrw9ICg6t6xUaHV4DmUPbbXxobOysKHqCvGTkbW2tUyEECNXbg+WR6iJ4ZI0BO8qtS9XGqyujOTVQeONTq05anElCgvedk8RWhzF8qF6Zg2IDLCfZKcRvFgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I966CMgw; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3652731b2b7so6153005ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709252812; x=1709857612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhQN8lEo47C06uFL3UK+82WnUqWmwbabHP0lvyxYyyI=;
        b=I966CMgwFsUOlvnt2dycxXw0qMhxkqVDPfcjooz6KPKJ3iDvGwwHMlImO1OjD2ZSGn
         1RyJeGX371u8IOcUv0DdX9xvnBI076cePxf1rI/jRNfET6WER+lpavqwNShOjZ0VmXOz
         6lqxmMmuIOqZ6qCNKU+CrqkJuaolvseY4QfMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252812; x=1709857612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhQN8lEo47C06uFL3UK+82WnUqWmwbabHP0lvyxYyyI=;
        b=do2Ln3BjtiJ+HnaBu4v1Di+yIFGRQ03jlgY0H90rovknDFOelxxmWIqozpScowBtYO
         P+FUb5v+5Gwt7uJZD3dECITtMAYWdILMF/0uanDFua24YkVnjEmDnmi+F8Gwk5d7qV1F
         dZBIWQxsHC1XjWkvGMSzSOSM2BPbqYu8YSkSGtx8yAze5gxqmS8CNZD2p/yKgwEtB1Es
         RiWxOyRjy+bbfPVu11Z/ONu8nNsJy+Yc3DuZLVNHNs3OEStTA/L1QxakNcf512qXHwVs
         fpnMUgjiTsX6PY5bxNIoP/YrWb9HO/Wl8vLewVIWXn/gKsO3b/wuW8zpwKlxFM5kc1M/
         1caQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtHdJVgI6tj1N7W07tySD5HCDi1s/s82J3R2R1+6gN0RYGXI+b3rQxm+v51fJLpDKJdQlfDK3PMiQcEP0jt+V+NOx/JDNm5MdNd0gS
X-Gm-Message-State: AOJu0Ywda3eBVhMVmQGjliQ3Y5QLggJdzqkwGkakr/rHF45LEw9O4Egt
	JO1T3Lq+zNs8+ApxiVb8CAArYyxjlctpNEYdtSTa8BrUtUrrE8diDMxw6n/yyGg5SEME+2qel3M
	=
X-Google-Smtp-Source: AGHT+IEpsa9sCTPYv+KsQFgBox3T1DxeXaCTw2hobPVds2ftPX4N0287clgH/pZEXUuiqNJ86S5foQ==
X-Received: by 2002:a05:6e02:1a8c:b0:365:3e12:8bfb with SMTP id k12-20020a056e021a8c00b003653e128bfbmr299302ilv.21.1709252812357;
        Thu, 29 Feb 2024 16:26:52 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a27-20020a62d41b000000b006e48e64ef54sm1971821pfh.173.2024.02.29.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:26:50 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] string: Convert selftest to KUnit
Date: Thu, 29 Feb 2024 16:26:47 -0800
Message-Id: <20240301002650.1544829-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301002416.it.092-kees@kernel.org>
References: <20240301002416.it.092-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9530; i=keescook@chromium.org;
 h=from:subject; bh=55xyn8zKO4nNH9Rvcx8r5OPu2ble/KrvXCx28GmYr8o=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4SDIk3eOcod2ISKCbrONdo52S/cd/eKMgfWDU
 72HZYnkRyCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEgyAAKCRCJcvTf3G3A
 JsOIEACv8/xAArv+Wft8iBQU4FUyttrBGIVPhLYyQu+RfXvWSjbQ3X3T5Ofl1pXImdEP/PAKrN2
 yZKCEEIV4hLX9pcraulqkrM29te373it+eEbLDfygXuhjRlLkMSY0auegc375nTkBNAvf4rql9X
 cQx2jgS2u6LKVYYKu7LezIgYo2oEstoA6Hl9G27huYreIcZ6Iw81amesuWa8bWerpL3VTrTP0+S
 QPgKdz05ceBkVhWi2MA3akGtytHyAPmKY/lakVJXK5pNGWDcHC0I8pYtq1L5pFkJ9A7rzXYJ9TQ
 Y5s3zaIt0xbCOQRR0TOxQYo4dpsQLHL1vqfF3fxYkMbbPcIbNuE4AeVTjbNuCgb7JXubVSj2CIL
 gfhtUuYlBKB3rDOIBzQ6tKHYFxgeX7fvCO+DVxw9iukDC06Z3ECzgOO18CG0uvq0UIL73CwADke
 EEKbvZ6sumFwxXDM0HKr3TGT499yeU0CzzKyy9udfnj6JVRyBhEZfJhuFeY3kV33ken1404kXjN
 ZaGlk9Dr2QIDCDdDZEhm41z4oQ+tA6jXdELtxCKgE9pYNAgfALm5YbB84Ft1CACEP7rgdL2uiEp
 NpWSOnDBwn3PMZf9+4t/+FzpKWt4OdL4VgmRT+agW6kFzGMCXnqAUEwLXBZBqibVmn7PbO46weO vBCiKckEkbunZzA==
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


