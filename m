Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8159787DED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHYCqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjHYCqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A6133;
        Thu, 24 Aug 2023 19:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B95562E87;
        Fri, 25 Aug 2023 02:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D81C433C7;
        Fri, 25 Aug 2023 02:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692931594;
        bh=83I67iwnJPZLEAG3UU6JFs3IemcFTcfX1RYGsDkKxVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DImzY/yDcyNFG/FuRdA2Wz5aIPj42zxvR6+0jbr4HZ1u7YsreZRRDkPnKxihh+xMK
         ujlOM4zzePqZmwmf5gVUAiRzcbG+HHt5lvl1mOM785opTcAHFQcz9erLDjKkjAoGyG
         mkDHU2HB9x4zRJrHVnYUZCYbI7vN+KpmDPRFIDFUwJqj/LxAm5k7umro88TQxxZ8va
         BfJnQOzbRjDFehS2mu37p7xCdQaHH/mmQvpQbtE0/1BI6612JSkmogBeQsrK1CGtjH
         AGeiISX9VLDMNwN6/7cohevd6UJZvv1BVbiD87jQnm95L02o/K62SaflV+SdZb8XjC
         rT5YcjMGRp1mw==
Date:   Fri, 25 Aug 2023 11:46:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-Id: <20230825114630.e1fc8d2a281067d29ea140d7@kernel.org>
In-Reply-To: <20230824160859.66113-2-flaniel@linux.microsoft.com>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com>
        <20230824160859.66113-2-flaniel@linux.microsoft.com>
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

On Thu, 24 Aug 2023 18:08:59 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Previously to this commit, if func matches several symbols, a kprobe, being
> either sysfs or PMU, would only be installed for the first matching address.
> This could lead to some misunderstanding when some BPF code was never called
> because it was attached to a function which was indeed not called, because
> the effectively called one has no kprobes attached.
> 
> So, this commit returns EADDRNOTAVAIL when func matches several symbols.
> This way, user needs to use address to remove the ambiguity.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/

Looks good to me!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/trace_kprobe.c | 61 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 23dba01831f7..2f393739e8cf 100644
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
> +static unsigned int number_of_same_symbols(char *func_name)
> +{
> +	unsigned int count;
> +
> +	count = 0;
> +	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
> +
> +	return count;
> +}
> +
>  static int __trace_kprobe_create(int argc, const char *argv[])
>  {
>  	/*
> @@ -836,6 +855,29 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		}
>  	}
>  
> +	if (symbol) {
> +		unsigned int count;
> +
> +		count = number_of_same_symbols(symbol);
> +		if (count > 1) {
> +			/*
> +			 * Users should use ADDR to remove the ambiguity of
> +			 * using KSYM only.
> +			 */
> +			ret = -EADDRNOTAVAIL;
> +
> +			goto error;
> +		} else if (count == 0) {
> +			/*
> +			 * We can return ENOENT earlier than when register the
> +			 * kprobe.
> +			 */
> +			ret = -ENOENT;
> +
> +			goto error;
> +		}
> +	}
> +
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1699,6 +1741,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
>  }
>  
>  #ifdef CONFIG_PERF_EVENTS
> +
>  /* create a trace_kprobe, but don't add it to global lists */
>  struct trace_event_call *
>  create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> @@ -1709,6 +1752,24 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	int ret;
>  	char *event;
>  
> +	if (func) {
> +		unsigned int count;
> +
> +		count = number_of_same_symbols(func);
> +		if (count > 1)
> +			/*
> +			 * Users should use addr to remove the ambiguity of
> +			 * using func only.
> +			 */
> +			return ERR_PTR(-EADDRNOTAVAIL);
> +		else if (count == 0)
> +			/*
> +			 * We can return ENOENT earlier than when register the
> +			 * kprobe.
> +			 */
> +			return ERR_PTR(-ENOENT);
> +	}
> +
>  	/*
>  	 * local trace_kprobes are not added to dyn_event, so they are never
>  	 * searched in find_trace_kprobe(). Therefore, there is no concern of
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
