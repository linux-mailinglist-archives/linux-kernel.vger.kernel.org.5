Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F2767E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjG2LFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjG2LFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:05:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CD3AB9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:05:47 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 36TB5jLB045161;
        Sat, 29 Jul 2023 20:05:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 29 Jul 2023 20:05:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 36TB5iJX045156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jul 2023 20:05:45 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <649fa1a7-4efd-8cc7-92c7-ac7944adc283@I-love.SAKURA.ne.jp>
Date:   Sat, 29 Jul 2023 20:05:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de> <ZJmkPuqpW-wQAyNz@alley>
 <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
 <20230727151029.e_M9bi8N@linutronix.de>
 <b6ba16ce-4849-d32c-68fe-07a15aaf9d9c@I-love.SAKURA.ne.jp>
In-Reply-To: <b6ba16ce-4849-d32c-68fe-07a15aaf9d9c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/07/29 14:31, Tetsuo Handa wrote:
> On 2023/07/28 0:10, Sebastian Andrzej Siewior wrote:
>> On 2023-06-28 21:14:16 [+0900], Tetsuo Handa wrote:
>>>> Anyway, please do not do this change only because of printk().
>>>> IMHO, the current ordering is more logical and the printk() problem
>>>> should be solved another way.
>>>
>>> Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
>>> rejected.
>>
>> My understanding is that this patch gets applied and your objection will
>> be noted.
> 
> My preference is that zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
> allocations, which is a low-hanging fruit towards GFP_LOCKLESS mentioned at
> https://lkml.kernel.org/r/ZG3+l4qcCWTPtSMD@dhcp22.suse.cz and
> https://lkml.kernel.org/r/ZJWWpGZMJIADQvRS@dhcp22.suse.cz .
> 
> Maybe we can defer checking zonelist_update_seq till retry check like below,
> for this is really an infrequent event.
> 

An updated version with comments added.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d3460c7a480..92ecf5f2f76b 100644
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
+		 * __build_all_zonelists() did not rebuilt zonelists, hence
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


