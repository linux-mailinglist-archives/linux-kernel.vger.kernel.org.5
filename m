Return-Path: <linux-kernel+bounces-65893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24B85536D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8C31C2224E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4613DBA3;
	Wed, 14 Feb 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CL30+4UO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055A13B7B4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939969; cv=none; b=XHMyjx7p3hpuv2/5hOW1htTQ2EuCMuLayHKhL68NWC5nGo24A9Bj+nG6rlsoaJhIm1BoYqHLwwVXPxR3y+WeWWnufEZcyRRlxCkCMdHXwHAjWHAtuS2U23eB+f6V3cJxNgQvCQ3eInxxwNnT88/Xda0Z+VmNQJvggUS7zHMTb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939969; c=relaxed/simple;
	bh=WpCfOJKQI2tEPzWqXq2AwhFgSH1gItVpb6dbVuRrWwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HnMK4TseUjqk0RcVum7+Cg5N8kXSiMH28LcuuRUMYbdWb2dQmDDHUKhK/chrIILzzi5J3gknGNxCYOnXAieKlEJLJJbWF1PfZt4Iwx6AtrQ3P53pXckP4ieqPkCtP+ZlsYojsDfL4Ooz+liTk+Em/Pz9azCWyyYSnLtqNtgXXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CL30+4UO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso111820b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939966; x=1708544766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bry1Iv4OwAWhs4o2wnnICjHcqHEe/LGfZjQ3JQDyLI0=;
        b=CL30+4UONMDUamoihrAc4I7FEMnqZdRaE1YwlyxOApICXEg5hu18WE/JlOo7dLry35
         amPeNtAkGSJ1SAmXCQUDnLxuGyJcZjy6SAwU/BDd8usqYQnHe+HWl946fwF+1yL/jRH9
         XYDy2ayocLgcXsz6e/58BG0+ymgRJJzfWwPdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939966; x=1708544766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bry1Iv4OwAWhs4o2wnnICjHcqHEe/LGfZjQ3JQDyLI0=;
        b=ZObnbFGu1SWsV6Xb/hI+3DL5cikJj6WpLqx0WGybU3lGTpjsam65cC9uMJFBiWp48y
         MIECAp8hMH5aAuGKqw3dXmGMBMRt0aFACoAzx627Uw468GSAz3BxFWpfPFns3Qxber4P
         w4j5tgv26iuRWs0SE9w60Xk873yl4Wo5EB1UryYhRwVokndYlXP3EotKWJ8jQ68J5t+p
         GqQmTNxJEMXLZugY5gQAdqVfDd/rVNuzdHNFF/5TRtsrD5yVwnia7hegDe518hwcB4tr
         04RgYvXSF0ZjFxfM26mUGTiyeFTUS58hgTY5jFPi4EXWV3u8lLTLzb15Ougnfqchsut+
         YOHg==
X-Forwarded-Encrypted: i=1; AJvYcCUIGVoBsY0B1ogWG/0HbPEh0iJ32yTIEg49iMraDCdiYA1OLDkfbpX5614LVhQ4VfMOI1h8h0mTZ1DFNQLVsY5WSYzIq8TXqangseuk
X-Gm-Message-State: AOJu0YwZ269CWqveg5n2OiSQbV4Xwki5AGFXLpLx5GIhDZ0e4umTF0iZ
	u1d86nDSOppyqjJxXtBT/dRMg7Tuz3KvQAj03K1J3VtvvCxRhvq+xi6sn4lz2Q==
X-Google-Smtp-Source: AGHT+IH5Sw/HT0OyVXLBg/e8n9jUkdU4yFY3S1cXX9otdPn05DcvG2jn96yrMk2U7cZPMe4B36fr4A==
X-Received: by 2002:a05:6a00:4b85:b0:6e0:47b9:b727 with SMTP id ks5-20020a056a004b8500b006e047b9b727mr3372804pfb.30.1707939966471;
        Wed, 14 Feb 2024 11:46:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7Cwoijsp6dJM+Ekva4xtJ7poFQrc+CxsLCm0rozgF+ThOJCdpm3+MlFGTlkTSbTvAXQzO+vbs7yYuL+AF4R7WXy0Jj2xceLs+3esoKAvzv7epf+Iajsi5GfEz2f/6bDW5QSOUlMbXIxHjfnDRf9y8eb1xRHMVcAQLFXUZyXl6X/oQOSEC2tK9beZdNDpClZBEfI0MUNear1S6IPJ+s2yrz5b3XfoN4RBlh85EoL7tcIdWQRV88jI+DQ6daYac+w2yUHK4sE0Tc9sYc5q5ipsk2fys9Q24ygGmhy6JUyAZDMezJliIaNXs5fU6mUAtbaEbYZKGBFcW4A==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g15-20020aa79dcf000000b006e09e975596sm9229771pfq.38.2024.02.14.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:46:05 -0800 (PST)
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
Subject: [PATCH v7 3/3] overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()
Date: Wed, 14 Feb 2024 11:46:03 -0800
Message-Id: <20240214194605.602505-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214194432.makes.837-kees@kernel.org>
References: <20240214194432.makes.837-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4684; i=keescook@chromium.org;
 h=from:subject; bh=WpCfOJKQI2tEPzWqXq2AwhFgSH1gItVpb6dbVuRrWwo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzRh7+CaMXERKbG/TjLkrLLxvw47pmVByFgyp2
 54s77/hIuKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc0YewAKCRCJcvTf3G3A
 JsTHD/9V5W7uSsNqclqE+WRbQgUNPUGr2Z0aTYhid2E0NBqKt6TgpdzgEwYnkz9QuNi5PtqbfeT
 3KTzVu2TztVAD4MhsWpK2R/8I/5oxcFJ4EmlZyWwT9dBWDK+zSRK/cEYDvgORPHFFUkL+6JLKmx
 IFd5SgbuvI+F9E0kHGN2iReicG9HHlGEfZSaEKLx2kyFfpupG9h+M+7kTxuH1X5ir78pyd9W6Tt
 J2UBp+xPAMuTNMBLRLJWuZHq+TvGU1Kz/JK5zEx0fbqz8cALwhRivwYPFrDN0Y2iEzqLgV/MpjC
 SHjYSsrc5iWCXjP0EemrzTB5cIGSeLBraofYV92DRO/p2mDB9MMmb7qPEfhVmUr+8f3th+vMAAc
 pAA0F9PgA6bqNHULJ2zElabbp5GuOulS5jBINn/wKJzioxU4878geM1q2k8PTPSUepBcZFd3UPY
 fbKEUR6FYlggQ/7iP6jF3xBAO1vq7KoNWQNYFjHeK54ugrWSJSFJUdV9YPPw4hQsdv9mub8VJqy
 Hft7QxCQWfSYhP67h/+sl5pFlyz55GXeBD61nGAQgwb+rS8SWO+zDWbxGGjYToUvmBu/lRs/TDS
 k1/esybUWsrTq1oqfi/k8Cy6C08yc9t8PKr+FCbSmcTCPhLiMe4Z/UIEQxMPB+w0u4eS812ZPDy k7VJ5j6GMhaPMJw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This allows replacements of the idioms "var += offset" and "var -=
offset" with the wrapping_assign_add() and wrapping_assign_sub() helpers
respectively. They will avoid wrap-around sanitizer instrumentation.

Add to the selftests to validate behavior and lack of side-effects.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marco Elver <elver@google.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index d3ff8e2bec29..dede374832c9 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -81,6 +81,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * wrapping_assign_add() - Intentionally perform a wrapping increment assignment
+ * @var: variable to be incremented
+ * @offset: amount to add
+ *
+ * Increments @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_assign_add(var, offset)				\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_add(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -111,6 +127,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		__val;						\
 	})
 
+/**
+ * wrapping_assign_sub() - Intentionally perform a wrapping decrement assign
+ * @var: variable to be decremented
+ * @offset: amount to subtract
+ *
+ * Decrements @var by @offset with wrap-around. Returns the resulting
+ * value of @var. Will not trip any wrap-around sanitizers.
+ *
+ * Returns the new value of @var.
+ */
+#define wrapping_assign_sub(var, offset)				\
+	({								\
+		typeof(var) *__ptr = &(var);				\
+		*__ptr = wrapping_sub(typeof(var), *__ptr, offset);	\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index d3fdb906d3fe..65e8a72a83bf 100644
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
+	/* wrapping_assign_{add,sub}() */				\
+	check_self_op(fmt, assign_add, +=, p->a, p->b);			\
+	check_self_op(fmt, assign_add, +=, p->b, p->a);			\
+	check_self_op(fmt, assign_sub, -=, p->a, p->b);			\
 }									\
 									\
 static void n ## _overflow_test(struct kunit *test) {			\
-- 
2.34.1


