Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1097AC212
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjIWMhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjIWMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:37:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C6127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 05:37:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E446C433C7;
        Sat, 23 Sep 2023 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695472630;
        bh=bcygefpblKdJikSyubX+CQYuxg19JdqQRln729Toe5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AutvtvyfZ1hOD4BHgapyqGZBR7L427cq4Lk7TaAT4DRVF8Wb/W73D2GTFS1VyFj1w
         tl8F115j1muRg6JAQ+RFIFxghLqtK5dqVK50uHB74ERzYr5FXfcTigtU8nvt3jrfUD
         RsfsisKq0SHXbmtd37tGrD0n2OZoRTvuSFMYcZRLTWtwGPTJg27JC4yDYV0Ss5/PJv
         BsHm2AmsFZrs6JZsS5bMoqflPvLKkxpGj/E3KaGbmBlUGbvfK/kyooAOce5zpk4Yc0
         vl2a+s89HJcetbfuEXmT8qd89SZ++PVnPjOCCUGj4EUcXQa0P3aX6i5u5albS+nPcZ
         qyInkmmL2LdIQ==
Date:   Sat, 23 Sep 2023 14:37:05 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] time,signal: turn signal_struct.stats_lock into
 seqcount_rwlock_t
Message-ID: <ZQ7b8T9aA3UUHdOT@example.org>
References: <20230913154907.GA26210@redhat.com>
 <20230913155009.GA26255@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913155009.GA26255@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:50:09PM +0200, Oleg Nesterov wrote:
> This way thread_group_cputime() doesn't exclude other readers on the
> 2nd pass.
> 
> thread_group_cputime() still needs to disable irqs because stats_lock
> nests inside siglock. But once we change the getrusage()-like users to
> rely on stats_lock we can remove this dependency, and after that there
> will be no need for _irqsave.
> 
> And IIUC, this is the bugfix for CONFIG_PREEMPT_RT? Before this patch
> read_seqbegin_or_lock() can spin in __read_seqcount_begin() while the
> write_seqlock(stats_lock) section was preempted.
> 
> While at it, change the main loop to use __for_each_thread(sig, t).
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/sched/signal.h |  4 +++-
>  kernel/exit.c                | 12 ++++++++----
>  kernel/fork.c                |  3 ++-
>  kernel/sched/cputime.c       | 10 ++++++----
>  4 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index d7fa3ca2fa53..c7c0928b877d 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -182,7 +182,9 @@ struct signal_struct {
>  	 * Live threads maintain their own counters and add to these
>  	 * in __exit_signal, except for the group leader.
>  	 */
> -	seqlock_t stats_lock;
> +	rwlock_t stats_lock;
> +	seqcount_rwlock_t stats_seqc;
> +
>  	u64 utime, stime, cutime, cstime;
>  	u64 gtime;
>  	u64 cgtime;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f3ba4b97a7d9..8dedb7138f9c 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -182,7 +182,8 @@ static void __exit_signal(struct task_struct *tsk)
>  	 * see the empty ->thread_head list.
>  	 */
>  	task_cputime(tsk, &utime, &stime);
> -	write_seqlock(&sig->stats_lock);
> +	write_lock(&sig->stats_lock);
> +	write_seqcount_begin(&sig->stats_seqc);
>  	sig->utime += utime;
>  	sig->stime += stime;
>  	sig->gtime += task_gtime(tsk);
> @@ -196,7 +197,8 @@ static void __exit_signal(struct task_struct *tsk)
>  	sig->sum_sched_runtime += tsk->se.sum_exec_runtime;
>  	sig->nr_threads--;
>  	__unhash_process(tsk, group_dead);
> -	write_sequnlock(&sig->stats_lock);
> +	write_seqcount_end(&sig->stats_seqc);
> +	write_unlock(&sig->stats_lock);
>  
>  	/*
>  	 * Do this under ->siglock, we can race with another thread
> @@ -1160,7 +1162,8 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  		 */
>  		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
>  		spin_lock_irq(&current->sighand->siglock);
> -		write_seqlock(&psig->stats_lock);
> +		write_lock(&psig->stats_lock);
> +		write_seqcount_begin(&psig->stats_seqc);
>  		psig->cutime += tgutime + sig->cutime;
>  		psig->cstime += tgstime + sig->cstime;
>  		psig->cgtime += task_gtime(p) + sig->gtime + sig->cgtime;
> @@ -1183,7 +1186,8 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  			psig->cmaxrss = maxrss;
>  		task_io_accounting_add(&psig->ioac, &p->ioac);
>  		task_io_accounting_add(&psig->ioac, &sig->ioac);
> -		write_sequnlock(&psig->stats_lock);
> +		write_seqcount_end(&psig->stats_seqc);
> +		write_unlock(&psig->stats_lock);
>  		spin_unlock_irq(&current->sighand->siglock);
>  	}
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b9d3aa493bbd..bbd5604053f8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1870,7 +1870,8 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>  	sig->curr_target = tsk;
>  	init_sigpending(&sig->shared_pending);
>  	INIT_HLIST_HEAD(&sig->multiprocess);
> -	seqlock_init(&sig->stats_lock);
> +	rwlock_init(&sig->stats_lock);
> +	seqcount_rwlock_init(&sig->stats_seqc, &sig->stats_lock);
>  	prev_cputime_init(&sig->prev_cputime);
>  
>  #ifdef CONFIG_POSIX_TIMERS
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..bd6a85bd2a49 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -333,12 +333,13 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
>  	nextseq = 0;
>  	do {
>  		seq = nextseq;
> -		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
> +		flags = read_seqcount_begin_or_lock_irqsave(&sig->stats_seqc,
> +						     &sig->stats_lock, &seq);
>  		times->utime = sig->utime;
>  		times->stime = sig->stime;
>  		times->sum_exec_runtime = sig->sum_sched_runtime;
>  
> -		for_each_thread(tsk, t) {
> +		__for_each_thread(sig, t) {
>  			task_cputime(t, &utime, &stime);
>  			times->utime += utime;
>  			times->stime += stime;
> @@ -346,8 +347,9 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
>  		}
>  		/* If lockless access failed, take the lock. */
>  		nextseq = 1;

I think you're right, and indeed there is a possible situation here
where write_seqlock will force all readers to take locks one after
another.

I really don’t know how critical it is in this place.

> -	} while (need_seqretry(&sig->stats_lock, seq));
> -	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
> +	} while (need_seqcount_retry(&sig->stats_seqc, seq));
> +	done_seqcount_retry_irqrestore(&sig->stats_seqc, &sig->stats_lock,
> +					seq, flags);
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.25.1.362.g51ebf55
> 

-- 
Rgrds, legion

