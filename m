Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC080EEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376828AbjLLOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376827AbjLLOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:33:07 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A37DFE;
        Tue, 12 Dec 2023 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702391592;
        bh=T1FTOhn+dhe2RzQli+HA9sglh+MKVmt+QGRK16ISh8c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N/XuIcIC5n/F9LxFkbso1fomRmByzGSpVdY0yHcHKFnqc56Z86rthqwwb81hDbQLl
         Uh8IPawWVo14yvd+5h+t9oL5MpUcMABxKJvJCOUA+v7c/T9VrlbCAIfi6qNQA5FZJb
         vu7eezd4Ljb+IfozTCP+OVSwNa4NL6r2Whg4e/eb64BlCws/4+xQUj6Rp/Ocs/tWGW
         NojGDRAVm+4DhQjcTjQYdvGn2xCpkYo96ByDUx8Ae+2PrsEOJroGzjnqsLCT8Vd2ap
         noaa5PMANi+SrI26YYNlQvAFJUieMCy7Wk/S/PH7FJMvjCg2AHZQ5sXGw4a8aIIVBL
         hIFDB56U5nzsw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SqLgr0zpNzGCv;
        Tue, 12 Dec 2023 09:33:12 -0500 (EST)
Message-ID: <445ac00d-0f0c-4f6a-b85a-97209635c3f3@efficios.com>
Date:   Tue, 12 Dec 2023 09:33:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Allow for max buffer data size trace_marker
 writes
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231212090057.41b28efe@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231212090057.41b28efe@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-12 09:00, Steven Rostedt wrote:
[...]
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7272,6 +7272,7 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	enum event_trigger_type tt = ETT_NONE;
>   	struct trace_buffer *buffer;
>   	struct print_entry *entry;
> +	int meta_size;
>   	ssize_t written;
>   	int size;
>   	int len;
> @@ -7286,12 +7287,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	if (!(tr->trace_flags & TRACE_ITER_MARKERS))
>   		return -EINVAL;
>   
> -	if (cnt > TRACE_BUF_SIZE)
> -		cnt = TRACE_BUF_SIZE;

You're removing an early bound check for a size_t userspace input...

> -
> -	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
> -
> -	size = sizeof(*entry) + cnt + 2; /* add '\0' and possible '\n' */
> +	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
> + again:
> +	size = cnt + meta_size;

... and then implicitly casting it into a "int" size variable, which
can therefore become a negative value.

Just for the sake of not having to rely on ring_buffer_lock_reserve
catching (length > BUF_MAX_DATA_SIZE), I would recommend to add an
early check for negative here.

>   
>   	/* If less than "<faulted>", then make sure we can still add that */
>   	if (cnt < FAULTED_SIZE)
> @@ -7300,9 +7298,25 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
>   	buffer = tr->array_buffer.buffer;
>   	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
>   					    tracing_gen_ctx());
> -	if (unlikely(!event))
> +	if (unlikely(!event)) {
> +		/*
> +		 * If the size was greated than what was allowed, then

greater ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

