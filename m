Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE857CB091
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJPQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjJPQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:55:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85E5D4D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DmMKf0qGpeoZW2z/Wnq5RJEB0AlgVOQb1rbg9/aBfVM=; b=kuAgrKq7bwQcAbs+Uw+396Ori0
        EUxIHPNScDgpUZnELdzTAPVMZVcaTqq5IRbR7cTv0oHMtfPtJfvzzib6Sz94H7JK8wRcCFY3Fump4
        Yyle/I9m2nQIYIlBERTNJI0QFP4CAeMltkCxIW55O2h5bu+0ul73qZzCEbYQQ8q1xnF/wBmsp2Q4C
        ZX6sTQOp1wDcn4xC5Sv5qsHhqwqKwOD7skX3zpEDxjKcTCkv7S7soFXQOvDncz5zLpsngcMnAuY1/
        8YUl6mShOZa48gq7tAgfBeJ6mbTnh04hYKGlkdqTDcSrrX7A9RQKzYHs2BPWTLsSNGIjCZRE7TQ4S
        Mm3CIoHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsQnK-006AUE-1R;
        Mon, 16 Oct 2023 16:50:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A7B2300513; Mon, 16 Oct 2023 18:50:19 +0200 (CEST)
Date:   Mon, 16 Oct 2023 18:50:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20231016165019.GG33217@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
 <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net>
 <20231005120557.GA743@noisy.programming.kicks-ass.net>
 <20231007220400.GA5581@noisy.programming.kicks-ass.net>
 <CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+q576Mov1jpdfZhPBoy_hiVh3xSWuJjXdP3nS4zfpqfOXtq7Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I seem to have forgotten to reply to this part...

On Mon, Oct 09, 2023 at 07:51:03PM -0500, Youssef Esmat wrote:

> I think looking at the sched latency numbers alone does not show the
> complete picture. I ran the same input latency test again and tried to
> capture some of these numbers for the chrome processes.
> 
> EEVDF 1.5ms slice:
> 
> Input latency test result: 226ms
> perf sched latency:
> switches: 1,084,694
> avg:   1.139 ms
> max: 408.397 ms
> 
> EEVDF 6.0ms slice:
> 
> Input latency test result: 178ms
> perf sched latency:
> switches: 892,306
> avg:   1.145 ms
> max: 354.344 ms

> For our scenario, it is very expensive to interrupt UI threads. It
> will increase the input latency significantly. Lowering the scheduling
> latency at the cost of switching out important threads can be very
> detrimental in this workload. UI and input threads run with a nice
> value of -8.

> That said, this might not be beneficial for all workloads, and we are
> still trying our other workloads out.

Right, this seems to suggest something on your critical path (you should
trace that) has more than 3ms of compute in a single activation. 

Basically this means chrome is fairly fat on this critical path. But it
seems you know about that.

Anyway, once you know the 95% length of the longest activation on your
critical path, you can indeed set your slice to that. This should be
readily available from trace data.

