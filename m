Return-Path: <linux-kernel+bounces-148061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCB18A7D27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7541C210D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459E80638;
	Wed, 17 Apr 2024 07:34:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBA7BB14
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339268; cv=none; b=Vka0Fbq24t1mVkIKNlA8NAM0onlMMFAuGWO1IJfKX/rvhzF4zynYRBcgkPoJMTYE4wF5s5CQ62ZstoHogY9rebLBehk0z7Fu5lwmHNzCGFiAPpRb8VLxfC860zvrV9/vR0Uoyd0ewxZ9yWOuHNZbBzRqX2jCyh3e4yMrFMmurP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339268; c=relaxed/simple;
	bh=eFi5Wu0m28oGDzaL0rBLfxlUVSsbx0DZkuIuKdmE0jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rrRyPvynWnQ6lbji0de6bfOAG8flIXNSnrgLZf17Y0/z09ZxhPFmLNZUKtWkblCERTk8e0TplbKgnb8fg55OzLIjdHcy10Us2IDrz7icKSl0kCLEpdtMdcDR+2LGF05q4PRn+b1anxQr1QChuAD1da6SMM3azf6SFNzlWHcAmH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-b7-661f77e24a4a
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v9 8/8] mm: defer tlb flush until the source folios at migration actually get used
Date: Wed, 17 Apr 2024 16:18:47 +0900
Message-Id: <20240417071847.29584-9-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6jcvk0gxuNehZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	/baD7AWLtzJWnL5+iqmBsa+XsYuRk0NCwESi8+UqIJsDzL71rRwkzCagLnHjxk9mEFtEwEzi
	YOsfdhCbWeAuk8SBfjYQW1ggSeLhtAusIDaLgKrEkZttTCA2r4CpxJy+TUwQ4+UlVm84ADaH
	E2jO5uY1YL1CQDXfT3xkg6j5zibxYroIhC0pcXDFDZYJjLwLGBlWMQpl5pXlJmbmmOhlVOZl
	Vugl5+duYgSG/rLaP9E7GD9dCD7EKMDBqMTDaxAllybEmlhWXJl7iFGCg1lJhLdFWDZNiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6Nn08adCg9FPZWm
	5zI78glp13VceXrU0+hjQH50nhLHXaOKfGWePIup9dfmSVtyTknOCFteLv30sRcD9/SMouDs
	Gfm7rtS8q/j2a5XIu5hXZ2cf8HRt2j1vUf5x81azNsMLJeEmCj/yL+lcEHSodDY7+eTQwV6n
	f+fOF19OORJ93dlF76+JsRJLcUaioRZzUXEiAMlpBip5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7N4MgkBYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZazfdpC9YPFWxorT108xNTD29TJ2MXJwSAiYSNz6Vt7FyMnBJqAucePGT2YQ
	W0TATOJg6x92EJtZ4C6TxIF+NhBbWCBJ4uG0C6wgNouAqsSRm21MIDavgKnEnL5NYLaEgLzE
	6g0HwOZwAs3Z3LwGrFcIqOb7iY9sExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM
	5WW1fybuYPxy2f0QowAHoxIPr0GUXJoQa2JZcWXuIUYJDmYlEd4WYdk0Id6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsbrkwWZNR97HDBLl6stNNpmtlr7
	/pqzXU2CN75fUJqzoqzqp3y5lXyepbalVPFP7rowg90+32smWm837LlyLTCw7//t9bPa+2yM
	nHbO+ff5zaqnEm9VLA50acRMeHWmMjn2ha1YaquS9vq2PWbLv/xzPrViS1Xjzo0/1vGxls0o
	fpf9/Pr72DwlluKMREMt5qLiRADnf6nVYQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is implementation of MIGRC mechanism that stands for 'Migration
Read Copy'.  We always face the migration overhead at either promotion
or demotion, while working with tiered memory e.g. CXL memory and found
out tlb shootdown is one that is needed to get rid of if possible.

Fortunately, tlb flush can be defered as long as it guarantees to be
performed before the source folios at migration actually become used, of
course, only if the target PTE entries have read-only permission,
precisely, don't have write permission.  Otherwise, no doubt the sytem
might get messed up.

To achieve that:

   1. For the folios that map only to non-writable tlb entries, prevent
      tlb flush during migration but perform it just before the source
      folios actually become used out of buddy or pcp.

   2. When any non-writable tlb entry changes to writable e.g. through
      fault handler, give up migrc mechanism and perform tlb flush
      required right away.

No matter what type of workload is used for performance evaluation, the
result would be positive thanks to the unconditional reduction of tlb
flushes, tlb misses and interrupts.  For the test, I picked up XSBench
that is widely used for performance analysis on high performance
computing architectures - https://github.com/ANL-CESAR/XSBench.

The result would depend on memory latency and how often reclaim runs,
which implies tlb miss overhead and how many times migration happens.
The slower the memory is and the more reclaim runs, the better migrc
works so as to obtain the better result.  In my system, the result
shows:

   1. itlb flushes are reduced over 90%.
   2. itlb misses are reduced over 30%.
   3. All the other tlb numbers also get enhanced.
   4. tlb shootdown interrupts are reduced over 90%.
   5. The test program runtime is reduced over 5%.

The test envitonment:

   Architecture - x86_64
   QEMU - kvm enabled, host cpu
   Numa - 2 nodes (16 CPUs 1GB, no CPUs 99GB)
   Linux Kernel - v6.9-rc4, numa balancing tiering on, demotion enabled

< measurement: raw data - tlb and interrupt numbers >

   $ perf stat -a \
           -e itlb.itlb_flush \
           -e tlb_flush.dtlb_thread \
           -e tlb_flush.stlb_any \
           -e dtlb-load-misses \
           -e dtlb-store-misses \
           -e itlb-load-misses \
	   XSBench -t 16 -p 50000000

   $ grep "TLB shootdowns" /proc/interrupts

   BEFORE
   ------
   40417078	itlb.itlb_flush
   234852566	tlb_flush.dtlb_thread
   153192357	tlb_flush.stlb_any
   119001107892	dTLB-load-misses
   307921167	dTLB-store-misses
   1355272118	iTLB-load-misses

   TLB: 1364803    1303670    1333921    1349607
        1356934    1354216    1332972    1342842
	1350265    1316443    1355928    1360793
	1298239    1326358    1343006    1340971
	TLB shootdowns

   AFTER
   -----
   3316495	itlb.itlb_flush
   138912511	tlb_flush.dtlb_thread
   115199341	tlb_flush.stlb_any
   117610390021 dTLB-load-misses
   198042233	dTLB-store-misses
   840066984	iTLB-load-misses

   TLB: 117257     119219     117178     115737
        117967     118948     117508     116079
	116962     117266     117320     117215
	105808     103934     115672     117610
	TLB shootdowns

< measurement: user experience - runtime >

   $ time XSBench -t 16 -p 50000000

   BEFORE
   ------
   Threads:     16
   Runtime:     968.783 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,754,778

   15208.91s user 141.44s system 1564% cpu 16:20.98 total

   AFTER
   -----
   Threads:     16
   Runtime:     913.210 seconds
   Lookups:     1,700,000,000
   Lookups/s:   1,861,565

   14351.69s user 138.23s system 1565% cpu 15:25.47 total

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |   8 +
 mm/internal.h         |  46 +++++-
 mm/memory.c           |   8 +
 mm/migrate.c          | 359 ++++++++++++++++++++++++++++++++++++++++--
 mm/rmap.c             |  12 +-
 5 files changed, 414 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 74f8d106be79..7fba33c1faec 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1337,6 +1337,14 @@ struct task_struct {
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
 	unsigned short int		mgen;
 
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+	/*
+	 * whether all the mappings of a folio during unmap are read-only
+	 * so that migrc can work on the folio
+	 */
+	bool				can_migrc;
+#endif
+
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
diff --git a/mm/internal.h b/mm/internal.h
index f381af27e6d1..cfdfa5908f72 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1380,6 +1380,39 @@ void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
 #if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+void check_migrc_flush(unsigned short int mgen);
+void migrc_flush(void);
+void rmap_flush_start(void);
+void rmap_flush_end(struct tlbflush_unmap_batch *batch);
+
+/*
+ * Reset the indicator indicating there are no writable mappings at the
+ * beginning of every rmap traverse for unmap.  migrc can work only when
+ * all the mappings are read-only.
+ */
+static inline void can_migrc_init(void)
+{
+	current->can_migrc = true;
+}
+
+/*
+ * Mark the folio is not applicable to migrc once it found a writble or
+ * dirty pte during rmap traverse for unmap.
+ */
+static inline void can_migrc_fail(void)
+{
+	current->can_migrc = false;
+}
+
+/*
+ * Check if all the mappings are read-only and read-only mappings even
+ * exist.
+ */
+static inline bool can_migrc_test(void)
+{
+	return current->can_migrc && current->tlb_ubc_ro.flush_required;
+}
+
 static inline unsigned short int mgen_latest(unsigned short int a, unsigned short int b)
 {
 	if (!a || !b)
@@ -1406,13 +1439,16 @@ static inline unsigned int hand_over_task_mgen(void)
 
 static inline void check_flush_task_mgen(void)
 {
-	/*
-	 * XXX: migrc mechanism will handle this. For now, do nothing
-	 * but reset current's mgen to finalize this turn.
-	 */
-	current->mgen = 0;
+	check_migrc_flush(xchg(&current->mgen, 0));
 }
 #else /* CONFIG_MIGRATION && CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static inline void check_migrc_flush(unsigned short int mgen) {}
+static inline void migrc_flush(void) {}
+static inline void rmap_flush_start(void) {}
+static inline void rmap_flush_end(struct tlbflush_unmap_batch *batch) {}
+static inline void can_migrc_init(void) {}
+static inline void can_migrc_fail(void) {}
+static inline bool can_migrc_test(void) { return false; }
 static inline unsigned short int mgen_latest(unsigned short int a, unsigned short int b) { return 0; }
 static inline void update_task_mgen(unsigned short int mgen) {}
 static inline unsigned int hand_over_task_mgen(void) { return 0; }
diff --git a/mm/memory.c b/mm/memory.c
index d2155ced45f8..fc4d09fdfef8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3611,6 +3611,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vmf->page)
 		folio = page_folio(vmf->page);
 
+	/*
+	 * The folio may or may not be one that is under migrc's control
+	 * and about to change its permission from read-only to writable.
+	 * Conservatively give up deferring tlb flush just in case.
+	 */
+	if (folio)
+		migrc_flush();
+
 	/*
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
diff --git a/mm/migrate.c b/mm/migrate.c
index fed3a65e9bbe..7e16cb608ac5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,279 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+static struct tlbflush_unmap_batch migrc_ubc;
+static DEFINE_SPINLOCK(migrc_lock);
+
+/*
+ * Don't be zero to distinguish from invalid mgen, 0.
+ */
+static unsigned short int mgen_next(unsigned short int a)
+{
+	return a + 1 ?: a + 2;
+}
+
+static bool mgen_before(unsigned short int a, unsigned short int b)
+{
+	return (short int)(a - b) < 0;
+}
+
+static void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
+{
+	arch_tlbbatch_clear(&ubc->arch);
+	ubc->flush_required = false;
+	ubc->writable = false;
+}
+
+/*
+ * Need to synchronize between tlb flush and managing pending CPUs in
+ * migrc_ubc.  Take a look at the following scenario, where CPU0 is in
+ * try_to_unmap_flush() and CPU1 is in migrate_pages_batch():
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	tlb flush
+ *				unmap folios (needing tlb flush)
+ *				add pending CPUs to migrc_ubc
+ *				<-- not performed tlb flush needed by
+ *				    the unmap above yet but the request
+ *				    will be cleared by CPU0 shortly. bug!
+ *	clear the CPUs from migrc_ubc
+ *
+ * The pending CPUs added in CPU1 should not be cleared from migrc_ubc
+ * in CPU0 because the tlb flush for migrc_ubc added in CPU1 has not
+ * been performed this turn.  To avoid this, using 'on_flushing'
+ * variable, prevent adding pending CPUs to migrc_ubc and give up migrc
+ * mechanism if someone is in the middle of tlb flush, like:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	on_flushing++
+ *	tlb flush
+ *				unmap folios (needing tlb flush)
+ *				if on_flushing == 0:
+ *				   add pending CPUs to migrc_ubc
+ *				else: <-- hit
+ *				   give up migrc mechanism
+ *	clear the CPUs from migrc_ubc
+ *	on_flushing--
+ *
+ * Only the following case would be allowed for migrc mechanism to work:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *				unmap folios (needing tlb flush)
+ *				if on_flushing == 0: <-- hit
+ *				   add pending CPUs to migrc_ubc
+ *				else:
+ *				   give up migrc mechanism
+ *	on_flushing++
+ *	tlb flush
+ *	clear the CPUs from migrc_ubc
+ *	on_flushing--
+ */
+static int on_flushing;
+
+/*
+ * When more than one thread enter check_migrc_flush() at the same
+ * time, each should wait for the request on progress to be done to
+ * avoid the following scenario, where the both CPUs are in
+ * check_migrc_flush():
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	if !migrc_ubc.flush_required:
+ *	   return
+ *	migrc_ubc.flush_required = false
+ *				if !migrc_ubc.flush_requied: <-- hit
+ *				   return <-- not performed tlb flush
+ *				              needed yet but return. bug!
+ *				migrc_ubc.flush_required = false
+ *				try_to_unmap_flush()
+ *				finalize
+ *	try_to_unmap_flush() <-- performs tlb flush needed
+ *	finalize
+ *
+ * So it should be handled:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	atomically execute {
+ *	   if migrc_on_flushing:
+ *	      wait for the completion
+ *	      return
+ *	   if !migrc_ubc.flush_required:
+ *	      return
+ *	   migrc_ubc.flush_required = false
+ *	   migrc_on_flushing = true
+ *	}
+ *				atomically execute {
+ *				   if migrc_on_flushing: <-- hit
+ *				      wait for the completion
+ *				      return <-- tlb flush needed is done
+ *				   if !migrc_ubc.flush_requied:
+ *				      return
+ *				   migrc_ubc.flush_required = false
+ *				   migrc_on_flushing = true
+ *				}
+ *
+ *				try_to_unmap_flush()
+ *				migrc_on_flushing = false
+ *				finalize
+ *	try_to_unmap_flush() <-- performs tlb flush needed
+ *	migrc_on_flushing = false
+ *	finalize
+ */
+static bool migrc_on_flushing;
+
+/*
+ * Generation number for the current request of deferred tlb flush.
+ */
+static unsigned short int migrc_gen;
+
+/*
+ * Generation number for the next request.
+ */
+static unsigned short int migrc_gen_next = 1;
+
+/*
+ * Generation number for the latest request handled.
+ */
+static unsigned short int migrc_gen_done;
+
+static unsigned short int migrc_add_pending_ubc(struct tlbflush_unmap_batch *ubc)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	unsigned long flags;
+	unsigned short int mgen;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	if (on_flushing || migrc_on_flushing) {
+		spin_unlock_irqrestore(&migrc_lock, flags);
+
+		/*
+		 * Give up migrc mechanism.  Just let tlb flush needed
+		 * handled by try_to_unmap_flush() at the caller side.
+		 */
+		fold_ubc(tlb_ubc, ubc);
+		return 0;
+	}
+	fold_ubc(&migrc_ubc, ubc);
+	mgen = migrc_gen = migrc_gen_next;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+
+	return mgen;
+}
+
+void rmap_flush_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	on_flushing++;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+}
+
+void rmap_flush_end(struct tlbflush_unmap_batch *batch)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	if (arch_tlbbatch_done(&migrc_ubc.arch, &batch->arch)) {
+		migrc_ubc.flush_required = false;
+		migrc_ubc.writable = false;
+	}
+	on_flushing--;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+}
+
+/*
+ * Even if multiple contexts are requesting tlb flush at the same time,
+ * it must guarantee to have completed tlb flush requested on return.
+ */
+void check_migrc_flush(unsigned short int mgen)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	unsigned long flags;
+
+	/*
+	 * Nothing has been requested.  We are done.
+	 */
+	if (!mgen)
+		return;
+retry:
+	/*
+	 * We can see a larger value than or equal to migrc_gen_done,
+	 * which means the tlb flush we need has been done.
+	 */
+	if (!mgen_before(READ_ONCE(migrc_gen_done), mgen))
+		return;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+
+	/*
+	 * With migrc_lock held, we might read migrc_gen_done updated.
+	 */
+	if (mgen_next(migrc_gen_done) != mgen) {
+		spin_unlock_irqrestore(&migrc_lock, flags);
+		return;
+	}
+
+	/*
+	 * Others are already working for us.
+	 */
+	if (migrc_on_flushing) {
+		spin_unlock_irqrestore(&migrc_lock, flags);
+		goto retry;
+	}
+
+	if (!migrc_ubc.flush_required) {
+		spin_unlock_irqrestore(&migrc_lock, flags);
+		return;
+	}
+
+	fold_ubc(tlb_ubc, &migrc_ubc);
+	migrc_gen_next = mgen_next(migrc_gen);
+	migrc_on_flushing = true;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+
+	try_to_unmap_flush();
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	migrc_on_flushing = false;
+
+	/*
+	 * migrc_gen_done can be read by another with migrc_lock not
+	 * held so use WRITE_ONCE() to prevent tearing.
+	 */
+	WRITE_ONCE(migrc_gen_done, mgen);
+	spin_unlock_irqrestore(&migrc_lock, flags);
+}
+
+void migrc_flush(void)
+{
+	unsigned long flags;
+	unsigned short int mgen;
+
+	/*
+	 * Obtain the latest mgen number.
+	 */
+	spin_lock_irqsave(&migrc_lock, flags);
+	mgen = migrc_gen;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+
+	check_migrc_flush(mgen);
+}
+#else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
+{
+}
+static unsigned int migrc_add_pending_ubc(struct tlbflush_unmap_batch *ubc)
+{
+	return 0;
+}
+#endif
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -1090,7 +1363,8 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
 
 /* Cleanup src folio upon migration success */
 static void migrate_folio_done(struct folio *src,
-			       enum migrate_reason reason)
+			       enum migrate_reason reason,
+			       unsigned short int mgen)
 {
 	/*
 	 * Compaction can migrate also non-LRU pages which are
@@ -1101,8 +1375,15 @@ static void migrate_folio_done(struct folio *src,
 		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
 				    folio_is_file_lru(src), -folio_nr_pages(src));
 
-	if (reason != MR_MEMORY_FAILURE)
-		/* We release the page in page_handle_poison. */
+	/* We release the page in page_handle_poison. */
+	if (reason == MR_MEMORY_FAILURE) {
+		check_migrc_flush(mgen);
+		return;
+	}
+
+	if (mgen)
+		folio_put_mgen(src, mgen);
+	else
 		folio_put(src);
 }
 
@@ -1126,7 +1407,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
 		list_del(&src->lru);
-		migrate_folio_done(src, reason);
+		migrate_folio_done(src, reason, 0);
 		return MIGRATEPAGE_SUCCESS;
 	}
 
@@ -1272,7 +1553,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct folio *src, struct folio *dst,
 			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+			      struct list_head *ret, unsigned short int mgen)
 {
 	int rc;
 	int old_page_state = 0;
@@ -1322,11 +1603,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	 * and will be freed.
 	 */
 	list_del(&src->lru);
+
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-	migrate_folio_done(src, reason);
+	migrate_folio_done(src, reason, mgen);
 
 	return rc;
 out:
@@ -1616,7 +1898,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 		struct list_head *ret_folios,
 		struct migrate_pages_stats *stats,
 		int *retry, int *thp_retry, int *nr_failed,
-		int *nr_retry_pages)
+		int *nr_retry_pages, unsigned short int mgen)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
 	bool is_thp;
@@ -1633,7 +1915,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 
 		rc = migrate_folio_move(put_new_folio, private,
 				folio, dst, mode,
-				reason, ret_folios);
+				reason, ret_folios, mgen);
 		/*
 		 * The rules are:
 		 *	Success: folio will be freed
@@ -1706,24 +1988,36 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
+	bool is_zone_device = false;
 	struct folio *folio, *folio2, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
+	LIST_HEAD(unmap_folios_migrc);
+	LIST_HEAD(dst_folios_migrc);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	struct tlbflush_unmap_batch pending_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	unsigned short int mgen;
 
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
+	init_tlb_ubc(&pending_ubc);
+
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
+			bool can_migrc;
+
 			is_large = folio_test_large(folio);
 			is_thp = is_large && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
+			is_zone_device = folio_is_zone_device(folio);
 
 			cond_resched();
 
@@ -1750,9 +2044,25 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			can_migrc_init();
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
 					ret_folios);
+			can_migrc = can_migrc_test();
+
+			/*
+			 * XXX: No way to handle zone device folio after
+			 * freeing.  Remove the following constraint
+			 * once migrc can handle it.
+			 */
+			can_migrc = can_migrc && likely(!is_zone_device);
+
+			/*
+			 * XXX: Remove the following constraint once
+			 * migrc handles large folio.
+			 */
+			can_migrc = can_migrc && likely(!is_large);
+
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1798,7 +2108,8 @@ static int migrate_pages_batch(struct list_head *from,
 				/* nr_failed isn't updated for not used */
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios) &&
+				    list_empty(&unmap_folios_migrc))
 					goto out;
 				else
 					goto move;
@@ -1812,8 +2123,19 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_succeeded += is_thp;
 				break;
 			case MIGRATEPAGE_UNMAP:
-				list_move_tail(&folio->lru, &unmap_folios);
-				list_add_tail(&dst->lru, &dst_folios);
+				if (can_migrc) {
+					list_move_tail(&folio->lru, &unmap_folios_migrc);
+					list_add_tail(&dst->lru, &dst_folios_migrc);
+
+					/*
+					 * Gather ro batch data to add
+					 * to migrc_ubc after unmap.
+					 */
+					fold_ubc(&pending_ubc, tlb_ubc_ro);
+				} else {
+					list_move_tail(&folio->lru, &unmap_folios);
+					list_add_tail(&dst->lru, &dst_folios);
+				}
 				break;
 			default:
 				/*
@@ -1827,12 +2149,19 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_failed_pages += nr_pages;
 				break;
 			}
+			/*
+			 * Done with the current folio.  Fold the ro
+			 * batch data gathered to the normal batch.
+			 */
+			fold_ubc(tlb_ubc, tlb_ubc_ro);
 		}
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/* Should be before try_to_unmap_flush() */
+	mgen = migrc_add_pending_ubc(&pending_ubc);
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
@@ -1846,7 +2175,11 @@ static int migrate_pages_batch(struct list_head *from,
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-				&nr_failed, &nr_retry_pages);
+				&nr_failed, &nr_retry_pages, 0);
+		migrate_folios_move(&unmap_folios_migrc, &dst_folios_migrc,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages, mgen);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1857,6 +2190,8 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Cleanup remaining folios */
 	migrate_folios_undo(&unmap_folios, &dst_folios,
 			put_new_folio, private, ret_folios);
+	migrate_folios_undo(&unmap_folios_migrc, &dst_folios_migrc,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index d8671d0dc416..9c369aefd636 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -672,7 +672,9 @@ void try_to_unmap_flush(void)
 	if (!tlb_ubc->flush_required)
 		return;
 
+	rmap_flush_start();
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	rmap_flush_end(tlb_ubc);
 	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
@@ -707,9 +709,15 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	if (!pte_accessible(mm, pteval))
 		return;
 
-	if (pte_write(pteval) || writable)
+	if (pte_write(pteval) || writable) {
 		tlb_ubc = &current->tlb_ubc;
-	else
+
+		/*
+		 * migrc cannot work with the folio once it found a
+		 * writable or dirty mapping on it.
+		 */
+		can_migrc_fail();
+	} else
 		tlb_ubc = &current->tlb_ubc_ro;
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
-- 
2.17.1


