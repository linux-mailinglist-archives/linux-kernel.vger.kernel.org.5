Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B87D83BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbjJZNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjJZNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:40:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62F1B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:40:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5FFC433C7;
        Thu, 26 Oct 2023 13:40:38 +0000 (UTC)
Date:   Thu, 26 Oct 2023 09:40:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20231026094035.213e3744@gandalf.local.home>
In-Reply-To: <20231026085414.GL31411@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <884e4603-4d29-41ae-8715-a070c43482c4@efficios.com>
        <20231025162435.ibhdktcshhzltr3r@f>
        <20231025131731.48461873@gandalf.local.home>
        <20231026085414.GL31411@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 10:54:14 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > No, I wouldn't say it's the same as priority inheritance, which is to help
> > with determinism and not performance. PI adds overhead but removes
> > unbounded latency. On average, a non PI mutex is faster than PI mutex, but
> > can suffer from unbounded priority inversion.  
> 
> Matheusz is right though, what you're asking for is a (limited) priority
> ceiling, which is a very primitive form of PI, which itself is a very
> specific case of proxy execution :-)
> 
> Note that in kernel spinners have this priority ceiling by means of
> preempt_disable().
> 
> > For this code, I took off my RT hat, and put on my performance hat.  
> 
> Seems to me you took the brain along with the hat.
> 
> You're confusing cost of implementation with concept. Yes full blown PI
> is fairly expensive, but the concept is still valid. Priority ceilings
> were always an approximation.

It's a very weak priority ceiling, and why I didn't associate it, as I
would with preempt_disable() in the kernel (and I have mentioned in several
of my talks that preempt_disable() is a PI, as it makes the running task
the highest priority task on the CPU).

The major difference is that this is time sensitive. That is, the kernel
gives it an arbitrary amount of time to finish up. Priority ceiling is
usually associated to an entire critical section. Not the start of it and
if you don't finish it in time we take away that ceiling.

Even proxy execution doesn't work that way.

Hence, why I don't want to associate this with priority inheritance. The
time constraint is a fundamental difference.

-- Steve
