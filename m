Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49B756818
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGQPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGQPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F83FA;
        Mon, 17 Jul 2023 08:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E3236112B;
        Mon, 17 Jul 2023 15:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1921C433C7;
        Mon, 17 Jul 2023 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689608164;
        bh=0KH5QZtva041A6q7/f5OP+yi5SzktuvZ1Reqbp3ZKbY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JNynSVfFOXQtpLLV2T55ySh4UwU/qNfGCss1eZBxmRCgoefhlXiH39pvQsTZS/WTQ
         X9iZpTLnnA9cYONCEHUJqXr9DAWX9vBTOjiv/vOWLxwy6lm8GFzmCDp4lpiRf48Q99
         rIKNZNBI/a2IzlIEZvfK9MePH239Ydv7qY/dCMpxnYHFyq0UlIzqcuo6/yr4cD2m94
         PNnVLy/uKsVpSJeUGnc1yAWtUYaknmaMZRglJEV4SHwItbSidsalQlkZzaiscyWVB+
         3cYOkLlP+X4AArc7Figug4vChnieHQUjVQfgOnTMqAD6VzRTCcYjj2LDQiuSAvhy67
         +Hm5JRNvHZf+w==
Message-ID: <9b212c49-ab51-0cd9-5871-c145c5f41b48@kernel.org>
Date:   Mon, 17 Jul 2023 17:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tracing/timerlat: Add latency threshold
Content-Language: en-US, pt-BR, it-IT
To:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20230716193000.231406-1-costa.shul@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230716193000.231406-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Costa,

On 7/16/23 21:30, Costa Shulyupin wrote:
> The timerlat tracer generates a huge amount of traces.
> This affects the performance of the system and
> the delays we are trying to measure with timerlat.

More explanations in the code, but that is not the dominant factor,
neither relevant for large spikes.

> However, we are often interested in spikes of delay
> rather than small values.

That is why the stop tracing exists. One can set stop tracing,
ignore the trace buffer while tracing is on. Once tracing
turns off, tail the trace.

rtla timerlat has the --aa-only that ignores the trace until
the tracing stops, and then do the auto-analysis based on the
tail of the trace.

> 
> The patch effectively filters out irrelevant traces
> before they are generated and produces more reliable
> data.

More in the code, but it is not more reliable data... did
you mean human-readable data?

> 
> This patch helped to debug a very big problem
> and find this solution:
> https://lore.kernel.org/lkml/20221208075604.811710-1-junxiao.chang@intel.com/

Can you explain more about this? Because AFAICT, the patch above is
dealing with a SOFT timer. timerlat uses a HARD timer, so timerlat
is not affected by that bug... so I might be missing a point here.

> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/trace/timerlat-tracer.rst |  1 +
>  kernel/trace/trace_osnoise.c            | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
> index 53a56823e903..71b1c63ca403 100644
> --- a/Documentation/trace/timerlat-tracer.rst
> +++ b/Documentation/trace/timerlat-tracer.rst
> @@ -68,6 +68,7 @@ directory. The timerlat configs are:
>  
>   - cpus: CPUs at which a timerlat thread will execute.
>   - timerlat_period_us: the period of the timerlat thread.
> + - timerlat_threshold_ns: filter out timer latencies below the threshold

All the interface is in us....

>   - stop_tracing_us: stop the system tracing if a
>     timer latency at the *irq* context higher than the configured
>     value happens. Writing 0 disables this option.
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index bd0d01d00fb9..43284a1e8bea 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -346,6 +346,7 @@ static struct osnoise_data {
>  	u64	stop_tracing_total;	/* stop trace in the final operation (report/thread) */
>  #ifdef CONFIG_TIMERLAT_TRACER
>  	u64	timerlat_period;	/* timerlat period */
> +	u64	timerlat_threshold_ns;

comment....

>  	u64	print_stack;		/* print IRQ stack if total > */
>  	int	timerlat_tracer;	/* timerlat tracer */
>  #endif
> @@ -358,6 +359,7 @@ static struct osnoise_data {
>  #ifdef CONFIG_TIMERLAT_TRACER
>  	.print_stack			= 0,
>  	.timerlat_period		= DEFAULT_TIMERLAT_PERIOD,
> +	.timerlat_threshold_ns		= 0,
>  	.timerlat_tracer		= 0,
>  #endif
>  };
> @@ -597,6 +599,10 @@ static void trace_timerlat_sample(struct timerlat_sample *sample)
>  	struct osnoise_instance *inst;
>  	struct trace_buffer *buffer;
>  
> +	if (osnoise_data.timerlat_threshold_ns &&
> +	    sample->timer_latency < osnoise_data.timerlat_threshold_ns)
> +		return;
> +

From the entire timerlat machinery, skipping the print is not the
dominant factor. It can save a few nanoseconds, but the values are already
produced at this point... so why not?

You mentioned that this is useful for large spikes, so... it will not be the few
ns to cause problems.

And I'm not convinced that it produces more reliable results.
For example, if you find a large latency in the thread context, but skip
the IRQ context trace, you will lose useful data.... so your analysis is
prone to be less reliable.

Did you mean readable? improve the readability... That I can see.

Also, for debugging purposes, one needs to enable more events... at least
the osnoise: ones. These events happen more frequently than the timerlat
ones... and they are not being filtered here... Filtering them using the
event filtering interface will not help either, e.g., hiding 1k one us
interrupts bomb will mask you a 1ms delay...

So, as I said, I am not convinced that adding this interface file is
better than setting the stop-tracing option... and then waiting for
the trace to stop... parsing only the tail of the buffer.

Thoughts?

-- Daniel
