Return-Path: <linux-kernel+bounces-43316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E789841215
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732291C20C19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083D76035;
	Mon, 29 Jan 2024 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nKpRiEVI"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9961429F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553257; cv=none; b=oRw/CKoAEQp4svdghjZAkTD0kvSRzzkC23AcbFTziSZUdOvgARNuudOZNv1sbriU3EixvRQz+etX3aDOYTpVgYeiKrOtxOI1JrvU08RVikpX7Me3/ylB1tLaOFoMb8YQHnB92UNDi6o91nQA3zpZYZ01RSEdc/ON6UCwJjYqWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553257; c=relaxed/simple;
	bh=wU5wiWooVyd2eqSdpoTBHd90qKwM9wZ/F9mLDiaQmqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7fiOCs14MK/f3RIe+Rx7arYp0xs5V4KR74tfUr8ykqIH1ntWLRwOOd/ZX1NhJ6aTkgiASuBnltiXR4uOOBc3qkFWm2QxfK+nWp57TenA6zaBw8asFtOCUVw1yQqRIk7l+yTbAQg12XaqHf8ce/h0wTINZGohU4QftpImPTiAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nKpRiEVI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2901ceb0d33so3088215a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706553253; x=1707158053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLoyWv8OtbHjtjHwspyJBOM+KJjmRvPEg1tZQlUAAzg=;
        b=nKpRiEVImw6NMmMvz63DF5v/sZ9K1rE1huSEYQgzv6J9ej7sIFp2Gg82PHrr3w/NkA
         S66fQlq3A+hd0HnslqpX+pqNOyXY///cRCkNvHCQmhlT/nLk3wSVWOBijaSSMkI8HWav
         SRICVkL87LBGjUYyZKz06PpOkgR7w6nP7T11Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706553253; x=1707158053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLoyWv8OtbHjtjHwspyJBOM+KJjmRvPEg1tZQlUAAzg=;
        b=qKUfo5N08UKag8yMhQtPZwB6gS6gFvsHRcHQC3cpKF+k3ov+JQK5xDykizrfQvUBRp
         4bb2DLe01RCg2ry7wcNytic23137vO7spss5piADy8si9CjSZFsxvbK3Pzulii4aRZ6K
         2onjtruMA9qVtGXcNAv7APDPsIjtMDetKWap3dBqG3FH3u9S/XHrPezDYCCLWkSKJnG9
         aQ7KUz25FRhRtWtRL3tw5je4gGbRAUSiUhbwFIO1hho2qnVBYkqyyHxhh0MIBx0HI3rn
         sSz8EYxffhazo26Nv37UipY5KKkShuv0zVc99qQBYK4S88xgg++8aJN2ou7mRJmpKaAV
         pVpQ==
X-Gm-Message-State: AOJu0YwAbk4rImsrPHd6n0U96fwKgy6mLG7usl4WcOJyYhC1IjG44JkX
	S1ewN7OdTlp1+0tcWOVn4uLPHrZGfcspfNVwf2Jv+7Hhp8x0wtZKr1BpZyxALg==
X-Google-Smtp-Source: AGHT+IEtZun+s6fgm7zz06w28zAsAVRtjQwAiJs7DujINPla24nIanKkgDFDBEVCmPrBFkc5WJrlow==
X-Received: by 2002:a17:90a:c593:b0:290:8eb8:aca8 with SMTP id l19-20020a17090ac59300b002908eb8aca8mr6012937pjt.21.1706553253540;
        Mon, 29 Jan 2024 10:34:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b002902076c395sm8502122pjc.34.2024.01.29.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:34:11 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] overflow: Expand check_add_overflow() for pointer addition
Date: Mon, 29 Jan 2024 10:34:06 -0800
Message-Id: <20240129183411.3791340-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129182845.work.694-kees@kernel.org>
References: <20240129182845.work.694-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10664; i=keescook@chromium.org;
 h=from:subject; bh=wU5wiWooVyd2eqSdpoTBHd90qKwM9wZ/F9mLDiaQmqs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt++hOmJWNChP5gjc4TpxLGURO5jKzEEgWMbHO
 GpeBzggvUWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfvoQAKCRCJcvTf3G3A
 JshUD/4mfIxZHN04yZHdDDv+6B1mABxoQcm8MH8k5+dd+1Cg2mWb2V4dyLaHGOAXy0VSNJfF/EP
 O+vimDvJMsIZdST6MlKaXVJlZf+eFfG6AafkEtRLoBtBpXCj+FXSXt+dDhCCaW/iLHhdEDk3KYa
 DmmGSN8Adg1hdRFmVDiUXRefTS62WOY/jaZVomk9moOg8doMlKC3812t7dtp3qoeaWIRBIr/bMM
 wV43sD2nLqxSItSJD61I5sBZVOENslq1ibBg8BEQNkGV2VlR1mW57dYhFqIki2dZzU8cyPTi5bo
 1lkHC9FI/xA6xEZ/xk/X2FM1Z7/QY1Cnt3C3HcjsEuq9v/XkP4bJRzyybEHSHRUfDS7AYD3QodD
 pH53rdjtqpYXmCXu77+XnR3e1r06vIWqhEHC+OCfhUruHhRUnh80seJbjLf9JT0vBBy/pYKNj2d
 Si0NuZy4FAN5ZtqOOSMV0FBWt3trfnSrfdg08H8FnJZ4ArlNcxD4+8DteNXDLYShnJCUN0tIfKr
 PBnqZGcPOGapoFOOA2GY+lSZPS3tKYH6hsfAfm4Y9e1XxIT3AG/9bv6GBhLRDm4Fh84ksGdEXVK
 1wOrPvVNg2y8tgCPDXr41Tzuces9sa6QPztqCxgKFVZ1OL+o98SdArPyOeP+aQt2aRXa/wk0KQI jSPhzQFtz2fupRQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The check_add_overflow() helper is mostly a wrapper around
__builtin_add_overflow(), but GCC and Clang refuse to operate on pointer
arguments that would normally be allowed if the addition were open-coded.

For example, we have many places where pointer overflow is tested:

	struct foo *ptr;
	...
	/* Check for overflow */
	if (ptr + count < ptr) ...

And in order to avoid running into the overflow sanitizers in the
future, we need to rewrite these "intended" overflow checks:

	if (check_add_overflow(ptr, count, &result)) ...

Frustratingly the argument type validation for __builtin_add_overflow()
is done before evaluating __builtin_choose_expr(), so for arguments to
be valid simultaneously for sizeof(*p) (when p may not be a pointer),
and __builtin_add_overflow(a, ...) (when a may be a pointer), we must
introduce wrappers that always produce a specific type (but they are
only used in the places where the bogus arguments will be ignored).

To test whether a variable is a pointer or not, introduce the __is_ptr()
helper, which uses __builtin_classify_type() to find arrays and pointers
(via the new __is_ptr_or_array() helper), and then decays arrays into
pointers (via the new __decay() helper), to distinguish pointers from
arrays.

Additionally update the unit tests to cover pointer addition.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: llvm@lists.linux.dev
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_types.h | 10 +++++
 include/linux/overflow.h       | 44 ++++++++++++++++++-
 lib/overflow_kunit.c           | 77 ++++++++++++++++++++++++++++++----
 3 files changed, 120 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6f1ca49306d2..d27b58fddfaa 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -375,6 +375,16 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/* Is variable addressable? */
+#define __is_ptr_or_array(p)	(__builtin_classify_type(p) == 5)
+
+/* Return an array decayed to a pointer. */
+#define __decay(p)		\
+	(&*__builtin_choose_expr(__is_ptr_or_array(p), p, NULL))
+
+/* Report if variable is a pointer type. */
+#define __is_ptr(p)		__same_type(p, __decay(p))
+
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4e741ebb8005..210e5602e89b 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,6 +51,43 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	return unlikely(overflow);
 }
 
+/* Always produce an integral variable expression. */
+#define __filter_integral(x)		\
+	__builtin_choose_expr(!__is_ptr(x), (x), 0)
+
+/* Always produce a pointer value. */
+#define __filter_ptr(x)			\
+	__builtin_choose_expr(__is_ptr(x), (x), NULL)
+
+/* Always produce a pointer to an integral value. */
+#define __filter_ptrint(x)		\
+	__builtin_choose_expr(!__is_ptr(*(x)), x, &(int){ 0 })
+
+/**
+ * __check_ptr_add_overflow() - Calculate pointer addition with overflow checking
+ * @a: pointer addend
+ * @b: numeric addend
+ * @d: pointer to store sum
+ *
+ * Returns 0 on success, 1 on wrap-around.
+ *
+ * Do not use this function directly, use check_add_overflow() instead.
+ *
+ * *@d holds the results of the attempted addition, which may wrap-around.
+ */
+#define __check_ptr_add_overflow(a, b, d)		\
+	({						\
+		typeof(a) __a = (a);			\
+		typeof(b) __b = (b);			\
+		size_t __bytes;				\
+		bool __overflow;			\
+							\
+		/* we want to perform the wrap-around, but retain the result */ \
+		__overflow = __builtin_mul_overflow(sizeof(*(__a)), __b, &__bytes); \
+		__builtin_add_overflow((unsigned long)(__a), __bytes, (unsigned long *)(d)) || \
+		__overflow;				\
+	})
+
 /**
  * check_add_overflow() - Calculate addition with overflow checking
  * @a: first addend
@@ -61,8 +98,11 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  *
  * *@d holds the results of the attempted addition, which may wrap-around.
  */
-#define check_add_overflow(a, b, d)	\
-	__must_check_overflow(__builtin_add_overflow(a, b, d))
+#define check_add_overflow(a, b, d)					\
+	__must_check_overflow(__builtin_choose_expr(__is_ptr(a),	\
+		__check_ptr_add_overflow(__filter_ptr(a), b, d),	\
+		__builtin_add_overflow(__filter_integral(a), b,		\
+				       __filter_ptrint(d))))
 
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index c527f6b75789..2d106e880956 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -45,13 +45,18 @@
 # define SKIP_64_ON_32(t)	do { } while (0)
 #endif
 
-#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
-	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
+#define DEFINE_TEST_ARRAY_NAMED_TYPED(n1, n2, n, t1, t2, t)	\
+	static const struct test_ ## n1 ## _ ## n2 ## __ ## n {	\
 		t1 a;						\
 		t2 b;						\
-		t sum, diff, prod;				\
+		t sum;						\
+		t diff;						\
+		t prod;						\
 		bool s_of, d_of, p_of;				\
-	} t1 ## _ ## t2 ## __ ## t ## _tests[]
+	} n1 ## _ ## n2 ## __ ## n ## _tests[]
+
+#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
+	DEFINE_TEST_ARRAY_NAMED_TYPED(t1, t2, t, t1, t2, t)
 
 #define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
 
@@ -251,8 +256,10 @@ DEFINE_TEST_ARRAY(s64) = {
 };
 
 #define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
-	int _a_orig = a, _a_bump = a + 1;				\
-	int _b_orig = b, _b_bump = b + 1;				\
+	typeof(a + 0) _a_orig = a;					\
+	typeof(a + 0) _a_bump = a + 1;					\
+	typeof(b + 0) _b_orig = b;					\
+	typeof(b + 0) _b_bump = b + 1;					\
 	bool _of;							\
 	t _r;								\
 									\
@@ -260,13 +267,13 @@ DEFINE_TEST_ARRAY(s64) = {
 	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
 		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
 		a, b, of ? "" : " not", #t);				\
-	KUNIT_EXPECT_EQ_MSG(test, _r, r,				\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
 		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
 		a, b, r, _r, #t);					\
 	/* Check for internal macro side-effects. */			\
 	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
-	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump, "Unexpected " #op " macro side-effect!\n"); \
-	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
 } while (0)
 
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
@@ -333,6 +340,55 @@ DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
 };
 DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
 
+#define DEFINE_TEST_PTR_FUNC_TYPED(n, t, fmt)				\
+static void do_ptr_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
+{									\
+	/* we're only doing single-direction sums, no product or division */ \
+	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);\
+}									\
+									\
+static void n ## _overflow_test(struct kunit *test) {			\
+	unsigned i;							\
+									\
+	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
+		do_ptr_test_ ## n(test, &n ## _tests[i]);		\
+	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
+		ARRAY_SIZE(n ## _tests), #n);				\
+}
+
+DEFINE_TEST_ARRAY_NAMED_TYPED(void, int, void, void *, int, void *) = {
+	{NULL, 0, NULL, NULL, NULL, false, false, false},
+	{(void *)0x30, 0x10, (void *)0x40, NULL, NULL, false, false, false},
+	{(void *)ULONG_MAX, 0, (void *)ULONG_MAX, NULL, NULL, false, false, false},
+	{(void *)ULONG_MAX, 1, NULL, NULL, NULL, true, false, false},
+	{(void *)ULONG_MAX, INT_MAX, (void *)(INT_MAX - 1), NULL, NULL, true, false, false},
+};
+DEFINE_TEST_PTR_FUNC_TYPED(void_int__void, void *, "%lx");
+
+struct _sized {
+	int a;
+	char b;
+};
+
+DEFINE_TEST_ARRAY_NAMED_TYPED(sized, int, sized, struct _sized *, int, struct _sized *) = {
+	{NULL, 0, NULL, NULL, NULL, false, false, false},
+	{NULL, 1, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, false, false, false},
+	{NULL, 0x10, (struct _sized *)(sizeof(struct _sized) * 0x10), NULL, NULL, false, false, false},
+	{(void *)(ULONG_MAX - sizeof(struct _sized)), 1, (struct _sized *)ULONG_MAX, NULL, NULL, false, false, false},
+	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 1, NULL, NULL, NULL, true, false, false},
+	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 2, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, true, false, false},
+	{(void *)(ULONG_MAX - sizeof(struct _sized) + 1), 3, (struct _sized *)(sizeof(struct _sized) * 2), NULL, NULL, true, false, false},
+};
+DEFINE_TEST_PTR_FUNC_TYPED(sized_int__sized, struct _sized *, "%lx");
+
+DEFINE_TEST_ARRAY_NAMED_TYPED(sized, size_t, sized, struct _sized *, size_t, struct _sized *) = {
+	{NULL, 0, NULL, NULL, NULL, false, false, false},
+	{NULL, 1, (struct _sized *)(sizeof(struct _sized)), NULL, NULL, false, false, false},
+	{NULL, 0x10, (struct _sized *)(sizeof(struct _sized) * 0x10), NULL, NULL, false, false, false},
+	{NULL, SIZE_MAX - 10, (struct _sized *)18446744073709551528UL, NULL, NULL, true, false, false},
+};
+DEFINE_TEST_PTR_FUNC_TYPED(sized_size_t__sized, struct _sized *, "%zu");
+
 /* Args are: value, shift, type, expected result, overflow expected */
 #define TEST_ONE_SHIFT(a, s, t, expect, of)	do {			\
 	typeof(a) __a = (a);						\
@@ -1122,6 +1178,9 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(s32_s32__s32_overflow_test),
 	KUNIT_CASE(u64_u64__u64_overflow_test),
 	KUNIT_CASE(s64_s64__s64_overflow_test),
+	KUNIT_CASE(void_int__void_overflow_test),
+	KUNIT_CASE(sized_int__sized_overflow_test),
+	KUNIT_CASE(sized_size_t__sized_overflow_test),
 	KUNIT_CASE(u32_u32__int_overflow_test),
 	KUNIT_CASE(u32_u32__u8_overflow_test),
 	KUNIT_CASE(u8_u8__int_overflow_test),
-- 
2.34.1


