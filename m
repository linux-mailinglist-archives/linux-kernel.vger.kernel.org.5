Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A36E7B8D68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJDTYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjJDTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:24:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3D3A7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:24:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3248aa5cf4eso209795f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696447479; x=1697052279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34+sTfQq8VFq+rqZ/LN8b+9Fd2ulSHVTsGXcANm5iu8=;
        b=Nd3cSlFqckgZEOtsKZnfOUN/A/nHKbe9lkQEpeABypFIxp4WJCGvmbw4u5ghToKaC4
         4NMUC9Ca2oJ5+Z7i3ubz2Qxc1qlHmvDEwU+p6oqBsjZ9k7iGFacJWwOtBP//jua1K5t8
         RL+k0+h38kfIKBPz3ewSJmPLAtN+Y4ck+kakZqk/0cmiFXBK0KKaU/z1wQEclr1To4HA
         2EGgYNhK3XvzqOmdCTSj8lBetX/RNsyCYcs53c1yvZiNCW4G/tLWQIAnToClBtainbRi
         RqfMrwisjBr0/KLVlPz4B8Ky3XpmeNKHEV46n+DYUPlRUHSEvPnrdZUz/Zk2sf6oeFsp
         mRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447479; x=1697052279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34+sTfQq8VFq+rqZ/LN8b+9Fd2ulSHVTsGXcANm5iu8=;
        b=eeLJHrrz/Xo4PMWHw/t0ACn98W6oO7PGtKIovOkfwCDvdQyr5ZL+UgJPfZdztox3ja
         TFMxq0CuMUvnXdsbfmPdeGtACXAWtDV8mpD6dvdddrwOOf/nBsZAn4RQQWIeIVYsfPT4
         uZzLRHc6CFcqq0j87mDbOKgwWkWKQlBm2DpHW07flQDu29zspga8j+IeV1mgeBwzyOQ0
         IqXLzrEgIgSBxSgzGhyOr1GNGnV3UKyXyGEussDSaHBpkEdNa/MReH/JQso8NCyLbeud
         yes5vanYac6tG8+s9bZP1lTdVaaWB3vuMDQpzU1U3Iv6c/bu6Hu8va9feEFRhTkAMW65
         hREQ==
X-Gm-Message-State: AOJu0YxJo4MCLxxbrUugCmzKdz3HLl/FbH0gVlVkarovtlwXhRVfYMR5
        uPRrLGpggNfwVPdbcBdmdlc=
X-Google-Smtp-Source: AGHT+IHB+L2cfLZNXgHNFo7sCGDVz2G16YUx5ZgPm9mbGNJS7eE8jgY+a7lcGEpVlVhYrVnUaw6QhA==
X-Received: by 2002:adf:fccd:0:b0:323:20a7:94d with SMTP id f13-20020adffccd000000b0032320a7094dmr2916232wrs.50.1696447478727;
        Wed, 04 Oct 2023 12:24:38 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090627c900b009ad8084e08asm3230390ejc.0.2023.10.04.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:24:38 -0700 (PDT)
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
Subject: [PATCH v2 4/4] x86/percpu: Use C for percpu read/write accessors
Date:   Wed,  4 Oct 2023 21:23:08 +0200
Message-ID: <20231004192404.31733-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZR2U4DLycLT5xFH6@gmail.com>
References: <ZR2U4DLycLT5xFH6@gmail.com>
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

The percpu code mostly uses inline assembly. Using segment qualifiers
allows to use C code instead, which enables the compiler to perform
various optimizations (e.g. propagation of memory arguments). Convert
percpu read and write accessors to C code, so the memory argument can
be propagated to the instruction that uses this argument.

Some examples of propagations:

a) into sign/zero extensions:

the code improves from:

 65 8a 05 00 00 00 00    mov    %gs:0x0(%rip),%al
 0f b6 c0                movzbl %al,%eax

to:

 65 0f b6 05 00 00 00    movzbl %gs:0x0(%rip),%eax
 00

and in a similar way for:

    movzbl %gs:0x0(%rip),%edx
    movzwl %gs:0x0(%rip),%esi
    movzbl %gs:0x78(%rbx),%eax

    movslq %gs:0x0(%rip),%rdx
    movslq %gs:(%rdi),%rbx

b) into compares:

the code improves from:

 65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax
 a9 00 00 0f 00          test   $0xf0000,%eax

to:

 65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
 00 00 0f 00

and in a similar way for:

    testl  $0xf0000,%gs:0x0(%rip)
    testb  $0x1,%gs:0x0(%rip)
    testl  $0xff00,%gs:0x0(%rip)

    cmpb   $0x0,%gs:0x0(%rip)
    cmp    %gs:0x0(%rip),%r14d
    cmpw   $0x8,%gs:0x0(%rip)
    cmpb   $0x0,%gs:(%rax)

c) into other insns:

the code improves from:

   1a355:	83 fa ff             	cmp    $0xffffffff,%edx
   1a358:	75 07                	jne    1a361 <...>
   1a35a:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx
   1a361:

to:

   1a35a:	83 fa ff             	cmp    $0xffffffff,%edx
   1a35d:	65 0f 44 15 00 00 00 	cmove  %gs:0x0(%rip),%edx
   1a364:	00

The above propagations result in the following code size
improvements for current mainline kernel (with the default config),
compiled with

gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1)

   text    data     bss     dec     hex filename
25508862        4386540  808388 30703790        1d480ae vmlinux-vanilla.o
25500922        4386532  808388 30695842        1d461a2 vmlinux-new.o

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
Co-developed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Rewrite code examples in the commit message.
---
 arch/x86/include/asm/percpu.h | 65 +++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index da451202a1b9..60ea7755c0fe 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -400,13 +400,66 @@ do {									\
 #define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+
+#define __raw_cpu_read(qual, pcp)					\
+({									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
+})
+
+#define __raw_cpu_write(qual, pcp, val)					\
+do {									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
+} while (0)
+
+#define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(, pcp, val)
+
+#define this_cpu_read_1(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_read_2(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_read_4(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_write_1(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_write_2(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_write_4(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+
+#ifdef CONFIG_X86_64
+#define raw_cpu_read_8(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(, pcp, val)
+
+#define this_cpu_read_8(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_write_8(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#endif
+
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
 #define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
-
 #define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
 #define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
 #define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
+
+#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
+
+#ifdef CONFIG_X86_64
+#define raw_cpu_read_8(pcp)		percpu_from_op(8, , "mov", pcp)
+#define raw_cpu_write_8(pcp, val)	percpu_to_op(8, , "mov", (pcp), val)
+
+#define this_cpu_read_8(pcp)		percpu_from_op(8, volatile, "mov", pcp)
+#define this_cpu_write_8(pcp, val)	percpu_to_op(8, volatile, "mov", (pcp), val)
+#endif
+
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
@@ -432,12 +485,6 @@ do {									\
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
-#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
 #define this_cpu_add_1(pcp, val)	percpu_add_op(1, volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(2, volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(4, volatile, (pcp), val)
@@ -476,8 +523,6 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op(8, , "mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
@@ -486,8 +531,6 @@ do {									\
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
 #define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
-#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
-- 
2.41.0

