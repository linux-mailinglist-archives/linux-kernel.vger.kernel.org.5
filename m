Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF37FA89B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjK0SHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjK0SH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:07:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEBB1A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:07:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07642C433C9;
        Mon, 27 Nov 2023 18:07:32 +0000 (UTC)
Date:   Mon, 27 Nov 2023 13:07:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     tiozhang <tiozhang@didiglobal.com>
Cc:     <bigeasy@linutronix.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>
Subject: Re: [PATCH] sched/cputime: exclude ktimer threads in
 irqtime_account_irq
Message-ID: <20231127130754.3affb908@gandalf.local.home>
In-Reply-To: <20231124063450.GA18089@didi-ThinkCentre-M930t-N000>
References: <20231124063450.GA18089@didi-ThinkCentre-M930t-N000>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 14:34:50 +0800
tiozhang <tiozhang@didiglobal.com> wrote:

> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..0fac0109d151 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -73,7 +73,12 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
>  	 */
>  	if (pc & HARDIRQ_MASK)
>  		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> +#ifdef CONFIG_PREEMPT_RT
> +	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd()
> +		&& curr != this_cpu_ktimers())
> +#else
>  	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
> +#endif
>  		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>  }

If the above is necessary, it would look nicer as:

  	else if (((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd() &&
		  (!IS_ENABLED(CONFIG_PREEMPT_RT) || curr != this_cpu_ktimers()))

-- Steve

