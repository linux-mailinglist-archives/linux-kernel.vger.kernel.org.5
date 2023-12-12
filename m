Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B629980F2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbjLLQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjLLQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:34:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00A5A8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:35:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80B0C433C7;
        Tue, 12 Dec 2023 16:35:04 +0000 (UTC)
Date:   Tue, 12 Dec 2023 11:35:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yeweihua4@huawei.com>
Subject: Re: [PATCH] tracing: Fix uaf issue when open the hist or hist_debug
 file
Message-ID: <20231212113546.6a51d359@gandalf.local.home>
In-Reply-To: <20231212113317.4159890-1-zhengyejian1@huawei.com>
References: <20231212113317.4159890-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 19:33:17 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1abc07fba1b9..00447ea7dabd 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5623,10 +5623,12 @@ static int event_hist_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  
> -	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	ret = tracing_open_file_tr(inode, file);
>  	if (ret)
>  		return ret;
>  
> +	/* Clear private_data to avoid warning in single_open */
> +	file->private_data = NULL;
>  	return single_open(file, hist_show, file);
>  }
>  
> @@ -5634,7 +5636,7 @@ const struct file_operations event_hist_fops = {
>  	.open = event_hist_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = single_release,
> +	.release = tracing_release_file_tr,

single_release() still needs to be called. This can't simply be replaced
with tracing_release_file_tr().

>  };
>  
>  #ifdef CONFIG_HIST_TRIGGERS_DEBUG
> @@ -5900,10 +5902,12 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  
> -	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	ret = tracing_open_file_tr(inode, file);
>  	if (ret)
>  		return ret;
>  
> +	/* Clear private_data to avoid warning in single_open */
> +	file->private_data = NULL;
>  	return single_open(file, hist_debug_show, file);
>  }
>  
> @@ -5911,7 +5915,7 @@ const struct file_operations event_hist_debug_fops = {
>  	.open = event_hist_debug_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = single_release,
> +	.release = tracing_release_file_tr,

Same here. This just causes a leak of the single resources.

What needs to be done is to add a:

tracing_single_release_file_tr()

That does both:

int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
{
	struct trace_event_file *file = inode->i_private;

	trace_array_put(file->tr);
	event_file_put(file);

	return single_release(inode, filp);
}

-- Steve

>  };
>  #endif
>  

