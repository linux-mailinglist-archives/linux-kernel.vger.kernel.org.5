Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604CE7B15B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjI1IHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjI1IGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:06:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD0D1BB;
        Thu, 28 Sep 2023 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LekBj6wTZxTMKdeALQa2ROWFF95ATjADykPA+v1SjL0=; b=IjxmehA4a27eBfQLGua9QdyZ5Q
        YSVrMtlAbpx1XLo74atalEjDdTWhnS5WPkkqkP3ETGwsFNV/6/YOM6M/PofwR5bqSA+p7UTZAXVfa
        YbsUqz9ek8arGRXsb5qOEZZ9+P7RHTrWpqXtjv1XuykXaGxK4Z486HBPmDKOpjqgVo/P+YoLTnmdo
        wfHsfDrUPb369rrxSLsvNQV2vgzoB5EEuhjGDUeZY6CpZP7msqjGl/YUaAcReuwMbAfWP+7F9shrg
        Upnwol5EU3GFH6z1Sc7Rg8b7Ixn7nCIB3qlYGnSFDb9vSXPhk1UsmER5qu4P8/TrzFezhnp7i7ezI
        6vGs+DQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlm20-001JyD-Mt; Thu, 28 Sep 2023 08:05:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48408300454; Thu, 28 Sep 2023 10:05:56 +0200 (CEST)
Date:   Thu, 28 Sep 2023 10:05:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [RFC PATCH] srcu: Use try-lock lockdep annotation for NMI-safe
 access.
Message-ID: <20230928080556.GE9829@noisy.programming.kicks-ass.net>
References: <20230927160231.XRCDDSK4@linutronix.de>
 <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:06:09PM -0700, Boqun Feng wrote:

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e85b5ad3e206..1af8d44e5eb4 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5727,8 +5727,9 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>                 return;
> 
>         if (unlikely(!lockdep_enabled())) {
> +               /* Only do NMI context checking if it's a check lock */
>                 /* XXX allow trylock from NMI ?!? */
> -               if (lockdep_nmi() && !trylock) {
> +               if (check && lockdep_nmi() && !trylock) {
>                         struct held_lock hlock;
> 
>                         hlock.acquire_ip = ip;
> 
> Peter, thoughts?
> 

I think I prefer the trylock one. Fundamentally trylock conveys the 'we
wont block' thing. Making 'lock' sometimes work for NMI is just
confusing.
