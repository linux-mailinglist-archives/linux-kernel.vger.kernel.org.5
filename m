Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015EB78CC50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjH2Smp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjH2SmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:42:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7719A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C8656250C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F2EC433C7;
        Tue, 29 Aug 2023 18:42:13 +0000 (UTC)
Date:   Tue, 29 Aug 2023 14:42:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang You <wangyoua@uniontech.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove preempt in do_sched_yield
Message-ID: <20230829144212.0eedc210@rorschach.local.home>
In-Reply-To: <20230823100705.5363-1-wangyoua@uniontech.com>
References: <20230823100705.5363-1-wangyoua@uniontech.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 18:07:05 +0800
Wang You <wangyoua@uniontech.com> wrote:

> I see do_sched_yield's irq disable cover preempt disable. In this
> function, I think preempt op may not work, or it may have some
> special effect ? Thanks.

Why would it not work?

> 
> Signed-off-by: Wang You <wangyoua@uniontech.com>
> ---
>  kernel/sched/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..b255e54c1d38 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8487,10 +8487,7 @@ static void do_sched_yield(void)
>  
>  	schedstat_inc(rq->yld_count);
>  	current->sched_class->yield_task(rq);
> -
> -	preempt_disable();
>  	rq_unlock_irq(rq, &rf);
> -	sched_preempt_enable_no_resched();

The point of this is if an interrupt triggers here and NEED_RESCHED is
set, then it will call schedule and possibly schedule out the task.
When it gets scheduled back in, the first thing it will do is to call
schedule again. The above code you deleted removes the spurious
schedule.

-- Steve


>  
>  	schedule();
>  }

