Return-Path: <linux-kernel+bounces-89084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE4486EA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A94AB28CF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985263C48C;
	Fri,  1 Mar 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kF5LUqKn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8613C464
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324856; cv=none; b=q6WVp9eMDWQDDzr9blPMKNRfh1jdjLBiomffAmMBPU6I5Dx+M9u69uyQ0iTIihRKcEiuIQKqGb+gnFrgGT5lxbqWfuVj5zWvaUAt7GdCR0WfAU3vySr44+J+CTX2DU98MM8frpFBXx+nVWaM/nHC/oFBUfZa83OCKSYYyaIQ0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324856; c=relaxed/simple;
	bh=VwPmtfrEpMQZppZlXT0BVh7uJDWDRNLzilybx+4SCQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jO9k93tqAA8gCOpwaVdAUXd42H7LHP3BcXjpr/uBEFXo4rMIgTWditRneu9gg5SwGRbLEUmxRSx+RqO9aDXZ/DsWgCjobjpW4co/BIzw/F7IFmXF9x0F3cbrZN76AwCxAu3tKVLX9TIe3JLQ0F+BAGpPUTlMmlUsMPEhaO/5GwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kF5LUqKn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so1247620b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709324854; x=1709929654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++ygW/zrbGDkm7OEamsSzy5xkbe+NsVciJd37Dungz8=;
        b=kF5LUqKnuIVXes1UZfoHYG7RhK+EdqqV0JX655qiHf9Kq5s9vH2jDmvbX7lOcLrXsn
         aGtnK+1n2g2DbiGhr4lRDKePpH6JqGTbxTa7vfyvBQF4uN9H0rfNmmZG5A7AVRusgGZ5
         ef4c9HneZK2KIt6uHofaRUUALf+w/JTiTGMpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324854; x=1709929654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++ygW/zrbGDkm7OEamsSzy5xkbe+NsVciJd37Dungz8=;
        b=iflVqFx2kXEsbPIpMg3n/dRxiWlZq8NKaiJQkSlLZtnyHPQptlB6rzjqT8DYABYKNE
         ZUVsJgAE/MoAoL9CezYBkFqa0hPYJT2XVssuPYdj7IA9RdcsJaxo22ZEZAMnSnIJF+g2
         MIHr3qbTno1Y+hZ0wwHOCVm71ORWF1ZOWs1pxJqSfGzuaAcrT/cf2fwDGVzbOvjkRd60
         Px9VJyGxkbXTjIr+U9eFjMtdPheVuOIkrfXuY3JgLdtioSwMzTZ8DCDyCTqvDuQ/kiGW
         144Zy9FeWGC0QLTEWQBy73tNnu3zIB9By3Se0QoRU4I+3/GaYntuOCfV5cJkxUI+iCax
         Esfw==
X-Forwarded-Encrypted: i=1; AJvYcCUClcdGFwwPMB2lrLV4a2HGBPtaWG94j5oNmy2B2sMPtjlu/HbNZ6oh8NMWDC8cEZw5yp6Eo5rU4ljGJHXWe8XTxOmTgXRGSkM365g8
X-Gm-Message-State: AOJu0YwFQ9JfW4tAO22pIb7BOiJWtMUEraxc0q9sZYJnS09mCbBKow8G
	BO6Rp2uAVVJVr/E2cDD3L6Dd7CQeMxi6qI7cpgTiaP3xjFF3lps+z+nw4T9RLg==
X-Google-Smtp-Source: AGHT+IG3c0BvnqRYp7HHxponKHVesrJ9uywDhykAWTt3SMm/sN4jr8XioGLuQKBfjydM9P3PT60q8Q==
X-Received: by 2002:a05:6a00:842:b0:6e4:79a1:c9c with SMTP id q2-20020a056a00084200b006e479a10c9cmr3309881pfk.12.1709324853845;
        Fri, 01 Mar 2024 12:27:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fn17-20020a056a002fd100b006e2301e702fsm3348707pfb.125.2024.03.01.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:27:33 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/2] string: Convert selftest to KUnit
Date: Fri,  1 Mar 2024 12:27:30 -0800
Message-Id: <20240301202732.2688342-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301202524.make.800-kees@kernel.org>
References: <20240301202524.make.800-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11517; i=keescook@chromium.org;
 h=from:subject; bh=VwPmtfrEpMQZppZlXT0BVh7uJDWDRNLzilybx+4SCQM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4jozJUd6Mz1T30BxDp7hozu+2IvRChqP3J4eW
 TlBK7mJFQOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeI6MwAKCRCJcvTf3G3A
 JvfwD/9iGxn5ciz1gJA3FgcC6oguTmCdle9NVS+6b/xS7jRSs3juqi+nl/vAJ4yuw1bv9nLxOPE
 0VeBW/x0QLJWEgnpi6xkolPaEIT+kGFfMYWZkNPNhzoaqBJH2uUTdnq4yvLEtC4KCRAbVli0rpb
 GzQbMHIW2ahuDlavI2Baxn52g5Daf8MJvwMZPpQU47gzPiTBr6abSYz6j7ShNOWLe3Mu/noECWW
 cnaradEbLvKUJ//vEbSX8tu6+ozt+w31Dc+xlsEFV18AZ1pCTlS8Un+HVVh+eI8IXpMy0wNdXkR
 ognlZZpI06X7cax8hi1rX4lJjjSlDmMv+VP4IB6+M/f0Y6mxofgofRX7UMZ9SQBkchdLGOKNEWZ
 3CiDYm0GVevzIW+HZMVxXfw//U/p2nNZfcs85+v4H6HjJ8Begzo4BvEY5tMQJTTncP4xp/qr8mM
 SOiKIvNT/P6DRjPUesTYN7ITb68/ww5o2ebFgL9/nxRqIN7i1mHeeTtXRJVMugcte8yUULul2/C
 IWClruJEuyKhgYrAkTLoGp4UuJ9w6kHqE6h9hRAcX3N8TNaKTdrWFlap+ccXwthIKwHj+F5+0Mv
 60cqvxskVmrZP1cpUW4tHNyRd5kpw52TLhSfLULG4OHD0kG8qaRyGb0LITB9doxf04ujDjTJNYW SXcVN4kvBTMbiag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Convert test_string.c to KUnit so it can be easily run with everything
else.

Additional text context is retained for failure reporting. For example,
when forcing a bad match, we can see the loop counters reported for the
memset() tests:

[09:21:52]     # test_memset64: ASSERTION FAILED at lib/string_kunit.c:93
[09:21:52]     Expected v == 0xa2a1a1a1a1a1a1a1ULL, but
[09:21:52]         v == -6799976246779207263 (0xa1a1a1a1a1a1a1a1)
[09:21:52]         0xa2a1a1a1a1a1a1a1ULL == -6727918652741279327 (0xa2a1a1a1a1a1a1a1)
[09:21:52] i:0 j:0 k:0
[09:21:52] [FAILED] test_memset64

Currently passes without problems:

$ ./tools/testing/kunit/kunit.py run string
..
[09:37:40] Starting KUnit Kernel (1/1)...
[09:37:40] ============================================================
[09:37:40] =================== string (6 subtests) ====================
[09:37:40] [PASSED] test_memset16
[09:37:40] [PASSED] test_memset32
[09:37:40] [PASSED] test_memset64
[09:37:40] [PASSED] test_strchr
[09:37:40] [PASSED] test_strnchr
[09:37:40] [PASSED] test_strspn
[09:37:40] ===================== [PASSED] string ======================
[09:37:40] ============================================================
[09:37:40] Testing complete. Ran 6 tests: passed: 6
[09:37:40] Elapsed time: 6.730s total, 0.001s configuring, 6.562s building, 0.131s running

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
---
 MAINTAINERS                           |   2 +-
 lib/Kconfig.debug                     |   6 +-
 lib/Makefile                          |   2 +-
 lib/{test_string.c => string_kunit.c} | 200 +++++++++-----------------
 4 files changed, 77 insertions(+), 133 deletions(-)
 rename lib/{test_string.c => string_kunit.c} (46%)

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
similarity index 46%
rename from lib/test_string.c
rename to lib/string_kunit.c
index c5cb92fb710e..15551200d858 100644
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
 
-	p = kmalloc(256 * 2 * 2, GFP_KERNEL);
-	if (!p)
-		return -1;
+	p = kunit_kzalloc(test, 256 * 2 * 2, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
@@ -20,34 +26,27 @@ static __init int memset16_selftest(void)
 			for (k = 0; k < 512; k++) {
 				v = p[k];
 				if (k < i) {
-					if (v != 0xa1a1)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xa1a1,
+						"i:%d j:%d k:%d", i, j, k);
 				} else if (k < i + j) {
-					if (v != 0xb1b2)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xb1b2,
+						"i:%d j:%d k:%d", i, j, k);
 				} else {
-					if (v != 0xa1a1)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xa1a1,
+						"i:%d j:%d k:%d", i, j, k);
 				}
 			}
 		}
 	}
-
-fail:
-	kfree(p);
-	if (i < 256)
-		return (i << 24) | (j << 16) | k | 0x8000;
-	return 0;
 }
 
-static __init int memset32_selftest(void)
+static void test_memset32(struct kunit *test)
 {
 	unsigned i, j, k;
 	u32 v, *p;
 
-	p = kmalloc(256 * 2 * 4, GFP_KERNEL);
-	if (!p)
-		return -1;
+	p = kunit_kzalloc(test, 256 * 2 * 4, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
@@ -56,34 +55,27 @@ static __init int memset32_selftest(void)
 			for (k = 0; k < 512; k++) {
 				v = p[k];
 				if (k < i) {
-					if (v != 0xa1a1a1a1)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xa1a1a1a1,
+						"i:%d j:%d k:%d", i, j, k);
 				} else if (k < i + j) {
-					if (v != 0xb1b2b3b4)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xb1b2b3b4,
+						"i:%d j:%d k:%d", i, j, k);
 				} else {
-					if (v != 0xa1a1a1a1)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xa1a1a1a1,
+						"i:%d j:%d k:%d", i, j, k);
 				}
 			}
 		}
 	}
-
-fail:
-	kfree(p);
-	if (i < 256)
-		return (i << 24) | (j << 16) | k | 0x8000;
-	return 0;
 }
 
-static __init int memset64_selftest(void)
+static void test_memset64(struct kunit *test)
 {
 	unsigned i, j, k;
 	u64 v, *p;
 
-	p = kmalloc(256 * 2 * 8, GFP_KERNEL);
-	if (!p)
-		return -1;
+	p = kunit_kzalloc(test, 256 * 2 * 8, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
 
 	for (i = 0; i < 256; i++) {
 		for (j = 0; j < 256; j++) {
@@ -92,27 +84,21 @@ static __init int memset64_selftest(void)
 			for (k = 0; k < 512; k++) {
 				v = p[k];
 				if (k < i) {
-					if (v != 0xa1a1a1a1a1a1a1a1ULL)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xa1a1a1a1a1a1a1a1ULL,
+						"i:%d j:%d k:%d", i, j, k);
 				} else if (k < i + j) {
-					if (v != 0xb1b2b3b4b5b6b7b8ULL)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xb1b2b3b4b5b6b7b8ULL,
+						"i:%d j:%d k:%d", i, j, k);
 				} else {
-					if (v != 0xa1a1a1a1a1a1a1a1ULL)
-						goto fail;
+					KUNIT_ASSERT_EQ_MSG(test, v, 0xa1a1a1a1a1a1a1a1ULL,
+						"i:%d j:%d k:%d", i, j, k);
 				}
 			}
 		}
 	}
-
-fail:
-	kfree(p);
-	if (i < 256)
-		return (i << 24) | (j << 16) | k | 0x8000;
-	return 0;
 }
 
-static __init int strchr_selftest(void)
+static void test_strchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
 	const char *empty_string = "";
@@ -121,26 +107,21 @@ static __init int strchr_selftest(void)
 
 	for (i = 0; i < strlen(test_string) + 1; i++) {
 		result = strchr(test_string, test_string[i]);
-		if (result - test_string != i)
-			return i + 'a';
+		KUNIT_ASSERT_EQ_MSG(test, result - test_string, i,
+				    "char:%c", 'a' + i);
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
@@ -151,35 +132,29 @@ static __init int strnchr_selftest(void)
 		for (j = 0; j < strlen(test_string) + 2; j++) {
 			result = strnchr(test_string, j, test_string[i]);
 			if (j <= i) {
-				if (!result)
-					continue;
-				return ((i + 'a') << 8) | j;
+				KUNIT_ASSERT_NULL_MSG(test, result,
+					"char:%c i:%d j:%d", 'a' + i, i, j);
+			} else {
+				KUNIT_ASSERT_EQ_MSG(test, result - test_string, i,
+					"char:%c i:%d j:%d", 'a' + i, i, j);
 			}
-			if (result - test_string != i)
-				return ((i + 'a') << 8) | j;
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
@@ -187,71 +162,38 @@ static __init int strspn_selftest(void)
 		const char reject[16];
 		unsigned a;
 		unsigned r;
-	} tests[] __initconst = {
+	} tests[] = {
 		{ "foobar", "", "", 0, 6 },
 		{ "abba", "abc", "ABBA", 4, 4 },
 		{ "abba", "a", "b", 1, 1 },
 		{ "", "abc", "abc", 0, 0},
 	};
 	const struct strspn_test *s = tests;
-	size_t i, res;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i, ++s) {
-		res = strspn(s->str, s->accept);
-		if (res != s->a)
-			return 0x100 + 2*i;
-		res = strcspn(s->str, s->reject);
-		if (res != s->r)
-			return 0x100 + 2*i + 1;
+		KUNIT_ASSERT_EQ_MSG(test, s->a, strspn(s->str, s->accept),
+			"i:%d", i);
+		KUNIT_ASSERT_EQ_MSG(test, s->r, strcspn(s->str, s->reject),
+			"i:%d", i);
 	}
-	return 0;
 }
 
-static __exit void string_selftest_remove(void)
-{
-}
+static struct kunit_case string_test_cases[] = {
+	KUNIT_CASE(test_memset16),
+	KUNIT_CASE(test_memset32),
+	KUNIT_CASE(test_memset64),
+	KUNIT_CASE(test_strchr),
+	KUNIT_CASE(test_strnchr),
+	KUNIT_CASE(test_strspn),
+	{}
+};
 
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
+static struct kunit_suite string_test_suite = {
+	.name = "string",
+	.test_cases = string_test_cases,
+};
 
-	test = 4;
-	subtest = strchr_selftest();
-	if (subtest)
-		goto fail;
-
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


