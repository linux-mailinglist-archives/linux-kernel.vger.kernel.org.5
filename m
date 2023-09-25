Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E515B7AD6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjIYLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjIYLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:11:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E9D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:11:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695640280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHRlkDi0urU5sq2L6T80vrK7gNbNkDP2/rYTyTZW66c=;
        b=h4mpzpuZSg0h7aOZ40Ld7cIpedbmemkJ9qeVhYYdkw3yqcn89GSfxkst6uzPK0QMDlUKN0
        IRfaQDtxxqEawJw7K0m5FUPVcJDoj01X06PYeBdjNYAc7HDKJjWIUxSU4GwfKHLTiOV0EI
        BkVK3L1yWtuq6/satRSJcm4kTZvDtmhb/3AF6EHQczr1hsqD9l92oAYC8R++56wkNy2/GH
        qn9N6iU1nLSd87qdpWELippbhUrIY5u3cJeqTaQoxt4IY5azCZU8Rih8vYLdTwpDDrPkNj
        8bWLtYCUedKLCN1/21y0uKjUpWfwJpcHGr2Rcc/eGZkI84yQ4vuIyvG8Ah1Ghw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695640280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHRlkDi0urU5sq2L6T80vrK7gNbNkDP2/rYTyTZW66c=;
        b=oLA3P4ZKUX3JPJpBvEZemn+EVWMiWC+WkaShcyiBvkRBzeLUxD5WI5frlXpLNi9hgQLQiY
        wT304MohkpHePEAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 05/11] printk: nbcon: Provide function for
 atomic flushing
In-Reply-To: <ZQ2JU9PyZIvu4spa@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-6-john.ogness@linutronix.de>
 <ZQ2JU9PyZIvu4spa@alley>
Date:   Mon, 25 Sep 2023 13:17:19 +0206
Message-ID: <87fs32bj8o.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22, Petr Mladek <pmladek@suse.com> wrote:
>> Note that if the current CPU is in a nested elevated priority
>> state (EMERGENCY/PANIC), nbcon_atomic_flush() does nothing.
>
> This confused me a bit. It was not clear to me if it was
> "nested and elevated" or "the elevated priority was nested".

Elevated priority within an elevated priority. Or put another way: an
atomic printing section within an atomic printing section. Maybe the
"elevated priority" terminology is confusing. I can just use "atomic
printing section" instead if that helps.

>> This is in case the printing itself generates urgent messages
>> (OOPS/WARN/PANIC), that those messages are fully stored into
>> the ringbuffer before any printing resumes.
>
> This feels like it was an advantage. But I would say that it is
> a limitation. IMHO, it simply works this way and we should describe
> it as a limitation.

The "atomic printing section" feature was the result of designing this
advantage. It "simply works this way" because that it how it was
designed.

Actually, this is explaining the nesting variable that you asked about
in the previous patch commit message. When I reverse the patch order,
this paragraph will be moved into that patch commit message.

>> +/**
>> + * nbcon_atomic_emit_one - Print one record for a console in atomic mode
>> + * @wctxt:			An initialized write context struct to use
>> + *				for this context
>> + *
>> + * Returns false if the given console could not print a record or there are
>> + * no more records to print, otherwise true.
>> + *
>> + * This is an internal helper to handle the locking of the console before
>> + * calling nbcon_emit_next_record().
>> + */
>> +static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>> +{
>> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>> +
>> +	if (!nbcon_context_try_acquire(ctxt))
>> +		return false;
>> +
>> +	/*
>> +	 * nbcon_emit_next_record() returns false when the console was
>> +	 * handed over or taken over. In both cases the context is no
>> +	 * longer valid.
>> +	 */
>> +	if (!nbcon_emit_next_record(wctxt))
>> +		return false;
>> +
>> +	nbcon_context_release(ctxt);
>> +
>> +	return prb_read_valid(prb, ctxt->seq, NULL);
>
> IMHO, it should be enough to check ctxt->backlog. I mean to do:
>
> 	return !!ctxt->backlog;
>
> We are here only when nbcon_emit_next_record() owned the context and
> was able to call printk_get_next_message().

Yes, but ctxt->backlog is set before the printing begins. If any nested
atomic printing occurs (i.e. just adding records to the ringbuffer),
these also need to be atomically printed.

For example, console_unlock() deals with that situation with:

                /*
                 * Some context may have added new records after
                 * console_flush_all() but before unlocking the console.
                 * Re-check if there is a new record to flush. If the trylock
                 * fails, another context is already handling the printing.
                 */
        } while (prb_read_valid(prb, next_seq, NULL) && console_trylock());

The prb_read_valid() here corresponds to the prb_read_valid() in
console_unlock(). I can add a similar comment here for that.

>> +static void __nbcon_atomic_flush_all(bool allow_unsafe_takeover)
>> +{
>> +	struct nbcon_write_context wctxt = { };
>> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
>> +	struct nbcon_cpu_state *cpu_state;
>> +	struct console *con;
>> +	bool any_progress;
>> +	int cookie;
>> +
>> +	cpu_state = nbcon_get_cpu_state();
>> +
>> +	/*
>> +	 * Let the outermost flush of this priority print. This avoids
>> +	 * nasty hackery for nested WARN() where the printing itself
>> +	 * generates one and ensures such nested messages are stored to
>> +	 * the ringbuffer before any printing resumes.
>
> It is not clear to me what hackery was meant.

Hackery = Trying to implement this feature without tracking CPU state
priorities.

> The fact is that only printk_once() or WARN_ONCE() should be used in
> the console emit/flush code paths. Any non-once printk might block
> consoles and even these nesting checks probably would not help much.

I am not sure what that has to do with it. This is a flush function,
which (for example) will be called when a warning is hit. We do _not_
want to flush the console if something more important (a panic) is
already in the process of being added to the ringbuffer.

> Anyway, I believe that we do not need this nesting counter.
> The nesting is already prevented by nbcon_context_try_acquire().
> It would not allow to take the nested lock with the same priority.

You are mixing 2 different things:

The acquire is related to ownership of a console.

The nesting is related to urgency state of a CPU.

> I would personally just describe the behavior in the commit message
> and in the comment above __nbcon_atomic_flush_all():
>
> 	* The messages are flushed only when this context is able to
> 	* get the per-console lock. Namely, it works only when the
> 	* lock is free or when this context has a higher priority
> 	* than the current owner.

Your comment is stating the obvious. All messages are only written by a
context when that context can acquire ownership.

What the check here is doing is refusing to write messages even if it
_could_ acquire ownership. It isn't about console ownership. It is about
not _wanting_ to print in nested atomic printing sections.

>> +	if (cpu_state->prio > NBCON_PRIO_NORMAL &&
>> +	    cpu_state->nesting[cpu_state->prio] != 1)
>> +		return;

[...]

>> +/**
>> + * nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
>> + *
>> + * Context:	Any context where migration is disabled.
>
> We should make it more clear what migration is meant here. For
> example:
>
>  * Context:	Any context which could not be migrated to another CPU.

OK.

John
