Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962197B2143
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjI1PaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjI1P37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:29:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D27B7;
        Thu, 28 Sep 2023 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jd8dYp7Pt8k7CilbcSNgX/vhKFjZi5YS/kaYrGpcaOg=; b=Tho9mKtJbnXYlt4hSYEACcM56G
        q45VTY9HK9+1l97sJufYzPbUu6F26LTsmKIlv02ZgfCOTqDNynlWvidyGUafGQfqxp3OIhR61LmWx
        9tbndOmSa2gdFN5XG8O01QNBbVRo68zOUf98BfbZxLCZHCz4t3pHsOpZxgtDKyWAV0p6YZBdvfN/q
        QSAvWJENsjxFyojQAK1eobn6RjO+jkz0eb3KQe/lGS0e+/9EDiHcxiSNoJxoEiO/KbZ6ogx3JKneS
        QeSQZ9xW0tj5fZNxSh0/7TxWKUvYkdn5KxPNckXqmJ2KDMGAXmEyODk9iE2vlUVmC14OV3PAGHCJM
        kRGDIkLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlsxR-0058br-2J;
        Thu, 28 Sep 2023 15:29:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEEC63002E3; Thu, 28 Sep 2023 17:29:42 +0200 (CEST)
Date:   Thu, 28 Sep 2023 17:29:42 +0200
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
Message-ID: <20230928152942.GE27245@noisy.programming.kicks-ass.net>
References: <20230927160231.XRCDDSK4@linutronix.de>
 <ZRUX0YUrXfepRGKE@Boquns-Mac-mini.home>
 <20230928080900.GF9829@noisy.programming.kicks-ass.net>
 <ZRWTktRdej5OW53q@Boquns-Mac-mini.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRWTktRdej5OW53q@Boquns-Mac-mini.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:54:10AM -0700, Boqun Feng wrote:
> On Thu, Sep 28, 2023 at 10:09:00AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 27, 2023 at 11:06:09PM -0700, Boqun Feng wrote:
> > 
> > > I think this is a "side-effect" of commit f0f44752f5f6 ("rcu: Annotate
> > > SRCU's update-side lockdep dependencies"). In verify_lock_unused(), i.e.
> > > the checking for NMI lock usages, the logic is that
> > 
> > I think I'm having a problem with this commit -- that is, by adding
> > lockdep you're adding tracepoint, which rely on RCU being active.
> > 
> > The result is that SRCU is now no longer usable from !RCU regions.
> > 
> 
> Interesting
> 
> > Was this considered and intended?
> > 
> 
> No, I don't think I have considered this before, I think I may still
> miss something here, maybe you or Paul can provide an example for such
> a case?

The whole trace_.*_rcuidle() machinery. Which I thought I had fully
eradicated, but apparently still exists (with *one* user) :-/

Search for rcuidle in include/linux/tracepoint.h

Also, git grep trace_.*_rcuidle


