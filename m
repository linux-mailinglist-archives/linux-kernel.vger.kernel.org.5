Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C67563F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQNMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGQNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:12:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E642694;
        Mon, 17 Jul 2023 06:12:10 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4Mq35PpqztRVP;
        Mon, 17 Jul 2023 21:09:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 21:12:08 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <x86@kernel.org>, <mark.rutland@arm.com>, <ryan.roberts@arm.com>,
        <will@kernel.org>, <anshuman.khandual@arm.com>,
        <linux-doc@vger.kernel.org>
CC:     <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, Barry Song <21cnbao@gmail.com>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>, <Jonathan.Cameron@Huawei.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH v11 1/4] mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
Date:   Mon, 17 Jul 2023 21:10:01 +0800
Message-ID: <20230717131004.12662-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230717131004.12662-1-yangyicong@huawei.com>
References: <20230717131004.12662-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

The entire scheme of deferred TLB flush in reclaim path rests on the
fact that the cost to refill TLB entries is less than flushing out
individual entries by sending IPI to remote CPUs. But architecture
can have different ways to evaluate that. Hence apart from checking
TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
architecture specific.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[https://lore.kernel.org/linuxppc-dev/20171101101735.2318-2-khandual@linux.vnet.ibm.com/]
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
[Rebase and fix incorrect return value type]
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
 arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
 mm/rmap.c                       |  9 +--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 80450e1d5385..cf2a1de5d388 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -253,6 +253,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
+static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+	bool should_defer = false;
+
+	/* If remote CPUs need to be flushed then defer batch the flush */
+	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
+		should_defer = true;
+	put_cpu();
+
+	return should_defer;
+}
+
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 {
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 0c0d8857dfce..6480e526c154 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -688,17 +688,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval)
  */
 static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 {
-	bool should_defer = false;
-
 	if (!(flags & TTU_BATCH_FLUSH))
 		return false;
 
-	/* If remote CPUs need to be flushed then defer batch the flush */
-	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
-		should_defer = true;
-	put_cpu();
-
-	return should_defer;
+	return arch_tlbbatch_should_defer(mm);
 }
 
 /*
-- 
2.24.0

