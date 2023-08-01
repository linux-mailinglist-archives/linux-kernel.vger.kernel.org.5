Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7776B944
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjHAQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHAQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36090
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B44716160D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8BFC433C7;
        Tue,  1 Aug 2023 16:00:57 +0000 (UTC)
Date:   Tue, 1 Aug 2023 12:00:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Don't try push tasks if there are none.
Message-ID: <20230801120056.43d4a30b@gandalf.local.home>
In-Reply-To: <20230801152648._y603AS_@linutronix.de>
References: <20230801152648._y603AS_@linutronix.de>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 17:26:48 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 00e0e50741153..338cd150973ff 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2247,8 +2247,11 @@ static int rto_next_cpu(struct root_domain *rd)
>  
>  		rd->rto_cpu = cpu;
>  
> -		if (cpu < nr_cpu_ids)
> +		if (cpu < nr_cpu_ids) {
> +			if (!has_pushable_tasks(cpu_rq(cpu)))
> +				continue;

Hmm, I had to read this again to make sure we can't get into an infinite
loop. But it looks like we are safe, as if none of the CPUs had pushable
tasks, we would still hit the cpu == nr_cpu_ids case and fall into the loop
check, and break out there.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


>  			return cpu;
> +		}
>  
>  		rd->rto_cpu = -1;
>  

