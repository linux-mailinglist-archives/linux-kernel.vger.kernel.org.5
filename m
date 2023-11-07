Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554657E32D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjKGCQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjKGCQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:16:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63710F;
        Mon,  6 Nov 2023 18:16:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D499DC433C7;
        Tue,  7 Nov 2023 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699323385;
        bh=CAY5eN+ENFGDKAuLurg++jGp9f4malk1xjfnSCzpDag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rEfgRbPhlKqibubsy412L3jQrZb8Fs3rNE8fah7geeMByUEYX5n6d+IJl5T/qa2Le
         Tki0kst00BZOBCDTNWPuuXa/t89nx0sjnMlbGv5fZMWCgfw2qZeE9lw7nylq1akdMp
         rjugCyQu3cNk7qv4N597AGfEnkmh95oMiNEymgXdePqQlPsGV321leTAsm5O0pEhjD
         qU/sqpvciQ1NWTCfPzOI6uA3GKLJ9wATdURsCD1+YST8nGIAn7fyn1z+l0e+IBYY/k
         ekpQGWqla3RIf1I20bANkqIGUT+c4Euk5pdQCp8ubYsAAdLo1yWJ0TzwwHT64Mhbe1
         JfYhjfYe1qFIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 60C9BCE0DD2; Mon,  6 Nov 2023 18:16:24 -0800 (PST)
Date:   Mon, 6 Nov 2023 18:16:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     j.alglave@ucl.ac.uk, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        palmer@dabbelt.com, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        boqun.feng@gmail.com, davidtgoldblatt@gmail.com
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Message-ID: <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
 <20231105230859.GH8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105230859.GH8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:08:59AM +0100, Peter Zijlstra wrote:
> On Fri, Oct 27, 2023 at 02:08:13PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > FYI, unless someone complains, it is quite likely that C++ (and thus
> > likely C) compilers and standards will enforce Hans Boehm's proposal
> > for ordering relaxed loads before relaxed stores.  The document [1]
> > cites "Bounding data races in space and time" by Dolan et al. [2], and
> > notes an "average a 2.x% slow down" for ARMv8 and PowerPC.  In the past,
> > this has been considered unacceptable, among other things, due to the
> > fact that this issue is strictly theoretical.
> > 
> > This would not (repeat, not) affect the current Linux kernel, which
> > relies on volatile loads and stores rather than C/C++ atomics.
> > 
> > To be clear, the initial proposal is not to change the standards, but
> > rather to add a command-line argument to enforce the stronger ordering.
> > However, given the long list of ARM-related folks in the Acknowledgments
> > section, the future direction is clear.
> > 
> > So, do any ARMv8, PowerPC, or RISC-V people still care?  If so, I strongly
> > recommend speaking up.  ;-)
> 
> OK, I finally had some time to read up...
> 
> Colour me properly confused. To me this all reads like C people can't
> deal with relaxed atomics and are doing crazy things to try and 'fix'
> it.
> 
> And while I don't speak for ARM/Power, I do worry this all takes C/C++
> even further away from LKMM instead of closing the gap.
> 
> Worse, things like:
> 
>   https://lukegeeson.com/blog/2023-10-17-A-Proposal-For-Relaxed-Atomics/
> 
> Which state:
> 
>  "It would solve real issues in the Linux Kernel without costly fences
>  (the kernel does not use relaxed atomics or the ISO C/C++ model - the
>  load buffering issue affects the ISO C and linux memory models) ..."
> 
> Which is a contradiction if ever I saw one. It both claims this atrocity
> fixes our volatile_if() woes while at the same time saying we're
> unaffected because we don't use any of the C/C++ atomic batshit.

I guess that my traditional reply would be that if you are properly
confused by all this, that just means that you were reading carefully.

> Anyway, I worry that all this faffing about will get in the way of our
> volatile_if() 'demands'. Compiler people will tell us, just use relaxed
> atomics, which that is very much not what we want. We know relaxed loads
> and stores behave 'funny', we've been doing that for a long long time.
> Don't impose that madness on us. And certainly don't use us as an excuse
> to peddle this nonsense.

I am very much against incurring real overhead to solve an issue that is
an issue only in theory and not in practice.  I wish I could confidently
say that my view will prevail, but...

> Bah, what a load of crazy.
> 
> /me stomps off in disgust.

If this goes through and if developers see any overhead from relaxed
atomics in a situation that matters to them, they will reach for some
other tool.  Inline assembly and volatile accesses, I suppose.  Or the
traditional approach of a compiler flag.

							Thanx, Paul
