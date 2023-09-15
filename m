Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3985C7A25AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjIOS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjIOSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:25:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761212D5D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:25:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9961EC433C8;
        Fri, 15 Sep 2023 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694802336;
        bh=tI4aIfone71e2rJtw81f/6/MavNYU+k1+mNvMUh5TA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Atqv/D9RjXan1oJbtAgBvbdJRn03JAT/MvFlzWwRNZ2oZr8jFZU7pJDgBdecw7Go0
         7edHXyg9udHnr4MAzrNPXWy4+2/AzvvCsBTY0/q2ZhUKTEmkVwAtSE5eKCNTdMY7+r
         EJ3k0zKnaCj9goknDZrM8VkHhp2gF1l2IvwY0UuvH5fZBhUHwhUkD0A2P6cNJyLb4+
         r0LGQRkScxsxsRsnrV9mZjY16b8iU8youOptYenFLfegaRrHRWjqG9odXzuxCa9Mel
         VVB4n9LvB8i7Th2N6X2+iTQJs3thylSoy2+CjUpsumRLpKoLjPD8eDjsxN6V1JBejg
         MExPW/2nAS3zg==
Date:   Fri, 15 Sep 2023 20:25:31 +0200
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
Subject: Re: [PATCH 3/5] seqlock: introduce seqprop_lock/unlock
Message-ID: <ZQShm4QAeAtjR8EK@example.org>
References: <20230913154907.GA26210@redhat.com>
 <20230913155000.GA26248@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913155000.GA26248@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:50:00PM +0200, Oleg Nesterov wrote:
> which can be used to take/release the corresponding lock.
> 
> Thanks to the previous patch, it is trivial to pass 2 arguments to
> the new __seqprop_##lockname##_lock/unlock "methods", plus we do not
> loose the type info and thus the new seqprop's are "type safe".
> 
> So for example
> 
> 	void func(seqcount_rwlock_t *s, rwlock_t *l)
> 	{
> 		seqprop_lock(s, l);
> 	}
> 
> happily compiles, but this one
> 
> 	void func(seqcount_rwlock_t *s, spinlock_t *l)
> 	{
> 		seqprop_lock(s, l);
> 	}
> 
> doesn't.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/seqlock.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 41e36f8afad4..9831683a0102 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -241,6 +241,21 @@ static __always_inline void						\
>  __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
>  {									\
>  	__SEQ_LOCK(lockdep_assert_held(s->lock));			\
> +}									\
> +									\
> +static __always_inline void						\
> +__seqprop_##lockname##_lock(seqcount_##lockname##_t *s,			\
> +				locktype *lock)				\
> +{									\
> +	__SEQ_LOCK(WARN_ON_ONCE(s->lock != lock));			\
> +	lockbase##_lock(lock);						\
> +}									\
> +									\
> +static __always_inline void						\
> +__seqprop_##lockname##_unlock(seqcount_##lockname##_t *s,		\
> +				locktype *lock)				\
> +{									\
> +	lockbase##_unlock(lock); 					\
>  }

Why are you creating a new method with an unused argument s ?

>  
>  /*
> @@ -306,6 +321,12 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
>  #define seqprop_preemptible(s)		__seqprop(s, preemptible)(s)
>  #define seqprop_assert(s)		__seqprop(s, assert)(s)
>  
> +/* seqcount_t doesn't have these methods */
> +static inline void __seqprop_lock   (seqcount_t *s, void *l) { BUILD_BUG(); }
> +static inline void __seqprop_unlock (seqcount_t *s, void *l) { BUILD_BUG(); }
> +#define seqprop_lock(s, l)		__seqprop(s, lock)(s, l)
> +#define seqprop_unlock(s, l)		__seqprop(s, unlock)(s, l)
> +
>  /**
>   * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
>   * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
> -- 
> 2.25.1.362.g51ebf55
> 

-- 
Rgrds, legion

