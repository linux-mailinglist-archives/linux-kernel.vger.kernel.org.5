Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F47D51E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjJXNgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjJXNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D50859DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698153934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVvmHaW44kmFnrNDGsSIIetA6WaIzZe9yR4+bN0hZ3s=;
        b=Eyex0UDJOYgoqF+nM5UO76lD+7iJhX68Nfpw3Wx4v/73Ltxk6HLKoNpkurP4X8NVunRdpg
        DXyS60yZNYsQtjvLzkHiB0CjDL9lo005L0yPKJ08TWEZAGa0S9P5u/HzRA4+MquqttAbMe
        HIrHh5AUGX/OFIizQ/E844YpMhHsTSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-mV2pcPg7NnGJufnQNKGmDw-1; Tue, 24 Oct 2023 09:25:19 -0400
X-MC-Unique: mV2pcPg7NnGJufnQNKGmDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5915B811E86;
        Tue, 24 Oct 2023 13:25:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id F2A7225C0;
        Tue, 24 Oct 2023 13:25:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 24 Oct 2023 15:24:18 +0200 (CEST)
Date:   Tue, 24 Oct 2023 15:24:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] seqlock: introduce need_seqretry_xxx()
Message-ID: <20231024132414.GA23757@redhat.com>
References: <20231024120808.GA15382@redhat.com>
 <20231024120840.GA15391@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024120840.GA15391@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or perhaps even something like

	static inline int xxx(seqlock_t *lock, int *seq, int lockless)
	{
		if (lockless) {
			*seq = read_seqbegin(lock);
			return 1;
		}

		if (*seq & 1) {
			read_sequnlock_excl(lock);
			return 0;
		}

		if (read_seqretry(lock, *seq)) {
			read_seqlock_excl(lock);
			*seq = 1;
			return 1;
		}

		return 0;

	}

	#define __XXX(lock, seq, lockless)	\
		for (int lockless = 1, seq; xxx(lock, &seq, lockless); lockless = 0)

	#define XXX(lock)	\
		__XXX(lock, __UNIQUE_ID(seq), __UNIQUE_ID(lockless))


? This way one can do

	seqlock_t sl;

	void func(void)
	{
		XXX(&sl) {
			... read-side critical section ...
		}
	}

using the single XXX() helper, no need to declare/initialize seq, no need to call
need_seqretry/done_seqretry.

What do you think?

Oleg.


On 10/24, Oleg Nesterov wrote:
>
> Not for inclusion, just for discussion...
>
> Modulo naming, do you think the new need_seqretry_xxx() makes sense?
>
> Simpler to use and less error prone. thread_group_cputime() is changed
> as an example.
> ---
>  include/linux/seqlock.h | 10 ++++++++++
>  kernel/sched/cputime.c  |  9 +++------
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index d0050c889f26..9b3bc4ce3332 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1165,6 +1165,16 @@ static inline int need_seqretry(seqlock_t *lock, int seq)
>  	return !(seq & 1) && read_seqretry(lock, seq);
>  }
>
> +static inline int need_seqretry_xxx(seqlock_t *lock, int *seq)
> +{
> +	int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> +
> +	if (ret)
> +		++*seq;	/* make this counter odd */
> +
> +	return ret;
> +}
> +
>  /**
>   * done_seqretry() - end seqlock_t "locking or lockless" reader section
>   * @lock: Pointer to seqlock_t
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..45704a84baec 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -314,7 +314,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
>  	struct signal_struct *sig = tsk->signal;
>  	u64 utime, stime;
>  	struct task_struct *t;
> -	unsigned int seq, nextseq;
> +	unsigned int seq;
>  	unsigned long flags;
>
>  	/*
> @@ -330,9 +330,8 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
>
>  	rcu_read_lock();
>  	/* Attempt a lockless read on the first round. */
> -	nextseq = 0;
> +	seq = 0;
>  	do {
> -		seq = nextseq;
>  		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
>  		times->utime = sig->utime;
>  		times->stime = sig->stime;
> @@ -344,9 +343,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
>  			times->stime += stime;
>  			times->sum_exec_runtime += read_sum_exec_runtime(t);
>  		}
> -		/* If lockless access failed, take the lock. */
> -		nextseq = 1;
> -	} while (need_seqretry(&sig->stats_lock, seq));
> +	} while (need_seqretry_xxx(&sig->stats_lock, &seq));
>  	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
>  	rcu_read_unlock();
>  }
> --
> 2.25.1.362.g51ebf55
>

