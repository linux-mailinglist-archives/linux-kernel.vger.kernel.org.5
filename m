Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2876956D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGaMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGaMCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:02:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8ECB5;
        Mon, 31 Jul 2023 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NtFOEPY77USWKXTfle1qi3nnxQlNUFkP6IPh0bUdyZY=; b=odO5I1ugzWHvFkRK1PF57mg0rI
        P3cmTIC7c1kuhvIy56ar2u7ujCRmaboo+U/yV1LaMt9P5A49M1cA/wBHflBMsdnxJGfpfE3yYACJe
        rAjCXOrSIQuBpN/RJHZaJRGg5rxSE8jMO1CWH83mugDImMTIXQtOcLrSlv/bgzLGH9/flcOGiSEMB
        L/TXRt5vAi11qHQDxzuIdd0fQprbmyeHVpLX5hHeLEyoE5NAYcKHGHQZE8uMBpJuGowVbNHDiBuKn
        9hvkmyX7tS9ReQTWYnEPPMzvhsMKBX/tHVEzkyyOCC82XruDQpBK1CmYvACxEJMCXou97J8/vlLJQ
        HVEhm1BA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQRb7-00Cfzv-2V;
        Mon, 31 Jul 2023 12:02:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 221963002CE;
        Mon, 31 Jul 2023 14:02:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09295206A36EE; Mon, 31 Jul 2023 14:02:01 +0200 (CEST)
Date:   Mon, 31 Jul 2023 14:02:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 2/3] cpuidle,teo: Improve NOHZ management
Message-ID: <20230731120200.GF29590@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.902892871@infradead.org>
 <CAJZ5v0hi25zZ_SRnSk0r=7q=UFh1dsrWEao6225KZVWp3-ivDQ@mail.gmail.com>
 <20230728220109.GA3934165@hirez.programming.kicks-ass.net>
 <CAJZ5v0ir_VsvBi4KKhpcjQnVsTK-EXZJjNsk=Jp84HLvaspChw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ir_VsvBi4KKhpcjQnVsTK-EXZJjNsk=Jp84HLvaspChw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:17:27PM +0200, Rafael J. Wysocki wrote:

> Something really simple like:
> 
> 1. Check sched_cpu_util() (which is done by teo anyway).
> 2. If that is around 90% of the maximum CPU capacity, select the first
> non-polling idle state and be done (don't stop the tick as my other
> replay earlier today).

So I really don't like using cpu_util() here, yes, 90% is a high number,
but it doesn't say *anything* about the idle duration. Remember, this is
a 32ms window, so 90% of that is 28.8ms.

(not entirely accurate, since it's an exponential average, but that
doesn't change the overal argument, only some of the particulars)

That is, 90% util, at best, says there is no idle longer than 3.2 ms.
But that is still vastly longer than pretty much all residencies. Heck,
that is still 3 ticks worth of HZ=1000 ticks. So 90% util should not
preclude disabling the tick (at HZ=1000).

Now, typically this won't be the case, and at 90% you'll have lots of
small idles adding up to 3.2ms total idle. But the point is, you can't
tell the difference. And as such util is a horrible measure to use for
cpuidle.

> > If we track the tick+ bucket -- as
> > we must in order to say anything useful about it, then we can decide the
> > tick state before (as I do here) calling sleep_length().
> >
> > The timer-pull rework from Anna-Maria unfortunately makes the
> > tick_nohz_get_sleep_length() thing excessively expensive and it really
> > doesn't make sense to call it when we retain the tick.
> >
> > It's all a bit of a chicken-egg situation, cpuidle wants to know when
> > the next timer is, but telling when that is, wants to know if the tick
> > stays. We need to break that somehow -- I propose by not calling it when
> > we know we'll keep the tick.
> 
> By selecting a state whose target residency will not be met, we lose
> on both energy and performance, so doing this really should be
> avoided, unless the state is really shallow in which case there may be
> no time for making this consideration.

I'm not sure how that relates to what I propose above. By adding the
tick+ bucket we have more historical information as related to the tick
boundary, how does that make us select states we won't match residency
for?
