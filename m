Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3EF8085E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjLGKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:12:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3398A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:12:48 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701943966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uUxHjyDj4NRFMrhXCuRnn2gfUyDxgWhxlbVoNO/d3M=;
        b=cfJROQdJKb2KzsnF9n0prH8m5esN/M7acjPp7eQEvIgSMDLshZcvEY1I640zhN3tmfasyu
        Lb/D358mrpPlcNiRr2vS+q7DvCv1KFv8rOyuZhJfIqOv+XdA++lzVOACq9SI1VOxVUBHk8
        KXHqQbLHmeBn80bcc2faNgB9N/jZvSqPqr1yq0gPbCqJQ/wDVPL7TzjMgnY7hsktSt3B8f
        gTiZWqO/j/aCuwJVxALwvN0tpN1Lt4dyP13uNPTYTzwuDgbMjeyJAL+KKVVTpKAY61PX7V
        xrZ+9Hg6ckjOlWuB3y4kIR8pYK4bzfLKhg1Gt6kk/LHr4KXxniYj3d8MT9Wv0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701943966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uUxHjyDj4NRFMrhXCuRnn2gfUyDxgWhxlbVoNO/d3M=;
        b=EQAKsl0dDkVzdF0MrvwdUQkH5wXKUQG6fBDuCDpgjWQr6tb7mZVT/QlfUdr+oW/lK5UyAD
        vfnauG3fCsMZO5AA==
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v9 23/32] timers: Retrieve next expiry of
 pinned/non-pinned timers separately
In-Reply-To: <20231206094735.HMFIZlHa@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-24-anna-maria@linutronix.de>
 <20231206094735.HMFIZlHa@linutronix.de>
Date:   Thu, 07 Dec 2023 11:12:45 +0100
Message-ID: <87h6ku8go2.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:45 [+0100], Anna-Maria Behnsen wrote:
>> For the conversion of the NOHZ timer placement to a pull at expiry time
>> model it's required to have separate expiry times for the pinned and the
>> non-pinned (movable) timers. Therefore struct timer_events is introduced.
>>=20
>> No functional change
>>=20
>> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.c=
om>
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> =E2=80=A6
>> index 366ea26ce3ba..0d53d853ae22 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
> =E2=80=A6
>> @@ -2022,13 +2028,31 @@ static inline u64 __get_next_timer_interrupt(uns=
igned long basej, u64 basem,
>>=20=20
>>  	nextevt =3D local_first ? nextevt_local : nextevt_global;
>>=20=20
>> -	if (base_local->timers_pending || base_global->timers_pending) {
>> +	/*
>> +	 * If the @nextevt is at max. one tick away, use @nextevt and store
>> +	 * it in the local expiry value. The next global event is irrelevant in
>> +	 * this case and can be left as KTIME_MAX.
>> +	 */
>> +	if (time_before_eq(nextevt, basej + 1)) {
>>  		/* If we missed a tick already, force 0 delta */
>>  		if (time_before(nextevt, basej))
>>  			nextevt =3D basej;
>> -		expires =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
>> +		tevt.local =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
>> +		goto unlock;
>
> You claim "No functional change" in the patch description. However if
> you take the shortcut here you don't update `idle' if set and you don't
> __forward_timer_base(). The `idle` parameter doesn't matter because it
> was false and will remain false as per current logic.
>
> But what about the forward of the timer base? It is probably not real
> problem since the next add/mod timer call will forward it.

You are right. It is not a problem as the timer base will be forwarded
by add/mod timer and also when timers needs to expire. (It is reworked
by the next patch...)

But it is not consistent and happend within one of the last rework
iterations. I'll change the goto label into 'forward' and place it
before the forward calls.

Thanks,

	Anna-Maria
