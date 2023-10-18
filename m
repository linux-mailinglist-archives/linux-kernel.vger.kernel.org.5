Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6A7CDDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344713AbjJRNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjJRNqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:46:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B6BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:46:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697636767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aHr2BzWnALAi96WZOeBFoa+QlTGYS/bQ5Th8GJp4Cvw=;
        b=IkIC4l9tDueXa/vIQ6w1HOjpVc7cavmCmA09ULqPoZ67IB+G8M7Z+mOKODAw+RilPpA6Fx
        FU+6xM6xhwzRx8ZxsH7kBBQe7Y2qpQfxy7fP1Ufzbp+ZSOP9rMrNlICaqeU//zG31FYxus
        xZ9AseBkqQ5gJGfI1cH9tKfxFoG3qm4rJQfEBfn+nYEDvdjT2qVI/ohQkIqpg0QwEIfWFe
        NmpowxB7Zs4G6mQ6i3H4yac5P31WKfCIcrseBzTkOR6QyMuF1Xr+pK6a1x9xReGsnmc/7V
        5+e3HOPfOSBe3oHNSMs2Q8zR7HCZMb+iW6dkj+7qcrV161BZooE4jwtaN688Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697636767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aHr2BzWnALAi96WZOeBFoa+QlTGYS/bQ5Th8GJp4Cvw=;
        b=jM4nkKOYrwc7jyJLweY/UbG98J/e7hHLogrsdQpsH3AHytELs7DPAb34+y7y1ep7EQm4La
        Fca0pALyeAEUucDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/4] printk: Skip unfinalized records in panic
In-Reply-To: <ZS_Vg4vvT29LxWSD@alley>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
 <20231013204340.1112036-4-john.ogness@linutronix.de>
 <ZS5vrte2OZXcIc9L@alley> <87mswh6iwq.fsf@jogness.linutronix.de>
 <ZS_Vg4vvT29LxWSD@alley>
Date:   Wed, 18 Oct 2023 15:51:57 +0206
Message-ID: <874jio6o2y.fsf@jogness.linutronix.de>
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

On 2023-10-18, Petr Mladek <pmladek@suse.com> wrote:
> Wait! This means that your patch actually does not work. Here is the diff:
>
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2815,8 +2815,19 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	else
>  		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
>  
> -	if (!prb_read_valid(prb, seq, &r))
> -		return false;
> +	while (!prb_read_valid(prb, seq, &r)) {
> +		if (this_cpu_in_panic() && seq < prb_next_seq(prb)) {
> +			/*
> +			 * The record @seq is not finalized and there may be
> +			 * more records in the ringbuffer. Since this is the
> +			 * panic CPU, skip over the unfinalized record and
> +			 * try to read a finalized record that may follow.
> +			 */
> +			seq++;
> +		} else {
> +			return false;
> +		}
> +	}
>  
>  	pmsg->seq = r.info->seq;
>  	pmsg->dropped = r.info->seq - seq;
>
> It skips the invalid reads only when seq < prb_next_seq(). But
> prb_next_seq(prb) points to the 1st non-finalized record. And
> all records with seq < prb_next_seq() must be finalized!

Please take a look at prb_next_seq(). It _starts_ its search from:

    id = atomic_long_read(&desc_ring->last_finalized_id);

For console_flush_on_panic(), @last_finalized_id will _always_ be set to
the last finalized message of the panic messages, being higher than any
non-finalized records that may exist. There are no other CPUs running
except the panic CPU.

> And it is even wrong. I still believe that dataless records are
> quietly skipped. Here is the code:
>
> static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
> 			    struct printk_record *r, unsigned int *line_count)
> {
> 	while ((err = prb_read(rb, *seq, r, line_count))) {
> [...]
> 		} else if (err == -ENOENT) {
> 			/* Record exists, but no data available. Skip. */
> 			(*seq)++;
>
> 		} else {
> 	}
> [...]
> }

Yes, this is the code. But prb_read() returns _true_ for data-less
records. You are confusing data-less records (which are valid records
containing the empty string) with "no data available" (which are records
that have lost their data).

Your confusion shows that we should improve the language. I am working
on a patch that does this.

> Note that "seq" is incremented and the cycle continues. It means
> that it tries to read the next record. It does _not_ return
> "true" when seeing dataless record, definitely.

I showed you where to look: get_data() has an extra check for data-less
records. It returns a valid string "", not NULL.

>> that it is just a brief internal comment. It also says:
>> 
>>  * See the description of prb_read_valid() and prb_read_valid_info()
>>  * for details.
>
> This does not help because these two functions do not describe
> how the seq is modified. And there are clearly three possibilities
> when it returns false:
>
>     1. The record for the given seq number has not been finalized
>        yet. In this case, it keeps "seq" as it was.
>
>     2. The record for the given seq has been dataless. In this case
>       it would try to advance seq until it finds a record with
>       the data or not-yet-finalized one.

"dataless" is the wrong word. It should be "lost data". It is skipped
because there is no data available (because it was lost) for the reader
to read. This is _not_ the case where it is a finalized fully intakt
record containing an empty string.

>
>     3. The given seq number has been invalid, above the head.
>        In this case, it keeps "seq" intact. So same as 1st case.
>
> Note that "seq" was not updated in the 1st and 3rd case. But the
> current comment suggests that it is updated.
>
> Well, it might be updated in all situations when then given
> seq pointed to an already overwritten record (below tail).

You are making this all sound much more complicated than it
is. Really. I suppose this is testimony for the horrible documentation.

>> _prb_read_valid() returns true
>
> This is not true if I read the code correctly.

Unfortunately you are not reading the code correctly. (Or rather, you
are being misled by comments because you incorrectly associate "not
available to reader" to mean "valid record with an empty string".

> PS: Sigh, I know that my comments looked like nitpicking. I had big inner
>     fight whether it was worth it or I was just burning my and others
>     time. But it seems that it helped for find many subtle problems
>     in the end.

Indeed. The subtle problem is: unclear comments/documentation.

John
