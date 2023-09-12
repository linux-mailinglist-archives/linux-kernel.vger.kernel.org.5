Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8B79CC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjILJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjILJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:45:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70AE67
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZrbW79OPhmG1Mpq3uAPJjvHDT7aj4ZsdYnBQ8uRYZRU=; b=EIXfv47ybjiq75LnX4hyhcv0ln
        8tpEW8FmG6ddy15s/ntdhV2wmuxb2sSOQP/Lqq001GWw3U3i0eaHxwVG0pfu3wBPHRTsXEHZCqh7K
        /tUBlzbZl8laALO+Y1TsasvCx3Z0tkSpIzf5p3tOvmwkr1uAaR3/AQeCGhzz8tuPfP7HM1IWhtiXB
        b/F3p+n6q0t6FJVuXLbX1bG6r3ALK/lHDUt0UVlMuCd2fJp/3E2MoeT1maUWhMHQLAoYwfUozckKr
        C11AsOQfqPp0e7MNbhARM32imyyGuBVqqJz7TxG5FAeZCJwM4p+s2AbouHG9+7vJTyvNVqTkL2ePW
        rtQXaf/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfzwm-0060b5-1O;
        Tue, 12 Sep 2023 09:44:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85831300348; Tue, 12 Sep 2023 11:44:41 +0200 (CEST)
Date:   Tue, 12 Sep 2023 11:44:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230912094441.GA13926@noisy.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912092709.GE35261@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:27:09AM +0200, Peter Zijlstra wrote:
> On Sun, Sep 10, 2023 at 04:42:27PM +0200, Borislav Petkov wrote:
> > On Sat, Sep 09, 2023 at 11:25:54AM +0200, Peter Zijlstra wrote:
> > > So what you end up with is:
> > > 
> > > 661:
> > >   "one byte orig insn"
> > >   "one nop because alt1 is 2 bytes"
> > >   "one nop because alt2 is 3 bytes"
> > > 
> > > right?
> > 
> > Right.
> > 
> > > This becomes more of a problem with your example above where the
> > > respective lengths are 0, 5, 16. In that case, when you patch 5, you'll
> > > leave 11 single nops in there.
> > 
> > Well, I know what you mean but the code handles that gracefully and it
> > works. Watch this:
> 
> Aah, because we run optimize_nops() for all alternatives, irrespective
> of it being selected. And thus also for the longest and then that'll fix
> things up.
> 
> OK, let me check on objtool.

OK, I think objtool really does need the hunk you took out.

The problem there is that we're having to create ORC data that is valid
for all possible alternatives -- there is only one ORC table (unless we
go dynamically patch the ORC table too, but so far we've managed to
avoid doing that).

The constraint we have is that for every address the ORC data must match
between the alternatives, but because x86 is a variable length
instruction encoding we can (and do) play games. As long as the
instruction addresses do not line up, they can have different ORC data.

One place where this matters is the tail, if we consider this a string
of single byte nops, that forces a bunch of ORC state to match. So what
we do is that we assume the tail is a single large NOP, this way we get
minimal overlap / ORC conflicts.

As such, we need to know the max length when constructing the
alternatives, otherwise you get short alternatives jumping to somewhere
in the middle of the actual range and well, see above.
