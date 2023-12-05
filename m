Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CDD8043AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjLEBDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:03:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22922A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:03:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F1C433C7;
        Tue,  5 Dec 2023 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701738235;
        bh=Bs9k/6LoUODYcT83sb8TNsFZmO2JrEzRWlVXH0bC4/8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FL4NuMjyUEvhEfw6zbKZYj5RExoInuV0ePirGfgE7E7M4QrqD+0xVK1990Nx5iEFe
         7nMA6P03QxPN6J7poviGPulyznm4U6sYJ8Z7IIkiR3aYz4SpgWssQgaBp9PfRqFddh
         e+7F+a7pDXD9mqMIvmLt6ndZBIPnOTjlLbqeN5R+RsAN19JgHxi9eMN7wCgJayN72z
         S2+hAutD5D6aM51vYrj/7m5iqsZE4WdoImSPurfZ9dKrz1iq83m9KHbn9t6IPRr7VF
         P/6Bku8Qy3k7I5J7MaLPL5QD1kVNoDeMsipKuKi8UNJYjFYtsYPiYK/Oz1l8gvAuSj
         CuH9XQ/wmz7Kw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44B48CE1147; Mon,  4 Dec 2023 17:03:55 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:03:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <edf8fbd5-6779-4645-b030-2e39ba8b3e46@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <87plztvig2.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plztvig2.fsf@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:30:53AM -0800, Ankur Arora wrote:
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > Paul!
> >
> > On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:
> >> On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:
> >>> Right now, the use of cond_resched() is basically a whack-a-mole game where
> >>> we need to whack all the mole loops with the cond_resched() hammer. As
> >>> Thomas said, this is backwards. It makes more sense to just not preempt in
> >>> areas that can cause pain (like holding a mutex or in an RCU critical
> >>> section), but still have the general kernel be fully preemptable.
> >>
> >> Which is quite true, but that whack-a-mole game can be ended without
> >> getting rid of build-time selection of the preemption model.  Also,
> >> that whack-a-mole game can be ended without eliminating all calls to
> >> cond_resched().
> >
> > Which calls to cond_resched() should not be eliminated?
> >
> > They all suck and keeping some of them is just counterproductive as
> > again people will sprinkle them all over the place for the very wrong
> > reasons.
> 
> And, as Thomas alludes to here, cond_resched() is not always cost free.
> Needing to call cond_resched() forces us to restructure hot paths in
> ways that results in worse performance/complex code.
> 
> One example is clear_huge_page(), where removing the need to call
> cond_resched() every once in a while allows the processor to optimize
> differently.
> 
>   *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
>                           (GB/s)                (GB/s)
> 
>   pg-sz=2MB                14.55                 19.29    +32.5%
>   pg-sz=1GB                19.34                 49.60   +156.4%
> 
> (See https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/)
> 
> And, that's one of the simpler examples from mm. We do this kind of arbitrary
> batching all over the place.
> 
> Or see the filemap_read() example that Linus gives here:
>  https://lore.kernel.org/lkml/CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com/#t

I already agree that some cond_resched() calls can cause difficulties.
But that is not the same as proving that they *all* should be removed.

							Thanx, Paul
