Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF17DF445
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376610AbjKBNsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjKBNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:48:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F4B83
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:48:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698932905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=exRsZeFA/Fox41PFwSzIwfdOdhyGCgCdI0norJsp0Y0=;
        b=PVLXSieQA79uJ1mXex4K2zHQKFpBbDk/9aCIebp+kMHUU0WEoYv/sdEYkG3X7t1V9uj6V7
        wWGH6OWqDztY7cttuBnVWw9Gzgg6/q6gosbWxbaMH/3U53yMdF+KdnYOksGxEdHki239JD
        Dd9YRaytfqWAQbVJhDDxnk4WkQIdzFgvUlpQjFq8IkyKoHpXMhCGIvRYp/IuOasLWOfMUc
        QHX9f+HIvXVFbpItPmxJ8J8e/5t4Zw5wzQQX0V1ruzK7/5s2TXjHkfzg6iAaqzGLv9OOfo
        KU4b2Us/Fx5ZcnRJb7Dejkg78HOzx9stpdmiTDDwUZX6awI4VpC6AmP4VZRbrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698932905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=exRsZeFA/Fox41PFwSzIwfdOdhyGCgCdI0norJsp0Y0=;
        b=4DE/cjrYhMXRnuEsvR1e55oGsYizjf6FdiemXvqqyZ9c/32uf8W60IL/RY6OF4hYDP5sLG
        76/ZUn6BI1TgH7Bg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
In-Reply-To: <ZTkxOJbDLPy12n41@alley>
Date:   Thu, 02 Nov 2023 14:54:23 +0106
Message-ID: <87zfzwp8pk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-25, Petr Mladek <pmladek@suse.com> wrote:
> there seems to be missing word in the subject:
>
>     s/non-finalized/non-finalized records/

Ack.

> On Thu 2023-10-19 15:31:45, John Ogness wrote:
>> Commit f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq()
>> performance") introduced an optimization for prb_next_seq() by
>> using best-effort to track recently finalized records. However,
>> the order of finalization does not necessarily match the order
>> of the records. This can lead to prb_next_seq() returning
>> higher than desired sequence numbers, which results in the
>> reader skipping over records that are not yet finalized. From
>> the reader's perspective it results in messages never being
>> seen.
>
> IMHO, "messages never being seen" is too strong.

Agreed. A reader does not use prb_next_seq() to decide what to print
next. Worst case it thinks records are available that are not (available
for that reader).

> I have found only one (or two) scenarios where the messages might
> really get lost.
>
> 1. It might happen when real console is replacing a boot console.
>    The real console is initialized with the value returned
>    by prb_next_seq(). And the boot console might not be able
>    to flush earlier non-finalized records.

This cannot happen because in this situation console_init_seq() sets
@seq to the lowest boot console counter.

> 2. The other scenario is based on the fact that console_unlock()
>    or pr_flush() might see lower prb_next_seq() than the last
>    reserved record. It means that they might not flush all
>    pending records.
>
>    But wait! This is actually the opposite case. pr_flush()
>    and console_unlock() might miss the messages when
>    they see too low prb_next_seq().
>
>    Important: This problem existed since introducing
> 	      the lockless ring buffer!
>
>    The question is. Should pr_flush() and console_unlock()
>    wait until all registered messages get finalized?
>
>    It would need to ignore only the last record when it
>    is not finalized because it might be a continuous line.

Yes, this is the question to answer.

With the lockless ringbuffer we allow multiple CPUs/contexts to write
simultaneously into the buffer. This creates an ambiguity as some
writers will finalize sooner.

IMHO we need 2 different functions:

1. A function that reports the last contiguous finalized record for a
reader. This is useful for syslog and kmsg_dump to know what is
available for them to read. We can use @last_finalized_seq for this,
optimizing it correctly this time.

2. A function that reports the last reserved sequence number of a
writer. This is useful for pr_flush and console_unlock to know when they
are finished. This function can begin with @last_finalized_seq, looking
for the last finalized record (skipping over any non-finalized).

> I agree that this might be optimized. I think about reducing the
> number of cmpxchg even more, something like:
>
> static void desc_update_last_finalized(struct prb_desc_ring *desc_ring)
> {
> 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> 	u64 prev_seq = desc_last_finalized_seq(desc_ring);
> 	u64 seq = prev_seq;
>
> try_again:
> 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> 		seq++;
>
> 	if (seq == prev_seq)
> 		return;
>
> 	oldval = __u64seq_to_ulseq(prev_seq);
> 	newval = __u64seq_to_ulseq(seq);
>
> 	if (!atomic_long_try_cmpxchg_relaxed(&desc_ring->last_finalized_seq,
> 					     &oldval, newval)) {
> 		prev_seq = seq;
> 		goto try_again;
> 	}
> }

I am fine with this implementation.

> It looks to me that we could keep passing desc_ring as the parameter.

No, _prb_read_valid() needs it.

> I feel that we need a read barrier here. It should be between the
> above
>
> 	atomic_long_read(&desc_ring->last_finalized_seq))
>
> and the below
>
> 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> 		seq++;
>
> It should make sure that the _prb_read_valid() will see all messages
> finalized which were seen finalized by the CPU updating
> desc_ring->last_finalized_seq.

Generally we have not concerned ourselves with readers. But I agree we
should make the optimization coherent with what a reader can actually
read. It might save some CPU cycles for polling tasks.

Writing and reading of @last_finalized_seq will provide the necessary
boundaries to guarantee this:

...finalize record...
atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq, ...);

and

atomic_long_read_acquire(&desc_ring->last_finalized_seq);
...read record...

This guarantees that if a reader sees a certain @last_finalized_seq
value, that they will also see the record that was finalized.

This will be the 13th memory barrier pair to be added to the
documentation.

I would like to submit a new patch implementing things as described
here.

John
