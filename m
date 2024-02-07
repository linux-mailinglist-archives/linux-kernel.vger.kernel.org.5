Return-Path: <linux-kernel+bounces-56714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC0884CDF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C3D1F24EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3E80032;
	Wed,  7 Feb 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="it9IdQ+Y"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA57F7DF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319468; cv=none; b=vD146GQQu/iY6SCRnIbcm8ZjZS7xIuZbujHlijc8dP0pF83XFcgz0iHVNohcNQnuFYJNgqgI1hbOK2NMSttAqmRb8teAOSXeEkK1NubcycpKXA0vThxexsn3BagKh1GK4K9gSNNteB9iAMON9wawKZZCJM6/xDJ4SclA2bylXco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319468; c=relaxed/simple;
	bh=UF4ZOJtI7adR1ITE12VYKN2eWkYypBgjoqWUYT5HRLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQu1h67W01+KasnskF2vr7l0C0EU93z3dAh91M2g9MAHqUHjZ8HWCUByWPM3jalUK4ydRQvwSSHHobiFtzp7wGiX0DoaX4XnOqBMBEYt5a1llSHlNjjoT4eVEbpYnx9fL7gihI6r1iZedABix1jDUk4a9zABRb9WVgQ1rpzu1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=it9IdQ+Y; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363b2cc93a8so2646905ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707319466; x=1707924266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EnFY1zWcdu8s/mjer9aS3MtbQycrZesMBVuK3m9B0g=;
        b=it9IdQ+Y4JrTK1mcLttbVNTGIVvWN7I4MpBJRJJuefxlfo+KY8TScUC/f9iJo9SFG1
         ffaDNp+ISbsxgA/vdcYKuUzzAXL5/rQI3k5gYo+AkQmzbVmZk7esj15XjMB5e+itNq9A
         cncRON5ewJYe40jyiEV2S0swdtwpdSfMjaSjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319466; x=1707924266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EnFY1zWcdu8s/mjer9aS3MtbQycrZesMBVuK3m9B0g=;
        b=dpXtz03/4K2paAevYiyv/FWzIgeE1YOji2fP2BJthy9zKR7IuuIKM7OP9xEUvqbaT5
         GfM8klG2trQfejsYbJWbeprDvzdJk0HUpTDV2/Wp8twOKCCpzo00vfdUIUxSW7mNrrZg
         hDZn2iQPpba6X3k8ssf05p1iS58ik/U/9r+g17gJ/QonR5IZEHLKS+XKTzGE8rEgSUS2
         nZ5e+WZ0HSeqkLKeTtBiM2/OD4wVTvLnZ+50Gahpre4iVW/tsYpK/nfwBE2QHD5UEXvt
         bj/vBwSr5mLtydYp5KDMT1OAp5/pB5Q5IiGVPypek5P1YvLVwouut1aIhM8k6EmZa1l2
         C16Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlqTd4+RIt/pYHwujTBEk+xK57M4lhIS6nCmKRJELAz9qi9TRs8LsbvHmhnUV97lPGD7pOwa3qTWAUVo7XEMjpONeqXZTO8vDg37O+
X-Gm-Message-State: AOJu0Yw2O8hzvyYdjXcSBLtSEzRl/28gnu7G4blH6oV1fOx1uCbYtcPf
	ify/QM5jNDqLhBZGBsCDJbSFtlzXR77VhlABLavIsdSRN2VcoGMCDsHZaBL+cQ==
X-Google-Smtp-Source: AGHT+IE7j6jvYG+FoRxng/qxJh/jMF7VivG99Q7IA7DvNTnNu+DsCHFscKs16yM26kcFbL+bKi7DUA==
X-Received: by 2002:a92:c5ad:0:b0:363:b519:bff0 with SMTP id r13-20020a92c5ad000000b00363b519bff0mr6021971ilt.23.1707319466265;
        Wed, 07 Feb 2024 07:24:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeS11GMGkn+N1jnRT9igB6tGXtdjWUgYdh+a9ZUhg+63egyGammrT3oOfUDicT/SFBZod7cWWHqfpaP4Fff84UEy1gDTfc0KLGBBGRGgHBECtjrWYXPlVrjuoz7iZnqF7jb1+U1fMf0ZmxB3RkPuwtR6FSq3pEIOwXfF9yvC7uK2EV2gjvG1/68EjYurTdPZB2HUkpcGCImdt5OiWRKk8hw5Uhn+ZjY9XLNK+pMPoZMF27sUF7p4ZZkg92D9VDr5+dMIB+/0awbiK9bpqsBlfSKbs0ml3RidV2jTlCAWWD3OwC1xYX9Zd0rA8aO27skohWzu7g2vQPxQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bn20-20020a056a02031400b005dbed0ffb10sm1547254pgb.83.2024.02.07.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:24:24 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] overflow: Introduce wrapping_inc() and wrapping_dec()
Date: Wed,  7 Feb 2024 07:24:20 -0800
Message-Id: <20240207152422.3855315-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207152317.do.560-kees@kernel.org>
References: <20240207152317.do.560-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4594; i=keescook@chromium.org;
 h=from:subject; bh=UF4ZOJtI7adR1ITE12VYKN2eWkYypBgjoqWUYT5HRLA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlw6Ck4Knv0CZm8IYel3Z4RJZj9vYED+A+0Ru26
 cX6qKGKwNmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcOgpAAKCRCJcvTf3G3A
 JoQzD/wI+8Lf+6AaeGFKfxalG4dQxHYlwN0aqDm8Alb9xyyctuWdjfXnTerEf7Zbl0mQKHHonps
 M8lLZGpLU8sHrOb5ycfRTBw09he+nj3AF9xKEuGKkZ9O8ycxUVz2HqcRyF+lqTKV063RfCkqujw
 zEGzjrVLjgVd0x1FxNUztDEgZV73ow9l+Cfgp8ERi+ikCTsGdUoho3AorJsW8Y0qvR3JXMM97jQ
 xFbGLZ0PCLojIvcxjdrKESl63H9hPevoJIB0FG/Sn6WVxyN7kot9WPDJfgQ2WIUqtwMGrXBPDjz
 OR4YrvEdTDY0TkalsfmYhzoanRrSbRXil3oygyW9YDJKtGsa/+yNubbxSCzacaSqIQRs1oeJmnZ
 6IcVxM6bLXJWil6fIa6eUCvhAImjxYs1wh5jG9ZzqnjWfugekmyuEBd/0tHmJ+grIqjRmpVJBrb
 omBgutZBtt0zqBiK9fTx0LQWQmSCtFnzFvDKPYhIIY0IAYoi3Nml87y7pXmeBcuWEW7n6uUNpKx
 sJZqMfGtB3ozLCe+nRdTGn39Dq7lh/XJNaYN9FHtqFdo9Hi7R7iHMrW4xnR/Xt8vV4E2jesuwhs
 X0RHoojimonoJ4txcOJ1P4/8GMLM7KbV4havukwMIjKe34cKjTWZBEkWR09W6VfbAhNC0O9sc30 hB55mBv3p5236Ng==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This allows replacements of the idioms "var += offset" and "var -= offset"
with the wrapping_inc() and wrapping_dec() helpers respectively. They
will avoid wrap-around sanitizer instrumentation.

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 849a49fb496e..f4b18007fd2b 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -80,6 +80,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * wrapping_inc() - Intentionally perform a wrapping increment
+ * @var: variable to be incremented
+ * @offset: amount to add
+ *
+ * Increments @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_inc(var, offset)					\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_add(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -109,6 +125,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * wrapping_dec() - Intentionally perform a wrapping decrement
+ * @var: variable to be decremented
+ * @offset: amount to subtract
+ *
+ * Decrements @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_dec(var, offset)					\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_sub(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index d3fdb906d3fe..6cadce8f8a47 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -284,6 +284,45 @@ DEFINE_TEST_ARRAY(s64) = {
 		"Unexpected wrap " #op " macro side-effect!\n");	\
 } while (0)
 
+static int global_counter;
+static void bump_counter(void)
+{
+	global_counter++;
+}
+
+static int get_index(void)
+{
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
+	_r = wrapping_ ## op(_a, _b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == _a_sym,			\
+		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
+		a, b, _a_sym, _r);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _a == _a_sym,			\
+		"expected "fmt" "#op" "fmt" == "fmt", got "fmt"\n",	\
+		a, b, _a_sym, _a);					\
+	/* Check for internal macro side-effects. */			\
+	global_counter = 0;						\
+	wrapping_ ## op(_a_orig[get_index()], _b_orig++);		\
+	KUNIT_EXPECT_EQ_MSG(test, global_counter, 1,			\
+		"Unexpected wrapping_" #op " macro side-effect on arg1!\n"); \
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected wrapping_" #op " macro side-effect on arg2!\n"); \
+} while (0)
+
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
 static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 {									\
@@ -293,6 +332,10 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
 	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
 	check_one_op(t, fmt, mul, "*", p->a, p->b, p->prod, p->p_of);	\
 	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
+	/* wrapping_{inc,dec}() */					\
+	check_self_op(fmt, inc, +=, p->a, p->b);			\
+	check_self_op(fmt, inc, +=, p->b, p->a);			\
+	check_self_op(fmt, dec, -=, p->a, p->b);			\
 }									\
 									\
 static void n ## _overflow_test(struct kunit *test) {			\
-- 
2.34.1


