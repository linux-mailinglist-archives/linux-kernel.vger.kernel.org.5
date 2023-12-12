Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E871E80ED51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbjLLNWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjLLNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:21:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491E1BE6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:21:29 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702387286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlGpdwRMEpRoCFDzq4Qr67dRSkJMWxKFiBJopCplSz4=;
        b=NQg1ad5bPgDhlytdBl6emrZIs6TDt5HsxPbt/if4SY60/1eMTMVA+Tyc1xze5Tp+igKkZP
        uKy8vdG9vb373G7v8n5JfYIPYrOmr+vH4iIiovWVHiJU6v5BTcYd4KDMVkoUQKWU84yc7J
        oygCKLQUX/+N49Mbblojg8FYUzsfr7EbTPZbq9oWDZfqSy0vHwYSjCg8CMOjORJkU4CQ34
        4wX78hhhmHZvhsOFvndjej+dU+lP4HoWoOXXgoYbdAMPGYkkciapPwNyegP6C/BrZ3w1vT
        /5HvAsrxKV8HjkgO+VrbMkvBO3oAIlub5OXriuSqRaUyj5WTRnbuZuyE3kmVeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702387286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlGpdwRMEpRoCFDzq4Qr67dRSkJMWxKFiBJopCplSz4=;
        b=OFloWOz25JcxuIveEVjW9lc0NwQkmWKJOUUuRD4ZvrZSKiXvywVnW/RzNuzyVeCINQxCxN
        VOiy1AUdYbtzhEDA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers
 are pending
In-Reply-To: <ZXUHu6Xqdg8NNcPC@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-13-anna-maria@linutronix.de>
 <20231204160350.OTCnqCJf@linutronix.de> <87zfyodfxc.fsf@somnus>
 <ZXUHu6Xqdg8NNcPC@localhost.localdomain>
Date:   Tue, 12 Dec 2023 14:21:25 +0100
Message-ID: <875y13mu96.fsf@somnus>
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

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Tue, Dec 05, 2023 at 12:53:03PM +0100, Anna-Maria Behnsen a =C3=A9crit=
 :
>>=20
>> Frederic, what do you think?
>
> So it looks like is_idle must be fixed.
>
> As for the timer softirq, ->next_expiry is already unreliable because when
> a timer is removed, ->next_expiry is not updated (even though that removed
> timer might have been the earliest). So ->next_expiry can already carry a
> "too early" value. The only constraint is that ->next_expiry can't be lat=
er
> than the first timer.
>
> So I'd rather put a comment somewhere about the fact that wrapping is exp=
ected
> to behave ok. But it's your call.

Ok. If both solutions are fine, I would like to take the solution with
updating the next_expiry values for empty bases. It will make the
compare of expiry values of global and local timer base easier in one of
the patches later on.

Thanks,

	Anna-Maria

