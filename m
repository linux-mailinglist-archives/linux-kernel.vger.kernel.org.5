Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD0780C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377003AbjHRNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376991AbjHRNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44B3A9A;
        Fri, 18 Aug 2023 06:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224FC626C4;
        Fri, 18 Aug 2023 13:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55320C433C8;
        Fri, 18 Aug 2023 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692363941;
        bh=ST8aoYDt4cxO6YEU5/qRzZ0HaZMR0ytBs56r1s7+yh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gV4/yET9sR/jTp3PcUeivMmVkMqlnAjDBosXqT+51t4DVqYFogfIDynb60uf+P6yG
         /M+YvcpO0OFaVO5y9egdDuvQcP2nV7HUk2MnY6dZz6Tusgf0Z3A8Vq9zARcYkyCMnr
         BjJOJNR/QyYVIBlJkyMOKoc2wtKaSICFc9b4Ws6q2wCo9sZ+TL7saZ9ocEllnZgh9B
         /r64/SVV2U23jmlnG4kjMSa2ZazXnVgkyIz/AkTlJv2bRQ/ua6kVPDdvhQi9UZ1+kk
         BeSrNJdZfpGQ3QGgs1avRlGBi1O3KJEVHQ34eCFqyKq1MzuBDAcqeSXEqmB77QJtBr
         B25bO2vOieWXA==
Date:   Fri, 18 Aug 2023 22:05:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230818220537.75ce8210c6a4c80a5a8d16f8@kernel.org>
In-Reply-To: <2154216.irdbgypaU6@pwmachine>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230816163517.112518-2-flaniel@linux.microsoft.com>
        <20230817165057.bd073da472851462e30ef145@kernel.org>
        <2154216.irdbgypaU6@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 13:06:20 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le jeudi 17 août 2023, 09:50:57 CEST Masami Hiramatsu a écrit :
> > Hi,
> > 
> > On Wed, 16 Aug 2023 18:35:17 +0200
> > 
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > When using sysfs, it is possible to create kprobe for several kernel
> > > functions sharing the same name, but of course with different addresses,
> > > by writing their addresses in kprobe_events file.
> > > 
> > > When using PMU, if only the symbol name is given, the event will be
> > > created for the first address which matches the symbol, as returned by
> > > kallsyms_lookup_name().
> > 
> > Do you mean probing the same name symbols? Yes, it is intended behavior,
> > since it is not always true that the same name function has the same
> > prototype (it is mostly true but is not ensured), it is better to leave
> > user to decide which one is what you want to probe.
> 
> This is what I meant.
> I also share your mind regarding leaving the users deciding which one they 
> want to probe but in my case (which I agree is a bit a corner one) it leaded 
> me to misunderstanding as the PMU kprobe was only added to the first 
> ntfs_file_write_iter() which is not the one for ntfs3.

Hmm, OK. I think in that case (multiple same-name symbols exist) the default
behavior is rejecting with error message. And optionally, it will probe all
or them like your patch.

> 
> > Have you used 'perf probe' tool? It tries to find the appropriate function
> > by line number and creates the probe by 'text+OFFSET' style, not by symbol.
> > I think this is the correct way to do that, because user will not know
> > which 'address' of the symbol is what the user want.
> 
> 'perf probe' perfectly does the trick, as it would find all the kernel 
> addresses which correspond to the symbol name and create as many probes as 
> corresponding symbols [1]:
> root@vm-amd64:~# perf probe --add ntfs_file_write_iter

If you can specify the (last part of) file path as below,

perf probe --add ntfs_file_write_iter@ntfs3/file.c

Then it will choose correct one. :)

> 
> Added new events:
>   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
>   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> 
> You can now use it in all perf tools, such as:
> 
>         perf record -e probe:ntfs_file_write_iter -aR sleep 1
> root@vm-amd64:~# cat /sys/kernel/tracing/kprobe_events
> p:probe/ntfs_file_write_iter _text+5088544
> p:probe/ntfs_file_write_iter _text+5278560
> 
> > Thought?
> 
> This contribution is basically here to sort of mimic what perf does but with 
> PMU kprobes, as this is not possible to write in a sysfs file with this type of 
> probe.

OK, I see it is for BPF only. Maybe BPF program can filter correct one
to access the argument etc. 

Thank you,

> 
> > 
> > Thank you,
> > 
> > > The idea here is to search all kernel functions which match this symbol
> > > and
> > > create a trace_kprobe for each of them.
> > > All these trace_kprobes are linked together by sharing the same
> > > trace_probe.
> > > 
> > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > ---
> > > 
> > >  kernel/trace/trace_kprobe.c | 86 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 86 insertions(+)
> > > 
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index 1b3fa7b854aa..08580f1466c7 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -1682,13 +1682,42 @@ static int unregister_kprobe_event(struct
> > > trace_kprobe *tk)> 
> > >  }
> > >  
> > >  #ifdef CONFIG_PERF_EVENTS
> > > 
> > > +
> > > +struct address_array {
> > > +	unsigned long *addrs;
> > > +	size_t size;
> > > +};
> > > +
> > > +static int add_addr(void *data, unsigned long addr)
> > > +{
> > > +	struct address_array *array = data;
> > > +	unsigned long *p;
> > > +
> > > +	array->size++;
> > > +	p = krealloc(array->addrs,
> > > +				sizeof(*array->addrs) * array->size,
> > > +				GFP_KERNEL);
> > > +	if (!p) {
> > > +		kfree(array->addrs);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	array->addrs = p;
> > > +	array->addrs[array->size - 1] = addr;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > 
> > >  /* create a trace_kprobe, but don't add it to global lists */
> > >  struct trace_event_call *
> > >  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > >  
> > >  			  bool is_return)
> > >  
> > >  {
> > >  
> > >  	enum probe_print_type ptype;
> > > 
> > > +	struct address_array array;
> > > 
> > >  	struct trace_kprobe *tk;
> > > 
> > > +	unsigned long func_addr;
> > > +	unsigned int i;
> > > 
> > >  	int ret;
> > >  	char *event;
> > > 
> > > @@ -1722,7 +1751,64 @@ create_local_trace_kprobe(char *func, void *addr,
> > > unsigned long offs,> 
> > >  	if (ret < 0)
> > >  	
> > >  		goto error;
> > > 
> > > +	array.addrs = NULL;
> > > +	array.size = 0;
> > > +	ret = kallsyms_on_each_match_symbol(add_addr, func, &array);
> > > +	if (ret)
> > > +		goto error_free;
> > > +
> > > +	if (array.size == 1)
> > > +		goto end;
> > > +
> > > +	/*
> > > +	 * Below loop allocates a trace_kprobe for each function with the same
> > > +	 * name in kernel source code.
> > > +	 * All this differente trace_kprobes will be linked together through
> > > +	 * append_trace_kprobe().
> > > +	 * NOTE append_trace_kprobe() is called in register_trace_kprobe() 
> which
> > > +	 * is called when a kprobe is added through sysfs.
> > > +	 */
> > > +	func_addr = kallsyms_lookup_name(func);
> > > +	for (i = 0; i < array.size; i++) {
> > > +		struct trace_kprobe *tk_same_name;
> > > +		unsigned long address;
> > > +
> > > +		address = array.addrs[i];
> > > +		/* Skip the function address as we already registered it. */
> > > +		if (address == func_addr)
> > > +			continue;
> > > +
> > > +		/*
> > > +		 * alloc_trace_kprobe() first considers symbol name, so we set
> > > +		 * this to NULL to allocate this kprobe on the given address.
> > > +		 */
> > > +		tk_same_name = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > +						  (void *)address, NULL, offs,
> > > +						  0 /* maxactive */,
> > > +						  0 /* nargs */, is_return);
> > > +
> > > +		if (IS_ERR(tk_same_name)) {
> > > +			ret = -ENOMEM;
> > > +			goto error_free;
> > > +		}
> > > +
> > > +		init_trace_event_call(tk_same_name);
> > > +
> > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> > > +			ret = -ENOMEM;
> > > +			goto error_free;
> > > +		}
> > > +
> > > +		ret = append_trace_kprobe(tk_same_name, tk);
> > > +		if (ret)
> > > +			goto error_free;
> > > +	}
> > > +
> > > +end:
> > > +	kfree(array.addrs);
> > > 
> > >  	return trace_probe_event_call(&tk->tp);
> > > 
> > > +error_free:
> > > +	kfree(array.addrs);
> > > 
> > >  error:
> > >  	free_trace_kprobe(tk);
> > >  	return ERR_PTR(ret);
> 
> ---
> [1]: https://github.com/torvalds/linux/blob/
> 57012c57536f8814dec92e74197ee96c3498d24e/tools/perf/util/probe-event.c#L2989-
> L2993
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
