Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7C7D71AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjJYQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJYQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:24:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA82184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:24:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-508126afb9bso1970525e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698251086; x=1698855886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb8J3cN3R9uMzhlYCtBR7uNblIZcRq+8mJPIykg4/p8=;
        b=cntuCB4PU9XXChojZjt+iWEw1sfHod7+cl8r9Hw2e4XD44j/xMM52JfugmZdblzagP
         mQx6GzPZwBfqaYFtEVzAViPe1ejVx4isvjslz+TwIwkKpn0tGYJdMEg/bFEbxA2lBni9
         DUx/688i/YMFRscDn5ELvdVfDcE+LqjkANS43tOuuS++uZ2R+aYY7yowppYV3Ty5jJ0h
         Dvt6KRv09NovNJU1FlWh5UVf51vPxn9ezgggzQ74XTl9XgQ3ojHxMrOrQhK7A0J2SHar
         UmCudcmJClJfjUrvC8DmjI/7MqtXlxaXgbI/6rfut+ZTpcEmqVQ5pLLRMJwlc58s1wZx
         HhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698251086; x=1698855886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb8J3cN3R9uMzhlYCtBR7uNblIZcRq+8mJPIykg4/p8=;
        b=CgvqWvLXTusvwhcgOBsk0gilEw8JL4Y+Cd5POUtac+/AM5PVOnDWZo0/cKZdHGns5R
         mrOmATdsB8TV1XobctasWHwv6eXRQnaenr6JB4a8JT177FdcS4gN0ydDX27wmR986IU5
         ASJBdlsdcehUX2srOQh9B5g66hxCrYWh1nkiFTaUUz5qyvZNj0HeLeMGtv64jKVBlWiT
         yiPhFawHiVm+QdEXI50cnyt/RoPEO1HWwYo71k0fB6v5bVJIiAXa2I09fLazAcVW3vws
         QBgxp+bCOm3Fu22tPNyw8+CDuYksNfQmXgFxg+uLzmkB9sC6x9mDolNqYlHU6eOA9RBL
         eVfw==
X-Gm-Message-State: AOJu0Yz8A4h0idLJzUaxljmd5ebqPvMfpCw9yw0lGAMr/eLM+qT0iDpZ
        HSGUyLqcN6flZxUsHUutEys=
X-Google-Smtp-Source: AGHT+IH5lNOS/o2uNQlCPNMPFz89yBKto7oBJr9IMpNBYe7HXN1XpkH4fXYpXrvNzTkqg04R1tegzg==
X-Received: by 2002:a19:7605:0:b0:507:a8cd:6c90 with SMTP id c5-20020a197605000000b00507a8cd6c90mr11665107lff.51.1698251086351;
        Wed, 25 Oct 2023 09:24:46 -0700 (PDT)
Received: from f (cst-prg-84-142.cust.vodafone.cz. [46.135.84.142])
        by smtp.gmail.com with ESMTPSA id dl11-20020a0560000b8b00b0032da4f70756sm12382332wrb.5.2023.10.25.09.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 09:24:45 -0700 (PDT)
Date:   Wed, 25 Oct 2023 18:24:35 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231025162435.ibhdktcshhzltr3r@f>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
 <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:42:34AM -0400, Mathieu Desnoyers wrote:
> On 2023-10-25 10:31, Steven Rostedt wrote:
> > On Wed, 25 Oct 2023 15:55:45 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> [...]
> 
> After digging lore for context, here are some thoughts about the actual
> proposal: AFAIU the intent here is to boost the scheduling slice for a
> userspace thread running with a mutex held so it can complete faster,
> and therefore reduce contention.
> 
> I suspect this is not completely unrelated to priority inheritance
> futexes, except that one goal stated by Steven is to increase the
> owner slice without requiring to call a system call on the fast-path.
> 
> Compared to PI futexes, I think Steven's proposal misses the part
> where a thread waiting on a futex boosts the lock owner's priority
> so it can complete faster. By making the lock owner selfishly claim
> that it needs a larger scheduling slice, it opens the door to
> scheduler disruption, and it's hard to come up with upper-bounds
> that work for all cases.
> 
> Hopefully I'm not oversimplifying if I state that we have mainly two
> actors to consider:
> 
> [A] the lock owner thread
> 
> [B] threads that block trying to acquire the lock
> 
> The fast-path here is [A]. [B] can go through a system call, I don't
> think it matters at all.
> 
> So perhaps we can extend the rseq per-thread area with a field that
> implements a "held locks" list that allows [A] to let the kernel know
> that it is currently holding a set of locks (those can be chained when
> locks are nested). It would be updated on lock/unlock with just a few
> stores in userspace.
> 
> Those lock addresses could then be used as keys for private locks,
> or transformed into inode/offset keys for shared-memory locks. Threads
> [B] blocking trying to acquire the lock can call a system call which
> would boost the lock owner's slice and/or priority for a given lock key.
> 
> When the scheduler preempts [A], it would check whether the rseq
> per-thread area has a "held locks" field set and use this information
> to find the slice/priority boost which are currently active for each
> lock, and use this information to boost the task slice/priority
> accordingly.
> 
> A scheme like this should allow lock priority inheritance without
> requiring system calls on the userspace lock/unlock fast path.
> 

I think both this proposal and the original in this thread are opening a
can of worms and I don't think going down that road was properly
justified. A proper justification would demonstrate a big enough(tm)
improvement over a locking primitive with adaptive spinning.

It is well known that what mostly shafts performance of regular
userspace locking is all the nasty going off cpu to wait.

The original benchmark with slice extension disabled keeps using CPUs,
virtually guaranteeing these threads will keep getting preempted, some
of the time while holding the lock. Should that happen all other threads
which happened to get preempted actively waste time.

Adaptive spinning was already mentioned elsewhere in the thread and the
idea itself is at least 2 decades old. If anything I find it strange it
did not land years ago.

I find there is a preliminary patch by you which exports the state so
one can nicely spin without even going to the kernel:
https://lore.kernel.org/lkml/20230529191416.53955-1-mathieu.desnoyers@efficios.com/

To be clear, I think a locking primitive which can do adaptive spinning
*and* futexes *and* not get preempted while holding locks is the fastest
option. What is not clear to me if it is sufficiently faster than
adaptive spinning and futexes.

tl;dr perhaps someone(tm) could carry the above to a state where it can
be benchmarked vs the original patch
