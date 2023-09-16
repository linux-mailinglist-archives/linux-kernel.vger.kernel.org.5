Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E65D7A2EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 10:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjIPIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbjIPIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 04:54:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B972F1720
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AlpOWelhfZuxNFmsb+NCEO45kUZ57SgYZ2VMJo6EZf4=; b=PXxE3hBt9i43smfHycQKVudTkj
        rH4zBetgksjPtSiw6AIvGkiLNnCf5zD2xS67+rP3O1csXBwvtS8o6sRS0qqsW7Yqhpdiiyn3ds1Yn
        EXB2veb4j9MpKJE2zx3b6ottrQyf1Xo1a74p/2NUqoyMSebTvgrMiJ9M1IBDiGq1x74E1+JSr827q
        9UpDDDbPt8Cp++Ikff0TYLjZEPjMShu8OisI0YswCebcb5H3quMLKz3EgZVcQoDIkQWwRtkknAcI+
        jKeopRMvMmJY/QIPy3p31vmhDqJMwhFvo3Lgk2zUk8khZu86rYelyLL6jCtNVQic3Javvk03wR/k9
        MPGnJdYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qhR1I-00AER2-2j;
        Sat, 16 Sep 2023 08:53:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF5FB300353; Sat, 16 Sep 2023 10:51:17 +0200 (CEST)
Date:   Sat, 16 Sep 2023 10:51:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <20230916085117.GA35156@noisy.programming.kicks-ass.net>
References: <20230913154907.GA26210@redhat.com>
 <20230913154953.GA26242@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154953.GA26242@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:49:53PM +0200, Oleg Nesterov wrote:
> 1. Kill the "lockmember" argument. It is always s->lock plus
>    __seqprop_##lockname##_sequence() already uses s->lock and
>    ignores "lockmember".
> 
> 2. Kill the "lock_acquire" argument. __seqprop_##lockname##_sequence()
>    can use the same "lockbase" prefix for _lock and _unlock.
> 
> Apart from line numbers, gcc -E outputs the same code.

With seqlock_ww_mutex gone, yes this is a nice cleanup.

> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/seqlock.h | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 987a59d977c5..ac6631bd5706 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -191,11 +191,9 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
>   * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
>   * @locktype:		LOCKNAME canonical C data type
>   * @preemptible:	preemptibility of above locktype
> - * @lockmember:		argument for lockdep_assert_held()
> - * @lockbase:		associated lock release function (prefix only)
> - * @lock_acquire:	associated lock acquisition function (full call)
> + * @lockbase:		prefix for associated lock/unlock
>   */
> -#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember, lockbase, lock_acquire) \
> +#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
>  typedef struct seqcount_##lockname {					\
>  	seqcount_t		seqcount;				\
>  	__SEQ_LOCK(locktype	*lock);					\
> @@ -216,7 +214,7 @@ __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
>  		return seq;						\
>  									\
>  	if (preemptible && unlikely(seq & 1)) {				\
> -		__SEQ_LOCK(lock_acquire);				\
> +		__SEQ_LOCK(lockbase##_lock(s->lock));			\
>  		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
>  									\
>  		/*							\
> @@ -242,7 +240,7 @@ __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
>  static __always_inline void						\
>  __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
>  {									\
> -	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
> +	__SEQ_LOCK(lockdep_assert_held(s->lock));			\
>  }
>  
>  /*
> @@ -271,10 +269,10 @@ static inline void __seqprop_assert(const seqcount_t *s)
>  
>  #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
>  
> -SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
> -SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
> -SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
> -SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
> +SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
> +SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
> +SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
> +SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>  
>  /*
>   * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
> -- 
> 2.25.1.362.g51ebf55
> 
