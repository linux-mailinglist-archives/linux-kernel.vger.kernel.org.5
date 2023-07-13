Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C2751D88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbjGMJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjGMJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:40:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3D2698;
        Thu, 13 Jul 2023 02:40:35 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R1qLv1v51zVjYP;
        Thu, 13 Jul 2023 17:39:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 17:40:32 +0800
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
Subject: [PATCH rfc -next 09/10] loongarch: mm: add access_error() helper
Date:   Thu, 13 Jul 2023 17:53:37 +0800
Message-ID: <20230713095339.189715-10-wangkefeng.wang@huawei.com>
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

Add access_error() to check whether vma could be accessible or not,
which will be used __do_page_fault() and later vma locked based page
fault.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/loongarch/mm/fault.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 03d06ee184da..cde2ea0119fa 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -120,6 +120,22 @@ static void __kprobes do_sigsegv(struct pt_regs *regs,
 	force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 }
 
+static inline bool access_error(unsigned int flags, struct pt_regs *regs,
+				unsigned long addr, struct vm_area_struct *vma)
+{
+	if (flags & FAULT_FLAG_WRITE) {
+		if (!(vma->vm_flags & VM_WRITE))
+			return true;
+	} else {
+		if (!(vma->vm_flags & VM_READ) && addr != exception_era(regs))
+			return true;
+		if (!(vma->vm_flags & VM_EXEC) && addr == exception_era(regs))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -163,6 +179,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+	if (write)
+		flags |= FAULT_FLAG_WRITE;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
@@ -172,16 +190,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 
 	si_code = SEGV_ACCERR;
 
-	if (write) {
-		flags |= FAULT_FLAG_WRITE;
-		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;
-	} else {
-		if (!(vma->vm_flags & VM_READ) && address != exception_era(regs))
-			goto bad_area;
-		if (!(vma->vm_flags & VM_EXEC) && address == exception_era(regs))
-			goto bad_area;
-	}
+	if (access_error(flags, regs, vma))
+		goto bad_area;
 
 	/*
 	 * If for any reason at all we couldn't handle the fault,
-- 
2.27.0

