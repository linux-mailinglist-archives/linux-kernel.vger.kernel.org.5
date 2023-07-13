Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99EF751D86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjGMJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjGMJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:40:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A52127;
        Thu, 13 Jul 2023 02:40:34 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1qMc4wfvz18Lt7;
        Thu, 13 Jul 2023 17:39:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:40:31 +0800
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
Subject: [PATCH rfc -next 08/10] loongarch: mm: cleanup __do_page_fault()
Date:   Thu, 13 Jul 2023 17:53:36 +0800
Message-ID: <20230713095339.189715-9-wangkefeng.wang@huawei.com>
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

Cleanup __do_page_fault() by reuse bad_area_nosemaphore and
bad_area label.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/loongarch/mm/fault.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index da5b6d518cdb..03d06ee184da 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -151,18 +151,15 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		if (!user_mode(regs))
 			no_context(regs, address);
 		else
-			do_sigsegv(regs, write, address, si_code);
-		return;
+			goto bad_area_nosemaphore;
 	}
 
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
 	 */
-	if (faulthandler_disabled() || !mm) {
-		do_sigsegv(regs, write, address, si_code);
-		return;
-	}
+	if (faulthandler_disabled() || !mm)
+		goto bad_area_nosemaphore;
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
@@ -172,23 +169,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma))
 		goto bad_area_nosemaphore;
-	goto good_area;
-
-/*
- * Something tried to access memory that isn't in our memory map..
- * Fix it, but check if it's kernel or user first..
- */
-bad_area:
-	mmap_read_unlock(mm);
-bad_area_nosemaphore:
-	do_sigsegv(regs, write, address, si_code);
-	return;
 
-/*
- * Ok, we have a good vm_area for this memory access, so
- * we can handle it..
- */
-good_area:
 	si_code = SEGV_ACCERR;
 
 	if (write) {
@@ -229,14 +210,15 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		 */
 		goto retry;
 	}
+
+	mmap_read_unlock(mm);
+
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mmap_read_unlock(mm);
 		if (fault & VM_FAULT_OOM) {
 			do_out_of_memory(regs, address);
 			return;
 		} else if (fault & VM_FAULT_SIGSEGV) {
-			do_sigsegv(regs, write, address, si_code);
-			return;
+			goto bad_area_nosemaphore;
 		} else if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 			do_sigbus(regs, write, address, si_code);
 			return;
@@ -244,7 +226,11 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		BUG();
 	}
 
+	return;
+bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
+	do_sigsegv(regs, write, address, si_code);
 }
 
 asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
-- 
2.27.0

