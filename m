Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E47768C6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjHITdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjHITdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:33:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6E2D6A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYkVGxmZ/pANXkTEfnBsfoFOl4UNWaG54/QZoH4GA6w=; b=OLnm7SnfIZTITV+gk7hzegclmH
        YRrBXfNWJGlVwQ2JC+B8gR5aChtF748Ks72C5c9gsyFhR/o7GdD/G1DWAwa4lBf8xmLFoGxQ9+Dds
        q8xxi6b8ZesefUUd3JrEZqZNdzEyxyzW70UBUHDp4KVbhEBTxmCfVBrnugrg+snoquntIVj+lENzC
        ZTSnnT61HPWjpHCtyCrtjebvsDFTIX+gyOPOxKyfWsd2XcVE7FN2w4wYhUc74dbmtCZjk+xa8bnWk
        VIr1/0Tbka749fYH1XZi9rNUUxrlyo6K9ZDm6umDNqoCrf83hCVqV32CupLf/QQhE1ZqNvpO1xDia
        irDZUoww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTopY-007zcv-VT; Wed, 09 Aug 2023 19:26:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BD8330026C;
        Wed,  9 Aug 2023 21:26:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11FEF2023C23F; Wed,  9 Aug 2023 21:26:52 +0200 (CEST)
Date:   Wed, 9 Aug 2023 21:26:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] sched: Simplify ttwu()
Message-ID: <20230809192651.GU212435@hirez.programming.kicks-ass.net>
References: <20230801204121.929256934@infradead.org>
 <20230801211812.101069260@infradead.org>
 <xhsmh4jl8ckcf.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh4jl8ckcf.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:21:36PM +0100, Valentin Schneider wrote:
> On 01/08/23 22:41, Peter Zijlstra wrote:
> > Use guards to reduce gotos and simplify control flow.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/core.c |  221 +++++++++++++++++++++++++---------------------------
> >  1 file changed, 109 insertions(+), 112 deletions(-)
> >
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3706,14 +3706,14 @@ ttwu_stat(struct task_struct *p, int cpu
> >               struct sched_domain *sd;
> >
> >               __schedstat_inc(p->stats.nr_wakeups_remote);
> > -		rcu_read_lock();
> > +
> > +		guard(rcu)();
> 
> This isn't strictly equivalent, right? AFAICT that pushes the
> rcu_read_unlock() further down than it currently is - not a big deal, but
> indentation aside scoped_guard() would preserve that.

The full hunk:

| @@ -3706,14 +3706,14 @@ ttwu_stat(struct task_struct *p, int cpu
|  		struct sched_domain *sd;
|  
|  		__schedstat_inc(p->stats.nr_wakeups_remote);
| -		rcu_read_lock();
| +
| +		guard(rcu)();
|  		for_each_domain(rq->cpu, sd) {
|  			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
|  				__schedstat_inc(sd->ttwu_wake_remote);
|  				break;
|  			}
|  		}
| -		rcu_read_unlock();
|  	}

And you'll see the guard goes out of scope here ^

Which is the exact place rcu_read_unlock() was at, no?

|  
|  	if (wake_flags & WF_MIGRATED)

