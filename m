Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242AC7EC797
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjKOPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:49:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B96AD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NSxlWyJ/QR88QjvU607qQ9AMoaeC041mVLyy9ZjImTA=; b=a+o9XdEotKZ8XxpT3bXlWK1MWY
        l2wc3DruYdaa/3gxPbbBwuNTQ7OVpDFbhKDfDegF+oVrV1NkjFHr2aLWxlOx9/sFHCwnTWT5Hyjka
        sKXQyg5xOJhkmC3cwb1GFWs5bge26jEUkoWYvlOs3Uj8zPrK2z2iwOEBwT4TjyG4ofZFolJwdQ/Tt
        VTmxczR958wjSS74LU+EbEQn8DghwBUNeycLcBYu6fK2ClIB91dr3+Fqverg7cpeZdko+2skHKf4X
        MAYUT/khEJ5J6ysbkV0gIDFr8yq4/l2fJPxYkFOWvzSYsFz8NJXlvSKhGo/8b53UhggkQBgL6uS9A
        tM1zInYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3I8f-0047oA-0C;
        Wed, 15 Nov 2023 15:49:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B13F2300427; Wed, 15 Nov 2023 16:49:12 +0100 (CET)
Date:   Wed, 15 Nov 2023 16:49:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
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
Message-ID: <20231115154912.GC8262@noisy.programming.kicks-ass.net>
References: <a79d1bc3-1aca-4169-a963-b7c9279aa7fd@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79d1bc3-1aca-4169-a963-b7c9279aa7fd@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:09:16AM -0500, Mathieu Desnoyers wrote:
> Hi,
> 
> [ With lkml and diamon-discuss in CC ]
> 
> I'm adding the following notes of the hallway track discussion we had
> immediately after the sframe slot within the tracing MC [1]. I suspect it
> is relevant (please correct me if I'm wrong or if there are conclusions
> that are too early to tell):
> 
> - Handling of shared libraries:
>   - the libc dynamic loader should register/unregister sframe sections
>     explicitly with new prctl(2) options,
>   - The prctl() for registration of the sframe sections can take the
>     section address and size as arguments,
>   - The prctl for unregistration could take the section address as argument,
>     but this would require additional data in the linker map (within libc),
>     which is unwanted.
>   - One alternative would be to provide an additional information to
>     sframe registration/unregistration: a key which is decided by the libc
>     to match registration/unregistration. That key could be either the
>     address of the text section associated with the sframe section, or it
>     could be the address of the linker map entry (at the choice of userspace).
>   - Overall, the prctl(3) sframe register could have the following parameters:
>     { key, sframe address, sframe section length }
>   - The prctl(3) sframe unregister would then take a { key } as parameter.
> 
> - The kernel backtrace code using the sframe information should consider
>   it hostile:
>   - can be corrupted by the application (by accident or maliciously),
>   - can be corrupted on disk by modification of the ELF binary, either
>     before registration or after (either by accident or maliciously),
>   - can be malformed to contain loops (need to find a way to have upper
>     bounds, sanity checks about the direction of the stack traversal),
> 
> - It was discussed that the kernel could possibly validate checksums on
>   registration and write-protect the sframe pages. Considering that the
>   kernel still needs to consider the content hostile even with those
>   mechanisms in place, it is unclear whether they are relevant.
> 
> - Mark Rutland told me that for aarch64 the current sframe content is
>   not sufficient to express how to walk the stack over code area at
>   the beginning of functions before the stack pointer is updated.
>   He plans to discuss this with Indu as a follow up.
> 
> - Interpreters:
> 
>   - Walking over an interpreter's own stack can be as simple as skipping
>     over the interpreter's runtime functions. This is a first step to
>     allow skipping over interpreters without detailed information about
>     their own stack layout.

Profiling interpreters is typically done using SIGnals. Perf is capable
of generating signals on overflow. This is slow, but so is an
interpreter. SIGhandler is part of the interpreter and can interpret
the interpreter state and do whatever it damn well pleases.

A stack-machine based interpreter will not have anything but the main
loop on the actual function call stack. Unwinding it using the 'C'
unwinder will yield nothing useful.

> - JITs:
> 
>   - There are two approaches to skip over JITted code stacks:
> 
>     - If the jitted code has frame pointers, then use this.
> 
>     - If we figure out that some JITs do not have frame pointers, then
>       we would need to design a new kernel ABI that would allow JITs
>       to express sframe-alike information. This will need to be designed
>       with the input of JIT communities because some of them are likely
>       not psABI compliant (e.g. lua has a separate stack).

Why a new interface? They can use the same prctl() as above. Here text,
there sframe.

>   - When we have a good understanding of the JIT requirements in terms
>     of frame description content, the other element that would need to
>     be solved is how to allow JITs to emit frame data in a data structure
>     that can expand. We may need something like a reserved memory area, with
>     a counter of the number of elements which is used to synchronize communication
>     between the JITs (producer) and kernel (consumer).

Again, huh?! Expand? Typical JIT has the normal epoch like approach to
text generation, have N>1 text windows, JIT into one until full, once
full, copy all still active crap into second window, induce grace period
and wipe first window, rince-repeat.

Just have a sframe thing per window and expand the definition of 'full'
to be either text of sframe window is full and everything should just
work, no?

> 
>   - We would need to figure out if JITs expect to have a single producer per
>     frame description area, or multiple producers.

I've not really kept up and only ever seen single threaded JITs, but I
would imagine they each get their own window.

>   - We would need to figure out if JITs expect to append frame descriptions in
>     sorted function address order (append only for frame description, append only
>     for functions text section as well), or if there needs to be support for unsorted
>     function entries.

So from what I know they typically so the sorted thing, easier for their
own accounting too.

Note that there is this JAVA JIT text symbol userspace API thing that
tracks symbols. Perf-tool implements that IIRC. Writes it out to a file
which is then read and munged back into the report or so. IIRC this also
includes information on reclaim.

>   - We would need information about how JITs reclaim functions, and how it impacts
>     the frame description ABI. For instance, we may want to have a tombstone bit to
>     state that a frame was deleted.

prctl() unregister + register ? I mean, JIT would need to be fully
co-operative anyway.

>   - We may have to create frame description areas which content are specific to given
>     JITs. For instance, the frame descriptions for a lua JIT on x86-64 may not follow
>     the x86-64 regular psABI.
> 
>   - As an initial stage, we can focus on handling the sframe section for executable
>     and shared objects, and use frame pointers to skip over JITted code if available.
>     The goal here is to show the usefulness of this kind of information so we get
>     the interest/collaboration needed to get the relevant input from JIT communities
>     as we design the proper ABI for handling JIT frames.

As per: https://realpython.com/python312-perf-profiler/

There is some 'demand' for all this, might be useful to contact some JIT
authors and have them detail their needs or something.
