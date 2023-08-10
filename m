Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E31777C45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjHJPfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbjHJPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:35:10 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBDB270A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:35:08 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37AFZ6FH067394;
        Fri, 11 Aug 2023 00:35:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 11 Aug 2023 00:35:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37AFZ50L067391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Aug 2023 00:35:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f39a7ebf-d67a-1535-271f-388d639cfa9a@I-love.SAKURA.ne.jp>
Date:   Fri, 11 Aug 2023 00:35:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] mm/page_alloc: don't check zonelist_update_seq from
 atomic allocations
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
References: <6cc13636-eda6-6a95-6564-db1c9ae76bb6@I-love.SAKURA.ne.jp>
 <20230810072637.6Sc3UU3R@linutronix.de>
 <566173d4-84d1-c76b-6fe4-f5ea5f24f613@I-love.SAKURA.ne.jp>
In-Reply-To: <566173d4-84d1-c76b-6fe4-f5ea5f24f613@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/10 18:58, Tetsuo Handa wrote:
> If __build_all_zonelists() can run without being switched to other threads
> (except interrupt handlers), I consider that this approach works.

If there is no way to make sure that the section between
write_seqlock(&zonelist_update_seq) and write_sequnlock(&zonelist_update_seq)
runs without context switching (interrupts handlers are fine), something like
below could be used in order to keep

  spin_lock(s->lock);
  spin_unlock(s->lock);

away from seqprop_sequence() from atomic allocations. But I think that looses
the reason to replace read_seqbegin() with raw_seqcount_begin(); that will be
essentially the same with
https://lkml.kernel.org/r/dfdb9da6-ca8f-7a81-bfdd-d74b4c401f11@I-love.SAKURA.ne.jp .



diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d3460c7a480..f2f79caab2cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3644,20 +3644,20 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  */
 static DEFINE_SEQLOCK(zonelist_update_seq);
 
-static unsigned int zonelist_iter_begin(void)
+static unsigned int zonelist_iter_begin(gfp_t gfp)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
-		return read_seqbegin(&zonelist_update_seq);
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp & __GFP_DIRECT_RECLAIM))
+		return data_race(raw_seqcount_begin(&zonelist_update_seq.seqcount));
 
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+static unsigned int check_retry_zonelist(gfp_t gfp, unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
-		return read_seqretry(&zonelist_update_seq, seq);
+	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp & __GFP_DIRECT_RECLAIM))
+		return data_race(read_seqcount_retry(&zonelist_update_seq.seqcount, seq));
 
-	return seq;
+	return 0;
 }
 
 /* Perform direct synchronous page reclaim */
@@ -3968,7 +3968,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	no_progress_loops = 0;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
-	zonelist_iter_cookie = zonelist_iter_begin();
+	zonelist_iter_cookie = zonelist_iter_begin(gfp_mask);
 
 	/*
 	 * The fast path uses conservative alloc_flags to succeed only until
@@ -4146,7 +4146,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * a unnecessary OOM kill.
 	 */
 	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
-	    check_retry_zonelist(zonelist_iter_cookie))
+	    check_retry_zonelist(gfp_mask, zonelist_iter_cookie))
 		goto restart;
 
 	/* Reclaim has failed us, start killing things */
@@ -4172,7 +4172,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * a unnecessary OOM kill.
 	 */
 	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
-	    check_retry_zonelist(zonelist_iter_cookie))
+	    check_retry_zonelist(gfp_mask, zonelist_iter_cookie))
 		goto restart;
 
 	/*
@@ -5138,20 +5138,7 @@ static void __build_all_zonelists(void *data)
 	pg_data_t *self = data;
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
+	write_seqlock_irqsave(&zonelist_update_seq, flags);
 
 #ifdef CONFIG_NUMA
 	memset(node_load, 0, sizeof(node_load));
@@ -5188,9 +5175,7 @@ static void __build_all_zonelists(void *data)
 #endif
 	}
 
-	write_sequnlock(&zonelist_update_seq);
-	printk_deferred_exit();
-	local_irq_restore(flags);
+	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
 }
 
 static noinline void __init

