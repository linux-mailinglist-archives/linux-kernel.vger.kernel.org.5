Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035776798A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjG2A3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG2A3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F098210CB;
        Fri, 28 Jul 2023 17:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84F866221A;
        Sat, 29 Jul 2023 00:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70385C433C7;
        Sat, 29 Jul 2023 00:29:36 +0000 (UTC)
Date:   Fri, 28 Jul 2023 20:29:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix warning in trace_buffered_event_disable()
Message-ID: <20230728202934.0203ccb7@rorschach.local.home>
In-Reply-To: <20230726095804.920457-1-zhengyejian1@huawei.com>
References: <20230726095804.920457-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 17:58:04 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Warning happened in trace_buffered_event_disable() at
>   WARN_ON_ONCE(!trace_buffered_event_ref)
> 
>   Call Trace:
>    ? __warn+0xa5/0x1b0
>    ? trace_buffered_event_disable+0x189/0x1b0
>    __ftrace_event_enable_disable+0x19e/0x3e0
>    free_probe_data+0x3b/0xa0
>    unregister_ftrace_function_probe_func+0x6b8/0x800
>    event_enable_func+0x2f0/0x3d0
>    ftrace_process_regex.isra.0+0x12d/0x1b0
>    ftrace_filter_write+0xe6/0x140
>    vfs_write+0x1c9/0x6f0
>    [...]
> 
> The cause of the warning is in __ftrace_event_enable_disable(),
> trace_buffered_event_enable() was called once while
> trace_buffered_event_disable() was called twice.
> Reproduction script show as below, for analysis, see the comments:
>  ```
>  #!/bin/bash
> 
>  cd /sys/kernel/tracing/
> 
>  # 1. Register a 'disable_event' command, then:
>  #    1) SOFT_DISABLED_BIT was set;
>  #    2) trace_buffered_event_enable() was called first time;
>  echo 'cmdline_proc_show:disable_event:initcall:initcall_finish' > \
>      set_ftrace_filter
> 
>  # 2. Enable the event registered, then:
>  #    1) SOFT_DISABLED_BIT was cleared;
>  #    2) trace_buffered_event_disable() was called first time;
>  echo 1 > events/initcall/initcall_finish/enable
> 
>  # 3. Try to call into cmdline_proc_show(), then SOFT_DISABLED_BIT was
>  #    set again!!!
>  cat /proc/cmdline
> 
>  # 4. Unregister the 'disable_event' command, then:
>  #    1) SOFT_DISABLED_BIT was cleared again;
>  #    2) trace_buffered_event_disable() was called second time!!!
>  echo '!cmdline_proc_show:disable_event:initcall:initcall_finish' > \
>      set_ftrace_filter
>  ```
> 
> To fix it, IIUC, we can change to call trace_buffered_event_enable() at
> fist time soft-mode enabled, and call trace_buffered_event_disable() at
> last time soft-mode disabled.
> 

This looks right. I thought I was being safe by ignoring all that crazy
logic and just doing the compare at the end. Perhaps checking SOFT_MODE
instead of SOFT_DISABLE was the way to go. But I think this works too.

-- Steve


> Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/trace_events.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 5d6ae4eae510..578f1f7d49a6 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -611,7 +611,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  {
>  	struct trace_event_call *call = file->event_call;
>  	struct trace_array *tr = file->tr;
> -	unsigned long file_flags = file->flags;
>  	int ret = 0;
>  	int disable;
>  
> @@ -635,6 +634,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  				break;
>  			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
>  			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
> +			/* Disable use of trace_buffered_event */
> +			trace_buffered_event_disable();
>  		} else
>  			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
>  
> @@ -673,6 +674,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  			if (atomic_inc_return(&file->sm_ref) > 1)
>  				break;
>  			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
> +			/* Enable use of trace_buffered_event */
> +			trace_buffered_event_enable();
>  		}
>  
>  		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
> @@ -712,15 +715,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  		break;
>  	}
>  
> -	/* Enable or disable use of trace_buffered_event */
> -	if ((file_flags & EVENT_FILE_FL_SOFT_DISABLED) !=
> -	    (file->flags & EVENT_FILE_FL_SOFT_DISABLED)) {
> -		if (file->flags & EVENT_FILE_FL_SOFT_DISABLED)
> -			trace_buffered_event_enable();
> -		else
> -			trace_buffered_event_disable();
> -	}
> -
>  	return ret;
>  }
>  

