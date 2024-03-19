Return-Path: <linux-kernel+bounces-107401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C987FBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37DE1F22D01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3207E586;
	Tue, 19 Mar 2024 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQVW28hu"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858485787B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845069; cv=none; b=Rj3l+SfcFGv5ulqeh/YOdJxUDBjgbEfPYY9T18x6gjfLPDotf1Eh+1ebyfP7Q6eV8vLl1foJxdmDHXacWFhLsGJHY0S0TBrOtiDwkzFKVF3hAX2sUulWHKHbmN0epV7bBYTXycJ6ioOW9BDKQ19v1kxOB7HlXGI+x+ySvzIlIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845069; c=relaxed/simple;
	bh=KzkEZj5kjdNgQUHGE9x0UalB7ACNVeen+2pef2ya1lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVB2KjCzPDTsNbV6AcWsPJ2BKsZdSHMLoFPlhBS601V95EAo2GetDL2eeJllPrhbfcjh3SzSLWqtgiM/LJmGLkLiwJH9K3358NYZIC8qQjCDYuKxO2Ir9Gs9WfKCXmvyat4SE2jGqrdZcvj1zByqyo3gn8Qgxfw3dWNZar8wBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQVW28hu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44f2d894b7so631889866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710845066; x=1711449866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2+B+/6TvQSh2U7p54Yz9mx2QZSgsrHUBHDYCmp6npA=;
        b=lQVW28huyIKzG004ox8DNn0weA2iZK0mgyaTby9fhlcopC6QcveZQIAmtKxwcpZFdS
         48+ueW0HelgBD4dPwPJcOlPaFipb0Rl7/pCFQBq0ysN32uFnhO3u9vygF6LGV5OUa4VU
         32BGLWL7ruTTbQRy4R5uBq/8o1MYdy1I2DXKhZEzJkHT01TtQnKOQXRwpasb5wLRPZRE
         oF4wFsYGjzs9z8zGgAC9iNtZEn/nWD2XPvt0bx8qqciQJqe5NDsPEV1Hop09E+C0IL7S
         C8NCZpdUp6+CFv0uBO5NFcqSKdxpJDFmptwMwcftaGox/QJEz8sTnYp+fNkBtqK/qhx9
         8cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845066; x=1711449866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2+B+/6TvQSh2U7p54Yz9mx2QZSgsrHUBHDYCmp6npA=;
        b=ocSkSA45/oBqLw+7BW4Dfm+S5pl0FG6wp7D+pg4UJkYvku2QK6qpJ5n8LBK+oObB6x
         20NMgapSmJh4w8K0FF3/sZ7zf+SGpBOWPjnTwk8j6VaiXcYpYihx5qpkJHFox0BLnLtn
         sDCvNDVyhOLW/1wdx0tWp/IGK8RXoAZhhRgeiGz5ri6syXqeTUbcAA/ToYKwnTl1vuKY
         eJcutURvRdQCLult0pD6ItP/5mHeTtVNbvA1gHaxSq19kq1ZLxnM4Qv6XsmJsB0Yk5sT
         +/N3b8Lg9+poekOR2CC8J4QhjG9MAMGOWcUcv3hKExMvO8sfwZnxZgMDgWQ6y9ZOXdvt
         tY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBtFkp0F9auv8c5EWj8PZNGn8d2bPblJzWIV+ulQtmB/sZUJ2Kd/H52pqM5A+mI2S9mwQtyC6wCLPERMtw5tp3umP2BtUhM0oy0KKv
X-Gm-Message-State: AOJu0YymfDbx8v2DTP4GyF0roqHodN4igvJWRgK9Dq484OBAWuCEScG+
	OEQqRc+P3LxuPZAkdH//8xLBLIbCES0B5vjsei2HxJwsgs+106+Q
X-Google-Smtp-Source: AGHT+IEPTzIUpYNUzp6JhPNvECH1uHKE5tlPkhdtd9O44FZ40Y1tIHuMv7goCbhPtlJCG1wAIvoZrg==
X-Received: by 2002:a17:906:d8c:b0:a46:181f:c1c3 with SMTP id m12-20020a1709060d8c00b00a46181fc1c3mr9153255eji.70.1710845065901;
        Tue, 19 Mar 2024 03:44:25 -0700 (PDT)
Received: from 123000256IE.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id bx21-20020a170906a1d500b00a4655976025sm5882342ejb.82.2024.03.19.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:44:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH -tip 2/3] x86/asm: Use %c/%n instead of %P operand modifier in asm templates
Date: Tue, 19 Mar 2024 11:40:13 +0100
Message-ID: <20240319104418.284519-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319104418.284519-1-ubizjak@gmail.com>
References: <20240319104418.284519-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "P" asm operand modifier is a x86 target-specific modifier.

When used with a constant, the "P" modifier emits "cst" instead of
"$cst". This property is currently used to emit the bare constant
without all syntax-specific prefixes.

The generic "c" resp. "n" operand modifier should be used instead.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/boot/main.c               |  4 ++--
 arch/x86/include/asm/alternative.h | 22 +++++++++++-----------
 arch/x86/include/asm/atomic64_32.h |  2 +-
 arch/x86/include/asm/cpufeature.h  |  2 +-
 arch/x86/include/asm/irq_stack.h   |  2 +-
 arch/x86/include/asm/uaccess.h     |  4 ++--
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index c4ea5258ab55..9049f390d834 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -119,8 +119,8 @@ static void init_heap(void)
 	char *stack_end;
 
 	if (boot_params.hdr.loadflags & CAN_USE_HEAP) {
-		asm("leal %P1(%%esp),%0"
-		    : "=r" (stack_end) : "i" (-STACK_SIZE));
+		asm("leal %n1(%%esp),%0"
+		    : "=r" (stack_end) : "i" (STACK_SIZE));
 
 		heap_end = (char *)
 			((size_t)boot_params.hdr.heap_end_ptr + 0x200);
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fcd20c6dc7f9..99432696b181 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -294,10 +294,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, newinstr1 is used.
  * Otherwise, oldinstr is used.
  */
-#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	     \
-			   ft_flags2, input...)				     \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1,     \
-		newinstr2, ft_flags2)					     \
+#define alternative_input_2(oldinstr, newinstr1, ft_flags1, newinstr2,	\
+			   ft_flags2, input...)				\
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, \
+		newinstr2, ft_flags2)					\
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
@@ -307,7 +307,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
+	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -316,12 +316,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
-			   output, input...)				      \
-	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,\
-		"call %P[new2]", ft_flags2)				      \
-		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
+#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2, \
+			   output, input...)				\
+	asm_inline volatile (ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1, \
+		"call %c[new2]", ft_flags2)				\
+		: output, ASM_CALL_CONSTRAINT				\
+		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
 		  [new2] "i" (newfunc2), ## input)
 
 /*
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 3486d91b8595..d510405e4e1d 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -24,7 +24,7 @@ typedef struct {
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define __alternative_atomic64(f, g, out, in...) \
-	asm volatile("call %P[func]" \
+	asm volatile("call %c[func]" \
 		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a1273698fc43..fa938ed96506 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -169,7 +169,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 static __always_inline bool _static_cpu_has(u16 bit)
 {
 	asm goto(
-		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
+		ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
 		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 798183867d78..b71ad173f877 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -100,7 +100,7 @@
 }
 
 #define ASM_CALL_ARG0							\
-	"call %P[__func]				\n"		\
+	"call %c[__func]				\n"		\
 	ASM_REACHABLE
 
 #define ASM_CALL_ARG1							\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 237dc8cdd12b..0f9bab92a43d 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -78,7 +78,7 @@ extern int __get_user_bad(void);
 	int __ret_gu;							\
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
-	asm volatile("call __" #fn "_%P4"				\
+	asm volatile("call __" #fn "_%c4"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (ptr), "i" (sizeof(*(ptr))));		\
@@ -177,7 +177,7 @@ extern void __put_user_nocheck_8(void);
 	__chk_user_ptr(__ptr);						\
 	__ptr_pu = __ptr;						\
 	__val_pu = __x;							\
-	asm volatile("call __" #fn "_%P[size]"				\
+	asm volatile("call __" #fn "_%c[size]"				\
 		     : "=c" (__ret_pu),					\
 			ASM_CALL_CONSTRAINT				\
 		     : "0" (__ptr_pu),					\
-- 
2.44.0


