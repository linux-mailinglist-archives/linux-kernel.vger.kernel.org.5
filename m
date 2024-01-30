Return-Path: <linux-kernel+bounces-45363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0060C842F58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2BB1F2548E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579B5762DD;
	Tue, 30 Jan 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfOHYvuP"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BF7D3FA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652377; cv=none; b=DWZxOLQvwSVMpU+Jk6X4r7I3Pq+9KCPB9Ch6MuIBtXPGrrILVJhis88AQULk51h/ompzl2l7na6hTULZfCMqNFoKbbARv4VOleQP3CYM/KHzP0OfLNRy9nIuXF2Ixp1a/utIAu/fbl2rOQL6XFu6T1a26js3Yniv7ehY+b3mas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652377; c=relaxed/simple;
	bh=wU5wiWooVyd2eqSdpoTBHd90qKwM9wZ/F9mLDiaQmqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raE3R28UVkQHsQ6V0JIcgjWeWfRyeM7p0I7Wd0mj9bBHWpwDjNq/Qez+5BchrbvvVUD1oqyTL71wVTLDfDogIfRP5m24h+B/b7GDd92KQ731HRVq8F2ha6WpYf4AmBNfEfpCOzFMo5Pi8Ncs1FoFrxsv0DUoeWjGPNi2d/wOaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kfOHYvuP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2283487a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706652375; x=1707257175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLoyWv8OtbHjtjHwspyJBOM+KJjmRvPEg1tZQlUAAzg=;
        b=kfOHYvuPK1IX9lQxpDuAMMkdrFbyN8cno0Ha9ci8dVkRYiASuC8nvrCc8rRKtx6IQQ
         jTPlb0LNX2b6M/6lKDIxvHsD4qWoJCdZv6SoM9gdN3vhLldAUmsNOKlmGMBdPcu3AIFU
         SVex/IriVcrHh7+OuSHKCikqRoynHK1d/Wr7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652375; x=1707257175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLoyWv8OtbHjtjHwspyJBOM+KJjmRvPEg1tZQlUAAzg=;
        b=twVm6hKh9Vml5PPMlD5OMG6lD4KWUpxitBHfUrHFq12Rd9S9wPxH1rpmC6n9Kzp8si
         ky9OLfn+FHQZrjImrmEvxpeBlceeYcByZIf1OYy81AHmI+xX3ccNSuo0hc20KcFTSQAL
         yIzUE2nJX+vLHaIyrzHqvjrw+TK/u9aLih0SMuRArzjAyyqG+UYMoBQrysQjd3n/KLdE
         6zxDNOVygGDFlCHTQDu8Z88AIQ9xPzkgJO47212JWXLxLJPU7zGtxsPxdWiMrDY7Iz/w
         YsDOQO3twxd5GH++GElxCgSsM0qTJ3TFI0JNCmprvFDrrKIE3kP61shKTmmQ6KXCtqLN
         ZJ8g==
X-Gm-Message-State: AOJu0Ywbg8/Pk1GU4FGz36p/j8ubeWBnk0P5FOFah6UH37t6CaDbp2wG
	1DzdG2UkFSE6owDM5aaMgZdBHSJ7P/eInKubnEgQ7QPR1ZW4MmPRMEUg+zfM3w==
X-Google-Smtp-Source: AGHT+IEhkW9fawB+RfxZA8/LTl4ybX0trJVe7R6hgeVDy2kpvJ5enfZuKr5R42usSZ3qcav99HXhKQ==
X-Received: by 2002:a05:6a20:b9a7:b0:19c:7bc4:6b0 with SMTP id ff39-20020a056a20b9a700b0019c7bc406b0mr4716562pzb.42.1706652375177;
        Tue, 30 Jan 2024 14:06:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001d72f6ba383sm3691421pld.224.2024.01.30.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:06:14 -0800 (PST)
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
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] overflow: Expand check_add_overflow() for pointer addition
Date: Tue, 30 Jan 2024 14:06:07 -0800
Message-Id: <20240130220614.1154497-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130220218.it.154-kees@kernel.org>
References: <20240130220218.it.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10664; i=keescook@chromium.org;
 h=from:subject; bh=wU5wiWooVyd2eqSdpoTBHd90qKwM9wZ/F9mLDiaQmqs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluXLROmJWNChP5gjc4TpxLGURO5jKzEEgWMbHO
 GpeBzggvUWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbly0QAKCRCJcvTf3G3A
 JldrD/9TuUJyp3YsW0TEykPmrvgH9vU+VjqFQEapybkawwEcPT72Aav3rQMCiud+MIQNu6QDnza
 CziIeADD0D81cGp5ZDuEDQY/HMptU+dssftL2CzDrVhdYspifI9JTq7EzqvgPqZeSo4t9US+kdE
 VtNO3CQVdcCYyUkHY3/CaLNUTJXMbMIK8swjlCViq1GtWE6lINsWzXLvW73bdzXOIB87YTivK4h
 hUGpD80CMy+07kiguOKKqrZ1ZPg2Y3XRx4vKNyzho0Kg4J2FcPZ7Oz79L97PUwcvaFTavvGrxHd
 fiKI1LEhE6WcBZqugHyqNgTpWPGDxJzpNanmeVmDy9E0hoL4A1svI5VEmHAI+Ut4JVqCxfkM7iS
 sDmgJPatT0uJuTcqofzQ+awJUUlzRRUgE3GTHAcwKUJzC882pEk2y6JXA60mef01JINAyLuHV2f
 /dNrGRT5kg9DEak+3v3pvUdtF8p99GKUDb4fZDzhvPBPYfU0gWyNNpCYY3LruDTcwSzcFa/MeRH
 TwoZ3TqKgHYYg2sC1FrZNgYWC8oAtVXxLOXBHDPkmxvrwLggAs3Qu4Erms4l20o00Wbyk7G6MLO
 BqxhPRQG0RZHMXBZ2LriEnaX1mA6uS6p5PRqI6v/hLMX5bYBFzkkCBGwbO+VCZF/vAyQuQ4bnUT 3lM/omqZkKwDXgg==
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


