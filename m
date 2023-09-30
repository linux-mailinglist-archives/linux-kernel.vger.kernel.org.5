Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76B7B3EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjI3Gvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 02:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3Gvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:51:50 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015D1A7;
        Fri, 29 Sep 2023 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/rOmt5SLaS7Yz0iKS8ydfKeLA81Zpo1ZPG8/8eRAUK8=;
  b=K25GxmM7xyuuG5kAcEs455V8uqwkUzj7nQx1IdDsQvnFQMla2h44A/Tz
   tyzXs7DCAdI0ABzglWm594TIgsVKekHvtjevyf3g4Z8r4Y97khKpmAYpy
   /8VS+Dd/KpsZIweHNkN4/5fPPXqbQjewphzGkqFCGMCF2dY4v3ou9qYt2
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,189,1694728800"; 
   d="scan'208";a="67391132"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 08:51:46 +0200
Date:   Sat, 30 Sep 2023 08:51:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ring-buffer: Update "shortest_full" in polling
In-Reply-To: <20230929180113.01c2cae3@rorschach.local.home>
Message-ID: <alpine.DEB.2.22.394.2309300850320.3082@hadrien>
References: <20230929180113.01c2cae3@rorschach.local.home>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Sep 2023, Steven Rostedt wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> It was discovered that the ring buffer polling was incorrectly stating
> that read would not block, but that's because polling did not take into
> account that reads will block if the "buffer-percent" was set. Instead,
> the ring buffer polling would say reads would not block if there was any
> data in the ring buffer. This was incorrect behavior from a user space
> point of view. This was fixed by commit 42fb0a1e84ff by having the polling
> code check if the ring buffer had more data than what the user specified
> "buffer percent" had.
>
> The problem now is that the polling code did not register itself to the
> writer that it wanted to wait for a specific "full" value of the ring
> buffer. The result was that the writer would wake the polling waiter
> whenever there was a new event. The polling waiter would then wake up, see
> that there's not enough data in the ring buffer to notify user space and
> then go back to sleep. The next event would wake it up again.
>
> Before the polling fix was added, the code would wake up around 100 times
> for a hackbench 30 benchmark. After the "fix", due to the constant waking
> of the writer, it would wake up over 11,0000 times! It would never leave
> the kernel, so the user space behavior was still "correct", but this
> definitely is not the desired effect.
>
> To fix this, have the polling code add what it's waiting for to the
> "shortest_full" variable, to tell the writer not to wake it up if the
> buffer is not as full as it expects to be.
>
> Note, after this fix, it appears that the waiter is now woken up around 2x
> the times it was before (~200). This is a tremendous improvement from the
> 11,000 times, but I will need to spend some time to see why polling is
> more aggressive in its wakeups than the read blocking code.

Actually, in my test it has gone from 276 wakeups in 6.0 to only 3 with
this patch.

I can do some more tests.

>
> Cc: stable@vger.kernel.org
> Fixes: 42fb0a1e84ff ("tracing/ring-buffer: Have polling block on watermark")
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Julia Lawall <julia.lawall@inria.fr>

julia

> ---
>  kernel/trace/ring_buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 28daf0ce95c5..515cafdb18d9 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1137,6 +1137,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
>  	if (full) {
>  		poll_wait(filp, &work->full_waiters, poll_table);
>  		work->full_waiters_pending = true;
> +		if (!cpu_buffer->shortest_full ||
> +		    cpu_buffer->shortest_full > full)
> +			cpu_buffer->shortest_full = full;
>  	} else {
>  		poll_wait(filp, &work->waiters, poll_table);
>  		work->waiters_pending = true;
> --
> 2.40.1
>
>
