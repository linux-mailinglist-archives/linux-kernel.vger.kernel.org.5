Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF47D65B9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJYItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjJYIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:48:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EE1BB;
        Wed, 25 Oct 2023 01:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F0PnvleoCLYlsWDIAZ9QRM9jwjwZHpt5kAYggTq8dSo=; b=Wexg2ZNPC1rEOENJ/ysbmrdopg
        pzAAgfTFVUzYdpOZePb0gUzTz/hnc+XTqzneZpu4tXUs5yLz74QZyXxt4xWUGlkItlb3U3bJPtjxv
        IQziYYBSoGy++TgHmKwqR0Up98GmdlMwLNTCMsrvRjgcjxjw2VTvqOIbDiDh+KQxgCMjveBe3gRqN
        ARUDhybDMbWkfKj5e7SpcdN2Sk0Uy6u69rsb6kPL++cVZemf8vO2CaHS6kvXNwHZtdc92U1oAtpBB
        HaWKOgOtXvybTDjcrVN9Ihwe2TZxZlWSHcIlL0Kn2iqvEA8bFLSW8dgfJ4jxCo0bEI9X61r/cpgKk
        s3tyyYFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvZZ4-007krV-8v; Wed, 25 Oct 2023 08:48:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF40430047C; Wed, 25 Oct 2023 10:48:33 +0200 (CEST)
Date:   Wed, 25 Oct 2023 10:48:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 4/4] sched: Exclude CPU boot code from PF_IDLE area
Message-ID: <20231025084833.GE37471@noisy.programming.kicks-ass.net>
References: <20231024214625.6483-1-frederic@kernel.org>
 <20231024214625.6483-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024214625.6483-5-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 11:46:25PM +0200, Frederic Weisbecker wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8885be2c143e..ad18962b921d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1945,7 +1945,7 @@ extern struct task_struct *idle_task(int cpu);
>   */
>  static __always_inline bool is_idle_task(const struct task_struct *p)
>  {
> -	return !!(p->flags & PF_IDLE);
> +	return !!(READ_ONCE(p->flags) & PF_IDLE);
>  }
>  
>  extern struct task_struct *curr_task(int cpu);
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3b9d5c7eb4a2..3a1991010f4e 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  
> +	WRITE_ONCE(current->flags, current->flags & ~PF_IDLE);
>  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> +
>  	rcutree_report_cpu_dead();
>  	st->state = CPUHP_AP_IDLE_DEAD;
>  	/*
> @@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  
> +	WRITE_ONCE(current->flags, current->flags | PF_IDLE);
> +
>  	/* Happens for the boot cpu */
>  	if (state != CPUHP_AP_ONLINE_IDLE)
>  		return;

Without changing *ALL* ->flags stores to WRITE_ONCE() I don't see the
point of this. Also, since we only care about a single bit, how does
store tearing affect things?

Not to mention if we're really paranoid, what are the SMP ordering
considerations :-)

[ also, PF_ is used for Protocol Family, Page Flag and Process Flag,
  grepping is a pain in the arse :-( ]
