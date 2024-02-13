Return-Path: <linux-kernel+bounces-64216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D303853C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A4F1C24399
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4AE60B92;
	Tue, 13 Feb 2024 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcchW9NF"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47160B85
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855125; cv=none; b=jnAzixglRjRCxc4tTW66YGLLL19/9/AaHnUSfC2tpglHtNOgwqkk7zigeyVZTPk8YPsHOU/QMZNfTQM7urTwYtPuABFdpacjiYg+gPQ3B8sA7dZw6pVGCW08Cwbsails6h0DgAbauLTty6P/mH2hfSCF+WgYpEyxrMUQViI/9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855125; c=relaxed/simple;
	bh=+mPsQFxDyv4xoZGkFnZUtpvg7QmtVFk4n4nJyEwpkmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZzqpczwBrX/z5bq/RpxCZzwRx/LA/UbPVi00Tk6hSGSPWSktDSFHo+dm9fOPRoC3tQRcvVdwgxSBFKFyDz1wJocIbCJvNRGOE4WuLXSwbTswTWJW49OHRAkOw7rFZD0HkOWKbVOmMQoBgINxQ+2FvhzqJuS8yl5oBLd51d9wfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcchW9NF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e0f80fc3a2so130633b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707855123; x=1708459923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2A5s0YU98xz4fK0cK8V3de3MUudesnEU1GM23Fa1guU=;
        b=FcchW9NF+RFaRtvsFotzI6lXoaHvXnWc3XaCoV82OK+bgCjrCQtbWoGHadoc68Gr/4
         Wic9+HYvkwcryNBxDLicbi5USRaiDw0Zd23iabST4/8rHe6VtynoSiiW04xorxnbi9j9
         P1pge8Lrbsq+XiNsRBDk60KohVcclxKyL5AlRvix2iXBpHnjc8IQ9TQ9apSFjGnr4GK5
         Bu/lnigi5GwnNBJwftAoYoNbTc/OLeed+yc9/tHW/Pb1Z9itfA4+VzssFqtwsVdnIWMB
         roCP8A5++R0xCLV6p8oZxEOlMn25vlTZ4eJe6xES+Az111i1fA3Xj0GASj+xU77K+ssg
         smow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855123; x=1708459923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A5s0YU98xz4fK0cK8V3de3MUudesnEU1GM23Fa1guU=;
        b=mVswn2XyqMnWzHHN3PW6Yk/VV0AKuu84KsbOU1x4q5ERytuuBU40X8wHKdRhWAO6Cl
         8W4by1whT/bN50rWCDFOjqbvwftf73isGDe6/99+2/DrjNKvdEUkqsIiHNkgFumhlMVT
         uIxETcMBmy6FqTE6bydQJQBS6IwzbhwrtyAu2wMJ6jd6C76lFNreXoK/b/1522bQ+fxG
         IYWtSWb+A+fG8uWqmP6+jN8mixfpr9x517/b8FR4V948DMGHBgkB5U1q9J2Ja4hSCZXG
         SlFNG54XrcE8DdymunXn1zmQ3tvCqeEDccomoA5VnZsuD6MiNAgO334KRECk5T4ePM4J
         9o6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW73N1TtPIFxJUkC65CBv1VxW6UCoG+7G7UWR7Irot8HQJ+MR2QlKep/fpnCMq9wUPXUjhzSoEtd59zngFLx+zLc/dd0TcYQAh5N063
X-Gm-Message-State: AOJu0YxJCVmwjpffWg7dyyd7OnD5IDmrHwNn4TKtogCvhQqAoJ8K/y/K
	rDPxh01VAzDLy5xgiiAVvhTVkBS6tvpcICc+V9Yy15C/cMe3BqVmimkbYpddVYwHsAPWYqQlUZp
	QXsCIAWTBwETzk20c0A==
X-Google-Smtp-Source: AGHT+IExeZVhpAceFDb9htK4GPHrMci1ApVjcWdvilVnelZ/Zf/UUmWgJiNkumOH4bXfBBgUeGQGqpkRPlRlgfZx
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6a00:c94:b0:6e0:59a6:fbab with SMTP
 id a20-20020a056a000c9400b006e059a6fbabmr103151pfv.1.1707855122648; Tue, 13
 Feb 2024 12:12:02 -0800 (PST)
Date: Tue, 13 Feb 2024 20:11:56 +0000
In-Reply-To: <20240213200923.2547570-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213200923.2547570-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213201156.2549021-1-ericchancf@google.com>
Subject: [PATCH v4 2/4] riscv/barrier: Define RISCV_FULL_BARRIER
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce RISCV_FULL_BARRIER and use in arch_atomic* function.
like RISCV_ACQUIRE_BARRIER and RISCV_RELEASE_BARRIER, the fence
instruction can be eliminated When SMP is not enabled.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/atomic.h  | 16 ++++++++--------
 arch/riscv/include/asm/cmpxchg.h |  4 ++--
 arch/riscv/include/asm/fence.h   |  2 ++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index f5dfef6c2153..31e6e2e7cc18 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -207,7 +207,7 @@ static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int
 		"	add      %[rc], %[p], %[a]\n"
 		"	sc.w.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
@@ -228,7 +228,7 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
 		"	add      %[rc], %[p], %[a]\n"
 		"	sc.d.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		: [a]"r" (a), [u]"r" (u)
@@ -248,7 +248,7 @@ static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
 		"	addi      %[rc], %[p], 1\n"
 		"	sc.w.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -268,7 +268,7 @@ static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
 		"	addi      %[rc], %[p], -1\n"
 		"	sc.w.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -288,7 +288,7 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 		"	bltz     %[rc], 1f\n"
 		"	sc.w.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -310,7 +310,7 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
 		"	addi      %[rc], %[p], 1\n"
 		"	sc.d.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -331,7 +331,7 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
 		"	addi      %[rc], %[p], -1\n"
 		"	sc.d.rl   %[rc], %[rc], %[c]\n"
 		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
@@ -352,7 +352,7 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 		"	bltz     %[rc], 1f\n"
 		"	sc.d.rl  %[rc], %[rc], %[c]\n"
 		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
+		RISCV_FULL_BARRIER
 		"1:\n"
 		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
 		:
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..a608e4d1a0a4 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -313,7 +313,7 @@
 			"	bne  %0, %z3, 1f\n"			\
 			"	sc.w.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
+			RISCV_FULL_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" ((long)__old), "rJ" (__new)		\
@@ -325,7 +325,7 @@
 			"	bne %0, %z3, 1f\n"			\
 			"	sc.d.rl %1, %z4, %2\n"			\
 			"	bnez %1, 0b\n"				\
-			"	fence rw, rw\n"				\
+			RISCV_FULL_BARRIER				\
 			"1:\n"						\
 			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
 			: "rJ" (__old), "rJ" (__new)			\
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 2b443a3a487f..6c26c44dfcd6 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -4,9 +4,11 @@
 #ifdef CONFIG_SMP
 #define RISCV_ACQUIRE_BARRIER		"\tfence r , rw\n"
 #define RISCV_RELEASE_BARRIER		"\tfence rw,  w\n"
+#define RISCV_FULL_BARRIER		"\tfence rw, rw\n"
 #else
 #define RISCV_ACQUIRE_BARRIER
 #define RISCV_RELEASE_BARRIER
+#define RISCV_FULL_BARRIER
 #endif
 
 #endif	/* _ASM_RISCV_FENCE_H */
-- 
2.43.0.687.g38aa6559b0-goog


