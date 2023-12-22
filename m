Return-Path: <linux-kernel+bounces-9402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D5B81C508
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812692866E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C17B65B;
	Fri, 22 Dec 2023 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ha0xCEu3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2409468;
	Fri, 22 Dec 2023 06:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63446C433C7;
	Fri, 22 Dec 2023 06:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703226366;
	bh=RcsFW1L2WrpJyYwQYLw00Ia10eHMAhJtzWgVW/ZE2EY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ha0xCEu3Fh1I2oApz9I+MyAz5Gk7OMFZjsCV2IZnqwQx3ubfkKhKFQiHfFp5Zfm6G
	 QVQwM/ORAIbFM/94hwStez9jWsVKVj+Q2KgpktnaLMz38mXITmFoHfSikHPF2Ibv9g
	 WSqBdaI7lmGaJfZQtFSdvo/axxVCSML3njwcQbuQ=
Date: Thu, 21 Dec 2023 22:26:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20231221222605.7295cd886dd551b9bf95d4e9@linux-foundation.org>
In-Reply-To: <20231222111649.7802e7d7@canb.auug.org.au>
References: <20231127144418.54daad5d@canb.auug.org.au>
	<20231222111649.7802e7d7@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 11:16:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Mon, 27 Nov 2023 14:44:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the mm tree, today's linux-next build (sparc64 defconfig)
> > failed like this:
> > 
> > arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
> >   254 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
> > 
>
> ...
>
> > So I turned off -Werrror in the lib directory as well which added this:
> > 
> > arch/sparc/lib/ucmpdi2.c:5:11: warning: no previous prototype for '__ucmpdi2' [-Wmissing-prototypes]
> >     5 | word_type __ucmpdi2(unsigned long long a, unsigned long long b)
> >       |           ^~~~~~~~~
> 
> Is anything being done about the above warnings?

OK, here's sparc64.  I'll do sparc32 in a bit.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: sparc64: fix up fallout from enabling -Wmissing-prototypes
Date: Thu Dec 21 04:33:25 PM PST 2023

Fix sparc64 allmodconfig build errors caused by enabling
-Wmissing-prototypes.

- Symbols only used from assembly were given local prototypes

- A couple of missing inclusions were added

- Define some functions to be static

- vmemmap_free() is only needed if CONFIG_MEMORY_HOTPLUG

- add new arch/sparc/include/asm/irq_work.h for arch_irq_work_raise()

- move prom_cif_init() prototype to header, fix longstanding
  prom_cif_init() borkage.

- various function declarations were moved from .c into shared .h

Fixes: c6345dfa6e3e ("Makefile.extrawarn: turn on missing-prototypes globally")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/sparc/include/asm/floppy_64.h |    4 +++-
 arch/sparc/include/asm/irq_work.h  |   10 ++++++++++
 arch/sparc/include/asm/openprom.h  |    2 ++
 arch/sparc/kernel/adi_64.c         |    6 +++---
 arch/sparc/kernel/asm-offsets.c    |    4 +++-
 arch/sparc/kernel/pci_sun4v.c      |    2 +-
 arch/sparc/kernel/setup_64.c       |    2 +-
 arch/sparc/kernel/time_64.c        |    2 ++
 arch/sparc/kernel/traps_64.c       |    7 ++++---
 arch/sparc/kernel/uprobes.c        |    1 +
 arch/sparc/mm/init_64.c            |    2 ++
 arch/sparc/power/hibernate.c       |    1 +
 arch/sparc/prom/init_64.c          |    2 --
 arch/sparc/prom/misc_64.c          |    2 +-
 arch/sparc/prom/p1275.c            |    2 +-
 arch/sparc/vdso/vclock_gettime.c   |   10 ++++++++++
 arch/sparc/vdso/vma.c              |    2 +-
 drivers/mtd/maps/sun_uflash.c      |    2 +-
 drivers/sbus/char/bbc_i2c.c        |    3 ---
 drivers/sbus/char/bbc_i2c.h        |    3 +++
 20 files changed, 50 insertions(+), 19 deletions(-)

--- a/arch/sparc/vdso/vclock_gettime.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/vdso/vclock_gettime.c
@@ -250,6 +250,8 @@ notrace static int do_monotonic_coarse(s
 	return 0;
 }
 
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+
 notrace int
 __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -278,6 +280,9 @@ int
 clock_gettime(clockid_t, struct __kernel_old_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+int
+__vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts);
+
 notrace int
 __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
 {
@@ -303,6 +308,8 @@ __vdso_clock_gettime_stick(clockid_t clo
 	return vdso_fallback_gettime(clock, ts);
 }
 
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+
 notrace int
 __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
@@ -339,6 +346,9 @@ int
 gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
+int
+__vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz);
+
 notrace int
 __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
--- a/arch/sparc/kernel/asm-offsets.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/asm-offsets.c
@@ -19,6 +19,7 @@
 #include <asm/hibernate.h>
 
 #ifdef CONFIG_SPARC32
+int sparc32_foo(void);
 int sparc32_foo(void)
 {
 	DEFINE(AOFF_thread_fork_kpsr,
@@ -26,6 +27,7 @@ int sparc32_foo(void)
 	return 0;
 }
 #else
+int sparc64_foo(void);
 int sparc64_foo(void)
 {
 #ifdef CONFIG_HIBERNATION
@@ -45,6 +47,7 @@ int sparc64_foo(void)
 }
 #endif
 
+int foo(void);
 int foo(void)
 {
 	BLANK();
@@ -57,4 +60,3 @@ int foo(void)
 	/* DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28); */
 	return 0;
 }
-
--- a/arch/sparc/prom/misc_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/prom/misc_64.c
@@ -162,7 +162,7 @@ unsigned char prom_get_idprom(char *idbu
 	return 0xff;
 }
 
-int prom_get_mmu_ihandle(void)
+static int prom_get_mmu_ihandle(void)
 {
 	phandle node;
 	int ret;
--- a/arch/sparc/kernel/traps_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/traps_64.c
@@ -22,6 +22,7 @@
 #include <linux/kdebug.h>
 #include <linux/ftrace.h>
 #include <linux/reboot.h>
+#include <linux/cpu.h>
 #include <linux/gfp.h>
 #include <linux/context_tracking.h>
 
@@ -249,7 +250,7 @@ void sun4v_insn_access_exception_tl1(str
 	sun4v_insn_access_exception(regs, addr, type_ctx);
 }
 
-bool is_no_fault_exception(struct pt_regs *regs)
+static bool is_no_fault_exception(struct pt_regs *regs)
 {
 	unsigned char asi;
 	u32 insn;
@@ -2031,7 +2032,7 @@ static void sun4v_log_error(struct pt_re
 /* Handle memory corruption detected error which is vectored in
  * through resumable error trap.
  */
-void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
+static void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
 {
 	if (notify_die(DIE_TRAP, "MCD error", regs, 0, 0x34,
 		       SIGSEGV) == NOTIFY_STOP)
@@ -2149,7 +2150,7 @@ static unsigned long sun4v_get_vaddr(str
 /* Attempt to handle non-resumable errors generated from userspace.
  * Returns true if the signal was handled, false otherwise.
  */
-bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
+static bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
 				  struct sun4v_error_entry *ent) {
 
 	unsigned int attrs = ent->err_attrs;
--- a/arch/sparc/mm/init_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/mm/init_64.c
@@ -2641,10 +2641,12 @@ int __meminit vmemmap_populate(unsigned
 	return 0;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
 }
+#endif
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 /* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */
--- a/arch/sparc/vdso/vma.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/vdso/vma.c
@@ -243,7 +243,7 @@ static int stick_patch(const struct vdso
  * Allocate pages for the vdso and vvar, and copy in the vdso text from the
  * kernel image.
  */
-int __init init_vdso_image(const struct vdso_image *image,
+static int __init init_vdso_image(const struct vdso_image *image,
 			   struct vm_special_mapping *vdso_mapping, bool elf64)
 {
 	int cnpages = (image->size) / PAGE_SIZE;
--- a/arch/sparc/kernel/setup_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/setup_64.c
@@ -599,7 +599,7 @@ static void __init init_sparc64_elf_hwca
 		pause_patch();
 }
 
-void __init alloc_irqstack_bootmem(void)
+static void __init alloc_irqstack_bootmem(void)
 {
 	unsigned int i, node;
 
--- a/arch/sparc/kernel/time_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/time_64.c
@@ -35,6 +35,8 @@
 #include <linux/platform_device.h>
 #include <linux/ftrace.h>
 
+#include <linux/sched/clock.h>
+
 #include <asm/oplib.h>
 #include <asm/timer.h>
 #include <asm/irq.h>
--- a/arch/sparc/power/hibernate.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/power/hibernate.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/suspend.h>
 
 #include <asm/hibernate.h>
 #include <asm/visasm.h>
--- a/arch/sparc/kernel/adi_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/adi_64.c
@@ -121,7 +121,7 @@ adi_not_found:
 		mdesc_release(hp);
 }
 
-tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
+static tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
 				   struct vm_area_struct *vma,
 				   unsigned long addr)
 {
@@ -153,7 +153,7 @@ tag_storage_desc_t *find_tag_store(struc
 	return tag_desc;
 }
 
-tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
+static tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
 				    struct vm_area_struct *vma,
 				    unsigned long addr)
 {
@@ -296,7 +296,7 @@ out:
 	return tag_desc;
 }
 
-void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
+static void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
 {
 	unsigned long flags;
 	unsigned char *tags = NULL;
--- /dev/null
+++ a/arch/sparc/include/asm/irq_work.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_SPARC_IRQ_WORK_H
+#define __ASM_SPARC_IRQ_WORK_H
+
+#include <asm-generic/irq_work.h>
+
+extern void arch_irq_work_raise(void);
+
+#endif /* __ASM_SPARC_IRQ_WORK_H */
--- a/arch/sparc/include/asm/floppy_64.h~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/include/asm/floppy_64.h
@@ -197,6 +197,7 @@ static void sun_fd_enable_dma(void)
 	pdma_areasize = pdma_size;
 }
 
+irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie);
 irqreturn_t sparc_floppy_irq(int irq, void *dev_cookie)
 {
 	if (likely(doing_pdma)) {
@@ -434,7 +435,8 @@ static int sun_pci_fd_eject(int drive)
 	return -EINVAL;
 }
 
-void sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
+static void
+sun_pci_fd_dma_callback(struct ebus_dma_info *p, int event, void *cookie)
 {
 	floppy_interrupt(0, NULL);
 }
--- a/arch/sparc/prom/init_64.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/prom/init_64.c
@@ -27,8 +27,6 @@ phandle prom_chosen_node;
  * It gets passed the pointer to the PROM vector.
  */
 
-extern void prom_cif_init(void *);
-
 void __init prom_init(void *cif_handler)
 {
 	phandle node;
--- a/arch/sparc/prom/p1275.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/prom/p1275.c
@@ -49,7 +49,7 @@ void p1275_cmd_direct(unsigned long *arg
 	local_irq_restore(flags);
 }
 
-void prom_cif_init(void *cif_handler, void *cif_stack)
+void prom_cif_init(void *cif_handler)
 {
 	p1275buf.prom_cif_handler = (void (*)(long *))cif_handler;
 }
--- a/arch/sparc/include/asm/openprom.h~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/include/asm/openprom.h
@@ -275,6 +275,8 @@ struct linux_prom_pci_intmask {
 	unsigned int interrupt;
 };
 
+extern void prom_cif_init(void *cif_handler);
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC_OPENPROM_H) */
--- a/arch/sparc/kernel/pci_sun4v.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/pci_sun4v.c
@@ -256,7 +256,7 @@ range_alloc_fail:
 	return NULL;
 }
 
-unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
+static unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
 				unsigned long iotsb_num,
 				struct pci_bus *bus_dev)
 {
--- a/arch/sparc/kernel/uprobes.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/arch/sparc/kernel/uprobes.c
@@ -234,6 +234,7 @@ int arch_uprobe_post_xol(struct arch_upr
 /* Handler for uprobe traps.  This is called from the traps table and
  * triggers the proper die notification.
  */
+void uprobe_trap(struct pt_regs *regs, unsigned long trap_level);
 asmlinkage void uprobe_trap(struct pt_regs *regs,
 			    unsigned long trap_level)
 {
--- a/drivers/sbus/char/bbc_i2c.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/drivers/sbus/char/bbc_i2c.c
@@ -358,9 +358,6 @@ fail:
 	return NULL;
 }
 
-extern int bbc_envctrl_init(struct bbc_i2c_bus *bp);
-extern void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp);
-
 static int bbc_i2c_probe(struct platform_device *op)
 {
 	struct bbc_i2c_bus *bp;
--- a/drivers/sbus/char/bbc_i2c.h~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/drivers/sbus/char/bbc_i2c.h
@@ -82,4 +82,7 @@ extern int bbc_i2c_readb(struct bbc_i2c_
 extern int bbc_i2c_write_buf(struct bbc_i2c_client *, char *buf, int len, int off);
 extern int bbc_i2c_read_buf(struct bbc_i2c_client *, char *buf, int len, int off);
 
+extern int bbc_envctrl_init(struct bbc_i2c_bus *bp);
+extern void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp);
+
 #endif /* _BBC_I2C_H */
--- a/drivers/mtd/maps/sun_uflash.c~arch-sparc-fix-up-fallout-from-enabling-wmissing-prototypes
+++ a/drivers/mtd/maps/sun_uflash.c
@@ -47,7 +47,7 @@ struct map_info uflash_map_templ = {
 	.bankwidth =	UFLASH_BUSWIDTH,
 };
 
-int uflash_devinit(struct platform_device *op, struct device_node *dp)
+static int uflash_devinit(struct platform_device *op, struct device_node *dp)
 {
 	struct uflash_dev *up;
 
_


