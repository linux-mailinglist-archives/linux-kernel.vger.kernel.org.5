Return-Path: <linux-kernel+bounces-145072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58C8A4F15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C81B20BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47726CDBD;
	Mon, 15 Apr 2024 12:33:55 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445D3EA7B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184435; cv=none; b=BZOAHqNNXg2u8RC+rPKAh5diVenjVd0qBPITglbxDU/ccj7UusuUh0GUsUuOmAoObZP9TLr1HMbyYGR/2gtuEhhZcG07Ur5wpgu9EuywFO6wymwIxYCTi/ya88lWWdpiqZ32tZQK93MlHvA1mDbgdWPOoUaGocQ5j4+7Pz/q+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184435; c=relaxed/simple;
	bh=cBp62E+s56Nui16EPkkeS4pd+YkHG4mqujvuBihrTjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RszDfr+uGQxWWadivlndGWlWeB2N62Y2h20M7Lo/dEynTfMwlH77D5/In1yckze4Kz/DylIvPinonLGsYscip47iOLuf8y5nJUaFqMGQSfitEKepLKryjcKt1eyjkVpLnn72KK8MBVLYURLx3PnKpYNkI53gcq8uJQGxKb0iL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJ65D4v2gz1wrP8;
	Mon, 15 Apr 2024 20:32:48 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 57469180063;
	Mon, 15 Apr 2024 20:33:46 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 20:33:45 +0800
Message-ID: <e30f3d21-6957-a5fd-d61f-44d7d52f63cb@huawei.com>
Date: Mon, 15 Apr 2024 20:33:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/3] mm: convert mm's rss stats into
 lazy_percpu_counter
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <dennisszhou@gmail.com>, <shakeelb@google.com>,
	<surenb@google.com>, <kent.overstreet@linux.dev>, <mhocko@suse.cz>,
	<vbabka@suse.cz>, <yuzhao@google.com>, <yu.ma@intel.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240412092441.3112481-1-zhangpeng362@huawei.com>
 <20240412135333.btd6e7wfprg4cmx2@quack3>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240412135333.btd6e7wfprg4cmx2@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/4/12 21:53, Jan Kara wrote:

> On Fri 12-04-24 17:24:38, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
>> percpu_counter"), the rss_stats have converted into percpu_counter,
>> which convert the error margin from (nr_threads * 64) to approximately
>> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
>> performance regression on fork/exec/shell. Even after commit
>> 14ef95be6f55 ("kernel/fork: group allocation/free of per-cpu counters
>> for mm struct"), the performance of fork/exec/shell is still poor
>> compared to previous kernel versions.
>>
>> To mitigate performance regression, we use lazy_percpu_counter[1] to
>> delay the allocation of percpu memory for rss_stats. After lmbench test,
>> we will get 3% ~ 6% performance improvement for lmbench
>> fork_proc/exec_proc/shell_proc after conversion.
>>
>> The test results are as follows:
>>
>>               base           base+revert        base+lazy_percpu_counter
>>
>> fork_proc    427.4ms        394.1ms  (7.8%)    413.9ms  (3.2%)
>> exec_proc    2205.1ms       2042.2ms (7.4%)    2072.0ms (6.0%)
>> shell_proc   3180.9ms       2963.7ms (6.8%)    3010.7ms (5.4%)
>>
>> This solution has not been fully evaluated and tested. The main idea of
>> this RFC patch series is to get the community's opinion on this approach.
> Thanks! I like the idea and in fact I wanted to do something similar (just
> never got to it). Thread [2] has couple of good observations regarding this
> problem. Couple of thoughts regarding your approach:
>
> 1) I think switching to pcpu counter when update rate exceeds 256 updates/s
> is not a great fit for RSS because the updates are going to be frequent in
> some cases but usually they will all happen from one thread. So I think it
> would make more sense to move the decision of switching to pcpu mode from
> the counter itself into the callers and just switch on clone() when the
> second thread gets created.
>
> 2) I thought that for RSS lazy percpu counters, we could directly use
> struct percpu_counter and just make it that if 'counters' is NULL, the
> counter is in atomic mode (count is used as atomic_long_t), if counters !=
> NULL, we are in pcpu mode.

Thanks for your reply!
Agree with your thoughts, I'll implement it in the next version.

> 3) In [2] Mateusz had a good observation that the old RSS counters actually
> used atomic operations only in rare cases so even lazy pcpu counters are
> going to have worse performance for singlethreaded processes than the old
> code. We could *almost* get away with non-atomic updates to counter->count
> if it was not for occasional RSS updates from unrelated tasks. So it might
> be worth it to further optimize the counters as:
>
> struct rss_counter_single {
> 	void *state;			/* To detect switching to pcpu mode */
> 	atomic_long_t counter_atomic;	/* Used for foreign updates */
> 	long counter;			/* Used by local updates */
> }
>
> struct rss_counter {
> 	union {
> 		struct rss_counter_single single;
> 		/* struct percpu_counter needs to be modified to have
> 		 * 'counters' first to avoid issues for different
> 		 * architectures or with CONFIG_HOTPLUG_CPU enabled */
> 		struct percpu_counter pcpu;
> 	}
> }
>
> But I'm not sure this complexity is worth it so I'd do it as a separate
> patch with separate benchmarking if at all.
>
> 								Honza

Agreed. Single-threaded processes don't need atomic operations, and
this scenario needs to be thoroughly tested.
I'll try to implement it in another patch series after I finish the
basic approach.

> [2] https://lore.kernel.org/all/ZOPSEJTzrow8YFix@snowbird/
>
>> [1] https://lore.kernel.org/linux-iommu/20230501165450.15352-8-surenb@google.com/
>>
>> Kent Overstreet (1):
>>    Lazy percpu counters
>>
>> ZhangPeng (2):
>>    lazy_percpu_counter: include struct percpu_counter in struct
>>      lazy_percpu_counter
>>    mm: convert mm's rss stats into lazy_percpu_counter
>>
>>   include/linux/lazy-percpu-counter.h |  88 +++++++++++++++++++
>>   include/linux/mm.h                  |   8 +-
>>   include/linux/mm_types.h            |   4 +-
>>   include/trace/events/kmem.h         |   4 +-
>>   kernel/fork.c                       |  12 +--
>>   lib/Makefile                        |   2 +-
>>   lib/lazy-percpu-counter.c           | 131 ++++++++++++++++++++++++++++
>>   7 files changed, 232 insertions(+), 17 deletions(-)
>>   create mode 100644 include/linux/lazy-percpu-counter.h
>>   create mode 100644 lib/lazy-percpu-counter.c
>>
>> -- 
>> 2.25.1
>>
-- 
Best Regards,
Peng


