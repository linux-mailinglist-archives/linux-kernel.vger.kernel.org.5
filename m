Return-Path: <linux-kernel+bounces-151524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E058AB00E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35271C21833
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629412FB29;
	Fri, 19 Apr 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NuGZq0bv"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A212F399
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535323; cv=none; b=lI2S11QnulQpuwctd7WiToj2+mruBJllPJRsorsV3gmS1tzN98ZXbTyhQguocRkLqhxUOhiQAiIiR1Y7rXY7JanJeLMsc5j04CEoWBp7zr5KFA+XWakQbPTm6a8aoeQBgF/BnkZcOg3yM7RbkjOWEUgShZgNBKjDbP5PaK8MSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535323; c=relaxed/simple;
	bh=+0EnWFIUe5hlVK05YLz9T9Pnd3LijK1uo6bFgPKzyJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ag+MVauMsL+4Sku+mPz036hgeAwQkOUZFQreIPvUSy0cKt2dLqsnJnLMD/xev8D3ojpfJ/9Hnn3zdScj8DW++LBh3flBq9DfihCfzF8ttW4cj4l5VoW8NR1c0X/5bXff6dC4dO5sOcCG/TKpmchfxtxd+sV6/TYYrnPdzOsLwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NuGZq0bv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so329857a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535320; x=1714140120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29HXZf1N36mh2e7GgKZvXztZsU0hSmEcg2Pmkgs+XEs=;
        b=NuGZq0bvvIyNEFH6CTmbdw46s8eq9iGVenL6wH+jBxjGVxH0rhX6oS5pJeJ3hTtXGs
         iDed46g8hO1nNkPvq1DT6aLO/eY96SUkALjYfsISPbOrXDSML21P0VkLsZ8cVvBH42tP
         8EsIh+55P07qwJNDq2aGbTTm9Fs29e1QSvs4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535320; x=1714140120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29HXZf1N36mh2e7GgKZvXztZsU0hSmEcg2Pmkgs+XEs=;
        b=V1SmNnyU9lgnpt5iLoYix83HWAYjMdl7Im8gP+ieEtecI4yd7NAECVUmY1bIB2hQkB
         F7ahtAiqVO+Z2LD3SNEcR9ppQpui6LbiCfs3q3N+c62Aj0Dws6WmF/tCLiQqcG1kEtwX
         qpoF56pFQpdEQka1TOf0S7Hq0xyi3sS+CkZiGSKvuoTISdSK3Pke5X/n+7jpkfb9NacS
         HPEDyvQyU87VmlCgXPvfnrS+oFJ9/WBuHIUfzAWbqhjg6HjR+4Jld9HOQdNmlqsS3+ML
         BiUMAzneG4N/ki3DcrinDOHyczBIRHUpRlUjIcyEYM4iZsFIeEn4W36oNkmpMymC6eK+
         Y07g==
X-Forwarded-Encrypted: i=1; AJvYcCWWOInIlwBgMPHHntkDGFemV0cbKbZPVej18JfP4hKY6EvRzKzHNXxj82EYgHhH65p+97SW/Jr7HPiISWPhBZaoKhPwJdz5P7oK43FK
X-Gm-Message-State: AOJu0YxKxsBd+79wi2fcpthb7/2OWf2G4ubv7wehzs2sjpOo9epJgau1
	ks0+DW9DnhPTxZ3GwcvMdaCjDgeJmcy41rl4m5kGKjxkongjDK0v8AxPix3H8w==
X-Google-Smtp-Source: AGHT+IGSLbWho6Qb3JfLHwL4mcods9dF8OusYpeCj9RiODxQmsCgTUUSCGkFJaFJW/BYj0WQAQKZCA==
X-Received: by 2002:a17:90b:3597:b0:2a5:c3a7:39d9 with SMTP id mm23-20020a17090b359700b002a5c3a739d9mr2038455pjb.45.1713535320396;
        Fri, 19 Apr 2024 07:02:00 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ay12-20020a17090b030c00b002a5cf58aae2sm3168143pjb.11.2024.04.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:59 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] string: Merge strcat KUnit tests into string_kunit.c
Date: Fri, 19 Apr 2024 07:01:53 -0700
Message-Id: <20240419140155.3028912-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
References: <20240419140017.work.012-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9620; i=keescook@chromium.org;
 h=from:subject; bh=+0EnWFIUe5hlVK05YLz9T9Pnd3LijK1uo6bFgPKzyJw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlStYIdocn87Qf/7qJEbu/Lsh/jHUitFwbL0
 C3jhY3NZv6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UgAKCRCJcvTf3G3A
 Jl1LD/9rGflKJbgMJEtCMXq4XKoyUnHbv2dX+E6jheTf5ZVHywPhBiKMLsgeN/xq8F+UK7vTsyt
 gf6AnLgz27aeVVzmU9+jWOlUtlnNy0XdZ8vu95xym2zneMgVLDFSvYUy+r+g5ZQcHtt8Fyh+FvJ
 irvIeUxuvMv4LclhdLuY4y0CIIN+hw4rPNg+MyV+bsqzRnUp5tOobCOvXaZ0OO0Fzkaj/tELQjt
 THt0pUEa7G62ReQ2zPDGK47x+l9za0HnOHY11o4qjpOkWbD4sjLI/8pq18Z9nMaOf9Vqs8emkkk
 viMxu1IGxFiamESbF5JKHV4gLx8VPbTEOUXcwAX0rm3uV2WaACxi/ZQX62tvGWBzvEl8p57JR7t
 DS6pA+rgHZZhT4+5IqyFaqlwzIXZ8aFmdNhVThyIHJDEsWD2UpZ6XrnNXXsAfxjbD1/zGW/fMaz
 KFQqzYE3F8LAhaCuRwbPs3jppzhBJi8+C6hq3AmKY9vtADDTSTyFDEm3sGANysLHWCfQREOa2At
 tzFRd1QPzlV9QM/kveDl92ICYlEQiEHFaigeaz1uZbUGXEWJSH9qk+INbIEv09+Crse+MqhaNed
 EGsHeBXm3Mdm462Q19vRCQrFxYlK2/87Ye66WLxs+CPAz3Y41TWz6R5v+yevvC6H5XOQAfvSAr6 uSJWCF6pE0Ni0LQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Move the strcat() tests into string_kunit.c. Remove the separate
Kconfig and Makefile rule.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 MAINTAINERS        |   1 -
 lib/Kconfig.debug  |   5 ---
 lib/Makefile       |   1 -
 lib/strcat_kunit.c | 104 ---------------------------------------------
 lib/string_kunit.c |  82 +++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 111 deletions(-)
 delete mode 100644 lib/strcat_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 17d079aa15ec..8974511315c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8441,7 +8441,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/har
 F:	include/linux/fortify-string.h
 F:	lib/fortify_kunit.c
 F:	lib/memcpy_kunit.c
-F:	lib/strcat_kunit.c
 F:	lib/test_fortify/*
 F:	scripts/test_fortify.sh
 K:	\b__NO_FORTIFY\b
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7ffb06eabcd1..a384070c74bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2758,11 +2758,6 @@ config HW_BREAKPOINT_KUNIT_TEST
 
 	  If unsure, say N.
 
-config STRCAT_KUNIT_TEST
-	tristate "Test strcat() family of functions at runtime" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	default KUNIT_ALL_TESTS
-
 config SIPHASH_KUNIT_TEST
 	tristate "Perform selftest on siphash functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index 5f994b963d1a..b040ad5f8022 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -403,7 +403,6 @@ CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
-obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/strcat_kunit.c b/lib/strcat_kunit.c
deleted file mode 100644
index ca09f7f0e6a2..000000000000
--- a/lib/strcat_kunit.c
+++ /dev/null
@@ -1,104 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Kernel module for testing 'strcat' family of functions.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <kunit/test.h>
-#include <linux/string.h>
-
-static volatile int unconst;
-
-static void test_strcat(struct kunit *test)
-{
-	char dest[8];
-
-	/* Destination is terminated. */
-	memset(dest, 0, sizeof(dest));
-	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
-	/* Empty copy does nothing. */
-	KUNIT_EXPECT_TRUE(test, strcat(dest, "") == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "");
-	/* 4 characters copied in, stops at %NUL. */
-	KUNIT_EXPECT_TRUE(test, strcat(dest, "four\000123") == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "four");
-	KUNIT_EXPECT_EQ(test, dest[5], '\0');
-	/* 2 more characters copied in okay. */
-	KUNIT_EXPECT_TRUE(test, strcat(dest, "AB") == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
-}
-
-static void test_strncat(struct kunit *test)
-{
-	char dest[8];
-
-	/* Destination is terminated. */
-	memset(dest, 0, sizeof(dest));
-	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
-	/* Empty copy of size 0 does nothing. */
-	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0 + unconst) == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "");
-	/* Empty copy of size 1 does nothing too. */
-	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1 + unconst) == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "");
-	/* Copy of max 0 characters should do nothing. */
-	KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0 + unconst) == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "");
-
-	/* 4 characters copied in, even if max is 8. */
-	KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8 + unconst) == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "four");
-	KUNIT_EXPECT_EQ(test, dest[5], '\0');
-	KUNIT_EXPECT_EQ(test, dest[6], '\0');
-	/* 2 characters copied in okay, 2 ignored. */
-	KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2 + unconst) == dest);
-	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
-}
-
-static void test_strlcat(struct kunit *test)
-{
-	char dest[8] = "";
-	int len = sizeof(dest) + unconst;
-
-	/* Destination is terminated. */
-	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
-	/* Empty copy is size 0. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "", len), 0);
-	KUNIT_EXPECT_STREQ(test, dest, "");
-	/* Size 1 should keep buffer terminated, report size of source only. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", 1 + unconst), 4);
-	KUNIT_EXPECT_STREQ(test, dest, "");
-
-	/* 4 characters copied in. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", len), 4);
-	KUNIT_EXPECT_STREQ(test, dest, "four");
-	/* 2 characters copied in okay, gets to 6 total. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "AB", len), 6);
-	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
-	/* 2 characters ignored if max size (7) reached. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "CD", 7 + unconst), 8);
-	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
-	/* 1 of 2 characters skipped, now at true max size. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "EFG", len), 9);
-	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
-	/* Everything else ignored, now at full size. */
-	KUNIT_EXPECT_EQ(test, strlcat(dest, "1234", len), 11);
-	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
-}
-
-static struct kunit_case strcat_test_cases[] = {
-	KUNIT_CASE(test_strcat),
-	KUNIT_CASE(test_strncat),
-	KUNIT_CASE(test_strlcat),
-	{}
-};
-
-static struct kunit_suite strcat_test_suite = {
-	.name = "strcat",
-	.test_cases = strcat_test_cases,
-};
-
-kunit_test_suite(strcat_test_suite);
-
-MODULE_LICENSE("GPL");
diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index 4af04643f4c2..48752ed19d56 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -445,6 +445,85 @@ static void test_strscpy(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, strscpy(dest, "This is too long", ARRAY_SIZE(dest)), -E2BIG);
 }
 
+static volatile int unconst;
+
+static void test_strcat(struct kunit *test)
+{
+	char dest[8];
+
+	/* Destination is terminated. */
+	memset(dest, 0, sizeof(dest));
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy does nothing. */
+	KUNIT_EXPECT_TRUE(test, strcat(dest, "") == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* 4 characters copied in, stops at %NUL. */
+	KUNIT_EXPECT_TRUE(test, strcat(dest, "four\000123") == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	KUNIT_EXPECT_EQ(test, dest[5], '\0');
+	/* 2 more characters copied in okay. */
+	KUNIT_EXPECT_TRUE(test, strcat(dest, "AB") == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+}
+
+static void test_strncat(struct kunit *test)
+{
+	char dest[8];
+
+	/* Destination is terminated. */
+	memset(dest, 0, sizeof(dest));
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy of size 0 does nothing. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Empty copy of size 1 does nothing too. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Copy of max 0 characters should do nothing. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+
+	/* 4 characters copied in, even if max is 8. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	KUNIT_EXPECT_EQ(test, dest[5], '\0');
+	KUNIT_EXPECT_EQ(test, dest[6], '\0');
+	/* 2 characters copied in okay, 2 ignored. */
+	KUNIT_EXPECT_TRUE(test, strncat(dest, "ABCD", 2 + unconst) == dest);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+}
+
+static void test_strlcat(struct kunit *test)
+{
+	char dest[8] = "";
+	int len = sizeof(dest) + unconst;
+
+	/* Destination is terminated. */
+	KUNIT_EXPECT_EQ(test, strlen(dest), 0);
+	/* Empty copy is size 0. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "", len), 0);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+	/* Size 1 should keep buffer terminated, report size of source only. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", 1 + unconst), 4);
+	KUNIT_EXPECT_STREQ(test, dest, "");
+
+	/* 4 characters copied in. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "four", len), 4);
+	KUNIT_EXPECT_STREQ(test, dest, "four");
+	/* 2 characters copied in okay, gets to 6 total. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "AB", len), 6);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+	/* 2 characters ignored if max size (7) reached. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "CD", 7 + unconst), 8);
+	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
+	/* 1 of 2 characters skipped, now at true max size. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "EFG", len), 9);
+	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
+	/* Everything else ignored, now at full size. */
+	KUNIT_EXPECT_EQ(test, strlcat(dest, "1234", len), 11);
+	KUNIT_EXPECT_STREQ(test, dest, "fourABE");
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
@@ -461,6 +540,9 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_strncasecmp),
 	KUNIT_CASE(test_strncasecmp_long_strings),
 	KUNIT_CASE(test_strscpy),
+	KUNIT_CASE(test_strcat),
+	KUNIT_CASE(test_strncat),
+	KUNIT_CASE(test_strlcat),
 	{}
 };
 
-- 
2.34.1


