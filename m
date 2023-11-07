Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6987E4657
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjKGQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:44:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC94E93;
        Tue,  7 Nov 2023 08:44:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711B2C433C7;
        Tue,  7 Nov 2023 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699375493;
        bh=kNJQEfH4fV5bGrV5pEKSxIjNeERGSHFawubQFMpT+HA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iJ1IijufEZT9JCunm4YGwT3t6VR+eU2MTcRVnaJ+ftCpIfCXRPV/e41Cww9vbzpcP
         V06Hk17fM0INcfPdSeRL8hQchYgwcpzg1fZzSWrv/KDiU+H4Xn4kMrC7gAv9KOLtWq
         W1JF8+YBOSMxPa5grNbnXXdEnvII8BrQhbFiE54DVpKOmfBco6Iictnd519+xlF0sN
         mI5MZxS1DKt8AuiwId2REA7vwVEJTClha/xViMUhOpJ4Zv+V8Izj9FKMoQetL+IN95
         KXfjZMP1XoLptHvez5QvhNf+MHrFFdy7QJ0k2TCcAaAMHPxosCdE8n/lo8WNN/ziMI
         kRaEfbA5O3U5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E284BCE0E95; Tue,  7 Nov 2023 08:44:51 -0800 (PST)
Date:   Tue, 7 Nov 2023 08:44:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, j.alglave@ucl.ac.uk,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, boqun.feng@gmail.com,
        davidtgoldblatt@gmail.com
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Message-ID: <bf18e3f7-f8be-4b11-b348-b784420bda16@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
 <20231105230859.GH8262@noisy.programming.kicks-ass.net>
 <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
 <20231107095745.GD19790@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107095745.GD19790@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:57:45AM -0600, Segher Boessenkool wrote:
> On Mon, Nov 06, 2023 at 06:16:24PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 06, 2023 at 12:08:59AM +0100, Peter Zijlstra wrote:
> > > Which is a contradiction if ever I saw one. It both claims this atrocity
> > > fixes our volatile_if() woes while at the same time saying we're
> > > unaffected because we don't use any of the C/C++ atomic batshit.
> > 
> > I guess that my traditional reply would be that if you are properly
> > confused by all this, that just means that you were reading carefully.
> 
> I'll put that in my quote box :-)

Please accept my condolences.  ;-)

> > I am very much against incurring real overhead to solve an issue that is
> > an issue only in theory and not in practice.  I wish I could confidently
> > say that my view will prevail, but...
> 
> Given enough time most theory turns out to be practice.

Actually, in this field, it tends to be the other way around.  After
all, if practice followed theory, we would have all abandoned locks
for non-blocking synchronization in the 1990s, and then switched to
transactional memory in the decade following.

>                                                          If what you
> are writing has a constrained scope, or a limited impact, or both, you
> can ignore this "we'll deal with it later if/when it shows up".  But a
> compiler does not have that luxury at all: it has to make correct
> translations from source code to assembler code (or machine code
> directly, for some compilers), or refuse to compile something.  Making
> an incorrect translation is not an option.

But in this case, it would be most excellent if compiler practice were
to follow theory.  Because the theory of avoiding OOTA without emitting
extraneous instructions is quite simple:

	Avoid breaking semanitic dependencies.

Given that, as you say, incorrect translation is not an option, it
should not be hard to satisfy oneself that a correct compiler must
avoid breaking semantic dependencies, at least for compilers that do not
indulge in value speculation, which would be a very brave indulgence.
Or, alternatively, that any such breaking constitutes a compiler bug.

But when this approach was put forward about a decade ago, compiler
writers were quite resistant.  Plus they argued that concurrency was a
niche use case, which might be a less convincing argument these days.

> > If this goes through and if developers see any overhead from relaxed
> > atomics in a situation that matters to them, they will reach for some
> > other tool.  Inline assembly and volatile accesses, I suppose.  Or the
> > traditional approach of a compiler flag.
> 
> And I understand you want the standards to be more useful for the kernel
> concurrency model?  Why, exactly?  I can think of many reasons, but I'm
> a bit lost as to what motivates you here :-)

My hope is that a number of useful and efficient concurrent-code idioms
can be implemented with help from the compiler, in the Linux kernel
and elsewhere.  Or failing that, at least with less resistance on the
part of the compiler.

Here is an incomplete list:

1.	When it is necessary for fast-path code to load from a shared
	variable, it should be possible to use a single normal load
	instruction for this purpose.  Our current conversation touches
	on this point.

2.	Address dependencies extending to loads do not generate OOTA,
	but are another example of this "just use a normal load" issue.
	Address dependencies need more careful handling because compilers
	can and do convert them to control dependencies.  Which is why
	the Linux-kernel advice in rcu_dereference.rst is to avoid using
	integers for address dependencies, and most especially to avoid
	using booleans for this.

	But it would be nice to be able to tell the compiler that a
	given variable, function parameter, and/or return value carried
	a dependency.  At a minimum, it would be nice if the compiler
	could complain if that dependency would be broken.

3.	It should be possible to implement 50-year-old concurrent
	algorithms straightforwardly (LIFO push stack being the poster
	boy here [1]).	Right now, pointer provenance gets in the way
	of this.  On the other hand, clang/LLVM does quite well without
	pointer provenance, so one has to wonder just how important
	pointer-provenance-based optimizations really are.

	Hans Boehm, were he looking over my shoulder, would add that
	there are a number of single-threaded algorithms that are made
	unnecessarily complex due pointer provenance issues [3].  Hans and
	I often come down on opposite sides of concurrency issues, so
	in cases like this one where we do agree, you just might want
	to pay attention.  ;-)

	Anthony Williams goes further, arguing that pointers should at
	least sometimes just be bags of bits, that is, that the role of
	pointer provenance should be greatly reduced or even eliminated [3].

4.	Semantics of volatile.	Perhaps the current state is the best
	that can be hoped for, but given that the current state is a
	few vague words in the standard in combination with the fact
	that C-language device drivers must be able to use volatile
	to reliably and concurrently access memory shared with device
	firmware, one would hope for better.

5.	UB on signed integer overflow.	Right now, the kernel just
	forces wrapping, which works, so maybe we don't really care
	all that much.	But at this point, it seems to me that it was a
	mistake for the language to have failed to provide a means of
	specifying signed integers that wrap (int_wrap?).  (Yes, yes,
	you can get them by making an atomic signed int, but that is
	not exactly an ergonomic workaround.)

Is this really too much to ask?  If so, why?

The Linux-kernel memory model and associated coding guidelines form
a way of achieving the items on this list with the current level of
cooperation from the compilers, or perhaps more accurately, current
level of lack of cooperation.

The thing is that C11 and C++11 did pretty much the bare minimum to
support concurrency.  After all, when that effort started back in 2005,
concurrency really was a niche use case.  It is only reasonable to
expect a few adjustments almost 20 years on.

Hey, you asked!!!  ;-)

							Thanx, Paul

[1] https://docs.google.com/document/d/12paeC4suYAmVZlQvqytiCjGmEeGdJn0X7oM0SRLMALk/edit
[2] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2021/p1726r5.pdf
[3] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p2188r1.html
