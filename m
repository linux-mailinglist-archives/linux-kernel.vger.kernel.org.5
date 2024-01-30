Return-Path: <linux-kernel+bounces-45367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A144A842F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC04BB223DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92779943;
	Tue, 30 Jan 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kKoYfoDG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C47866F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652381; cv=none; b=oaqqpsjinTD9FMDkqSUsh9/gse4klx3v0SL8GNWm8wawij8jJGccQni9TlfAmI4iizYMZX1KA1lS3r02ldh1RX6l/KJ5KkKUpCsdVTB1VX8vz72Sk/kx0R+CvAzTtHfMEBpdlrvSBidFB9oaafumLEwzfU9QICJR9u9aJg0sQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652381; c=relaxed/simple;
	bh=yC6D2Eizr2psrnwwA4qhvvtdQ0LcAEcPaifv0qco7Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qA/59Db3DWJFE+q6r9WRZ/1fU0g6ZELrwBZV1vU03J7MfuSe7fjsuGNYOt40zuqhFIO0Ueh26N076OHhCOYAyGv1hJmCjWY28Kj/XvbGaN58dMIOOhyjzmeJLDItuH/nEExE0kIrF78UpVGPpd0ut86ar82r/1s0eGjVYservFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kKoYfoDG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d91397bd22so7259285ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706652378; x=1707257178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzQ7vFiYMTeVrAkzHMhY9QBXLQuQnHe/ph5NFW0GaXM=;
        b=kKoYfoDGuo1eyJQI8tlxF5tWUavzuAix9okxF0CE3AmOMgAT0GbU6k7PXMRDVL2RBj
         0nnfeIfH6FgI8w6mpGioJEZDJ7e2uDkS/hXnvmoova2q1NqZ37JTWT3KYv9u7q/w1tds
         SuO/C2Anwepo5f248ibnFX5Dr/Wyi7ii8uUoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652378; x=1707257178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzQ7vFiYMTeVrAkzHMhY9QBXLQuQnHe/ph5NFW0GaXM=;
        b=hCrnKuv7H7RMAuKX4H44p5jAHJsq5yw1onLeJHKY01J7e6W2uDSYaVt06EOdS3VS/4
         tLtpS83zBhsYlQe/nmaRw759Pj3GIUsXQmo0OisZvAhhNUDOtTSUZb9X/irelxF/PNVx
         38oVwWrI9d9MnGTFq0jswuEsuB15cuFSfceEwcBNKPkwDEvfvAqcmwvpOXyNT1jZC/lY
         zUdAueMeeUj7qfUVUGSX6j+LMCYy7hx7Xu84Q3fnGhHZ317j0vzn7uv3yD+5Y9xodYVy
         grp6Gye/fEC+xuaASNbBXJWwQnYT/Ps05ekr4Wr2efosm8t2scpVa8NrqAuDGmy+oePG
         enVw==
X-Gm-Message-State: AOJu0YxnAwuPc9hLDS9v1HO1xg8vk6WuXN3ZUDdy05eJatGsYLXxidOo
	zL5aIvTktzk585l3SfE95aE8SFugjr+dcs99AjGV986Y4zXNyaEz9zph/oaTxA==
X-Google-Smtp-Source: AGHT+IGzZlwU0MXV/5cSAxoNXH1SzaePvovUzfEFE1ulJPkFuOUHeABKKMVSmpksGBNhLRfKJuTKZw==
X-Received: by 2002:a17:902:64c8:b0:1d7:75a0:3c86 with SMTP id y8-20020a17090264c800b001d775a03c86mr775656pli.66.1706652378708;
        Tue, 30 Jan 2024 14:06:18 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902b10600b001d706912d1esm7690514plr.225.2024.01.30.14.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:06:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 5/5] overflow: Introduce inc_wrap() and dec_wrap()
Date: Tue, 30 Jan 2024 14:06:10 -0800
Message-Id: <20240130220614.1154497-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130220218.it.154-kees@kernel.org>
References: <20240130220218.it.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6254; i=keescook@chromium.org;
 h=from:subject; bh=yC6D2Eizr2psrnwwA4qhvvtdQ0LcAEcPaifv0qco7Dk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluXLS0ATCJtp/qR8GBQF2YJ6xD8OeGPPuokIWa
 WIkyhk7RLiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbly0gAKCRCJcvTf3G3A
 Ju4sD/wPbmqbSBI0CmdEMVroSWLFzHvcrcDEKt92REO7h0y2x+p8Ca4j2Q+roGDd5raGg96jqha
 uUUIej0AkmF/snly5wLNBli+Db3jFjRA67sUQ6Bmk/sIWkKhsuI7LOn2qeUgzQNM3C8bUI8mjUs
 zriVdFG4FNDe6j2zCPIRciZpUbEKXiKYYAcXb4o38CipVxVmx9v8QuKTEV1Ep4V+jaepOvqbASc
 vWXwsS9d5vqwMRqcAkwr1/71PtmuWO/NlR/Bmcyf16r1TCVqaZX6+zDQg1hgI7f9ay/8JfPBpdz
 YEYFRKHlDEuHhvLH4wM3SbW4iN3AA5puuVJlak08kvigQ4kSsbZyEXYa3j5W8ol+PbC//WM9jYj
 d+6LkAbhQQJUyDuNjbhhBrz/pmAyeUNzMJPQCauRBVmprN7o0utPp5qFmoUBARR75kUQ2arbLL6
 KrxysxBajTAF5gaWUtUYh5VYo4Ol1kYosQituWY9U5BodZvdefIPURNMJ81Kh9a9NXocoGsz9JV
 V6gFF9OuqhwF82rRcxCel2l13GrNj3Gl87FMQRv8T33XXWEGcP/OTtkfrOeTH8yRhlxuKcIPBOi
 9cCVQhUhqdjZvceD+FzJ8l9ctO9Ytv7SNTkscbfHleVQhI0i33YRSpN+Bnuxi464yuHHqFTkcNw e51m/Es65BQzHOw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This allows replacements of the idioms "var += offset" and "var -= offset"
with the inc_wrap() and dec_wrap() helpers respectively. They will avoid
wrap-around sanitizer instrumentation.

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 28 +++++++++++++++++++++
 lib/overflow_kunit.c     | 54 ++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index c9139f88578b..075c30218145 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -138,6 +138,20 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;					\
 	})
 
+/**
+ * inc_wrap() - Intentionally perform a wrapping increment
+ * @a: variable to be incremented
+ * @b: amount to add
+ *
+ * Increments @a by @b with wrap-around. Returns the resulting
+ * value of @a. Will not trip any wrap-around sanitizers.
+ */
+#define inc_wrap(var, offset)					\
+	({							\
+		typeof(var) *__ptr = &(var);			\
+		*__ptr = add_wrap(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -169,6 +183,20 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;					\
 	})
 
+/**
+ * dec_wrap() - Intentionally perform a wrapping decrement
+ * @a: variable to be decremented
+ * @b: amount to subtract
+ *
+ * Decrements @a by @b with wrap-around. Returns the resulting
+ * value of @a. Will not trip any wrap-around sanitizers.
+ */
+#define dec_wrap(var, offset)					\
+	({							\
+		typeof(var) *__ptr = &(var);			\
+		*__ptr = sub_wrap(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 319f950872bd..46af7ccde0c6 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -265,36 +265,76 @@ DEFINE_TEST_ARRAY(s64) = {
 									\
 	_of = check_ ## op ## _overflow(a, b, &_r);			\
 	KUNIT_EXPECT_EQ_MSG(test, _of, of,				\
-		"expected "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
+		"expected check "fmt" "sym" "fmt" to%s overflow (type %s)\n",	\
 		a, b, of ? "" : " not", #t);				\
 	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
-		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		"expected check "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
 		a, b, r, _r, #t);					\
 	/* Check for internal macro side-effects. */			\
 	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
-	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
-	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected check " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected check " #op " macro side-effect!\n"); \
 									\
 	_r = op ## _wrap(t, a, b);					\
 	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
-		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		"expected wrap "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
 		a, b, r, _r, #t);					\
 	/* Check for internal macro side-effects. */			\
 	_a_orig = a;							\
 	_b_orig = b;							\
 	_r = op ## _wrap(t, _a_orig++, _b_orig++);			\
-	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
-	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected wrap " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected wrap " #op " macro side-effect!\n"); \
+} while (0)
+
+static int global_counter;
+static void bump_counter(void) {
+	global_counter ++;
+}
+
+static int get_index(void) {
+	volatile int index = 0;
+	bump_counter();
+	return index;
+}
+
+#define check_self_op(fmt, op, sym, a, b) do {				\
+	typeof(a + 0) _a = a;						\
+	typeof(b + 0) _b = b;						\
+	typeof(a + 0) _a_sym = a;					\
+	typeof(a + 0) _a_orig[1] = { a };				\
+	typeof(b + 0) _b_orig = b;					\
+	typeof(b + 0) _b_bump = b + 1;					\
+	typeof(a + 0) _r;						\
+									\
+	_a_sym sym _b;							\
+	_r = op ## _wrap(_a, _b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == _a_sym,			\
+		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
+		a, b, _a_sym, _r);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _a == _a_sym,			\
+		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
+		a, b, _a_sym, _a);					\
+	/* Check for internal macro side-effects. */			\
+	global_counter = 0;						\
+	op ## _wrap(_a_orig[get_index()], _b_orig++);			\
+	KUNIT_EXPECT_EQ_MSG(test, global_counter, 1, "Unexpected " #op "_wrap() macro side-effect on arg1!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op "_wrap() macro side-effect on arg2!\n"); \
 } while (0)
 
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
 static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {									\
+	/* check_{add,sub,mul}_overflow() and {add,sub,mul}_wrap() */	\
 	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
 	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
 	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
 	check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	\
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
+	/* {inc,dec}_wrap() */						\
+	check_self_op(fmt, inc, +=, p->a, p->b);			\
+	check_self_op(fmt, inc, +=, p->b, p->a);			\
+	check_self_op(fmt, dec, -=, p->a, p->b);			\
 }									\
 									\
 static void n ## _overflow_test(struct kunit *test) {			\
-- 
2.34.1


