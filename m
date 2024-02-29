Return-Path: <linux-kernel+bounces-87699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5C86D7E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2210B22ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE8213E7C7;
	Thu, 29 Feb 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJF1zktF"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772E17545
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249734; cv=none; b=o5X2sbsXNME3DfWsNu2tzEY0wFgewiNveWQ8CW2WHztEjfoKfZq09XusZd1LZk8F3q0FzW6s4NuSeQHe2i05vmH1nitE9A4sd1IWAmPTE+mewONSATM1XHqWJWjT47awhJDhmsZRmyN6eoAsIjtjTnLifIbonVFiCUn0lWAudcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249734; c=relaxed/simple;
	bh=8AW6vpLoBsvSGGVQr6eadfqDgRiZzNtT+j+25yacYoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r5Lq4FDZpq4tXyHT2ft1nmwr2xARqpRItvN1rItL9bh5wlupwNqsDWBRDkieJhyGYZCxhZav9BBwz4ZlIUUhoI9vAYZ7otJmULPS2cYTnRkIdvnKrBtzbQtR3dqq6bM6nHB9p3T/KPTh1qwbafSDbpNxD//+3NSMDVj5omvIh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SJF1zktF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da202aa138so1085716b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709249732; x=1709854532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaSgUgfOZn9fgH6QcdlrLYMK12GQmmivaE6Pb6d2BPw=;
        b=SJF1zktFcDiqAD0ChmcC/e9AcZl2KgveVIA+u2XzhO/yqnsd2upDJKAzFO9TkGx0YB
         YOx1kMOfeHdS16x6asO8J38O9+qyrgpq8DsOPIvr/fH0qzXiMZbClw4vKJ/odSDHg7q9
         kjll02vL8c1yxFXZEt7GH+MZBPTijYwXvU6XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249732; x=1709854532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaSgUgfOZn9fgH6QcdlrLYMK12GQmmivaE6Pb6d2BPw=;
        b=E2FMoFZWtzj4K7iEb+MZXltVMEkBKzBqFog3IZdPgkq+kj4qLuYO9JGQkn+lwGM0ay
         AoAz38pTaA6ketqhydh0mdvK+GketdcF+4sg1kWaI847hA/ngyOCTrwmDtx/L4GT5zlV
         6H/plhqFwloz3B7KY4LFbUj4qHknIRsJ7j5v164/zYukoXkNhGw3WLi0V/7Nbf1CcmBT
         AbsYdKW5lHH053KJYIqgq6w2ehHupExfqbeiOTNSQMRN0LHkhqxhCgYdz5meuCobTmOi
         EVtuwOA9wB4P9dUX86i+u3t75WDZpgLInQOAnoI34jGOW8LTDaV551NwXn5fOy6zhB9g
         K19g==
X-Forwarded-Encrypted: i=1; AJvYcCVc91UVj9YkPZ9UJ6vq55hj5TCluz/hOHxs7Wg/QH7s6QN9FxBrvyr4Ch8cr/R8GOkqBHZy8/tvSf/ti/irj2WwQuQdZsrf1FYYdvSE
X-Gm-Message-State: AOJu0YyCsI3CSAICEtPDPOmmuYVMJ75R7vHXma4tVXpHIVzmCBCMJPST
	AZdUEDscMKs7GQC/mocuOSuV3GjhbKBOFmHIdOP+I3hZcykQwOCDAHUFYXRB1hABfR15MxSS7mw
	=
X-Google-Smtp-Source: AGHT+IE5B7mswf+4qUh2cf+dDQa1tBkBuEawV7F8OA8wSM4dkH/uSFxyG7LiHngrk0Q0ti87JOh+zA==
X-Received: by 2002:a05:6a00:929d:b0:6e5:8cc1:f75b with SMTP id jw29-20020a056a00929d00b006e58cc1f75bmr247230pfb.4.1709249732019;
        Thu, 29 Feb 2024 15:35:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y133-20020a62ce8b000000b006e45a0101basm1926356pfg.99.2024.02.29.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:35:29 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] string: Convert helpers selftest to KUnit
Date: Thu, 29 Feb 2024 15:35:24 -0800
Message-Id: <20240229233528.1538803-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229233432.work.675-kees@kernel.org>
References: <20240229233432.work.675-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13861; i=keescook@chromium.org;
 h=from:subject; bh=8AW6vpLoBsvSGGVQr6eadfqDgRiZzNtT+j+25yacYoY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4RS8pY37KRfK0m6BW6mkRvOBGJyKj4b3fBznP
 DPbMv/BUQuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEUvAAKCRCJcvTf3G3A
 JoheD/4ysCqHzF0OnapGBM5miH8aDv6O141tgCMfC0/53/u3YAtpJ9qyC23hmr1Q1D5rfy2Cw2P
 WJlBS29/i7mXfEZmdxQH8lNWHcbblmTZdj1aIbdbwiGPwrzW5GzK0i4NL/NPehKeYFT+YKSBhVU
 ACa2W4FloX21fDjlT5PSLOVL2JIBClNfxFg/L4Y0KuT1Nkia4rLmQRPJtD0QN3K42F4A5nWs2me
 FNYQiaDbAwmGEpbHc4LP5WBJcKsnAvg8UsOocRvXocqJQAv0AEPR21P6fXrQQNvwAV58jlKG4Ig
 CZMYkFbfs+f89b+leZpYs82cHx2eoQddQkq9dBgbSkH4QL7feUU1Lf9pNl++9C/8k2TUs6oAAtK
 yjJkSYC25Y0xf8nG8W1RI50hlGewF11i9VenOB2yREdNwvuFdLoIJggPvFsot4mvAIM0OupNsp9
 BglWt9plPqHmvE77rr45g4Cc6e0Gy8VAm/qaaYuLHZCFTQJze7xXq7Y0SOf8MQk5d4lONcMOGKv
 bVYYxZGbcAVElDIVWWBH2zUEamotjaYHyRFKUokCienmCJEbqxoBKOeHCG8GFBw8k8pVBDSqH1y
 eM25HkrIrqY7mJ9xSfxw0bNRzcnzFQjnLDVRc1gB0eW8y+4HFdyWv6FmcagLSZvpZx2bmTH9aUl UVlhf+lZvaLbLvA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert test-string_helpers.c to KUnit so it can be easily run with
everything else.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS                                   |   2 +-
 lib/Kconfig.debug                             |   6 +-
 lib/Makefile                                  |   2 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 160 ++++++++++--------
 4 files changed, 93 insertions(+), 77 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (79%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f1f68cccd6a..f3f26d2d4ffb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8978,7 +8978,7 @@ F:	include/linux/string_helpers.h
 F:	lib/string.c
 F:	lib/string_kunit.c
 F:	lib/string_helpers.c
-F:	lib/test-string_helpers.c
+F:	lib/string_helpers_kunit.c
 F:	scripts/coccinelle/api/string_choices.cocci
 
 GENERIC UIO DRIVER FOR PCI DEVICES
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 406cdf353488..5429e6f170f3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2357,8 +2357,10 @@ config STRING_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 
-config TEST_STRING_HELPERS
-	tristate "Test functions located in the string_helpers module at runtime"
+config STRING_HELPERS_KUNIT_TEST
+	tristate "KUnit test string helpers at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 
 config TEST_KSTRTOX
 	tristate "Test kstrto*() family of functions at runtime"
diff --git a/lib/Makefile b/lib/Makefile
index 946277c37831..97c42e38046f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -51,7 +51,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 generic-radix-tree.o bitmap-str.o
 obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-y += string_helpers.o
-obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
+obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
diff --git a/lib/test-string_helpers.c b/lib/string_helpers_kunit.c
similarity index 79%
rename from lib/test-string_helpers.c
rename to lib/string_helpers_kunit.c
index 9a68849a5d55..67d6703146c0 100644
--- a/lib/test-string_helpers.c
+++ b/lib/string_helpers_kunit.c
@@ -3,7 +3,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/init.h>
+#include <kunit/test.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -11,13 +11,21 @@
 #include <linux/string.h>
 #include <linux/string_helpers.h>
 
-static __init bool test_string_check_buf(const char *name, unsigned int flags,
-					 char *in, size_t p,
-					 char *out_real, size_t q_real,
-					 char *out_test, size_t q_test)
+static void test_string_check_buf(struct kunit *test,
+				  const char *name, unsigned int flags,
+				  char *in, size_t p,
+				  char *out_real, size_t q_real,
+				  char *out_test, size_t q_test)
 {
-	if (q_real == q_test && !memcmp(out_test, out_real, q_test))
-		return true;
+	int result;
+
+	KUNIT_EXPECT_EQ(test, q_real, q_test);
+
+	result = memcmp(out_test, out_real, q_test);
+	KUNIT_EXPECT_EQ(test, 0, result);
+
+	if (q_real == q_test && result == 0)
+		return;
 
 	pr_warn("Test '%s' failed: flags = %#x\n", name, flags);
 
@@ -27,8 +35,6 @@ static __init bool test_string_check_buf(const char *name, unsigned int flags,
 		       out_test, q_test, true);
 	print_hex_dump(KERN_WARNING, "Got: ", DUMP_PREFIX_NONE, 16, 1,
 		       out_real, q_real, true);
-
-	return false;
 }
 
 struct test_string {
@@ -37,7 +43,7 @@ struct test_string {
 	unsigned int flags;
 };
 
-static const struct test_string strings[] __initconst = {
+static const struct test_string strings[] = {
 	{
 		.in = "\\f\\ \\n\\r\\t\\v",
 		.out = "\f\\ \n\r\t\v",
@@ -60,8 +66,9 @@ static const struct test_string strings[] __initconst = {
 	},
 };
 
-static void __init test_string_unescape(const char *name, unsigned int flags,
-					bool inplace)
+static void test_string_unescape(struct kunit *test,
+				 const char *name, unsigned int flags,
+				 bool inplace)
 {
 	int q_real = 256;
 	char *in = kmalloc(q_real, GFP_KERNEL);
@@ -103,7 +110,7 @@ static void __init test_string_unescape(const char *name, unsigned int flags,
 		q_real = string_unescape(in, out_real, q_real, flags);
 	}
 
-	test_string_check_buf(name, flags, in, p - 1, out_real, q_real,
+	test_string_check_buf(test, name, flags, in, p - 1, out_real, q_real,
 			      out_test, q_test);
 out:
 	kfree(out_real);
@@ -123,7 +130,7 @@ struct test_string_2 {
 };
 
 #define	TEST_STRING_2_DICT_0		NULL
-static const struct test_string_2 escape0[] __initconst = {{
+static const struct test_string_2 escape0[] = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
 		.out = "\\f\\ \\n\\r\\t\\v",
@@ -221,7 +228,7 @@ static const struct test_string_2 escape0[] __initconst = {{
 }};
 
 #define	TEST_STRING_2_DICT_1		"b\\ \t\r\xCF"
-static const struct test_string_2 escape1[] __initconst = {{
+static const struct test_string_2 escape1[] = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
 		.out = "\f\\134\\040\n\\015\\011\v",
@@ -358,7 +365,7 @@ static const struct test_string_2 escape1[] __initconst = {{
 	/* terminator */
 }};
 
-static const struct test_string strings_upper[] __initconst = {
+static const struct test_string strings_upper[] = {
 	{
 		.in = "abcdefgh1234567890test",
 		.out = "ABCDEFGH1234567890TEST",
@@ -369,7 +376,7 @@ static const struct test_string strings_upper[] __initconst = {
 	},
 };
 
-static const struct test_string strings_lower[] __initconst = {
+static const struct test_string strings_lower[] = {
 	{
 		.in = "ABCDEFGH1234567890TEST",
 		.out = "abcdefgh1234567890test",
@@ -380,8 +387,8 @@ static const struct test_string strings_lower[] __initconst = {
 	},
 };
 
-static __init const char *test_string_find_match(const struct test_string_2 *s2,
-						 unsigned int flags)
+static const char *test_string_find_match(const struct test_string_2 *s2,
+					  unsigned int flags)
 {
 	const struct test_string_1 *s1 = s2->s1;
 	unsigned int i;
@@ -402,21 +409,20 @@ static __init const char *test_string_find_match(const struct test_string_2 *s2,
 	return NULL;
 }
 
-static __init void
-test_string_escape_overflow(const char *in, int p, unsigned int flags, const char *esc,
+static void
+test_string_escape_overflow(struct kunit *test,
+			    const char *in, int p, unsigned int flags, const char *esc,
 			    int q_test, const char *name)
 {
 	int q_real;
 
 	q_real = string_escape_mem(in, p, NULL, 0, flags, esc);
-	if (q_real != q_test)
-		pr_warn("Test '%s' failed: flags = %#x, osz = 0, expected %d, got %d\n",
-			name, flags, q_test, q_real);
+	KUNIT_EXPECT_EQ(test, q_real, q_test);
 }
 
-static __init void test_string_escape(const char *name,
-				      const struct test_string_2 *s2,
-				      unsigned int flags, const char *esc)
+static void test_string_escape(struct kunit *test, const char *name,
+			       const struct test_string_2 *s2,
+			       unsigned int flags, const char *esc)
 {
 	size_t out_size = 512;
 	char *out_test = kmalloc(out_size, GFP_KERNEL);
@@ -462,10 +468,10 @@ static __init void test_string_escape(const char *name,
 
 	q_real = string_escape_mem(in, p, out_real, out_size, flags, esc);
 
-	test_string_check_buf(name, flags, in, p, out_real, q_real, out_test,
+	test_string_check_buf(test, name, flags, in, p, out_real, q_real, out_test,
 			      q_test);
 
-	test_string_escape_overflow(in, p, flags, esc, q_test, name);
+	test_string_escape_overflow(test, in, p, flags, esc, q_test, name);
 
 out:
 	kfree(in);
@@ -474,22 +480,26 @@ static __init void test_string_escape(const char *name,
 }
 
 #define string_get_size_maxbuf 16
-#define test_string_get_size_one(size, blk_size, exp_result10, exp_result2)    \
-	do {                                                                   \
-		BUILD_BUG_ON(sizeof(exp_result10) >= string_get_size_maxbuf);  \
-		BUILD_BUG_ON(sizeof(exp_result2) >= string_get_size_maxbuf);   \
-		__test_string_get_size((size), (blk_size), (exp_result10),     \
-				       (exp_result2));                         \
+#define test_string_get_size_one(size, blk_size, exp_result10, exp_result2)      \
+	do {                                                                     \
+		BUILD_BUG_ON(sizeof(exp_result10) >= string_get_size_maxbuf);    \
+		BUILD_BUG_ON(sizeof(exp_result2) >= string_get_size_maxbuf);     \
+		__test_string_get_size(test, (size), (blk_size), (exp_result10), \
+				       (exp_result2));                           \
 	} while (0)
 
 
-static __init void test_string_get_size_check(const char *units,
-					      const char *exp,
-					      char *res,
-					      const u64 size,
-					      const u64 blk_size)
+static void test_string_get_size_check(struct kunit *test,
+				       const char *units,
+				       const char *exp,
+				       char *res,
+				       const u64 size,
+				       const u64 blk_size)
 {
-	if (!memcmp(res, exp, strlen(exp) + 1))
+	int result = memcmp(res, exp, strlen(exp) + 1);
+
+	KUNIT_EXPECT_EQ(test, 0, result);
+	if (!result)
 		return;
 
 	res[string_get_size_maxbuf - 1] = '\0';
@@ -500,9 +510,10 @@ static __init void test_string_get_size_check(const char *units,
 	pr_warn("expected: '%s', got '%s'\n", exp, res);
 }
 
-static __init void __test_string_get_size(const u64 size, const u64 blk_size,
-					  const char *exp_result10,
-					  const char *exp_result2)
+static void __test_string_get_size(struct kunit *test,
+				   const u64 size, const u64 blk_size,
+				   const char *exp_result10,
+				   const char *exp_result2)
 {
 	char buf10[string_get_size_maxbuf];
 	char buf2[string_get_size_maxbuf];
@@ -510,14 +521,14 @@ static __init void __test_string_get_size(const u64 size, const u64 blk_size,
 	string_get_size(size, blk_size, STRING_UNITS_10, buf10, sizeof(buf10));
 	string_get_size(size, blk_size, STRING_UNITS_2, buf2, sizeof(buf2));
 
-	test_string_get_size_check("STRING_UNITS_10", exp_result10, buf10,
+	test_string_get_size_check(test, "STRING_UNITS_10", exp_result10, buf10,
 				   size, blk_size);
 
-	test_string_get_size_check("STRING_UNITS_2", exp_result2, buf2,
+	test_string_get_size_check(test, "STRING_UNITS_2", exp_result2, buf2,
 				   size, blk_size);
 }
 
-static __init void test_string_get_size(void)
+static void test_get_size(struct kunit *test)
 {
 	/* small values */
 	test_string_get_size_one(0, 512, "0 B", "0 B");
@@ -537,7 +548,7 @@ static __init void test_string_get_size(void)
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
 }
 
-static void __init test_string_upper_lower(void)
+static void test_upper_lower(struct kunit *test)
 {
 	char *dst;
 	int i;
@@ -545,65 +556,68 @@ static void __init test_string_upper_lower(void)
 	for (i = 0; i < ARRAY_SIZE(strings_upper); i++) {
 		const char *s = strings_upper[i].in;
 		int len = strlen(strings_upper[i].in) + 1;
+		int result;
 
 		dst = kmalloc(len, GFP_KERNEL);
-		if (!dst)
-			return;
+		KUNIT_ASSERT_NOT_NULL(test, dst);
 
 		string_upper(dst, s);
-		if (memcmp(dst, strings_upper[i].out, len)) {
+		result = memcmp(dst, strings_upper[i].out, len);
+		KUNIT_EXPECT_EQ(test, 0, result);
+		if (result)
 			pr_warn("Test 'string_upper' failed : expected %s, got %s!\n",
 				strings_upper[i].out, dst);
-			kfree(dst);
-			return;
-		}
 		kfree(dst);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(strings_lower); i++) {
 		const char *s = strings_lower[i].in;
 		int len = strlen(strings_lower[i].in) + 1;
+		int result;
 
 		dst = kmalloc(len, GFP_KERNEL);
-		if (!dst)
-			return;
+		KUNIT_ASSERT_NOT_NULL(test, dst);
 
 		string_lower(dst, s);
-		if (memcmp(dst, strings_lower[i].out, len)) {
+		result = memcmp(dst, strings_lower[i].out, len);
+		KUNIT_EXPECT_EQ(test, 0, result);
+		if (result)
 			pr_warn("Test 'string_lower failed : : expected %s, got %s!\n",
 				strings_lower[i].out, dst);
-			kfree(dst);
-			return;
-		}
 		kfree(dst);
 	}
 }
 
-static int __init test_string_helpers_init(void)
+static void test_unescape(struct kunit *test)
 {
 	unsigned int i;
 
-	pr_info("Running tests...\n");
 	for (i = 0; i < UNESCAPE_ALL_MASK + 1; i++)
-		test_string_unescape("unescape", i, false);
-	test_string_unescape("unescape inplace",
+		test_string_unescape(test, "unescape", i, false);
+	test_string_unescape(test, "unescape inplace",
 			     get_random_u32_below(UNESCAPE_ALL_MASK + 1), true);
 
 	/* Without dictionary */
 	for (i = 0; i < ESCAPE_ALL_MASK + 1; i++)
-		test_string_escape("escape 0", escape0, i, TEST_STRING_2_DICT_0);
+		test_string_escape(test, "escape 0", escape0, i, TEST_STRING_2_DICT_0);
 
 	/* With dictionary */
 	for (i = 0; i < ESCAPE_ALL_MASK + 1; i++)
-		test_string_escape("escape 1", escape1, i, TEST_STRING_2_DICT_1);
+		test_string_escape(test, "escape 1", escape1, i, TEST_STRING_2_DICT_1);
+}
+
+static struct kunit_case string_helpers_test_cases[] = {
+	KUNIT_CASE(test_get_size),
+	KUNIT_CASE(test_upper_lower),
+	KUNIT_CASE(test_unescape),
+	{}
+};
 
-	/* Test string_get_size() */
-	test_string_get_size();
+static struct kunit_suite string_helpers_test_suite = {
+	.name = "string_helpers",
+	.test_cases = string_helpers_test_cases,
+};
 
-	/* Test string upper(), string_lower() */
-	test_string_upper_lower();
+kunit_test_suites(&string_helpers_test_suite);
 
-	return -EINVAL;
-}
-module_init(test_string_helpers_init);
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


