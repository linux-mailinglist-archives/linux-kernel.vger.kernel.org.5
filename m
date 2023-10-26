Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12D87D7F02
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbjJZIzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjJZIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:54:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3D19D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZEBcz5oDJwulfgGWI6eBUOuuP2Vu4P0o4e5NZllAitM=; b=PwTKzgqvwdV9vqkNhbYrKz+zek
        Kon6ciA7lLWc3CH3oFeB3yz7K1FCn6sywGmYEw/yBrczmsPFg1BranwwmAr/W69KAcF5cdCQeoZPF
        NpNvU7gh9IyC359JYttetQBwZkEuIvfOwf33jiJogBpRKTVgbcKB/Hl6zy9nPlTWOiYBpScpWXhhX
        /pe8fHGSrwAT/i2ZNzXibH1JGhHivrNhyzcXsgolpORCmMUCrd5vAJHpgdpNx3DdG/c3ESzKBTtZ4
        UoM3/JDu4XuhdJWnf2m8HjIoLhyHb+j/u8MoEIm+lnF9CVaW/LP2juXic+rGYxDZsjMgT33DNFwLO
        V/q8AstA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvw86-00H9u7-2g;
        Thu, 26 Oct 2023 08:54:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7949D300473; Thu, 26 Oct 2023 10:54:14 +0200 (CEST)
Date:   Thu, 26 Oct 2023 10:54:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <20231026085414.GL31411@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
 <20231025135545.GG31201@noisy.programming.kicks-ass.net>
 <20231025103105.5ec64b89@gandalf.local.home>
 <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
 <20231025162435.ibhdktcshhzltr3r@f>
 <20231025131731.48461873@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025131731.48461873@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:17:31PM -0400, Steven Rostedt wrote:
> On Wed, 25 Oct 2023 18:24:35 +0200
> Mateusz Guzik <mjguzik@gmail.com> wrote:
> 
> > On Wed, Oct 25, 2023 at 11:42:34AM -0400, Mathieu Desnoyers wrote:
> > > On 2023-10-25 10:31, Steven Rostedt wrote:  
> > > > On Wed, 25 Oct 2023 15:55:45 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > > 
> > > [...]
> > > 
> > > After digging lore for context, here are some thoughts about the actual
> > > proposal: AFAIU the intent here is to boost the scheduling slice for a
> > > userspace thread running with a mutex held so it can complete faster,
> > > and therefore reduce contention.
> > > 
> > > I suspect this is not completely unrelated to priority inheritance
> > > futexes, except that one goal stated by Steven is to increase the
> > > owner slice without requiring to call a system call on the fast-path.
> 
> No, I wouldn't say it's the same as priority inheritance, which is to help
> with determinism and not performance. PI adds overhead but removes
> unbounded latency. On average, a non PI mutex is faster than PI mutex, but
> can suffer from unbounded priority inversion.

Matheusz is right though, what you're asking for is a (limited) priority
ceiling, which is a very primitive form of PI, which itself is a very
specific case of proxy execution :-)

Note that in kernel spinners have this priority ceiling by means of
preempt_disable().

> For this code, I took off my RT hat, and put on my performance hat.

Seems to me you took the brain along with the hat.

You're confusing cost of implementation with concept. Yes full blown PI
is fairly expensive, but the concept is still valid. Priority ceilings
were always an approximation.
