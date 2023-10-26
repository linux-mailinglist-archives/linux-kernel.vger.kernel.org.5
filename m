Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC67D8904
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjJZTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjJZTgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:36:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EA1BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:36:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBAFC433CA;
        Thu, 26 Oct 2023 19:36:43 +0000 (UTC)
Date:   Thu, 26 Oct 2023 15:36:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org,
        x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com,
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
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231026153642.06bb418b@gandalf.local.home>
In-Reply-To: <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
        <CAHk-=whnyt2TccpDaWGTbDsVkKApL3c2FtDPMEwuTmeu_cEL8Q@mail.gmail.com>
        <7871472b-a0c4-4475-9671-69a3244f956d@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 14:59:13 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Steven, check out
> > 
> >      arch/x86/include/asm/percpu.h
> > 
> > for a rough implementation of a 'xchg()' without SMP coherency, just
> > cpu-local one (ie atomic wrt being preempted by the kernel, but not
> > atomic wrt other CPU's accessing the same variable concurrently)  
> 
> Actually Steven does not need a xchg to test-and-set a single bit which
> is only accessed concurrently between kernel and userspace from the same
> thread. Either "bts" or "andb" should work fine.

Thanks Linus and Mathieu!

Yeah, I just changed it to andb and that works just as well (or better).

When I first made the change, it became substantially worse. But then I
realized it was because I had "addb" and not "andb" :-D

-- Steve
