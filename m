Return-Path: <linux-kernel+bounces-131199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC689845B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46250283F49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2D757EB;
	Thu,  4 Apr 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL+qng30"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D45D734
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223747; cv=none; b=LPJHW0zfCq/pPDzP7gbVp+jq7zWhEx9ufrhPqdWHdaUNkeJF1NfA+26m6b97oitosNj8BZ4llxH4NX7Uz4/9ktvzU5Qy7wD3gtZRStFEiesGII1FFO7pWPgHVSc55iOvikMFPaSbhtZiJ4Te+QjXrsN60SXd3rEqTOIr2xDfHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223747; c=relaxed/simple;
	bh=My06F/QUqqtWT73Ads4As4Qj3pMI0Oj1iaKsOVtCsWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbiLv2hEDaKo36KbipnjX9fGrHEHrtmNXgVlextAGevcyQ7KE1F9LbAUJaAbRSBFnx+CSKpfl7fbCzZdHsgtsjmsf16HajLntzJM3dpwTaBx3/B9paZbF/zg+yQvB2PeoIoFQ8Lx2xhWXSAMc4sNk+9HOnNn+u0UPTM2YI8lI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL+qng30; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4644bde1d4so107586466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223744; x=1712828544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoqlN3nosT+/1c7Je8c7SBGZJC3Xjll6GHoyVL0bqyA=;
        b=aL+qng30405JYv1CWMY+WSAGaDfSs4xoT0cxgXPVdqzcigeBPlwq6XUpfeui9QTPep
         CgKGqTf0WcVvdBq3gUctpYCmmlfABTvSZG/Et8UnmO8Ca0qRDTbr25hQBKv7fjbp26L8
         dnxDiAmvEF/JM91hhxMWDvtjZgbzL7ZhfQpmqeercGHY8GUPlzwe5mebjlga5pzeYldH
         LVZQUZQlyj02pOfSE4XkEsPuSYnNQ5DC88HTBXeG8al/vpSuHBJlqXv7MWfP8hm+EpgW
         uJEGzyar+OEuXHkhKb55LXJEJ0PiXDXkyQwpwAd/Th3JLVyACVoqCzM2kIzA0MRvwaCm
         ItFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223744; x=1712828544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoqlN3nosT+/1c7Je8c7SBGZJC3Xjll6GHoyVL0bqyA=;
        b=VCBqrmwIZGVH8DZ10hrjIK2362f4kPJYOi2HkK2rf9iIpySuzDXYPv+gHEx3qJx96d
         Gnbgb11/WzaRsUXiZr7vRlM9f5TzrcZeJ8GeTMroQfsTTRWpPlv7X9xQNm1NNAlh4LNz
         d/E01+TvRm3flUi5ww6VJKS98G95faxpVQZtNmUI9tg50LQ1y4t/KtdWVfUohM9WCj7i
         LaSLfONP6etHtJZbbNPKXSK/ylngJeK8ckBmF2WCY4gBpIsXoltg2KsggiYt27OHsFHi
         3IjDN3zFh9QsGYxab8cboIgDLuQSJgrPIdgcZnm0QWpRbdwCDje0e4piWIh466ncqYmM
         RTzA==
X-Forwarded-Encrypted: i=1; AJvYcCX+VQEeMNZYKYI774T70oXdtuUFvD7+Q1CwNykK4ovkbbORR1N5zixTWKB3m13pSbQHow58CHUSBHb+0ZmEOYe/D0y92Qt4slPZ120r
X-Gm-Message-State: AOJu0Yw8JI3c3JAlzGKtQ+A4FDzYdHVOwGLWgQUhGVuQBJIgq1vEq5l8
	qlnaoYKueTUj1XAg9mjj0v3EWln+G17hw21XDpxR6doidhGzzKzs
X-Google-Smtp-Source: AGHT+IFDbbWi8xuCijRe7DzBzAvue4E+3LK84tucyEMc607HFUXzeDbbxVWF4UImi+l31m5aYXrG1A==
X-Received: by 2002:a17:906:a386:b0:a51:7999:3d11 with SMTP id k6-20020a170906a38600b00a5179993d11mr1235940ejz.15.1712223743778;
        Thu, 04 Apr 2024 02:42:23 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709061c4100b00a5194b5b932sm62362ejg.16.2024.04.04.02.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:42:22 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 2/3] x86/percpu: Rewrite x86_this_cpu_test_bit() and friends as macros
Date: Thu,  4 Apr 2024 11:42:02 +0200
Message-ID: <20240404094218.448963-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404094218.448963-1-ubizjak@gmail.com>
References: <20240404094218.448963-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the whole family of x86_this_cpu_test_bit() functions
as macros, so standard __my_cpu_var() and raw_cpu_read() macros
can be used on percpu variables. This approach considerably
simplifies implementation of functions and also introduces
standard checks on accessed percpu variables.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2: Split from the original v1 patch.
---
 arch/um/include/asm/cpufeature.h  |  3 +-
 arch/x86/include/asm/cpufeature.h |  3 +-
 arch/x86/include/asm/percpu.h     | 54 +++++++++++++------------------
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
index 66fe06db872f..1eb8b834fbec 100644
--- a/arch/um/include/asm/cpufeature.h
+++ b/arch/um/include/asm/cpufeature.h
@@ -38,8 +38,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define this_cpu_has(bit)						\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
-	 x86_this_cpu_test_bit(bit,					\
-		(unsigned long __percpu *)&cpu_info.x86_capability))
+	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index f95e1c8b7c01..7d527467ab9c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -127,8 +127,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define this_cpu_has(bit)						\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
-	 x86_this_cpu_test_bit(bit,					\
-		(unsigned long __percpu *)&cpu_info.x86_capability))
+	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
 
 /*
  * This macro is for detection of features which need kernel
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index cbfbbe836ee2..d6ff0db32209 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -96,7 +96,7 @@
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr)*)(__force uintptr_t)(ptr)
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
 #define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
@@ -568,37 +568,29 @@ do {									\
 #define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
 #endif
 
-static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
-                        const unsigned long __percpu *addr)
-{
-	unsigned long __percpu *a =
-		(unsigned long __percpu *)addr + nr / BITS_PER_LONG;
+#define x86_this_cpu_constant_test_bit(_nr, _var)			\
+({									\
+	unsigned long __percpu *addr__ =				\
+		(unsigned long __percpu *)&(_var) + ((_nr) / BITS_PER_LONG); \
+	!!((1UL << ((_nr) % BITS_PER_LONG)) & raw_cpu_read(*addr__));	\
+})
 
-#ifdef CONFIG_X86_64
-	return ((1UL << (nr % BITS_PER_LONG)) & raw_cpu_read_8(*a)) != 0;
-#else
-	return ((1UL << (nr % BITS_PER_LONG)) & raw_cpu_read_4(*a)) != 0;
-#endif
-}
-
-static inline bool x86_this_cpu_variable_test_bit(int nr,
-                        const unsigned long __percpu *addr)
-{
-	bool oldbit;
-
-	asm volatile("btl %[nr], " __percpu_arg([var])
-			CC_SET(c)
-			: CC_OUT(c) (oldbit)
-			: [var] "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))),
-			  [nr] "Ir" (nr));
-
-	return oldbit;
-}
-
-#define x86_this_cpu_test_bit(nr, addr)			\
-	(__builtin_constant_p((nr))			\
-	 ? x86_this_cpu_constant_test_bit((nr), (addr))	\
-	 : x86_this_cpu_variable_test_bit((nr), (addr)))
+#define x86_this_cpu_variable_test_bit(_nr, _var)		\
+({								\
+	bool oldbit;						\
+								\
+	asm volatile("btl %[nr], " __percpu_arg([var])		\
+		     CC_SET(c)					\
+		     : CC_OUT(c) (oldbit)			\
+		     : [var] "m" (__my_cpu_var(_var)),		\
+		       [nr] "rI" (_nr));			\
+	oldbit;							\
+})
+
+#define x86_this_cpu_test_bit(_nr, _var)			\
+	(__builtin_constant_p(_nr)				\
+	 ? x86_this_cpu_constant_test_bit(_nr, _var)		\
+	 : x86_this_cpu_variable_test_bit(_nr, _var))
 
 
 #include <asm-generic/percpu.h>
-- 
2.44.0


