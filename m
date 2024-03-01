Return-Path: <linux-kernel+bounces-89085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13B86EA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC94D1F235F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98C3D0BC;
	Fri,  1 Mar 2024 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iSz/cKB4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E63C470
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324857; cv=none; b=ClC5YryhJzXSsYJwh7mptUUEPAkMmDNc0w5h3qASmWaACQ4EMh/Z798HtZaMETDbBlnssNWp/qKn71h2KbQ+pg2ycbHq0WOoJ/cyzEeMRqktEdMEtix78S/h3x//YLrYmwisWDyZN2A6vVqf/CJe748eestVNuxjMQdFywmInCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324857; c=relaxed/simple;
	bh=WI2CgIw9rdflWWSy0zWA8s7YyBxlDqey+Uf+AJqyeQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+fe5BkFbF1EuSzQ0pR2fwWTlrTuoujXqh/6RW5WcUdSjqZS4AlMAfcDtmRlbJeqfYrNbsH5QmnYpKmc5thNFlqy7p98xNkeYqvphUEoo/N0WF5pjCcubIgnqq3AFZFNFvPyPYx6fFZ/AkAp9gWoguQLmNl9/IBgmSlQA9gPxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iSz/cKB4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dcad814986so22539925ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709324854; x=1709929654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e43Oy1VJb2rh5tC+uRZesllR18sa6QyvpjGCw0Qb8JA=;
        b=iSz/cKB44q+Se9EGJBWfXW84wNg24pb8hSWrUXwTGgx+n1LlvdycmTexf+YHFD3CuR
         bIgSWacCk3YqYy97NpIEvHnAMJH2HNPR96lpV1QaBkC/pDva4HmQo5kQoSff/cdH3Fub
         I4PMZiRrCVsMgn9sFCf/v/pKfkSPa9dQ/44gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324854; x=1709929654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e43Oy1VJb2rh5tC+uRZesllR18sa6QyvpjGCw0Qb8JA=;
        b=Tvvud0I7MHirmGR34fQ+hg95qCEIIn1m9n2nkl0y2LJoejvBaKLAxvMYQP057VYJNl
         rYP4aOKlH4Cu3g26RTjMTOR1JBwtcOv2aoHx0QgLQxDFLo6w4tR0BaAnis/ZDteqyxqz
         YThuIgmxmoZxeZoIv54GopLs2iktViAs/AukHrALe7dERkapTRp4Z0k7fZwYb3RbiE3v
         He+KettUrDhEhcdZVOiKZVPHN7hF6F209s73PDFnBDmavvg45RGTxSqxhEmul+uSmLk0
         5XyQU8rIqoxrpNjzc3JabGLk/h4/kqvamVS7ydLCo3gk45rKI/Dw+WWN3neMQgyrHqa4
         e8yA==
X-Forwarded-Encrypted: i=1; AJvYcCW4uZqKLg8xg/CY5psMwMcTkAxhzXw3h+8Wki6gYuXbBdgGM0lxogZGo6MHaFBcaxkLGBMY26cw3Jb1Px7ncd5Skz8ODeQtYV9resGJ
X-Gm-Message-State: AOJu0YxMU03L78QQV8dScmkyj6sO2hnnknv42Ib7EmDHko7+DbWEs7Nw
	RKQ6NpfVhMZxk778C+JEWARzWuo/k58WTO+XviWwgi8kDwfWNKUX3EvNjRpzkpxc8ldOKVe2l2s
	=
X-Google-Smtp-Source: AGHT+IEcmLPHCY7iAOfIyILJFDBxVuX+lcL41ko/Px1/lT2QlVA0ycrl8dSGmRvttQs2d0mK+r4Qgw==
X-Received: by 2002:a17:902:e849:b0:1dc:a681:ca08 with SMTP id t9-20020a170902e84900b001dca681ca08mr2730378plg.28.1709324854497;
        Fri, 01 Mar 2024 12:27:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju16-20020a170903429000b001db5ecd115bsm3882815plb.276.2024.03.01.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:27:33 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 2/2] string: Convert helpers selftest to KUnit
Date: Fri,  1 Mar 2024 12:27:31 -0800
Message-Id: <20240301202732.2688342-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301202524.make.800-kees@kernel.org>
References: <20240301202524.make.800-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17432; i=keescook@chromium.org;
 h=from:subject; bh=WI2CgIw9rdflWWSy0zWA8s7YyBxlDqey+Uf+AJqyeQs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4jozuLu7YIfN+Fw/yCXN12+wlzlDkxX5fEo5L
 nXUdMWNu+SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeI6MwAKCRCJcvTf3G3A
 JslrD/9FJwTVshjXuVhWvBF22g+VZ/uAtIQdQdZ7JFx9C0alntuyMm7T6JvRlAVqagQ1ipFdedz
 O6K2Eg5FnWXQGePYNmwaEMqsPBacR0U2N6MFqeq8QSSc3cuoaGq34qN7lSm8Q1NXN02bhaliUAb
 1uLdhNGxuigZiOuj3DC9gjh53jYOyTrgjaPmpC9f2HSdfo3eoqEDi61ripe2zThfd4k2zd16M3q
 08RfVQom5dETF04jYaVpBSbs5Y058iPNC/IzdOlkkd3SOVEL/pMP9LoV3NQDxxE5k5vinV3eC4V
 AOHq62HlPAOLduZ5TI1Fr2SMnL0jvL/9Pptpser0NU8nLkP79cP+30Z0bfqNr+1T8JQRcYQ9don
 JH3XrVEdUC787+V+AHTEqLeoLZeyjGWcs3aDwcEy0w/UHudoMZeNfxqDgS6qUbJ2OX5Koujfb13
 aJQVdqAuFtZIa8YAVnU6ycNSnmji/GZvwMvo7BakdeRO1E+GFVUZyMJNTHxtFDIHeQtHGK/wi3K
 qmU+2/yDKsaehEggaSw/8xHYrrJQy4wn5XuNNjnraNUiWozRz1DhuyS8tVz0bcFiX/TD4x8nxTy
 K7xIjNvM044/7SauK8YewyXztsOS8vUnbMPS7bKSOfVm3CdkHkyATVvrL0UJzn7jrV5xwiAlRzR 2jKVkP7KH1vC4RA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert test-string_helpers.c to KUnit so it can be easily run with
everything else.

Failure reporting doesn't need to be open-coded in most places, for
example, forcing a failure in the expected output for upper/lower
testing looks like this:

[12:18:43] # test_upper_lower: EXPECTATION FAILED at lib/string_helpers_kunit.c:579
[12:18:43] Expected dst == strings_upper[i].out, but
[12:18:43]     dst == "ABCDEFGH1234567890TEST"
[12:18:43]     strings_upper[i].out == "ABCDEFGH1234567890TeST"
[12:18:43] [FAILED] test_upper_lower

Currently passes without problems:

$ ./tools/testing/kunit/kunit.py run string_helpers
..
[12:23:55] Starting KUnit Kernel (1/1)...
[12:23:55] ============================================================
[12:23:55] =============== string_helpers (3 subtests) ================
[12:23:55] [PASSED] test_get_size
[12:23:55] [PASSED] test_upper_lower
[12:23:55] [PASSED] test_unescape
[12:23:55] ================= [PASSED] string_helpers ==================
[12:23:55] ============================================================
[12:23:55] Testing complete. Ran 3 tests: passed: 3
[12:23:55] Elapsed time: 6.709s total, 0.001s configuring, 6.591s building, 0.066s running

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
---
 MAINTAINERS                                   |   2 +-
 lib/Kconfig.debug                             |   6 +-
 lib/Makefile                                  |   2 +-
 ...tring_helpers.c => string_helpers_kunit.c} | 216 ++++++++----------
 4 files changed, 101 insertions(+), 125 deletions(-)
 rename lib/{test-string_helpers.c => string_helpers_kunit.c} (72%)

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
similarity index 72%
rename from lib/test-string_helpers.c
rename to lib/string_helpers_kunit.c
index dce67698297b..f88e39fd68d6 100644
--- a/lib/test-string_helpers.c
+++ b/lib/string_helpers_kunit.c
@@ -1,35 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Test cases for lib/string_helpers.c module.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/array_size.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/random.h>
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
-
-	pr_warn("Test '%s' failed: flags = %#x\n", name, flags);
-
-	print_hex_dump(KERN_WARNING, "Input: ", DUMP_PREFIX_NONE, 16, 1,
-		       in, p, true);
-	print_hex_dump(KERN_WARNING, "Expected: ", DUMP_PREFIX_NONE, 16, 1,
-		       out_test, q_test, true);
-	print_hex_dump(KERN_WARNING, "Got: ", DUMP_PREFIX_NONE, 16, 1,
-		       out_real, q_real, true);
-
-	return false;
+	KUNIT_ASSERT_EQ_MSG(test, q_real, q_test, "name:%s", name);
+	KUNIT_EXPECT_MEMEQ_MSG(test, out_test, out_real, q_test,
+			       "name:%s", name);
 }
 
 struct test_string {
@@ -38,7 +28,7 @@ struct test_string {
 	unsigned int flags;
 };
 
-static const struct test_string strings[] __initconst = {
+static const struct test_string strings[] = {
 	{
 		.in = "\\f\\ \\n\\r\\t\\v",
 		.out = "\f\\ \n\r\t\v",
@@ -61,17 +51,19 @@ static const struct test_string strings[] __initconst = {
 	},
 };
 
-static void __init test_string_unescape(const char *name, unsigned int flags,
-					bool inplace)
+static void test_string_unescape(struct kunit *test,
+				 const char *name, unsigned int flags,
+				 bool inplace)
 {
 	int q_real = 256;
-	char *in = kmalloc(q_real, GFP_KERNEL);
-	char *out_test = kmalloc(q_real, GFP_KERNEL);
-	char *out_real = kmalloc(q_real, GFP_KERNEL);
+	char *in = kunit_kzalloc(test, q_real, GFP_KERNEL);
+	char *out_test = kunit_kzalloc(test, q_real, GFP_KERNEL);
+	char *out_real = kunit_kzalloc(test, q_real, GFP_KERNEL);
 	int i, p = 0, q_test = 0;
 
-	if (!in || !out_test || !out_real)
-		goto out;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, in);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out_test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out_real);
 
 	for (i = 0; i < ARRAY_SIZE(strings); i++) {
 		const char *s = strings[i].in;
@@ -104,12 +96,8 @@ static void __init test_string_unescape(const char *name, unsigned int flags,
 		q_real = string_unescape(in, out_real, q_real, flags);
 	}
 
-	test_string_check_buf(name, flags, in, p - 1, out_real, q_real,
+	test_string_check_buf(test, name, flags, in, p - 1, out_real, q_real,
 			      out_test, q_test);
-out:
-	kfree(out_real);
-	kfree(out_test);
-	kfree(in);
 }
 
 struct test_string_1 {
@@ -124,7 +112,7 @@ struct test_string_2 {
 };
 
 #define	TEST_STRING_2_DICT_0		NULL
-static const struct test_string_2 escape0[] __initconst = {{
+static const struct test_string_2 escape0[] = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
 		.out = "\\f\\ \\n\\r\\t\\v",
@@ -222,7 +210,7 @@ static const struct test_string_2 escape0[] __initconst = {{
 }};
 
 #define	TEST_STRING_2_DICT_1		"b\\ \t\r\xCF"
-static const struct test_string_2 escape1[] __initconst = {{
+static const struct test_string_2 escape1[] = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
 		.out = "\f\\134\\040\n\\015\\011\v",
@@ -359,7 +347,7 @@ static const struct test_string_2 escape1[] __initconst = {{
 	/* terminator */
 }};
 
-static const struct test_string strings_upper[] __initconst = {
+static const struct test_string strings_upper[] = {
 	{
 		.in = "abcdefgh1234567890test",
 		.out = "ABCDEFGH1234567890TEST",
@@ -370,7 +358,7 @@ static const struct test_string strings_upper[] __initconst = {
 	},
 };
 
-static const struct test_string strings_lower[] __initconst = {
+static const struct test_string strings_lower[] = {
 	{
 		.in = "ABCDEFGH1234567890TEST",
 		.out = "abcdefgh1234567890test",
@@ -381,8 +369,8 @@ static const struct test_string strings_lower[] __initconst = {
 	},
 };
 
-static __init const char *test_string_find_match(const struct test_string_2 *s2,
-						 unsigned int flags)
+static const char *test_string_find_match(const struct test_string_2 *s2,
+					  unsigned int flags)
 {
 	const struct test_string_1 *s1 = s2->s1;
 	unsigned int i;
@@ -403,31 +391,31 @@ static __init const char *test_string_find_match(const struct test_string_2 *s2,
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
+	KUNIT_EXPECT_EQ_MSG(test, q_real, q_test, "name:%s: flags:%#x", name, flags);
 }
 
-static __init void test_string_escape(const char *name,
-				      const struct test_string_2 *s2,
-				      unsigned int flags, const char *esc)
+static void test_string_escape(struct kunit *test, const char *name,
+			       const struct test_string_2 *s2,
+			       unsigned int flags, const char *esc)
 {
 	size_t out_size = 512;
-	char *out_test = kmalloc(out_size, GFP_KERNEL);
-	char *out_real = kmalloc(out_size, GFP_KERNEL);
-	char *in = kmalloc(256, GFP_KERNEL);
+	char *out_test = kunit_kzalloc(test, out_size, GFP_KERNEL);
+	char *out_real = kunit_kzalloc(test, out_size, GFP_KERNEL);
+	char *in = kunit_kzalloc(test, 256, GFP_KERNEL);
 	int p = 0, q_test = 0;
 	int q_real;
 
-	if (!out_test || !out_real || !in)
-		goto out;
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out_test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, out_real);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, in);
 
 	for (; s2->in; s2++) {
 		const char *out;
@@ -463,45 +451,35 @@ static __init void test_string_escape(const char *name,
 
 	q_real = string_escape_mem(in, p, out_real, out_size, flags, esc);
 
-	test_string_check_buf(name, flags, in, p, out_real, q_real, out_test,
+	test_string_check_buf(test, name, flags, in, p, out_real, q_real, out_test,
 			      q_test);
 
-	test_string_escape_overflow(in, p, flags, esc, q_test, name);
-
-out:
-	kfree(in);
-	kfree(out_real);
-	kfree(out_test);
+	test_string_escape_overflow(test, in, p, flags, esc, q_test, name);
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
-		return;
-
-	res[string_get_size_maxbuf - 1] = '\0';
-
-	pr_warn("Test 'test_string_get_size' failed!\n");
-	pr_warn("string_get_size(size = %llu, blk_size = %llu, units = %s)\n",
+	KUNIT_EXPECT_MEMEQ_MSG(test, res, exp, strlen(exp) + 1,
+		"string_get_size(size = %llu, blk_size = %llu, units = %s)",
 		size, blk_size, units);
-	pr_warn("expected: '%s', got '%s'\n", exp, res);
 }
 
-static __init void __strchrcut(char *dst, const char *src, const char *cut)
+static void __strchrcut(char *dst, const char *src, const char *cut)
 {
 	const char *from = src;
 	size_t len;
@@ -515,11 +493,12 @@ static __init void __strchrcut(char *dst, const char *src, const char *cut)
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
@@ -537,13 +516,14 @@ static __init void __test_string_get_size_one(const u64 size, const u64 blk_size
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
@@ -557,12 +537,13 @@ static __init void __test_string_get_size(const u64 size, const u64 blk_size,
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
@@ -582,7 +563,7 @@ static __init void test_string_get_size(void)
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
 }
 
-static void __init test_string_upper_lower(void)
+static void test_upper_lower(struct kunit *test)
 {
 	char *dst;
 	int i;
@@ -592,16 +573,10 @@ static void __init test_string_upper_lower(void)
 		int len = strlen(strings_upper[i].in) + 1;
 
 		dst = kmalloc(len, GFP_KERNEL);
-		if (!dst)
-			return;
+		KUNIT_ASSERT_NOT_NULL(test, dst);
 
 		string_upper(dst, s);
-		if (memcmp(dst, strings_upper[i].out, len)) {
-			pr_warn("Test 'string_upper' failed : expected %s, got %s!\n",
-				strings_upper[i].out, dst);
-			kfree(dst);
-			return;
-		}
+		KUNIT_EXPECT_STREQ(test, dst, strings_upper[i].out);
 		kfree(dst);
 	}
 
@@ -610,45 +585,44 @@ static void __init test_string_upper_lower(void)
 		int len = strlen(strings_lower[i].in) + 1;
 
 		dst = kmalloc(len, GFP_KERNEL);
-		if (!dst)
-			return;
+		KUNIT_ASSERT_NOT_NULL(test, dst);
 
 		string_lower(dst, s);
-		if (memcmp(dst, strings_lower[i].out, len)) {
-			pr_warn("Test 'string_lower failed : : expected %s, got %s!\n",
-				strings_lower[i].out, dst);
-			kfree(dst);
-			return;
-		}
+		KUNIT_EXPECT_STREQ(test, dst, strings_lower[i].out);
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


