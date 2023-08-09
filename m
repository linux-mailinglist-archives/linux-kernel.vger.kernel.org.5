Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D45A7759DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjHILD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHILDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:03:11 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AEE1FFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:03:04 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 379B31Ur074373;
        Wed, 9 Aug 2023 20:03:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 09 Aug 2023 20:03:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 379B30sR074366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Aug 2023 20:03:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6cc13636-eda6-6a95-6564-db1c9ae76bb6@I-love.SAKURA.ne.jp>
Date:   Wed, 9 Aug 2023 20:03:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] mm/page_alloc: don't check zonelist_update_seq from atomic
 allocations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior reported that commit 1007843a9190
("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
is problematic for CONFIG_PREEMPT_RT=y case, for PREEMPT_RT kernels do not
allow holding spinlocks with interrupts disabled because PREEMPT_RT kernels
manage priority by making the spinlock sleepable.

Commit 3d36424b3b58 ("mm/page_alloc: fix race condition between
build_all_zonelists and page allocation") was obviously wrong that
that commit introduced a spinlock into !__GFP_DIRECT_RECLAIM allocations
without understanding the reality that we cannot figure out all possible
locking dependency. Like commit 726ccdba1521 ("kasan,kmsan: remove
__GFP_KSWAPD_RECLAIM usage from kasan/kmsan") says, !__GFP_DIRECT_RECLAIM
allocations might happen with arbitrary locks held. But the page allocator
does not offer a gfp flag that opts out from holding zonelist_update_seq
seqlock. Under such situations, the safer approach is not to opt in to
holding zonelist_update_seq seqlock if sleeping is not permitted.

This is an updated and optimized version of [1]. This patch eliminates

     while ((__seq = seqprop_sequence(s)) & 1)
     	   cpu_relax();

path from zonelist_iter_begin() which is always called as long as
__alloc_pages_slowpath() is called. There is no need to wait for
completion of rebuilding zonelists, for rebuilding zonelists being in
flight does not mean that allocation never succeeds. When allocation did
not fail, this "while" loop becomes nothing but a waste of CPU time.
And it is very likely that rebuilding zonelists being not in flight from
the beginning.

This patch not only avoids possibility of deadlock, but also makes
zonelist_iter_begin() faster and simpler. This change is an improvement
even without considering printk() and lockdep/KCSAN related problems.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Closes: https://lkml.kernel.org/r/20230621104034.HT6QnNkQ@linutronix.de
Link: https://lkml.kernel.org/r/dfdb9da6-ca8f-7a81-bfdd-d74b4c401f11@I-love.SAKURA.ne.jp [1]
Fixes: 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
This patch replaces "mm/page_alloc: use write_seqlock_irqsave() instead
write_seqlock() + local_irq_save()." in linux-next.git tree.

 mm/page_alloc.c | 73 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d3460c7a480..5557d9a2ff2c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3638,26 +3638,44 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
 
 /*
  * Zonelists may change due to hotplug during allocation. Detect when zonelists
- * have been rebuilt so allocation retries. Reader side does not lock and
- * retries the allocation if zonelist changes. Writer side is protected by the
- * embedded spin_lock.
+ * have been rebuilt so __GFP_DIRECT_RECLAIM allocation retries. Writer side
+ * makes this sequence odd before rebuilding zonelists and makes this sequence
+ * even after rebuilding zonelists. Sine writer side disables context switching
+ * when rebuilding zonelists, and !__GFP_DIRECT_RECLAIM allocation will not
+ * retry when zonelists changed, reader side does not need to hold a lock (but
+ * needs to use data_race() annotation), making locking dependency simpler.
  */
-static DEFINE_SEQLOCK(zonelist_update_seq);
+static unsigned int zonelist_update_seq;
 
 static unsigned int zonelist_iter_begin(void)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
-		return read_seqbegin(&zonelist_update_seq);
+		/* See comment above. */
+		return data_race(READ_ONCE(zonelist_update_seq));
 
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+static unsigned int check_retry_zonelist(gfp_t gfp, unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
-		return read_seqretry(&zonelist_update_seq, seq);
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp & __GFP_DIRECT_RECLAIM)) {
+		/* See comment above. */
+		unsigned int seq2 = data_race(READ_ONCE(zonelist_update_seq));
 
-	return seq;
+		/*
+		 * "seq != seq2" indicates that __build_all_zonelists() has
+		 * started or has finished rebuilding zonelists, hence retry.
+		 * "seq == seq2 && (seq2 & 1)" indicates that
+		 * __build_all_zonelists() is still rebuilding zonelists
+		 * with context switching disabled, hence retry.
+		 * "seq == seq2 && !(seq2 & 1)" indicates that
+		 * __build_all_zonelists() did not rebuild zonelists, hence
+		 * no retry.
+		 */
+		return unlikely(seq != seq2 || (seq2 & 1));
+	}
+
+	return 0;
 }
 
 /* Perform direct synchronous page reclaim */
@@ -4146,7 +4164,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * a unnecessary OOM kill.
 	 */
 	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
-	    check_retry_zonelist(zonelist_iter_cookie))
+	    check_retry_zonelist(gfp_mask, zonelist_iter_cookie))
 		goto restart;
 
 	/* Reclaim has failed us, start killing things */
@@ -4172,7 +4190,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * a unnecessary OOM kill.
 	 */
 	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
-	    check_retry_zonelist(zonelist_iter_cookie))
+	    check_retry_zonelist(gfp_mask, zonelist_iter_cookie))
 		goto restart;
 
 	/*
@@ -5136,22 +5154,17 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
+	static DEFINE_SPINLOCK(lock);
 	unsigned long flags;
 
-	/*
-	 * Explicitly disable this CPU's interrupts before taking seqlock
-	 * to prevent any IRQ handler from calling into the page allocator
-	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
-	 */
-	local_irq_save(flags);
-	/*
-	 * Explicitly disable this CPU's synchronous printk() before taking
-	 * seqlock to prevent any printk() from trying to hold port->lock, for
-	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
-	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
-	 */
-	printk_deferred_enter();
-	write_seqlock(&zonelist_update_seq);
+#ifdef CONFIG_PREEMPT_RT
+	migrate_disable()
+#endif
+	/* Serialize increments of zonelist_update_seq. */
+	spin_lock_irqsave(&lock, flags);
+	zonelist_update_seq++;
+	/* Tell check_retry_zonelist() that we started rebuilding zonelists. */
+	smp_wmb();
 
 #ifdef CONFIG_NUMA
 	memset(node_load, 0, sizeof(node_load));
@@ -5188,9 +5201,13 @@ static void __build_all_zonelists(void *data)
 #endif
 	}
 
-	write_sequnlock(&zonelist_update_seq);
-	printk_deferred_exit();
-	local_irq_restore(flags);
+	/* Tell check_retry_zonelist() that we finished rebuilding zonelists. */
+	smp_wmb();
+	zonelist_update_seq++;
+	spin_unlock_irqrestore(&lock, flags);
+#ifdef CONFIG_PREEMPT_RT
+	migrate_enable()
+#endif
 }
 
 static noinline void __init
-- 
2.18.4
