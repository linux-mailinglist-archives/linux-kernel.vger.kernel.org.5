Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1691277F17B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbjHQHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbjHQHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69087198C;
        Thu, 17 Aug 2023 00:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06A14633D4;
        Thu, 17 Aug 2023 07:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FC7C433C7;
        Thu, 17 Aug 2023 07:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692258661;
        bh=OyyGocwEfh+WJN46VXnSNwi5oxgvXIO4wyboTuRfmag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XAFtGVOlIuXDbq1rBeuuBrYe6IN3h14IE0lzysPns/72q1qS2BK9m4B+LN65AiHKw
         oYZHyhk95YyBnEcPKDtou2+GoIkzfKTaJrp9DL139t+qSxpbsFto79L71TL67nmf+V
         Cw5WGkeDj75BYUCiLC7FKlQdHChW+bf5NryXpdCRQbLUohWOS3irC4eHmkmC4pqbfW
         QkPnAyVFlTsKG2Lk3geCNXUxbpBiHLepAgxPN3zN1fJ7i1WrfLz654gYboybAja+04
         SC8EXyIRqzqQRH+PoNjKzHhZwu44t0GwkLUxlWNdik0BmJ3qG52YxQ5hTtgKGwNt6L
         3ix46TdMW9m2g==
Date:   Thu, 17 Aug 2023 16:50:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230817165057.bd073da472851462e30ef145@kernel.org>
In-Reply-To: <20230816163517.112518-2-flaniel@linux.microsoft.com>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230816163517.112518-2-flaniel@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Aug 2023 18:35:17 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> When using sysfs, it is possible to create kprobe for several kernel functions
> sharing the same name, but of course with different addresses, by writing their
> addresses in kprobe_events file.
> 
> When using PMU, if only the symbol name is given, the event will be created for
> the first address which matches the symbol, as returned by
> kallsyms_lookup_name().

Do you mean probing the same name symbols? Yes, it is intended behavior, since
it is not always true that the same name function has the same prototype (it is
mostly true but is not ensured), it is better to leave user to decide which one
is what you want to probe.

Have you used 'perf probe' tool? It tries to find the appropriate function by
line number and creates the probe by 'text+OFFSET' style, not by symbol.
I think this is the correct way to do that, because user will not know which
'address' of the symbol is what the user want.

Thought?

Thank you,

> The idea here is to search all kernel functions which match this symbol and
> create a trace_kprobe for each of them.
> All these trace_kprobes are linked together by sharing the same trace_probe.
> 
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>  kernel/trace/trace_kprobe.c | 86 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 1b3fa7b854aa..08580f1466c7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1682,13 +1682,42 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
>  }
>  
>  #ifdef CONFIG_PERF_EVENTS
> +
> +struct address_array {
> +	unsigned long *addrs;
> +	size_t size;
> +};
> +
> +static int add_addr(void *data, unsigned long addr)
> +{
> +	struct address_array *array = data;
> +	unsigned long *p;
> +
> +	array->size++;
> +	p = krealloc(array->addrs,
> +				sizeof(*array->addrs) * array->size,
> +				GFP_KERNEL);
> +	if (!p) {
> +		kfree(array->addrs);
> +		return -ENOMEM;
> +	}
> +
> +	array->addrs = p;
> +	array->addrs[array->size - 1] = addr;
> +
> +	return 0;
> +}
> +
>  /* create a trace_kprobe, but don't add it to global lists */
>  struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  			  bool is_return)
>  {
>  	enum probe_print_type ptype;
> +	struct address_array array;
>  	struct trace_kprobe *tk;
> +	unsigned long func_addr;
> +	unsigned int i;
>  	int ret;
>  	char *event;
>  
> @@ -1722,7 +1751,64 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	if (ret < 0)
>  		goto error;
>  
> +	array.addrs = NULL;
> +	array.size = 0;
> +	ret = kallsyms_on_each_match_symbol(add_addr, func, &array);
> +	if (ret)
> +		goto error_free;
> +
> +	if (array.size == 1)
> +		goto end;
> +
> +	/*
> +	 * Below loop allocates a trace_kprobe for each function with the same
> +	 * name in kernel source code.
> +	 * All this differente trace_kprobes will be linked together through
> +	 * append_trace_kprobe().
> +	 * NOTE append_trace_kprobe() is called in register_trace_kprobe() which
> +	 * is called when a kprobe is added through sysfs.
> +	 */
> +	func_addr = kallsyms_lookup_name(func);
> +	for (i = 0; i < array.size; i++) {
> +		struct trace_kprobe *tk_same_name;
> +		unsigned long address;
> +
> +		address = array.addrs[i];
> +		/* Skip the function address as we already registered it. */
> +		if (address == func_addr)
> +			continue;
> +
> +		/*
> +		 * alloc_trace_kprobe() first considers symbol name, so we set
> +		 * this to NULL to allocate this kprobe on the given address.
> +		 */
> +		tk_same_name = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> +						  (void *)address, NULL, offs,
> +						  0 /* maxactive */,
> +						  0 /* nargs */, is_return);
> +
> +		if (IS_ERR(tk_same_name)) {
> +			ret = -ENOMEM;
> +			goto error_free;
> +		}
> +
> +		init_trace_event_call(tk_same_name);
> +
> +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> +			ret = -ENOMEM;
> +			goto error_free;
> +		}
> +
> +		ret = append_trace_kprobe(tk_same_name, tk);
> +		if (ret)
> +			goto error_free;
> +	}
> +
> +end:
> +	kfree(array.addrs);
>  	return trace_probe_event_call(&tk->tp);
> +error_free:
> +	kfree(array.addrs);
>  error:
>  	free_trace_kprobe(tk);
>  	return ERR_PTR(ret);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
