Return-Path: <linux-kernel+bounces-34466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E0837DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC798B2DB70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8F514690A;
	Tue, 23 Jan 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e78cyRK4"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767941468E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969711; cv=none; b=qK1JBI7va7msqaSTbLMem6VoKunFIdMGQfhORWqrC/AhU4QYMjUAq8S4ocZ8RjLFMWsMVabPmYs7of96p9gzHqdkCpRQ1pAzoqbpSdtMHe/wFZlLGtCZUtNY5bz6FIaDGzhvh1scQVO/z0xe/n7TjoxWlqQ9L3brVCL/iXL9t5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969711; c=relaxed/simple;
	bh=GmPAxgHKHubLn9MGZBZdUQq9TsG2fUO2ZtsyyqCrjXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWHqTy/sKuIDEhgMv5jrgvMGZctLVnpx5NKO8zGmN1cHwR5HnQWmOF8kpHiLpUN0Tjj06o7gpPZ9ukskMjEUo9yKN8dE0d8y94n6IgFS6UAYhGGh61CHtxCVFOp6zy31+kV1kDgwNBN4rhOhPbb4EPHLXmK7Ivj1y2MO5qSfL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e78cyRK4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2349a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969708; x=1706574508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lArTqUWjSpk/OeY3+qANt+dZXdElsgEYjM7TfGsNafw=;
        b=e78cyRK4J2W1iHVEI8zdJDTYHx197PlonyDIjYn2Ih2ngXE/iccjvOD/CLy0KpbASX
         nMt3dUjdom+vz3WOMhHDtY94QzGosA5jorPJ/tFtPC+RBDk3YmfP45XMWcl/IvYlRKT7
         34waM7kYU0V/rUdZJv0fnyAXyX+WVlESS0j/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969708; x=1706574508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lArTqUWjSpk/OeY3+qANt+dZXdElsgEYjM7TfGsNafw=;
        b=vJzByxBi4f7ZVO0ji/rjbxjDimv4T53nmO9C9ys4AV0o2TEky5UKjvvXqhEVAO14Py
         isgLHm4pfZWsuQf/NOf9ySpLEFHxKIHA0glYtxrsfkDEbjzpBzxPNMu+AZmGBfIl3awv
         FFw4nsUUhD2n0pvB/K0N3+0O7FyJ1ij/2vlDdqTI0/vTe7QBfiwJ9ENYexAAi74WO7ma
         bfuqOPJ6d0pCCjvN1RBDDsuPwO/XXypGl/aY5Fxsm1KsKTYRBTTOuaHwkI6JVzCom/Qd
         I6Hg5UfADkqK3hmr8tggisvWAuaACXoLcdmlbL8PfTCiMBPB+uJev97sSGks++KKzdHZ
         DwTA==
X-Gm-Message-State: AOJu0Yyeg50jFwtFtbf/0FboU/A1VwQBWeKDrXiwobFnrqbX9Jhd6xnW
	1/yzAw98WuLdXVJJcDuwnNRxNzKPAbIkd+BOUwPIkfq/OZNDoxp4WOgB5qI71w==
X-Google-Smtp-Source: AGHT+IEL0OAhszuTE+DREqBy8kuie4n5JflXi9iAa/aUSzhFQ8heJUVRu/5klVCwSbJzSq+AVnRchw==
X-Received: by 2002:a05:6a20:8f09:b0:195:2770:5b7e with SMTP id b9-20020a056a208f0900b0019527705b7emr2683349pzk.119.1705969707738;
        Mon, 22 Jan 2024 16:28:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001d564115807sm7664893plx.46.2024.01.22.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/82] overflow: Expand check_add_overflow() for pointer addition
Date: Mon, 22 Jan 2024 16:26:36 -0800
Message-Id: <20240123002814.1396804-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10628; i=keescook@chromium.org;
 h=from:subject; bh=GmPAxgHKHubLn9MGZBZdUQq9TsG2fUO2ZtsyyqCrjXQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgDoUKTmAuWb19BxZjUN7+ddA/jXHTbKdyVN
 EfDFJR+7eOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IAwAKCRCJcvTf3G3A
 JpSCEACQ5mYrM7i5JOmYbVd+Q5AkrUZpJML/LWSTJVslOGTKtFY7pOJ4b5nGs0MuTs4RA6hn1fb
 fwi3JkVl/ohmms70RbzK9zztLs5bUM4HYuL+lomFGyZrxI/fzmKPtla94BdVgpWTXhJRWjWv5Yn
 2NBYey87p5SzGF/++U1RVuiMq6irTQcHecMhx7h1MYdtta20/en2Dps48cCka58pdT3v+2fASMj
 459rPl8qXF7VEfxqWA9kdjoCHnV7iLUFsngzMmV4T5bfSiNylZs1Quyc/XV0qHDaBvtZU8ahbmC
 ZE7QtaJmnp303xY4TT1jeblUY/MKFrZ7gxzx9ATtJIsOXEsp/4YbFJPUff3iAc3pLczCXi8qLYL
 extKud6V9k/5mf5uuNS7O3VlrHPELWkn9o4qIlonPGnLzkqT5F+K3Q1TNxI8uucoejBpS2nCXzz
 LpYDCVGx3Cz9e3Etw3mQmvgQbiRvlsE1gbhqAc8KzV0rB2e7LjUrdH1pHfUvW1M5/ED8RNiI0Ni
 evuBn4TAQKwKKykbMCeHS9Z8Nxai3n7wmHR+G1VK7TtLr389KSIRwKVsnEdaP84x07FTHGaaAtL
 qQkir3gVSorK9Sv6pAedjKOW1Azqro0bZpCflFfsyE2QTuP22RUSNSKiKEl23FNt+1FTcexvBU8 Zxt/lP9SN8nyIPA==
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
 3 files changed, 121 insertions(+), 10 deletions(-)

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
index 7b5cf4a5cd19..099f2e559aa8 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -51,6 +51,45 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
+ * Returns 0 on success.
+ *
+ * Do not use this function directly, use check_add_overflow() instead.
+ *
+ * *@d holds the results of the attempted addition, but is not considered
+ * "safe for use" on a non-zero return value, which indicates that the
+ * sum has overflowed or been truncated.
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
@@ -64,7 +103,10 @@ static inline bool __must_check __must_check_overflow(bool overflow)
  * sum has overflowed or been truncated.
  */
 #define check_add_overflow(a, b, d)	\
-	__must_check_overflow(__builtin_add_overflow(a, b, d))
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


