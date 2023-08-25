Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2778882E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbjHYNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbjHYNNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6710FE;
        Fri, 25 Aug 2023 06:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F40665C5;
        Fri, 25 Aug 2023 13:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF52C433C7;
        Fri, 25 Aug 2023 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692969206;
        bh=X0U/xGU5nTINH9ptHEr8geKyHkeF/nokeua/b8gI5pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iLwJSPQ+HEmNKHHSHGeUp2NRaARIZ1QOngBZaItREod9pHlgCj84ZPblnuh6bh7cX
         xbZvcb+xMTefRPT9XIBUw/mdfieoKcrWfeXdwMXGbxGatgBEqsWcpMUzU0PLaBRvYg
         4ZzRY3gk8lUpnndfFII508PTZPEkxtq9yQBKS53JaeHpGs5XPYrSPD2P3z6AcSWdqC
         i1rEekfcOOH0TZlZnAI+5pQ0y2iOjasUN+BRQpsIEeHG0DIoiL0B0uOQsiqEzMjJhM
         XAVlspLP7DV7zhg5t4iObg8bwKl3rqfJMxLsTxrxu9zJWd1gPUlzmXPjLECcxrR5Jz
         KH1y935or28EQ==
Date:   Fri, 25 Aug 2023 22:13:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-Id: <20230825221321.faaa33e03afc48abc345c24f@kernel.org>
In-Reply-To: <5704161.DvuYhMxLoT@pwmachine>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com>
        <20230824160859.66113-2-flaniel@linux.microsoft.com>
        <20230825211649.188a81321f00297ec161a046@kernel.org>
        <5704161.DvuYhMxLoT@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 14:34:49 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le vendredi 25 août 2023, 14:16:49 CEST Masami Hiramatsu a écrit :
> > On Thu, 24 Aug 2023 18:08:59 +0200
> > 
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > Previously to this commit, if func matches several symbols, a kprobe,
> > > being
> > > either sysfs or PMU, would only be installed for the first matching
> > > address. This could lead to some misunderstanding when some BPF code was
> > > never called because it was attached to a function which was indeed not
> > > called, because the effectively called one has no kprobes attached.
> > > 
> > > So, this commit returns EADDRNOTAVAIL when func matches several symbols.
> > > This way, user needs to use address to remove the ambiguity.
> > > 
> > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > Link:
> > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kern
> > > el.org/ ---
> > 
> > Ah, this should be fine, but selftest (tools/testing/selftests/ftrace)
> > fails.
> > 
> >  # tail 60-kprobe_module.tc-log.vsOHnF
> > ...
> > + :
> > + : 'Add an event on a module function without specifying event name'
> > + :
> > + echo 'p trace_printk:trace_printk_irq_work'
> > sh: write error: No such file or directory
> > 
> > Ah, the function on non-exist module should be checked too.
> > 
> > # tail 63-kprobe_syntax_errors.tc-log.mMLwIQ
> > + + printfwc '%s' -c
> >  'p '
> > + pos=2
> > + printf+  '%s'tr 'p ^non_exist_func'
> >  -d ^
> > + command='p non_exist_func'
> > + echo 'Test command: p non_exist_func'
> > Test command: p non_exist_func
> > + echo
> > + grep 'trace_kprobe: error:' -A 3 error_log
> > 
> > Also, this doesn't leave a syntax error message.
> > 
> > So, the below changes are needed.
> 
> Excellent catch! Thank you, I will apply this patch and send v4 right after.
> Regarding test, do you think I can add a test for the EADDRNOTAVAIL case?

Hmm, in that case, you need to change something in tracefs/README so that
we can identify the kernel has different behavior. Or we have to change
this is a "Fix" for backporting.

> Maybe it should go inside LTP? As this would need having a kernel compiled 
> with a name pointing to several symbols?

For this tracing feature, I rather like to use tools/testing/selftests/ftrace
to test it. And it is used on all stable kernel, that is why we need to add
some change on tracefs/README or something.

But I would like to wait for Alessandro's work. After his work, in this time
we need to probe all the same-name symbols as your original patch does.
This is because 1:n mapping can happen as Alessandro pointed in

https://lore.kernel.org/all/CAPp5cGQsRdB0+KHR1wX2bDDdc5sTzSNPA417PNJb0ypmV=yS6w@mail.gmail.com/

But if his feature is configurable (and maybe so), we need to keep this
version... We have many options.

- this normal kallsyms: the same-name symbols should not be used.
- enhanced kallsyms (if 1:n symbol has the same suffix): the same name symbols
   should be probed at once.
- enhanced kallsyms (if 1:n symbol has different suffix): the same-name symbol
   must not exist.


> 
> Also, should some man pages somewhere be updated to reflect the case kprobe can 
> return EADDRNOTAVAIL?

No, it is a tracefs interface and we don't have man pages yet.

Thank you,

> 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 8ab46a2a446d..1e57bc896952 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -855,7 +855,7 @@ static int __trace_kprobe_create(int argc, const char
> > *argv[]) }
> >  	}
> > 
> > -	if (symbol) {
> > +	if (symbol && !strchr(symbol, ':')) {
> >  		unsigned int count;
> > 
> >  		count = number_of_same_symbols(symbol);
> > @@ -864,6 +864,7 @@ static int __trace_kprobe_create(int argc, const char
> > *argv[]) * Users should use ADDR to remove the ambiguity of
> >  			 * using KSYM only.
> >  			 */
> > +			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> >  			ret = -EADDRNOTAVAIL;
> > 
> >  			goto error;
> > @@ -872,6 +873,7 @@ static int __trace_kprobe_create(int argc, const char
> > *argv[]) * We can return ENOENT earlier than when register the
> >  			 * kprobe.
> >  			 */
> > +			trace_probe_log_err(0, BAD_PROBE_ADDR);
> >  			ret = -ENOENT;
> > 
> >  			goto error;
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 7f929482e8d4..a4f478448eef 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -450,6 +450,7 @@ extern int traceprobe_define_arg_fields(struct
> > trace_event_call *event_call, C(BAD_MAXACT,		"Invalid maxactive
> > number"),		\
> >  	C(MAXACT_TOO_BIG,	"Maxactive is too big"),		\
> >  	C(BAD_PROBE_ADDR,	"Invalid probed address or symbol"),	\
> > +	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
> >  	C(BAD_RETPROBE,		"Retprobe address must be an function 
> entry"), \
> >  	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
> >  	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
> > 
> > Thank you,
> > 
> > >  kernel/trace/trace_kprobe.c | 61 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > > 
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index 23dba01831f7..2f393739e8cf 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -705,6 +705,25 @@ static struct notifier_block trace_kprobe_module_nb =
> > > {> 
> > >  	.priority = 1	/* Invoked after kprobe module callback */
> > >  
> > >  };
> > > 
> > > +static int count_symbols(void *data, unsigned long unused)
> > > +{
> > > +	unsigned int *count = data;
> > > +
> > > +	(*count)++;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static unsigned int number_of_same_symbols(char *func_name)
> > > +{
> > > +	unsigned int count;
> > > +
> > > +	count = 0;
> > > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > > +
> > > +	return count;
> > > +}
> > > +
> > > 
> > >  static int __trace_kprobe_create(int argc, const char *argv[])
> > >  {
> > >  
> > >  	/*
> > > 
> > > @@ -836,6 +855,29 @@ static int __trace_kprobe_create(int argc, const char
> > > *argv[])> 
> > >  		}
> > >  	
> > >  	}
> > > 
> > > +	if (symbol) {
> > > +		unsigned int count;
> > > +
> > > +		count = number_of_same_symbols(symbol);
> > > +		if (count > 1) {
> > > +			/*
> > > +			 * Users should use ADDR to remove the ambiguity of
> > > +			 * using KSYM only.
> > > +			 */
> > > 
> > > 
> > > 
> > > +			ret = -EADDRNOTAVAIL;
> > > +
> > > +			goto error;
> > > +		} else if (count == 0) {
> > > +			/*
> > > +			 * We can return ENOENT earlier than when register the
> > > +			 * kprobe.
> > > +			 */
> > > +			ret = -ENOENT;
> > > +
> > > +			goto error;
> > > +		}
> > > +	}
> > > +
> > > 
> > >  	trace_probe_log_set_index(0);
> > >  	if (event) {
> > >  	
> > >  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> > > 
> > > @@ -1699,6 +1741,7 @@ static int unregister_kprobe_event(struct
> > > trace_kprobe *tk)> 
> > >  }
> > >  
> > >  #ifdef CONFIG_PERF_EVENTS
> > > 
> > > +
> > > 
> > >  /* create a trace_kprobe, but don't add it to global lists */
> > >  struct trace_event_call *
> > >  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > > 
> > > @@ -1709,6 +1752,24 @@ create_local_trace_kprobe(char *func, void *addr,
> > > unsigned long offs,> 
> > >  	int ret;
> > >  	char *event;
> > > 
> > > +	if (func) {
> > > +		unsigned int count;
> > > +
> > > +		count = number_of_same_symbols(func);
> > > +		if (count > 1)
> > > +			/*
> > > +			 * Users should use addr to remove the ambiguity of
> > > +			 * using func only.
> > > +			 */
> > > +			return ERR_PTR(-EADDRNOTAVAIL);
> > > +		else if (count == 0)
> > > +			/*
> > > +			 * We can return ENOENT earlier than when register the
> > > +			 * kprobe.
> > > +			 */
> > > +			return ERR_PTR(-ENOENT);
> > > +	}
> > > +
> > > 
> > >  	/*
> > >  	
> > >  	 * local trace_kprobes are not added to dyn_event, so they are never
> > >  	 * searched in find_trace_kprobe(). Therefore, there is no concern of
> 
> Best regards.
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
