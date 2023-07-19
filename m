Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1775A241
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGSWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCB1FFD;
        Wed, 19 Jul 2023 15:47:32 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QLCuU+MP60OI7qqOOLHpQ8TBHTxvIgx36nhbmKidke0=;
        b=izDij7Bs/IV25KKuzG2Hw7JgDMPd4SEQX7hpuSbmsd3kKE+HGIrbEtSMZpH3GnV9Xm097J
        6qGhBEOmaM7gEPdjcwtsSRbn8ynT6wQYnZrP98Y/YUGEoXoOy6jJ836duAE4YvnoDmd0Nc
        aZgILinPhjGOUW32+S56nuie5UBkcTlc5Kq0BGJgm/HiquqkPAyS8hjlJVf1YP8lGZjNBR
        nPqJknopr5/q9ZPRuZno/TJ7ZE4ZiuuxMTVIgZVo+AJg4WzgjAeI/yxJ/fmp5RQOxDN1Ha
        YNYf3OiaTJqqXlshMr6QYz4pZ+sJv1hnw9rIevye1OiDJTtR2KdSGxF+uviRDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QLCuU+MP60OI7qqOOLHpQ8TBHTxvIgx36nhbmKidke0=;
        b=wmOROvBccyangmoJt36oDHvmGA+11xnwtycX1L9fFXdhItVXe05ksD6vreX6oKKQjPskhf
        kyYRHXj1rk0TmeCw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Introduce map_shadow_stack syscall
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980684929.28540.4408798500803841643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     ffe0b4926f520439a875ae1d7f161b45143c975d
Gitweb:        https://git.kernel.org/tip/ffe0b4926f520439a875ae1d7f161b45143c975d
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:00 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:13:22 -07:00

x86/shstk: Introduce map_shadow_stack syscall

When operating with shadow stacks enabled, the kernel will automatically
allocate shadow stacks for new threads, however in some cases userspace
will need additional shadow stacks. The main example of this is the
ucontext family of functions, which require userspace allocating and
pivoting to userspace managed stacks.

Unlike most other user memory permissions, shadow stacks need to be
provisioned with special data in order to be useful. They need to be setup
with a restore token so that userspace can pivot to them via the RSTORSSP
instruction. But, the security design of shadow stacks is that they
should not be written to except in limited circumstances. This presents a
problem for userspace, as to how userspace can provision this special
data, without allowing for the shadow stack to be generally writable.

Previously, a new PROT_SHADOW_STACK was attempted, which could be
mprotect()ed from RW permissions after the data was provisioned. This was
found to not be secure enough, as other threads could write to the
shadow stack during the writable window.

The kernel can use a special instruction, WRUSS, to write directly to
userspace shadow stacks. So the solution can be that memory can be mapped
as shadow stack permissions from the beginning (never generally writable
in userspace), and the kernel itself can write the restore token.

First, a new madvise() flag was explored, which could operate on the
PROT_SHADOW_STACK memory. This had a couple of downsides:
1. Extra checks were needed in mprotect() to prevent writable memory from
   ever becoming PROT_SHADOW_STACK.
2. Extra checks/vma state were needed in the new madvise() to prevent
   restore tokens being written into the middle of pre-used shadow stacks.
   It is ideal to prevent restore tokens being added at arbitrary
   locations, so the check was to make sure the shadow stack had never been
   written to.
3. It stood out from the rest of the madvise flags, as more of direct
   action than a hint at future desired behavior.

So rather than repurpose two existing syscalls (mmap, madvise) that don't
quite fit, just implement a new map_shadow_stack syscall to allow
userspace to map and setup new shadow stacks in one step. While ucontext
is the primary motivator, userspace may have other unforeseen reasons to
setup its own shadow stacks using the WRSS instruction. Towards this
provide a flag so that stacks can be optionally setup securely for the
common case of ucontext without enabling WRSS. Or potentially have the
kernel set up the shadow stack in some new way.

The following example demonstrates how to create a new shadow stack with
map_shadow_stack:
void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-35-rick.p.edgecombe%40intel.com
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +-
 arch/x86/include/uapi/asm/mman.h       |  3 +-
 arch/x86/kernel/shstk.c                | 59 +++++++++++++++++++++----
 include/linux/syscalls.h               |  1 +-
 kernel/sys_ni.c                        |  1 +-
 5 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 227538b..38db4b1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -373,6 +373,7 @@
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
 451	common	cachestat		sys_cachestat
+452	64	map_shadow_stack	sys_map_shadow_stack
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 5a0256e..8148bdd 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -13,6 +13,9 @@
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
 #endif
 
+/* Flags for map_shadow_stack(2) */
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
+
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 50733a5..04c37b3 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -17,6 +17,7 @@
 #include <linux/compat.h>
 #include <linux/sizes.h>
 #include <linux/user.h>
+#include <linux/syscalls.h>
 #include <asm/msr.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
@@ -71,19 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
-static unsigned long alloc_shstk(unsigned long size)
+static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
+				 unsigned long token_offset, bool set_res_tok)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr, unused;
+	unsigned long mapped_addr, unused;
 
-	mmap_write_lock(mm);
-	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
-		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
 
+	mmap_write_lock(mm);
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
 	mmap_write_unlock(mm);
 
-	return addr;
+	if (!set_res_tok || IS_ERR_VALUE(mapped_addr))
+		goto out;
+
+	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
+		vm_munmap(mapped_addr, size);
+		return -EINVAL;
+	}
+
+out:
+	return mapped_addr;
 }
 
 static unsigned long adjust_shstk_size(unsigned long size)
@@ -134,7 +147,7 @@ static int shstk_setup(void)
 		return -EOPNOTSUPP;
 
 	size = adjust_shstk_size(0);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return PTR_ERR((void *)addr);
 
@@ -178,7 +191,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 		return 0;
 
 	size = adjust_shstk_size(stack_size);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
@@ -398,6 +411,36 @@ static int shstk_disable(void)
 	return 0;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
+	unsigned long aligned_size;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	if (flags & ~SHADOW_STACK_SET_TOKEN)
+		return -EINVAL;
+
+	/* If there isn't space for a token */
+	if (set_tok && size < 8)
+		return -ENOSPC;
+
+	if (addr && addr < SZ_4G)
+		return -ERANGE;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	aligned_size = PAGE_ALIGN(size);
+	if (aligned_size < size)
+		return -EOVERFLOW;
+
+	return alloc_shstk(addr, aligned_size, size, set_tok);
+}
+
 long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 {
 	if (option == ARCH_SHSTK_LOCK) {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 03e3d01..7f6dc09 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -953,6 +953,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
 asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
+asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 781de7c..e137c13 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -274,6 +274,7 @@ COND_SYSCALL(vm86old);
 COND_SYSCALL(modify_ldt);
 COND_SYSCALL(vm86);
 COND_SYSCALL(kexec_file_load);
+COND_SYSCALL(map_shadow_stack);
 
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);
