Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C764B80F6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377147AbjLLTj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjLLTjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:39:24 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EECCE;
        Tue, 12 Dec 2023 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702409969;
        bh=NcnbNTopFnVXj6ayAjrFagAgkOJOw+5lSqAYTa5IGNM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hNGpYvN44nzEB5dOOxATG/fKvpkH7T4beuh0KCrhCVxLX02ZQZhAsY7s/FWvk27ZY
         1gVcXIBNC5usisuxr3bgKQFD2BQ7GWBMgbqNaykbKxdf5FtfGbVDtxFdCoAnoZsdHc
         tNoLL3o3phK8B2Zb1V/TAboyvDmu4n5Z+D3mSTG4RJ+cItZDZmKJfw3S5/fOqFHiQu
         S2F8rpHQiL99JEU8EifaSoxZQIx+rF0BNhqr5ZwuVLCM6Ts3B3STc18hw82QzZY/Km
         HQkNoqXKtYi2IxLf88/tLLqpLjEnjAB0c9L0jGuqBFg+aBuM5uzjJjjyHoUDNg22Ol
         7rdpVxk/xWf/w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SqTTF3S4wzGKL;
        Tue, 12 Dec 2023 14:39:29 -0500 (EST)
Message-ID: <572ab085-ce40-4110-9296-99b136582eba@efficios.com>
Date:   Tue, 12 Dec 2023 14:39:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit
 archs
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231212115301.7a9c9a64@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231212115301.7a9c9a64@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-12 11:53, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Mathieu Desnoyers pointed out an issue in the rb_time_cmpxchg() for 32 bit
> architectures. That is:
> 
>   static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>   {
> 	unsigned long cnt, top, bottom, msb;
> 	unsigned long cnt2, top2, bottom2, msb2;
> 	u64 val;
> 
> 	/* The cmpxchg always fails if it interrupted an update */
> 	 if (!__rb_time_read(t, &val, &cnt2))
> 		 return false;
> 
> 	 if (val != expect)
> 		 return false;
> 
> <<<< interrupted here!
> 
> 	 cnt = local_read(&t->cnt);
> 
> The problem is that the synchronization counter in the rb_time_t is read
> *after* the value of the timestamp is read. That means if an interrupt
> were to come in between the value being read and the counter being read,
> it can change the value and the counter and the interrupted process would
> be clueless about it!
> 
> The counter needs to be read first and then the value. That way it is easy
> to tell if the value is stale or not. If the counter hasn't been updated,
> then the value is still good.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20231211201324.652870-1-mathieu.desnoyers@efficios.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 10464b4aa605e ("ring-buffer: Add rb_time_t 64 bit operations for speeding up 32 bit")
> Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   kernel/trace/ring_buffer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1d9caee7f542..e110cde685ea 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -706,6 +706,9 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>   	unsigned long cnt2, top2, bottom2, msb2;
>   	u64 val;
>   
> +	/* Any interruptions in this function should cause a failure */
> +	cnt = local_read(&t->cnt);
> +
>   	/* The cmpxchg always fails if it interrupted an update */
>   	 if (!__rb_time_read(t, &val, &cnt2))
>   		 return false;
> @@ -713,7 +716,6 @@ static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
>   	 if (val != expect)
>   		 return false;
>   
> -	 cnt = local_read(&t->cnt);
>   	 if ((cnt & 3) != cnt2)
>   		 return false;
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

