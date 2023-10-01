Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5673E7B478B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjJANQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjJANQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:16:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9EB8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:16:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso2167839066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696166196; x=1696770996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qamY6WyojZk0Zj2T/3tRAPkmbEH4lz9al7O5t6kqV54=;
        b=H1G09yVBQ44Actd6QwTMkGczEtqfw2iknnYzQm3L7FmyD0M7zYpOAg8ucLQQI1OijJ
         mzIn0FmoQI5E7PzwMS9x38U/zy6unKyErjqSIL5VdM28TVvesTduHsOwgL+ST+DMCzJj
         +bTaFvnJi6H85DuAUDZ5JJg7TbS95cmL8YBXGHR728xu/lqar5yuwAkHxbiYh5mf7qGI
         rgSEohvmHh2T12gxcCcTnp3f97sofV8iseeuIi3ddHIWCB6T+1GctxL/eJuhpPmnlfz1
         gegRSJKN3+kUYa2vuLrFtJddXK7rb5Gv7/PhCkKLYnXPcA/eZKtSFsOAiBCmvXXYBJ8z
         mOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166196; x=1696770996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qamY6WyojZk0Zj2T/3tRAPkmbEH4lz9al7O5t6kqV54=;
        b=u8Hs4TI42BfxrS9C23TkeK/HAU/WYLFocgUZvRTBM4oQM9Jag3ysx7jjQ+Eejj7cIw
         pe3ELXBkzQd9jCoAWBYBEUqJkGLFpMMdySW14nFqI+9icncd8TcRbO3DPDsjrvEkBYji
         vh4n71kariPbKavKAIDki4f+uQDgQRjMbjKNW8n0ggefGYiew03T5YXvI4I0tRVNM6hN
         nBIAcvYxQtRLotejIsXOo1K0WjiwsMuMrxcnH+71VD5KGXPO//Ub52WhOGD3y3X9pUus
         FpZjnL1jdB/PPp/saxgZvdXojPwgwIPTeqshJxBRNQFZ2OyNC5YF2oaIhMUmGLUY5SgG
         IUpA==
X-Gm-Message-State: AOJu0YxGPMJ3Jm+3UX205KTvTvhI8F3PwS7L0tug+Le6PeXZntOQOKJl
        Z0jZbsTgauyktvabQyYRhDHQrn1HOvjcQU+Q
X-Google-Smtp-Source: AGHT+IHRWZurJereLL48r/V2TUF1m5AcurnyEwrKYdgueDjw8zZWEiuBO0v7J8Q+dP/7Kfo3Ce+5ww==
X-Received: by 2002:a17:907:770e:b0:9ae:738b:86d0 with SMTP id kw14-20020a170907770e00b009ae738b86d0mr8701612ejc.66.1696166196167;
        Sun, 01 Oct 2023 06:16:36 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b0099d798a6bb5sm15504272ejb.67.2023.10.01.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:16:35 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH 1/4] x86/percpu: Update arch/x86/include/asm/percpu.h to the current tip
Date:   Sun,  1 Oct 2023 15:14:33 +0200
Message-ID: <20231001131620.112484-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001131620.112484-1-ubizjak@gmail.com>
References: <20231001131620.112484-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a convenient patch that brings current mainline version
of arch/x86/include/asm/percpu.h to the version in the current tip tree.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 110 ++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 34734d730463..20624b80f890 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,25 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#define percpu_try_cmpxchg_op(size, qual, _var, _ovalp, _nval)		\
+({									\
+	bool success;							\
+	__pcpu_type_##size *pco_oval__ = (__pcpu_type_##size *)(_ovalp); \
+	__pcpu_type_##size pco_old__ = *pco_oval__;			\
+	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+				    __percpu_arg([var]))		\
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [oval] "+a" (pco_old__),				\
+		    [var] "+m" (_var)					\
+		  : [nval] __pcpu_reg_##size(, pco_new__)		\
+		  : "memory");						\
+	if (unlikely(!success))						\
+		*pco_oval__ = pco_old__;				\
+	likely(success);						\
+})
+
 #if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
 #define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
 ({									\
@@ -223,26 +242,63 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  : [var] "+m" (_var),					\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
-		    "c" (new__.high)					\
-		  : "memory", "esi");					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
 									\
 	old__.var;							\
 })
 
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
 #define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+
+#define percpu_try_cmpxchg64_op(size, qual, _var, _ovalp, _nval)	\
+({									\
+	bool success;							\
+	u64 *_oval = (u64 *)(_ovalp);					\
+	union {								\
+		u64 var;						\
+		struct {						\
+			u32 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = *_oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
+			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
+	if (unlikely(!success))						\
+		*_oval = old__.var;					\
+	likely(success);						\
+})
+
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg64_op(8,         , pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg64_op(8, volatile, pcp, ovalp, nval)
 #endif
 
 #ifdef CONFIG_X86_64
 #define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
 #define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
 
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg_op(8,         , pcp, ovalp, nval);
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval);
+
 #define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
 ({									\
 	union {								\
@@ -255,20 +311,54 @@ do {									\
 	old__.var = _oval;						\
 	new__.var = _nval;						\
 									\
-	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  : [var] "+m" (_var),					\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
-		    "c" (new__.high)					\
-		  : "memory", "rsi");					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
 									\
 	old__.var;							\
 })
 
 #define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
 #define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+
+#define percpu_try_cmpxchg128_op(size, qual, _var, _ovalp, _nval)	\
+({									\
+	bool success;							\
+	u128 *_oval = (u128 *)(_ovalp);					\
+	union {								\
+		u128 var;						\
+		struct {						\
+			u64 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = *_oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
+			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		  CC_SET(z)						\
+		  : CC_OUT(z) (success),				\
+		    [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high),					\
+		    "S" (&(_var))					\
+		  : "memory");						\
+	if (unlikely(!success))						\
+		*_oval = old__.var;					\
+	likely(success);						\
+})
+
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16,         , pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16, volatile, pcp, ovalp, nval)
 #endif
 
 /*
@@ -343,6 +433,9 @@ do {									\
 #define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
 #define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
 #define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, , pcp, ovalp, nval)
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
@@ -350,6 +443,9 @@ do {									\
 #define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
+#define this_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, volatile, pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, volatile, pcp, ovalp, nval)
+#define this_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, volatile, pcp, ovalp, nval)
 
 /*
  * Per cpu atomic 64 bit operations are only available under 64 bit.
@@ -364,6 +460,7 @@ do {									\
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
@@ -373,6 +470,7 @@ do {									\
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
+#define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 #endif
 
 static __always_inline bool x86_this_cpu_constant_test_bit(unsigned int nr,
-- 
2.41.0

