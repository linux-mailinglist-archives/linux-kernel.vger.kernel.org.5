Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40317751D82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjGMJkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjGMJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:40:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E52118;
        Thu, 13 Jul 2023 02:40:31 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1qLp2H4wzVjg5;
        Thu, 13 Jul 2023 17:39:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:40:27 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <surenb@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
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
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc -next 05/10] powerpc: mm: use try_vma_locked_page_fault()
Date:   Thu, 13 Jul 2023 17:53:33 +0800
Message-ID: <20230713095339.189715-6-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713095339.189715-1-wangkefeng.wang@huawei.com>
References: <20230713095339.189715-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new try_vma_locked_page_fault() helper to simplify code.
No functional change intended.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/mm/fault.c | 54 +++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 82954d0e6906..dd4832a3cf10 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -391,6 +391,23 @@ static int page_fault_is_bad(unsigned long err)
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
 #endif
 
+#ifdef CONFIG_PER_VMA_LOCK
+int arch_vma_check_access(struct vm_area_struct *vma,
+			  struct vm_locked_fault *vmlf)
+{
+	int is_exec = TRAP(vmlf->regs) == INTERRUPT_INST_STORAGE;
+	int is_write = page_fault_is_write(vmlf->fault_code);
+
+	if (unlikely(access_pkey_error(is_write, is_exec,
+				(vmlf->fault_code & DSISR_KEYFAULT), vma)))
+		return -EINVAL;
+
+	if (unlikely(access_error(is_write, is_exec, vma)))
+		return -EINVAL;
+	return 0;
+}
+#endif
+
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
  * for a data fault, SRR1 for an instruction fault.
@@ -413,6 +430,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_write = page_fault_is_write(error_code);
 	vm_fault_t fault, major = 0;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
+	struct vm_locked_fault vmlf;
 
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
 		return 0;
@@ -469,41 +487,15 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
-#ifdef CONFIG_PER_VMA_LOCK
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
+	VM_LOCKED_FAULT_INIT(vmlf, mm, address, flags, 0, regs, error_code);
+	if (try_vma_locked_page_fault(&vmlf, &fault))
+		goto retry;
+	else if (!(fault | VM_FAULT_RETRY))
 		goto done;
-	}
-	count_vm_vma_lock_event(VMA_LOCK_RETRY);
 
 	if (fault_signal_pending(fault, regs))
 		return user_mode(regs) ? 0 : SIGBUS;
 
-lock_mmap:
-#endif /* CONFIG_PER_VMA_LOCK */
-
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -552,9 +544,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	mmap_read_unlock(current->mm);
 
-#ifdef CONFIG_PER_VMA_LOCK
 done:
-#endif
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
 
-- 
2.27.0

