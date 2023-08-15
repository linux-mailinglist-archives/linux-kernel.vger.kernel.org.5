Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE877D64F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjHOWkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbjHOWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:39:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EAD1BCC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p0dnrXaOJRM8/s6rL5nTY2bKXhrHrej0BMKckbVSWZk=; b=dcdl0R5S8kNNGQOpzJ8jprK1gB
        dSYRMXJypWOAV3PYvXfuO2wpX7wf+WA1sLf+pKClIZHF4VhCHxCDfiiEMC6KBExpkTbdUeKGEwSOD
        PYK4KLzDQPRy4Ca6pR2N2B9B2JbO2mFBjyDEfyowuxKJLnjlQAnLTiAfR/AHIsak+xQPejXgOPl+6
        qHTfqRL035TAC5JQK1RWyapbDLqO6mmROdYnmfEBA6ru5gnxvNd4/4JTrT87xBOa+1GIAUK93NWeR
        k8S7vL3Of7feJgkE6+OMoI53mSxJ4pSMX2nHd3vtAXB9vL/Rj3alUKWT/CBDvhXtR+kV8FzKFgQFJ
        gXB5NisQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qW2hE-00AuTX-4D; Tue, 15 Aug 2023 22:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0908E300388;
        Wed, 16 Aug 2023 00:39:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD676206A36D9; Wed, 16 Aug 2023 00:39:26 +0200 (CEST)
Date:   Wed, 16 Aug 2023 00:39:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     bigeasy@linutronix.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/6] sched: Extract __schedule_loop()
Message-ID: <20230815223926.GC971582@hirez.programming.kicks-ass.net>
References: <20230815110121.117752409@infradead.org>
 <20230815111430.288063671@infradead.org>
 <20230815223301.GC602899@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815223301.GC602899@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:33:01PM -0400, Phil Auld wrote:
> Hi Peter,
> 
> On Tue, Aug 15, 2023 at 01:01:24PM +0200 Peter Zijlstra wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > There are currently two implementations of this basic __schedule()
> > loop, and there is soon to be a third.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20230427111937.2745231-2-bigeasy@linutronix.de
> > ---
> >  kernel/sched/core.c |   21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
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
>   17036 1 kworker/ I __schedule_loop.constprop.0
>   17151 1 kworker/ I __schedule_loop.constprop.0
>   17235 0 sleep    S __schedule_loop.constprop.0
>   17236 4 ps       R -

But but but __always_inline... ?!?
