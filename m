Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3987D7061
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjJYPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJYPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D6128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:07:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E8CC433C7;
        Wed, 25 Oct 2023 15:07:12 +0000 (UTC)
Date:   Wed, 25 Oct 2023 11:07:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20231025110709.3e28861a@gandalf.local.home>
In-Reply-To: <48573a20-19d9-4400-a35e-86bf3dc043ad@efficios.com>
References: <20231025054219.1acaa3dd@gandalf.local.home>
        <20231025102952.GG37471@noisy.programming.kicks-ass.net>
        <20231025085434.35d5f9e0@gandalf.local.home>
        <20231025135545.GG31201@noisy.programming.kicks-ass.net>
        <20231025103105.5ec64b89@gandalf.local.home>
        <48573a20-19d9-4400-a35e-86bf3dc043ad@efficios.com>
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

On Wed, 25 Oct 2023 10:53:38 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I don't have an informed opinion on whether the proposed heuristic is a 
> good idea or not, but it should definitely be implemented as an 

If you want to get an informed opinion, you can start here:  ;-)

  Thomas's first reply that had me think about this solution:

    https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/

  My reply that started it:

    https://lore.kernel.org/lkml/20231024103426.4074d319@gandalf.local.home/

> extension to rseq as suggested by Peter. I've even made the whole rseq 
> ABI extensible to accommodate those additional use-cases.
> 
> In the initial rounds of rseq implementation, I even called rseq "kTLS" 
> because I expected it to be extended and eventually become an ABI that 
> contains various per-thread fields which are shared between kernel and 
> userspace.
> 
> So don't let the specific naming of the rseq system call stop you from 
> extending it for other purposes when per-thread shared memory between 
> kernel and userspace is needed. Setting up various per-thread areas like 
> this on thread creation is not free: it requires additional system calls 
> on thread creation. It really makes no sense to have more than one.

Thanks for the feedback Mathieu. This may indeed be the interface I am
looking for.

-- Steve
