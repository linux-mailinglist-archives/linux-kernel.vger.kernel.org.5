Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C07D0D08
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376795AbjJTKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjJTKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:23:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06FDAB8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:23:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA32D2F4;
        Fri, 20 Oct 2023 03:24:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05373F5A1;
        Fri, 20 Oct 2023 03:23:44 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:23:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rongtao@cestc.cn, tglx@linutronix.de
Subject: Re: [PATCH v2] stop_machine: Avoid potential non-atomic read of
 multi_stop_data::state
Message-ID: <ZTJVKbJWqyx2e8Su@FVFF77S0Q05N>
References: <tencent_4CD220721A6C0B39670D5D52AAE4BD2A8F0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4CD220721A6C0B39670D5D52AAE4BD2A8F0A@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:11:23AM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> In commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
> fix both multi_cpu_stop() and set_state() access multi_stop_data::state,
> Pass curstate as a parameter to ack_state(), to avoid the non-atomic read.

Can we please describe this better? This is *not* a fix, it is a cleanup.

As I covered in:

  https://lore.kernel.org/lkml/ZS5g6I-UtUnihToH@FVFF77S0Q05N/

... there are no concurrent writers, and so the value of multi_stop_data::state
cannot change, and a non-atomic read is fine.

The actual change looks good to me as it makes it easier to see that there's no
race.

> And replace smp_wmb()+WRITE_ONCE() with smp_store_release().

This is also fine, but feels like a logically separate change.

Mark.

> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v1: stop_machine: Avoid potential race behaviour of multi_stop_data::state
>     https://lore.kernel.org/lkml/tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com/
> ---
>  kernel/stop_machine.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cedb17ba158a..35a122ce2cbd 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -183,15 +183,15 @@ static void set_state(struct multi_stop_data *msdata,
>  {
>  	/* Reset ack counter. */
>  	atomic_set(&msdata->thread_ack, msdata->num_threads);
> -	smp_wmb();
> -	WRITE_ONCE(msdata->state, newstate);
> +	smp_store_release(&msdata->state, newstate);
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
> @@ -242,7 +242,7 @@ static int multi_cpu_stop(void *data)
>  			default:
>  				break;
>  			}
> -			ack_state(msdata);
> +			ack_state(msdata, curstate);
>  		} else if (curstate > MULTI_STOP_PREPARE) {
>  			/*
>  			 * At this stage all other CPUs we depend on must spin
> -- 
> 2.42.0
> 
