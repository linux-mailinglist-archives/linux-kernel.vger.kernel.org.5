Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384FA78C34D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjH2L2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjH2L2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC8129
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E55B864E8A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE525C433C7;
        Tue, 29 Aug 2023 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693308483;
        bh=lg9al/GWl6np4zxA2pWeGOQtEupGpuutzdMeqT8Rp+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGippfrc089VvEmwfGz7LpNlowU1nFtBI3/93nqPT4rXhxGEb8QN/5qllbltVC2pj
         dHUCuQtNQ6G44Q5EVS03GS12gbvBP7bmWAYoYCAF/9kfT3jZ3pGjeb6LXrXfDQjNoS
         PMkVGXpfGyD6GzMJ+N+0FFQI8GgP6kjhGr0vURjhEJni9wDrF+72W9UZeW2ogSt6W2
         32x4e8WiIxlEro64dKowVPCrGzHIibB7vkbia8eBL+wJJXk6C5vJocQ/lOG/V5e8zg
         W4n5I7QGILc6MZ5enUHoNHLUBSkzxCgEMDUTtGV+M6VHT5Jo727bJ7gzMfmdOr5o3T
         +S6MINjYZ/OFg==
Date:   Tue, 29 Aug 2023 13:28:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 00/10] timers/cpuidle: Fixes and cleanups
Message-ID: <ZO3WQJXTMw7CKhxO@lothringen>
References: <20230811170049.308866-1-frederic@kernel.org>
 <20230815161043.GL212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815161043.GL212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:10:43PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 11, 2023 at 07:00:39PM +0200, Frederic Weisbecker wrote:
> > Hi,
> > 
> > The first part of the series is cpuidle callback fixes against timers,
> > some of which haven't been Signed by Peter yet.
> > 
> > Another part is removing the overhead of useless TIF_NR_POLLING clearing.
> 
> So I've again forgotten why we don't simply set TIF_NEED_RESCHED if we
> need the timer re-programmed. That is by far the simplest fix.
> 
> I'm sure we talked about it, but this was a long time ago and I can't
> remember :/

I don't think we did but the rationale is that with forcing setting
TIF_NEED_RESCHED, you force a needless timer restart (which is then going
to be cancelled shortly after) and a round trip to the scheduler with the
rq lock overhead, etc...

Just for the fun I just tried the following change:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..ec43d135cf65 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1132,8 +1132,10 @@ static void wake_up_idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (cpu == smp_processor_id())
+	if (cpu == smp_processor_id()) {
+		set_tsk_need_resched(current);
 		return;
+	}
 
 	if (set_nr_and_not_polling(rq->idle))
 		smp_send_reschedule(cpu);


Then I computed the average of 100 runs of "make clean -C tools/perf; make -C
tools/perf/" before and after this patch.

I observed an average regression of 1.27% less time spent in C-states.

So this has a measurable impact.

> 
> Anyway, the patches look good, except I think there's a whole bunch of
> architectures that still need fixing. In particular since loongson
> 'borrowed' the whole lot from MIPS, they need an identical fix. But I'm
> sure there's more architectures affected.

MIPS at least yes, I only did a quick check and it seems that most archs
use a "wfi" like instruction. I'll check for others.

Thanks.
