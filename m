Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73D77D96E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 06:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbjHPE15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbjHPE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 00:27:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724FF210E;
        Tue, 15 Aug 2023 21:27:22 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQZnh3Z8tz1GDM1;
        Wed, 16 Aug 2023 12:26:00 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 12:27:20 +0800
Message-ID: <8c853c0c-84f0-c8be-3020-561db6f87081@huawei.com>
Date:   Wed, 16 Aug 2023 12:27:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: Fix memleak due to race between current_tracer
 and trace
Content-Language: en-US
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC:     <fweisbec@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230808092905.2936459-1-zhengyejian1@huawei.com>
 <32583a11-9cbd-9b4d-34be-551babed6f51@huawei.com>
In-Reply-To: <32583a11-9cbd-9b4d-34be-551babed6f51@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/16 09:45, Zheng Yejian wrote:
> On 2023/8/8 17:29, Zheng Yejian wrote:
>> Kmemleak report a leak in graph_trace_open():
>>
>>    unreferenced object 0xffff0040b95f4a00 (size 128):
>>      comm "cat", pid 204981, jiffies 4301155872 (age 99771.964s)
>>      hex dump (first 32 bytes):
>>        e0 05 e7 b4 ab 7d 00 00 0b 00 01 00 00 00 00 00 .....}..........
>>        f4 00 01 10 00 a0 ff ff 00 00 00 00 65 00 10 00 ............e...
>>      backtrace:
>>        [<000000005db27c8b>] kmem_cache_alloc_trace+0x348/0x5f0
>>        [<000000007df90faa>] graph_trace_open+0xb0/0x344
>>        [<00000000737524cd>] __tracing_open+0x450/0xb10
>>        [<0000000098043327>] tracing_open+0x1a0/0x2a0
>>        [<00000000291c3876>] do_dentry_open+0x3c0/0xdc0
>>        [<000000004015bcd6>] vfs_open+0x98/0xd0
>>        [<000000002b5f60c9>] do_open+0x520/0x8d0
>>        [<00000000376c7820>] path_openat+0x1c0/0x3e0
>>        [<00000000336a54b5>] do_filp_open+0x14c/0x324
>>        [<000000002802df13>] do_sys_openat2+0x2c4/0x530
>>        [<0000000094eea458>] __arm64_sys_openat+0x130/0x1c4
>>        [<00000000a71d7881>] el0_svc_common.constprop.0+0xfc/0x394
>>        [<00000000313647bf>] do_el0_svc+0xac/0xec
>>        [<000000002ef1c651>] el0_svc+0x20/0x30
>>        [<000000002fd4692a>] el0_sync_handler+0xb0/0xb4
>>        [<000000000c309c35>] el0_sync+0x160/0x180
>>
>> The root cause is descripted as follows:
>>
>>    __tracing_open() {  // 1. File 'trace' is being opened;
>>      ...
>>      *iter->trace = *tr->current_trace;  // 2. Tracer 'function_graph' is
>>                                          //    currently set;
>>      ...
>>      iter->trace->open(iter);  // 3. Call graph_trace_open() here,
>>                                //    and memory are allocated in it;
>>      ...
>>    }
>>
>>    s_start() {  // 4. The opened file is being read;
>>      ...
>>      *iter->trace = *tr->current_trace;  // 5. If tracer is switched to
>>                                          //    'nop' or others, then 
>> memory
>>                                          //    in step 3 are leaked!!!
>>      ...
>>    }
>>
>> To fix it, in s_start(), close tracer before switching then reopen the
>> new tracer after switching.
>>
>> Fixes: d7350c3f4569 ("tracing/core: make the read callbacks reentrants")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/trace/trace.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index b8870078ef58..d50a0227baa3 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -4213,8 +4213,15 @@ static void *s_start(struct seq_file *m, loff_t 
>> *pos)
>>        * will point to the same string as current_trace->name.
>>        */
>>       mutex_lock(&trace_types_lock);
>> -    if (unlikely(tr->current_trace && iter->trace->name != 
>> tr->current_trace->name))
>> +    if (unlikely(tr->current_trace && iter->trace->name != 
>> tr->current_trace->name)) {
>> +        /* Close iter->trace before switching to the new current 
>> tracer */
>> +        if (iter->trace->close)
>> +            iter->trace->close(iter);
> 
> Hi, kasan report an issue related to this patch in v5.10, I'll handle
> it and then send V2 if the patch needs to be changed.
> 
>    BUG: KASAN: use-after-free in graph_trace_close+0x78/0x7c
>    Read of size 8 at addr ffff204054ca8f00 by task cat/193541
>    [...]
>    Call trace:
>     dump_backtrace+0x0/0x3e4
>     show_stack+0x20/0x2c
>     dump_stack+0x140/0x198
>     print_address_description.constprop.0+0x2c/0x1fc
>     __kasan_report+0xe0/0x140
>     kasan_report+0x44/0x5c
>     __asan_report_load8_noabort+0x34/0x60
>     graph_trace_close+0x78/0x7c
>     wakeup_trace_close+0x3c/0x54
>     s_start+0x4f4/0x794
>     seq_read_iter+0x210/0xd90
>     seq_read+0x288/0x410
>     vfs_read+0x13c/0x41c
>     ksys_read+0xf4/0x1e0
>     __arm64_sys_read+0x74/0xa4
>     el0_svc_common.constprop.0+0xfc/0x394
>     do_el0_svc+0xac/0xec
>     el0_svc+0x20/0x30
>     el0_sync_handler+0xb0/0xb4
>     el0_sync+0x160/0x180
> 
>    Allocated by task 193541:
>     kasan_save_stack+0x28/0x60
>     __kasan_kmalloc.constprop.0+0xa4/0xd0
>     kasan_kmalloc+0x10/0x20
>     kmem_cache_alloc_trace+0x2ec/0x5f0
>     graph_trace_open+0xb0/0x344
>     __tracing_open+0x450/0xb10
>     tracing_open+0x1a0/0x2a0
>     do_dentry_open+0x3c0/0xdc0
>     vfs_open+0x98/0xd0
>     do_open+0x520/0x8d0
> 

The root cause should be that:
   1. As __tracing_open() being called, function graph tracer is set,
      then graph_trace_open() is called;
   2. As s_start() being called, switch to wakeup tracer, then
      graph_trace_close() is called, here 'iter->private' is not cleared.
      Then wakeup_trace_open() is called, and if graph_trace_open() is
      not called by it due to is_graph(iter->tr) returns false;
   3. As next time s_start() being called, if tracer switched again then
      wakeup_trace_close() is called and it mistakenly close the
      'iter->private' in step 2 which finally causes kasan do the report.

So we may also need to set 'iter->private' to be NULL in
graph_trace_close(), I'll send v2 soon.

--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1244,6 +1244,7 @@ void graph_trace_close(struct trace_iterator *iter)
         if (data) {
                 free_percpu(data->cpu_data);
                 kfree(data);
+               iter->private = NULL;
         }
  }

-- Zheng Yejian

>>           *iter->trace = *tr->current_trace;
>> +        /* Reopen the new current tracer */
>> +        if (iter->trace->open)
>> +            iter->trace->open(iter);
>> +    }
>>       mutex_unlock(&trace_types_lock);
>>   #ifdef CONFIG_TRACER_MAX_TRACE
> 
> 

