Return-Path: <linux-kernel+bounces-45366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F01842F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DC5281E44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00BA78B71;
	Tue, 30 Jan 2024 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KqbwGoet"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF37D3FE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706652380; cv=none; b=CMF7/Pm2iL6xRQfAr+L7reRfey85pctBo42E8aArcXYtCNZ7vti0FdQudYa+J2F+zR9eIM5hRla2WgChdoICErFz1+4xGSMC7KRNz//zA27Nm8zmS29SkcDbFqFpfGxhGkBQKPt7DWuYw3HLV7ZVmCH8JBDQJUSQA/XnUIcl640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706652380; c=relaxed/simple;
	bh=Lsn3+N+1f8l6lRmtTSj3tYRTIPnbB1C3Ti+RJg8Mz0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXf0EgxDxBmTcXtt12t0eIiQbmK5ewJfHE4Dbj6d9w60IqNco9z3W+JGB0SAu+6mD73gQ0p0MwHssjpGLLRaF7ufLA9yWubeWrYUCxlbc5JHS/jlb19PD/b34hvCiENYcMe0vq4c/fevikjyyBNLTYDPdj1CzXcKuVmIZW6oHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KqbwGoet; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7393de183so22408915ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706652377; x=1707257177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcwNGWRjXs5hTgiaUtk2cifYdvfoOCz6Y06w4rb2tvo=;
        b=KqbwGoet4mGX7QMurDGZxHWw1ezcxtwReh/5pmt0luh4xdsvA0Nt9VdaZsdwuJaK1h
         B9PuKq++5wz7aGlXCSsYO3reBhzLYNMQAU78r9BNLWSb6zWhAuGEmrCtc1gCBuxqyRTL
         OyL6R0CRcF6PlBR20Kvw22n5TL02vNRLE7c/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706652377; x=1707257177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcwNGWRjXs5hTgiaUtk2cifYdvfoOCz6Y06w4rb2tvo=;
        b=XQYKMMjiDnc9HWm/NGLIlvKLAxnYuz/MbcxUb4yA1Le+cqhHIEwkOvlYH/YuzqjO8p
         V65BUxRGc9d5TIyjjwa6RKAMEnW/gbYKgACr/HNLil9wmdTXpRHIZ3Z8vUooS8k4SiNs
         JjQzQRtY/8Hm3IulsSkoSQ2dqOJpXRkvvXdVvGlk9r6ZB67AoxsoTyQsWM1HXO5/wU8k
         hU9tUpTpdt3tTjflvyI/QhmGb0yF0UCDXQVq9LN+kmkNgz0RITctwkU4THA1T/OtV6/3
         Z6pNXgYYTD2lAVDMpNYbjQAGwNa2Hl3lHiVMBy2MJAwMFnNu0p5o4Bi6r09nWjD0dwgs
         G6wQ==
X-Gm-Message-State: AOJu0YxBX96ljO7RVAZzamOE8LVY4WHKRmFNUuMGp7OcNllTw2JFmJRy
	oWxUQ4qBbF4R6UKIBjBhglQtHEeQx00gTyHLXaX44c8lTo2vl3tVVpyiAe2ZcQ==
X-Google-Smtp-Source: AGHT+IFwGslklds9lr8c1QxuX+bIJ7/vmMB9zzJ44D/A0uB+OZi/8NBit+SgfyxTYtzD00MndD/IHg==
X-Received: by 2002:a17:902:eb8a:b0:1d9:11dd:1443 with SMTP id q10-20020a170902eb8a00b001d911dd1443mr2343791plg.56.1706652377271;
        Tue, 30 Jan 2024 14:06:17 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090311c200b001d919be90fdsm1021511plh.42.2024.01.30.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 14:06:14 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
Subject: [PATCH v2 4/5] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
Date: Tue, 30 Jan 2024 14:06:09 -0800
Message-Id: <20240130220614.1154497-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130220218.it.154-kees@kernel.org>
References: <20240130220218.it.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4387; i=keescook@chromium.org;
 h=from:subject; bh=Lsn3+N+1f8l6lRmtTSj3tYRTIPnbB1C3Ti+RJg8Mz0E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluXLSe19O6Hvhh0igqhBhzvh/k2nMh67arN8UO
 ViDdP3DCpCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbly0gAKCRCJcvTf3G3A
 Jl6SD/949IhkriFg68ZDIGgVjR+vt3zRnyJL3kmoeJ5EwTrfegqnwpEcSBAHuYt9EE5dphltzfG
 Xxju7AsQMKZy9Qi7who7pbzxSfOcx7AvjfSOpZrA2QUZfIvHtsKfkwel72z3/YEFmiVslEcd0LA
 h/w20GBNyE/QZD5xaEUGyY74qMuxV9rzeUFzaRQZtbEBuN578gGtjt+solHfAGj878JE5tjtfCa
 fYizb2R+/TIJ8c5txcNgiUThUvmlpYdpAZeugD3hdi3v/tCmIX+FZcDcYU/6bvj95r2WYS0MTh3
 IHO63Tg8P7ySWnC6su/nGSuHYf2+6rHo/ZEit3wIkCNOXJ5NE/iAcM1UAAEfOtGyBELr9cIMHiW
 TSwh4cIN51YZTYFVwEpKwMxw0qi1pT7D70pgJRnDyA3VEwT09RzE5AyIfmJt0LSixzpdMyr2ro4
 TuevDNqjiIZSSIe6jduIvJmt5AHiHl11YTXK92CQrWvCcGUXwEPVyCKiFxL1Sz8EjAmvEbQigE0
 hIwsJEG09BwJNh6CaSQVMi+73ihg21dBrOyFNkNzrtlnWRf4UkoPTtg6yohpWwxhQTh2hhRRrFp
 KQ7zqDMuA13212l6WJ7ogVbceJxQ4taZI0ZiW2ogyZFE1oij+Dv94p0qVlwdVW8oVZQ1lxdl7wu Wnpi70NpXkvuPUQ==
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
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
 lib/overflow_kunit.c     | 11 ++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 3c46c648d2e8..c9139f88578b 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -120,6 +120,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 		check_add_overflow(var, offset, &__result);	\
 	}))
 
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
@@ -133,6 +151,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
@@ -146,6 +182,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
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
index 2d106e880956..319f950872bd 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -273,6 +273,17 @@ DEFINE_TEST_ARRAY(s64) = {
 	/* Check for internal macro side-effects. */			\
 	_of = check_ ## op ## _overflow(_a_orig++, _b_orig++, &_r);	\
 	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
+	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
+									\
+	_r = op ## _wrap(t, a, b);					\
+	KUNIT_EXPECT_TRUE_MSG(test, _r == r,				\
+		"expected "fmt" "sym" "fmt" == "fmt", got "fmt" (type %s)\n", \
+		a, b, r, _r, #t);					\
+	/* Check for internal macro side-effects. */			\
+	_a_orig = a;							\
+	_b_orig = b;							\
+	_r = op ## _wrap(t, _a_orig++, _b_orig++);			\
+	KUNIT_EXPECT_TRUE_MSG(test, _a_orig == _a_bump, "Unexpected " #op " macro side-effect!\n"); \
 	KUNIT_EXPECT_TRUE_MSG(test, _b_orig == _b_bump, "Unexpected " #op " macro side-effect!\n"); \
 } while (0)
 
-- 
2.34.1


