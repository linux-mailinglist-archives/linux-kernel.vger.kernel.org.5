Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523447D4E78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjJXLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:01:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CEEFFE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:01:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 678A12F4;
        Tue, 24 Oct 2023 04:01:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211A33F64C;
        Tue, 24 Oct 2023 04:01:07 -0700 (PDT)
Date:   Tue, 24 Oct 2023 12:01:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rong Tao <rtoax@foxmail.com>, peterz@infradead.org
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rongtao@cestc.cn, tglx@linutronix.de
Subject: Re: [PATCH 2/2] stop_machine: Apply smp_store_release() to
 multi_stop_data::state
Message-ID: <ZTej8a0ieBAqjbfn@FVFF77S0Q05N>
References: <cover.1697811778.git.rongtao@cestc.cn>
 <tencent_3B1BE2B20183906E56D9E58C4AE4EBC62806@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3B1BE2B20183906E56D9E58C4AE4EBC62806@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:43:34PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Replace smp_wmb()+WRITE_ONCE() with smp_store_release() and add comment.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/stop_machine.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index 268c2e581698..cdf4a3fe0348 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -183,8 +183,10 @@ static void set_state(struct multi_stop_data *msdata,
>  {
>  	/* Reset ack counter. */
>  	atomic_set(&msdata->thread_ack, msdata->num_threads);
> -	smp_wmb();
> -	WRITE_ONCE(msdata->state, newstate);
> +	/* This smp_store_release() pair with READ_ONCE() in multi_cpu_stop().
> +	 * Avoid potential access multi_stop_data::state race behaviour.
> +	 */
> +	smp_store_release(&msdata->state, newstate);

This doesn't match coding style:

	/*
	 * Block comments should look like this, with a leading '/*' line
	 * before the text and a traling '*/' line afterwards.
	 */

See https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

I don't think the "Avoid potential access multi_stop_data::state race
behaviour." text is all that helpful, and I think we can drop that.

In general, it's unusual to pair a smp_store_release() with READ_ONCE(), and
for that to work it relies on dependency ordering and/or hazarding on the
reader side (e.g. the atomic_dec_and_test() is ordered after the READ_ONCE()
since it's an RMW and there's a control dependency, but a plain read could be
reordered w.r.t. the READ_ONCE()). So we probably need to explain that if we're
going to comment on that smp_store_release().

Peter, might it be worth replacing the READ_ONCE() with smp_load_acquire() at
the same time? I know it's not strictly necessary given the ordering we have
today, but it would at least be obvious.

Mark.

>  }
>  
>  /* Last one to ack a state moves to the next state. */
> -- 
> 2.41.0
> 
