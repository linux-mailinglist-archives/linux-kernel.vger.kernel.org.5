Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093F07D9E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjJ0Qo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0Qo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:44:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821B10A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:44:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9CAC433C8;
        Fri, 27 Oct 2023 16:44:21 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:44:19 -0400
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
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231027124419.4638d25d@gandalf.local.home>
In-Reply-To: <0b88d73c-c1c0-4ed8-9e63-b54698fbc039@efficios.com>
References: <20231025235413.597287e1@gandalf.local.home>
        <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
        <20231026071413.4ed47b0e@gandalf.local.home>
        <f5b0fffa-423a-4571-be6c-383399274328@efficios.com>
        <20231026152022.668ca0f3@gandalf.local.home>
        <20231026173527.2ad215cc@gandalf.local.home>
        <0b88d73c-c1c0-4ed8-9e63-b54698fbc039@efficios.com>
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

On Fri, 27 Oct 2023 12:21:45 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> > Attached is the updated test program.  
> 
> I think you'll want to modify the semantic of your "cr_flags" field so
> it supports nested locks as well. You can change this cr_flags for a
> nesting counter. The "yield" bit could be one of the bits of that
> counter (e.g. lowest bit).

Hmm, yeah, we could just have it be: bit 0 set by the kernel, and allow
user space set any bit above that to say "I'm in a critical section". Then,
the kernel would do:

	if (cr_flags & ~1) // in critical section

and this would allow user space to us cr_flags as the nested counter if it
wants to. I just don't want that to be a kernel requirement, but allowing
*any* bit to be set above bit 0 would allow user space to decide that or
not.

> 
> Therefore extend() become add 0x2, and unextend() become a sub 0x2, and
> you can check the lowest bit for yield hint.

Right, that makes sense. I'll update that in the next version.

Thanks!

-- Steve
