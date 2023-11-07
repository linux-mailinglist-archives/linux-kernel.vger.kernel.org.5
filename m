Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD17E3912
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjKGKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKGKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:25:42 -0500
X-Greylist: delayed 1204 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 02:25:37 PST
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12394122;
        Tue,  7 Nov 2023 02:25:36 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 3A79vlV9015665;
        Tue, 7 Nov 2023 03:57:47 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 3A79vjkH015661;
        Tue, 7 Nov 2023 03:57:45 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 7 Nov 2023 03:57:45 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, j.alglave@ucl.ac.uk,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, boqun.feng@gmail.com,
        davidtgoldblatt@gmail.com
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load) discussion
Message-ID: <20231107095745.GD19790@gate.crashing.org>
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop> <20231105230859.GH8262@noisy.programming.kicks-ass.net> <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 06:16:24PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 06, 2023 at 12:08:59AM +0100, Peter Zijlstra wrote:
> > Which is a contradiction if ever I saw one. It both claims this atrocity
> > fixes our volatile_if() woes while at the same time saying we're
> > unaffected because we don't use any of the C/C++ atomic batshit.
> 
> I guess that my traditional reply would be that if you are properly
> confused by all this, that just means that you were reading carefully.

I'll put that in my quote box :-)

> I am very much against incurring real overhead to solve an issue that is
> an issue only in theory and not in practice.  I wish I could confidently
> say that my view will prevail, but...

Given enough time most theory turns out to be practice.  If what you
are writing has a constrained scope, or a limited impact, or both, you
can ignore this "we'll deal with it later if/when it shows up".  But a
compiler does not have that luxury at all: it has to make correct
translations from source code to assembler code (or machine code
directly, for some compilers), or refuse to compile something.  Making
an incorrect translation is not an option.

> If this goes through and if developers see any overhead from relaxed
> atomics in a situation that matters to them, they will reach for some
> other tool.  Inline assembly and volatile accesses, I suppose.  Or the
> traditional approach of a compiler flag.

And I understand you want the standards to be more useful for the kernel
concurrency model?  Why, exactly?  I can think of many reasons, but I'm
a bit lost as to what motivates you here :-)


Segher
