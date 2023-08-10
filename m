Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE7777155
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjHJH0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHJH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:26:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD452211B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:26:40 -0700 (PDT)
Date:   Thu, 10 Aug 2023 09:26:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691652399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4O0xleWwbLEz5uNtQqAFP8rru9+g0EjKLnL+sKvBtM=;
        b=OuRRKRDvuB/9D8TwbLjCmSJBiNo71POOsbtBcqDpDDCis9ruu8BDyDKUxWwxHiBljBt4jA
        m+eEdgFTaXId1fVjQPXkSvT0nNNk729ni/KqRqMIg1/Ly9hePUk9OyWKybeO43+AmxLSV4
        9eeVaKvH181VYnVQTU8F1gX6iclho9W7GisSfpuIDncU8ZVkLOqBNSfo4JVexvYrWBmcBG
        O9Es82SCSGwspTA9SMqFB1XW9hx4lg6nvQckrERkxN8AT/apS3qPU19nKVTApR7cMeEGbu
        tNtQZ0Mei+Gn1BeZL84iNSSZ/U0Z09MoZholgmdZGGYk1Cx7NgwApjiavRaj9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691652399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4O0xleWwbLEz5uNtQqAFP8rru9+g0EjKLnL+sKvBtM=;
        b=+TuJ5hUyGLZg4p2ro9OWMxk1hQ1m0fb2xPbXFa1/RUhadKwNh80TIA22pKVgxS1TtC6a5o
        G5Ww0un+LBtToRDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
Subject: Re: [PATCH v2] mm/page_alloc: don't check zonelist_update_seq from
 atomic allocations
Message-ID: <20230810072637.6Sc3UU3R@linutronix.de>
References: <6cc13636-eda6-6a95-6564-db1c9ae76bb6@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6cc13636-eda6-6a95-6564-db1c9ae76bb6@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-09 20:03:00 [+0900], Tetsuo Handa wrote:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7d3460c7a480..5557d9a2ff2c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3638,26 +3638,44 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
=E2=80=A6
> -static DEFINE_SEQLOCK(zonelist_update_seq);
> +static unsigned int zonelist_update_seq;
> =20
>  static unsigned int zonelist_iter_begin(void)
>  {
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
> -		return read_seqbegin(&zonelist_update_seq);
> +		/* See comment above. */
> +		return data_race(READ_ONCE(zonelist_update_seq));

This is open coded raw_read_seqcount() while it should have been
raw_seqcount_begin().

>  	return 0;
>  }
> =20
> -static unsigned int check_retry_zonelist(unsigned int seq)
> +static unsigned int check_retry_zonelist(gfp_t gfp, unsigned int seq)
>  {
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
> -		return read_seqretry(&zonelist_update_seq, seq);
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE) && (gfp & __GFP_DIRECT_RECLAIM)=
) {
> +		/* See comment above. */
> +		unsigned int seq2 =3D data_race(READ_ONCE(zonelist_update_seq));
> =20
> -	return seq;
> +		/*
> +		 * "seq !=3D seq2" indicates that __build_all_zonelists() has
> +		 * started or has finished rebuilding zonelists, hence retry.
> +		 * "seq =3D=3D seq2 && (seq2 & 1)" indicates that
> +		 * __build_all_zonelists() is still rebuilding zonelists
> +		 * with context switching disabled, hence retry.
> +		 * "seq =3D=3D seq2 && !(seq2 & 1)" indicates that
> +		 * __build_all_zonelists() did not rebuild zonelists, hence
> +		 * no retry.
> +		 */
> +		return unlikely(seq !=3D seq2 || (seq2 & 1));

open coded read_seqcount_retry().

> +	}
> +
> +	return 0;
>  }
> =20
>  /* Perform direct synchronous page reclaim */
> @@ -5136,22 +5154,17 @@ static void __build_all_zonelists(void *data)
>  	int nid;
>  	int __maybe_unused cpu;
>  	pg_data_t *self =3D data;
> +	static DEFINE_SPINLOCK(lock);
>  	unsigned long flags;
> =20
> -	/*
> -	 * Explicitly disable this CPU's interrupts before taking seqlock
> -	 * to prevent any IRQ handler from calling into the page allocator
> -	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
> -	 */
> -	local_irq_save(flags);
> -	/*
> -	 * Explicitly disable this CPU's synchronous printk() before taking
> -	 * seqlock to prevent any printk() from trying to hold port->lock, for
> -	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
> -	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
> -	 */
> -	printk_deferred_enter();
> -	write_seqlock(&zonelist_update_seq);
> +#ifdef CONFIG_PREEMPT_RT
> +	migrate_disable()
> +#endif

There is no justification/ explanation why migrate_disable() here is
needed on PREEMPT_RT and I don't see one.

There are two changes here:
- The replacement of seqlock_t with something open coded=20
- Logic change when a retry is needed (the gfp mask is considered).

I am not a big fan of open coding things especially when not needed and
then there is this ifdef which is not needed as well. I don't comment on
the logic change.

Can we please put an end to this?

> +	/* Serialize increments of zonelist_update_seq. */
> +	spin_lock_irqsave(&lock, flags);
> +	zonelist_update_seq++;
> +	/* Tell check_retry_zonelist() that we started rebuilding zonelists. */
> +	smp_wmb();
> =20
>  #ifdef CONFIG_NUMA
>  	memset(node_load, 0, sizeof(node_load));

Sebastian
