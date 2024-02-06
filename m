Return-Path: <linux-kernel+bounces-54691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD984B286
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A417282D70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F21EB21;
	Tue,  6 Feb 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gbv2Kr3O"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306A1AB7E2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215524; cv=none; b=cLQPdqkWlYO0jW8afSxLq9lqk8EoZuFtZRlRrbvd7V0+Y8wn8Oh2XEi4AOufIZLQ9r+M7k7YngxRohJDn297cCYUG7Lws3ZPKqfe4cUx0gPFNddyNT+r3PN3hXdijPbC89WI2VurTHzSfe1DUKWlENxjUF7+Q2L2o7ssKrLD6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215524; c=relaxed/simple;
	bh=DbmgLK5FCaGALvzwgkJxPr5U6aJ/eDPf0sDwp7xRfDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHyfyt072Jq8hDmilqfLQV2go+FeLxsd2l/wMuRaS3MS+0TjrTUchlCb2SVRWkDpA2vnb4GAr1k/ZcGERn95aaMyfXQH2Tyzn2eJQsvGlcOFaznr5W0qCTbYfrLxReupgzToQxNSaPHmxZTihnwords3RWH0XNcZSR4oZbbABRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gbv2Kr3O; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so4007297a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707215522; x=1707820322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhFCws/Ub8aMZOpLyoDbYEiUVdxcrMWspU59qodMGdQ=;
        b=gbv2Kr3OHPjJzTq4TMso9j5nYJZYOdz4BIhDoijSZkmM7b1GC7Age+OuuAGC6dNlte
         OBVN0hMZjhys51Nfl2zIULZerufkAjn4Qfr/Mn5woLHJk76rh8zAmPfQX24ohYOhPt3s
         qn98UQETftRhr4PcwIQYgU/kkvuIzil0E+t8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215522; x=1707820322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhFCws/Ub8aMZOpLyoDbYEiUVdxcrMWspU59qodMGdQ=;
        b=laZwMrivpYgrTb8ukcKHtxSfurUCTmho/z8Ys5I2HMPDEty9ijR94dROFELWKAIMeb
         mf7+N7U7QgjSgEsf+CHaFnF1OZfn5sZt9U+saqRcI98xTfCCARd6OebG244D/enwftMu
         KT8K0ZOordB0dPLzXp8hEitPiJb/nBqgmDcjL5zGCSWiWH6xY1G1GTeor1VTicizWmzr
         rCKpe/SRH+jpThNI62WebW8IqypZsmVWhVJK4fXd6r+L8Erv7LGYvmiow6zAg81kjgtf
         gzIrTX9eAmERYtyAG+Yt/SxIipogAMPQaMCfbnHTio/uLn1LFhYiMw+hxBd2wl1lGbqC
         XaEw==
X-Gm-Message-State: AOJu0YzW8mBE+1ldOaeKPV7tVwu4/5odjIqZg7kkZxwizjPR99SPoGm/
	aHUv1+7xvDD5UrS0cpoW7MWYaCBjVAWtAdTaHRtFb4wn1xDF7y/KtsnH2TmJnQ==
X-Google-Smtp-Source: AGHT+IFfpA1Dsjtclw11u64fwTkWqfKgMYMn6mW+iodny5UX6JDfSd5PjwUEAglPonEYpimmxIqquw==
X-Received: by 2002:a17:90a:f494:b0:295:d782:95df with SMTP id bx20-20020a17090af49400b00295d78295dfmr2109624pjb.34.1707215522544;
        Tue, 06 Feb 2024 02:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6xKecjlbMLOyR7rsVt6VQVhxc1dg/yMd5hmR9JhAIFhOtIY0O6kh1WCLq5KNQsHnLKfnJgJyUDpchLNTHtKalC7uSYWpZ5oYdp+VO5sLE268Kh8+GtJ6DES7u6soeofZAWViHoL+NNRO5u3JhWNt4blVuWdAoJ8WN6+R6UbHkJ3q4XWMYLa3hlhPIxScIjT2PsjnOzcqsPXb8ag9WuSLE67m0ZiH/UTU1zXptEQw/snC56WwdjNNnKH2r+JitAMNuqKgVUztGDstl2VefltqvBpD4Dd+VG4TBfLGY
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ecc500b001d752c4f36asm1489543plh.78.2024.02.06.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:32:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
Date: Tue,  6 Feb 2024 02:31:55 -0800
Message-Id: <20240206103201.2013060-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206102354.make.081-kees@kernel.org>
References: <20240206102354.make.081-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5732; i=keescook@chromium.org;
 h=from:subject; bh=DbmgLK5FCaGALvzwgkJxPr5U6aJ/eDPf0sDwp7xRfDM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwgqciWHmTjoSuG/dx6zOi/1l/YjqP+laoqdfR
 ovdssAE7m6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcIKnAAKCRCJcvTf3G3A
 JsXxD/wLUYpp78EMl8iOGH6disPMQua5RJtfe5N1B4ytfwBB+lsT7+xb3YG3ihf+QTvdR8acujV
 LJz2JioIhloCYJxZsh/sdr6RxglRGzJRuZeFeTnPJxgc7tdmzmFvGcSZ0EnqccKRu3llkDcD3qy
 KEl8wNBJzwigEn9+RtrlT50EdAAN+ONrrGlCbJvQ0OTCWTgdYvnXSre2h7AdvmPCtViKgF7v7MK
 hIQJJ6ev6Re0ZWoiwVyx5tYKI0mXOybtQLvrzBRqpp/oAuf3OmGt5u1lhQORCYSSAzgnWkBZ1sG
 W4R7o1Hd8J7X64Qhm/vVrnSjAlvq85wzHnHGRxsuT2KpUGPyKqRS4F9PKahzAO0xGiDnknvPWVr
 uLo/5R6NQFrQO4dQa+o3/DsX9XlCSZP0AF6Ny3Zwv3UCsY4STZv9Ouy1PyYbBCKrLaWRTHMjESU
 vMD5kg9YQKl/BSRWPJqFxDnvycSfRZf3isW820kO2dwgm9yjh++HR4i0quEbGRHEczay/XJIAor
 vPhHn2AV1T6xBHqGfhMmfwNEnP5RSyPKq5grCMeue1tI5HGCEO20qsyqs5HNF0Dpnmp74rU+Mfz
 S9j0POaTnS0wRZCnt03d7BLdam2qnsPVFeriTl9AVZ6lm90pNeOCge31dNokQIaMGCauu70mLc2 oQeyhZ32FLyJBXA==
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
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 24 +++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4e741ebb8005..429c4d61a940 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
+		if (__builtin_add_overflow(a, b, &__val)) {	\
+			/* do nothing */			\
+		}						\
+		__val;						\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -77,6 +95,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
+		if (__builtin_sub_overflow(a, b, &__val)) {	\
+			/* do nothing */			\
+		}						\
+		__val;						\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
@@ -90,6 +126,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
+		if (__builtin_mul_overflow(a, b, &__val)) {	\
+			/* do nothing */			\
+		}						\
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


