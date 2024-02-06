Return-Path: <linux-kernel+bounces-54694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A184B289
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA51C22873
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D45B1EA;
	Tue,  6 Feb 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="djXBH0S0"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EDB1EB34
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215527; cv=none; b=MGHF4UKliugq8wbMtxllCtNh01TsJ5YPYzSc4+c7gAymjsBN+tiOvH0q84IaqpvnnyBNb1lnobxxUpQE/fkd5XTxl96//+pXrZNEgh1KqPZlc3i8Q75ZUGSkwMpPsafUZs7kYjdE4ufg+7hZgyrz4eJOXA58++GeIimu5HuzRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215527; c=relaxed/simple;
	bh=x+5u1/62GjqPm4J+K/Qoybak4L71WQqcO1bP9T4XrmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUk6lb3PqNlCf4rpHdKYXk0L1CEpqrftRVKiPiXYg+OFeo/TA/zFZci56mmSEYM3mcQPN4tf6di2IIa+oMnUYwawXzsJfL4plkFgMta+XsF5gQLsWjT4IRBsH6k1Jg2ok5A3VcZn5X785w4qHQ0ReqP9wmBbZX1BWt/BatnKlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=djXBH0S0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9d54575cso3956322b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707215525; x=1707820325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUGh1m4vEJfx4LYw/dq2uJg2ss+SX8Rk3NEV+3Psk0A=;
        b=djXBH0S0pSbWcmvBMLLDo26slhDlN+la84ij+540gktO+u1mKlvmIxLIRq0aRUqcD/
         E4zdTe4d3rYnhR73xqEA3P30nYas6dOQqUYWG9hjkoINUHAXUUgaQMJTXJQgjrQ92dXn
         aUN86AJHqxheFvGA/CBskJMhWG8CLj4UUv1dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215525; x=1707820325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUGh1m4vEJfx4LYw/dq2uJg2ss+SX8Rk3NEV+3Psk0A=;
        b=oIEvlarqyfqZGH/2pTBGuMR/zpYfSZiF8SisD69Vb/7cfSwHnTuo4J1RheJ62w8f6G
         S8H3j0Nx42tu+UAahSksJT5Oyghk+7vM/qxQYBZ0QFRuIhWPr2sjRwbQPBgbuC0VF9Fr
         O3yDbEmRa7Lwor+j2kXjPO0W/MY0BNNHgEEIOVnsipmO/0is+CM2a+Vz0hQGbNRUhXiA
         8aXLFuyJSbdSKMXTEcHZpB8dhmfaN6I3MKWs72dnJWd/d9H320IABJka2A8JfIU0K2H5
         8Xkz5MCntAM+WrxWh4D+Axy+3IftvhGQ4LLuHQi5aPCt4/PT0xHrFUQadmxkWISEdGi/
         8v+g==
X-Gm-Message-State: AOJu0YzrBg7BpdS4qstEcA/F4lSlfwO3E4Xkk9y9D/mGWtjEqFaggTAh
	OlitHE2O2BKJ0eY5nEnUlwg+UsXEms5G4PwOdd1qaW6k5xCUo4t2JpMbYDgA6g==
X-Google-Smtp-Source: AGHT+IHWf1CRRfCMfTgNDBYZWCfmFcOq1KJp90qIv3BSmfa9pxgwclAKJSsfUsox1xUUQ0dXXRmVlw==
X-Received: by 2002:a05:6358:d3a9:b0:178:95b6:f87c with SMTP id mp41-20020a056358d3a900b0017895b6f87cmr2409328rwb.11.1707215525452;
        Tue, 06 Feb 2024 02:32:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV24em5IS4s7JAE218P07kqL46txEuIxTL1kfA1VPy8qdwJK4jFyTRhVXbBJzHV522IhtNl0eX1u8Vp40IbvitznQty3Vt+niOa12WFcuyyr38sxhXi0fDqs0CQd4LKwXGLJ3pBqGPCSl0oY0TiePi4o6TOCQv9A8qg1VzFxmt5Y7T5oy0KTgq/fIH/XVXusBRnZJ6XYbMs+vk0e+p9PXYJN2+BD0WPfJlO7+qopilM0F8wMVvyDlKPp5CBaPQspg5daaHNN5S4Ylu3SKkf7oTx5hhmlXXDuZw3mDby
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u18-20020a634552000000b005d34cf68664sm1706606pgk.25.2024.02.06.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:32:04 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] overflow: Introduce wrapping_inc() and wrapping_dec()
Date: Tue,  6 Feb 2024 02:31:56 -0800
Message-Id: <20240206103201.2013060-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206102354.make.081-kees@kernel.org>
References: <20240206102354.make.081-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4594; i=keescook@chromium.org;
 h=from:subject; bh=x+5u1/62GjqPm4J+K/Qoybak4L71WQqcO1bP9T4XrmI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwgqcvO4krnAoU+Rr+Gvl32kxOeOhCYatsR4T/
 haupH9B8XGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcIKnAAKCRCJcvTf3G3A
 JuzyEACzIv2MQscJjBejmNkVxm4bFcbzhhhchqsGibBbieQc/rFAhmbNdB5sYv5ORxjv5cMcYkv
 xX4V8HgwRYFjCugg8O/BdDK8A9YXckGXVFGoWII5El9rC5EBvCq0MaSoOiq7W3O41tgzQqGbMXO
 LrNQ+cexzghCSKOBoB12ID3s0e0/HmYiZjbfNSnxuB/+D9kz/kKia3bZFAhY0bs9CAvYoyyrkS+
 2ypLoduanCyex9vlEjfY/bs6voxRX71T/4w86Ji/sXZfMv+jqrQ0EvQt4TS7OGM4GL0kUMLkTvM
 iRiENAdMFViWlB4/gIkqqoHvTlE84wd8rk2AMtDhTzcE8uqkj6JbJyh7YI8vGE7fCuL0bCZnWOy
 FwP9xJ4vbqXoDEsnEfQass9Wj46X3F7Sgf0ZdJGzdI+93JcSugQYngR+mGhpQy2KAmWJ6Mu63ss
 eXdgU/m4mHQ/5Jep4finoVlIxZ7AngYMVCKDcwTWTQSwohaB0swTi/zimad6hh4RShHeod7WW+u
 eiI6tp3yYylhzSsd/HMvtmOoJI3E0bUPP18O3hkPQOXYX7T95xJFfQUsJxgHduTqpBxwfM45hn3
 wvjPp9RnN4mcXbRNJqtcsHrctbCdua0Ern6y8PPNN6rzGjrdAyNluVQplQwaw9jKpuDwGI5TCLF BbLS6RazbsEbM7w==
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
index 429c4d61a940..8ab68350f976 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -82,6 +82,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
@@ -113,6 +129,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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


