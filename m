Return-Path: <linux-kernel+bounces-64445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D6853E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EA41C20BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F485634FA;
	Tue, 13 Feb 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e3VkhR0d"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBFD633E7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862268; cv=none; b=FA3d/d5v6qkVCDh9MptbtlwcMjIwcUaqNqxEMVclXtmaGt7VjIwLRmmhWKHZ2QL/9hibHIvfRpj0gp0ZAGfngWTQcXxhB5FldIj0WXIU8uo5efPnJqe4uK46iGV+RPW18wtN0kdqz+m2/7Ul2sztTB0Q33f86Fi4JSBuhll28G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862268; c=relaxed/simple;
	bh=XF4r45LSthMB7YVQUTdzEjocvHZZ2Akb/A9zylSTGZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCBSmjvrkZYNLUvQQcbt77UiTz2U0PzQ6121LTKCI5faD17O8mIOl/kFP7EyGSzawO1gb8PvdOzUQqL48tdn+D7H90ox24YF749fv8XU61WspiE8Ht27Jak6ZH6m/azd4PtS6fYlLJ2gzuVy81Yh+j9Zjb7OInZTjfEOOaSmleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e3VkhR0d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d9b2400910so1405445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707862266; x=1708467066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vaQBRrGxq8giGU/rUfJzaBqC9E236GkqOs6N9h8ECk=;
        b=e3VkhR0deJoEpDmUgUpa6BbMWuCN/l75oidfDfyZtFJQmjdA8un/F5NP1arrLcHRmr
         yz4L2hszW5LsCLNRr+Rf1UiDKXxp/OlH1Qv7EcfgiK/KJHObMVbXZPyx/+TqQ1Vx111G
         YkpcziF2Zqzgyma2aEWUqB4ivrbI/ybpikN4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862266; x=1708467066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vaQBRrGxq8giGU/rUfJzaBqC9E236GkqOs6N9h8ECk=;
        b=LRsMQs4RYeo2OcvauJmn7bFh4f4+k6tnZbwCZaZxLnavR6vHJpCkz/6+z2ak5EEGjU
         EKrRzFxc8/Ytf4ft5Pv7HQlXCsiS9A3RB2rxnSav4CpviqaKG21g7lRI9iIopcEFOaWq
         K6SQrnhcHjz+fb74MaMo12W76O2teNVapRnQuEKuqYXjT4sRBCetKrxDV6kl+bu8X6BM
         UAT63xYjwH3nMAVpiwPbrXt/RZirLyEW3wWz0fKdZpDTD/QLAztgMWm4z5u/fZOWiLj2
         Gd4A1+HGXS4AATS15gVUvQhORXjnqVhah9ctjIzszoNBr/YhPKSNvPdysHvqzf663AuO
         V1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBJ0UUGfxQg5KjNxZXbg6rFDRICqNhs0j5AT9Bz2gPdy/p+IyBb1hM9THcD0chIiQYjoImGDDL97ebXDTG4BZadPG30oh3ULYWpjsI
X-Gm-Message-State: AOJu0Yzc2xyLxV822S+sAMKKeJ6gBfOZqPfiP15U0Xv7db2Qqe9WZKV/
	8H23buxw36lQU3axQ5AW4RLOgqOQ5ahJrlyVS+XSx4UKAGBD50wjli2KrCkmtg==
X-Google-Smtp-Source: AGHT+IEJs3QUULkGTcTHjIIabKseLhxv4UbOGWs1/OzdPtMsnROZTiGog/a8CV7z94VJqhNpX7+p0A==
X-Received: by 2002:a17:903:41c3:b0:1d9:2e9d:8cb6 with SMTP id u3-20020a17090341c300b001d92e9d8cb6mr222238ple.15.1707862266128;
        Tue, 13 Feb 2024 14:11:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsCsed9m6sJYBvwIZFjsK6qniGUXhULSPYvW/Fm5655xVVKS7LE9Ox5dfg+uAbDK3w29HesPwnOvD5w3zDbrWtu0ljz8fsbu1RDdsu0dgWJyWCFIenNBLdx9+ps4myuDL4j87bm3PJ1f995ip5A3A9hGQHz21Wd584a4Ph6xqGsmKTSiSSlvZgo1pYxJIm9UZhjBk/amSv0TAt2eSP1CLJ3MXjL/Jcs322I8WkuNR6Wel83/CJ1nOLMHagp74kNXg1hvK9XoIJ4UWYnXCJYXR269vdZ4J1CPrLbZKqWOTVRVCvcH7JL38iO10dNY5KevJZRdvFyanOAQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kd12-20020a17090313cc00b001d706e373a9sm104564plb.292.2024.02.13.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:11:04 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
Date: Tue, 13 Feb 2024 14:10:58 -0800
Message-Id: <20240213221100.3556356-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220844.it.345-kees@kernel.org>
References: <20240213220844.it.345-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5647; i=keescook@chromium.org;
 h=from:subject; bh=XF4r45LSthMB7YVQUTdzEjocvHZZ2Akb/A9zylSTGZU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly+jzl2oYM+h6ESvayR0VXH2Ls/OCkv3ZYMMGL
 cj9eHUrGjGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcvo8wAKCRCJcvTf3G3A
 Jt2nEAChpDMVoEbTWwliB3MsMGyfVB0zWz6dz9iKPEfgZ9bW4GBCPzr4hsMkIRjqSy6Xk0tvTGP
 N7cOJfQ4ufVEh6s/6rA3XeQ8IMIpCJaBQdPFAZjIIBJGwpEF9WNW3s1ac9lJ0xf72hOkSylmMXk
 Xbv7mYpdsj0f4nvJprR5WNlri8RVmfz4Oycg0GLG0DnZ0xYd24KAV1m7sHlZwbWMRqco5RqC69O
 G+l2b5AEsSs1KR8UdnNOvM0xS3eIu+U/yXxlpuUOejjKWdFlLk+AR/7LWGn3JEQA+5jgl1nwt4+
 IS/sIMMF4AzygjoFSbYDhI0W+Q9fCHOZp3pXUSj9vPtG7Qhi6/Y8aEOCWjVsLf4sJdLS28AP9lq
 EVpm3C/eC66TPsNfSdwQtFk7JK1lWb1n2ZwyJaTkxI42g2BB+5dECKQJJTqR704zK+zsvxD3pYx
 SOw3QL4vLNyXDL3Ica/rm3v/9h6CbgVPnAhngs+3110a/jeGjiMXynKy0D/1geRx5f/kpS1uo0z
 oQHs0AesDBMDW+0RNWWGON/xuGAyCDfjQP4ojwsZ/LXlarSfGdLHnfDQ0461ZHFcVwTPF9PZWWZ
 s2bZtJyVG5GqqMpYn1GE0bm4pcVWJnLhGU1ttPCTBR2DxzeUn+IjN7wSxXN7IQ5fsIZ9IPMKROs 1RwK3x6pKCLxtyA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide helpers that will perform wrapping addition, subtraction, or
multiplication without tripping the arithmetic wrap-around sanitizers. The
first argument is the type under which the wrap-around should happen
with. In other words, these two calls will get very different results:

	wrapping_mul(int, 50, 50) == 2500
	wrapping_mul(u8,  50, 50) ==  196

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 24 ++++++++++++++++----
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4e741ebb8005..849a49fb496e 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -64,6 +64,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
+/**
+ * wrapping_add() - Intentionally perform a wrapping addition
+ * @type: type for result of calculation
+ * @a: first addend
+ * @b: second addend
+ *
+ * Return the potentially wrapped-around addition without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_add(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_add_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -77,6 +93,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
+/**
+ * wrapping_sub() - Intentionally perform a wrapping subtraction
+ * @type: type for result of calculation
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ *
+ * Return the potentially wrapped-around subtraction without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_sub(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_sub_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
@@ -90,6 +122,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
+/**
+ * wrapping_mul() - Intentionally perform a wrapping multiplication
+ * @type: type for result of calculation
+ * @a: first factor
+ * @b: second factor
+ *
+ * Return the potentially wrapped-around multiplication without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define wrapping_mul(type, a, b)				\
+	({							\
+		type __val;					\
+		__builtin_mul_overflow(a, b, &__val);		\
+		__val;						\
+	})
+
 /**
  * check_shl_overflow() - Calculate a left-shifted value and check overflow
  * @a: Value to be shifted
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index c527f6b75789..d3fdb906d3fe 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -258,20 +258,36 @@ DEFINE_TEST_ARRAY(s64) = {
 									\
 	_of = check_ ## op ## _overflow(a, b, &_r);			\
 	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
-		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
+		"expected check "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
 		a, b, of ? "" : " not", #t);				\
 	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
-		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		"expected check "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
 		a, b, r, _r, #t);					\
 	/* Check for internal macro side-effects. */			\
 	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
-	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
-	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
+		"Unexpected check " #op " macro side-effect!\n");	\
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected check " #op " macro side-effect!\n");	\
+									\
+	_r = wrapping_ ## op(t, a, b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
+		"expected wrap "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		a, b, r, _r, #t);					\
+	/* Check for internal macro side-effects. */			\
+	_a_orig = a;							\
+	_b_orig = b;							\
+	_r = wrapping_ ## op(t, _a_orig++, _b_orig++);			\
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
+		"Unexpected wrap " #op " macro side-effect!\n");	\
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected wrap " #op " macro side-effect!\n");	\
 } while (0)
 
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
 static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {									\
+	/* check_{add,sub,mul}_overflow() and wrapping_{add,sub,mul} */	\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
 	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
-- 
2.34.1


