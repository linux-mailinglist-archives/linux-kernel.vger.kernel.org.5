Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F189806B08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377264AbjLFJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377348AbjLFJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:47:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4E110D4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:47:39 -0800 (PST)
Date:   Wed, 6 Dec 2023 10:47:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701856057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZL4xpIW5Xbtis3hnUiCyn0G7mTR94oGieX73+hE5Tk=;
        b=RemarrlJFGANeBLplMKNzkZVPTgIXVgK0dnGTqZRpWRUqYuPNg/igS6wMk7e9a0ywmooih
        E8hIqIr8R7+MShTnVtcZAT52YYNbPlrbT7WnPcUGXKSxK8qlpV0HB6PBAPLKMYreUbN7l/
        kXGyL+1mc6S8vz/bZy53JD0DxWMzleHzS9WqHZ/Ua6g3x7veJh2bNdp0zsT8QwBtqiImuU
        ePXAGipjEoSKs5jrQgk6DZspsnsspss9zmjvXdcBBXROPv3BxwEWN7rbXk2j+VkkaftBO3
        5dEzCBM7PruJi5aRi+CN1bBDQPjmWGIEmcGgPZZjzUJuFqYPGoQXGUOooewa6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701856057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZL4xpIW5Xbtis3hnUiCyn0G7mTR94oGieX73+hE5Tk=;
        b=z4zP1RhM6n+SbF00Fk8AL8K/95cDBJ1CT8SFh0vLFGW1f56DUpS23k285R6aMNF9pyEemp
        Eol2yJnCC/pv0/Dg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
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
Message-ID: <20231206094735.HMFIZlHa@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-24-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-24-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:45 [+0100], Anna-Maria Behnsen wrote:
> For the conversion of the NOHZ timer placement to a pull at expiry time
> model it's required to have separate expiry times for the pinned and the
> non-pinned (movable) timers. Therefore struct timer_events is introduced.
>=20
> No functional change
>=20
> Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.co=
m>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
=E2=80=A6
> index 366ea26ce3ba..0d53d853ae22 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
=E2=80=A6
> @@ -2022,13 +2028,31 @@ static inline u64 __get_next_timer_interrupt(unsi=
gned long basej, u64 basem,
> =20
>  	nextevt =3D local_first ? nextevt_local : nextevt_global;
> =20
> -	if (base_local->timers_pending || base_global->timers_pending) {
> +	/*
> +	 * If the @nextevt is at max. one tick away, use @nextevt and store
> +	 * it in the local expiry value. The next global event is irrelevant in
> +	 * this case and can be left as KTIME_MAX.
> +	 */
> +	if (time_before_eq(nextevt, basej + 1)) {
>  		/* If we missed a tick already, force 0 delta */
>  		if (time_before(nextevt, basej))
>  			nextevt =3D basej;
> -		expires =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
> +		tevt.local =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
> +		goto unlock;

You claim "No functional change" in the patch description. However if
you take the shortcut here you don't update `idle' if set and you don't
__forward_timer_base(). The `idle` parameter doesn't matter because it
was false and will remain false as per current logic.

But what about the forward of the timer base? It is probably not real
problem since the next add/mod timer call will forward it.

Sebastian
