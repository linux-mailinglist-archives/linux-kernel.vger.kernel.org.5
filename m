Return-Path: <linux-kernel+bounces-65894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAE85536E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A301C24269
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DDA13DBB3;
	Wed, 14 Feb 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XDakyI+4"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F113B7A8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939970; cv=none; b=a46TO+Z5DLzPbLDY2VuxJN7RVgj1k++LcUGVb2QP2Q4CYq3aiz6wS5An4VvPMnKcMvb2qGUB+byQFoNj1ELn7Itu1f1nV4+rGHQIX3OpCw9EaqI+6tr2YKi9g+dOqHTc5rJeY8/Y216E8PzsB9Xix/hXzF0haHfVoSfWjpgGkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939970; c=relaxed/simple;
	bh=YgOkKOXlR0ASzxusUpx89CgykDXZ1IYPis0fKK7VnqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlXpq0LXRZXZtP2eGqjByv7XlLetD9dAf7esydwCwaTVI8HGeoiLYOM7cAe1TpJ3X/lLutMcwXwK1omtzOZGVoi/mxs8LjpDFDapLMQ0JtiS/1g7ULomrYkr4DH9gdKz23CiD8cTJfW0LSkzXsI+/asbKp86jYxrBm1ZKwndcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XDakyI+4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so120425a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939968; x=1708544768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tejg3N9iGCbYi0dxTPU89TKxpvu16yaRkXNuqXs5Q5E=;
        b=XDakyI+4vFORss2kyaqQ69FpmerJ42DgShcxxpOk83uc8eVjxHO4u/RY91+sX+icXk
         V+D8nj2HQ0DcT3saUrXWIo7luJMeOBhgfSForzI1lw8MUKpDxyO6CASe3Z/mMltKX9m5
         5/ZBgJZm/qVu2HVoChhVChIFcfUNYPIfTMGd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939968; x=1708544768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tejg3N9iGCbYi0dxTPU89TKxpvu16yaRkXNuqXs5Q5E=;
        b=KhYjZrGE/JLyxIIEWkZ0tCqv4s6elamDOQFu8z1ZKFsCzRCn04xmPDmF+FLer0jipa
         8pWMzKmfRkxIeTLzfJjFyhA5L2pzWqiTzIaTQSxm/AbzB5baqXy/J2LfgirQZy+ctgtu
         nxtMacwsIEh0jSXdHukrzyzYZQ9xRHybe9sirse7blayDrr5JBsSPMb2OJ0Xkbz8N7sD
         YyB7bm1mDF2reoSy7Ri6EbuPnniseGzDKphgWiaH+2xyl+mM5K8KsXd8BxqCCEzXIKgY
         hPlv1lE5DSlFwHa1eu8Ia3v5Sb11Is9FjCPJnQGGGM8zAXV3NolSYzrhAnDAvwo3itJT
         84NA==
X-Forwarded-Encrypted: i=1; AJvYcCXdyQGUX4VuNPUKkJM5/yENjK1ZQOjamjApPErfxY+DelK8c6hAj+Jt/SI1gb2rZaEt1VJgq7bLtdTe8WTloMkhFBJcsEH7PVxZH+Xb
X-Gm-Message-State: AOJu0Ywdu4KKBHNHLQupiUDkhVlw7z21Jy4/BXBmzkuM764r3JJ9RfAI
	avfsaop2IRXDK3fogKvESmO8qpYlyyADDEnPmp/LkWWbHEMghbx0lpKdtxbw5Q==
X-Google-Smtp-Source: AGHT+IGhX+m1ysItgafdEVPrg16Fh4vAL5NZ3KeCRJwEzenqYmwBBssH8GTXTGwURsKGEbhU/+Ma4Q==
X-Received: by 2002:a05:6a21:2d04:b0:19e:c9ad:68be with SMTP id tw4-20020a056a212d0400b0019ec9ad68bemr4640153pzb.43.1707939967996;
        Wed, 14 Feb 2024 11:46:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXk4JjOdU3VaIljHajvjjDeaBTKLY9UcT+t21yeudA4/9s/0YwdgSI8JHPAJiTYyGDsOwJ2XOI7F4hOyjGHcV5YPxUsqszMqx6eEnlJqHvBMu2bVLm8nuSsRrbBznJqROl9bz2TRurZ1ZcoMlfOT78ma7J0Dy7AsHm9meREoRMztnUCx0pjlDsV00uP6qYKM16ygGJ1cS/K7XIYLr5PUO3Ln1+ZSAFb+FhR+IOEDHSpLUfVPKxa566b6ivDGVqGaymtl9mlbuaUMNDuSg5jemxIzhRKyGgiaLVUt/2+xCo//nB3L8j4Cath6f7KrLbm22AjfzTcKocAJA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u23-20020a63b557000000b005cfb6e7b0c7sm4688648pgo.39.2024.02.14.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
Date: Wed, 14 Feb 2024 11:46:02 -0800
Message-Id: <20240214194605.602505-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214194432.makes.837-kees@kernel.org>
References: <20240214194432.makes.837-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5699; i=keescook@chromium.org;
 h=from:subject; bh=YgOkKOXlR0ASzxusUpx89CgykDXZ1IYPis0fKK7VnqI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzRh75R0GQGPPZ3V/orJDK5K3S77Rr4Gn5Trr5
 BIOzQyMkSqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc0YewAKCRCJcvTf3G3A
 JmR6D/47QsZE4N+Np5gKhL0eBIwumGpqxvTd6vDXmG0nJVHUr6MjBIsXaVPK8xgyC/CBJkqHnu4
 /3CHWgIQetK5nnziOHmusOYYYjzqjJ7xOwoZkv88oXIiHRBhoAJd4YGLeA4q2Xcr5R7cNm57+nI
 g7r7mIiy6m9H5c8409RHq8KglRXp1Fl/+DxfSSvPBmXPOciQvunRQLX7hTDqWYdoBtf7yMVic8r
 w3pVGGvmp1kXhNrzadU8VmDX/kI8nXu+oIuIklW6NhWUYUszF/AYva+k1jXU55cDxlpXBcWa/lP
 +prkhaCEwcTFYk8GubRxedPFKOf9Kh/LVKoQAJCLe7wForOeNv4FGhfj6bHQHrT1BslZK69u3H4
 dTDMEbvct38Yf0Y4jhHoec64KVzGJ0dW1YMmneNkMWoEh5N6a1d6vuQRdJ3FDiDQAtzY+jMf1yE
 9ICNjGGU2xplXOsF/qa52hktVd2fCKxQtOZWY697Pv8tzEnkzl6rIqdk/zl7UtNitVg7NJFp1dQ
 VNTe5XOaY30gijj3BGqF94elswFSPP01/Uqw1hSUVJCGoo8krNGAWp4ek1+MN0Xr4NvOwvGrFB4
 TGJr+ZryV3TfTElN0qb4RVawAVOSy7Jflpogzin+/kO4/HTiDnZyBkO1Xh17AYFrH7v/d42jBrl 8juwtUGbB4vwKdQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide helpers that will perform wrapping addition, subtraction, or
multiplication without tripping the arithmetic wrap-around sanitizers. The
first argument is the type under which the wrap-around should happen
with. In other words, these two calls will get very different results:

	wrapping_mul(int, 50, 50) == 2500
	wrapping_mul(u8,  50, 50) ==  196

Add to the selftests to validate behavior and lack of side-effects.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/overflow.h | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 24 ++++++++++++++++----
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index ad64d810c8aa..d3ff8e2bec29 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -65,6 +65,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
@@ -79,6 +95,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
@@ -93,6 +125,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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


