Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472D27B82B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbjJDOwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbjJDOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:52:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5FCE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:51:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a6190af24aso405625866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696431115; x=1697035915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jISPkvnxHNZ9YOvTMmU4+FmuVTZn4CUvBaU3KXe/pp4=;
        b=KqQhbewGXZw9JCQ10SBY8ctvjbp36URcRYlvjQa/LO6JA47730TRn9Em6cQ6gcuNgm
         jI+mpbosxKDCmt/KrBjdd9Ev3l+FsP7FyZYfeffu02dgYYJzaTKreUAZAzYj4CqSm6Nc
         9uOme2h91TqPWOtmFT9VLSJ3x0mhonCd/xNPOm1AXbfbdtlZGme7OOcYITyXO2rrInZs
         tPskQIbbvxdakTx+4bbkzj5hOJkCNjGFa047Pfm5sAHkHbIJGW4jAsu4Ogvu2z0DNsBS
         6LX/xH1RtebUtoL1Qam+DWXxpljZlHY6S6rsrkX6429E19WjWX7BDJbxIbjdjpq424W0
         KbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696431115; x=1697035915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jISPkvnxHNZ9YOvTMmU4+FmuVTZn4CUvBaU3KXe/pp4=;
        b=XZ/tDAaRnEr/FpYAxVCJ7Nz17S4KrgqAZAgh4d3sAC3oUE6cX6lLcXq9qBRZSRQz1I
         wx+t+Bxmc34u+5qjWMmzqDuyxc5BmAc1cb63rXW3MlKIHZb4SjvIXyTa19K0JwbrVi8l
         9noewd1cfhHn3A2PBbgWT6ol9y3jJkFnEOlWhovJV/cGjP2UM/F22M8NAl8d48i8KvKe
         5qhIflxSAtSZIenKFRcQ3qiySnPF5HVPDGD3/4vhyjAN18V59IGfY1U4D8QmnmWVrHM2
         2ID71DQKRd8kIzJ3SNcmMyT8CMXIE6Le74itvqnZbUz8+JbewcoTwwtddgEkhiwUVSht
         CUrw==
X-Gm-Message-State: AOJu0Yy17VRdmvGmrws54/5w6fwDpHC4k/Fo54szB/mhT3vbppkfIVJ4
        Zcn7ebgtbTtxQtjlL8Yfocw=
X-Google-Smtp-Source: AGHT+IGiD96DBTsW21prvGETGFZNjtbK94NpmrUYyzEZ/qvPHgfOmlZ3XPFsUvGnPRcVmnTm9gw+rw==
X-Received: by 2002:a17:906:305a:b0:9ae:5487:c71c with SMTP id d26-20020a170906305a00b009ae5487c71cmr2098120ejd.49.1696431114973;
        Wed, 04 Oct 2023 07:51:54 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j26-20020a1709064b5a00b009a16975ee5asm2906307ejv.169.2023.10.04.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:51:54 -0700 (PDT)
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
Subject: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
Date:   Wed,  4 Oct 2023 16:49:44 +0200
Message-ID: <20231004145137.86537-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004145137.86537-1-ubizjak@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
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

 110b54:       65 0f b6 05 00 00 00    movzbl %gs:0x0(%rip),%eax
 11ab90:       65 0f b6 15 00 00 00    movzbl %gs:0x0(%rip),%edx
 14484a:       65 0f b7 35 00 00 00    movzwl %gs:0x0(%rip),%esi
 1a08a9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax
 1a08f9:       65 0f b6 43 78          movzbl %gs:0x78(%rbx),%eax

 4ab29a:       65 48 63 15 00 00 00    movslq %gs:0x0(%rip),%rdx
 4be128:       65 4c 63 25 00 00 00    movslq %gs:0x0(%rip),%r12
 547468:       65 48 63 1f             movslq %gs:(%rdi),%rbx
 5474e7:       65 48 63 0a             movslq %gs:(%rdx),%rcx
 54d05d:       65 48 63 0d 00 00 00    movslq %gs:0x0(%rip),%rcx

b) into compares:

 b40804:       65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
 b487e8:       65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
 b6f14c:       65 f6 05 00 00 00 00    testb  $0x1,%gs:0x0(%rip)
 bac1b8:       65 f6 05 00 00 00 00    testb  $0x1,%gs:0x0(%rip)
 df2244:       65 f7 05 00 00 00 00    testl  $0xff00,%gs:0x0(%rip)

 9a7517:       65 80 3d 00 00 00 00    cmpb   $0x0,%gs:0x0(%rip)
 b282ba:       65 44 3b 35 00 00 00    cmp    %gs:0x0(%rip),%r14d
 b48f61:       65 66 83 3d 00 00 00    cmpw   $0x8,%gs:0x0(%rip)
 b493fe:       65 80 38 00             cmpb   $0x0,%gs:(%rax)
 b73867:       65 66 83 3d 00 00 00    cmpw   $0x8,%gs:0x0(%rip)

c) into other insns:

 65ec02:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx
 6c98ac:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx
 9aafaf:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx
 b45868:       65 0f 48 35 00 00 00    cmovs  %gs:0x0(%rip),%esi
 d276f8:       65 0f 44 15 00 00 00    cmove  %gs:0x0(%rip),%edx

The above propagations result in the following code size
improvements for current mainline kernel (with the default config),
compiled with

gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1)

   text    data     bss     dec     hex filename
25508862        4386540  808388 30703790        1d480ae vmlinux-vanilla.o
25500922        4386532  808388 30695842        1d461a2 vmlinux-new.o

The conversion of other read-modify-write instructions does not bring us any
benefits, the compiler has some problems when constructing RMW instructions
from the generic code and easily misses some opportunities.

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

