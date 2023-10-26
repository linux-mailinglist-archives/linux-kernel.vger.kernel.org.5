Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA47D816B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjJZLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJZLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:00:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358C184
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zJtkwDH/EO6PTJhx4ROcJ4tNEyeY6XV4QTbw/B99qmI=; b=JOhDUsvdTe+0SDYkdf2x4xyyDA
        KhCUNWjYLn7kKtsRh8M18ChAWYRUrMBKFaDDOnM+CNIB1i8BP6upsNzk5N0zas6K9ElUAubueaL4J
        bMrKkpCquHPIL0mSzMaeB3wErDUJNAwvqnz7jQFK3aHPeDhCOEeXXLcCWAagSayx3UrASmpdz/HfE
        VLoqYDnHSNxMKsp+Xo335L/L9Qz9BRsffCRCB+83JEi8QnW/3/V3+YSqdrLm26yT6upDiBPd9V+Q/
        eCyoJLJ/c2d6LiJVzuVr6lFWPqIWYns/p31Wj8wYkXDNEgIA6Qfn4ITLEeXFpTfRBZCIzp2JVW2ei
        OmoNPRqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvy5Y-00HEw1-3A;
        Thu, 26 Oct 2023 10:59:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86A86300473; Thu, 26 Oct 2023 12:59:44 +0200 (CEST)
Date:   Thu, 26 Oct 2023 12:59:44 +0200
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
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [POC][RFC][PATCH v2] sched: Extended Scheduler Time Slice
Message-ID: <20231026105944.GJ33965@noisy.programming.kicks-ass.net>
References: <20231025235413.597287e1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025235413.597287e1@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:54:13PM -0400, Steven Rostedt wrote:

>  static void extend(void)
>  {
> 	rseq_map.cr_flags = 1;
>  }
> 
>  static void unextend(void)
>  {
> 	unsigned long prev;
> 
> 	prev = xchg(&rseq_map.cr_flags, 0);

So you complain about overhead and then you add one of the most
expensive ops possible here? xchg has an implicit LOCK prefix and you
really don't need LOCK prefix here.

> 	if (prev & 2) {
> 		tracefs_printf(NULL, "Yield!\n");
> 		sched_yield();
> 	}
>  }

