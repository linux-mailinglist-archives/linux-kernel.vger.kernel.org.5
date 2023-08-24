Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8113C78722A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbjHXOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbjHXOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AFE1FD7;
        Thu, 24 Aug 2023 07:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8458561A43;
        Thu, 24 Aug 2023 14:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF710C433C8;
        Thu, 24 Aug 2023 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692888445;
        bh=7wEciiG/1W+7HITQ70qOkE5s3U7VWZTj6perXh1m3PQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sP+q8ZcWq3DuP5eRGPyEnmM2OsuNYBrSubXlObY3/RmXNme/mEG9GALweqAzd9JeL
         /4ZclqjS+Ae6RoAPNoBKRjjRkBDk8AnYWLrLZsTYTmpAYArqxzbjszJCesyYTQTlaa
         ZSqlYpgSb3Ym/HDuUN4prnIWcbb5wz8l+0BfvDqXawAsGnmaxq6UMsh7XSgHd7+NJ1
         x7VwjLuyxy7t5BCRNfkSTKkldK0i3ef6OICwqQzHo8KUQnfi9wVYbx/0LmhUS2aP0X
         fs+t4LT/af+t6pRXi30TIq6VWRkspHh2U4a0yVUZfHx7uEBO1yYqpIxigcmMULcP3L
         MafQeij4y5/rw==
Date:   Thu, 24 Aug 2023 23:47:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 1/1] tracing/kprobes: Return EADDRNOTAVAIL when
 func matches several symbols
Message-Id: <20230824234721.1b481cd5d0b8bbc43a24d9a6@kernel.org>
In-Reply-To: <12271275.O9o76ZdvQC@pwmachine>
References: <20230824103734.53453-1-flaniel@linux.microsoft.com>
        <20230824103734.53453-2-flaniel@linux.microsoft.com>
        <20230824220227.01c367c1d7b6219a79cf2843@kernel.org>
        <12271275.O9o76ZdvQC@pwmachine>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 16:31:13 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> Le jeudi 24 août 2023, 15:02:27 CEST Masami Hiramatsu a écrit :
> > On Thu, 24 Aug 2023 12:37:34 +0200
> > 
> > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > Previously to this commit, if func matches several symbols, a kprobe,
> > > being
> > > either sysfs or PMU, would only be installed for the first matching
> > > address. This could lead to some misunderstanding when some BPF code was
> > > never called because it was attached to a function which was indeed not
> > > call, because the effectively called one has no kprobes.
> > > 
> > > So, this commit returns EADDRNOTAVAIL when func matches several symbols.
> > > This way, user needs to use addr to remove the ambiguity.
> > 
> > Thanks for update the patch. I have some comments there.
> > 
> > > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > Link:
> > > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kern
> > > el.org/ ---
> > > 
> > >  kernel/trace/trace_kprobe.c | 42 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index 23dba01831f7..0c8dd6ba650b 100644
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
> > > +static unsigned int func_name_several_symbols(char *func_name)
> > 
> > If this returns boolean, please use 'bool' for return type.
> > Also, I think 'func_name_is_unique()' is more natural.
> > 
> 
> This name sounds better but it means it will check count == 1.
> I am fine with it, but please see my below comment.
> 
> > > +{
> > > +	unsigned int count;
> > > +
> > > +	count = 0;
> > > +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> > > +
> > > +	return count > 1;
> > > +}
> > > +
> > > 
> > >  static int __trace_kprobe_create(int argc, const char *argv[])
> > >  {
> > >  
> > >  	/*
> > > 
> > > @@ -836,6 +855,18 @@ static int __trace_kprobe_create(int argc, const char
> > > *argv[])> 
> > >  		}
> > >  	
> > >  	}
> > > 
> > > +	/*
> > > +	 * If user specifies KSYM, we check it does not correspond to several
> > > +	 * symbols.
> > > +	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
> > > +	 * he/she should use ADDR rather than KSYM to remove the ambiguity.
> > > +	 */
> > > +	if (symbol && func_name_several_symbols(symbol)) {
> > 
> > Then, here  will be
> > 
> > 	if (symbol && !func_name_is_unique(symbol)) {
> > 
> 
> I am fine with the above, but it means if users gives an unknown symbol, we 
> will return EADDRNOTAVAIL instead of currently returning ENOENT.
> Is it OK?

Ah, good catch! Hm, then what about 'int number_of_same_symbols()' ?


if (symbol) {
	num = number_of_same_symbols(symbol);
	if (num > 1)
		return -EADDRNOTAVAIL;
	else if (num == 0)
		return -ENOENT;
}

Thank you,

> 
> > > +		ret = -EADDRNOTAVAIL;
> > > +
> > > +		goto error;
> > > +	}
> > > +
> > > 
> > >  	trace_probe_log_set_index(0);
> > >  	if (event) {
> > >  	
> > >  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> > > 
> > > @@ -1699,6 +1730,7 @@ static int unregister_kprobe_event(struct
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
> > > @@ -1709,6 +1741,16 @@ create_local_trace_kprobe(char *func, void *addr,
> > > unsigned long offs,> 
> > >  	int ret;
> > >  	char *event;
> > > 
> > > +	/*
> > > +	 * If user specifies func, we check that function name does not
> > > +	 * correspond to several symbols.
> > > +	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
> > > +	 * he/she should use addr and offs rather than func to remove the
> > > +	 * ambiguity.
> > > +	 */
> > > +	if (func && func_name_several_symbols(func))
> > 
> > Ditto.
> > 
> > Thanks!
> > 
> > > +		return ERR_PTR(-EADDRNOTAVAIL);
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
