Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E297DC102
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJ3ULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJ3ULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:11:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF2D3;
        Mon, 30 Oct 2023 13:11:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0739DC433C8;
        Mon, 30 Oct 2023 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696702;
        bh=MKXkpWtKRAzxJ/2VbWDO/dJ5fbKLGEFRwo46utBR/yA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J2J8gymeVNMF+hW4edUc+9QdN2jIzBlmdKS80aqogRD7JYId+2ICMFcVbPNe+iT0x
         HMG+Eh6lyd86pqjgRkc5d0s8OIYlYOoy9C/8RuqcLvZcH7/3pACRjPJ9SEBOqPUvk0
         CiqzQkX1wyzmqNF/IVkUHcpM4S4oS0JW83gKYJKAAjzvtvS603hKhbqLq9Yd0Q9qqo
         XxhQl11w/v/9Ks8hEQbjn0/b7FrVJtxq3Xi1PIt2i8KChBXaGZyZygOCyTKfxwj8OS
         MFWunIjEdO/q4avNNowgWPLb0eggLQpfLE3Upc/B0r02N+TeVgANpPISFXU32vb0D8
         RKVtfMp/mKreQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9D844CE0BDD; Mon, 30 Oct 2023 13:11:41 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:11:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Message-ID: <622438a5-4d20-4bc9-86b9-f3de55ca6cda@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231027144050.110601-1-frederic@kernel.org>
 <20231027144050.110601-3-frederic@kernel.org>
 <20231027192026.GG26550@noisy.programming.kicks-ass.net>
 <2a0d52a5-5c28-498a-8df7-789f020e36ed@paulmck-laptop>
 <20231027224628.GI26550@noisy.programming.kicks-ass.net>
 <200c57ce-90a7-418b-9527-602dbf64231f@paulmck-laptop>
 <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030082138.GJ26550@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:21:38AM +0100, Peter Zijlstra wrote:
> On Fri, Oct 27, 2023 at 04:41:30PM -0700, Paul E. McKenney wrote:
> > On Sat, Oct 28, 2023 at 12:46:28AM +0200, Peter Zijlstra wrote:
> 
> > > Nah, this is more or less what I feared. I just worry people will come
> > > around and put WRITE_ONCE() on the other end. I don't think that'll buy
> > > us much. Nor do I think the current READ_ONCE()s actually matter.
> > 
> > My friend, you trust compilers more than I ever will.  ;-)
> 
> Well, we only use the values {0,1,2}, that's contained in the first
> byte. Are we saying compiler will not only byte-split but also
> bit-split the loads?
> 
> But again, lacking the WRITE_ONCE() counterpart, this READ_ONCE() isn't
> getting you anything, and if you really worried about it, shouldn't you
> have proposed a patch making it all WRITE_ONCE() back when you did this
> tasks-rcu stuff?

There are not all that many of them.  If such a WRITE_ONCE() patch would
be welcome, I would be happy to put it together.

> > > But perhaps put a comment there, that we don't care for the races and
> > > only need to observe a 0 once or something.
> > 
> > There are these two passagers in the big lock comment preceding the
> > RCU Tasks code:
> 
> > // rcu_tasks_pregp_step():
> > //      Invokes synchronize_rcu() in order to wait for all in-flight
> > //      t->on_rq and t->nvcsw transitions to complete.  This works because
> > //      all such transitions are carried out with interrupts disabled.
> 
> > Does that suffice, or should we add more?
> 
> Probably sufficient. If one were to have used the search option :-)
> 
> Anyway, this brings me to nvcsw, exact same problem there, except
> possibly worse, because now we actually do care about the full word.
> 
> No WRITE_ONCE() write side, so the READ_ONCE() don't help against
> store-tearing (however unlikely that actually is in this case).

Again, if such a WRITE_ONCE() patch would be welcome, I would be happy
to put it together.

> Also, I'm not entirely sure I see why you need on_rq and nvcsw. Would
> not nvcsw increasing be enough to know it passed through a quiescent
> state? Are you trying to say that if nvcsw hasn't advanced but on_rq is
> still 0, nothing has changed and you can proceed?
> 
> Or rather, looking at the code it seems use the inverse, if on_rq, nvcsw
> must change.
> 
> Makes sense I suppose, no point waiting for nvcsw to change if the task
> never did anything.

Exactly, the on_rq check is needed to avoid excessively long grace
periods for tasks that are blocked for long periods of time.

							Thanx, Paul
