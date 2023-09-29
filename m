Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD78D7B3657
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjI2PHI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjI2PHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:07:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFB1F9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:07:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552A5C433C8;
        Fri, 29 Sep 2023 15:07:01 +0000 (UTC)
Date:   Fri, 29 Sep 2023 11:06:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] tracing: relax trace_event_eval_update() execution with
 schedule()
Message-ID: <20230929110657.7a4b38ef@rorschach.local.home>
In-Reply-To: <20230929141348.248761-1-cleger@rivosinc.com>
References: <20230929141348.248761-1-cleger@rivosinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 16:13:48 +0200
Clément Léger <cleger@rivosinc.com> wrote:

> When kernel is compiled without preemption, the eval_map_work_func()
> (which calls trace_event_eval_update()) will not be preempted up to its
> complete execution. This can actually cause a problem since if another
> CPU call stop_machine(), the call will have to wait for the
> eval_map_work_func() function to finish executing in the workqueue
> before being able to be scheduled. This problem was observe on a SMP
> system at boot time, when the CPU calling the initcalls executed
> clocksource_done_booting() which in the end calls stop_machine(). We
> observed a 1 second delay because one CPU was executing
> eval_map_work_func() and was not preempted by the stop_machine() task.
> 
> Adding a call to schedule() in trace_event_eval_update() allows to let
> other tasks to be executed and thus continue working asynchronously like
> before without blocking any pending task at boot time.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  kernel/trace/trace_events.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 91951d038ba4..dbdf57a081c0 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  				update_event_fields(call, map[i]);
>  			}
>  		}
> +		schedule();

The proper answer to this is "cond_resched()" but still, there's going
to be work to get rid of all that soon [1]. But I'll take a cond_resched()
now until that is implemented.

-- Steve

>  	}
>  	up_write(&trace_event_sem);
>  }

[1] https://lore.kernel.org/all/87cyyfxd4k.ffs@tglx/
