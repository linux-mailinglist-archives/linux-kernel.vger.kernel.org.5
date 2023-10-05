Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A07B9FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjJEOcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjJEObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5016426A6A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 05:51:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696510309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=5wDeVRFP1Vm4NZAlzbUtbnWiTw52Nu5dsEMHfj0FQqo=;
        b=KbTgY1HSA9f1/jRiyZKr9e9ji3fxP9tkrt6vjFIH7e+EqzOCMJXCcXjU2XIlYRQFbbLINC
        EdctUZlQoa2kOfYTFn10Xt25nmWuc6ijOVM5TO6rsU7vvhNALPAeDJXYB6yPmvvqfUD0Hy
        q3Y0W89NuTlzfIeLhP1bZSfE98uT+8IjZVDDHK8bCEI96Yhfrhl2IX0KS2KlWj8TzYf2cC
        l+2MDsI3FmLhyVy/3LMqLlhIXS4a3ToNzpmjzOYY6K87nAF7VypZwvWDlsgEJtjcX61gYK
        U7p6xrg8IGujTukoOZr8McwcVlq7GpW57rEAxVdbKOGX78nBtvOhW+5DP5hNbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696510309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=5wDeVRFP1Vm4NZAlzbUtbnWiTw52Nu5dsEMHfj0FQqo=;
        b=jkfonX988kL1irdHG6qBTWhL2desWIbUrfDsKJQo3ahvAq/z1ruir1AHLoEr8W6z7Bi473
        K6SrnqnI0xGQOmAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/11] printk: nbcon: Provide functions to
 mark atomic write sections
In-Reply-To: <ZRGvn4m2NGCn3Pef@alley>
Date:   Thu, 05 Oct 2023 14:57:47 +0206
Message-ID: <87h6n5teos.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-25, Petr Mladek <pmladek@suse.com> wrote:
> From my POV:
>
>    + It did not mention/explained "atomic write" at all

Agreed.

>    + It said that the urgent messages required immediate printing.
>      And Later, it said that they would get flushed later. Which
>      is contradicting each other.

I agree that the wording needs to be dramatically improved. The term
"urgent message" was not meant to represent a single printk() call.

>    + The handling of priorities is not only about CPU nesting.
>      The same rules should apply also when other CPU is printing
>      messages in a higher priority context.

Sorry, I do not understand what you mean here. Each CPU is responsible
for its own state. If another CPU is in a higher priority state, that
CPU will be responsible for ensuring its own WARN/OOPS is stored and
flushed. (From v2 I see that the CPU does not try hard enough. I would
fix that for v3.)

> My proposal:
>
>   + Use the term "higher priority context" for all WARN/OOPS/PANIC
>     messages.
>
>   + Use "emergency priority context" or "nbcon emergency context"
>     when talking about NBCON_PRIO_EMERGENCY context to avoid
>     confusion with the printk log levels.
>
>   + use "panic priority context or "nbcon panic context" for the panic
>     one if we really want to add enter/exit for the panic context.

There are 3 different types of priority:

1. The printk record priority: KERN_ERR, KERN_WARNING, etc.

2. The priority of a console owner: used for controlled takeovers.

3. The priority state of a CPU: only elevated for urgent messages, used
to store all urgent messages and then afterwards print directly by
taking ownership of consoles.

I need to choose terminology carefully to make it easy to distinguish
between these 3 types. v2 failed to name, describe, and document this
correctly.

>   + We must somewhere explain the "atomic context" and "atomic_write".
>     callback. One important question is why it is atomic. Is it because it
>
>       + _can_ be called in atomic context?
>       + _must_ be called in atomic context?

Its main reason for existing is because it can be called from atomic
(including NMI) contexts. But like atomic_t, it can be used from any
context.

>     It is called also from console_unlock() for boot messages
>     so it need not be in atomic context.
>
>     What about renaming it to "nbcon_write" to avoid this confusion?

When we introduce the threads, there will be a 2nd callback (currently
planned write_thread()). This callback is guaranteed to be called from a
printing kthread, which for console drivers like fbcon will prove to be
helpful in cleaning up its code.

I will reserve the word "atomic" _only_ when talking about which
printing callback is used. That should help to avoid associating the
callback with a certain context or priority. But I think the name
"write_atomic" is appropriate.

>> The "nesting" array is needed in order to support a feature that is not
>> explained in the commit message: If nested OOPS/WARN/PANIC occur, only
>> the outermost OOPS/WARN/PANIC will do the flushing. I will add this
>> information to the commit message.
>
> What is the motivation for the feature, please?

During the demo at LPC2022 we had the situation that there was a large
backlog when a WARN was hit. With current mainline the first line of the
WARN is put into the ringbuffer and then the entire backlog is flushed
before storing the rest of the WARN into the ringbuffer. At the time it
was obvious that we should finish storing the WARN message and then
start flushing the backlog.

> 1. Either we want to flush the messages in the higher priority context
>    ASAP.
>
>    The per-CPU lock has been designed exactly for this purpose. It
>    would not need any extra nesting counter. And it would work
>    consistently also when the lock is acquired on another CPU.
>
>    It is simple, the context will either get the per-console lock or
>    not. The (nested) context might get the lock only when it has higher
>    priority. The flush would be called directly from vprintk_emit().
>
>    I always thought that this was the planned behavior.

It was. But then it was suggested by Thomas and acked by Linus that we
were taking the wrong approach. Rather than a global state for all the
consoles, each console should have separate owners with states, allowing
handovers/takeovers. And CPUs should have urgency states to control how
the ringbuffer is stored and when direct printing should take place for
that CPU. This idea is similar to the cpu_sync approach, but with
timeouts, handovers/takeovers, and is per-console.

This approach gives us a lot of flexibility to enforce logical and safe
policies for storing and printing in different situations. And if
named/documented correctly, I think it will be easy to understand.

> 2. Or we want to wait until all messages in the higher priority context
>    are stored into the ring buffer and flush them by the caller.

Yes.

>    Who would actually flush the higher messages?
>    WARN() caller?

Yes.

>    The timer callback which detected softlockup?

Yes.

>    Or a completely different context?

Another CPU could do some helpful backlog printing if it sees new
messages and is able to become an owner. But it is not the CPU that is
responsible for making certain that the messages have been printed.

>    Who would flush panic() messages when panic() interrupted
>    locked CPU?

The panic CPU can takeover (as a last resort, unsafely if
necessary). The panic CPU is responsible for getting those messages out.

> My proposal:
>
> There are only two higher priority contexts:
>
>   + NBCON_PRIO_PANIC should be used when panic_cpu == raw_smp_processor_id()

This is the case with v2.

>   + NBCON_PRIO_EMERGENCY contex would require some enter/exit wrappers
>     and tracking. But it does not necessarily need to be per-CPU
>     variable.
<
> I think about adding "int printk_state" into struct task_struct.
> It might be useful also for other things, e.g. for storing the last
> log level of non-finished message. Entering section with enforced
> minimal loglevel or so.

printk() calls are quite rare. And warning states are even more
rare. IMHO adding such a field to every task is a huge price to
pay. Also, printk operates in non-task contexts (hardirq, nmi). Although
@current probably points to something existing, there could be some
tricky corner cases.

IMHO per-cpu urgency state variables and per-console owner state
variables allows a much simpler picture in all contexts.

My proposal:

You have provided excellent feedback regarding naming and
documentation. Allow me to fix these things to clarify the various
functions and their roles.

John
