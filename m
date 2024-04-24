Return-Path: <linux-kernel+bounces-156268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392EC8B008B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9531C22F60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13C13DB99;
	Wed, 24 Apr 2024 04:29:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F08F47
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932985; cv=none; b=LtkquVRY8ZMWK4OORbZ9NNStUXflL1s2VwLciQSTQ7yLPDAzw/OE2OI8f1vRhE7O6LRL/It29bBXndgX0XJKLTPfNGJNUpS2iLqoT29MVOYb2rqwTqAr+MSIc6GIghtwkaiSGNqV7LDxhw81J/hygWOHmYrRskJWOwAVVGeUEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932985; c=relaxed/simple;
	bh=q5W9H19vXmzx0UW0GfZKEuwH98Exrq5h+lk0uURqxuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E6pa8Ukoc2tfjxKgyes55BR7SanRsa+zcTEu0vWbwpendzyuf30MaJA/zAs2fgDyb/ZzUeLMPHXtXeHqDiblpuSGZ31OIuNk3zonWhDJmHb9tP7gjW/KxrH8sjJvF/Nn0OmX9JjvfbVJkPcjrR0jA9kWfcjtvt92SiNCj1nNWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPQsb1KZTzXlLL;
	Wed, 24 Apr 2024 12:26:11 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D04118007D;
	Wed, 24 Apr 2024 12:29:40 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 12:29:39 +0800
Message-ID: <0145f5db-1adf-46d1-1a2e-41230ab1e462@huawei.com>
Date: Wed, 24 Apr 2024 12:29:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2 0/2] mm: convert mm's rss stats to use atomic mode
Content-Language: en-US
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20240418142008.2775308-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/4/18 22:20, Peng Zhang wrote:

Any suggestions or opinions are welcome. Could someone please review
this patch series?
Thanks!

> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter"), the rss_stats have converted into percpu_counter,
> which convert the error margin from (nr_threads * 64) to approximately
> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
> performance regression on fork/exec/shell. Even after commit 14ef95be6f55
> ("kernel/fork: group allocation/free of per-cpu counters for mm struct"),
> the performance of fork/exec/shell is still poor compared to previous
> kernel versions.
>
> To mitigate performance regression, we delay the allocation of percpu
> memory for rss_stats. Therefore, we convert mm's rss stats to use
> percpu_counter atomic mode. For single-thread processes, rss_stat is in
> atomic mode, which reduces the memory consumption and performance
> regression caused by using percpu. For multiple-thread processes,
> rss_stat is switched to the percpu mode to reduce the error margin.
> We convert rss_stats from atomic mode to percpu mode only when the
> second thread is created.
>
> After lmbench test, we can get 2% ~ 4% performance improvement
> for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
> improvement for lmbench page_fault (before batch mode[1]).
>
> The test results are as follows:
>               base           base+revert        base+this patch
>
> fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms  (4.2%)
> exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
> shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
> page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)
>
> [1] https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/
>
> ChangeLog:
> v2->v1:
> - Convert rss_stats from atomic mode to percpu mode only when
>    the second thread is created per Jan Kara.
> - Compared with v1, the performance data may be different due to
>    different test machines.
>
> ZhangPeng (2):
>    percpu_counter: introduce atomic mode for percpu_counter
>    mm: convert mm's rss stats to use atomic mode
>
>   include/linux/mm.h             | 50 +++++++++++++++++++++++++++++-----
>   include/linux/percpu_counter.h | 43 +++++++++++++++++++++++++++--
>   include/trace/events/kmem.h    |  4 +--
>   kernel/fork.c                  | 18 +++++++-----
>   lib/percpu_counter.c           | 31 +++++++++++++++++++--
>   5 files changed, 125 insertions(+), 21 deletions(-)
>
-- 
Best Regards,
Peng


