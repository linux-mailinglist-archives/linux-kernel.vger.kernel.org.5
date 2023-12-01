Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84852801363
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379464AbjLATI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379443AbjLATI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:08:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7FD63
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:09:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC3C433C8;
        Fri,  1 Dec 2023 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701457744;
        bh=gfAKpxTJr88+nH/VYuHmnmVgmXh+i5LB/OHeGQr5JjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uk+N8e9BxrNW/+0NPefP+KTXN1tRzsSxKjbX3222yyJTHsp0Qiwq/dHiIYeLFW4Wa
         vW2o9uokp1Z6s0yhTTd6Bl45P4byEoHtxTn1lLh1Mzp5U7A8ffByJUoClDe9MqYp7M
         cgPr4a7BKx+t1zFIbce8PzdpV0aWff3t4Mzi0W9Wxdl5NR+o30RVS5v2eGfAXxchYo
         96qAtdyPXpe62P4fCgJjhYN5KXRfassQS8OXs7f08EY2WuKT7ZI3NR1YjS2g6/0g25
         XNoPybkWKotiBFJr3qmGCYAVIiw3uHKIao9gLzPJIJN6HaZDnCFVoZVCfHUq1bgWXN
         GRiQdEYKwfHTg==
Date:   Fri, 1 Dec 2023 11:08:41 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Summary of discussion following LPC2023 sframe talk
Message-ID: <20231201190841.z5flmsmzectrlrew@treble>
References: <a79d1bc3-1aca-4169-a963-b7c9279aa7fd@efficios.com>
 <20231115154912.GC8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115154912.GC8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:49:12PM +0100, Peter Zijlstra wrote:
> > - JITs:
> > 
> >   - There are two approaches to skip over JITted code stacks:
> > 
> >     - If the jitted code has frame pointers, then use this.
> > 
> >     - If we figure out that some JITs do not have frame pointers, then
> >       we would need to design a new kernel ABI that would allow JITs
> >       to express sframe-alike information. This will need to be designed
> >       with the input of JIT communities because some of them are likely
> >       not psABI compliant (e.g. lua has a separate stack).
> 
> Why a new interface? They can use the same prctl() as above. Here text,
> there sframe.

Our thinking was that a syscall defeats the point of "just in time".

> >   - When we have a good understanding of the JIT requirements in terms
> >     of frame description content, the other element that would need to
> >     be solved is how to allow JITs to emit frame data in a data structure
> >     that can expand. We may need something like a reserved memory area, with
> >     a counter of the number of elements which is used to synchronize communication
> >     between the JITs (producer) and kernel (consumer).
> 
> Again, huh?! Expand? Typical JIT has the normal epoch like approach to
> text generation, have N>1 text windows, JIT into one until full, once
> full, copy all still active crap into second window, induce grace period
> and wipe first window, rince-repeat.
> 
> Just have a sframe thing per window and expand the definition of 'full'
> to be either text of sframe window is full and everything should just
> work, no?

Yes, assuming the JIT doesn't mind doing a syscall.
 
> >   - We may have to create frame description areas which content are specific to given
> >     JITs. For instance, the frame descriptions for a lua JIT on x86-64 may not follow
> >     the x86-64 regular psABI.
> > 
> >   - As an initial stage, we can focus on handling the sframe section for executable
> >     and shared objects, and use frame pointers to skip over JITted code if available.
> >     The goal here is to show the usefulness of this kind of information so we get
> >     the interest/collaboration needed to get the relevant input from JIT communities
> >     as we design the proper ABI for handling JIT frames.
> 
> As per: https://realpython.com/python312-perf-profiler/
> 
> There is some 'demand' for all this, might be useful to contact some JIT
> authors and have them detail their needs or something.

If there's no sframe then we can just fall back to frame pointers like
ORC does.  And that article recommends enabling frame pointers for
python.

Between that and prctl(), it may be enough.

-- 
Josh
