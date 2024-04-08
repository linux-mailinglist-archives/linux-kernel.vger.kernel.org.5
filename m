Return-Path: <linux-kernel+bounces-135126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57489BB6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6871C215E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC74DA03;
	Mon,  8 Apr 2024 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA8Lv5Ok"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F0482EA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567756; cv=none; b=Zf2w+ZALt3sOkga6IKc+tO9V3rDgAq7thqMTezGKFMrTEolojRhoHf71qU2IoLhr9rhpV3aQFuIPNQglnw9K24b3ZLW4d1AU2vTMRvF20dyb2GRY62NmbLQ8Ca0r3v4DvtScgbYP6OquOgu+Uj3K1a4wjBooczpukXFwl4V9Gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567756; c=relaxed/simple;
	bh=ajtEuYhg6tg/Ve6M8YmoGbWiyVZbMBY8VxkpitJpcxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIB8FK6ydpagaGVTVAdUq51HJv5JVDFysHKur/dYE/a+JU0f5QwoPsVV5RCb9USU/L9PSZ0vv6scN4Z1Vpur985DsZncjh4wEgLmSdo6U124hHFfdhpFJzRqdAwwxOJ456ATvUJkJPgCoLNF3N1LVDn6WAgdVI87Gl/5m3mBdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA8Lv5Ok; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516dbc36918so2088585e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712567753; x=1713172553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lly84JUd9nQjiRLZt1VPtBdBs8JWG4Lo21me51Cb3p8=;
        b=OA8Lv5OkEs6fqGWarE34I01fYv6IGo24ofV0HGGWqxXqvTGbAsKti8IA2a4gjfEIYv
         BvpSjGtEtTaUmTae06kTuILgldueAazqQM+iqbfhocVvA82eTAtbTyMFA2BGmufieRp8
         wEIB2L9dRO2uQ3DlKrAogGa1Iw3+pL1OL9TFDo3cMUjv1ANlJdhdR0w5BVhVxWh2og94
         nCtn/nk/8SBDgsw1Rh/Wz+vDa/oHG7KGkn8NbFYtLALyaUvNrO74+Ykiabe00lcwwEpv
         rAOnEVeBymFiaq0knykkp+ZaIcmmCbQTuQprpunQSm7az4faFEWh3w51ZiktjLAbyP1A
         WYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567753; x=1713172553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lly84JUd9nQjiRLZt1VPtBdBs8JWG4Lo21me51Cb3p8=;
        b=DASegVMFvUkcx5GTOOf7MK6VMUUmucdPZ32z86Damad30yMnV1c+iGdUw3FNloE2DQ
         Q6tZrjoZWAB3NDG1FEj3CoC3HOzfA0eE9II4GDhQjgorGIPXThso1/ChJNaYVjeH71Ix
         1WEdJpSDtQtpO7wAxdNNU4aoLPDY3j2Cc+GgJ49dt9eT201sO+gKabK6KebS2oeEDVsy
         4XunDjAI82dE6b0vhzynox/Mlvsf4htWqhQHxaA+6UPxDvEVwIgcRisG729z1KAHG0sc
         PMN04GH02HZriyaKY75z3hPyhXzHxeewXdPr4zke8J9RXojdUlwBA5ZVLIGsckynJMG6
         F6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXh1AvkCabczcxKV/GoCPPuEhnyGBxHVOTB1NsRCVW9N0u50jdaVa0rHANTAJoMAT8KicLpJA8xGdS15XGCkNaurvHoxHYyH8kJBWCu
X-Gm-Message-State: AOJu0YwKenumgphtyDQN1UqnY3zQPJimsvDVvDGgWSeUs8uBlLV86Cc1
	fARMe4tRunO2TXtQlVjoV9Gnv6QqjqKo0RHOOKOyc6PoBhDAm/Fk
X-Google-Smtp-Source: AGHT+IG258Ol6woJs2qReshG4mhHDqu8BVouu5bALoOu3PFnH5xi7MUq0385pTIp43atwUWe4v+hgw==
X-Received: by 2002:ac2:539c:0:b0:515:9185:652f with SMTP id g28-20020ac2539c000000b005159185652fmr4919406lfh.33.1712567753010;
        Mon, 08 Apr 2024 02:15:53 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id n2-20020a056402434200b0056de7bee45bsm3854201edc.18.2024.04.08.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:15:52 -0700 (PDT)
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
Subject: [PATCH 2/3] locking/atomic/x86: Modernize x86_32 arch_{,try_}_cmpxchg64{,_local}()
Date: Mon,  8 Apr 2024 11:13:57 +0200
Message-ID: <20240408091547.90111-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408091547.90111-1-ubizjak@gmail.com>
References: <20240408091547.90111-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit:

  b23e139d0b66 ("arch: Introduce arch_{,try_}_cmpxchg128{,_local}()")

introduced arch_{,try_}_cmpxchg128{,_local}() for x86_64 targets.

Modernize existing x86_32 arch_{,try_}_cmpxchg64{,_local}() definitions
to follow the same structure as the definitions introduced by the
above commit.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/cmpxchg_32.h | 179 +++++++++++++++++-------------
 1 file changed, 100 insertions(+), 79 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index b5731c51f0f4..fe40d0681ea8 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -3,103 +3,124 @@
 #define _ASM_X86_CMPXCHG_32_H
 
 /*
- * Note: if you use set64_bit(), __cmpxchg64(), or their variants,
+ * Note: if you use __cmpxchg64(), or their variants,
  *       you need to test for the feature in boot_cpu_data.
  */
 
-#ifdef CONFIG_X86_CMPXCHG64
-#define arch_cmpxchg64(ptr, o, n)					\
-	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
-					 (unsigned long long)(n)))
-#define arch_cmpxchg64_local(ptr, o, n)					\
-	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
-					       (unsigned long long)(n)))
-#define arch_try_cmpxchg64(ptr, po, n)					\
-	__try_cmpxchg64((ptr), (unsigned long long *)(po), \
-			(unsigned long long)(n))
-#endif
+union __u64_halves {
+	u64 full;
+	struct {
+		u32 low, high;
+	};
+};
+
+#define __arch_cmpxchg64(_ptr, _old, _new, _lock)			\
+({									\
+	union __u64_halves o = { .full = (_old), },			\
+			   n = { .full = (_new), };			\
+									\
+	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	o.full;								\
+})
 
-static inline u64 __cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
+
+static __always_inline u64 __cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	u64 prev;
-	asm volatile(LOCK_PREFIX "cmpxchg8b %1"
-		     : "=A" (prev),
-		       "+m" (*ptr)
-		     : "b" ((u32)new),
-		       "c" ((u32)(new >> 32)),
-		       "0" (old)
-		     : "memory");
-	return prev;
+	return __arch_cmpxchg64(ptr, old, new, LOCK_PREFIX);
 }
 
-static inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
+static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
 {
-	u64 prev;
-	asm volatile("cmpxchg8b %1"
-		     : "=A" (prev),
-		       "+m" (*ptr)
-		     : "b" ((u32)new),
-		       "c" ((u32)(new >> 32)),
-		       "0" (old)
-		     : "memory");
-	return prev;
+	return __arch_cmpxchg64(ptr, old, new,);
 }
 
-static inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *pold, u64 new)
+#define __arch_try_cmpxchg64(_ptr, _oldp, _new, _lock)			\
+({									\
+	union __u64_halves o = { .full = *(_oldp), },			\
+			   n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(_lock "cmpxchg8b %[ptr]"				\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	bool success;
-	u64 old = *pold;
-	asm volatile(LOCK_PREFIX "cmpxchg8b %[ptr]"
-		     CC_SET(z)
-		     : CC_OUT(z) (success),
-		       [ptr] "+m" (*ptr),
-		       "+A" (old)
-		     : "b" ((u32)new),
-		       "c" ((u32)(new >> 32))
-		     : "memory");
-
-	if (unlikely(!success))
-		*pold = old;
-	return success;
+	return __arch_try_cmpxchg64(ptr, oldp, new, LOCK_PREFIX);
 }
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CMPXCHG64
+
+#define arch_cmpxchg64 __cmpxchg64
+
+#define arch_cmpxchg64_local __cmpxchg64_local
+
+#define arch_try_cmpxchg64 __try_cmpxchg64
+
+#else
+
 /*
  * Building a kernel capable running on 80386 and 80486. It may be necessary
  * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
  */
 
-#define arch_cmpxchg64(ptr, o, n)				\
-({								\
-	__typeof__(*(ptr)) __ret;				\
-	__typeof__(*(ptr)) __old = (o);				\
-	__typeof__(*(ptr)) __new = (n);				\
-	alternative_io(LOCK_PREFIX_HERE				\
-			"call cmpxchg8b_emu",			\
-			"lock; cmpxchg8b (%%esi)" ,		\
-		       X86_FEATURE_CX8,				\
-		       "=A" (__ret),				\
-		       "S" ((ptr)), "0" (__old),		\
-		       "b" ((unsigned int)__new),		\
-		       "c" ((unsigned int)(__new>>32))		\
-		       : "memory");				\
-	__ret; })
-
-
-#define arch_cmpxchg64_local(ptr, o, n)				\
-({								\
-	__typeof__(*(ptr)) __ret;				\
-	__typeof__(*(ptr)) __old = (o);				\
-	__typeof__(*(ptr)) __new = (n);				\
-	alternative_io("call cmpxchg8b_emu",			\
-		       "cmpxchg8b (%%esi)" ,			\
-		       X86_FEATURE_CX8,				\
-		       "=A" (__ret),				\
-		       "S" ((ptr)), "0" (__old),		\
-		       "b" ((unsigned int)__new),		\
-		       "c" ((unsigned int)(__new>>32))		\
-		       : "memory");				\
-	__ret; })
+#define __arch_cmpxchg64_emu(_ptr, _old, _new)				\
+({									\
+	union __u64_halves o = { .full = (_old), },			\
+			   n = { .full = (_new), };			\
+									\
+	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+				 "call cmpxchg8b_emu",			\
+				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	o.full;								\
+})
+
+static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
+{
+	return __arch_cmpxchg64_emu(ptr, old, new);
+}
+#define arch_cmpxchg64 arch_cmpxchg64
+
+#define __arch_cmpxchg64_emu_local(_ptr, _old, _new)			\
+({									\
+	union __u64_halves o = { .full = (_old), },			\
+			   n = { .full = (_new), };			\
+									\
+	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
+				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	o.full;								\
+})
+
+static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
+{
+	return __arch_cmpxchg64_emu_local(ptr, old, new);
+}
+#define arch_cmpxchg64_local arch_cmpxchg64_local
 
 #endif
 
-- 
2.44.0


