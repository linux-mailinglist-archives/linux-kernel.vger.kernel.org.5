Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D127D819B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbjJZLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJZLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:14:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9F01AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:14:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438C6C433C7;
        Thu, 26 Oct 2023 11:14:16 +0000 (UTC)
Date:   Thu, 26 Oct 2023 07:14:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231026071413.4ed47b0e@gandalf.local.home>
In-Reply-To: <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
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

On Thu, 26 Oct 2023 12:59:44 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Oct 25, 2023 at 11:54:13PM -0400, Steven Rostedt wrote:
> 
> >  static void extend(void)
> >  {
> > 	rseq_map.cr_flags = 1;
> >  }
> > 
> >  static void unextend(void)
> >  {
> > 	unsigned long prev;
> > 
> > 	prev = xchg(&rseq_map.cr_flags, 0);  
> 
> So you complain about overhead and then you add one of the most
> expensive ops possible here? xchg has an implicit LOCK prefix and you
> really don't need LOCK prefix here.

Peter, this is the user space side, where I cut and pasted the code from
the file I attached.

That has:

static inline unsigned long
xchg(volatile unsigned *ptr, unsigned new)
{
        unsigned ret = new;

	asm volatile("xchg %b0,%1"
		     : "+r"(ret), "+m"(*(ptr))
		     : : "memory");
        return ret;
}

-- Steve


> 
> > 	if (prev & 2) {
> > 		tracefs_printf(NULL, "Yield!\n");
> > 		sched_yield();
> > 	}
> >  }  

