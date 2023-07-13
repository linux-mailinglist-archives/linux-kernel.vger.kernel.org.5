Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1613751D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjGMJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjGMJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:40:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692C26B8;
        Thu, 13 Jul 2023 02:40:36 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1qMg1LkQz18Lnh;
        Thu, 13 Jul 2023 17:39:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:40:33 +0800
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
Subject: [PATCH rfc -next 10/10] loongarch: mm: try VMA lock-based page fault handling first
Date:   Thu, 13 Jul 2023 17:53:38 +0800
Message-ID: <20230713095339.189715-11-wangkefeng.wang@huawei.com>
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

Attempt VMA lock-based page fault handling first, and fall back
to the existing mmap_lock-based handling if that fails.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/loongarch/Kconfig    |  1 +
 arch/loongarch/mm/fault.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 397203e18800..afb0ccabab97 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -53,6 +53,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index cde2ea0119fa..7e54bc48813e 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -136,6 +136,17 @@ static inline bool access_error(unsigned int flags, struct pt_regs *regs,
 	return false;
 }
 
+#ifdef CONFIG_PER_VMA_LOCK
+int arch_vma_check_access(struct vm_area_struct *vma,
+			  struct vm_locked_fault *vmlf)
+{
+	if (unlikely(access_error(vmlf->fault_flags, vmlf->regs, vmlf->address,
+		     vma)))
+		return -EINVAL;
+	return 0;
+}
+#endif
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -149,6 +160,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	struct vm_area_struct *vma = NULL;
+	struct vm_locked_fault vmlf;
 	vm_fault_t fault;
 
 	if (kprobe_page_fault(regs, current->thread.trap_nr))
@@ -183,6 +195,19 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		flags |= FAULT_FLAG_WRITE;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+
+	VM_LOCKED_FAULT_INIT(vmlf, mm, address, flags, 0, regs, 0);
+	if (try_vma_locked_page_fault(&vmlf, &fault))
+		goto retry;
+	else if (!(fault | VM_FAULT_RETRY))
+		goto done;
+
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, address);
+		return;
+	}
+
 retry:
 	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma))
@@ -223,6 +248,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 
 	mmap_read_unlock(mm);
 
+done:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM) {
 			do_out_of_memory(regs, address);
-- 
2.27.0

