Return-Path: <linux-kernel+bounces-149024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 988AF8A8AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB32846C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCC172BC5;
	Wed, 17 Apr 2024 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEDG4pOH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56416FF52
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376723; cv=none; b=aj+34O/NzC+hGUXGXxc2d5V44dJWs+yVKKq493BN0VOMdKt9llPr3P/Qpzgrfj+nZRJGQoKie511fVaOra/j8Kovxc83+GIin8+tNeDNIhhA7SqZb+Esn1ulncE7xWQ9pcPClhOee4zjsidevzrEcVegaGqo3PuFO0BT0aiNNRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376723; c=relaxed/simple;
	bh=ZKyapYL4RldrjpQ9jjqVJyk+yZwJ4tJfRj7tapsNa/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4pq0WhtB6wXvv4CAOra39iw79nhyU6nuT9iqZvIPO0Q90WYHjFnsqH67WfY/536rhRz16etUs+RJfqcNDVVpv99HchMznrJVmky2HXTlbUtMeXLpw1vedRQzKhn3ZGo44Mbinn5Jo18sweZ/1QqfNRjqr1GopQuUrWg+XFt7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEDG4pOH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5194a2cf7c2so1129938e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713376720; x=1713981520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eso1cJErLr5fMl62SnEcQ5C9TY3ZGBWSN1bAngprfS8=;
        b=dEDG4pOHSrHk9YNGOz1tuD3uPSW5JtMGBwTH/mNFns52ouYQZuqkeXNogaEqY7OsEI
         6o4KH5wELxR9UBJXcU4IouDE4qtNA5HS3+uNkGMfCM/D1JezAwEqVgopy/I5dyy0gTM0
         Dyuvl6f0wB7kFpOiqQgjCZgC+8AyHglFYdj0w0fNFzoLKX5ftm3T/nApuOot1+LxNtqq
         jI91DjVq7qB5eDiwNMsVJ5gCJFK2d1Q8Rx0LM6z+RhPhxJAXKN8Ix3osUSz3WLnz4CaM
         wbAYPwRsQv9ByloZrO7bjgkPfpgbpbNGl0XveL+GG7j2s/c7OsTZvtdaii90A+/MWeml
         uGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376720; x=1713981520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eso1cJErLr5fMl62SnEcQ5C9TY3ZGBWSN1bAngprfS8=;
        b=i4cIDrmbmeCDMfiSGSs5SzRx+AsojA1rIUZZh8ar5n3UG8RXRFlNCTMEmnpCivisWS
         0FCadHwG9lGqHY89wY4DLQ84gHvrLTpOJr3nLmuDvun8f1yqTrWVEyarvq5G9r4EEL43
         PEq9E34cLlFY5GAoXcd24nDcfAeOnG+0f7UpxvHSk0JNXz1S/iTDRyCG4IAErgA2I03L
         5lFwBSzSb+8eX+EOCaQvYBrFPpMrM3tVWVQIxF6Vn/s+JH8T4vc/fUy2wPveA95BmQ1j
         qH+wIHcp7aY3xcjRnwAIJz+pcRW53Zovrk8DO0WTux6WYr2pt/CLeSzX9ZgCy1lCEoYM
         sWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7maNr3KWFtPKTdLmkgyjwfjtT+BF1Pg9fS2kRZNpcr5IW0eM+QZlGRgzhxfJ2Btl6LTIsOOCFVEdeDVPId2lz/CIjrmbxBzSyybX9
X-Gm-Message-State: AOJu0YzzvOl9P98NJs29EZaGtBJQETluV9147OG/hVH/cTnIb2fJK1W2
	NcAoFUvWFrydgXnhlxbezfo9yQ7Op6H7OxMA2VpJQ6waUNnYKZsy
X-Google-Smtp-Source: AGHT+IEv/0c2jDP51WUlSYyun8nci8jBNXmqx9E44utZDSlE0V/G3Oa92y1Ilyf0YxSiWJIu4nosVA==
X-Received: by 2002:a05:6512:3b22:b0:517:5ee6:4f56 with SMTP id f34-20020a0565123b2200b005175ee64f56mr36531lfv.8.1713376719696;
        Wed, 17 Apr 2024 10:58:39 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906501100b00a4e696e613esm8373650ejj.153.2024.04.17.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:58:38 -0700 (PDT)
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
Subject: [PATCH] locking/atomic/x86: Merge __arch{,_try}_cmpxchg64_emu_local() with __arch{,_try}_cmpxchg64_emu()
Date: Wed, 17 Apr 2024 19:58:12 +0200
Message-ID: <20240417175830.161561-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Macros __arch{,_try}_cmpxchg64_emu() are almost identical to their
local variants __arch{,_try}_cmpxchg64_emu_local(), differing only
by lock prefixes.

Merge these two macros by introducing additional macro parameters
to pass lock location and lock prefix from their respective static
inline functions.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/cmpxchg_32.h | 56 ++++++-------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 9dedc13d5a77..ed2797f132ce 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -86,14 +86,14 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
  * to simulate the cmpxchg8b on the 80386 and 80486 CPU.
  */
 
-#define __arch_cmpxchg64_emu(_ptr, _old, _new)				\
+#define __arch_cmpxchg64_emu(_ptr, _old, _new, _lock_loc, _lock)	\
 ({									\
 	union __u64_halves o = { .full = (_old), },			\
 			   n = { .full = (_new), };			\
 									\
-	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
 		     : [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
@@ -104,40 +104,25 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 
 static __always_inline u64 arch_cmpxchg64(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu(ptr, old, new);
+	return __arch_cmpxchg64_emu(ptr, old, new, LOCK_PREFIX_HERE, "lock; ");
 }
 #define arch_cmpxchg64 arch_cmpxchg64
 
-#define __arch_cmpxchg64_emu_local(_ptr, _old, _new)			\
-({									\
-	union __u64_halves o = { .full = (_old), },			\
-			   n = { .full = (_new), };			\
-									\
-	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
-				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
-		     : [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
-		     : "memory");					\
-									\
-	o.full;								\
-})
-
 static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new)
 {
-	return __arch_cmpxchg64_emu_local(ptr, old, new);
+	return __arch_cmpxchg64_emu(ptr, old, new, ,);
 }
 #define arch_cmpxchg64_local arch_cmpxchg64_local
 
-#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new)			\
+#define __arch_try_cmpxchg64_emu(_ptr, _oldp, _new, _lock_loc, _lock)	\
 ({									\
 	union __u64_halves o = { .full = *(_oldp), },			\
 			   n = { .full = (_new), };			\
 	bool ret;							\
 									\
-	asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE			\
+	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
-				 "lock; cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
+				 _lock "cmpxchg8b %[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
 		     : CC_OUT(e) (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
@@ -153,34 +138,13 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 
 static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu(ptr, oldp, new);
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, LOCK_PREFIX_HERE, "lock; ");
 }
 #define arch_try_cmpxchg64 arch_try_cmpxchg64
 
-#define __arch_try_cmpxchg64_emu_local(_ptr, _oldp, _new)		\
-({									\
-	union __u64_halves o = { .full = *(_oldp), },			\
-			   n = { .full = (_new), };			\
-	bool ret;							\
-									\
-	asm volatile(ALTERNATIVE("call cmpxchg8b_emu",			\
-				 "cmpxchg8b %[ptr]", X86_FEATURE_CX8)	\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       [ptr] "+m" (*(_ptr)),				\
-		       "+a" (o.low), "+d" (o.high)			\
-		     : "b" (n.low), "c" (n.high), "S" (_ptr)		\
-		     : "memory");					\
-									\
-	if (unlikely(!ret))						\
-		*(_oldp) = o.full;					\
-									\
-	likely(ret);							\
-})
-
 static __always_inline bool arch_try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp, u64 new)
 {
-	return __arch_try_cmpxchg64_emu_local(ptr, oldp, new);
+	return __arch_try_cmpxchg64_emu(ptr, oldp, new, ,);
 }
 #define arch_try_cmpxchg64_local arch_try_cmpxchg64_local
 
-- 
2.42.0


