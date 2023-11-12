Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3B7E8EC2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjKLGS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjKLGSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:18:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DC47AB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC5C433C7;
        Sun, 12 Nov 2023 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769880;
        bh=nL7iDuDhY95l52l/CjM7hbY+3m/GNRO3MBYY0dX3WHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPbNX3VW6Wt4eQeItvPkn01OM6G1EIx3FnWK8VeBrKuI9rgxBaf5VRbXsrchYPGct
         LSLCVQkzLfG8/4xG035kAhK9C685tNhXpTe0magt/gSOZrI5LWkGvfePLULoH6tSMI
         Y53CCQfyFMMYdLTYovZ547xGxNYgAMInBnTzn/bNzBvA/aF9KAsmsgJO10b/EOmjfc
         WU558dZUZSvVwa7pOR3JvsfGhrdVKMmXZIGbGsJu6AW6oFFsaWyHyuM9OXzMUevdyW
         8I+ZWWe6tBeA3ORoOl3R+QgfFlnrOfOSEORIJqU3IjnHERzrwMiQw6e86KPzhjxeDl
         vEBZJfJsIx+BQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 25/38] riscv: s64ilp32: Implement cmpxchg_double
Date:   Sun, 12 Nov 2023 01:15:01 -0500
Message-Id: <20231112061514.2306187-26-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The s64ilp32 has the ability to exclusively load and store (ld/sd)
a pair of words from an address. Then the SLUB can take advantage
of a cmpxchg_double implementation to avoid taking some locks.

This patch provides an implementation of cmpxchg_double for 64-bit
pairs, and activates the logic required for the SLUB to use these
functions (HAVE_ALIGNED_STRUCT_PAGE and HAVE_CMPXCHG_DOUBLE).

Similar commit: 5284e1b4bc8a ("arm64: xchg: Implement
cmpxchg_double")

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig               |  2 ++
 arch/riscv/include/asm/cmpxchg.h | 53 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a45e31ef3b2c..57b98f1990b3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -86,6 +86,7 @@ config RISCV
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
+	select HAVE_ALIGNED_STRUCT_PAGE if SLUB && ARCH_RV64ILP32
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_HUGE_VMAP if MMU && 64BIT && !XIP_KERNEL
@@ -105,6 +106,7 @@ config RISCV
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_CMPXCHG_DOUBLE if ARCH_RV64ILP32
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2f4726d3cfcc..9f48a1da1c0a 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_CMPXCHG_H
 
 #include <linux/bug.h>
+#include <linux/mmdebug.h>
 
 #include <asm/barrier.h>
 #include <asm/fence.h>
@@ -360,4 +361,56 @@
 	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
+#ifdef CONFIG_ARCH_RV64ILP32
+#define system_has_cmpxchg_double()	1
+
+#define __cmpxchg_double_check(ptr1, ptr2)				\
+({									\
+	if (sizeof(*(ptr1)) != 4)					\
+		BUILD_BUG();						\
+	if (sizeof(*(ptr2)) != 4)					\
+		BUILD_BUG();						\
+	VM_BUG_ON((ulong *)(ptr2) - (ulong *)(ptr1) != 1);		\
+	VM_BUG_ON(((ulong)ptr1 & 0x7) != 0);				\
+})
+
+#define __cmpxchg_double(old1, old2, new1, new2, ptr)			\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	register unsigned int __ret;					\
+	u64 __old;							\
+	u64 __new;							\
+	u64 __tmp;							\
+	switch (sizeof(*(ptr))) {					\
+	case 4:								\
+		__old = ((u64)old2 << 32) | (u64)old1;			\
+		__new = ((u64)new2 << 32) | (u64)new1;			\
+		__asm__ __volatile__ (					\
+			"0:	lr.d %0, %2\n"				\
+			"	bne %0, %z3, 1f\n"			\
+			"	sc.d %1, %z4, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			"1:\n"						\
+			: "=&r" (__tmp), "=&r" (__ret), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new)			\
+			: "memory");					\
+		__ret = (__old == __tmp);				\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define arch_cmpxchg_double(ptr1, ptr2, o1, o2, n1, n2)			\
+({									\
+	int __ret;							\
+	__cmpxchg_double_check(ptr1, ptr2);				\
+	__ret = __cmpxchg_double((ulong)(o1), (ulong)(o2),		\
+				 (ulong)(n1), (ulong)(n2),		\
+				  ptr1);				\
+	__ret;								\
+})
+#endif
+
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.36.1

