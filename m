Return-Path: <linux-kernel+bounces-87732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4386D84D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767CF1F2318D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604317E1;
	Fri,  1 Mar 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g9Wd+5g/"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585E631
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252816; cv=none; b=s5cG+vRn9tk5eImUu5OC4Olxn2kRq+fXNXVIFW1udLmrYZSk/OENWYRxq+KBcMKhSWCsKe8ORSpQLdSXArEg174vqT5VYp4cGKINXjxulfC7RnBF3iCnh/NDTDuESzo4F+QTzqvlXtfU+mxuz4u4V0uiOLbZM4AWONIcy7BbDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252816; c=relaxed/simple;
	bh=KDDjoM6A5PAucF/jTCWxQ0PKblp1gjUY4Bj03CQrEXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKdPU+B8LYsMn/Vf5YUFSAF8M9Nfcsw4D8L/XUO9sHhptzG2NOMSJktxJYIk0BAGhpGFH9hrzqblD6hSs+2BB0yUax8X4U+wsRnWIzJNzfWV43GMKueV/gsOXsU//i80iax+EVWnQlNQbIG+5pyzzjE6TdOfuYLZDSJOz7TgEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g9Wd+5g/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da9c834646so1284215b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709252814; x=1709857614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7bRmosJbyZC7ndFguV6EJboVLhr8lLHSQFdlQ3jzWE=;
        b=g9Wd+5g/iVb+bPitYJXzCGKfdixrdch1eNoIHkYTQNOrP1TqIVB5Mh4wunV6Y4xLgD
         u7OTZiY+PIfcUO6SgCG+kqteGWWFDsnmSm+o7DcBujX+ngOAW1JoPtvUkFBTlmVVXcUd
         LtgCc3ZkP0BghJC+E92eQ3ePDyRv/WxCb9sf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252814; x=1709857614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7bRmosJbyZC7ndFguV6EJboVLhr8lLHSQFdlQ3jzWE=;
        b=QpiOGTbnuqsKm+S+QDk43mv2z9fNH2bXeQQLVhwQq0M3SS1t9+hLDHhnPRtfM8c4yR
         NzAJ1RI+aS1EHm2UszlsnuVRLTWCTQMQ/wgfcLR+AZjam4vEMERaG4LWfrOWuTjShusv
         xdhYxC1xznZU3rYYcO94guBrmQ6k+7WLLX7//tT1f7uEg/ngOLYXd6Sxbi1QHJXY/26e
         6h3BOiPQIaleSqptyYFt8IhUFRUqpTAttMWTRHKLNUbcY8MOnp10zpyALZgQuKzI3hYn
         j/TYo0mBrylfNF+AwVtKqW5a2V8q3ABVaVMnwYXVvLq1hJ2gkIDNAIFuRk6LE79lSj5j
         RSFA==
X-Forwarded-Encrypted: i=1; AJvYcCVNFJusOgzUWnoRo7uC1Y4EKfo47P7lNviiut4pVZpoht1XWNWI+Ogp1/seyLKfH67D0bbN5vbAu7KaL3An8Jvcy+QU/LpDUYKl+ktz
X-Gm-Message-State: AOJu0YxT83besWeMWp1UJZtE9vZMu4LBc8eeABGTlTL47Foxc0sqQ+bb
	mPs3MyQcdNXOQltoKp795MGQbKU3pm6h93GQy7eZvCq5UsZwaT0VnAia/aGhVQ==
X-Google-Smtp-Source: AGHT+IEFck/4RuZec23JUkAngqfrVx8YBgBtsPV1rE252GXcqZs+EtAiO2ImDV4mhSoxT61evxAxAg==
X-Received: by 2002:a05:6a21:3288:b0:1a0:9ab5:1e83 with SMTP id yt8-20020a056a21328800b001a09ab51e83mr36196pzb.24.1709252813623;
        Thu, 29 Feb 2024 16:26:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oe1-20020a17090b394100b0029929dca278sm4249147pjb.16.2024.02.29.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:26:50 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] string: Convert helpers selftest to KUnit
Date: Thu, 29 Feb 2024 16:26:48 -0800
Message-Id: <20240301002650.1544829-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301002416.it.092-kees@kernel.org>
References: <20240301002416.it.092-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15224; i=keescook@chromium.org;
 h=from:subject; bh=KDDjoM6A5PAucF/jTCWxQ0PKblp1gjUY4Bj03CQrEXo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4SDI5Kz4zXaH8+qTFLSxONpT1sbN6feRXpVsc
 QeLAK+W6G6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeEgyAAKCRCJcvTf3G3A
 JnxUD/9a02Wuryk8/8zvgKX5QeBB7lKP1KY2QINTt0kSaafqjtcBy901aaD4Vt5YeVcvKuGvlLs
 CU33MIrTYtqqKH6EPSyo1URO02/iUDzm29eHP7jEPhgIw3YNCY/cZ8BBBeMcP8cjBNpRweW0ElE
 Ed61l9noS4bFeATRvEsEBctXJxeeWRL9Mpueal0p0dt5lwI+xnqLk5aFLbgmQibfpH+zEy4Ct/M
 NPx9nuPB7MeLPr7o+RGKrZLTQplCZXZKr1GAD6YSWzNcC0u5APIsmng8i/GF3Q3P8nq65hV8FOU
 +dtX0VGnJ7qg2QwbC5lrHcclW9YLgWIHR/xfT2EdyG48HoQNpbHwkGEhW4e7uhqeO8FV40bGQmJ
 mj8937jKtzdFIwqyyoW5qKWQ9kWyMqiTq5H6MX0YVrahxWbscuCSSl8ZGRZoY/pqe8enwLjfa5q
 G2nWQbTSc0rvgkm3tKxm+/W9mGpH3pjmGkiHV20mgdlQ28YoGm1nXXX1nwHErA9CTfa56+YW/vH
 vXFAh9B8bOnywK7BlNKhWLvtG1dLe8TzWjsxvufhqsmeezGk5nGhZCDaUIIqF6XLyq3dvgrEbyp
 d2HQtxrbravC5gHD1im6sHAMb4czItbvKyyyM0TIfPeFhy3nPHZMczaqqjobvKVqhg5fz+zY0B8 Q4vnclsJpa3/eCg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert test-string_helpers.c to KUnit so it can be easily run with
everything else.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS                                   |   2 +-
 lib/Kconfig.debug                             |   6 +-
 lib/Makefile                                  |   2 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 177 ++++++++++--------
 4 files changed, 103 insertions(+), 84 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (78%)

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
similarity index 78%
rename from lib/test-string_helpers.c
rename to lib/string_helpers_kunit.c
index dce67698297b..1fed4fa38f97 100644
--- a/lib/test-string_helpers.c
+++ b/lib/string_helpers_kunit.c
@@ -3,8 +3,9 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/array_size.h>
 #include <linux/init.h>
+#include <kunit/test.h>
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -12,13 +13,21 @@
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
 
@@ -28,8 +37,6 @@ static __init bool test_string_check_buf(const char *name, unsigned int flags,
 		       out_test, q_test, true);
 	print_hex_dump(KERN_WARNING, "Got: ", DUMP_PREFIX_NONE, 16, 1,
 		       out_real, q_real, true);
-
-	return false;
 }
 
 struct test_string {
@@ -38,7 +45,7 @@ struct test_string {
 	unsigned int flags;
 };
 
-static const struct test_string strings[] __initconst = {
+static const struct test_string strings[] = {
 	{
 		.in = "\\f\\ \\n\\r\\t\\v",
 		.out = "\f\\ \n\r\t\v",
@@ -61,8 +68,9 @@ static const struct test_string strings[] __initconst = {
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
@@ -104,7 +112,7 @@ static void __init test_string_unescape(const char *name, unsigned int flags,
 		q_real = string_unescape(in, out_real, q_real, flags);
 	}
 
-	test_string_check_buf(name, flags, in, p - 1, out_real, q_real,
+	test_string_check_buf(test, name, flags, in, p - 1, out_real, q_real,
 			      out_test, q_test);
 out:
 	kfree(out_real);
@@ -124,7 +132,7 @@ struct test_string_2 {
 };
 
 #define	TEST_STRING_2_DICT_0		NULL
-static const struct test_string_2 escape0[] __initconst = {{
+static const struct test_string_2 escape0[] = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
 		.out = "\\f\\ \\n\\r\\t\\v",
@@ -222,7 +230,7 @@ static const struct test_string_2 escape0[] __initconst = {{
 }};
 
 #define	TEST_STRING_2_DICT_1		"b\\ \t\r\xCF"
-static const struct test_string_2 escape1[] __initconst = {{
+static const struct test_string_2 escape1[] = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
 		.out = "\f\\134\\040\n\\015\\011\v",
@@ -359,7 +367,7 @@ static const struct test_string_2 escape1[] __initconst = {{
 	/* terminator */
 }};
 
-static const struct test_string strings_upper[] __initconst = {
+static const struct test_string strings_upper[] = {
 	{
 		.in = "abcdefgh1234567890test",
 		.out = "ABCDEFGH1234567890TEST",
@@ -370,7 +378,7 @@ static const struct test_string strings_upper[] __initconst = {
 	},
 };
 
-static const struct test_string strings_lower[] __initconst = {
+static const struct test_string strings_lower[] = {
 	{
 		.in = "ABCDEFGH1234567890TEST",
 		.out = "abcdefgh1234567890test",
@@ -381,8 +389,8 @@ static const struct test_string strings_lower[] __initconst = {
 	},
 };
 
-static __init const char *test_string_find_match(const struct test_string_2 *s2,
-						 unsigned int flags)
+static const char *test_string_find_match(const struct test_string_2 *s2,
+					  unsigned int flags)
 {
 	const struct test_string_1 *s1 = s2->s1;
 	unsigned int i;
@@ -403,21 +411,20 @@ static __init const char *test_string_find_match(const struct test_string_2 *s2,
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
@@ -463,10 +470,10 @@ static __init void test_string_escape(const char *name,
 
 	q_real = string_escape_mem(in, p, out_real, out_size, flags, esc);
 
-	test_string_check_buf(name, flags, in, p, out_real, q_real, out_test,
+	test_string_check_buf(test, name, flags, in, p, out_real, q_real, out_test,
 			      q_test);
 
-	test_string_escape_overflow(in, p, flags, esc, q_test, name);
+	test_string_escape_overflow(test, in, p, flags, esc, q_test, name);
 
 out:
 	kfree(in);
@@ -475,22 +482,26 @@ static __init void test_string_escape(const char *name,
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
@@ -501,7 +512,7 @@ static __init void test_string_get_size_check(const char *units,
 	pr_warn("expected: '%s', got '%s'\n", exp, res);
 }
 
-static __init void __strchrcut(char *dst, const char *src, const char *cut)
+static void __strchrcut(char *dst, const char *src, const char *cut)
 {
 	const char *from = src;
 	size_t len;
@@ -515,11 +526,12 @@ static __init void __strchrcut(char *dst, const char *src, const char *cut)
 	*dst = '\0';
 }
 
-static __init void __test_string_get_size_one(const u64 size, const u64 blk_size,
-					      const char *exp_result10,
-					      const char *exp_result2,
-					      enum string_size_units units,
-					      const char *cut)
+static void __test_string_get_size_one(struct kunit *test,
+				       const u64 size, const u64 blk_size,
+				       const char *exp_result10,
+				       const char *exp_result2,
+				       enum string_size_units units,
+				       const char *cut)
 {
 	char buf10[string_get_size_maxbuf];
 	char buf2[string_get_size_maxbuf];
@@ -537,13 +549,14 @@ static __init void __test_string_get_size_one(const u64 size, const u64 blk_size
 	string_get_size(size, blk_size, STRING_UNITS_10 | units, buf10, sizeof(buf10));
 	string_get_size(size, blk_size, STRING_UNITS_2 | units, buf2, sizeof(buf2));
 
-	test_string_get_size_check(prefix10, exp10, buf10, size, blk_size);
-	test_string_get_size_check(prefix2, exp2, buf2, size, blk_size);
+	test_string_get_size_check(test, prefix10, exp10, buf10, size, blk_size);
+	test_string_get_size_check(test, prefix2, exp2, buf2, size, blk_size);
 }
 
-static __init void __test_string_get_size(const u64 size, const u64 blk_size,
-					  const char *exp_result10,
-					  const char *exp_result2)
+static void __test_string_get_size(struct kunit *test,
+				   const u64 size, const u64 blk_size,
+				   const char *exp_result10,
+				   const char *exp_result2)
 {
 	struct {
 		enum string_size_units units;
@@ -557,12 +570,13 @@ static __init void __test_string_get_size(const u64 size, const u64 blk_size,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(get_size_test_cases); i++)
-		__test_string_get_size_one(size, blk_size, exp_result10, exp_result2,
+		__test_string_get_size_one(test, size, blk_size,
+					   exp_result10, exp_result2,
 					   get_size_test_cases[i].units,
 					   get_size_test_cases[i].cut);
 }
 
-static __init void test_string_get_size(void)
+static void test_get_size(struct kunit *test)
 {
 	/* small values */
 	test_string_get_size_one(0, 512, "0 B", "0 B");
@@ -582,7 +596,7 @@ static __init void test_string_get_size(void)
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
 }
 
-static void __init test_string_upper_lower(void)
+static void test_upper_lower(struct kunit *test)
 {
 	char *dst;
 	int i;
@@ -590,65 +604,68 @@ static void __init test_string_upper_lower(void)
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
 
-	/* Test string_get_size() */
-	test_string_get_size();
+static struct kunit_case string_helpers_test_cases[] = {
+	KUNIT_CASE(test_get_size),
+	KUNIT_CASE(test_upper_lower),
+	KUNIT_CASE(test_unescape),
+	{}
+};
 
-	/* Test string upper(), string_lower() */
-	test_string_upper_lower();
+static struct kunit_suite string_helpers_test_suite = {
+	.name = "string_helpers",
+	.test_cases = string_helpers_test_cases,
+};
+
+kunit_test_suites(&string_helpers_test_suite);
 
-	return -EINVAL;
-}
-module_init(test_string_helpers_init);
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


