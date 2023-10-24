Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE7D7D4E35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjJXKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjJXKqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:46:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DD8D7E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:46:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95A592F4;
        Tue, 24 Oct 2023 03:47:17 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71C7E3F64C;
        Tue, 24 Oct 2023 03:46:35 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:46:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rongtao@cestc.cn, tglx@linutronix.de
Subject: Re: [PATCH 1/2] stop_machine: Use non-atomic read
 multi_stop_data::state clearly
Message-ID: <ZTegiFbGQUAp1l0p@FVFF77S0Q05N>
References: <cover.1697811778.git.rongtao@cestc.cn>
 <tencent_49AFDBA31F885906234219591097D42ABE08@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_49AFDBA31F885906234219591097D42ABE08@qq.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:43:33PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
> solved the race behaviour problem, to better show that race behaviour
> does not exist, pass the 'curstate' directly to ack_state() instead of
> refetching msdata->state in ack_state().
> 

I'd prefer if we make this:

| stop_machine: pass curstate to ack_state()
| 
| The multi_cpu_stop() state machine uses multi_stop_data::state to hold
| the current state, and this is read and written atomically except in
| ack_state(), which performs a non-atomic read.
| 
| As ack_state() only performs this non-atomic read when there is a single
| writer, this is benign, but it makes reasoning about the state machine a
| little harder.
| 
| Remove the non-atomic read and pass the (atomically read) curstate in
| instead. This makes it clear that we do not expect any racy writes, and
| avoids a redundant load.

With that wording:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/stop_machine.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cedb17ba158a..268c2e581698 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data *msdata,
>  }
>  
>  /* Last one to ack a state moves to the next state. */
> -static void ack_state(struct multi_stop_data *msdata)
> +static void ack_state(struct multi_stop_data *msdata,
> +		      enum multi_stop_state curstate)
>  {
>  	if (atomic_dec_and_test(&msdata->thread_ack))
> -		set_state(msdata, msdata->state + 1);
> +		set_state(msdata, curstate + 1);
>  }
>  
>  notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
> @@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
>  			default:
>  				break;
>  			}
> -			ack_state(msdata);
> +			ack_state(msdata, curstate);
>  		} else if (curstate > MULTI_STOP_PREPARE) {
>  			/*
>  			 * At this stage all other CPUs we depend on must spin
> -- 
> 2.41.0
> 
