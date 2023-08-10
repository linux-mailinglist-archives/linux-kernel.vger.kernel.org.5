Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89085777530
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjHJJ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHJJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:03 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB12E42
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:02 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 37A9wx2X092256;
        Thu, 10 Aug 2023 18:58:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 10 Aug 2023 18:58:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 37A9wxvM092250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Aug 2023 18:58:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <566173d4-84d1-c76b-6fe4-f5ea5f24f613@I-love.SAKURA.ne.jp>
Date:   Thu, 10 Aug 2023 18:58:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] mm/page_alloc: don't check zonelist_update_seq from
 atomic allocations
Content-Language: en-US
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230810072637.6Sc3UU3R@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/10 16:26, Sebastian Andrzej Siewior wrote:
> On 2023-08-09 20:03:00 [+0900], Tetsuo Handa wrote:
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 7d3460c7a480..5557d9a2ff2c 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3638,26 +3638,44 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
> …
>> -static DEFINE_SEQLOCK(zonelist_update_seq);
>> +static unsigned int zonelist_update_seq;
>>  
>>  static unsigned int zonelist_iter_begin(void)
>>  {
>>  	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
>> -		return read_seqbegin(&zonelist_update_seq);
>> +		/* See comment above. */
>> +		return data_race(READ_ONCE(zonelist_update_seq));
> 
> This is open coded raw_read_seqcount() while it should have been
> raw_seqcount_begin().

Not an open coded raw_read_seqcount(). You explained us at
https://lkml.kernel.org/r/20230623101111.7tuAg5p5@linutronix.de that
seqprop_sequence() behaves differently if CONFIG_PREEMPT_RT=y.

The point of my proposal is to get rid of

  spin_lock(s->lock);
  spin_unlock(s->lock);

 from zonelist_iter_begin().

Also, my version avoids KCSAN warning by using data_race() and avoids papering
over KCSAN warnings between zonelist_iter_begin() and check_retry_zonelist()
by not using kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX).

  /*
   * The seqlock seqcount_t interface does not prescribe a precise sequence of
   * read begin/retry/end. For readers, typically there is a call to
   * read_seqcount_begin() and read_seqcount_retry(), however, there are more
   * esoteric cases which do not follow this pattern.
   *
   * As a consequence, we take the following best-effort approach for raw usage
   * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
   * pessimistically mark the next KCSAN_SEQLOCK_REGION_MAX memory accesses as
   * atomics; if there is a matching read_seqcount_retry() call, no following
   * memory operations are considered atomic. Usage of the seqlock_t interface
   * is not affected.
   */

The section between zonelist_iter_begin() and check_retry_zonelist() is very
complicated where concurrency bug that is unrelated to zonelist counters could
be found and fixed.

> 
>>  	return 0;
>>  }
>>  
>> -static unsigned int check_retry_zonelist(unsigned int seq)
>> +static unsigned int check_retry_zonelist(gfp_t gfp, unsigned int seq)
>>  {
>> -	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
>> -		return read_seqretry(&zonelist_update_seq, seq);
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp & __GFP_DIRECT_RECLAIM)) {
>> +		/* See comment above. */
>> +		unsigned int seq2 = data_race(READ_ONCE(zonelist_update_seq));
>>  
>> -	return seq;
>> +		/*
>> +		 * "seq != seq2" indicates that __build_all_zonelists() has
>> +		 * started or has finished rebuilding zonelists, hence retry.
>> +		 * "seq == seq2 && (seq2 & 1)" indicates that
>> +		 * __build_all_zonelists() is still rebuilding zonelists
>> +		 * with context switching disabled, hence retry.
>> +		 * "seq == seq2 && !(seq2 & 1)" indicates that
>> +		 * __build_all_zonelists() did not rebuild zonelists, hence
>> +		 * no retry.
>> +		 */
>> +		return unlikely(seq != seq2 || (seq2 & 1));
> 
> open coded read_seqcount_retry().

Not an open coded read_seqcount_retry(), for read_seqcount_retry() checks
only "seq != seq2" condition. We need to check "seq2 & 1" condition too.

> 
>> +	}
>> +
>> +	return 0;
>>  }
>>  
>>  /* Perform direct synchronous page reclaim */
>> @@ -5136,22 +5154,17 @@ static void __build_all_zonelists(void *data)
>>  	int nid;
>>  	int __maybe_unused cpu;
>>  	pg_data_t *self = data;
>> +	static DEFINE_SPINLOCK(lock);
>>  	unsigned long flags;
>>  
>> -	/*
>> -	 * Explicitly disable this CPU's interrupts before taking seqlock
>> -	 * to prevent any IRQ handler from calling into the page allocator
>> -	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
>> -	 */
>> -	local_irq_save(flags);
>> -	/*
>> -	 * Explicitly disable this CPU's synchronous printk() before taking
>> -	 * seqlock to prevent any printk() from trying to hold port->lock, for
>> -	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
>> -	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
>> -	 */
>> -	printk_deferred_enter();
>> -	write_seqlock(&zonelist_update_seq);
>> +#ifdef CONFIG_PREEMPT_RT
>> +	migrate_disable()
>> +#endif
> 
> There is no justification/ explanation why migrate_disable() here is
> needed on PREEMPT_RT and I don't see one.

This migrate_disable() is a compensation for removing

  spin_lock(s->lock);
  spin_unlock(s->lock);

 from zonelist_iter_begin(). Since neither the proposed zonelist_iter_begin()
nor the proposed check_retry_zonelist() holds the spinlock, we need to
guarantee that the thread which has performed the opening zonelist_update_seq++
can continue execution till the closing zonelist_update_seq++ without sleeping.
Calling interrupt handlers are fine, for interrupt handlers can't do
__GFP_DIRECT_RECLAIM allocation, which in turn guarantees that interrupt
handlers switched from the thread which has performed the opening
zonelist_update_seq++ won't deadlock.

> 
> There are two changes here:
> - The replacement of seqlock_t with something open coded 

Yes.

> - Logic change when a retry is needed (the gfp mask is considered).

Yes.

> 
> I am not a big fan of open coding things especially when not needed and
> then there is this ifdef which is not needed as well. I don't comment on
> the logic change.

If __build_all_zonelists() can run without being switched to other threads
(except interrupt handlers), I consider that this approach works.

> 
> Can we please put an end to this?
> 
>> +	/* Serialize increments of zonelist_update_seq. */
>> +	spin_lock_irqsave(&lock, flags);
>> +	zonelist_update_seq++;
>> +	/* Tell check_retry_zonelist() that we started rebuilding zonelists. */
>> +	smp_wmb();
>>  
>>  #ifdef CONFIG_NUMA
>>  	memset(node_load, 0, sizeof(node_load));
> 
> Sebastian
> 

