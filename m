Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A9786FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbjHXNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbjHXNCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8396CE79;
        Thu, 24 Aug 2023 06:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008D664AF8;
        Thu, 24 Aug 2023 13:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2163C433C7;
        Thu, 24 Aug 2023 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692882152;
        bh=q2az01/KAgq/cnwVEoG/mArWYoVRqcX7JTqR4RkwD9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=exrNO0cyE7+gD8isFveY8zJlFYKrFIHi+EBtj8pEu1J7XJt+8j9kFwpezxlM+4xRd
         QQ9RjWPFwIIx8VO3lNkhUqgkcE+bOpJgSi/TJzxgdikmDVBADeucuGZ44kfEdVG6Ku
         K34FRTCANLETF/b+Vsw6D2PTMAooRECfaqZgc9VVeVEM475v6oqfqBkEn8kg3RFEad
         Z1cmnOKK+wEr3JRJ0rDk8lSgo8lwCa4c9wEZw6IXKjzlfm2wgdW/QHTGTdYXHA7e5w
         Rok54at1yG/NjoYu0L5iqDGorJAy4mszNRIqP5dIfFB9Ad7EOMgy01VZ4Cd0rsUseC
         Vy1JH8IcvvXTA==
Date:   Thu, 24 Aug 2023 22:02:27 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v2 1/1] tracing/kprobes: Return EADDRNOTAVAIL when
 func matches several symbols
Message-Id: <20230824220227.01c367c1d7b6219a79cf2843@kernel.org>
In-Reply-To: <20230824103734.53453-2-flaniel@linux.microsoft.com>
References: <20230824103734.53453-1-flaniel@linux.microsoft.com>
        <20230824103734.53453-2-flaniel@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 12:37:34 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Previously to this commit, if func matches several symbols, a kprobe, being
> either sysfs or PMU, would only be installed for the first matching address.
> This could lead to some misunderstanding when some BPF code was never called
> because it was attached to a function which was indeed not call, because the
> effectively called one has no kprobes.
> 
> So, this commit returns EADDRNOTAVAIL when func matches several symbols.
> This way, user needs to use addr to remove the ambiguity.

Thanks for update the patch. I have some comments there. 

> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
> ---
>  kernel/trace/trace_kprobe.c | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 23dba01831f7..0c8dd6ba650b 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -705,6 +705,25 @@ static struct notifier_block trace_kprobe_module_nb = {
>  	.priority = 1	/* Invoked after kprobe module callback */
>  };
>  
> +static int count_symbols(void *data, unsigned long unused)
> +{
> +	unsigned int *count = data;
> +
> +	(*count)++;
> +
> +	return 0;
> +}
> +
> +static unsigned int func_name_several_symbols(char *func_name)

If this returns boolean, please use 'bool' for return type.
Also, I think 'func_name_is_unique()' is more natural.

> +{
> +	unsigned int count;
> +
> +	count = 0;
> +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> +
> +	return count > 1;
> +}
> +
>  static int __trace_kprobe_create(int argc, const char *argv[])
>  {
>  	/*
> @@ -836,6 +855,18 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		}
>  	}
>  
> +	/*
> +	 * If user specifies KSYM, we check it does not correspond to several
> +	 * symbols.
> +	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
> +	 * he/she should use ADDR rather than KSYM to remove the ambiguity.
> +	 */
> +	if (symbol && func_name_several_symbols(symbol)) {

Then, here  will be 

	if (symbol && !func_name_is_unique(symbol)) {

> +		ret = -EADDRNOTAVAIL;
> +
> +		goto error;
> +	}
> +
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1699,6 +1730,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
>  }
>  
>  #ifdef CONFIG_PERF_EVENTS
> +
>  /* create a trace_kprobe, but don't add it to global lists */
>  struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> @@ -1709,6 +1741,16 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	int ret;
>  	char *event;
>  
> +	/*
> +	 * If user specifies func, we check that function name does not
> +	 * correspond to several symbols.
> +	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
> +	 * he/she should use addr and offs rather than func to remove the
> +	 * ambiguity.
> +	 */
> +	if (func && func_name_several_symbols(func))

Ditto.

Thanks!

> +		return ERR_PTR(-EADDRNOTAVAIL);
> +
>  	/*
>  	 * local trace_kprobes are not added to dyn_event, so they are never
>  	 * searched in find_trace_kprobe(). Therefore, there is no concern of
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
