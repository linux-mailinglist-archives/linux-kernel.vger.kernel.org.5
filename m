Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64880660F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjLFEHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFEHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA01B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 20:07:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE132C433C7;
        Wed,  6 Dec 2023 04:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701835669;
        bh=KMG769MNITrQ/3a5d6hMdwbizXr8YhfZCzIXqzcUdYA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f1748msnH4UQkZY4UnLQFsRD/ti09IyK8xqHUWb8u87QYi26s4DPocVQXv5FtSbMd
         TZcXEoX6s1arM0oMdj9IJ9VKA+P3O+MGKAScOm6cOcxw4u6ry8SIbysXE1m7Os9mNY
         98Hyr8j9xBAO5QQeDvdHXRflHiCSrRW1Cux1bcNQeNCQgr6oCYK8qCqNfH1G07zHep
         lGyfWwryQfZJy05NiswJd1h9tJOR8jCp57z9Sowi2jcPbJyGPXZfRHBAVHVDSNO+1T
         5xNEkgQXuB7zi+9ME3m4kZLePMkZmCljR9UkhQ82s55XJLAJNzVRKYqVft6nDH8rBt
         Rvkp9wYHkaViw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 612ACCE0B04; Tue,  5 Dec 2023 20:07:49 -0800 (PST)
Date:   Tue, 5 Dec 2023 20:07:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Message-ID: <106ab2d8-f63b-4c52-a93f-fc499d43fc13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
 <20231205100114.0bd3c4a2@gandalf.local.home>
 <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
 <87il5cpfn1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il5cpfn1.fsf@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:18:26PM -0800, Ankur Arora wrote:
> 
> Paul E. McKenney <paulmck@kernel.org> writes:
> 
> > On Tue, Dec 05, 2023 at 10:01:14AM -0500, Steven Rostedt wrote:
> >> On Mon, 4 Dec 2023 17:01:21 -0800
> >> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>
> >> > On Tue, Nov 28, 2023 at 11:53:19AM +0100, Thomas Gleixner wrote:
> >> > > Paul!
> >> > >
> >> > > On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
> >> > > > On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
> ...
> >> > >   3) Looking at the initial problem Ankur was trying to solve there is
> >> > >      absolutely no acceptable solution to solve that unless you think
> >> > >      that the semantically invers 'allow_preempt()/disallow_preempt()'
> >> > >      is anywhere near acceptable.
> >> >
> >> > I am not arguing for allow_preempt()/disallow_preempt(), so for that
> >> > argument, you need to find someone else to argue with.  ;-)
> >>
> >> Anyway, there's still a long path before cond_resched() can be removed. It
> >> was a mistake by Ankur to add those removals this early (and he has
> >> acknowledged that mistake).
> >
> > OK, that I can live with.  But that seems to be a bit different of a
> > take than that of some earlier emails in this thread.  ;-)
> 
> Heh I think it's just that this thread goes to (far) too many places :).
> 
> As Steven says, the initial series touching everything all together
> was a mistake. V1 adds the new preemption model alongside the existing
> ones locally defines cond_resched() as nop.
> 
> That'll allow us to experiment and figure out where there are latency
> gaps.

Sounds very good!

Again, I am very supportive of the overall direction.  Devils and details
and all that.  ;-)

							Thanx, Paul
