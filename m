Return-Path: <linux-kernel+bounces-151523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA488AB00D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E4628493D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211912DD8F;
	Fri, 19 Apr 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nrWaMdci"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8B12DD97
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535322; cv=none; b=ojW+bfXO96cUSyykonoAFiagTRms8wv3QOlDoID01QcOj7IlY1ZdO9wKl2dCN8KKViwS5VH6eGZxIpmia/Z2M7IWkhAqfsRxkBc0uMIDqecvGtOJSb2319KKtW8ltg2CZiaGaMlUmJ5+6NUPRHGOxfSIcNoobNeVH7gbq+NT6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535322; c=relaxed/simple;
	bh=7IyPCd/IlqNLChXRCOCFkpN3SWykrDEomkSKWSd5dtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWFpGfpmB/W3ewy6LJuxCIOlfew8VEMlIVn7Fpn6m+4Tx59LECigrLlm0o3WAUP96uuktBPYx9idZNM9N9iryRZ30yah76apXcu+J+Xe3y4rPEVZ/D5QIQ/eYVSe+mTVB0TTTB7t+w1Q1QDKUjOXvmTRGWsjzTN0nIRR0M4fqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nrWaMdci; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4f341330fso17927645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535320; x=1714140120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7YZZdCjQz9hWJpo9/lD9tjkwJaEcXHf2TvVvmg/KzA=;
        b=nrWaMdci6q66g5LVZGmmqg5/rkRX659/WGcn2KiUP3o/H/gEUSu/RCMnY0yhGijil0
         g2XnutHXeTjl9NLlObIDhVcaE9jqMmYF/J72cU/2Gsi7H8aOX8qHaR9Yhld0Sj5I3o0a
         Iqt8j7qPNVxOFYNn2vhqw/jVh2qqROzb0xiOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535320; x=1714140120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7YZZdCjQz9hWJpo9/lD9tjkwJaEcXHf2TvVvmg/KzA=;
        b=nf3ZMwzNBqqiCC9UqBjSO5FxRK3j2h/KbytkNTnlLISIZQmjGNqvuUUGxWFzX2RpKG
         3aFEYzRwVvbaAmAb2hySrm6ZFCwCGub9G33wY4zQI/zRBrSaH2afZCqmOGZMMwPVP3wo
         hPPw690ZnGq7pEmynJaVSh5xaNlMfsPFe0s/pCyKUCDxTYpK7+QOsHuJ7c4w82vgl4Oz
         jj0ixFyRqG1MPq1PMspzd5D6N1lB93/7m13gRar8MPrTL6Tr5blnwuaER63GgPDV2CUY
         B8RkiyzgbPnb0Cp/GJc4DM6a3ZV8dZtVBsHHSqpWnJ9SCG+LABHJBubF0Px6LWE1LcT0
         aSjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhP6pOyuIaVONGlCwIl5s7iS7AHPfDuAzfT2tqLl2E3MbaDtuulth/bOb7pUVTAaA8rxQ5PnmETfQ1gINSCxW7LfkQM5FYrPH991QR
X-Gm-Message-State: AOJu0YyawFmBQTN3icSGfMr0KRXhEYt42ATypcDbZ+dAPrrR+2jWKMOI
	BYbZQqNOTe1qfirWDdJcsANdlMlss7HeAH4Hn3nFXbrWM5nqvagvKtbZmR61kQ==
X-Google-Smtp-Source: AGHT+IHfm3vjj0w/4WFkFLVFA8P3SlF4h6GTKa95SeBReMH3BoiG3dYkBaqOIc9hDnYdcp3A/qzqAA==
X-Received: by 2002:a17:902:db04:b0:1e2:c8f9:4cd7 with SMTP id m4-20020a170902db0400b001e2c8f94cd7mr2492007plx.64.1713535320016;
        Fri, 19 Apr 2024 07:02:00 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001e61d87e4aasm3362122plf.185.2024.04.19.07.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:59 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] string: Convert KUnit test names to standard convention
Date: Fri, 19 Apr 2024 07:01:54 -0700
Message-Id: <20240419140155.3028912-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
References: <20240419140017.work.012-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7670; i=keescook@chromium.org;
 h=from:subject; bh=7IyPCd/IlqNLChXRCOCFkpN3SWykrDEomkSKWSd5dtA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlSXJhJLGlM4vLUJ65OHluVqz3q6Q0PhsGPZ
 CCgVfp3eaqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UgAKCRCJcvTf3G3A
 Jsy4EACTTMxVuGa4JzV6Yr0v3/2N0V1MAVIosTzb8TNWXkoqd+HRXw72hnVSlo6++gdE6eO4FF0
 kXHYppA7wHd/QN8F4BRRCgxSpDkwZIm6q/q+WTfNhmbqYd6WqYoJMKiijtfxk3M5FOzuwCvDGej
 xA4V4Xxur1H28ndlw9S4fB6d7l+oCZUM0ijjVf1lQjKOSNaQp0TrjzvsLLt+XD784aWC4QG3Hek
 n3lm5+2FK1r2KG/D1/sL1aO8YIZG0wbALIo7nlBveF0T5YEpltEAud9UZOE4OPPEytYXRFGYBGf
 4Lw71uCeovmuc7awK16MpYTYJq92Z9Knubm87J/u/6xhV9iMK9L6evsDV86LWlChbb6pzXRxGUo
 GHKfCdrpyeaHFrppTVqHVJYnDEEk/cI3O4LRwtUG2BlahLcHi2dtX5j8lY8n6shSHQCsIH7PUqW
 ZIptf1FAciUTtmNW5Ce/00NB34IMDRP9F27AatzHaQPsMDyK98tJNhTHQbmaGWsNFzXeWoHcCBJ
 /VsX8TVf1jdZo6hAIk6trlpdnFHznJt/eKmUDpIgTP4odI6TyxmtZjkViWtgJ+GE4XY5Th8WxEM
 kqCQKhyMWXmlAtub9sRewaYMUit6lTKE8uxAIkYn+pmdCK3WSIyJIPdW9wSvp9XWVxrmBXnDkei Esd+1+Bc6TRfxwg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The KUnit convention for test names is AREA_test_WHAT. Adjust the string
test names to follow this pattern.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 lib/string_kunit.c | 72 +++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index 48752ed19d56..de4eae91403f 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -17,7 +17,7 @@
 #define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
 #define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
 
-static void test_memset16(struct kunit *test)
+static void string_test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
 	u16 v, *p;
@@ -46,7 +46,7 @@ static void test_memset16(struct kunit *test)
 	}
 }
 
-static void test_memset32(struct kunit *test)
+static void string_test_memset32(struct kunit *test)
 {
 	unsigned i, j, k;
 	u32 v, *p;
@@ -75,7 +75,7 @@ static void test_memset32(struct kunit *test)
 	}
 }
 
-static void test_memset64(struct kunit *test)
+static void string_test_memset64(struct kunit *test)
 {
 	unsigned i, j, k;
 	u64 v, *p;
@@ -104,7 +104,7 @@ static void test_memset64(struct kunit *test)
 	}
 }
 
-static void test_strchr(struct kunit *test)
+static void string_test_strchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
 	const char *empty_string = "";
@@ -127,7 +127,7 @@ static void test_strchr(struct kunit *test)
 	KUNIT_ASSERT_NULL(test, result);
 }
 
-static void test_strnchr(struct kunit *test)
+static void string_test_strnchr(struct kunit *test)
 {
 	const char *test_string = "abcdefghijkl";
 	const char *empty_string = "";
@@ -160,7 +160,7 @@ static void test_strnchr(struct kunit *test)
 	KUNIT_ASSERT_NULL(test, result);
 }
 
-static void test_strspn(struct kunit *test)
+static void string_test_strspn(struct kunit *test)
 {
 	static const struct strspn_test {
 		const char str[16];
@@ -196,7 +196,7 @@ static void strcmp_fill_buffers(char fill1, char fill2)
 	strcmp_buffer2[STRCMP_LARGE_BUF_LEN - 1] = 0;
 }
 
-static void test_strcmp(struct kunit *test)
+static void string_test_strcmp(struct kunit *test)
 {
 	/* Equal strings */
 	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "Hello, Kernel!", "Hello, Kernel!");
@@ -214,7 +214,7 @@ static void test_strcmp(struct kunit *test)
 	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Just a string", "Just a string and something else");
 }
 
-static void test_strcmp_long_strings(struct kunit *test)
+static void string_test_strcmp_long_strings(struct kunit *test)
 {
 	strcmp_fill_buffers('B', 'B');
 	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, strcmp_buffer1, strcmp_buffer2);
@@ -226,7 +226,7 @@ static void test_strcmp_long_strings(struct kunit *test)
 	STRCMP_TEST_EXPECT_GREATER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
 }
 
-static void test_strncmp(struct kunit *test)
+static void string_test_strncmp(struct kunit *test)
 {
 	/* Equal strings */
 	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, KUnit!", "Hello, KUnit!", 13);
@@ -249,7 +249,7 @@ static void test_strncmp(struct kunit *test)
 				 strlen("Just a string"));
 }
 
-static void test_strncmp_long_strings(struct kunit *test)
+static void string_test_strncmp_long_strings(struct kunit *test)
 {
 	strcmp_fill_buffers('B', 'B');
 	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
@@ -269,7 +269,7 @@ static void test_strncmp_long_strings(struct kunit *test)
 				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
 }
 
-static void test_strcasecmp(struct kunit *test)
+static void string_test_strcasecmp(struct kunit *test)
 {
 	/* Same strings in different case should be equal */
 	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "Hello, Kernel!", "HeLLO, KErNeL!");
@@ -282,7 +282,7 @@ static void test_strcasecmp(struct kunit *test)
 	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "-+**.1230ghTTT~^", "-+**.1230Ghttt~^");
 }
 
-static void test_strcasecmp_long_strings(struct kunit *test)
+static void string_test_strcasecmp_long_strings(struct kunit *test)
 {
 	strcmp_fill_buffers('b', 'B');
 	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
@@ -294,7 +294,7 @@ static void test_strcasecmp_long_strings(struct kunit *test)
 	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
 }
 
-static void test_strncasecmp(struct kunit *test)
+static void string_test_strncasecmp(struct kunit *test)
 {
 	/* Same strings in different case should be equal */
 	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbAcAbA", "Abacaba", strlen("Abacaba"));
@@ -306,7 +306,7 @@ static void test_strncasecmp(struct kunit *test)
 	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "Abacaba", "Not abacaba", 0);
 }
 
-static void test_strncasecmp_long_strings(struct kunit *test)
+static void string_test_strncasecmp_long_strings(struct kunit *test)
 {
 	strcmp_fill_buffers('b', 'B');
 	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
@@ -398,7 +398,7 @@ static void strscpy_check(struct kunit *test, char *src, int count,
 	}
 }
 
-static void test_strscpy(struct kunit *test)
+static void string_test_strscpy(struct kunit *test)
 {
 	char dest[8];
 
@@ -447,7 +447,7 @@ static void test_strscpy(struct kunit *test)
 
 static volatile int unconst;
 
-static void test_strcat(struct kunit *test)
+static void string_test_strcat(struct kunit *test)
 {
 	char dest[8];
 
@@ -466,7 +466,7 @@ static void test_strcat(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void test_strncat(struct kunit *test)
+static void string_test_strncat(struct kunit *test)
 {
 	char dest[8];
 
@@ -493,7 +493,7 @@ static void test_strncat(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void test_strlcat(struct kunit *test)
+static void string_test_strlcat(struct kunit *test)
 {
 	char dest[8] = "";
 	int len = sizeof(dest) + unconst;
@@ -525,24 +525,24 @@ static void test_strlcat(struct kunit *test)
 }
 
 static struct kunit_case string_test_cases[] = {
-	KUNIT_CASE(test_memset16),
-	KUNIT_CASE(test_memset32),
-	KUNIT_CASE(test_memset64),
-	KUNIT_CASE(test_strchr),
-	KUNIT_CASE(test_strnchr),
-	KUNIT_CASE(test_strspn),
-	KUNIT_CASE(test_strcmp),
-	KUNIT_CASE(test_strcmp_long_strings),
-	KUNIT_CASE(test_strncmp),
-	KUNIT_CASE(test_strncmp_long_strings),
-	KUNIT_CASE(test_strcasecmp),
-	KUNIT_CASE(test_strcasecmp_long_strings),
-	KUNIT_CASE(test_strncasecmp),
-	KUNIT_CASE(test_strncasecmp_long_strings),
-	KUNIT_CASE(test_strscpy),
-	KUNIT_CASE(test_strcat),
-	KUNIT_CASE(test_strncat),
-	KUNIT_CASE(test_strlcat),
+	KUNIT_CASE(string_test_memset16),
+	KUNIT_CASE(string_test_memset32),
+	KUNIT_CASE(string_test_memset64),
+	KUNIT_CASE(string_test_strchr),
+	KUNIT_CASE(string_test_strnchr),
+	KUNIT_CASE(string_test_strspn),
+	KUNIT_CASE(string_test_strcmp),
+	KUNIT_CASE(string_test_strcmp_long_strings),
+	KUNIT_CASE(string_test_strncmp),
+	KUNIT_CASE(string_test_strncmp_long_strings),
+	KUNIT_CASE(string_test_strcasecmp),
+	KUNIT_CASE(string_test_strcasecmp_long_strings),
+	KUNIT_CASE(string_test_strncasecmp),
+	KUNIT_CASE(string_test_strncasecmp_long_strings),
+	KUNIT_CASE(string_test_strscpy),
+	KUNIT_CASE(string_test_strcat),
+	KUNIT_CASE(string_test_strncat),
+	KUNIT_CASE(string_test_strlcat),
 	{}
 };
 
-- 
2.34.1


