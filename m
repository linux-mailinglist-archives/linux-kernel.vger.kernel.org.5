Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445D782919
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjHUMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjHUMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:31:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B4CD;
        Mon, 21 Aug 2023 05:31:21 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTsFF3Rj6zNnTN;
        Mon, 21 Aug 2023 20:27:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 20:31:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <surenb@google.com>, <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc v2 05/10] powerpc: mm: use try_vma_locked_page_fault()
Date:   Mon, 21 Aug 2023 20:30:51 +0800
Message-ID: <20230821123056.2109942-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
References: <20230821123056.2109942-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new try_vma_locked_page_fault() helper to simplify code.
No functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/mm/fault.c | 66 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b1723094d464..52f9546e020e 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -391,6 +391,22 @@ static int page_fault_is_bad(unsigned long err)
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
 #endif
 
+#ifdef CONFIG_PER_VMA_LOCK
+bool arch_vma_access_error(struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	int is_exec = TRAP(vmf->regs) == INTERRUPT_INST_STORAGE;
+	int is_write = page_fault_is_write(vmf->fault_code);
+
+	if (unlikely(access_pkey_error(is_write, is_exec,
+				(vmf->fault_code & DSISR_KEYFAULT), vma)))
+		return true;
+
+	if (unlikely(access_error(is_write, is_exec, vma)))
+		return true;
+	return false;
+}
+#endif
+
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
  * for a data fault, SRR1 for an instruction fault.
@@ -407,12 +423,18 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 {
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
-	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int is_exec = TRAP(regs) == INTERRUPT_INST_STORAGE;
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
 	vm_fault_t fault, major = 0;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
+	struct vm_fault vmf = {
+		.real_address = address,
+		.fault_code = error_code,
+		.regs = regs,
+		.flags = FAULT_FLAG_DEFAULT,
+	};
+
 
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
 		return 0;
@@ -463,45 +485,21 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * mmap_lock held
 	 */
 	if (is_user)
-		flags |= FAULT_FLAG_USER;
+		vmf.flags |= FAULT_FLAG_USER;
 	if (is_write)
-		flags |= FAULT_FLAG_WRITE;
+		vmf.flags |= FAULT_FLAG_WRITE;
 	if (is_exec)
-		flags |= FAULT_FLAG_INSTRUCTION;
+		vmf.flags |= FAULT_FLAG_INSTRUCTION;
 
-	if (!(flags & FAULT_FLAG_USER))
-		goto lock_mmap;
-
-	vma = lock_vma_under_rcu(mm, address);
-	if (!vma)
-		goto lock_mmap;
-
-	if (unlikely(access_pkey_error(is_write, is_exec,
-				       (error_code & DSISR_KEYFAULT), vma))) {
-		vma_end_read(vma);
-		goto lock_mmap;
-	}
-
-	if (unlikely(access_error(is_write, is_exec, vma))) {
-		vma_end_read(vma);
-		goto lock_mmap;
-	}
-
-	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
-		vma_end_read(vma);
-
-	if (!(fault & VM_FAULT_RETRY)) {
-		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+	fault = try_vma_locked_page_fault(&vmf);
+	if (fault == VM_FAULT_NONE)
+		goto retry;
+	if (!(fault & VM_FAULT_RETRY))
 		goto done;
-	}
-	count_vm_vma_lock_event(VMA_LOCK_RETRY);
 
 	if (fault_signal_pending(fault, regs))
 		return user_mode(regs) ? 0 : SIGBUS;
 
-lock_mmap:
-
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -528,7 +526,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, regs);
+	fault = handle_mm_fault(vma, address, vmf.flags, regs);
 
 	major |= fault & VM_FAULT_MAJOR;
 
@@ -544,7 +542,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * case.
 	 */
 	if (unlikely(fault & VM_FAULT_RETRY)) {
-		flags |= FAULT_FLAG_TRIED;
+		vmf.flags |= FAULT_FLAG_TRIED;
 		goto retry;
 	}
 
-- 
2.27.0

