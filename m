Return-Path: <linux-kernel+bounces-151525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E28AB00F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556F0284F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75212FF6A;
	Fri, 19 Apr 2024 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S9fROnZz"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2512F591
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535324; cv=none; b=BAghcECb3rG7ZR/toSsqQjN1rhDhKjTxkDmzw3qm9xHr0xlFWlyXXGqrM6TdoijasfmLPGeihxq6zXoA4TMtt9X8W5uDZp8qTFOfXCGYOyAJ7s7p0nnKxswcaxIzr/g66TL9ZGSMGcQhpDDvVDGEjVYwDyptPlvjJxsWALLKDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535324; c=relaxed/simple;
	bh=T4T12aBzb3659aamqGpMxrlRfP3HpBW0G/bxlxU6j20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iboTucJYY4DhcYqjvNUuIbRMsABuoJtPGHwePlqVhO4igJF5eV5gu5qgBFYFTTrwp1ZuQvDjO6RYlHR7lOfVL1DrILjobhIP0K3L5gwLmilIvWRPILMKeP4dibcnItFPUwSoPUpUfaqNAc7yXdPEwfr+ClQm53bg+8Oyn4/us+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S9fROnZz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso1718884b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535321; x=1714140121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0GY48KBlH89KAXWIMTUcl58U5pXshvAuAxGbLF01U8=;
        b=S9fROnZzKJ4Vj9dHMNprmLPxCE03McbuzPSXiA7gHkWX+NRWRoMgDUfRjuCROLGeqm
         dIWG4FYLyTSjkORj9IsObLrTwMjA41t615uVW8UfMuaSjMAnvpd8ILtPCE7CyRyZcDDC
         /MYahSHfxMtgT951zN41INZaRprd5XPJNy4OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535321; x=1714140121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0GY48KBlH89KAXWIMTUcl58U5pXshvAuAxGbLF01U8=;
        b=OTpZyBu3BF4GVfBp3J7/J0GHjrFJudyob/hCZQ9X/dqZUOQO0+22FxusgSxTXHjk+l
         nCJS6fGjfbROQKJP2lkhDXFz1uofg6YkaoZG8zxkpzrNrQBsr1M8zw4jRU3Vi34x3K0Z
         hRSKdNYF2+8Ufb9YNBO4tF4YNGm6CKuoCH8hsUm3WGsHbrc79k7aZzVJgE9GAMjLLRrb
         aetz8+eLAoVSSsrPlv1BG3BmbMDoyJA/hi59PG5d76ASMZeRGOockSJm5G4xKzIP3Dyv
         kSHl8p2q1OznaT4pP4fDJRxFlOeMjDyMcItwNjGoZvD0wQtnFtF5CVkoUXWjCQoS9iQ0
         g6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX6mQMkCMaFW8xPqEaHLCuzJ8dHQwdF/vEULYMgkFZhdLNA/9rVib1BoAJyzG/8AoMKzHiLK+JY08dzM+0NuU+jX5YWFqtdeMlAaRhS
X-Gm-Message-State: AOJu0Yzk9/t/5Iw3oJRgj0BzvgUkpVsVBrKrtkTepKFfmGR9cO3cM4XY
	E0csHknIdvy+o3po+68Fz7Kc3VlLcI8L+oTurnuT3fXRXwrZ7I97tpNBo6n8PA==
X-Google-Smtp-Source: AGHT+IFJUoYrugMKC8D2gWzFPvfQ3MNRQvPuwqnx28doeCWtnRZ+68KaoLLiKoxcfIBsDJH85waJSQ==
X-Received: by 2002:a05:6a21:78a5:b0:1a9:c436:c904 with SMTP id bf37-20020a056a2178a500b001a9c436c904mr2897711pzc.10.1713535319066;
        Fri, 19 Apr 2024 07:01:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ge3-20020a056a00838300b006ecfc3a5f2dsm3233096pfb.46.2024.04.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] string: Merge strscpy KUnit tests into string_kunit.c
Date: Fri, 19 Apr 2024 07:01:51 -0700
Message-Id: <20240419140155.3028912-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
References: <20240419140017.work.012-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12551; i=keescook@chromium.org;
 h=from:subject; bh=T4T12aBzb3659aamqGpMxrlRfP3HpBW0G/bxlxU6j20=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlSd9EMm/VxnY5WBP5RPRwlSVvSeyS3z4w5L
 oF/F+0WBNCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UgAKCRCJcvTf3G3A
 JrbYD/9GYEopgnQ2tJe+7IjOXYOe5GTa0vJBkG8T3E7nCTco/P+LbuTqpO3J7Ffu5og2Hs7kITB
 YQ2eiMz2CIZ8wm/Qi+uiuqcO2dJJZgOqim4OtoXv9eANH1+5s2hvyc4A5BVrBpWJPqIO2x7U7hP
 YiU1Wwd7FRg673dVaiRooBAXozTKFvP226xoAav7oL3krrjajRcK65TK4Q+SERF6M5jJINjEU24
 ZhV9sbcI7CZPg9anFhr0J2zB6jMgH6+KXzSc6GpfJxDDmt1/fc/rA8pwpa8giT3EHE9aVnpwsZe
 CU16Y9GRKFLp7eb6lJWS1nJmi8p9OU6C/TPYrMwBxnn+zuEyJ4JE9kB/8VPYISWWwgxLHTF/s7O
 dojlOBo9VzTkq0lf7atFjqQ+33/4npG6FmoYYMmVUsshDBvjsF5swOmpkmrn5XJx04Z2dU7JIH5
 gsooGzh+SVZhF7KUDlfzPeNPVD2lxgDc0nZ6Jd6pR6+PNjQ2oSjBr3YRCYev8tHj8orTfLZ63oM
 3B8IRp9hzCuJ4trlDVN6O7AEAKdBDWUu6wXxGNG1ZwOPWLLoWC1eg6Ycj1QO3vIiynhSexGEpnI
 e7sZ9D1tDw2kl+fM/Jx4FKQRz4rZYZFvNyiPL4ve39mIpvC9ZQQJJCROrZgzl45lkC57UzBttUq VK6FwmlXKxoJntg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Move the strscpy() tests into string_kunit.c. Remove the separate
Kconfig and Makefile rule.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS         |   1 -
 lib/Kconfig.debug   |   5 --
 lib/Makefile        |   1 -
 lib/string_kunit.c  | 120 +++++++++++++++++++++++++++++++++++++
 lib/strscpy_kunit.c | 143 --------------------------------------------
 5 files changed, 120 insertions(+), 150 deletions(-)
 delete mode 100644 lib/strscpy_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..17d079aa15ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8442,7 +8442,6 @@ F:	include/linux/fortify-string.h
 F:	lib/fortify_kunit.c
 F:	lib/memcpy_kunit.c
 F:	lib/strcat_kunit.c
-F:	lib/strscpy_kunit.c
 F:	lib/test_fortify/*
 F:	scripts/test_fortify.sh
 K:	\b__NO_FORTIFY\b
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..7ffb06eabcd1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2763,11 +2763,6 @@ config STRCAT_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 
-config STRSCPY_KUNIT_TEST
-	tristate "Test strscpy*() family of functions at runtime" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	default KUNIT_ALL_TESTS
-
 config SIPHASH_KUNIT_TEST
 	tristate "Perform selftest on siphash functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index ffc6b2341b45..5f994b963d1a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -404,7 +404,6 @@ CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
-obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index dd19bd7748aa..4af04643f4c2 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -326,6 +326,125 @@ static void test_strncasecmp_long_strings(struct kunit *test)
 				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
 }
 
+/**
+ * strscpy_check() - Run a specific test case.
+ * @test: KUnit test context pointer
+ * @src: Source string, argument to strscpy_pad()
+ * @count: Size of destination buffer, argument to strscpy_pad()
+ * @expected: Expected return value from call to strscpy_pad()
+ * @chars: Number of characters from the src string expected to be
+ *         written to the dst buffer.
+ * @terminator: 1 if there should be a terminating null byte 0 otherwise.
+ * @pad: Number of pad characters expected (in the tail of dst buffer).
+ *       (@pad does not include the null terminator byte.)
+ *
+ * Calls strscpy_pad() and verifies the return value and state of the
+ * destination buffer after the call returns.
+ */
+static void strscpy_check(struct kunit *test, char *src, int count,
+			  int expected, int chars, int terminator, int pad)
+{
+	int nr_bytes_poison;
+	int max_expected;
+	int max_count;
+	int written;
+	char buf[6];
+	int index, i;
+	const char POISON = 'z';
+
+	KUNIT_ASSERT_TRUE_MSG(test, src != NULL,
+			      "null source string not supported");
+
+	memset(buf, POISON, sizeof(buf));
+	/* Future proofing test suite, validate args */
+	max_count = sizeof(buf) - 2; /* Space for null and to verify overflow */
+	max_expected = count - 1;    /* Space for the null */
+
+	KUNIT_ASSERT_LE_MSG(test, count, max_count,
+		"count (%d) is too big (%d) ... aborting", count, max_count);
+	KUNIT_EXPECT_LE_MSG(test, expected, max_expected,
+		"expected (%d) is bigger than can possibly be returned (%d)",
+		expected, max_expected);
+
+	written = strscpy_pad(buf, src, count);
+	KUNIT_ASSERT_EQ(test, written, expected);
+
+	if (count && written == -E2BIG) {
+		KUNIT_ASSERT_EQ_MSG(test, 0, strncmp(buf, src, count - 1),
+			"buffer state invalid for -E2BIG");
+		KUNIT_ASSERT_EQ_MSG(test, buf[count - 1], '\0',
+			"too big string is not null terminated correctly");
+	}
+
+	for (i = 0; i < chars; i++)
+		KUNIT_ASSERT_EQ_MSG(test, buf[i], src[i],
+			"buf[i]==%c != src[i]==%c", buf[i], src[i]);
+
+	if (terminator)
+		KUNIT_ASSERT_EQ_MSG(test, buf[count - 1], '\0',
+			"string is not null terminated correctly");
+
+	for (i = 0; i < pad; i++) {
+		index = chars + terminator + i;
+		KUNIT_ASSERT_EQ_MSG(test, buf[index], '\0',
+			"padding missing at index: %d", i);
+	}
+
+	nr_bytes_poison = sizeof(buf) - chars - terminator - pad;
+	for (i = 0; i < nr_bytes_poison; i++) {
+		index = sizeof(buf) - 1 - i; /* Check from the end back */
+		KUNIT_ASSERT_EQ_MSG(test, buf[index], POISON,
+			"poison value missing at index: %d", i);
+	}
+}
+
+static void test_strscpy(struct kunit *test)
+{
+	char dest[8];
+
+	/*
+	 * strscpy_check() uses a destination buffer of size 6 and needs at
+	 * least 2 characters spare (one for null and one to check for
+	 * overflow).  This means we should only call tc() with
+	 * strings up to a maximum of 4 characters long and 'count'
+	 * should not exceed 4.  To test with longer strings increase
+	 * the buffer size in tc().
+	 */
+
+	/* strscpy_check(test, src, count, expected, chars, terminator, pad) */
+	strscpy_check(test, "a", 0, -E2BIG, 0, 0, 0);
+	strscpy_check(test, "",  0, -E2BIG, 0, 0, 0);
+
+	strscpy_check(test, "a", 1, -E2BIG, 0, 1, 0);
+	strscpy_check(test, "",  1, 0,	 0, 1, 0);
+
+	strscpy_check(test, "ab", 2, -E2BIG, 1, 1, 0);
+	strscpy_check(test, "a",  2, 1,	  1, 1, 0);
+	strscpy_check(test, "",   2, 0,	  0, 1, 1);
+
+	strscpy_check(test, "abc", 3, -E2BIG, 2, 1, 0);
+	strscpy_check(test, "ab",  3, 2,	   2, 1, 0);
+	strscpy_check(test, "a",   3, 1,	   1, 1, 1);
+	strscpy_check(test, "",    3, 0,	   0, 1, 2);
+
+	strscpy_check(test, "abcd", 4, -E2BIG, 3, 1, 0);
+	strscpy_check(test, "abc",  4, 3,	    3, 1, 0);
+	strscpy_check(test, "ab",   4, 2,	    2, 1, 1);
+	strscpy_check(test, "a",    4, 1,	    1, 1, 2);
+	strscpy_check(test, "",     4, 0,	    0, 1, 3);
+
+	/* Compile-time-known source strings. */
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 3), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 1), 0);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 0), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", ARRAY_SIZE(dest)), 5);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 3), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 1), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 0), -E2BIG);
+	KUNIT_EXPECT_EQ(test, strscpy(dest, "This is too long", ARRAY_SIZE(dest)), -E2BIG);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
@@ -341,6 +460,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_strcasecmp_long_strings),
 	KUNIT_CASE(test_strncasecmp),
 	KUNIT_CASE(test_strncasecmp_long_strings),
+	KUNIT_CASE(test_strscpy),
 	{}
 };
 
diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
deleted file mode 100644
index b6d1d93a8883..000000000000
--- a/lib/strscpy_kunit.c
+++ /dev/null
@@ -1,143 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Kernel module for testing 'strscpy' family of functions.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <kunit/test.h>
-#include <linux/string.h>
-
-/**
- * strscpy_check() - Run a specific test case.
- * @test: KUnit test context pointer
- * @src: Source string, argument to strscpy_pad()
- * @count: Size of destination buffer, argument to strscpy_pad()
- * @expected: Expected return value from call to strscpy_pad()
- * @chars: Number of characters from the src string expected to be
- *         written to the dst buffer.
- * @terminator: 1 if there should be a terminating null byte 0 otherwise.
- * @pad: Number of pad characters expected (in the tail of dst buffer).
- *       (@pad does not include the null terminator byte.)
- *
- * Calls strscpy_pad() and verifies the return value and state of the
- * destination buffer after the call returns.
- */
-static void strscpy_check(struct kunit *test, char *src, int count,
-			  int expected, int chars, int terminator, int pad)
-{
-	int nr_bytes_poison;
-	int max_expected;
-	int max_count;
-	int written;
-	char buf[6];
-	int index, i;
-	const char POISON = 'z';
-
-	KUNIT_ASSERT_TRUE_MSG(test, src != NULL,
-			      "null source string not supported");
-
-	memset(buf, POISON, sizeof(buf));
-	/* Future proofing test suite, validate args */
-	max_count = sizeof(buf) - 2; /* Space for null and to verify overflow */
-	max_expected = count - 1;    /* Space for the null */
-
-	KUNIT_ASSERT_LE_MSG(test, count, max_count,
-		"count (%d) is too big (%d) ... aborting", count, max_count);
-	KUNIT_EXPECT_LE_MSG(test, expected, max_expected,
-		"expected (%d) is bigger than can possibly be returned (%d)",
-		expected, max_expected);
-
-	written = strscpy_pad(buf, src, count);
-	KUNIT_ASSERT_EQ(test, written, expected);
-
-	if (count && written == -E2BIG) {
-		KUNIT_ASSERT_EQ_MSG(test, 0, strncmp(buf, src, count - 1),
-			"buffer state invalid for -E2BIG");
-		KUNIT_ASSERT_EQ_MSG(test, buf[count - 1], '\0',
-			"too big string is not null terminated correctly");
-	}
-
-	for (i = 0; i < chars; i++)
-		KUNIT_ASSERT_EQ_MSG(test, buf[i], src[i],
-			"buf[i]==%c != src[i]==%c", buf[i], src[i]);
-
-	if (terminator)
-		KUNIT_ASSERT_EQ_MSG(test, buf[count - 1], '\0',
-			"string is not null terminated correctly");
-
-	for (i = 0; i < pad; i++) {
-		index = chars + terminator + i;
-		KUNIT_ASSERT_EQ_MSG(test, buf[index], '\0',
-			"padding missing at index: %d", i);
-	}
-
-	nr_bytes_poison = sizeof(buf) - chars - terminator - pad;
-	for (i = 0; i < nr_bytes_poison; i++) {
-		index = sizeof(buf) - 1 - i; /* Check from the end back */
-		KUNIT_ASSERT_EQ_MSG(test, buf[index], POISON,
-			"poison value missing at index: %d", i);
-	}
-}
-
-static void test_strscpy(struct kunit *test)
-{
-	char dest[8];
-
-	/*
-	 * strscpy_check() uses a destination buffer of size 6 and needs at
-	 * least 2 characters spare (one for null and one to check for
-	 * overflow).  This means we should only call tc() with
-	 * strings up to a maximum of 4 characters long and 'count'
-	 * should not exceed 4.  To test with longer strings increase
-	 * the buffer size in tc().
-	 */
-
-	/* strscpy_check(test, src, count, expected, chars, terminator, pad) */
-	strscpy_check(test, "a", 0, -E2BIG, 0, 0, 0);
-	strscpy_check(test, "",  0, -E2BIG, 0, 0, 0);
-
-	strscpy_check(test, "a", 1, -E2BIG, 0, 1, 0);
-	strscpy_check(test, "",  1, 0,	 0, 1, 0);
-
-	strscpy_check(test, "ab", 2, -E2BIG, 1, 1, 0);
-	strscpy_check(test, "a",  2, 1,	  1, 1, 0);
-	strscpy_check(test, "",   2, 0,	  0, 1, 1);
-
-	strscpy_check(test, "abc", 3, -E2BIG, 2, 1, 0);
-	strscpy_check(test, "ab",  3, 2,	   2, 1, 0);
-	strscpy_check(test, "a",   3, 1,	   1, 1, 1);
-	strscpy_check(test, "",    3, 0,	   0, 1, 2);
-
-	strscpy_check(test, "abcd", 4, -E2BIG, 3, 1, 0);
-	strscpy_check(test, "abc",  4, 3,	    3, 1, 0);
-	strscpy_check(test, "ab",   4, 2,	    2, 1, 1);
-	strscpy_check(test, "a",    4, 1,	    1, 1, 2);
-	strscpy_check(test, "",     4, 0,	    0, 1, 3);
-
-	/* Compile-time-known source strings. */
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 3), 0);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 1), 0);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "", 0), -E2BIG);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", ARRAY_SIZE(dest)), 5);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 3), -E2BIG);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 1), -E2BIG);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "Fixed", 0), -E2BIG);
-	KUNIT_EXPECT_EQ(test, strscpy(dest, "This is too long", ARRAY_SIZE(dest)), -E2BIG);
-}
-
-static struct kunit_case strscpy_test_cases[] = {
-	KUNIT_CASE(test_strscpy),
-	{}
-};
-
-static struct kunit_suite strscpy_test_suite = {
-	.name = "strscpy",
-	.test_cases = strscpy_test_cases,
-};
-
-kunit_test_suite(strscpy_test_suite);
-
-MODULE_AUTHOR("Tobin C. Harding <tobin@kernel.org>");
-MODULE_LICENSE("GPL");
-- 
2.34.1


