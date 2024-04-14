Return-Path: <linux-kernel+bounces-144260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D405D8A43B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D171C21C1A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A11350E3;
	Sun, 14 Apr 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAMyS3YQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750071350C8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111189; cv=none; b=Eti5H/PQ3iWv6ia7Y7eaTW/mpyp2C5GWUSa2jFWou5cZyU55+Ies53Fgv2hjZ5aycpoYkENSFAX1KT2ii3MfRBpin5KjgYa/YIK9SRz8WIMmY7qXSApB0gJyq7IMGdDe2imWyObMkq997QDAvYdYGKcY/kvhIYEjNmRLOLy53H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111189; c=relaxed/simple;
	bh=9oRFAYGbDDOoaLx4QcYNAokeXsnrRne20HKc37iwr4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPwuIo7JoCye6b3yWiTJr2ndWb48/03b8CFCpUTU5xZmpUzgAtw3KjipgyFBP2t5zVw9aI8mqpU6J72sxqQJITSe0d1iVaKhC8G7lJaydx4ydyB8v/3/OIFvefAWl744JUwKKd+tcWEYujD3a3nuzwYIVTx8tbT0p4GR4wQT6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAMyS3YQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a523dad53e0so270058466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713111186; x=1713715986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pb6u2iKzO91RpMLMUiyKz4o6sFnm+wegDY6BclSI7s=;
        b=KAMyS3YQAQpCQf5XqP/nGKMVNNglguN2oIFIVQXPIOiOvdnhmRIXgYLbjuy3j6xP2w
         A62jbwSRvX70w5YU7cBQ5ealNgZijxSMs9VO6nSA/mb8cveVUnY5GSoFV7JZCGfKgs/Y
         bfCx4T46MJhA4KuRTF1bmUuc6pAUJ4QqESPOtiNfS4MhPAGbCpO0MFDJuf0IxGpSLuHv
         1QGFgvYXbtKBaPkFOiAiZtuZ/r5DXIXnitAoPRn6Zqiv5XU+rSXMaCtKXrvq+YwcEsRw
         9NfnkehNT+f6SSWg8D2uAc8usjpQSjL3iTQuHTs7hAdUnmIhFRVlESqPsNhJ27fLU+0d
         M5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713111186; x=1713715986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pb6u2iKzO91RpMLMUiyKz4o6sFnm+wegDY6BclSI7s=;
        b=k2uqBKKs3DD3vMgJJEqEXPleHa6zD3FcY5rSgXTmfACK57iZxT7Achb/Bao7X0rFg/
         aBa/2+ukCaa1WlRebOSZ6v0lORvUPJLlB3mMbPVNsz1nfFkCIAka28Luk+8YMzu9VU9Q
         AfzJvy5NrwEpue/cx+2f8nhz9pluDN5Nngwn2LeFdZKdSYXLFbjiKvmvGjZbcuV70GZV
         XG0OmCjfo7nQfI1R5XwjqvKQ6NMUzsKbVN1lTg2A6MjLR48FNxAwundHpWKjuKxqqqRf
         AL7BHRv95CiIkKUx1OYQHJNyh5EzNY2szT0CazxVGirhXY+CVfHiH5MgXM90lfYPdnGz
         0cNA==
X-Forwarded-Encrypted: i=1; AJvYcCVxzS513xCUR0aZkA+6c5Ua0cPUZrHHMm8H2gbmHtt/vgu6UahD5LwwYmEPg8XLNfUilkHx5QXst61Jg1KWgELvTmlYBB3nePQI6IA9
X-Gm-Message-State: AOJu0YzxIhSldTbQCmryR0H6LKDpcaP791TLLQJyh/vfJfgpzo9kHNAY
	VSxjmFM9MSleTqCKRnmMvOCZe8jQUAsxgkGMJKU8i9NvDYmskdR3
X-Google-Smtp-Source: AGHT+IFdpf1IQ1AyM7KffYJX2Jh7ADp0i70O+uPHrrso96DxAsFMaIJ+4vrGgZjzoXY0w4f2KH+3eg==
X-Received: by 2002:a17:907:9715:b0:a52:1bba:7458 with SMTP id jg21-20020a170907971500b00a521bba7458mr10378489ejc.0.1713111185429;
        Sun, 14 Apr 2024 09:13:05 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id hd7-20020a170907968700b00a524dda47c0sm2085808ejc.143.2024.04.14.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 09:13:04 -0700 (PDT)
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
Subject: [PATCH] locking/atomic/x86: Introduce arch_try_cmpxchg64_local()
Date: Sun, 14 Apr 2024 18:12:43 +0200
Message-ID: <20240414161257.49145-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_try_cmpxchg64_local() for 64-bit and 32-bit targets
to improve code using cmpxchg64_local().  On 64-bit targets, the
generated assembly improves from:

    3e28:	31 c0                	xor    %eax,%eax
    3e2a:	4d 0f b1 7d 00       	cmpxchg %r15,0x0(%r13)
    3e2f:	48 85 c0             	test   %rax,%rax
    3e32:	0f 85 9f 00 00 00    	jne    3ed7 <...>

to:

    3e28:	31 c0                	xor    %eax,%eax
    3e2a:	4d 0f b1 7d 00       	cmpxchg %r15,0x0(%r13)
    3e2f:	0f 85 9f 00 00 00    	jne    3ed4 <...>

where a compare instruction after cmpxchg is saved.  The improvements
for 32-bit targets are even more noticeable, because double-word
compare after cmpxchg8b gets eliminated.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/cmpxchg_32.h | 34 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/cmpxchg_64.h |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 9e0d330dd5d0..9dedc13d5a77 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -64,6 +64,11 @@ static __always_inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 ne
 	return __arch_try_cmpxchg64(ptr, oldp, new, LOCK_PREFIX);
 }
 
+static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
+{
+	return __arch_try_cmpxchg64(ptr, oldp, new,);
+}
+
 #ifdef CONFIG_X86_CMPXCHG64
 
 #define arch_cmpxchg64 __cmpxchg64
@@ -72,6 +77,8 @@ static __always_inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 ne
 
 #define arch_try_cmpxchg64 __try_cmpxchg64
 
+#define arch_try_cmpxchg64_local __try_cmpxchg64_local
+
 #else
 
 /*
@@ -150,6 +157,33 @@ static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
+#define __arch_try_cmpxchg64_emu_local(_ptr, _oldp, _new)		\
+({									\
+	union __u64_halves o = { .full = *(_oldp), },			\
+			   n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
+				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
+{
+	return __arch_try_cmpxchg64_emu_local(ptr, oldp, new);
+}
+#define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
+
 #endif
 
 #define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index c1d6cd58f809..5e241306db26 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -20,6 +20,12 @@
 	arch_try_cmpxchg((ptr), (po), (n));				\
 })
 
+#define arch_try_cmpxchg64_local(ptr, po, n)				\
+({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_try_cmpxchg_local((ptr), (po), (n));			\
+})
+
 union __u128_halves {
 	u128 full;
 	struct {
-- 
2.42.0


