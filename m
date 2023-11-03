Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00A7E03C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbjKCNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:31:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEE182
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:31:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699018285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DO7j1o8i1eFeB5gs6eWS36MES+cLunQXTVXFwNc5ZRk=;
        b=ff3Ly7++0Fr6f7aie/n6kjixyBYXgiWRisrWR/Q33B0dMoPVeurgQygdPrLJipYpDF+kUB
        Kk0D6qA0U/hWXa8/lyxfGKfmaz7gLyVlWXSHSuRlqml/lcd4WV8xZw7gxojl9l7kGSOe4b
        W8h7K4PeqYe5WHBvCeZ2Lb3l0UtePPcyyIPdYpmSojm81dxogyOjZs7Syl2YHzdQucxvew
        TNf431DLxmORZ0KXnznVSwvAv930vda3kyeRswCAe+N0YH9m9x7tYY9UCnllnli6VvIqjd
        LQ3nX9MCd8UnEaRstvX2epCxGa7uht1mW13oOF2si/0j3GiIFyECPZyP7Mb7eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699018285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DO7j1o8i1eFeB5gs6eWS36MES+cLunQXTVXFwNc5ZRk=;
        b=WqzTlly/Z3Y7WdEpl59lbDH/QIzV6RX3pQ5yRRIRezhIBn5Wk291wTqLf0UVRoxWcEhpw5
        +Q93Ew15FnOz7eAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
In-Reply-To: <ZUToEzarc_F-bEXT@alley>
References: <ZTkxOJbDLPy12n41@alley> <87zfzwp8pk.fsf@jogness.linutronix.de>
 <ZUToEzarc_F-bEXT@alley>
Date:   Fri, 03 Nov 2023 14:37:23 +0106
Message-ID: <8734xnj74k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-03, Petr Mladek <pmladek@suse.com> wrote:
>> IMHO we need 2 different functions:
>>
>> 1. A function that reports the last contiguous finalized record for a
>> reader. This is useful for syslog and kmsg_dump to know what is
>> available for them to read. We can use @last_finalized_seq for this,
>> optimizing it correctly this time.
>
> I would use this also for console_unlock() as well, see below.

OK.

>> 2. A function that reports the last reserved sequence number of a
>> writer. This is useful for pr_flush and console_unlock to know when they
>> are finished.
>
> I would personally use the @last_finalized_seq for
> console_unlock() and pr_flush() without a timeout. We could
> always call defer_console_output() when it is lower then
> the last reserved seq.
>
> Well, we actually do not even need to do this because
> the reserved records must be added by some printk().
> And this printk() will either flush the pending messages
> or it will call defer_console_output().

OK.

> The above paragraph describes a scenario which is not obvious.
> We should probably document it somewhere, probably in the description
> of prb_last_finalized_seq() or how it will be called.

OK.

>> This function can begin with @last_finalized_seq, looking
>> for the last finalized record (skipping over any non-finalized).
>
> I though about using desc_ring->head_id or looking for the
> last reserved sequence number.

The problem with @head_id is that the sequence number may not be
assigned yet. Really @last_finalized_seq is the newest sequence number
we have to search from.

>> Generally we have not concerned ourselves with readers. But I agree we
>> should make the optimization coherent with what a reader can actually
>> read. It might save some CPU cycles for polling tasks.
>
> I wanted to agree. But then I found this scenario:
>
> CPU0				CPU1
>
> console_unlock()
>   console_flush_all()
>
> 				printk()
> 				  vprintk_store()
>     return;
> 				    prb_final_commit;
>
> 				  console_trylock();  # failed
>
>   while (prb_read_valid());
>
> Now, the race:
>
>   + console_flush_all() did not flush the message from CPU1 because
>     it was not finalized in time.
>
>   + CPU1 failed to get console_lock() => CPU0 is responsible for
>     flushing
>
>   + prb_read_valid() failed on CPU0 because it did not see
>     the prb_desc finalized (missing barrier).

For semaphores, up() and down_trylock() successfully take and release a
raw spin lock. That provides the necessary barriers so that CPU0 sees
the record that CPU1 finalized.

>> Writing and reading of @last_finalized_seq will provide the necessary
>> boundaries to guarantee this:
>> 
>> ...finalize record...
>> atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq, ...);
>> 
>> and
>> 
>> atomic_long_read_acquire(&desc_ring->last_finalized_seq);
>> ...read record...
>
> Yup. something like this.
>
> Well, it is suspicious that there is no _release() counter part.

Take a closer look above. The cmpxchg (on the writer side) does the
release. I have the litmus tests to verify that is correct and
sufficient for what we want: to guarantee that for any read
@last_finalized_seq value, the CPU can also read the associated record.

I am finalizing a new version of the "fix console flushing on panic"
series [0] that will also include the prb_next_seq() fix. If needed, we
can continue this discussion based on the new code.

John

[0] https://lore.kernel.org/lkml/20231013204340.1112036-1-john.ogness@linutronix.de
