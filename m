Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F3778EEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbjHaNvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjHaNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:51:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F6E47;
        Thu, 31 Aug 2023 06:51:20 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rc2b56rjKzrSXw;
        Thu, 31 Aug 2023 21:49:37 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 31 Aug 2023 21:51:18 +0800
Message-ID: <26f8fb43-6ea8-edc2-381d-3600fce261af@huawei.com>
Date:   Thu, 31 Aug 2023 21:51:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: zero the pipe cpumask on alloc to avoid spurious
 -EBUSY
Content-Language: en-US
To:     Brian Foster <bfoster@redhat.com>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <rostedt@goodmis.org>
References: <20230831125500.986862-1-bfoster@redhat.com>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230831125500.986862-1-bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/31 20:55, Brian Foster wrote:
> The pipe cpumask used to serialize opens between the main and percpu
> trace pipes is not zeroed or initialized. This can result in
> spurious -EBUSY returns if underlying memory is not fully zeroed.
> This has been observed by immediate failure to read the main
> trace_pipe file on an otherwise newly booted and idle system:
> 
>   # cat /sys/kernel/debug/tracing/trace_pipe
>   cat: /sys/kernel/debug/tracing/trace_pipe: Device or resource busy
> 
> Zero the allocation of pipe_cpumask to avoid the problem.
> 
> Fixes: c2489bb7e6be ("tracing: Introduce pipe_cpumask to avoid race on trace_pipes")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi,
> 
> I ran into this problem just recently on one of my test VMs immediately
> after updating to a v6.5 base. A revert of the aforementioned commit
> addressed the problem. I'm not terribly familiar with the tracing code,
> but on further inspection I noticed the cpumask doesn't appear to be
> initialized anywhere. I suppose this could alternatively do a
> cpumask_clear() or whatever after allocation, but either way this
> addresses the problem for me.

Yes, pipe_cpumask must be initialized.

--

Thanks,
Zheng Yejian

> 
> Please CC on replies as I'm not subscribed to the list. Thanks.
> 
> Brian
> 
>   kernel/trace/trace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8e64aaad5361..2656ca3b9b39 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9486,7 +9486,7 @@ static struct trace_array *trace_array_create(const char *name)
>   	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
>   		goto out_free_tr;
>   
> -	if (!alloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
>   		goto out_free_tr;
>   
>   	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
> @@ -10431,7 +10431,7 @@ __init static int tracer_alloc_buffers(void)
>   	if (trace_create_savedcmd() < 0)
>   		goto out_free_temp_buffer;
>   
> -	if (!alloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
>   		goto out_free_savedcmd;
>   
>   	/* TODO: make the number of buffers hot pluggable with CPUS */

