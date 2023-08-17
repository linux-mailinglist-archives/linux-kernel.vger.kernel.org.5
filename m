Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B173E77F1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbjHQIJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348736AbjHQIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:05 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F37BD2D70
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:08:58 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-cd-64ddd598b1b7
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 3/6] mm, migrc: Skip TLB flushes at the CPUs that already have been done
Date:   Thu, 17 Aug 2023 17:05:56 +0900
Message-Id: <20230817080559.43200-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817080559.43200-1-byungchul@sk.com>
References: <20230817080559.43200-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC9ZZnoe6Mq3dTDE7M1bWYs34Nm8WLDe2M
        Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsru96yGhxvPcAk8XvH0DZOVOsLE7O
        msziwOuxYFOpx+YVWh6L97xk8ti0qpPNY9OnSeweJ2b8ZvHY+dDSY97JQI/3+66yeWz9Zefx
        eZOcx7v5b9kCeKK4bFJSczLLUov07RK4MpYdkS64p1Axue8EYwPjHakuRk4OCQETic0NU5hg
        7MPLLrKC2GwC6hI3bvxkBrFFBMwkDrb+Ye9i5OJgFljGJHH3wDmwImGBSIl3K9rAmlkEVCUO
        31kK1sArYCoxe8lPNoih8hKrNxwAinNwcAIN2vxXFSQsBFTyYe86VpCZEgJn2CSmbZ7BClEv
        KXFwxQ2WCYy8CxgZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIEhvCy2j/ROxg/XQg+xCjAwajE
        w+uw606KEGtiWXFl7iFGCQ5mJRHeHt5bKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJ
        pCeWpGanphakFsFkmTg4pRoYXf75bBe89vrhtJhWGcu90yxfHKrkkzZ7sn72XYcjTpwrPT3e
        f3yheun5kbblwobtpdvC3zXwdMntiJx4R/adxYXLrB8aGv0Zo473KXxO8xZexrS/yvar891T
        TQVxvfN5e4rkct+uiN1y2k68ctFCm76HFQKbtmfe36R7Q6JZkFlsRX9ewu3dSizFGYmGWsxF
        xYkABxT0Ul0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsXC5WfdrDvj6t0Ugwd3lS3mrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugStj2RHpgnsKFZP7TjA2MN6R6mLk
        5JAQMJE4vOwiK4jNJqAucePGT2YQW0TATOJg6x/2LkYuDmaBZUwSdw+cAysSFoiUeLeijQnE
        ZhFQlTh8ZylYA6+AqcTsJT/ZIIbKS6zecAAozsHBCTRo819VkLAQUMmHvetYJzByLWBkWMUo
        kplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYkMtq/0zcwfjlsvshRgEORiUeXoddd1KEWBPLiitz
        DzFKcDArifD28N5KEeJNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl
        4uCUamCcmfprh7SOzUXlmHMuxVOuNJnK5DTzyDXMUJVT5W3P/P1wRvSHrZ6rr9y8GC25bu60
        PtvjD96/c+Vi7Tx7+5eBgsstd0OGK+9r4yMuGHKd69RmfWRqLhWm8D7nYrWe5gGVD4oz6g7v
        6Fix4WZ53AbnqrvWHgHF27P+T75mu+uiu1PIpotT1yxUYinOSDTUYi4qTgQATWrKskQCAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLB flushes can be skipped if TLB flushes requested have been done by
any reason, which doesn't have to be done from migrations. It can be
tracked by keeping timestamp(= migrc_gen) when it's requested and
when it's triggered.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h |  6 ++++
 arch/x86/mm/tlb.c               | 55 +++++++++++++++++++++++++++++++++
 mm/migrate.c                    | 10 ++++++
 mm/rmap.c                       |  1 +
 4 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 752d72ea209b..da987c15049e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -283,6 +283,12 @@ extern void arch_tlbbatch_clean(struct arch_tlbflush_unmap_batch *batch);
 extern void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
 			       struct arch_tlbflush_unmap_batch *bsrc);
 
+#ifdef CONFIG_MIGRC
+extern void arch_migrc_adj(struct arch_tlbflush_unmap_batch *batch, int gen);
+#else
+static inline void arch_migrc_adj(struct arch_tlbflush_unmap_batch *batch, int gen) {}
+#endif
+
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2dabf0f340fb..913cad013979 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1210,9 +1210,48 @@ STATIC_NOPV void native_flush_tlb_local(void)
 	native_write_cr3(__native_read_cr3());
 }
 
+#ifdef CONFIG_MIGRC
+DEFINE_PER_CPU(int, migrc_done);
+
+static inline int migrc_tlb_local_begin(void)
+{
+	int ret = atomic_read(&migrc_gen);
+
+	/*
+	 * XXX: barrier() would be sufficient if the architecture
+	 * quarantees the order between memory access and TLB flush.
+	 */
+	smp_mb();
+	return ret;
+}
+
+static inline void migrc_tlb_local_end(int gen)
+{
+	/*
+	 * XXX: barrier() would be sufficient if the architecture
+	 * quarantees the order between TLB flush and memory access.
+	 */
+	smp_mb();
+	WRITE_ONCE(*this_cpu_ptr(&migrc_done), gen);
+}
+#else
+static inline int migrc_tlb_local_begin(void)
+{
+	return 0;
+}
+
+static inline void migrc_tlb_local_end(int gen)
+{
+}
+#endif
+
 void flush_tlb_local(void)
 {
+	unsigned int gen;
+
+	gen = migrc_tlb_local_begin();
 	__flush_tlb_local();
+	migrc_tlb_local_end(gen);
 }
 
 /*
@@ -1237,6 +1276,22 @@ void __flush_tlb_all(void)
 }
 EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
+#ifdef CONFIG_MIGRC
+static inline bool before(int a, int b)
+{
+	return a - b < 0;
+}
+
+void arch_migrc_adj(struct arch_tlbflush_unmap_batch *batch, int gen)
+{
+	int cpu;
+
+	for_each_cpu(cpu, &batch->cpumask)
+		if (!before(READ_ONCE(*per_cpu_ptr(&migrc_done, cpu)), gen))
+			cpumask_clear_cpu(cpu, &batch->cpumask);
+}
+#endif
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	struct flush_tlb_info *info;
diff --git a/mm/migrate.c b/mm/migrate.c
index f9446f5b312a..c7b72d275b2a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2053,6 +2053,16 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/*
+	 * Should be prior to try_to_unmap_flush() so that
+	 * migrc_try_flush_free_folios() that will be called later
+	 * can take benefit from the TLB flushes in try_to_unmap_flush().
+	 *
+	 * migrc_req_end() will store the timestamp for pending, and
+	 * TLB flushes will also store the timestamp for TLB flush so
+	 * that unnecessary TLB flushes can be skipped using the time
+	 * information.
+	 */
 	if (migrc_cond1)
 		migrc_req_end();
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 0652d25206ee..2ae1b1324f84 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -627,6 +627,7 @@ static bool __migrc_try_flush_free_folios(struct llist_head *h)
 	llist_for_each_entry_safe(req, req2, reqs, llnode) {
 		struct llist_node *n;
 
+		arch_migrc_adj(&req->arch, req->gen);
 		arch_tlbbatch_fold(&arch, &req->arch);
 
 		n = llist_del_all(&req->pages);
-- 
2.17.1

