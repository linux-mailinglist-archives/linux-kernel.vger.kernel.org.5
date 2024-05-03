Return-Path: <linux-kernel+bounces-167366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E18BA87C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7111C21C83
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE5152188;
	Fri,  3 May 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTUH4wmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4015216B;
	Fri,  3 May 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723964; cv=none; b=aANFWPqEsudQ1K+lv0RnMo6iNSKNiI6HdLaPs+xssEivN4DTOYHyak1c3N+azgLEZfPQ5CrNNatZtq69TH8ueUMbJb22dy1jzpJN9jKInQLLAtCEhH8U0OwJwtyxmvdsQKCZdKP48e6j4zA8hg3KXpO2U70wgYWSsMs0R0UzOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723964; c=relaxed/simple;
	bh=8DzD5xjamkLb+D2d+JZVSOF0ZvcIqg4LyT6EvpU7YJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBhKGwhXS+hve0rdfHK1+CtU33SfVKeBRLG3+ZN4OeUHSIcrnVlpbIBCRpgk4hDqZuqvI8mjm+YDep6MrhUn+rguwTocE2fQxkPg0+urVNHDSgRAVpJJr/vCCSIcN15fWGLQfgEefa+xrSoCZZaxynjSp9w7Ds4V7FF9qGuTuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTUH4wmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87FBC4AF1A;
	Fri,  3 May 2024 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723964;
	bh=8DzD5xjamkLb+D2d+JZVSOF0ZvcIqg4LyT6EvpU7YJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTUH4wmMv7uLiGnXXaSy/zUsYEh3f0AjtF2R+NkW2/sArMfVji8IdyWBIFKL2ccfr
	 vlTApxgfpiIbzru/ftLeA4ty9rCwRpkUFn30FYTxzh1+wCOr45H98cGUIER9AXxD0j
	 c9Mid8cAgYpBhHasKCHKydGaySZhoOFogtascxOe4xQUZQfsvcpmrxbtPOXiw+AGTg
	 m45j1NsQs2c3JbkpLexYwyFdRpnDGFbvR6V3V6EEyPaNhEk8Eba0RVNsQCaaK6P8kd
	 oubyebjkrTT0/mSfkPAl3LPpHmFttnibQOGJ3IvS/uOq3SmaqeOvXzPJNw1GcytTpQ
	 x2+8ZQPIS2vvw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] alpha: drop pre-EV56 support
Date: Fri,  3 May 2024 10:11:25 +0200
Message-Id: <20240503081125.67990-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All EV4 machines are already gone, and the remaining EV5 based machines
all support the slightly more modern EV56 generation as well.
Debian only supports EV56 and later.

Drop both of these and build kernels optimized for EV56 and higher
when the "generic" options is selected, tuning for an out-of-order
EV6 pipeline, same as Debian userspace.

Since this was the only supported architecture without 8-bit and
16-bit stores, common kernel code no longer has to worry about
aligning struct members, and existing workarounds from the block
and tty layers can be removed.

The alpha memory management code no longer needs an abstraction
for the differences between EV4 and EV5+.

Link: https://lists.debian.org/debian-alpha/2023/05/msg00009.html
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/Kconfig                     | 21 +------
 arch/alpha/Makefile                    |  8 +--
 arch/alpha/include/asm/elf.h           |  4 +-
 arch/alpha/include/asm/machvec.h       |  9 ---
 arch/alpha/include/asm/mmu_context.h   | 45 +--------------
 arch/alpha/include/asm/special_insns.h |  5 +-
 arch/alpha/include/asm/tlbflush.h      | 41 +------------
 arch/alpha/include/asm/uaccess.h       | 80 --------------------------
 arch/alpha/include/uapi/asm/compiler.h | 18 ------
 arch/alpha/kernel/machvec_impl.h       | 25 +-------
 arch/alpha/kernel/traps.c              | 31 ----------
 include/linux/blk_types.h              |  6 --
 include/linux/tty.h                    | 14 ++---
 13 files changed, 19 insertions(+), 288 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 7987bb548652..50ff06d5b799 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -240,29 +240,14 @@ config ISA_DMA_API
 	bool
 	default y
 
-config ALPHA_EV4
-	bool
-
-config ALPHA_EV5
-	bool
-	default y if ALPHA_RX164 || ALPHA_RAWHIDE || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_SABLE || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_EB164 || ALPHA_ALCOR
-
 config ALPHA_CIA
 	bool
 	depends on ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_ALCOR
 	default y
 
 config ALPHA_EV56
-	bool "EV56 CPU (speed >= 366MHz)?" if ALPHA_ALCOR
-	default y if ALPHA_RX164 || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_PC164 || ALPHA_TAKARA
-
-config ALPHA_EV56
-	prompt "EV56 CPU (speed >= 333MHz)?"
-	depends on ALPHA_NORITAKE || ALPHA_MIKASA
-
-config ALPHA_EV56
-	prompt "EV56 CPU (speed >= 400MHz)?"
-	depends on ALPHA_RAWHIDE
+	bool
+	default y if ALPHA_ALCOR || ALPHA_RX164 || ALPHA_MIATA || ALPHA_LX164 || ALPHA_SX164 || ALPHA_RUFFIAN || ALPHA_PC164 || ALPHA_TAKARA || ALPHA_NORITAKE || ALPHA_MIKASA || ALPHA_RAWHIDE || ALPHA_SABLE
 
 config ALPHA_T2
 	bool
@@ -403,7 +388,7 @@ config ARCH_SPARSEMEM_ENABLE
 config ALPHA_WTINT
 	bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
 	default y if ALPHA_QEMU
-	default n if ALPHA_EV5 || ALPHA_EV56
+	default n if ALPHA_EV56
 	default n if !ALPHA_SRM && !ALPHA_GENERIC
 	default y if SMP
 	help
diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
index 45158024085e..35445ff2e489 100644
--- a/arch/alpha/Makefile
+++ b/arch/alpha/Makefile
@@ -15,18 +15,14 @@ CHECKFLAGS	+= -D__alpha__
 cflags-y	:= -pipe -mno-fp-regs -ffixed-8
 cflags-y	+= $(call cc-option, -fno-jump-tables)
 
-cpuflags-$(CONFIG_ALPHA_EV4)		:= -mcpu=ev4
-cpuflags-$(CONFIG_ALPHA_EV5)		:= -mcpu=ev5
 cpuflags-$(CONFIG_ALPHA_EV56)		:= -mcpu=ev56
 cpuflags-$(CONFIG_ALPHA_POLARIS)	:= -mcpu=pca56
 cpuflags-$(CONFIG_ALPHA_SX164)		:= -mcpu=pca56
 cpuflags-$(CONFIG_ALPHA_EV6)		:= -mcpu=ev6
 cpuflags-$(CONFIG_ALPHA_EV67)		:= -mcpu=ev67
 # If GENERIC, make sure to turn off any instruction set extensions that
-# the host compiler might have on by default.  Given that EV4 and EV5
-# have the same instruction set, prefer EV5 because an EV5 schedule is
-# more likely to keep an EV4 processor busy than vice-versa.
-cpuflags-$(CONFIG_ALPHA_GENERIC)	:= -mcpu=ev5
+# the host compiler might have on by default.
+cpuflags-$(CONFIG_ALPHA_GENERIC)	:= -mcpu=ev56 -mtune=ev6
 
 cflags-y				+= $(cpuflags-y)
 
diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
index e6da23f1da83..4d7c46f50382 100644
--- a/arch/alpha/include/asm/elf.h
+++ b/arch/alpha/include/asm/elf.h
@@ -133,9 +133,7 @@ extern int dump_elf_task(elf_greg_t *dest, struct task_struct *task);
 #define ELF_PLATFORM				\
 ({						\
 	enum implver_enum i_ = implver();	\
-	( i_ == IMPLVER_EV4 ? "ev4"		\
-	: i_ == IMPLVER_EV5			\
-	  ? (amask(AMASK_BWX) ? "ev5" : "ev56")	\
+	( i_ == IMPLVER_EV5 ? "ev56"			\
 	: amask (AMASK_CIX) ? "ev6" : "ev67");	\
 })
 
diff --git a/arch/alpha/include/asm/machvec.h b/arch/alpha/include/asm/machvec.h
index 8623f995d34c..490fc880bb3f 100644
--- a/arch/alpha/include/asm/machvec.h
+++ b/arch/alpha/include/asm/machvec.h
@@ -72,15 +72,6 @@ struct alpha_machine_vector
 	int (*mv_is_ioaddr)(unsigned long);
 	int (*mv_is_mmio)(const volatile void __iomem *);
 
-	void (*mv_switch_mm)(struct mm_struct *, struct mm_struct *,
-			     struct task_struct *);
-	void (*mv_activate_mm)(struct mm_struct *, struct mm_struct *);
-
-	void (*mv_flush_tlb_current)(struct mm_struct *);
-	void (*mv_flush_tlb_current_page)(struct mm_struct * mm,
-					  struct vm_area_struct *vma,
-					  unsigned long addr);
-
 	void (*update_irq_hw)(unsigned long, unsigned long, int);
 	void (*ack_irq)(unsigned long);
 	void (*device_interrupt)(unsigned long vector);
diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 29a3e3a1f02b..eee8fe836a59 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -71,9 +71,7 @@ __reload_thread(struct pcb_struct *pcb)
 #ifdef CONFIG_ALPHA_GENERIC
 # define MAX_ASN	(alpha_mv.max_asn)
 #else
-# ifdef CONFIG_ALPHA_EV4
-#  define MAX_ASN	EV4_MAX_ASN
-# elif defined(CONFIG_ALPHA_EV5)
+# if defined(CONFIG_ALPHA_EV56)
 #  define MAX_ASN	EV5_MAX_ASN
 # else
 #  define MAX_ASN	EV6_MAX_ASN
@@ -162,26 +160,6 @@ ev5_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
 	task_thread_info(next)->pcb.asn = mmc & HARDWARE_ASN_MASK;
 }
 
-__EXTERN_INLINE void
-ev4_switch_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm,
-	      struct task_struct *next)
-{
-	/* As described, ASN's are broken for TLB usage.  But we can
-	   optimize for switching between threads -- if the mm is
-	   unchanged from current we needn't flush.  */
-	/* ??? May not be needed because EV4 PALcode recognizes that
-	   ASN's are broken and does a tbiap itself on swpctx, under
-	   the "Must set ASN or flush" rule.  At least this is true
-	   for a 1992 SRM, reports Joseph Martin (jmartin@hlo.dec.com).
-	   I'm going to leave this here anyway, just to Be Sure.  -- r~  */
-	if (prev_mm != next_mm)
-		tbiap();
-
-	/* Do continue to allocate ASNs, because we can still use them
-	   to avoid flushing the icache.  */
-	ev5_switch_mm(prev_mm, next_mm, next);
-}
-
 extern void __load_new_mm_context(struct mm_struct *);
 asmlinkage void do_page_fault(unsigned long address, unsigned long mmcsr,
 			      long cause, struct pt_regs *regs);
@@ -209,25 +187,8 @@ ev5_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 	__load_new_mm_context(next_mm);
 }
 
-__EXTERN_INLINE void
-ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
-{
-	__load_new_mm_context(next_mm);
-	tbiap();
-}
-
-#ifdef CONFIG_ALPHA_GENERIC
-# define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
-# define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
-#else
-# ifdef CONFIG_ALPHA_EV4
-#  define switch_mm(a,b,c)	ev4_switch_mm((a),(b),(c))
-#  define activate_mm(x,y)	ev4_activate_mm((x),(y))
-# else
-#  define switch_mm(a,b,c)	ev5_switch_mm((a),(b),(c))
-#  define activate_mm(x,y)	ev5_activate_mm((x),(y))
-# endif
-#endif
+#define switch_mm(a,b,c)	ev5_switch_mm((a),(b),(c))
+#define activate_mm(x,y)	ev5_activate_mm((x),(y))
 
 #define init_new_context init_new_context
 static inline int
diff --git a/arch/alpha/include/asm/special_insns.h b/arch/alpha/include/asm/special_insns.h
index ca2c5c30b22e..798d0bdb11f9 100644
--- a/arch/alpha/include/asm/special_insns.h
+++ b/arch/alpha/include/asm/special_insns.h
@@ -15,10 +15,7 @@ enum implver_enum {
    (enum implver_enum) __implver; })
 #else
 /* Try to eliminate some dead code.  */
-#ifdef CONFIG_ALPHA_EV4
-#define implver() IMPLVER_EV4
-#endif
-#ifdef CONFIG_ALPHA_EV5
+#ifdef CONFIG_ALPHA_EV56
 #define implver() IMPLVER_EV5
 #endif
 #if defined(CONFIG_ALPHA_EV6)
diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 94dc37cf873a..02ccac5c5916 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -14,39 +14,12 @@
 extern void __load_new_mm_context(struct mm_struct *);
 
 
-/* Use a few helper functions to hide the ugly broken ASN
-   numbers on early Alphas (ev4 and ev45).  */
-
-__EXTERN_INLINE void
-ev4_flush_tlb_current(struct mm_struct *mm)
-{
-	__load_new_mm_context(mm);
-	tbiap();
-}
-
 __EXTERN_INLINE void
 ev5_flush_tlb_current(struct mm_struct *mm)
 {
 	__load_new_mm_context(mm);
 }
 
-/* Flush just one page in the current TLB set.  We need to be very
-   careful about the icache here, there is no way to invalidate a
-   specific icache page.  */
-
-__EXTERN_INLINE void
-ev4_flush_tlb_current_page(struct mm_struct * mm,
-			   struct vm_area_struct *vma,
-			   unsigned long addr)
-{
-	int tbi_flag = 2;
-	if (vma->vm_flags & VM_EXEC) {
-		__load_new_mm_context(mm);
-		tbi_flag = 3;
-	}
-	tbi(tbi_flag, addr);
-}
-
 __EXTERN_INLINE void
 ev5_flush_tlb_current_page(struct mm_struct * mm,
 			   struct vm_area_struct *vma,
@@ -59,18 +32,8 @@ ev5_flush_tlb_current_page(struct mm_struct * mm,
 }
 
 
-#ifdef CONFIG_ALPHA_GENERIC
-# define flush_tlb_current		alpha_mv.mv_flush_tlb_current
-# define flush_tlb_current_page		alpha_mv.mv_flush_tlb_current_page
-#else
-# ifdef CONFIG_ALPHA_EV4
-#  define flush_tlb_current		ev4_flush_tlb_current
-#  define flush_tlb_current_page	ev4_flush_tlb_current_page
-# else
-#  define flush_tlb_current		ev5_flush_tlb_current
-#  define flush_tlb_current_page	ev5_flush_tlb_current_page
-# endif
-#endif
+#define flush_tlb_current	ev5_flush_tlb_current
+#define flush_tlb_current_page	ev5_flush_tlb_current_page
 
 #ifdef __MMU_EXTERN_INLINE
 #undef __EXTERN_INLINE
diff --git a/arch/alpha/include/asm/uaccess.h b/arch/alpha/include/asm/uaccess.h
index c32c2584c0b7..ef295cbb797c 100644
--- a/arch/alpha/include/asm/uaccess.h
+++ b/arch/alpha/include/asm/uaccess.h
@@ -96,9 +96,6 @@ struct __large_struct { unsigned long buf[100]; };
 		: "=r"(__gu_val), "=r"(__gu_err)	\
 		: "m"(__m(addr)), "1"(__gu_err))
 
-#ifdef __alpha_bwx__
-/* Those lucky bastards with ev56 and later CPUs can do byte/word moves.  */
-
 #define __get_user_16(addr)				\
 	__asm__("1: ldwu %0,%2\n"			\
 	"2:\n"						\
@@ -112,33 +109,6 @@ struct __large_struct { unsigned long buf[100]; };
 	EXC(1b,2b,%0,%1)				\
 		: "=r"(__gu_val), "=r"(__gu_err)	\
 		: "m"(__m(addr)), "1"(__gu_err))
-#else
-/* Unfortunately, we can't get an unaligned access trap for the sub-word
-   load, so we have to do a general unaligned operation.  */
-
-#define __get_user_16(addr)						\
-{									\
-	long __gu_tmp;							\
-	__asm__("1: ldq_u %0,0(%3)\n"					\
-	"2:	ldq_u %1,1(%3)\n"					\
-	"	extwl %0,%3,%0\n"					\
-	"	extwh %1,%3,%1\n"					\
-	"	or %0,%1,%0\n"						\
-	"3:\n"								\
-	EXC(1b,3b,%0,%2)						\
-	EXC(2b,3b,%0,%2)						\
-		: "=&r"(__gu_val), "=&r"(__gu_tmp), "=r"(__gu_err)	\
-		: "r"(addr), "2"(__gu_err));				\
-}
-
-#define __get_user_8(addr)						\
-	__asm__("1: ldq_u %0,0(%2)\n"					\
-	"	extbl %0,%2,%0\n"					\
-	"2:\n"								\
-	EXC(1b,2b,%0,%1)						\
-		: "=&r"(__gu_val), "=r"(__gu_err)			\
-		: "r"(addr), "1"(__gu_err))
-#endif
 
 extern void __put_user_unknown(void);
 
@@ -192,9 +162,6 @@ __asm__ __volatile__("1: stl %r2,%1\n"				\
 		: "=r"(__pu_err)				\
 		: "m"(__m(addr)), "rJ"(x), "0"(__pu_err))
 
-#ifdef __alpha_bwx__
-/* Those lucky bastards with ev56 and later CPUs can do byte/word moves.  */
-
 #define __put_user_16(x, addr)					\
 __asm__ __volatile__("1: stw %r2,%1\n"				\
 	"2:\n"							\
@@ -208,53 +175,6 @@ __asm__ __volatile__("1: stb %r2,%1\n"				\
 	EXC(1b,2b,$31,%0)					\
 		: "=r"(__pu_err)				\
 		: "m"(__m(addr)), "rJ"(x), "0"(__pu_err))
-#else
-/* Unfortunately, we can't get an unaligned access trap for the sub-word
-   write, so we have to do a general unaligned operation.  */
-
-#define __put_user_16(x, addr)					\
-{								\
-	long __pu_tmp1, __pu_tmp2, __pu_tmp3, __pu_tmp4;	\
-	__asm__ __volatile__(					\
-	"1:	ldq_u %2,1(%5)\n"				\
-	"2:	ldq_u %1,0(%5)\n"				\
-	"	inswh %6,%5,%4\n"				\
-	"	inswl %6,%5,%3\n"				\
-	"	mskwh %2,%5,%2\n"				\
-	"	mskwl %1,%5,%1\n"				\
-	"	or %2,%4,%2\n"					\
-	"	or %1,%3,%1\n"					\
-	"3:	stq_u %2,1(%5)\n"				\
-	"4:	stq_u %1,0(%5)\n"				\
-	"5:\n"							\
-	EXC(1b,5b,$31,%0)					\
-	EXC(2b,5b,$31,%0)					\
-	EXC(3b,5b,$31,%0)					\
-	EXC(4b,5b,$31,%0)					\
-		: "=r"(__pu_err), "=&r"(__pu_tmp1), 		\
-		  "=&r"(__pu_tmp2), "=&r"(__pu_tmp3), 		\
-		  "=&r"(__pu_tmp4)				\
-		: "r"(addr), "r"((unsigned long)(x)), "0"(__pu_err)); \
-}
-
-#define __put_user_8(x, addr)					\
-{								\
-	long __pu_tmp1, __pu_tmp2;				\
-	__asm__ __volatile__(					\
-	"1:	ldq_u %1,0(%4)\n"				\
-	"	insbl %3,%4,%2\n"				\
-	"	mskbl %1,%4,%1\n"				\
-	"	or %1,%2,%1\n"					\
-	"2:	stq_u %1,0(%4)\n"				\
-	"3:\n"							\
-	EXC(1b,3b,$31,%0)					\
-	EXC(2b,3b,$31,%0)					\
-		: "=r"(__pu_err), 				\
-	  	  "=&r"(__pu_tmp1), "=&r"(__pu_tmp2)		\
-		: "r"((unsigned long)(x)), "r"(addr), "0"(__pu_err)); \
-}
-#endif
-
 
 /*
  * Complex access routines
diff --git a/arch/alpha/include/uapi/asm/compiler.h b/arch/alpha/include/uapi/asm/compiler.h
index 0e00c0e13374..8c03740966b4 100644
--- a/arch/alpha/include/uapi/asm/compiler.h
+++ b/arch/alpha/include/uapi/asm/compiler.h
@@ -95,24 +95,6 @@
 #define __kernel_ldwu(mem)	(mem)
 #define __kernel_stb(val,mem)	((mem) = (val))
 #define __kernel_stw(val,mem)	((mem) = (val))
-#else
-#define __kernel_ldbu(mem)				\
-  ({ unsigned char __kir;				\
-     __asm__(".arch ev56;				\
-	      ldbu %0,%1" : "=r"(__kir) : "m"(mem));	\
-     __kir; })
-#define __kernel_ldwu(mem)				\
-  ({ unsigned short __kir;				\
-     __asm__(".arch ev56;				\
-	      ldwu %0,%1" : "=r"(__kir) : "m"(mem));	\
-     __kir; })
-#define __kernel_stb(val,mem)				\
-  __asm__(".arch ev56;					\
-	   stb %1,%0" : "=m"(mem) : "r"(val))
-#define __kernel_stw(val,mem)				\
-  __asm__(".arch ev56;					\
-	   stw %1,%0" : "=m"(mem) : "r"(val))
 #endif
 
-
 #endif /* _UAPI__ALPHA_COMPILER_H */
diff --git a/arch/alpha/kernel/machvec_impl.h b/arch/alpha/kernel/machvec_impl.h
index c2ebcb39e589..129ae36b8e6d 100644
--- a/arch/alpha/kernel/machvec_impl.h
+++ b/arch/alpha/kernel/machvec_impl.h
@@ -44,33 +44,14 @@
 
 #define DO_DEFAULT_RTC			.rtc_port = 0x70
 
-#define DO_EV4_MMU							\
-	.max_asn =			EV4_MAX_ASN,			\
-	.mv_switch_mm =			ev4_switch_mm,			\
-	.mv_activate_mm =		ev4_activate_mm,		\
-	.mv_flush_tlb_current =		ev4_flush_tlb_current,		\
-	.mv_flush_tlb_current_page =	ev4_flush_tlb_current_page
-
 #define DO_EV5_MMU							\
-	.max_asn =			EV5_MAX_ASN,			\
-	.mv_switch_mm =			ev5_switch_mm,			\
-	.mv_activate_mm =		ev5_activate_mm,		\
-	.mv_flush_tlb_current =		ev5_flush_tlb_current,		\
-	.mv_flush_tlb_current_page =	ev5_flush_tlb_current_page
+	.max_asn =			EV5_MAX_ASN			\
 
 #define DO_EV6_MMU							\
-	.max_asn =			EV6_MAX_ASN,			\
-	.mv_switch_mm =			ev5_switch_mm,			\
-	.mv_activate_mm =		ev5_activate_mm,		\
-	.mv_flush_tlb_current =		ev5_flush_tlb_current,		\
-	.mv_flush_tlb_current_page =	ev5_flush_tlb_current_page
+	.max_asn =			EV6_MAX_ASN			\
 
 #define DO_EV7_MMU							\
-	.max_asn =			EV6_MAX_ASN,			\
-	.mv_switch_mm =			ev5_switch_mm,			\
-	.mv_activate_mm =		ev5_activate_mm,		\
-	.mv_flush_tlb_current =		ev5_flush_tlb_current,		\
-	.mv_flush_tlb_current_page =	ev5_flush_tlb_current_page
+	.max_asn =			EV6_MAX_ASN			\
 
 #define IO_LITE(UP,low)							\
 	.hae_register =		(unsigned long *) CAT(UP,_HAE_ADDRESS),	\
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index a9a8e9ab0f52..6afae65e9a8b 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -320,32 +320,6 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 		return;
 
 	      case 4: /* opDEC */
-		if (implver() == IMPLVER_EV4) {
-			long si_code;
-
-			/* The some versions of SRM do not handle
-			   the opDEC properly - they return the PC of the
-			   opDEC fault, not the instruction after as the
-			   Alpha architecture requires.  Here we fix it up.
-			   We do this by intentionally causing an opDEC
-			   fault during the boot sequence and testing if
-			   we get the correct PC.  If not, we set a flag
-			   to correct it every time through.  */
-			regs->pc += opDEC_fix; 
-			
-			/* EV4 does not implement anything except normal
-			   rounding.  Everything else will come here as
-			   an illegal instruction.  Emulate them.  */
-			si_code = alpha_fp_emul(regs->pc - 4);
-			if (si_code == 0)
-				return;
-			if (si_code > 0) {
-				send_sig_fault_trapno(SIGFPE, si_code,
-						      (void __user *) regs->pc,
-						      0, current);
-				return;
-			}
-		}
 		break;
 
 	      case 5: /* illoc */
@@ -946,11 +920,6 @@ trap_init(void)
 	register unsigned long gptr __asm__("$29");
 	wrkgp(gptr);
 
-	/* Hack for Multia (UDB) and JENSEN: some of their SRMs have
-	   a bug in the handling of the opDEC fault.  Fix it up if so.  */
-	if (implver() == IMPLVER_EV4)
-		opDEC_check();
-
 	wrent(entArith, 1);
 	wrent(entMM, 2);
 	wrent(entIF, 3);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..c3e098b21c16 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -88,15 +88,9 @@ struct block_device {
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
- * Alpha cannot write a byte atomically, so we need to use 32-bit value.
  */
-#if defined(CONFIG_ALPHA) && !defined(__alpha_bwx__)
-typedef u32 __bitwise blk_status_t;
-typedef u32 blk_short_t;
-#else
 typedef u8 __bitwise blk_status_t;
 typedef u16 blk_short_t;
-#endif
 #define	BLK_STS_OK 0
 #define BLK_STS_NOTSUPP		((__force blk_status_t)1)
 #define BLK_STS_TIMEOUT		((__force blk_status_t)2)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 2b2e6f0a54d6..2372f9357240 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -145,15 +145,12 @@ struct tty_operations;
  * @count: count of open processes, reaching zero cancels all the work for
  *	   this tty and drops a @kref too (but does not free this tty)
  * @winsize: size of the terminal "window" (cf. @winsize_mutex)
- * @flow: flow settings grouped together, see also @flow.unused
+ * @flow: flow settings grouped together
  * @flow.lock: lock for @flow members
  * @flow.stopped: tty stopped/started by stop_tty()/start_tty()
  * @flow.tco_stopped: tty stopped/started by %TCOOFF/%TCOON ioctls (it has
  *		      precedence over @flow.stopped)
- * @flow.unused: alignment for Alpha, so that no members other than @flow.* are
- *		 modified by the same 64b word store. The @flow's __aligned is
- *		 there for the very same reason.
- * @ctrl: control settings grouped together, see also @ctrl.unused
+ * @ctrl: control settings grouped together
  * @ctrl.lock: lock for @ctrl members
  * @ctrl.pgrp: process group of this tty (setpgrp(2))
  * @ctrl.session: session of this tty (setsid(2)). Writes are protected by both
@@ -161,7 +158,6 @@ struct tty_operations;
  *		  them.
  * @ctrl.pktstatus: packet mode status (bitwise OR of %TIOCPKT_ constants)
  * @ctrl.packet: packet mode enabled
- * @ctrl.unused: alignment for Alpha, see @flow.unused for explanation
  * @hw_stopped: not controlled by the tty layer, under @driver's control for CTS
  *		handling
  * @receive_room: bytes permitted to feed to @ldisc without any being lost
@@ -216,8 +212,7 @@ struct tty_struct {
 		spinlock_t lock;
 		bool stopped;
 		bool tco_stopped;
-		unsigned long unused[0];
-	} __aligned(sizeof(unsigned long)) flow;
+	} flow;
 
 	struct {
 		struct pid *pgrp;
@@ -225,8 +220,7 @@ struct tty_struct {
 		spinlock_t lock;
 		unsigned char pktstatus;
 		bool packet;
-		unsigned long unused[0];
-	} __aligned(sizeof(unsigned long)) ctrl;
+	} ctrl;
 
 	bool hw_stopped;
 	bool closing;
-- 
2.39.2


