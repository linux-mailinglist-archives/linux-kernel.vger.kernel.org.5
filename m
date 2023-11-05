Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095C37E17CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjKEXJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKEXJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:09:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF1FA;
        Sun,  5 Nov 2023 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJn9pUE4jhWZ42B4V7bBQeM4nDV7WZc44cKJDJP8pF8=; b=Ho3tin78mm2y9dGf/qp/e6vPp/
        /Hkrc3mf2bo0+g6wjUOT/ubyfUcEer7iJxRcppI+XApGmjlhBEihaD/R5KZCqcbGjIDcqYxUQuNLv
        hE25AOfLQ5QjWzyn/oLZP0u1fIT5Hsg3saig1v1q0EguP0KWPeY8VnBubAjbulTQMeVJitkfiEeiq
        LeFHxvu6Tu+alpWg1zG83vuXxmzp3TT13fXZu65TYo16GmU1+H3lXlgy4pen9dR6JRUoFXt3hT/BR
        91APnnt7sRwU2mHRr0PacA9RIxxvJyc3WNLOABbXoZtMWNpnA6vvP9YDLP/G0mzdFuqkOJswZkA3f
        QFnQyX6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qzmEl-002S01-Cj; Sun, 05 Nov 2023 23:09:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9525300326; Mon,  6 Nov 2023 00:08:59 +0100 (CET)
Date:   Mon, 6 Nov 2023 00:08:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     j.alglave@ucl.ac.uk, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        palmer@dabbelt.com, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        boqun.feng@gmail.com, davidtgoldblatt@gmail.com
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Message-ID: <20231105230859.GH8262@noisy.programming.kicks-ass.net>
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 02:08:13PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> FYI, unless someone complains, it is quite likely that C++ (and thus
> likely C) compilers and standards will enforce Hans Boehm's proposal
> for ordering relaxed loads before relaxed stores.  The document [1]
> cites "Bounding data races in space and time" by Dolan et al. [2], and
> notes an "average a 2.x% slow down" for ARMv8 and PowerPC.  In the past,
> this has been considered unacceptable, among other things, due to the
> fact that this issue is strictly theoretical.
> 
> This would not (repeat, not) affect the current Linux kernel, which
> relies on volatile loads and stores rather than C/C++ atomics.
> 
> To be clear, the initial proposal is not to change the standards, but
> rather to add a command-line argument to enforce the stronger ordering.
> However, given the long list of ARM-related folks in the Acknowledgments
> section, the future direction is clear.
> 
> So, do any ARMv8, PowerPC, or RISC-V people still care?  If so, I strongly
> recommend speaking up.  ;-)

OK, I finally had some time to read up...

Colour me properly confused. To me this all reads like C people can't
deal with relaxed atomics and are doing crazy things to try and 'fix'
it.

And while I don't speak for ARM/Power, I do worry this all takes C/C++
even further away from LKMM instead of closing the gap.

Worse, things like:

  https://lukegeeson.com/blog/2023-10-17-A-Proposal-For-Relaxed-Atomics/

Which state:

 "It would solve real issues in the Linux Kernel without costly fences
 (the kernel does not use relaxed atomics or the ISO C/C++ model - the
 load buffering issue affects the ISO C and linux memory models) ..."

Which is a contradiction if ever I saw one. It both claims this atrocity
fixes our volatile_if() woes while at the same time saying we're
unaffected because we don't use any of the C/C++ atomic batshit.

Anyway, I worry that all this faffing about will get in the way of our
volatile_if() 'demands'. Compiler people will tell us, just use relaxed
atomics, which that is very much not what we want. We know relaxed loads
and stores behave 'funny', we've been doing that for a long long time.
Don't impose that madness on us. And certainly don't use us as an excuse
to peddle this nonsense.

Bah, what a load of crazy.

/me stomps off in disgust.
