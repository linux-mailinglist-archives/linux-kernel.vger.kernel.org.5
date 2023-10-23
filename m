Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE73D7D3BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjJWQPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjJWQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:15:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7D10A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:15:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E1C433C8;
        Mon, 23 Oct 2023 16:15:48 +0000 (UTC)
Date:   Mon, 23 Oct 2023 12:15:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liangliang Li <liliangliang@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] freezer,sched: Report TASK_FROZEN tasks as
 TASK_UNINTERRUPTIBLE
Message-ID: <20231023121546.2d6acb62@gandalf.local.home>
In-Reply-To: <20231023135736.17891-1-liliangliang@vivo.com>
References: <20231023135736.17891-1-liliangliang@vivo.com>
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

On Mon, 23 Oct 2023 21:57:35 +0800
Liangliang Li <liliangliang@vivo.com> wrote:

> TASK_FROZEN is not in TASK_REPORT, thus a frozen task will appear as
> state == 0, IOW TASK_RUNNING.
> 
> Fix this by make TASK_FROZEN appear as TASK_UNINTERRUPTIBLE, thus we
> dont need to imply a new state to userspace tools.
> 

I'm not so sure I agree with this. If anything, it should be reported as
something other than RUNNING or TASK_UNINTERRUPTIBLE, (yes a new state).

The reason I state that, is that tasks may not be the one that sets its
state to FROZEN. A TASK_UNINTERRUPTIBLE is a task that purposely took
itself off the runqueue and is waiting for a response. A FROZEN task did
not necessarily take itself off the run queue, as something else did. It's
more like 'T' than 'D'.

I don't find 'D' any more useful that 'R' for a frozen task. In fact, I
find it even more deceiving.

If you see a task in 'D' that's not running, you will likely look to see
what its blocked on. If it's not blocked on anything, that will be very
confusing. If you see 'R' not running, you can then at least go look to see
why it's not running.

-- Steve


> Signed-off-by: Liangliang Li <liliangliang@vivo.com>
> ---
>  include/linux/sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 292c31697248..0cfe2ba4fc6f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1690,6 +1690,10 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>  	if (tsk_state & TASK_RTLOCK_WAIT)
>  		state = TASK_UNINTERRUPTIBLE;
>  
> +	/* Frozen tasks should appear as "D (disk sleep)' in userspace. */
> +	if (tsk_state & TASK_FROZEN)
> +		state = TASK_UNINTERRUPTIBLE;
> +
>  	return fls(state);
>  }
>  

