Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71976778FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjHKMhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:37:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012310C;
        Fri, 11 Aug 2023 05:37:10 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMjtQ1Cm0zTmYh;
        Fri, 11 Aug 2023 20:35:10 +0800 (CST)
Received: from [10.67.110.218] (10.67.110.218) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 20:37:08 +0800
Message-ID: <f7af687f-2376-fede-fa22-f776811c48f1@huawei.com>
Date:   Fri, 11 Aug 2023 20:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read
 trace_pipe
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <rostedt@goodmis.org>, <laijs@cn.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
 <20230811204257.99df8ba60d591f5bace38615@kernel.org>
From:   Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20230811204257.99df8ba60d591f5bace38615@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.218]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/11 19:42, Masami Hiramatsu (Google) wrote:
> On Thu, 10 Aug 2023 20:39:05 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> When concurrently splice_read file trace_pipe and per_cpu/cpu*/trace_pipe,
>> there are more data being read out than expected.
>>
>> The root cause is that in tracing_splice_read_pipe(), an entry is found
>> outside locks, it may be read by multiple readers or consumed by other
>> reader as starting printing it.
>>
>> To fix it, change to find entry after holding locks.
>>
>> Fixes: 7e53bd42d14c ("tracing: Consolidate protection of reader access to the ring buffer")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/trace/trace.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index b8870078ef58..f169d33b948f 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -7054,14 +7054,16 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>>   	if (ret <= 0)
>>   		goto out_err;
>>   
>> -	if (!iter->ent && !trace_find_next_entry_inc(iter)) {
>> +	trace_event_read_lock();
>> +	trace_access_lock(iter->cpu_file);
>> +
>> +	if (!trace_find_next_entry_inc(iter)) {
> 
> It seems you skips '!iter->ent' check. Is there any reason for this change?

IIUC, 'iter->ent' may be the entry that was found but not consumed
in last call tracing_splice_read_pipe(), and in this call, 'iter->ent'
may have being consumed, so we may should find a new 'iter->ent' before
printing it in tracing_fill_pipe_page(), see following reduced codes:

   tracing_splice_read_pipe() {
     if (!iter->ent && !trace_find_next_entry_inc(iter)) {  // 1. find 
entry here
         ... ...
     }
     tracing_fill_pipe_page() {
       for (;;) {
         ... ...
         ret = print_trace_line(iter);  // 2. print entry
         ... ...
         if (!trace_find_next_entry_inc()) {  // 3. find next entry
           ... ...
           break;
         }
       }

--

Thanks,
Zheng Yejian

> 
> Thank you,
> 
>> +		trace_access_unlock(iter->cpu_file);
>> +		trace_event_read_unlock();
>>   		ret = -EFAULT;
>>   		goto out_err;
>>   	}
>>   
>> -	trace_event_read_lock();
>> -	trace_access_lock(iter->cpu_file);
>> -
>>   	/* Fill as many pages as possible. */
>>   	for (i = 0, rem = len; i < spd.nr_pages_max && rem; i++) {
>>   		spd.pages[i] = alloc_page(GFP_KERNEL);
>> -- 
>> 2.25.1
>>
> 
> 

