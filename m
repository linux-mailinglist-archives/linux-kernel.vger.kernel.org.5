Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650667E7054
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbjKIRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344550AbjKIRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:31:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB61991
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:31:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8383FC433C9;
        Thu,  9 Nov 2023 17:31:43 +0000 (UTC)
Date:   Thu, 9 Nov 2023 12:31:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 07/86] Revert "livepatch,sched: Add livepatch task
 switching to cond_resched()"
Message-ID: <20231109123147.2bb11809@gandalf.local.home>
In-Reply-To: <20231109172637.ayue3jexgdxd53tu@treble>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-8-ankur.a.arora@oracle.com>
        <20231107181609.7e9e9dcc@gandalf.local.home>
        <20231109172637.ayue3jexgdxd53tu@treble>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2023 09:26:37 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Nov 07, 2023 at 06:16:09PM -0500, Steven Rostedt wrote:
> > On Tue,  7 Nov 2023 13:56:53 -0800
> > Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >   
> > > This reverts commit e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8.
> > > 
> > > Note that removing this commit reintroduces "live patches failing to
> > > complete within a reasonable amount of time due to CPU-bound kthreads."
> > > 
> > > Unfortunately this fix depends quite critically on PREEMPT_DYNAMIC and
> > > existence of cond_resched() so this will need an alternate fix.  
> 
> We definitely don't want to introduce a regression, something will need
> to be figured out before removing cond_resched().
> 
> We could hook into preempt_schedule_irq(), but that wouldn't work for
> non-ORC.
> 
> Another option would be to hook into schedule().  Then livepatch could
> set TIF_NEED_RESCHED on remaining unpatched tasks.  But again if they go
> through the preemption path then we have the same problem for non-ORC.
> 
> Worst case we'll need to sprinkle cond_livepatch() everywhere :-/
> 

I guess I'm not fully understanding what the cond rescheds are for. But
would an IPI to all CPUs setting NEED_RESCHED, fix it?

-- Steve
