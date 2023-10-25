Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5838B7D6E17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjJYN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbjJYN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:56:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF6194
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdPNIyANO+IrtJhwgqRTlWVT66WVymm6d1ZLZ8No5pU=; b=aC4u6wbbvkQWIu9A2bWwLTxi8K
        jDQLhhmdQd8BTiGEsdp/IAULoyEEnpDcrxV7HneAFou72KYGNKxBQ8Yc/XHDvyaKkNb6McWVn8Jxf
        AthweahAtCTx0fMgd35KJZJ51fkwxKyDOdPtyFycMlVFiQMzdjxkIHrK7+f9tciuPEZ4J4ICFmZR0
        Jxun1pR8dWgF49nfwTlLwG9ugsAKkVhmerleZxUPI7Rzl203d815oV9jpgRYEs+767PbFC/IIPLPC
        VUXA2XOdQHCWE9dxAZygi6xHLykhYleF5dsvN7PgadhTAhd8YTFMSJsW9J8unChgiQFc5VUXghTIW
        gAEm4lSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qveMM-0097TQ-5k; Wed, 25 Oct 2023 13:55:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE67B30047C; Wed, 25 Oct 2023 15:55:45 +0200 (CEST)
Date:   Wed, 25 Oct 2023 15:55:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [POC][RFC][PATCH] sched: Extended Scheduler Time Slice
Message-ID: <20231025135545.GG31201@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
 <20231025102952.GG37471@noisy.programming.kicks-ass.net>
 <20231025085434.35d5f9e0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025085434.35d5f9e0@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:54:34AM -0400, Steven Rostedt wrote:

> I didn't want to overload that for something completely different. This is
> not a "restartable sequence".

Your hack is arguably worse. At least rseq already exists and most
threads will already have it set up if you have a recent enough glibc.

> > So what if it doesn't ? Can we kill it for not playing nice ?
> 
> No, it's no different than a system call running for a long time. You could

Then why ask for it? What's the point. Also, did you define
sched_yield() semantics for OTHER to something useful? Because if you
didn't you just invoked UB :-) We could be setting your pets on fire.

> set this bit and leave it there for as long as you want, and it should not
> affect anything.

It would affect the worst case interference terms of the system at the
very least.

> If you look at what Thomas's PREEMPT_AUTO.patch

I know what it does, it also means your thing doesn't work the moment
you set things up to have the old full-preempt semantics back. It
doesn't work in the presence of RT/DL tasks, etc..

More importantly, it doesn't work for RT/DL tasks, so having the bit set
and not having OTHER policy is an error.

Do you want an interface that randomly doesn't work ?

> We could possibly make it adjustable. 

Tunables are not a good thing.

> The reason I've been told over the last few decades of why people implement
> 100% user space spin locks is because the overhead of going int the kernel
> is way too high.

Over the last few decades that has been a blatant falsehood. At some
point (right before the whole meltdown trainwreck) amluto had syscall
overhead down to less than 150 cycles.

Then of course meltdown happened and it all went to shit.

But even today (on good hardware or with mitigations=off):

gettid-1m:	179,650,423      cycles
xadd-1m:	 23,036,564      cycles

syscall is the cost of roughly 8 atomic ops. More expensive, sure. But
not insanely so. I've seen atomic ops go up to >1000 cycles if you
contend them hard enough.


