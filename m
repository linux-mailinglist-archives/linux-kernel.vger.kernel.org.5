Return-Path: <linux-kernel+bounces-137326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61889E075
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5551C22D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D078153582;
	Tue,  9 Apr 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/wZlSSZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7C152E0C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680338; cv=none; b=Uk70PLSIZD4MXYSzGR8mUqfzLWruPNI53y6XDvgsaAuuhPNpAM6FJEpRnDvlK/vBAvyP1UN9CR7O9zqEHxvREg/CfpH2iPkAd9EKDJJNp+LN2jg2oxgSiixaiQi2UZ7iNaLger0M0tKFZwTwXBibiEutgKGT3ce8gSSUDENqZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680338; c=relaxed/simple;
	bh=L0yPbG2/qZMEcSW2OR4dRnbvVqkKM9RX+OMLVf6pzME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFuIplFHIkIFqJtd9XHSnZT+MtlLhaVRkCZHQZjjPoLhyI9nK9bNsofOW/FJVfJC7R+tnLekenILeFqxUezyj4VcfTRpL2POd+h5CaLC5c2D8GJA29G81RHHY96UbjREr9ZQvjNBIhYMVRYF4qpXKUOdqOhyCMERK0ExXrkTVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/wZlSSZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so969525166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680335; x=1713285135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW+ax1eCwiYFzskSyK+X1ywGp/6NqdJMOyg1gUmgNzM=;
        b=B/wZlSSZygmJ0WxU/CQ9PlT4SAESsyVeDYwUxv8Z6wfB/9tyHq7nQhV3u5+77x++cg
         nSkNwOe6SrR1XpaH4Tfaj2uLTrCcx2pEqTna6I8MJ5Bxr/JOoGGcXq+rxJlxxeEW/duA
         KHJy22uzuqUxhj7Ujh3K5WXfqHIDZNjULtwBVVn8Czt+N2OKA6JfLiw1r042B/3dqezQ
         lDR3HpusD+qI6cb5UQDx5naTvgqCKWJ6ZKcCNppnQiUyIHUeZ0LUjOG3wD+7xS7XHf50
         qol6mAT0zVLDHUn7GTDhBMhyQea4rsJVKjaQw4cs3BHLNBSRM7pwO8uwrhdICf3Bibtu
         tZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680335; x=1713285135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW+ax1eCwiYFzskSyK+X1ywGp/6NqdJMOyg1gUmgNzM=;
        b=vs09pb+G2XZr+KyRcYFWQPiYNh/cRTF3dUaHVUSUtvtxRTVSZD4YosepDS2jgrV+QP
         zT3rgMfJBKckRkvLPFPbN9MEbEDuAvsQ3bs5aNsyxJGcwH49XWBhx6IbrkK+FD6WA1bN
         qaH/4ZYGqGpIOWaxW6vx8ppbnObwuD+oyFxrSg10/Aev9QdcblkWrF4wA76CDVK25S3t
         pn5RYJJgClZF6l8DVV/V1q8ms6Bed6rHJRaNBZVoF55ZGJ5gv4tls18lAUgkGgpR4GVB
         d4pTMww9smmD+cIYrZr06R/+lsakwHV5YLZOhIdAmTSpZDxHwbHwPEPEEdnhkuazt/ep
         QbLg==
X-Forwarded-Encrypted: i=1; AJvYcCWTfHNKjcMQT1ffxwYzd2kYspP2hZ42V8AUKWqAxJRY7KrUB2qH5V8ZkUAi9Qs3c1NOn3exGYqCu0Ld+o+C4VeAI0YKSENlPbSOcKay
X-Gm-Message-State: AOJu0YxdAxwtCO3X0vzIKWlyvmwSMz+tSGH7y3wheuqGaOT/amJ1tgzV
	MmhfAAR2YVdcvp9ip26ZaQDuVvw1aVCWyaIIO7Q9MKlvitRQpyil
X-Google-Smtp-Source: AGHT+IEHalRbGUe6rM9sZnISOL+yNkgSDhuqw0Ti8tD823zgKdqpvteKT2/pWE7gQ7VarySQoYlllg==
X-Received: by 2002:a17:907:1c95:b0:a4f:b398:2f47 with SMTP id nb21-20020a1709071c9500b00a4fb3982f47mr3298371ejc.25.1712680334798;
        Tue, 09 Apr 2024 09:32:14 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm5904265ejc.131.2024.04.09.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:32:13 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: mark.rutland@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/4] locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions
Date: Tue,  9 Apr 2024 18:30:31 +0200
Message-ID: <20240409163200.188498-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240409163200.188498-1-ubizjak@gmail.com>
References: <20240409163200.188498-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions to
use arch_atomic64_try_cmpxchg.  This implementation avoids one extra
trip through the cmpxchg loop.

The value preload before the cmpxchg loop does not need to be atomic.
Use arch_atomic64_read_tearable(v) to load the value from atomic_t
location in a non-atomic way.

The generated code improves from:

  1917d5:	31 c9                	xor    %ecx,%ecx
  1917d7:	31 db                	xor    %ebx,%ebx
  1917d9:	89 4c 24 3c          	mov    %ecx,0x3c(%esp)
  1917dd:	8b 74 24 24          	mov    0x24(%esp),%esi
  1917e1:	89 c8                	mov    %ecx,%eax
  1917e3:	89 5c 24 34          	mov    %ebx,0x34(%esp)
  1917e7:	8b 7c 24 28          	mov    0x28(%esp),%edi
  1917eb:	21 ce                	and    %ecx,%esi
  1917ed:	89 74 24 4c          	mov    %esi,0x4c(%esp)
  1917f1:	21 df                	and    %ebx,%edi
  1917f3:	89 de                	mov    %ebx,%esi
  1917f5:	89 7c 24 50          	mov    %edi,0x50(%esp)
  1917f9:	8b 54 24 4c          	mov    0x4c(%esp),%edx
  1917fd:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  191801:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  191805:	89 d3                	mov    %edx,%ebx
  191807:	89 f2                	mov    %esi,%edx
  191809:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
  19180d:	89 c1                	mov    %eax,%ecx
  19180f:	8b 74 24 34          	mov    0x34(%esp),%esi
  191813:	89 d3                	mov    %edx,%ebx
  191815:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  191819:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  19181d:	89 df                	mov    %ebx,%edi
  19181f:	89 54 24 44          	mov    %edx,0x44(%esp)
  191823:	89 ca                	mov    %ecx,%edx
  191825:	31 de                	xor    %ebx,%esi
  191827:	31 c8                	xor    %ecx,%eax
  191829:	09 f0                	or     %esi,%eax
  19182b:	75 ac                	jne    1917d9 <...>

to:

  1912ba:	8b 06                	mov    (%esi),%eax
  1912bc:	8b 56 04             	mov    0x4(%esi),%edx
  1912bf:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  1912c3:	89 c1                	mov    %eax,%ecx
  1912c5:	23 4c 24 34          	and    0x34(%esp),%ecx
  1912c9:	89 d3                	mov    %edx,%ebx
  1912cb:	23 5c 24 38          	and    0x38(%esp),%ebx
  1912cf:	89 54 24 40          	mov    %edx,0x40(%esp)
  1912d3:	89 4c 24 2c          	mov    %ecx,0x2c(%esp)
  1912d7:	89 5c 24 30          	mov    %ebx,0x30(%esp)
  1912db:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  1912df:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  1912e3:	f0 0f c7 0e          	lock cmpxchg8b (%esi)
  1912e7:	0f 85 f3 02 00 00    	jne    1915e0 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h | 43 +++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index b4434e5ae31d..50c4e5696e72 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -215,69 +215,62 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_tearable(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c + i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-- 
2.42.0


