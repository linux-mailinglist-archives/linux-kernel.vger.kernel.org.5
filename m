Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C597CBDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjJQInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjJQInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:43:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B3ED;
        Tue, 17 Oct 2023 01:42:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697532175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/MCZNp1QzgtRLikT/Uf4Z3LF4U+/3Nct6OerKSK/Ew=;
        b=0xaHt5rLv6MdaxB4Jxrip+Ym+uw2rdQ6EjzkblMTebXfp/pINnCFZeUQ3KK+qxiVZM+E3J
        YMNTb4aQ2MmL1b5qSxPn4bRLUfGcf6TLZQTQJ6s25dnC6WBAq25Q5poee0+4NWmT6n7XBf
        VAIUcdWNRE7HQdx7jZSpbmdyR2RECVLTWbMsN02jb1BSbTFsPjlRnfywlVF640Y8kzpdS+
        VdcQ2zDnMVUmNdP944cEOP6JqbKwEaWYNtLrY53xsv8/v7oh4cZ7ZiM8H1mZuw6Guz+EgS
        XDQbppPOnRKJJmG8W87xCJGqCwt5oRxLWuymKpbUpYTtCQb2VRlPGqiQyf/4Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697532175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/MCZNp1QzgtRLikT/Uf4Z3LF4U+/3Nct6OerKSK/Ew=;
        b=acP7zluJuMiuczktc068V0wpw5Fxn1HPf24ryC5Aig5kN+b2HcRx4LuqS095MgGwWLC1zR
        Bwz8SJYufs/m3TDQ==
To:     lakshmi.sowjanya.d@intel.com, jstultz@google.com,
        giometti@enneenne.com, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v1 1/6] kernel/time: Add system time to system counter
 conversion
In-Reply-To: <20231017052457.25287-2-lakshmi.sowjanya.d@intel.com>
References: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
 <20231017052457.25287-2-lakshmi.sowjanya.d@intel.com>
Date:   Tue, 17 Oct 2023 10:42:55 +0200
Message-ID: <87zg0h63n4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lakshmi!

On Tue, Oct 17 2023 at 10:54, lakshmi.sowjanya.d@intel.com wrote:

'kernel/time:' is not a proper subsystem prefix.

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> Support system-clock to system-counter conversion. Intel Timed IO
> hardware, using system counter as reference to schedule events.

This tells me WHAT the patch is doing but not at all WHY this is
required and that Intel Timed IO hardware reference is just not cutting
it.

> +extern int ktime_convert_real_to_system_counter(ktime_t sys_realtime,
> +						struct system_counterval_t *ret);

The changelog talks about system-clock. The function name and the
argument tell that this is about real-time. Thats confusing at best.

> +static inline int timekeeping_ns_to_delta(const struct tk_read_base *tkr, u64 nsec,
> +					  u64 *cycles)
> +{
> +	if (BITS_TO_BYTES(fls64(nsec) + tkr->shift) > sizeof(nsec))
> +		return -ERANGE;

Without a comment you will not be able to grok that check in three
months from now.

> +	*cycles = nsec << tkr->shift;
> +	*cycles -= tkr->xtime_nsec;
> +	do_div(*cycles, tkr->mult);
> +
> +	return 0;
> +}
> +
>  static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 delta)
>  {
>  	u64 nsec;
> @@ -1303,6 +1316,47 @@ int get_device_system_crosststamp(int (*get_time_fn)
>  }
>  EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
>  
> +/**
> + * ktime_convert_real_to_system_counter - Convert system time to system counter

System time is _NOT_ the same as clock realtime, really. What's wrong
with consistently using clock realtime instead of making up some new
terminology?

> + * value

Pointless line break which makes this unreadable.

> + * @sys_realtime:	realtime clock value to convert

What means sys_realtime? The argument supplies an absolute time value
based on clock realtime and not on some magic system realtime.

> + * @ret:		Computed system counter value with clocksource pointer

So @ret is returning the computed value along with a clocksource pointer
or what?

> + * Converts a supplied, future realtime clock value to the corresponding
> + * system counter value.
> + *
> + * Return: 0 on success, -errno on failure.

If this really needs error codes, then please explicitly document
them. If not, then make the function return bool and be done with it.

> + */
> +int ktime_convert_real_to_system_counter(ktime_t sys_realtime,
> +					 struct system_counterval_t *ret)
> +{
> +	struct timekeeper *tk = &tk_core.timekeeper;
> +	ktime_t base_real;
> +	unsigned int seq;
> +	u64 ns_delta;
> +	int err;
> +
> +	do {
> +		seq = read_seqcount_begin(&tk_core.seq);
> +
> +		base_real = ktime_add(tk->tkr_mono.base,
> +				      tk_core.timekeeper.offs_real);
> +		if (ktime_compare(sys_realtime, base_real) < 0)
> +			return -EINVAL;
> +
> +		ret->cs = tk->tkr_mono.clock;
> +		ns_delta = ktime_to_ns(ktime_sub(sys_realtime, base_real));
> +		err = timekeeping_ns_to_delta(&tk->tkr_mono, ns_delta, &ret->cycles);
> +		if (err < 0)
> +			return err;

This is completely uncomprehensible especially with the hidden range
check in the conversion function. All of this can be simplified to:

bool ktime_real_to_system_counter(ktime_t treal, struct system_counterval_t *scv)
{
	struct timekeeper *tk = &tk_core.timekeeper;
	unsigned int seq;
	u64 delta;

	do {
		seq = read_seqcount_begin(&tk_core.seq);

	        delta = (u64)treal - tk->tkr_mono.base_real;

		if (delta > tk->tkr_mono.clock->max_idle_ns)
                	return false;

                scv->cycles = timekeeping_ns_to_delta(&tk->tkr_mono, delta);
                scv->cycles += tk->tkr_mono.cycle_last;

		scv->cs = tk->tkr_mono.clock;
	} while (read_seqcount_retry(&tk_core.seq, seq));

	return true;
}

That gets rid of this hideous range check in the conversion function and
makes the code simple and straight forward, no?

Related question: What guarantee that the supplied value is not in the
past?

Nothing. It only guarantees that it is not before the realtime base
value, which can be up to one second in the past.

Maybe it does not matter, but then the 'future realtime clock value' in
the function documentation is wishful thinking.

Thanks,

        tglx
