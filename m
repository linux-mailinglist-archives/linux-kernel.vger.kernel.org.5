Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFEE7D0A81
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376466AbjJTI0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376440AbjJTI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:26:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BED119;
        Fri, 20 Oct 2023 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=osKF5xTE5Os5a5WuR1qk2MjC7K8kkdHQ+IqvT4rA6Yw=; b=RRATIkQhj9m5LFwq5iYAbS63vW
        z4aKuTIIYOZfs3dDKmQY0Y5/4Io9WB4Eul5JUY/3KNsQJeAEYD3pmG4Rffg2X676ZCwuaKtFIynyB
        mnYgtC/DUJ/n9/X+Wsj0zgW9PK+RMLyeEfSxWWSMzGzuuqPNYD+jPr2UUFEOgv1HphaYEG/7Xnyxr
        MEilGOpGwDNm6gnSI0af1NDmPlpxLHmpivXG+qNBmoQ/66M2+t/kP1zK8lDSIBh41dt6BivwaX4Wm
        3PCcLw/FG06r5J9aE8QNrJLOFCp+QBEVYDyrMOycRKfedCdXeiKbjgVuHs+x6dAb9cDQhAM2Dq54i
        CG6L7kTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtkp2-00AsVt-0q;
        Fri, 20 Oct 2023 08:25:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E87B8300392; Fri, 20 Oct 2023 10:25:31 +0200 (CEST)
Date:   Fri, 20 Oct 2023 10:25:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/4] Revert "kernel/sched: Modify initial boot task idle
 setup"
Message-ID: <20231020082531.GS33217@noisy.programming.kicks-ass.net>
References: <20231019233543.1243121-1-frederic@kernel.org>
 <20231019233543.1243121-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019233543.1243121-5-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 01:35:43AM +0200, Frederic Weisbecker wrote:
> Now that rcutiny can deal with early boot PF_IDLE setting, revert
> commit cff9b2332ab762b7e0586c793c431a8f2ea4db04.
> 
> This fixes several subtle issues introduced on RCU-tasks(-trace):
> 
> 1) RCU-tasks stalls when:
> 
>    1.1 Grace period is started before init/0 had a chance to set PF_IDLE,
>        keeping it stuck in the holdout list until idle ever schedules.
> 
>    1.2 Grace period is started when some possible CPUs have never been
>        online, keeping their idle tasks stuck in the holdout list until
>        the CPU ever boots up.
> 
>    1.3 Similar to 1.1 but with secondary CPUs: Grace period is started
>        concurrently with secondary CPU booting, putting its idle task in
>        the holdout list because PF_IDLE isn't yet observed on it. It
>        stays then stuck in the holdout list until that CPU ever
>        schedules. The effect is mitigated here by all the smpboot
>        kthreads and the hotplug AP thread that must run to bring the
>        CPU up.
> 
> 2) Spurious warning on RCU task trace that assumes offline CPU's idle
>    task is always PF_IDLE.
> 
> More issues have been found in RCU-tasks related to PF_IDLE which should
> be fixed with later changes as those are not regressions:
> 
> 3) The RCU-Tasks semantics consider the idle loop as a quiescent state,
>    however:
> 
>    3.1 The boot code preceding the idle entry is included in this
>        quiescent state. Especially after the completion of kthreadd_done
>        after which init/1 can launch userspace concurrently. The window
>        is tiny before PF_IDLE is set but it exists.
> 
>    3.2 Similarly, the boot code preceding the idle entry on secondary
>        CPUs is wrongly accounted as RCU tasks quiescent state.
> 

Urgh... so the plan is to fix RCU-tasks for all of the above to not rely
on PF_IDLE ? Because I rather like the more strict PF_IDLE and
subsequently don't much like this revert.
