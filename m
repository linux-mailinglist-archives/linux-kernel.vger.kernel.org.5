Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E077B43A5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjI3UlL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Sep 2023 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3UlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:41:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9DC4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:41:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF733C433C7;
        Sat, 30 Sep 2023 20:41:06 +0000 (UTC)
Date:   Sat, 30 Sep 2023 16:41:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [for-linus][PATCH 2/4] tracing: relax trace_event_eval_update()
 execution with cond_resched()
Message-ID: <20230930164105.534e7400@rorschach.local.home>
In-Reply-To: <20230930203821.632661639@goodmis.org>
References: <20230930203213.826737400@goodmis.org>
        <20230930203821.632661639@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ The problem with sending email with quilt. It doesn't handle UTF-8 well :-/ ]

On Sat, 30 Sep 2023 16:32:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
> 
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
> Adding a call to cond_resched() in trace_event_eval_update() allows
> other tasks to be executed and thus continue working asynchronously
> like before without blocking any pending task at boot time.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230929191637.416931-1-cleger@rivosinc.com
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Tested-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 91951d038ba4..f49d6ddb6342 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  				update_event_fields(call, map[i]);
>  			}
>  		}
> +		cond_resched();
>  	}
>  	up_write(&trace_event_sem);
>  }

