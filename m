Return-Path: <linux-kernel+bounces-52269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4506849617
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D028111B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394612B71;
	Mon,  5 Feb 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ywzu59O5"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5CC11CAD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124358; cv=none; b=uQ+3rqxfasCFu+WPUunKZx3NwgZEIcPCFBhhwzEfpHSmzh+2ao5+dcbqPKhKIkpjVvClPKXQdSbRpPxEYcHB+4sCAyda6YwmaX2V1bbIOYo5nbb/1TzcHm6fIe5kdWd7uw1FrMD+Wku7mvcccP7kpCnOFJyjmrWOM+HNzK7H4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124358; c=relaxed/simple;
	bh=Uu4zdTW2mKt9ckOwQpBzTQVr+FjHnYW3s+ZeUJaV4TY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Guj/0atXYuUi2DiwmvCIFyUv1Ag1GuqT1KeE1xGRLYQ8Xa9yxLzvgwFZDPwJgkOK0xE5kgmb0eipqjWghSmQMYitgpDnrXCDg9yQ6Mak6rfqHZYwG8i7khw2SxocF5WdSsdLIn8x7HsxM4SS6ia2bmxowkf+h8gwQaQdjfl9fl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ywzu59O5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-296851164b0so785229a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707124355; x=1707729155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl5P1mUqQmiBnyeDfQoNPHfTfxufsKI5ULtAGp1CR1s=;
        b=Ywzu59O5CKzGwQtjm4so8UlScBmDqGPGtns88AYLxwvz3+tO1LqCQjuvt8sB8Vdy3C
         ZgX0nC74gjOUgf3G3+ZWg6VEK7miyJ3ZOFg897bl0A162Vs12bQKGxxK0hQqbB0ZOdtJ
         rj2mOB80M69GFoX1nw2Xu/ow8sNZNTBFhNI48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124355; x=1707729155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rl5P1mUqQmiBnyeDfQoNPHfTfxufsKI5ULtAGp1CR1s=;
        b=fYwzGbfg98aWzy0LYBHEtUR5vkMHVQwldKz9qN4Xyopetbg3/LxOWup16QmA3e3vb5
         Zv7xOwM7R9GkS65cCvVVvxE0eUM24srimYqzhoDB0rxqSQ8P+DVcAlHbSmTvNwpmhXZ0
         djW4M//SM+b5QQz4r5MiGqDcw54qHRKj75tWgw3oQLdW7QZsc/y3TqUHR05Amabo6Fh9
         gBzwug9OZo6zIAoMfr56bmDd+BFDMUmNX9w/Oug3DqLSEePvSSUkqt3vGjtVOZ40u1rF
         u3/5McYBEFr11GEx0fO0buADDCHc4caAiVCjHPQ9DFUrKGdgbbDYE5Lm8MP4GwP7Sg3G
         m7YA==
X-Gm-Message-State: AOJu0YxQQLJ6Yr1TLcV4TbrCFh3PvS6iEz4LyX6tNhcrv38nICbzZBm/
	sfNfYS40rAC0NQPRs6vPYBeObf6vS+dGDIaODeFd3uoWO8zwl8NPwJ5vyl9kzg==
X-Google-Smtp-Source: AGHT+IFeIEBT39uHqjMQhJ+Ehe63S+Vs/ArHSmZDmdQ8X3HQivOsRo9BWqXSeWvsbNhjzSSicdzOBg==
X-Received: by 2002:a17:90a:98f:b0:296:15e7:8f33 with SMTP id 15-20020a17090a098f00b0029615e78f33mr8428122pjo.3.1707124355024;
        Mon, 05 Feb 2024 01:12:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqhjiuDjmMVHPN18ECjla0RfIop9XXvPwLkP05FFQDlQSBVyHu5Ig536nrszLRwze/Tpv7vsalA1VsCe4fw9jVqp7vHWdd8gOv8HO8PXlGG5UuRnKBgexuC99PHZRg10AonuBb0etPAIkVI7mHRpELptKNgZrFGd1nsxffNtb19nKcD4+KLl5B1bNDNu4TqnjwcBDrvODLT3+l7EI9mSUvr8/s9yQz8w==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id si3-20020a17090b528300b00296aa266ffesm752841pjb.31.2024.02.05.01.12.34
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
Subject: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
Date: Mon,  5 Feb 2024 01:12:30 -0800
Message-Id: <20240205091233.1357377-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205090854.make.507-kees@kernel.org>
References: <20240205090854.make.507-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5170; i=keescook@chromium.org;
 h=from:subject; bh=Uu4zdTW2mKt9ckOwQpBzTQVr+FjHnYW3s+ZeUJaV4TY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwKZ/Nm0pF6SN4QjXTBZaM3aZSgGNoHvNCa5I8
 5tIXu1d1suJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcCmfwAKCRCJcvTf3G3A
 JvkEEACy5IItnvaa4LrGBcbUWROutsPTmPl0aCSUlLm7QkszAaPgk12TTvyYNnF9DbNyDanPqm8
 1f2bs5RMLQvTkBhPHSjm6nUkym0GqENgSZ/NPbOcM1NOFNUd3BmBgfO44IKPNwl+NAvmMvoCMff
 cGHQrE+L0gH0SIyzX0Fdcv1kOzIna7iczsENiqouV4jeCND8tDeAv9pFkZVz8Qu1EKXTDsKL4t/
 YirmrsPi2zi2SveRKigdtLK3ODOodfT8qrzbAmnpVuYGNAtkblnKs+Tto188hCfV20DPglSgpqJ
 X91CCRbvL1zOW64YOvD/YfyQIc+Vvn6at78f3gFodIiryXasur+E17rejaN8uTRdECFuoeBH5Rt
 IfechYFxFtFanjMUdqS61scoRcsqMbUqr+1i87bUgFIgfRnO1rHgeiJVUd4gtPGkUlYeREzXlQS
 d1tjFFfxaiNz4/qMRSHqvawfXO4dcximqzeHZdh12jTEr+cIN0kfp48Lut5ryzSWNcijIYnqIkE
 R7Xnz5CPiewWtuw9bx2cLxv7WzaT4fAG8jAR3zV86WOJUt02F1p862j88YFvLVjQnbCq4+dEKlT
 e+9hhhb/CgLsXMqvsC2dHflQ5ueI3nwpIhT0hbTkVXhRgBR4Gae4H6aPPMOtwe/XvnKPtEAabxR 887o1pblbUVWiUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide helpers that will perform wrapping addition, subtraction, or
multiplication without tripping the arithmetic wrap-around sanitizers. The
first argument is the type under which the wrap-around should happen
with. In other words, these two calls will get very different results:

	mul_wrap(int, 50, 50) == 2500
	mul_wrap(u8,  50, 50) ==  196

Add to the selftests to validate behavior and lack of side-effects.

Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 23 ++++++++++++++---
 2 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 4e741ebb8005..9b8c05bdb788 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_add_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_add_overflow(a, b, d))
 
+/**
+ * add_wrap() - Intentionally perform a wrapping addition
+ * @type: type for result of calculation
+ * @a: first addend
+ * @b: second addend
+ *
+ * Return the potentially wrapped-around addition without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define add_wrap(type, a, b)				\
+	({						\
+		type __val;				\
+		if (check_add_overflow(a, b, &__val)) {	\
+			/* do nothing */		\
+		}					\
+		__val;					\
+	})
+
 /**
  * check_sub_overflow() - Calculate subtraction with overflow checking
  * @a: minuend; value to subtract from
@@ -77,6 +95,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_sub_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_sub_overflow(a, b, d))
 
+/**
+ * sub_wrap() - Intentionally perform a wrapping subtraction
+ * @type: type for result of calculation
+ * @a: minuend; value to subtract from
+ * @b: subtrahend; value to subtract from @a
+ *
+ * Return the potentially wrapped-around subtraction without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define sub_wrap(type, a, b)				\
+	({						\
+		type __val;				\
+		if (check_sub_overflow(a, b, &__val)) {	\
+			/* do nothing */		\
+		}					\
+		__val;					\
+	})
+
 /**
  * check_mul_overflow() - Calculate multiplication with overflow checking
  * @a: first factor
@@ -90,6 +126,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 #define check_mul_overflow(a, b, d)	\
 	__must_check_overflow(__builtin_mul_overflow(a, b, d))
 
+/**
+ * mul_wrap() - Intentionally perform a wrapping multiplication
+ * @type: type for result of calculation
+ * @a: first factor
+ * @b: second factor
+ *
+ * Return the potentially wrapped-around multiplication without
+ * tripping any wrap-around sanitizers that may be enabled.
+ */
+#define mul_wrap(type, a, b)				\
+	({						\
+		type __val;				\
+		if (check_mul_overflow(a, b, &__val)) {	\
+			/* do nothing */		\
+		}					\
+		__val;					\
+	})
+
 /**
  * check_shl_overflow() - Calculate a left-shifted value and check overflow
  * @a: Value to be shifted
diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index c527f6b75789..064dccd973ad 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -258,15 +258,30 @@ DEFINE_TEST_ARRAY(s64) = {
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
+	_r = op ## _wrap(t, a, b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
+		"expected wrap "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		a, b, r, _r, #t);					\
+	/* Check for internal macro side-effects. */			\
+	_a_orig = a;							\
+	_b_orig = b;							\
+	_r = op ## _wrap(t, _a_orig++, _b_orig++);			\
+	KUNIT_EXPECT_EQ_MSG(test, _a_orig, _a_bump,			\
+		"Unexpected wrap " #op " macro side-effect!\n");	\
+	KUNIT_EXPECT_EQ_MSG(test, _b_orig, _b_bump,			\
+		"Unexpected wrap " #op " macro side-effect!\n");	\
 } while (0)
 
 #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
-- 
2.34.1


