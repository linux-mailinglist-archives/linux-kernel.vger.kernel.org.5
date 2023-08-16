Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A824277E8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345625AbjHPSmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbjHPSmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE88A1B2;
        Wed, 16 Aug 2023 11:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4409762825;
        Wed, 16 Aug 2023 18:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF51C433C8;
        Wed, 16 Aug 2023 18:42:10 +0000 (UTC)
Date:   Wed, 16 Aug 2023 14:42:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230816144213.0f24cc62@gandalf.local.home>
In-Reply-To: <20230816163517.112518-2-flaniel@linux.microsoft.com>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230816163517.112518-2-flaniel@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 18:35:17 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> When using sysfs, it is possible to create kprobe for several kernel functions
> sharing the same name, but of course with different addresses, by writing their
> addresses in kprobe_events file.

So this only happens if you write in the address?

> 
> When using PMU, if only the symbol name is given, the event will be created for
> the first address which matches the symbol, as returned by
> kallsyms_lookup_name().
> The idea here is to search all kernel functions which match this symbol and
> create a trace_kprobe for each of them.
> All these trace_kprobes are linked together by sharing the same trace_probe.
> 

So this makes the PMU version enable all by name, so there's still a
disconnect between how sysfs works and how PMU does.

Why can't you just pass in the address like sysfs does?

-- Steve


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

