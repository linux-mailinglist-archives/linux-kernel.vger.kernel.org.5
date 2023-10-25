Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4004E7D6884
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjJYKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJYKam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:30:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF319D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u3vNha6LjEv/b3c8jTWSa/Lwv001Wj+D+Q8nha9WSuA=; b=VNIrsB9urY0wekP8UTVIzVjsM2
        y6efNVLQ9NwjDhypEthpckjEZPMVeqyEtF/oBg/fgl0pUUWcSvrWLCItoC4101n7brRReLBaGXR2G
        a61iM8g4J4lzNbWfSVUKJSZiIt0ZetJIH7TCAUv7V19U7lTCyLBziKpv8qio6sSJo6jTy7fQiZZpQ
        HkZk161Xwc5jYkiD4IhUSJUN+Ao+Bre6qV0ZjA1TtBiDvtJc+utBIyb6NR+WpTRdiV4vCjUR4cjhE
        zrz0hsVLkrP2y2HedlSlehaycHSosozsQnR+mJeZL5zdcqg+/laDfzXosx8FOj/y0z/0RFfPXElEf
        H95OXypg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvb96-008CLV-W4; Wed, 25 Oct 2023 10:29:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A328730047C; Wed, 25 Oct 2023 12:29:52 +0200 (CEST)
Date:   Wed, 25 Oct 2023 12:29:52 +0200
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
Message-ID: <20231025102952.GG37471@noisy.programming.kicks-ass.net>
References: <20231025054219.1acaa3dd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025054219.1acaa3dd@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:42:19AM -0400, Steven Rostedt wrote:

> That is, there's this structure for every thread. It's assigned with:
> 
> 	fd = open("/sys/kernel/extend_sched", O_RDWR);
> 	extend_map = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> 
> I don't actually like this interface, as it wastes a full page for just two
> bits :-p  Perhaps it should be a new system call, where it just locks in
> existing memory from the user application? The requirement is that each
> thread needs its own bits to play with. It should not be shared with other
> threads. It could be, as it will not mess up the kernel, but will mess up
> the application.

What was wrong with using rseq?

> Anyway, to tell the kernel to "extend" the time slice if possible because
> it's in a critical section, we have:
> 
>  static void extend(void)
>  {
> 	if (!extend_map)
> 		return;
> 
> 	extend_map->flags = 1;
>  }
> 
> And to say that's it's done:
> 
>  static void unextend(void)
>  {
> 	unsigned long prev;
> 
> 	if (!extend_map)
> 		return;
> 
> 	prev = xchg(&extend_map->flags, 0);
> 	if (prev & 2)
> 		sched_yield();
>  }
> 
> So, bit 1 is for user space to tell the kernel "please extend me", and bit
> two is for the kernel to tell user space "OK, I extended you, but call
> sched_yield() when done".

So what if it doesn't ? Can we kill it for not playing nice ?

[ aside from it being bit 0 and bit 1 as you yourself point out, it is
  also jarring you use a numeral for one and write out the other. ]

That said, I properly hate all these things, extending a slice doesn't
reliably work and we're always left with people demanding an ever longer
extension.

The *much* better heuristic is what the kernel uses, don't spin if the
lock holder isn't running.
