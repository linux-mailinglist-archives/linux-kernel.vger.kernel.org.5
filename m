Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A867A24F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjIORhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjIORhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:37:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0CA30FA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:36:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDAC433C8;
        Fri, 15 Sep 2023 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694799413;
        bh=aJ4FekGO2yxS7/H8mMlnT0UbBI9AQ2x1g0mD69B7N1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqLQRXJys8O9EzE6WzvwxQ/6jrGZL+ZZrFD8Yfo+lsBtopoPnLxuBiCf1DVSTEu9r
         Z4ioTxXoXIC5bRl4fxhq0jtKItGsC72aKnf1q219OjdcdmmpbuFi3ZL3owkfOnC0kY
         IhvYv3/fQ5RZernNNPiegAuI4x35cuP+iaU30twsiebcj+T6m/AqkmComE6tEK/D3N
         KMlxMFCpwMz3BR6QvkUfoYgcxnspmxigcgL2CgnBscdzMaTAmgKY5C9B7MbD6Kr6WD
         JFI2e65Z13Zal8BrU6Qzw7tewGkCLQ0rMAXW620Z2JnA3NAersHFCf9ywXu0m+qV8K
         Ae1rfBp5B4WSQ==
Date:   Fri, 15 Sep 2023 19:36:47 +0200
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
Subject: Re: [PATCH 1/5] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <ZQSWL4/TMncvtx0i@example.org>
References: <20230913154907.GA26210@redhat.com>
 <20230913154953.GA26242@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154953.GA26242@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:49:53PM +0200, Oleg Nesterov wrote:
> 1. Kill the "lockmember" argument. It is always s->lock plus
>    __seqprop_##lockname##_sequence() already uses s->lock and
>    ignores "lockmember".

typedef struct seqcount_##lockname {					\
	seqcount_t		seqcount;				\
	__SEQ_LOCK(locktype	*lock);					\
                                 ^^^^

and also lockmember was not used in the definition! :)
Thanks for bugfix!

Reviewed-by: Alexey Gladkov <legion@kernel.org>

> 2. Kill the "lock_acquire" argument. __seqprop_##lockname##_sequence()
>    can use the same "lockbase" prefix for _lock and _unlock.
> 
> Apart from line numbers, gcc -E outputs the same code.
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

-- 
Rgrds, legion

