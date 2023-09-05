Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D20792AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjIEQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354406AbjIEL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:26:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1161AB;
        Tue,  5 Sep 2023 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y+veJ7G7et4MOABC7+k7SGK7GisnFBtylzQKqH+19ng=; b=MrNi3pOkVFgnn/z5pOgCNWpywV
        VpUxARmJRIjDo/euZP3xmX1QXJD6ob4gOgMIeBnYSOtZDhDJqCW4YE/61HkyZGv64pBYUBMyG1LgY
        i8o1ZBRbQksOwFUtVH2TrFUXrKT+F6xk7qUkJ/rVKDtAuD8GGRvMWANRLl5Rv6ODkvJEJkBeL2Ke5
        T9BQVcS3Gaqvxs+KxJrr3iMOUj3dGjVNO5h/BTuLQ/o6TwHhyu3cOYUuv//LmtX6eD9xImbExHWz2
        4ROYy6TytD6UDOecWBIt/kF2EaeSLBNRVWDinNaK5j6W2vKsqR3cmNZSxDy0nAmhEj+ddoCAxA+jB
        4MVWVmoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdUBd-0097Ut-HR; Tue, 05 Sep 2023 11:25:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34A4F300687; Tue,  5 Sep 2023 13:25:37 +0200 (CEST)
Date:   Tue, 5 Sep 2023 13:25:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH 1/4] sched: consolidate and cleanup access to CPU's max
 compute capacity
Message-ID: <20230905112537.GE28319@noisy.programming.kicks-ass.net>
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901130312.247719-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 03:03:09PM +0200, Vincent Guittot wrote:
> Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
> instead.
> 
> Scheduler uses 3 methods to get access to the CPU's max compute capacity:
> - arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
> - cpu_capacity_orig field which is periodically updated with
>   arch_scale_cpu_capacity().
> - capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig
> 
> There is no real need to save the value returned by arch_scale_cpu_capacity()
> in struct rq. arch_scale_cpu_capacity() returns:
> - either a per_cpu variable.
> - or a const value for systems which have only one capacity.
> 
> Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.
> 
> No functional changes.

I think the original thinking was that we wouldn't know how expensive
the function call would end up being, but yeah, given how things stand
this is a nice cleanup.
