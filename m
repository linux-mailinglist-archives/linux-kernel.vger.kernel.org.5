Return-Path: <linux-kernel+bounces-139641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5D8A05A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BC128757D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F81626CB;
	Thu, 11 Apr 2024 01:48:49 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AE23BF;
	Thu, 11 Apr 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800128; cv=none; b=WwKB0axrncp5Yy4CaMwP7omrwzc7mYSVjN4CvpUQ86ner7DVvHzduHmC68jj9aZB4gK/409GhKNOgylWpKQnhiPH6ICu7BWM+y3LqV1SS8o0Hqo+kZnWGpDSsFK4TPTJF4Q7Iv3Lxk/LKZD5056o9ZMAqI17I/O3cqMTosBnmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800128; c=relaxed/simple;
	bh=N4j2LsCt6jsQg4mJYqpEIoEwMWFBhNHEMtvgTrBl+5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dRcdEL206CR4Dk8kzewb9FamkMhVhEP/t4TuwC3TnuBfindg0hTkmFxDWGg2bY1QUmLSa9W8sNu24q7dQaI1+XXTJ7XZl5wJ+R5DaFDbGmJwD9gd+HDnsYVExVIMr/9Z+o+8cZr3HstyWxcZrRZxw2mdlPRFaaFOMCRS8UNi7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VFMyj57fzz1wr2Z;
	Thu, 11 Apr 2024 09:47:41 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F44C1400D9;
	Thu, 11 Apr 2024 09:48:37 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 09:48:37 +0800
Message-ID: <781a6c75-2783-c459-1b82-c85419898a17@huawei.com>
Date: Thu, 11 Apr 2024 09:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ftrace: Fix use-after-free issue in ftrace_location()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20240401125543.1282845-1-zhengyejian1@huawei.com>
 <20240410112823.1d084c8f@gandalf.local.home>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20240410112823.1d084c8f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/4/10 23:28, Steven Rostedt wrote:
> On Mon, 1 Apr 2024 20:55:43 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> KASAN reports a bug:
>>
>>    BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
>>    Read of size 8 at addr ffff888141d40010 by task insmod/424
>>    CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+ #213
>>    [...]
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0x68/0xa0
>>     print_report+0xcf/0x610
>>     kasan_report+0xb5/0xe0
>>     ftrace_location+0x90/0x120
>>     register_kprobe+0x14b/0xa40
>>     kprobe_init+0x2d/0xff0 [kprobe_example]
>>     do_one_initcall+0x8f/0x2d0
>>     do_init_module+0x13a/0x3c0
>>     load_module+0x3082/0x33d0
>>     init_module_from_file+0xd2/0x130
>>     __x64_sys_finit_module+0x306/0x440
>>     do_syscall_64+0x68/0x140
>>     entry_SYSCALL_64_after_hwframe+0x71/0x79
>>
>> The root cause is that when lookup_rec() is lookuping ftrace record of
>> an address in some module, and at the same time in ftrace_release_mod(),
>> the memory that saving ftrace records has been freed as that module is
>> being deleted.
>>
>>    register_kprobes() {
>>      check_kprobe_address_safe() {
>>        arch_check_ftrace_location() {
>>          ftrace_location() {
>>            lookup_rec()  // access memory that has been freed by
>>                          // ftrace_release_mod() !!!
>>
>> It seems that the ftrace_lock is required when lookuping records in
>> ftrace_location(), so is ftrace_location_range().
>>
>> Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
>> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
>> ---
>>   kernel/trace/ftrace.c | 28 ++++++++++++++++++----------
>>   1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index da1710499698..838d175709c1 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -1581,7 +1581,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>>   }
>>   
>>   /**
>> - * ftrace_location_range - return the first address of a traced location
>> + * ftrace_location_range_locked - return the first address of a traced location
>>    *	if it touches the given ip range
>>    * @start: start of range to search.
>>    * @end: end of range to search (inclusive). @end points to the last byte
>> @@ -1592,7 +1592,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>>    * that is either a NOP or call to the function tracer. It checks the ftrace
>>    * internal tables to determine if the address belongs or not.
>>    */
>> -unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>> +static unsigned long ftrace_location_range_locked(unsigned long start, unsigned long end)
>>   {
>>   	struct dyn_ftrace *rec;
>>   
>> @@ -1603,6 +1603,17 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>>   	return 0;
>>   }
>>   
>> +unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>> +{
>> +	unsigned long loc;
>> +
>> +	mutex_lock(&ftrace_lock);
>> +	loc = ftrace_location_range_locked(start, end);
>> +	mutex_unlock(&ftrace_lock);
> 
> I'm not so sure we can take a mutex in all places that call this function.
> 
> What about using RCU?
> 
> 	rcu_read_lock();
> 	loc = ftrace_location_range_rcu(start, end);
> 	rcu_read_unlock();
> 
> Then in ftrace_release_mod() we can have:
> 
>   out_unlock:
> 	mutex_unlock();
> 
> 	/* Need to synchronize with ftrace_location() */
> 	if (tmp_pages)
> 		synchronize_rcu();
> 
> -- Steve

Yes, it is better to use RCU, I'll do it in v2.

--
Thanks
Zheng Yejian

> 
> 
>> +
>> +	return loc;
>> +}
>> +
>>   /**
>>    * ftrace_location - return the ftrace location
>>    * @ip: the instruction pointer to check
>> @@ -1614,25 +1625,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>>    */
>>   unsigned long ftrace_location(unsigned long ip)
>>   {
>> -	struct dyn_ftrace *rec;
>> +	unsigned long loc;
>>   	unsigned long offset;
>>   	unsigned long size;
>>   
>> -	rec = lookup_rec(ip, ip);
>> -	if (!rec) {
>> +	loc = ftrace_location_range(ip, ip);
>> +	if (!loc) {
>>   		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
>>   			goto out;
>>   
>>   		/* map sym+0 to __fentry__ */
>>   		if (!offset)
>> -			rec = lookup_rec(ip, ip + size - 1);
>> +			loc = ftrace_location_range(ip, ip + size - 1);
>>   	}
>>   
>> -	if (rec)
>> -		return rec->ip;
>> -
>>   out:
>> -	return 0;
>> +	return loc;
>>   }
>>   
>>   /**
> 


