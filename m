Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7578E06B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjH3URC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjH3URA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:17:00 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853FACDC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:16:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8EFD960174;
        Wed, 30 Aug 2023 21:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693424941; bh=so8YqI2SWj5niLlEAjXtC9dyNfVHBlkFMxSgrXze2zk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XwnB0xR+VkJ3KXRVGZ1EpWtSuOGWihju/qS4en7dYbXhxlzAlAzya0tJAamqihtJB
         MkXBC3G4m1JWJAfA37GdqAdk1qQ6xEgUrIBzaAsatZeaKdP+uKa6+oQoRi7PhbvCRs
         Ey6M2oiiHp4yY7ikor+bu3wGY9EOO792aEwfbnCTAmYOmqYmiPxzozwy7X2VPqmW+n
         L2QCrS5DFIyw02LsjzqElsk4VQkRMxe5WLdvH4YXSIykclsWqX6ujv+3F9bw0PgcnW
         Dsss0GfSxNqK1iTvpzclFNxEdJ9FKr7DA+am/PoOgZOjRvyxvqFoeUCcMBaGpRz8aW
         B8D44UI7ldM7g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FyXgOSrzJ-PS; Wed, 30 Aug 2023 21:48:57 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id AEE4A60173;
        Wed, 30 Aug 2023 21:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1693424937; bh=so8YqI2SWj5niLlEAjXtC9dyNfVHBlkFMxSgrXze2zk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ATRk2lzkcZhc4zyvQJN7Kb+I+ufmLiog74Hx8AA6ISsysZFJtaR1kGQoCMN/lvF5W
         bC2NvLOaYZTgk15KZfYkU9Pwxsi8BlwmyA9st08/nsBwyxBTjmhGeWY5axKVObG352
         KTjQgIxYY7UKvMr5nIs3DBtw5Td7CDOOWNOAARTSW+f8Twyt92r2BjTK7z9W1CTdvH
         Q1jYh2sb+VU9V2bwVO81iFwgPKpy4ftqDW/llpgGeetfM+49ww/YHj7yJ93Qbl/A/4
         cA/HJNGpCAVH8TLGdihOSM3h+hRTwp1Lrav0RaCEd9Y7vmrkopevgXDCKnJmmyPUL4
         D+CuxWEHUMIhg==
Message-ID: <e5120df6-19f7-da11-1c53-e16fb92d9098@alu.unizg.hr>
Date:   Wed, 30 Aug 2023 21:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/1] workqueue: fix data race with the pwq->stats[]
 increment
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20230826145102.5962-1-mirsad.todorovac@alu.unizg.hr>
 <ZO5Mk4a_LylG2AdM@slm.duckdns.org>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZO5Mk4a_LylG2AdM@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 21:52, Tejun Heo wrote:
> On Sat, Aug 26, 2023 at 04:51:03PM +0200, Mirsad Goran Todorovac wrote:
>> KCSAN has discovered a data race in kernel/workqueue.c:2598:
>>
>> [ 1863.554079] ==================================================================
>> [ 1863.554118] BUG: KCSAN: data-race in process_one_work / process_one_work
>>
>> [ 1863.554142] write to 0xffff963d99d79998 of 8 bytes by task 5394 on cpu 27:
>> [ 1863.554154] process_one_work (kernel/workqueue.c:2598)
>> [ 1863.554166] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
>> [ 1863.554177] kthread (kernel/kthread.c:389)
>> [ 1863.554186] ret_from_fork (arch/x86/kernel/process.c:145)
>> [ 1863.554197] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>>
>> [ 1863.554213] read to 0xffff963d99d79998 of 8 bytes by task 5450 on cpu 12:
>> [ 1863.554224] process_one_work (kernel/workqueue.c:2598)
>> [ 1863.554235] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
>> [ 1863.554247] kthread (kernel/kthread.c:389)
>> [ 1863.554255] ret_from_fork (arch/x86/kernel/process.c:145)
>> [ 1863.554266] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>>
>> [ 1863.554280] value changed: 0x0000000000001766 -> 0x000000000000176a
>>
>> [ 1863.554295] Reported by Kernel Concurrency Sanitizer on:
>> [ 1863.554303] CPU: 12 PID: 5450 Comm: kworker/u64:1 Tainted: G             L     6.5.0-rc6+ #44
>> [ 1863.554314] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 1863.554322] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>> [ 1863.554941] ==================================================================
>>
>>      lockdep_invariant_state(true);
>> →   pwq->stats[PWQ_STAT_STARTED]++;
>>      trace_workqueue_execute_start(work);
>>      worker->current_func(work);
>>
>> Moving pwq->stats[PWQ_STAT_STARTED]++; before the line
>>
>>      raw_spin_unlock_irq(&pool->lock);
>>
>> resolves the data race without performance penalty.
>>
>> KCSAN detected at least one additional data race:
>>
>> [  157.834751] ==================================================================
>> [  157.834770] BUG: KCSAN: data-race in process_one_work / process_one_work
>>
>> [  157.834793] write to 0xffff9934453f77a0 of 8 bytes by task 468 on cpu 29:
>> [  157.834804] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606)
>> [  157.834815] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752)
>> [  157.834826] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389)
>> [  157.834834] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145)
>> [  157.834845] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312)
>>
>> [  157.834859] read to 0xffff9934453f77a0 of 8 bytes by task 214 on cpu 7:
>> [  157.834868] process_one_work (/home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2606)
>> [  157.834879] worker_thread (/home/marvin/linux/kernel/linux_torvalds/./include/linux/list.h:292 /home/marvin/linux/kernel/linux_torvalds/kernel/workqueue.c:2752)
>> [  157.834890] kthread (/home/marvin/linux/kernel/linux_torvalds/kernel/kthread.c:389)
>> [  157.834897] ret_from_fork (/home/marvin/linux/kernel/linux_torvalds/arch/x86/kernel/process.c:145)
>> [  157.834907] ret_from_fork_asm (/home/marvin/linux/kernel/linux_torvalds/arch/x86/entry/entry_64.S:312)
>>
>> [  157.834920] value changed: 0x000000000000052a -> 0x0000000000000532
>>
>> [  157.834933] Reported by Kernel Concurrency Sanitizer on:
>> [  157.834941] CPU: 7 PID: 214 Comm: kworker/u64:2 Tainted: G             L     6.5.0-rc7-kcsan-00169-g81eaf55a60fc #4
>> [  157.834951] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [  157.834958] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>> [  157.835567] ==================================================================
>>
>> in code:
>>
>>          trace_workqueue_execute_end(work, worker->current_func);
>> →       pwq->stats[PWQ_STAT_COMPLETED]++;
>>          lock_map_release(&lockdep_map);
>>          lock_map_release(&pwq->wq->lockdep_map);
>>
>> which needs to be resolved separately.
>>
>> Fixes: 725e8ec59c56c ("workqueue: Add pwq->stats[] and a monitoring script")
>> Cc: Tejun Heo <tj@kernel.org>
>> Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
>> Link: https://lore.kernel.org/lkml/20230818194448.29672-1-mirsad.todorovac@alu.unizg.hr/
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Applied to wq/for-6.6.
> 
> Thanks.

Glad it worked out-of-the-box ...

Now, what should we do with the

           trace_workqueue_execute_end(work, worker->current_func);
  →        pwq->stats[PWQ_STAT_COMPLETED]++;
           lock_map_release(&lockdep_map);
           lock_map_release(&pwq->wq->lockdep_map);

???

There seem to be 8 occurrences of the use of pwq->stats[] ...

Some are protected with spinlocks:

-1/8-[SAFE PROTECTED]--------------------------
	raw_spin_lock_irq(&pool->lock);

	/*
	 * Recheck in case unbind_workers() preempted us. We don't
	 * want to decrement nr_running after the worker is unbound
	 * and nr_running has been reset.
	 */
	if (worker->flags & WORKER_NOT_RUNNING) {
		raw_spin_unlock_irq(&pool->lock);
		return;
	}

	pool->nr_running--;
	if (need_more_worker(pool)) {
→		worker->current_pwq->stats[PWQ_STAT_CM_WAKEUP]++;
		wake_up_worker(pool);
	}
	raw_spin_unlock_irq(&pool->lock);
-----------------------------------------------

This isn't, but the other one is:
-2/8-[POSSIBLE DATA RACE]----------------------
	if (!pwq)
		return;

→	pwq->stats[PWQ_STAT_CPU_TIME] += TICK_USEC;

	if (!wq_cpu_intensive_thresh_us)
		return;
-----------------------------------------------

-3+4/8--[SAFE BETWEEN LOCK AND UNLOCK]----------
	raw_spin_lock(&pool->lock);

	worker_set_flags(worker, WORKER_CPU_INTENSIVE);
	wq_cpu_intensive_report(worker->current_func);
→	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;

	if (need_more_worker(pool)) {
→		pwq->stats[PWQ_STAT_CM_WAKEUP]++;
		wake_up_worker(pool);
	}

	raw_spin_unlock(&pool->lock);
-------------------------------------------------

This one I don't know:
-5/8-[SUSPICIOUS FOR A RACE]---------------------
	if (list_empty(&pwq->mayday_node)) {
		/*
		 * If @pwq is for an unbound wq, its base ref may be put at
		 * any time due to an attribute change.  Pin @pwq until the
		 * rescuer is done with it.
		 */
		get_pwq(pwq);
		list_add_tail(&pwq->mayday_node, &wq->maydays);
		wake_up_process(wq->rescuer->task);
→		pwq->stats[PWQ_STAT_MAYDAY]++;
	}
-------------------------------------------------

This one we just solved:

-6/8-[WE JUST SOLVED THIS ONE]-------------------
	lockdep_invariant_state(true);
→	pwq->stats[PWQ_STAT_STARTED]++;
	trace_workqueue_execute_start(work);
	worker->current_func(work);
-------------------------------------------------


-7/8-[A CANDIDATE FOR atomic_inc() ??? ]---------
	trace_workqueue_execute_end(work, worker->current_func);
→	pwq->stats[PWQ_STAT_COMPLETED]++;
	lock_map_release(&lockdep_map);
	lock_map_release(&pwq->wq->lockdep_map);
-------------------------------------------------

-8/8-[SAFE BETWEEN LOCK AND UNLOCK]--------------
		raw_spin_lock_irq(&pool->lock);

		/*
		 * Slurp in all works issued via this workqueue and
		 * process'em.
		 */
		WARN_ON_ONCE(!list_empty(scheduled));
		list_for_each_entry_safe(work, n, &pool->worklist, entry) {
			if (get_work_pwq(work) == pwq) {
				if (first)
					pool->watchdog_ts = jiffies;
				move_linked_works(work, scheduled, &n);
→				pwq->stats[PWQ_STAT_RESCUED]++;
			}
			first = false;
		}

		if (!list_empty(scheduled)) {
			process_scheduled_works(rescuer);

			/*
			 * The above execution of rescued work items could
			 * have created more to rescue through
			 * pwq_activate_first_inactive() or chained
			 * queueing.  Let's put @pwq back on mayday list so
			 * that such back-to-back work items, which may be
			 * being used to relieve memory pressure, don't
			 * incur MAYDAY_INTERVAL delay inbetween.
			 */
			if (pwq->nr_active && need_to_create_worker(pool)) {
				raw_spin_lock(&wq_mayday_lock);
				/*
				 * Queue iff we aren't racing destruction
				 * and somebody else hasn't queued it already.
				 */
				if (wq->rescuer && list_empty(&pwq->mayday_node)) {
					get_pwq(pwq);
					list_add_tail(&pwq->mayday_node, &wq->maydays);
				}
				raw_spin_unlock(&wq_mayday_lock);
			}
		}

		/*
		 * Put the reference grabbed by send_mayday().  @pool won't
		 * go away while we're still attached to it.
		 */
		put_pwq(pwq);

		/*
		 * Leave this pool.  If need_more_worker() is %true, notify a
		 * regular worker; otherwise, we end up with 0 concurrency
		 * and stalling the execution.
		 */
		if (need_more_worker(pool))
			wake_up_worker(pool);

		raw_spin_unlock_irq(&pool->lock);
-----------------------------------------------------

These might just not have been triggered yet, but logically they seem suspicious for a data race.
I still have to verify if they are called from a locked context ...

Of course, as the original developer, you will have a clearer picture. I have been led by KCSAN
to this particular detail.

Hope this helps.

Best regards,
Mirsad Todorovac
