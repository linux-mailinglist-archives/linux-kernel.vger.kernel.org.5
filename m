Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13647CC09D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjJQKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbjJQKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:24:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01FFD9F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:24:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 472E52F4;
        Tue, 17 Oct 2023 03:25:24 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2A7A3F762;
        Tue, 17 Oct 2023 03:24:42 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:24:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     elver@google.com, tglx@linutronix.de, peterz@infradead.org,
        Rong Tao <rongtao@cestc.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop_machine: Avoid potential race behaviour of
 multi_stop_data::state
Message-ID: <ZS5g6I-UtUnihToH@FVFF77S0Q05N>
References: <tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_705C16DF25978ACAEBD1E83E228881901006@qq.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:50:52PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> In commit b1fc58333575 ("stop_machine: Avoid potential race behaviour")
> fix both multi_cpu_stop() and set_state() access multi_stop_data::state,
> We should ensure that multi_stop_data::state is accessed using the rwonce
> method.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/stop_machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index cedb17ba158a..73de9ab77132 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -191,7 +191,7 @@ static void set_state(struct multi_stop_data *msdata,
>  static void ack_state(struct multi_stop_data *msdata)
>  {
>  	if (atomic_dec_and_test(&msdata->thread_ack))
> -		set_state(msdata, msdata->state + 1);
> +		set_state(msdata, READ_ONCE(msdata->state) + 1);

IIUC this is bening, as the state machine only ever has a single writer to
msdata->state (though which thread is the writer may change per iteration of
the loop).

At this point we know that the active thread *is* the writer, and so no other
threads can write to msdata->state, so there is no race and reading that
non-atomically is fine.

I'm not opposed to making this use READ_ONCE(), but I don't think that it's
strictly necessary to do so.

That said, if we really want to avoid the non-atomic read, it's probably better
to have multi_cpu_stop() pass curstate as a paramter to ack_state. That or fold
ack_state() into multi_cpu_stop() and use curstate directly.

Mark.

>  }
>  
>  notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
> -- 
> 2.42.0
> 
