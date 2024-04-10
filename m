Return-Path: <linux-kernel+bounces-137987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EC89EADD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351501F2223B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BE0282F0;
	Wed, 10 Apr 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu19O7PK"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B7622
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730616; cv=none; b=M1eAROoV+DJjYwZOWXSoWxNl/p0hOTEU+i3NPs8T2uFCEM7HNBBV+HiyD727m4ISaCcxWayjJk4b3h5j3m22LvsBVRhDLkdS7AtyLcPiqKijAFCrKN8e+qw/shMLzZh7fJ+Irtk6uaJjOXidYLHR8qg7L3diOAMRzx5YgVAIG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730616; c=relaxed/simple;
	bh=CO+6MPVz/QxXcL0brnGMytLtD6O1q1GdQ40AKCK51R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKg4m2nA3pwb3TybHAbRU1f3KTN5dVa4GGvzofvBxdOy0/eHxRQmB+H0j3yzYXl9wBr1cGaLwD0oGFU7NKP10l4USQ7jdd9cSXqwaituC10AKYcTecalIX4wbCirGin4pgMqoncRLU4nNmN07iBm7yR6ncPLYQCWya7jT+ROhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu19O7PK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e6f4ee104so2424824a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712730613; x=1713335413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFxW3nI2+CPGcs4q8KjFFik9//Z7qUeRlO8tByqr2jM=;
        b=Iu19O7PKgQRd8lKVQ63qFZAl/y1LuZCWvSFWDPyKmQgyPxezv4KeO9PUQaqIqdHWh7
         Cm3wOnnzqQI85LDaS9kc2nQB+DCGeKAoMkEki2jqyejbDk73mh12Guf7s0cU+xD1nDdO
         RJ5j3nMd1m41JtjzY+FhC9zv27oiKDg/w1ogWa9uBKZc63KmzXI23uEXJQAdUUlzE/1e
         ADUSLKfFE6Aw56fCkG+vvlr7UYn+Y/oHJbHaY8KGjtycO/5M0mSgio41x8b28+HOu0ZT
         JRIKWhaUGx05V6TihtQo0KHEuxQD34d07lQunuR+eenw2Oa2yuXxHkquooyWkd3SVZ3F
         M/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730613; x=1713335413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFxW3nI2+CPGcs4q8KjFFik9//Z7qUeRlO8tByqr2jM=;
        b=UM7gYJ34VhGA7Ublg8qHXVX8qr4h1e0ZeU39Su8LtQrUhOIx/guqreVREHqCmgXzuu
         vB6zvvr7cNUQSbpYdiC2Fuw0YcRzDTOL8eTxabQtG9HTBpHuMCcfi3LBSSTVLfaKAU6F
         5UNy1vly9WzqIjwF6Wtdm3U85RODmV8F1De7ShjNg3zfIMmBks8wLmhF/VFvpU7jawJ0
         oigyHabi2c68QFnnok7cWgHl26HA+4wCnXgOCeOiM3luj3l2ezj04YLcbpPMqrpIBVJS
         VRgh9z/7Zj1tRAyA/6EDyjbLUxALAltLXM1EX9Nzdn4rKUL4tqyxTeThSrqEFtiYqYu6
         VyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqYqfw/TeHqdqqzZx/V4HsT+WpnaJlSuLW20dgJl8SpOb+q5wGNq+cx7+beqCHCq5+Q90MCqYmjMx5+685Hz9H/nMRM7l1ut6OyLNu
X-Gm-Message-State: AOJu0YwPJxMko/j8AmBTALXubJZY1pZvLr5FeClaxuyxfgfaKy1l6BIk
	MF2CMIZIjPGjv9ldFXnQnK4dNx5Q6/k/hY5kizjSaqOr/62xlRmw
X-Google-Smtp-Source: AGHT+IH4z8cdGhTCXwcW6szLX6C47v+3Mwa8s9jtrZxlOwKcH9FXOtsWqRex+3egEpHwTbbVLUI3+w==
X-Received: by 2002:a50:d795:0:b0:568:a9f3:b3fb with SMTP id w21-20020a50d795000000b00568a9f3b3fbmr945907edi.8.1712730613241;
        Tue, 09 Apr 2024 23:30:13 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id c9-20020a0564021f8900b00568c613570dsm6129606edc.79.2024.04.09.23.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:30:12 -0700 (PDT)
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
Subject: [PATCH v3 3/4] locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions
Date: Wed, 10 Apr 2024 08:29:35 +0200
Message-ID: <20240410062957.322614-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410062957.322614-1-ubizjak@gmail.com>
References: <20240410062957.322614-1-ubizjak@gmail.com>
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
Use arch_atomic64_read_nonatomic(v) to load the value from atomic_t
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
v2: Use arch_atomic64_read_nonatomic().
---
 arch/x86/include/asm/atomic64_32.h | 43 +++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index bc76a88ae481..8db2ec4d6cda 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -227,69 +227,62 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c & i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
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
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c | i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
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
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c ^ i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 }
 
 static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	s64 old, c = 0;
+	s64 val = arch_atomic64_read_nonatomic(v);
 
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
+	s64 val = arch_atomic64_read_nonatomic(v);
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c + i)) != c)
-		c = old;
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
 
-	return old;
+	return val;
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-- 
2.44.0


