Return-Path: <linux-kernel+bounces-136625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BE89D642
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C801F224CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6D1272C4;
	Tue,  9 Apr 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQtTZ1jY"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293482865
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657115; cv=none; b=ew6C4/NiOmra8mst3xeDWPc02DXMAKND9mXuZCs2+bUzxsWgryTZDU4/ocXg1euxEs+1F7aCapl1qHmJ805++9/enQ2M1jasbnqOsdPicmdlZqu267q8/Xu+m7AcndhzTREdszmnFSrH+ktJ18Htp7HubPiUGn4k2JD2zo9g0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657115; c=relaxed/simple;
	bh=ugA08uXqoEwEn8GuKopyp1EqHtpqnUKd/PxDao6nDlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj2WhN7Esqah4F8kNR2xNCtzos1xw3IQDKEXrLlqXY+ZxVU/EsSthNWZtSWyV+afepLekc9JJSF2B9zw0aEHCOaT8Y2sa0nce7G9BFYSjWeQnTNHHxwq/4I9pPq/hWxXvRO8ejYdcZiSV4eNh47xQj24SFpOfRHTmAr3LZnjtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQtTZ1jY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d82713f473so92622761fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657112; x=1713261912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hew6IrPXucrn4SI3v5T6ztETy+bvxdIyXI1Ro/bitzY=;
        b=QQtTZ1jYd3Dx0XGXbriuS03LiCZi47ythiq4Sda7uHQQ5nrCnXNqyn5vlL2xKn/Hx7
         sm7E4qXj68SyCw12ote1EO9wt5Y0pQkJqbmx1wjSXKO8ChpQ38ovgMa4wL0FmBJ1gtJN
         HaXh04uiq31kCmPwRAV4UQZAd5BvEE03PNEzCgUtznmHedVtbypZPSdtRGElLMa+CK1r
         uX4n88NnUg3iIRUigN10ZwpLGCZYU+5rELi7WupWR3Z7bglnojlUkaLSv8BWgCzOzCdH
         sBYyNrlVnG+Aioy7icIYD0HHPeGJPshqsGzB6/PCcPw2gwNseJnNa7VRejYmLc0s5pux
         OIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657112; x=1713261912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hew6IrPXucrn4SI3v5T6ztETy+bvxdIyXI1Ro/bitzY=;
        b=bTOzL/wGfZaBUQBv722+GhpY8IIaPa8Shws51Gvw4IpugKRqhC919T5V0wsLichnHK
         UEhjsEb+1QZyDtUUwkiFISgqMDCs0XizxtBkreve5EDM+sc3ThXWYPUpePVZuPpgtV9d
         XYsgYCQsDEnneP3TAVmZP+Mb5jLYRJygMxzqgT2Fe29zg8AFodg8bEzBx8kbkEZsRsBf
         on7krtVr3/A7POEiQBl5rRfJDP31XNycLWwLKaAMUkl3Yf+M8JodZUqXw0CX5wQAYcUj
         REiyDkczN+NQxg3KKYX1t56unjZTV+a82j10fK31L2PqDVA7uWyz8MpJ30Ux74q5ImBW
         Q6uw==
X-Forwarded-Encrypted: i=1; AJvYcCWJRXKYn95SzoVZmSiaA7Rdga2jvmlhg4xRYEkPz0ZP7+5oDHrBveRVKz0TtTvxn22UgjyQ2wD8QBBROes//zTMTS20h1LRsb9cxdqh
X-Gm-Message-State: AOJu0YyTntkoK2KtXtukTw+2fit0H5e9FFsxABdByoT5eZGusvJmGrX7
	2eQ28TvUlkbNSNr0mRK2csNtWsuzZF60E+6+DQjSFi4SoNlShNVn
X-Google-Smtp-Source: AGHT+IF/CiW5guZCr3itYqmfESeOATzJU7bpKqf1oFcMCzYNzUgGvRPQ6FqKK7h0BUTghiHIvY5nKg==
X-Received: by 2002:a2e:2e11:0:b0:2d4:5370:5e8a with SMTP id u17-20020a2e2e11000000b002d453705e8amr9333404lju.22.1712657111401;
        Tue, 09 Apr 2024 03:05:11 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:10 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/6] locking/atomic/x86: Use READ_ONCE before atomic{,64}_try_cmpxchg loops
Date: Tue,  9 Apr 2024 12:03:54 +0200
Message-ID: <20240409100503.274629-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409100503.274629-1-ubizjak@gmail.com>
References: <20240409100503.274629-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value preload before the cmpxchg loop does not need to be atomic,
but should use READ_ONCE to prevent compiler from merging, refetching
or reordering the read.

This patch unifies arch_atomic{,64}_{,fetch}_{and,or,xor}() macros
between x86_32 and x86_64 targets.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      |  8 ++++----
 arch/x86/include/asm/atomic64_64.h | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55a55ec04350..b166da21ee98 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -20,7 +20,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
 	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
 	 * it's non-inlined function that increases binary size and stack usage.
 	 */
-	return __READ_ONCE((v)->counter);
+	return __READ_ONCE(v->counter);
 }
 
 static __always_inline void arch_atomic_set(atomic_t *v, int i)
@@ -132,7 +132,7 @@ static __always_inline void arch_atomic_and(int i, atomic_t *v)
 
 static __always_inline int arch_atomic_fetch_and(int i, atomic_t *v)
 {
-	int val = arch_atomic_read(v);
+	int val = __READ_ONCE(v->counter);
 
 	do { } while (!arch_atomic_try_cmpxchg(v, &val, val & i));
 
@@ -150,7 +150,7 @@ static __always_inline void arch_atomic_or(int i, atomic_t *v)
 
 static __always_inline int arch_atomic_fetch_or(int i, atomic_t *v)
 {
-	int val = arch_atomic_read(v);
+	int val = __READ_ONCE(v->counter);
 
 	do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
 
@@ -168,7 +168,7 @@ static __always_inline void arch_atomic_xor(int i, atomic_t *v)
 
 static __always_inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 {
-	int val = arch_atomic_read(v);
+	int val = __READ_ONCE(v->counter);
 
 	do { } while (!arch_atomic_try_cmpxchg(v, &val, val ^ i));
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 3165c0feedf7..e7b12a48fecb 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -12,7 +12,7 @@
 
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
-	return __READ_ONCE((v)->counter);
+	return __READ_ONCE(v->counter);
 }
 
 static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
@@ -126,10 +126,10 @@ static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 
 static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	s64 val = arch_atomic64_read(v);
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 
-	do {
-	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 	return val;
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
@@ -144,10 +144,10 @@ static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 
 static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	s64 val = arch_atomic64_read(v);
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 
-	do {
-	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 	return val;
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
@@ -162,10 +162,10 @@ static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 
 static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	s64 val = arch_atomic64_read(v);
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 
-	do {
-	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 	return val;
 }
 #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
-- 
2.44.0


