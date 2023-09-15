Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44E87A1C59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjIOKfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjIOKfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:35:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE33CA1;
        Fri, 15 Sep 2023 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqoJwBNCiyqSvQr0zdz0P988LVcIrm0PsE963tNYtsY=; b=LCgA4w+tdceGRYZsXiQVZ/5vMQ
        4vBB49KzxqusDcPYTbcsbAMIWmWG48ADLyl0NcUTRFXqDGPk99siElEJgEkMdo4Ur2jkXRjb54COa
        HXLUca0aNoSjYnaeWkZFAD9vNzgncr43wqvyyZqXKEl1Ns5ajEaVMxGT/2fvcEadgBRQmE1B+41Pf
        H6f0NFM4J/wOzubauqpQDPqC/scGtP5QfljOuuNyeWBwYjqa3nDwKE7UTjhVLWK7ej7I0K31vg9i+
        A/Wk66vx9NTQF/zF/4Z6r1sDvxA2D+pdmALguSQ5Mde7qxTrZCQh1SRUBlSzBrwAmE4yhOqyQYVKU
        YFNMTKzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh6AL-009A3c-28; Fri, 15 Sep 2023 10:35:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6E1A3003F2; Fri, 15 Sep 2023 12:35:12 +0200 (CEST)
Date:   Fri, 15 Sep 2023 12:35:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [tip: core/urgent] panic: Reenable preemption in WARN slowpath
Message-ID: <20230915103512.GC6721@noisy.programming.kicks-ass.net>
References: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
 <169477058360.27769.17772363826818333894.tip-bot2@tip-bot2>
 <ZQQnnjzxbTwpn61F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQQnnjzxbTwpn61F@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:45:02AM +0200, Ingo Molnar wrote:
> 
> * tip-bot2 for Lukas Wunner <tip-bot2@linutronix.de> wrote:
> 
> > The following commit has been merged into the core/urgent branch of tip:
> > 
> > Commit-ID:     cccd32816506cbac3a4c65d9dff51b3125ef1a03
> > Gitweb:        https://git.kernel.org/tip/cccd32816506cbac3a4c65d9dff51b3125ef1a03
> > Author:        Lukas Wunner <lukas@wunner.de>
> > AuthorDate:    Fri, 15 Sep 2023 09:55:39 +02:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Fri, 15 Sep 2023 11:28:08 +02:00
> > 
> > panic: Reenable preemption in WARN slowpath
> > 
> > Commit:
> > 
> >   5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")
> > 
> > amended warn_slowpath_fmt() to disable preemption until the WARN splat
> > has been emitted.
> > 
> > However the commit neglected to reenable preemption in the !fmt codepath,
> > i.e. when a WARN splat is emitted without additional format string.
> > 
> > One consequence is that users may see more splats than intended.  E.g. a
> > WARN splat emitted in a work item results in at least two extra splats:
> > 
> >   BUG: workqueue leaked lock or atomic
> >   (emitted by process_one_work())
> > 
> >   BUG: scheduling while atomic
> >   (emitted by worker_thread() -> schedule())
> > 
> > Ironically the point of the commit was to *avoid* extra splats. ;)
> > 
> > Fix it.
> 
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 07239d4..ffa037f 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
> >  	if (!fmt) {
> >  		__warn(file, line, __builtin_return_address(0), taint,
> >  		       NULL, NULL);
> > +		warn_rcu_exit(rcu);
> >  		return;
> 
> BTW., one more thing we might want to consider here is to re-enable 
> preemption in warn_rcu_exit() a bit more gently, without forcing a
> pending reschedule, ie. preempt_enable_no_resched() or so?

nah, it's a warn, if that triggers you get to keep the pieces. Also
preempt_enable_no_resched() isn't exported because its a horribly
dangerous function.
