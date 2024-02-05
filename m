Return-Path: <linux-kernel+bounces-52271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDAC849619
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70B2281FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401212E45;
	Mon,  5 Feb 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQfGdFVW"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD5125B8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124358; cv=none; b=GaHrGBQv4ELdjGmpal1lYotoFu8wtASbiLKRLVR7hkmZLBNm62ht8vudqn3CLOiG4jLKOeo7WXAJDZ8t9oqtqYz77dV09DAel1MjQAAlieWKqDTzu4H3LwiywyganKzgKkq958aho4zWI4I60BIBYlzBVeDEhaqyxxgf6GRuKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124358; c=relaxed/simple;
	bh=BleaLxaprNdd2Ls0XK+kcFDPaLkJ843EpGNnQRcoyMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3DV9UYY0/xsT9LMZliX5sk24WQ7x15aTEinCTlQnq4lq0f1CrpezXwwHMIZ4XpP8p18gvwI+chu/Xs1bFjtCnrY61eG2V7m8UXEia9ity1lyZ0lskz72s8sN3zBt6NZzEEFGxkVvd56Cjgct2EyUGJ+rM7aRlxDATVJEZP8c8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQfGdFVW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso3585338a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707124356; x=1707729156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jniMpSsyDsU5fAoe54+F89x9cv/B23a7/rxO8q9YHEU=;
        b=XQfGdFVWO0p+PX12ExVRiTRWXeOYHViZ/JWxQHMN38xoApPy9zCKbb1DGOGAxtYMqc
         j9NWO3cR4GGqytLtYTf1bgy4MlguQcBFkHrucXIdn+WMLg2FJSOe1eDkK4GrbmV/Rbjf
         JkodyDGqWIKIKAC8cTY/m4JkHecomh5MNNzvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124356; x=1707729156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jniMpSsyDsU5fAoe54+F89x9cv/B23a7/rxO8q9YHEU=;
        b=SRXr0TLIJxoQVYpWvenhW1VtvKTGLVyAPSavNyuLbGHSzIYRoTHE8Ja3gA5SFhPOF9
         JHHvktNjhJdr6j4zjRCmVpjNdSdiBIwcfWY7HJQUIKJWfPO3S4tOVHDUcPvE0Bydgs/b
         ngMormbH4PkvEAqnUOHM96KVmMSG3XDb6vvr0DWvbB+K1vkizImLIKklViYlqUD2YAnM
         bWRy7pbR4nplyVfKfcpyqIWcrBE3yxHCW4VTsEv2ey/auX0CqSNoxwn4uLwpoC1OTKS0
         cYVFnGhDkK5Hu6JADp4tC0Uw+tM3VqZYaog2gKMpfzsmuBYdmZtci24u6tPqsIrwz8Ax
         3/NA==
X-Gm-Message-State: AOJu0YyosbjNIieSc5rogIWDz4saDR1wdmZC3CqfCm8brNrfpVLi/2yQ
	P7dVqEOrr09IJKqyX/L49SGD7Dg9g4GP75qJ34eST6Jwx4YoOu+WFchjlncAww==
X-Google-Smtp-Source: AGHT+IEi6SZEoKM0ZzkSN0DC6BfHVMttBxqE3zAuBAryrMJegKzNEVIAYKJ84mYzUxRCEYjmfZFWAQ==
X-Received: by 2002:a05:6a21:2d8b:b0:19c:61b9:d9bb with SMTP id ty11-20020a056a212d8b00b0019c61b9d9bbmr9712518pzb.8.1707124356612;
        Mon, 05 Feb 2024 01:12:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVDvA96yjO/KwcQR41cix9tuSjfftoIF+xmpKioEFUhdprdWIt0pZSh61sqHp33TIoS1UHA9/wAuFVqJCk7QKpDxgUJ9KXq4shewdbUN3sU7aQv08Gu6dD8fcnrUbhHiinpqZdJ00donD8iL/jnNk/Wgvjq7JfBxofQ+Yg/3scTTEGOLttrfvC+8+E6YMxmmLoR3IA76abHYWvdrrPMaEpiSam2wpymyQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r22-20020a62e416000000b006e03cce3f4asm2280702pfh.25.2024.02.05.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:12:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] overflow: Introduce inc_wrap() and dec_wrap()
Date: Mon,  5 Feb 2024 01:12:31 -0800
Message-Id: <20240205091233.1357377-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205090854.make.507-kees@kernel.org>
References: <20240205090854.make.507-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4480; i=keescook@chromium.org;
 h=from:subject; bh=BleaLxaprNdd2Ls0XK+kcFDPaLkJ843EpGNnQRcoyMU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwKZ/47AUqLm5ToJr980/JQTh0fsearVme/cqG
 RQaW2oif+qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcCmfwAKCRCJcvTf3G3A
 Jig5D/9LTGnRArg0ixC/Igu7Weo0f3WLiXQISsIPY7j85lWdvoVeZyJ0V87CuTxxChHPBIDb0Ze
 g/y15S7sis0rYZa2ZtEF6dgK9GCv08iOgJbkLWO/RJ58Mcltp6AkmzpcrAbVNiV0CY3yhZzq4aE
 /7o3sYZfqZv4bDrUuzaCnOlBcEdcVW1jHLJIkfklpFd1Eyxoq9Ec/nsN88H4K8HrjZLpXwQpe1k
 cAU1LsePQNAOvkmjkBF2pm12SsTu2gehJJ31jNczjIL6LtJ9uhiOUUZ6i3KiIz0l0cNlDC3N26H
 YVTRkOLO11m6cL3GGORuZ5R6fNuUYCpmLvsaRjEZx4fXlHzpk9G+cqqUEgNGd9REKFcRkXXMQ85
 tL0i1KFlUXs7JXdeMicgHrT6Ub+mii46osYMpJ4xzLSs7jFAzodrToS9+N3GwzMZYBxGuDI3o+3
 K35QXFDSVLKhJ9fYxEmC5qppuQkWKzPqW0Q8RjEsGpRFdVreVm1vQzCi1NJ/Q49fNjljmCru+e2
 9/y79fOVtlpqZMVsvRILZL79qVbGBDJ/KuMAeH4UrjBPsEJuQCoZf27NLy5CPnuJ+UBGNtIBiHn
 lkMMWm6QOiQcXZkC3Q9f+selb3BETCjUv1U9aR0qquKjV0fqsoSzVCSwYrhWOGSt00cP0Ongw3b aCoe6Sbbn5LaNOg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This allows replacements of the idioms "var += offset" and "var -= offset"
with the inc_wrap() and dec_wrap() helpers respectively. They will avoid
wrap-around sanitizer instrumentation.

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 28 +++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 9b8c05bdb788..6a4c18544ab1 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -82,6 +82,20 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;					\
 	})
 
+/**
+ * inc_wrap() - Intentionally perform a wrapping increment
+ * @var: variable to be incremented
+ * @offset: amount to add
+ *
+ * Increments @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
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
@@ -113,6 +127,20 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;					\
 	})
 
+/**
+ * dec_wrap() - Intentionally perform a wrapping decrement
+ * @var: variable to be decremented
+ * @offset: amount to subtract
+ *
+ * Decrements @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
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
index 064dccd973ad..23e37bce0022 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -284,14 +284,56 @@ DEFINE_TEST_ARRAY(s64) = {
 		"Unexpected wrap " #op " macro side-effect!\n");	\
 } while (0)
 
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
+	KUNIT_EXPECT_EQ_MSG(test, global_counter, 1,			\
+		"Unexpected " #op "_wrap() macro side-effect on arg1!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected " #op "_wrap() macro side-effect on arg2!\n"); \
+} while (0)
+
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


