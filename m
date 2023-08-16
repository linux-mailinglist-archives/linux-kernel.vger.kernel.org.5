Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6498977DE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbjHPKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbjHPKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:02:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7EC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:02:00 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:01:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692180118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzyfcJQ9ouh4S2dwRr0rXtUkpkdSQI1NMD1qu2Jadng=;
        b=sniRCBgB+UabFowp4MxMJ17R6d1N5aHqq3XbfrEQ/MEi6lmKlUewYTHcHSuo4dPZy+ZaDk
        4Nijg/X6GqyN3pVgVG8R5b8xRE0i9kh7sVql2f1kyCBKGAoN/ZTO2ifxVvyVEVNbINDIS1
        I1lrYhte3nuStaYn0w2P3PMPJ1wN09a1YNCOGKPhqcUjkFzSmmbk+83uKJDdP28yz1Ezol
        USkBuv5dDiCwGLlR1rj9s6LCnPNJQCnIImyR2s1AskpCEhTGSfMSOOW6of5lyq8WaW7Pce
        Jlmut6QjZIA0FREhbvxbDto+KreqVMUONJNT40lUY62ygBLeOdDhF1KLCR4Iaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692180118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzyfcJQ9ouh4S2dwRr0rXtUkpkdSQI1NMD1qu2Jadng=;
        b=bYjQHjjxI4dmajuWkp2w5qqtGNwuLkSAX1Om5IqnPY7YHzsbbIwEEkP7CJh/6wgols/wY8
        fSR91WeVc/4MeaDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/6] sched: Extract __schedule_loop()
Message-ID: <20230816100154.k6cmHUUp@linutronix.de>
References: <20230815110121.117752409@infradead.org>
 <20230815111430.288063671@infradead.org>
 <20230815223301.GC602899@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815223301.GC602899@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-15 18:33:01 [-0400], Phil Auld wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6787,16 +6787,21 @@ static void sched_update_worker(struct t
> >  	}
> >  }
> >  
> > -asmlinkage __visible void __sched schedule(void)
> > +static __always_inline void __schedule_loop(unsigned int sched_mode)
> 
> I think this needs __sched or it's the only thing that ever shows up
> in wchan. E.g.
> 
>   16995 0 bash     S __schedule_loop.constprop.0

I don't see __schedule_loop in my RT and !RT build. I tried gcc and
clang.

Sebastian
