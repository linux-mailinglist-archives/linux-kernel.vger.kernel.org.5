Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC187AAE30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjIVJeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjIVJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:34:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C385ACD2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:33:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6DA581F461;
        Fri, 22 Sep 2023 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695375232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oT88nNiQNdO60Vz7Y3YIUI4gJHlhQxjqQ04Nk/WTPQ=;
        b=qHzDnWtQsHr42UNv1vhtX0ug8W76HeSkVJvl4raHZMJYDu8vrcHuMjDjSdhVzkdr9EgmNV
        USWJihfu0JJwkcE/6rMy0wr2TnDSuB5iSHYmqT0lzUp9KCXJO2taQYbTqhedij7sdXwPQG
        gtYzO9dG0cfJh2TFsbgOf1li5GOx//M=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 150202C142;
        Fri, 22 Sep 2023 09:33:52 +0000 (UTC)
Date:   Fri, 22 Sep 2023 11:33:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/11] printk: nbcon: Provide functions to mark
 atomic write sections
Message-ID: <ZQ1ff96wS03ctA-v@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:49, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> WARN/OOPS/PANIC require printing out immediately since the
> regular printing method (and in the future, the printing
> threads) might not be able to run.
> 
> Add per-CPU state to denote the priority/urgency of the output
> and provide functions to mark the beginning and end of sections
> where the urgent messages are generated.
> 
> Note that when a CPU is in a priority elevated state, flushing
> only occurs when dropping back to a lower priority. This allows
> the full set of printk records (WARN/OOPS/PANIC output) to be
> stored in the ringbuffer before beginning to flush the backlog.

The above paragraph is a bit confusing. The code added by this patch
does not do any flushing. I guess that this last paragraph is supposed
to explain why the "nesting" array is needed. I would write
something like:

"The state also counts nesting of printing contexts per-priority.
It will be later used to prevent flushing in nested contexts."

That said, I am not sure if the special handling of nested contexts
is needed. But let's discuss it in the patch introducing the flush
funtions.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -961,6 +961,95 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>  	return nbcon_context_exit_unsafe(ctxt);
>  }
>  
> +/**
> + * struct nbcon_cpu_state - Per CPU printk context state
> + * @prio:	The current context priority level
> + * @nesting:	Per priority nest counter
> + */
> +struct nbcon_cpu_state {
> +	enum nbcon_prio		prio;
> +	int			nesting[NBCON_PRIO_MAX];
> +};
> +
> +static DEFINE_PER_CPU(struct nbcon_cpu_state, nbcon_pcpu_state);
> +static struct nbcon_cpu_state early_nbcon_pcpu_state __initdata;
> +
> +/**
> + * nbcon_get_cpu_state - Get the per CPU console state pointer
> + *
> + * Returns either a pointer to the per CPU state of the current CPU or to
> + * the init data state during early boot.
> + */
> +static __ref struct nbcon_cpu_state *nbcon_get_cpu_state(void)
> +{
> +	if (!printk_percpu_data_ready())
> +		return &early_nbcon_pcpu_state;

My first thought, was that this was racy. I was afraid that
printk_percpu_data_ready() could change value inside
atomit_enter()/exit() area. But it actually could not happen.
Anyway, it might worth a comment. Something like:

	/*
	 * The value of __printk_percpu_data_ready is modified in normal
	 * context. As a result it could never change inside a nbcon
	 * atomic context.
	 */
	if (!printk_percpu_data_ready())
		return &early_nbcon_pcpu_state;

> +
> +	return this_cpu_ptr(&nbcon_pcpu_state);
> +}
> +
> +/**
> + * nbcon_atomic_exit - Exit a context that enforces atomic printing
> + * @prio:	Priority of the context to leave
> + * @prev_prio:	Priority of the previous context for restore
> + *
> + * Context:	Any context. Enables migration.
> + *
> + * @prev_prio is the priority returned by the corresponding
> + * nbcon_atomic_enter().
> + */
> +void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
> +{
> +	struct nbcon_cpu_state *cpu_state;
> +
> +	cpu_state = nbcon_get_cpu_state();

I would add a consistency check:

	WARN_ON_ONCE(cpu_state->nesting[cpu_state->prio] <= 0)

> +	/*
> +	 * Undo the nesting of nbcon_atomic_enter() at the CPU state
> +	 * priority.
> +	 */
> +	cpu_state->nesting[cpu_state->prio]--;
> +
> +	/*
> +	 * Restore the previous priority, which was returned by
> +	 * nbcon_atomic_enter().
> +	 */
> +	cpu_state->prio = prev_prio;
> +
> +	migrate_enable();
> +}

Best Regards,
Petr
