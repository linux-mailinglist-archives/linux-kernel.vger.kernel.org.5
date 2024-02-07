Return-Path: <linux-kernel+bounces-56068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F03984C599
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312EB1C234B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF81F922;
	Wed,  7 Feb 2024 07:25:52 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF711F5F0;
	Wed,  7 Feb 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290751; cv=none; b=jFF4v8xnxZgp/Veg2e7NAAKyNnqD2rhWnLQ1YjbOX96cgltbIkwXjITzoDVvWcqookLiXURXT34mAZk6QlqHyKKjkr8slyDk70rF3KqHn6h4JCMgTPt3mJ4c2bY+IspfmTrNDqTrdbpLiZaRuUTZcXFtF/Eo0B9xWwroh1U5Qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290751; c=relaxed/simple;
	bh=O3sgm62nSGmbFRQsGxqyJmL69Gjp1V9NVkxQGdzVeqc=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iaImtbtmet1UfyU3bFS7t8z+AAD7N5FUshMbnQTIZfkfUnbb1xgjbPrAa91rZKn0qR3mR0q88xJA+r5qyRdALxGD/RdGP8rPnHwQO2MpOQSL+0gOsY0Qm6hBapTwkSHxITEhv1oGNeomx1TtHjD7q4uP8kmt94rCW9oS5BtYmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TVBTm6p8nz1vtJJ;
	Wed,  7 Feb 2024 15:25:16 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 09797140414;
	Wed,  7 Feb 2024 15:25:45 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 15:25:44 +0800
CC: <yangyicong@hisilicon.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <james.clark@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <zhanjie9@hisilicon.com>, <21cnbao@gmail.com>,
	<tim.c.chen@intel.com>, <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
Subject: Re: [RESEND v4] perf stat: Support per-cluster aggregation
To: Ian Rogers <irogers@google.com>
References: <20240206082016.22292-1-yangyicong@huawei.com>
 <CAP-5=fUaJSF1R_yDTeNwiNbm0isGTEpZSbp2m0q7BJox+TdRwg@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d8382fd2-1c0c-5041-3c0e-cd15244ef9f6@huawei.com>
Date: Wed, 7 Feb 2024 15:25:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUaJSF1R_yDTeNwiNbm0isGTEpZSbp2m0q7BJox+TdRwg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)

On 2024/2/7 1:49, Ian Rogers wrote:
> On Tue, Feb 6, 2024 at 12:24 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Some platforms have 'cluster' topology and CPUs in the cluster will
>> share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
>> cache (for Intel Jacobsville). Currently parsing and building cluster
>> topology have been supported since [1].
>>
>> perf stat has already supported aggregation for other topologies like
>> die or socket, etc. It'll be useful to aggregate per-cluster to find
>> problems like L3T bandwidth contention.
>>
>> This patch add support for "--per-cluster" option for per-cluster
>> aggregation. Also update the docs and related test. The output will
>> be like:
>>
>> [root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5
>>
>>  Performance counter stats for 'system wide':
>>
>> S56-D0-CLS158    4      1,321,521,570      LLC-load
>> S56-D0-CLS594    4        794,211,453      LLC-load
>> S56-D0-CLS1030    4             41,623      LLC-load
>> S56-D0-CLS1466    4             41,646      LLC-load
>> S56-D0-CLS1902    4             16,863      LLC-load
>> S56-D0-CLS2338    4             15,721      LLC-load
>> S56-D0-CLS2774    4             22,671      LLC-load
>> [...]
>>
>> On a legacy system without cluster or cluster support, the output will
>> be look like:
>> [root@localhost perf]# perf stat -a -e cycles --per-cluster -- sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>> S56-D0-CLS0   64         18,011,485      cycles
>> S7182-D0-CLS0   64         16,548,835      cycles
>>
>> Note that this patch doesn't mix the cluster information in the outputs
>> of --per-core to avoid breaking any tools/scripts using it.
>>
>> Note that perf recently supports "--per-cache" aggregation, but it's not
>> the same with the cluster although cluster CPUs may share some cache
>> resources. For example on my machine all clusters within a die share the
>> same L3 cache:
>> $ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
>> 0-31
>> $ cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
>> 0-3
>>
>> [1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")
>> Tested-by: Jie Zhan <zhanjie9@hisilicon.com>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 

Thanks!

>> ---
>> Change since v3:
>> - Rebase on v6.7-rc4 and resolve the conflicts
>> Link: https://lore.kernel.org/all/20230404104951.27537-1-yangyicong@huawei.com/
>>
>> Change since v2:
>> - Use 0 as cluster ID on legacy system without cluster support, keep consistenct
>>   with what --per-die does.
>> Link: https://lore.kernel.org/all/20230328112717.19573-1-yangyicong@huawei.com/
>>
>> Change since v1:
>> - Provides the information about how to map the cluster to the CPUs in the manual
>> - Thanks the review from Tim and test from Jie.
>> Link: https://lore.kernel.org/all/20230313085911.61359-1-yangyicong@huawei.com/
>>
>>  tools/perf/Documentation/perf-stat.txt        | 11 ++++
>>  tools/perf/builtin-stat.c                     | 52 +++++++++++++++++--
>>  .../tests/shell/lib/perf_json_output_lint.py  |  4 +-
>>  tools/perf/tests/shell/lib/stat_output.sh     | 12 +++++
>>  tools/perf/tests/shell/stat+csv_output.sh     |  2 +
>>  tools/perf/tests/shell/stat+json_output.sh    | 13 +++++
>>  tools/perf/tests/shell/stat+std_output.sh     |  2 +
>>  tools/perf/util/cpumap.c                      | 32 +++++++++++-
>>  tools/perf/util/cpumap.h                      | 19 +++++--
>>  tools/perf/util/env.h                         |  1 +
>>  tools/perf/util/stat-display.c                | 13 +++++
>>  tools/perf/util/stat.h                        |  1 +
>>  12 files changed, 153 insertions(+), 9 deletions(-)
>>
[...]
>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>> index 0581ee0fa5f2..5907456d42a2 100644
>> --- a/tools/perf/util/cpumap.c
>> +++ b/tools/perf/util/cpumap.c
>> @@ -222,6 +222,8 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
>>                 return a->socket - b->socket;
>>         else if (a->die != b->die)
>>                 return a->die - b->die;
>> +       else if (a->cluster != b->cluster)
>> +               return a->cluster - b->cluster;
>>         else if (a->cache_lvl != b->cache_lvl)
>>                 return a->cache_lvl - b->cache_lvl;
>>         else if (a->cache != b->cache)
>> @@ -309,6 +311,29 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
>>         return id;
>>  }
>>
>> +int cpu__get_cluster_id(struct perf_cpu cpu)
>> +{
>> +       int value, ret = cpu__get_topology_int(cpu.cpu, "cluster_id", &value);
> 
> nit: normal coding style is for a whitespace newline here.
> 

Will fix. I may referred to cpu__get_core_id() below which is an exception.

Thanks,
Yicong

