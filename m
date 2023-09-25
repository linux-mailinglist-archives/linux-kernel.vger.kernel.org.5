Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5737ADCA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjIYQE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjIYQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:04:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93892
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:04:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75D15212AE;
        Mon, 25 Sep 2023 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695657888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fk0C5BOuVUMirdLJNcwtzm6iwkHfz7xiZKtAyUdun7Y=;
        b=aFbWX6AUcQBr7o3I7on7bbBcIwxXA9tH82Tv3wMKhtP4dKdCUGZyH3K0nEI/0WgG6fMqAC
        qVrHF5RvxackjfNxG1cOKAu6RU8JoAVBUtiF6qcrcidXJchDu/mw+oR1D2/H/hA0GsDwwQ
        EL80VZVpzflzP5vzQARWC9iydvdUtzw=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12C022C142;
        Mon, 25 Sep 2023 16:04:48 +0000 (UTC)
Date:   Mon, 25 Sep 2023 18:04:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/11] printk: nbcon: Provide functions to mark
 atomic write sections
Message-ID: <ZRGvn4m2NGCn3Pef@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-5-john.ogness@linutronix.de>
 <ZQ1ff96wS03ctA-v@alley>
 <87il7ybo4d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il7ybo4d.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-09-25 11:31:54, John Ogness wrote:
> On 2023-09-22, Petr Mladek <pmladek@suse.com> wrote:
> >> Note that when a CPU is in a priority elevated state, flushing
> >> only occurs when dropping back to a lower priority. This allows
> >> the full set of printk records (WARN/OOPS/PANIC output) to be
> >> stored in the ringbuffer before beginning to flush the backlog.
> >
> > The above paragraph is a bit confusing. The code added by this patch
> > does not do any flushing.
> 
> You are right. I should put this patch after patch 5 "printk: nbcon:
> Provide function for atomic flushing" to simplify the introduction.
> 
> > I guess that this last paragraph is supposed to explain why the
> > "nesting" array is needed.
> 
> No, it is explaining how this feature works in general. The term
> "priority elevated state" means the CPU is in an atomic write section.

This did not help me much after at first. But I got it later after
connection more dots ;-)

IMHO, the problem was that the commit message introduced the terms
in the following order:

   + WARN/OOPS/PANIC require printing out immediately

   + per-CPU state to denote the priority/urgency

   + functions to mark the beginning/end where the urgent messages
     are generated

   + when CPU is in priority elevated state, flushing only occurs
     when dropping back to a lower priority

From my POV:

   + It did not mention/explained "atomic write" at all

   + It said that the urgent messages required immediate printing.
     And Later, it said that they would get flushed later. Which
     is contradicting each other.

   + The handling of priorities is not only about CPU nesting.
     The same rules should apply also when other CPU is printing
     messages in a higher priority context.

My proposal:

  + Use the term "higher priority context" for all WARN/OOPS/PANIC
    messages.

  + Use "emergency priority context" or "nbcon emergency context"
    when talking about NBCON_PRIO_EMERGENCY context to avoid
    confusion with the printk log levels.

  + use "panic priority context or "nbcon panic context" for the panic
    one if we really want to add enter/exit for the panic context.

  + We must somewhere explain the "atomic context" and "atomic_write".
    callback. One important question is why it is atomic. Is it because it

      + _can_ be called in atomic context?
      + _must_ be called in atomic context?

    It is called also from console_unlock() for boot messages
    so it need not be in atomic context.

    What about renaming it to "nbcon_write" to avoid this confusion?


> The "nesting" array is needed in order to support a feature that is not
> explained in the commit message: If nested OOPS/WARN/PANIC occur, only
> the outermost OOPS/WARN/PANIC will do the flushing. I will add this
> information to the commit message.

What is the motivation for the feature, please?

1. Either we want to flush the messages in the higher priority context
   ASAP.

   The per-CPU lock has been designed exactly for this purpose. It
   would not need any extra nesting counter. And it would work
   consistently also when the lock is acquired on another CPU.

   It is simple, the context will either get the per-console lock or
   not. The (nested) context might get the lock only when it has higher
   priority. The flush would be called directly from vprintk_emit().

   I always thought that this was the planned behavior.

   IMHO, we want it. A nested panic() should be able to takeover
   the console and flush messages ASAP. It will never return.


2. Or we want to wait until all messages in the higher priority context
   are stored into the ring buffer and flush them by the caller.

   Who would actually flush the higher messages?
   WARN() caller?
   The timer callback which detected softlockup?
   Or a completely different context?
   Who would flush panic() messages when panic() interrupted
   locked CPU?


My proposal:

There are only two higher priority contexts:

  + NBCON_PRIO_PANIC should be used when panic_cpu == raw_smp_processor_id()

  + NBCON_PRIO_EMERGENCY contex would require some enter/exit wrappers
    and tracking. But it does not necessarily need to be per-CPU
    variable.

I think about adding "int printk_state" into struct task_struct.
It might be useful also for other things, e.g. for storing the last
log level of non-finished message. Entering section with enforced
minimal loglevel or so.


Then we could have:

#define PRINTK_STATE_EMERGENCY_MASK   0x000000ff
#define PRINTK_STATE_EMERGENCY_OFFSET 0x00000001

void nbcon_emergency_enter(&printk_state)
{
	*printk_state = current->printk_state;

	WARN_ON_ONCE((*printk_state & PRINTK_STATE_EMERGENCY_MASK) == PRINTK_STATE_EMERGENCY_MASK);

	current->printk_state = *printk_state + PRINTK_STATE_EMERGENCY_OFFSET;
}

void nbcon_emergency_exit(printk_state)
{
	WARN_ON_ONCE(!(current->printk_state & PRINTK_STATE_EMERGENCY_MASK))

	current->printk_state = printk_state;
}

enum nbcon_prio nbcon_get_default_prio(void)
{
	if (panic_cpu == raw_smp_processor_id()
		return NBCON_PANIC_PRIO;

	/* Does current always exist? What about fork? */
	if (current && (current->printk_state && PRINTK_STATE_EMERGENCY_MASK))
		return NBCON_PRIO_EMERGENCY;

	return NBCON_PRIO_NORMAL;
}

IMHO, it should be race free. And we could use it to initialize
struct nbcon_context. The final decision will be left for
the nbcon_ctxt_try_acquire().

Best Regards,
Petr
