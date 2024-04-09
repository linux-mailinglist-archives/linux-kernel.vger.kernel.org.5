Return-Path: <linux-kernel+bounces-136627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E717E89D645
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1646C1C22ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7A82865;
	Tue,  9 Apr 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBD1Dh6X"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECABF127B78
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657118; cv=none; b=tYIY78dZoPNBW764uFb4Q9Qe00toowxUM7838rqyk8BaI+7imzFar9pb6fB9jRYLDIUt6vdujoo//IR6vpf7oAlbNg+o5AVAxacl3F5qSB5f+nuYjbKgW/e1lQolYE6R/u4Q4HmfnwLwndme5eaXw43AJBB1C6q7dKX1MFhHDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657118; c=relaxed/simple;
	bh=+Fa+VjFTLuwGROrkdO13qvGvvADDnYTOxp3ABbZPnww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE01dQB1sOM4evLBKr09ssv8VLDhGZo+ClZwcPWTNxn67sQaDAWoXFX8Gy5YIN1pkDTX8Qic52qg/iiXltXYTmhcMuRAYXUcfUiAMKapQSdmL5P+BkdtLZ2NijOq+nTwjNcnXLL+DjbczxfKa8ZRaSgNUBm5AFMqq1Yz3eVWneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBD1Dh6X; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51381021af1so8730386e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657115; x=1713261915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjP8OuPSYU8pIC+kj3/su0ypXF+SYBCAH3lD5yqhYyM=;
        b=hBD1Dh6XFYrNwTj0zZI3kDf2r1xbMRYbziDOIlYhlzJuSq+GDxyIzHCOjUQbryEXri
         JTPfBr7UCWMnUsKhwohDwJpcaQiQ00VV8mFtVGMlExCFL2wGEsros5bN2qvjDKtDYj4F
         lZuleocWltHQzAbuJdoM3KeM/qmbfhhvzZUR1TX5gAtMaNWeoimDwfMeeyY8r9+PSrg1
         fNm63Duz/Xi/rgoDsvZKb0fHm0Ax0N1v/w243yW0m5i4uNagzrmahMmOep+XIFXKEHOW
         EXCfjoFrBQYTGO7CYPtIKkV9/ztskN0xOkwvEKgXZVdZDKPU5kHKbwv7VjZmQuVYDzAX
         Ox5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657115; x=1713261915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjP8OuPSYU8pIC+kj3/su0ypXF+SYBCAH3lD5yqhYyM=;
        b=bxVk/BanPaTxwvLQww4Byv2+jwyeGlLaAKNa9/vqAuyKghaGTRLTwAEfWkAuiGu2rW
         8V8ky35uS+R5JbP+MKJFhiYcUfAWDvOf7MkZzj+E6xQJKzAbpIdjIAl5EWvajagK66au
         eAwAm2xT/Q2Ua6Kah9/MygWbsn8fW+tpN8Wd+qit1Yqz8sJCnpxBdJuNX0piLVgJpx0e
         O/A2SfUWLd5h4oiAuyhNfc50fVogG1XaxJOJkITrq8s8ilEwH+HI1uzPgB7oGDEWtp5v
         Xwmy15PRqkgiddAkWYAJc0w65+ldPFvwGc0737Ra3UVzw0QgbA667oQtqhkEeEogqnRA
         FxKw==
X-Forwarded-Encrypted: i=1; AJvYcCWRWKc/4NH5D4+wEYL0c8VkZc/tjCuPRXPUX9yY/CUtiYeGW35mOHwdPGT+EVRabmlG9axGF/dCn8f7GMeqSG2SnGWLsv5XPai6bMMR
X-Gm-Message-State: AOJu0YzPtZKXzMCkyGl9sn2ZqWhqOq5Pj7iutriLdKEbg9Ate0EmQqoD
	lwV9sO97LghrOcLRH4O8AwTqNpiEj60GCCPlxv2jCkl4v4C1QlxP
X-Google-Smtp-Source: AGHT+IEZDqWek1R8pb5BSd4GD7BsxX4mL7A81DVxst0hWKSLUUuvUDWNrQX52A4wuEmiKVhoe11XUw==
X-Received: by 2002:ac2:5302:0:b0:513:c223:f0e4 with SMTP id c2-20020ac25302000000b00513c223f0e4mr10321029lfh.10.1712657114965;
        Tue, 09 Apr 2024 03:05:14 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id qs1-20020a170906458100b00a4e6626ae21sm5496681ejc.0.2024.04.09.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:05:13 -0700 (PDT)
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
Subject: [PATCH 5/6] locking/atomic/x86: Define arch_atomic_sub() family using arch_atomic_add() functions
Date: Tue,  9 Apr 2024 12:03:56 +0200
Message-ID: <20240409100503.274629-6-ubizjak@gmail.com>
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

There is no need to implement arch_atomic_sub() family of inline
functions, corresponding macros can be directly implemented using
arch_atomic_add() inlines with negated argument.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      | 12 ++----------
 arch/x86/include/asm/atomic64_32.h | 23 ++++++++++++-----------
 arch/x86/include/asm/atomic64_64.h | 12 ++----------
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index b2e44de36934..77526257dacf 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -86,11 +86,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
-static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
-{
-	return arch_atomic_add_return(-i, v);
-}
-#define arch_atomic_sub_return arch_atomic_sub_return
+#define arch_atomic_sub_return(i, v) arch_atomic_add_return(-(i), v)
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
@@ -98,11 +94,7 @@ static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 }
 #define arch_atomic_fetch_add arch_atomic_fetch_add
 
-static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub(i, v) arch_atomic_fetch_add(-(i), v)
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 4f79198da98e..862448db1207 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -199,6 +199,18 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 #undef alternative_atomic64
 #undef __alternative_atomic64
 
+static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	s64 val = __READ_ONCE(v->counter);
+
+	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
+
+	return val;
+}
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
+
+#define arch_atomic64_fetch_sub(i, v) arch_atomic64_fetch_add(-(i), v)
+
 static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
 	s64 val = __READ_ONCE(v->counter);
@@ -220,15 +232,4 @@ static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 }
 
-static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
-{
-	s64 val = __READ_ONCE(v->counter);
-
-	do { } while (!arch_atomic64_try_cmpxchg(v, &val, val + i));
-	return val;
-}
-#define arch_atomic64_fetch_add arch_atomic64_fetch_add
-
-#define arch_atomic64_fetch_sub(i, v)	arch_atomic64_fetch_add(-(i), (v))
-
 #endif /* _ASM_X86_ATOMIC64_32_H */
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index b2c9974ba971..a96a4b9acfcb 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -80,11 +80,7 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
-{
-	return arch_atomic64_add_return(-i, v);
-}
-#define arch_atomic64_sub_return arch_atomic64_sub_return
+#define arch_atomic64_sub_return(i, v) arch_atomic64_add_return(-(i), v)
 
 static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -92,11 +88,7 @@ static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static __always_inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
-{
-	return xadd(&v->counter, -i);
-}
-#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub(i, v) arch_atomic64_fetch_add(-(i), v)
 
 static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-- 
2.44.0


