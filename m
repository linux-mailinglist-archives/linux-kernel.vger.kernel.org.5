Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233267546E5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 07:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGOFPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 01:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGOFPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 01:15:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11963A9D;
        Fri, 14 Jul 2023 22:15:35 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R2xNt5JSyz18KHx;
        Sat, 15 Jul 2023 13:14:54 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 15 Jul 2023 13:15:32 +0800
Message-ID: <d8aeab6c-338e-dcdd-75c6-7ae4eb9c9887@huawei.com>
Date:   Sat, 15 Jul 2023 13:15:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] tracing: Add free_trace_iter_content() helper
 function
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230713114510.04c452ca@gandalf.local.home>
 <20230713114700.450e7a17@gandalf.local.home>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230713114700.450e7a17@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/13 23:47, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As the trace iterator is created and used by various interfaces, the clean
> up of it needs to be consistent. Create a free_trace_iter_content() helper
> function that frees the content of the iterator and use that to clean it
> up in all places that it is used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/trace.c | 40 ++++++++++++++++++++++++++++------------
>   1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c370ffbe062..3f38250637e2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4815,6 +4815,25 @@ static const struct seq_operations tracer_seq_ops = {
>   	.show		= s_show,
>   };
>   
> +/*
> + * Note, as iter itself can be allocated and freed in different
> + * ways, this function is only used to free its content, and not
> + * the iterator itself. The only requirement to all the allocations
> + * is that it must zero all fields (kzalloc), as freeing works with
> + * ethier allocated content or NULL.
> + */
> +static void free_trace_iter_content(struct trace_iterator *iter)
> +{
> +	/* The fmt is either NULL, allocated or points to static_fmt_buf */
> +	if (iter->fmt != static_fmt_buf)
> +		kfree(iter->fmt);
> +
> +	kfree(iter->temp);
> +	kfree(iter->buffer_iter);
> +	mutex_destroy(&iter->mutex);
> +	free_cpumask_var(iter->started);
> +}
> +
>   static struct trace_iterator *
>   __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>   {
> @@ -4922,8 +4941,7 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>   
>    fail:
>   	mutex_unlock(&trace_types_lock);
> -	kfree(iter->temp);
> -	kfree(iter->buffer_iter);
> +	free_trace_iter_content(iter);
>   release:
>   	seq_release_private(inode, file);
>   	return ERR_PTR(-ENOMEM);
> @@ -5002,11 +5020,7 @@ static int tracing_release(struct inode *inode, struct file *file)
>   
>   	mutex_unlock(&trace_types_lock);
>   
> -	mutex_destroy(&iter->mutex);
> -	free_cpumask_var(iter->started);
> -	kfree(iter->fmt);
> -	kfree(iter->temp);
> -	kfree(iter->buffer_iter);
> +	free_trace_iter_content(iter);
>   	seq_release_private(inode, file);
>   
>   	return 0;
> @@ -6709,7 +6723,12 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>   	}
>   
>   	trace_seq_init(&iter->seq);
> -	iter->trace = tr->current_trace;
> +
> +	iter->trace = kzalloc(sizeof(*iter->trace), GFP_KERNEL);
> +	if (!iter->trace)
> +		goto fail;

Hi, Steve, 'ret' may need to be set before `goto fail`:
   ret = -ENOMEM;

> +
> +	*iter->trace = *tr->current_trace;
>   
>   	if (!alloc_cpumask_var(&iter->started, GFP_KERNEL)) {
>   		ret = -ENOMEM;
> @@ -6763,10 +6782,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>   
>   	mutex_unlock(&trace_types_lock);
>   
> -	free_cpumask_var(iter->started);
> -	kfree(iter->fmt);
> -	kfree(iter->temp);
> -	mutex_destroy(&iter->mutex);
> +	free_trace_iter_content(iter);
>   	kfree(iter);
>   
>   	trace_array_put(tr);

