Return-Path: <linux-kernel+bounces-132721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF749899946
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31F7B21577
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296C415FD05;
	Fri,  5 Apr 2024 09:17:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86315F31D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308648; cv=none; b=YxCK92dgkSd2bk0c/BjpsC5/qth9UrBB+VKdSvs1fA+pZkfEaefHYQA4amPVWqbNo2qg8JksYqXRAeKrNPdxBuDSNCkqQrRakbT+i0j8Mh0DxNmiMiIMY6JvGD26Oh2Lhxlc+7wG9V/IBiTkjdzS/AwCXdgX/FIQn4pGcjFriPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308648; c=relaxed/simple;
	bh=jRuRyU8skw5nXFDFIhbz+jtOVhngSn/6xq8P5ODa4I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nD7BS/5Ja3Wv3YT7XwVJ6fLYINstd3e0n1+FIuKnSIAjqC+TG59X8DGkMFLNd6xyBWBwaoKixsZKnPR/DYyK82QEwzZo3+/Ur0scWZC7Fw7fGpLE41J4JX44pEtoXnL/ci8JLLyLFwEWg6pGIFvDO8N1jGazL+LY97KZOYb6fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F70FFEC;
	Fri,  5 Apr 2024 02:17:56 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D063F64C;
	Fri,  5 Apr 2024 02:17:24 -0700 (PDT)
Message-ID: <3bf726af-e519-4cc2-a692-19a0cf99fca7@arm.com>
Date: Fri, 5 Apr 2024 11:17:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] sched/fair: allow disabling sched_balance_newidle
 with sched_relax_domain_level
Content-Language: en-US
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <cover.1712147341.git.vitaly@bursov.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <cover.1712147341.git.vitaly@bursov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 15:28, Vitalii Bursov wrote:
> Changes in v3:
> - Remove levels table change from the documentation patch
> - Link to v2: https://lore.kernel.org/lkml/cover.1711900396.git.vitaly@bursov.com/
> Changes in v2:
> - Split debug.c change in a separate commit and move new "level"
> after "groups_flags"
> - Added "Fixes" tag and updated commit message
> - Update domain levels cgroup-v1/cpusets.rst documentation
> - Link to v1: https://lore.kernel.org/all/cover.1711584739.git.vitaly@bursov.com/
> 
> During the upgrade from Linux 5.4 we found a small (around 3%) 
> performance regression which was tracked to commit 
> c5b0a7eefc70150caf23e37bc9d639c68c87a097
> 
>     sched/fair: Remove sysctl_sched_migration_cost condition
> 
>     With a default value of 500us, sysctl_sched_migration_cost is
>     significanlty higher than the cost of load_balance. Remove the
>     condition and rely on the sd->max_newidle_lb_cost to abort
>     newidle_balance.
> 
> Looks like "newidle" balancing is beneficial for a lot of workloads, 
> just not for this specific one. The workload is video encoding, there 
> are 100s-1000s of threads, some are synchronized with mutexes and 
> conditional variables. The process aims to have a portion of CPU idle, 
> so no CPU cores are 100% busy. Perhaps, the performance impact we see 
> comes from additional processing in the scheduler and additional cost 
> like more cache misses, and not from an incorrect balancing. See
> perf output below.
> 
> My understanding is that "sched_relax_domain_level" cgroup parameter 
> should control if sched_balance_newidle() is called and what's the scope
> of the balancing is, but it doesn't fully work for this case.
> 
> cpusets.rst documentation:
>> The 'cpuset.sched_relax_domain_level' file allows you to request changing
>> this searching range as you like.  This file takes int value which
>> indicates size of searching range in levels ideally as follows,
>> otherwise initial value -1 that indicates the cpuset has no request.
>>  
>> ====== ===========================================================
>>   -1   no request. use system default or follow request of others.
>>    0   no search.
>>    1   search siblings (hyperthreads in a core).
>>    2   search cores in a package.
>>    3   search cpus in a node [= system wide on non-NUMA system]
>>    4   search nodes in a chunk of node [on NUMA system]
>>    5   search system wide [on NUMA system]
>> ====== ===========================================================

IMHO, this list misses: 

      2   search cores in a cluster.

Related to CONFIG_SCHED_CLUSTER.
Like you mentioned, if CONFIG_SCHED_CLUSTER is not configured MC becomes
level=1.

I ran this on an Arm64 TaiShan 2280 v2, Kunpeng 920 - 4826 server:

$ numactl -H | tail -6
node distances:
node   0   1   2   3 
  0:  10  12  20  22 
  1:  12  10  22  24 
  2:  20  22  10  12 
  3:  22  24  12  10

$ head -8 /proc/schedstat | awk '{ print $1 " " $2 }' | tail -5
domain0 00000000,00000000,0000000f
domain1 00000000,00000000,00ffffff
domain2 00000000,0000ffff,ffffffff
domain3 000000ff,ffffffff,ffffffff
domain4 ffffffff,ffffffff,ffffffff

with additional debug:

[   18.196484] build_sched_domain() cpu=0 name=SMT level=0
[   18.202308] build_sched_domain() cpu=0 name=CLS level=1
[   18.208188] build_sched_domain() cpu=0 name=MC level=2
[   18.222550] build_sched_domain() cpu=0 name=PKG level=3
[   18.228371] build_sched_domain() cpu=0 name=NODE level=4
[   18.234515] build_sched_domain() cpu=0 name=NUMA level=5
[   18.246400] build_sched_domain() cpu=0 name=NUMA level=6
[   18.258841] build_sched_domain() cpu=0 name=NUMA level=7

/* search cores in a cluster */
# echo 2 > /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level

# grep . /sys/kernel/debug/sched/domains/cpu0/*/{name,flags,level}
/sys/kernel/debug/sched/domains/cpu0/domain0/name:CLS
/sys/kernel/debug/sched/domains/cpu0/domain1/name:MC
/sys/kernel/debug/sched/domains/cpu0/domain2/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain3/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain4/name:NUMA
/sys/kernel/debug/sched/domains/cpu0/domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_CLUSTER SD_SHARE_LLC SD_PREFER_SIBLING 
/sys/kernel/debug/sched/domains/cpu0/domain1/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING 
/sys/kernel/debug/sched/domains/cpu0/domain2/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
/sys/kernel/debug/sched/domains/cpu0/domain3/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
/sys/kernel/debug/sched/domains/cpu0/domain4/flags:SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
/sys/kernel/debug/sched/domains/cpu0/domain0/level:1
/sys/kernel/debug/sched/domains/cpu0/domain1/level:2
/sys/kernel/debug/sched/domains/cpu0/domain2/level:5
/sys/kernel/debug/sched/domains/cpu0/domain3/level:6
/sys/kernel/debug/sched/domains/cpu0/domain4/level:7

LGTM.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
 
> Setting cpuset.sched_relax_domain_level to 0 works as 1.
> 
> On a dual-CPU server, domains and levels are as follows:
>   domain 0: level 0, SMT
>   domain 1: level 2, MC

This is with CONFIG_SCHED_CLUSTER=y ?

[...]

