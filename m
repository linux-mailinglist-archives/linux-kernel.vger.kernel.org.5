Return-Path: <linux-kernel+bounces-58292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76884E424
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABB9287A70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE707C0AF;
	Thu,  8 Feb 2024 15:40:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6679940
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406840; cv=none; b=GkYiQQxURRjuowHMElJKDTq7+RRGhRNuDkuSNAgaRw2Dy7SvI6OgkzBsLRf9i1FsN97PZKco4/NnE3fEDBfCBXzqzru9JPMBmtimOAnMAHDrzFxGiuduCTa8wftUrpBI3nGQHVWEs9IS+CIxrPHN6yTEPU5umH1QcubbOKflGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406840; c=relaxed/simple;
	bh=tTBsg0G/Gw4HHORe59sPAuxqCX7z11HvovIoywwd1x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5QvIEbYi1naIab11Bp4k6uGIMzJgBs5wuVt4wMHzIkWDa6iDYDtC8XlEf6sxli8H0l5UnoqWvph17u7QuQ/26IQT5IkIDTIILlU6xlLuMC7YCskU1zZ+E3cY0kowZzgdkqEpHLkCzuJVZ1UuspNsKTJskojLy5iCtPivVw1L3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 856491FB;
	Thu,  8 Feb 2024 07:41:18 -0800 (PST)
Received: from [10.1.38.186] (XHFQ2J9959.cambridge.arm.com [10.1.38.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18903F64C;
	Thu,  8 Feb 2024 07:40:34 -0800 (PST)
Message-ID: <fd1adcc1-ed9b-44f8-b884-e7d0aa5e40b2@arm.com>
Date: Thu, 8 Feb 2024 15:40:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] 96204e1531: will-it-scale.per_thread_ops
 -3.9% regression
Content-Language: en-GB
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Yang Shi <shy828301@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
 linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com
References: <202402081435.c3faa4b4-oliver.sang@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202402081435.c3faa4b4-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/02/2024 07:36, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -3.9% regression of will-it-scale.per_thread_ops on:

Hi,

I've tried reproducing this on x86_64, but I see fluctuations of +/- 5% between
runs without changing the kernel, when running the page_fault1 test. So I'm not
sure a -3.9% regression is real?

The fingered change is actually a fix for a functional bug, so I'm not sure we
should be preferring performance over correctness anyway :)

I'm not planning to do anything further here, unless someone shouts that there
is a real problem.

> 
> 
> commit: 96204e15310c218fd9355bdcacd02fed1d18070e ("mm: thp_get_unmapped_area must honour topdown preference")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: will-it-scale
> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> parameters:
> 
> 	test: page_fault1
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202402081435.c3faa4b4-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240208/202402081435.c3faa4b4-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-2sp4/page_fault1/will-it-scale
> 
> commit: 
>   4ef9ad19e1 ("mm: huge_memory: don't force huge page alignment on 32 bit")
>   96204e1531 ("mm: thp_get_unmapped_area must honour topdown preference")
> 

I don't really understand the below table. Is a positive or negative change
better? There appear to be tests with much more fluctuation than the reported
page_fault1 test. Are these real?

Thanks,
Ryan

> 4ef9ad19e17676b9 96204e15310c218fd9355bdcacd 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      32.93            -3.5       29.43        mpstat.cpu.all.sys%
>      77.89 ï¿½  2%     -10.2%      69.98        vmstat.procs.r
>       4678           +14.0%       5332        vmstat.system.cs
>     251960            -3.4%     243306        vmstat.system.in
>       1049           -10.2%     943.00        turbostat.Avg_MHz
>      36.22            -3.7       32.54        turbostat.Busy%
>      29.10            +1.8       30.87        turbostat.C1E%
>       0.35           +15.7%       0.40        turbostat.CPU%c6
>     565.62            -2.3%     552.53        turbostat.PkgWatt
>     123847           -18.4%     101096        meminfo.Active
>     123657           -18.3%     101000        meminfo.Active(anon)
>    8127530           +10.3%    8966990        meminfo.AnonHugePages
>    8298705           +10.3%    9156780        meminfo.AnonPages
>    8417195           +10.1%    9267954        meminfo.Inactive
>    8416461           +10.1%    9267742        meminfo.Inactive(anon)
>     138121           -16.9%     114720        meminfo.Shmem
>    4852175 ï¿½  2%      +9.2%    5296708        numa-meminfo.node0.AnonHugePages
>    4941270 ï¿½  2%      +9.0%    5387476        numa-meminfo.node0.AnonPages
>     121571           -18.9%      98652        numa-meminfo.node1.Active
>     121528           -18.9%      98620        numa-meminfo.node1.Active(anon)
>    3270590           +12.4%    3674514        numa-meminfo.node1.AnonHugePages
>    3352686           +12.6%    3773824        numa-meminfo.node1.AnonPages
>    3395079           +12.4%    3815833        numa-meminfo.node1.Inactive
>    3394971           +12.4%    3815762        numa-meminfo.node1.Inactive(anon)
>     125041           -18.4%     102036        numa-meminfo.node1.Shmem
>    1219136 ï¿½  2%     +10.3%    1344427        numa-vmstat.node0.nr_anon_pages
>       2337           +10.4%       2581        numa-vmstat.node0.nr_anon_transparent_hugepages
>    1237208 ï¿½  2%     +10.1%    1362084        numa-vmstat.node0.nr_inactive_anon
>    1236994 ï¿½  2%     +10.1%    1362125        numa-vmstat.node0.nr_zone_inactive_anon
>      30361           -18.8%      24656        numa-vmstat.node1.nr_active_anon
>     828422           +13.5%     940280        numa-vmstat.node1.nr_anon_pages
>       1577           +13.3%       1788        numa-vmstat.node1.nr_anon_transparent_hugepages
>     838873           +13.3%     950629 ï¿½  2%  numa-vmstat.node1.nr_inactive_anon
>      31244           -18.4%      25510        numa-vmstat.node1.nr_shmem
>      30361           -18.8%      24656        numa-vmstat.node1.nr_zone_active_anon
>     838696           +13.4%     950674 ï¿½  2%  numa-vmstat.node1.nr_zone_inactive_anon
>      30907           -18.4%      25233        proc-vmstat.nr_active_anon
>    2068862           +11.0%    2295458        proc-vmstat.nr_anon_pages
>       3957           +11.0%       4390        proc-vmstat.nr_anon_transparent_hugepages
>    2099316           +10.6%    2322543        proc-vmstat.nr_inactive_anon
>       7379            +4.4%       7701        proc-vmstat.nr_page_table_pages
>      34526           -17.0%      28665        proc-vmstat.nr_shmem
>      30907           -18.4%      25233        proc-vmstat.nr_zone_active_anon
>    2099307           +10.6%    2322537        proc-vmstat.nr_zone_inactive_anon
>      26039 ï¿½ 10%     -16.4%      21774 ï¿½  6%  proc-vmstat.numa_hint_faults_local
>   51127959            -3.7%   49228917        proc-vmstat.numa_hit
>   50891640            -3.7%   48994322        proc-vmstat.numa_local
>      32315           -21.8%      25269        proc-vmstat.pgactivate
>  1.265e+10            -3.8%  1.217e+10        proc-vmstat.pgalloc_normal
>   25947640            -3.6%   25012103        proc-vmstat.pgfault
>  1.265e+10            -3.8%  1.217e+10        proc-vmstat.pgfree
>   24650837            -3.8%   23717158        proc-vmstat.thp_fault_alloc
>   44754589           -15.5%   37839290        will-it-scale.112.threads
>      74.20           +11.2%      82.49        will-it-scale.112.threads_idle
>   36349325            -6.0%   34182802        will-it-scale.168.threads
>      72.79           +11.7%      81.28        will-it-scale.168.threads_idle
>   40356275            -5.6%   38083547        will-it-scale.224.threads
>      66.97           +19.5%      80.06        will-it-scale.224.threads_idle
>   28146956           -15.5%   23782499        will-it-scale.56.threads
>      78.16            +8.4%      84.70        will-it-scale.56.threads_idle
>     795871            -3.9%     764972        will-it-scale.per_thread_ops
>      67103            -4.9%      63834        will-it-scale.time.involuntary_context_switches
>   17508243 ï¿½  4%      +6.9%   18724480        will-it-scale.time.maximum_resident_set_size
>   22382078            -3.6%   21577203        will-it-scale.time.minor_page_faults
>       7050            -7.3%       6534        will-it-scale.time.percent_of_cpu_this_job_got
>      20998            -7.4%      19448        will-it-scale.time.system_time
>       1075            -3.3%       1040        will-it-scale.time.user_time
>     236326           +40.3%     331522        will-it-scale.time.voluntary_context_switches
>  4.056e+08            -3.9%  3.899e+08        will-it-scale.workload
>    5880710            -9.8%    5305863        sched_debug.cfs_rq:/.avg_vruntime.avg
>   10300738 ï¿½  2%     -11.0%    9163982 ï¿½  2%  sched_debug.cfs_rq:/.avg_vruntime.max
>    1772532 ï¿½  6%     -15.5%    1498526 ï¿½  4%  sched_debug.cfs_rq:/.avg_vruntime.min
>    2066050           -12.1%    1817081        sched_debug.cfs_rq:/.avg_vruntime.stddev
>     321.14 ï¿½ 36%     -63.9%     115.93 ï¿½ 57%  sched_debug.cfs_rq:/.load_avg.avg
>       1945 ï¿½ 20%     -47.8%       1015 ï¿½ 50%  sched_debug.cfs_rq:/.load_avg.stddev
>    5880710            -9.8%    5305863        sched_debug.cfs_rq:/.min_vruntime.avg
>   10300738 ï¿½  2%     -11.0%    9163982 ï¿½  2%  sched_debug.cfs_rq:/.min_vruntime.max
>    1772532 ï¿½  6%     -15.5%    1498526 ï¿½  4%  sched_debug.cfs_rq:/.min_vruntime.min
>    2066050           -12.1%    1817081        sched_debug.cfs_rq:/.min_vruntime.stddev
>     233.57 ï¿½  8%     -24.3%     176.83 ï¿½  3%  sched_debug.cfs_rq:/.runnable_avg.avg
>     958.36 ï¿½  4%      -9.2%     870.11 ï¿½  3%  sched_debug.cfs_rq:/.runnable_avg.max
>     240.06 ï¿½  5%     -20.4%     190.99 ï¿½  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
>     232.74 ï¿½  9%     -24.3%     176.20 ï¿½  3%  sched_debug.cfs_rq:/.util_avg.avg
>     238.62 ï¿½  5%     -20.4%     189.97 ï¿½  5%  sched_debug.cfs_rq:/.util_avg.stddev
>     134.97 ï¿½ 20%     -46.6%      72.12 ï¿½  9%  sched_debug.cfs_rq:/.util_est.avg
>     211.62 ï¿½  7%     -30.9%     146.18 ï¿½  3%  sched_debug.cfs_rq:/.util_est.stddev
>      85860 ï¿½  4%     +20.2%     103165 ï¿½  4%  sched_debug.cpu.avg_idle.stddev
>       2360 ï¿½ 15%     -32.2%       1600 ï¿½  6%  sched_debug.cpu.curr->pid.avg
>       4127 ï¿½  5%     -11.4%       3655 ï¿½  2%  sched_debug.cpu.curr->pid.stddev
>       0.18 ï¿½ 13%     -30.8%       0.13 ï¿½  5%  sched_debug.cpu.nr_running.avg
>       0.35 ï¿½  3%     -11.4%       0.31        sched_debug.cpu.nr_running.stddev
>       4008           +10.9%       4445        sched_debug.cpu.nr_switches.avg
>       0.25 ï¿½  9%     +22.4%       0.31 ï¿½  2%  sched_debug.cpu.nr_uninterruptible.avg
>     234.42           +10.7%     259.59        perf-stat.i.MPKI
>  1.038e+09            -2.6%  1.012e+09        perf-stat.i.branch-instructions
>       0.45            +0.0        0.47        perf-stat.i.branch-miss-rate%
>  1.192e+09            +4.1%  1.241e+09        perf-stat.i.cache-misses
>  1.307e+09            +3.2%  1.349e+09        perf-stat.i.cache-references
>       4550           +15.1%       5238        perf-stat.i.context-switches
>      37.73           -11.3%      33.45        perf-stat.i.cpi
>  2.282e+11           -10.6%  2.041e+11        perf-stat.i.cpu-cycles
>     395.06            -4.0%     379.37        perf-stat.i.cycles-between-cache-misses
>       0.08            -0.0        0.07        perf-stat.i.dTLB-load-miss-rate%
>     957972           -11.5%     848218        perf-stat.i.dTLB-load-misses
>  1.142e+09            -2.6%  1.112e+09        perf-stat.i.dTLB-loads
>    4327055            -3.0%    4195482        perf-stat.i.dTLB-store-misses
>  9.982e+08            -3.2%   9.66e+08        perf-stat.i.dTLB-stores
>  5.057e+09            -2.7%   4.92e+09        perf-stat.i.instructions
>       0.08            +4.6%       0.09        perf-stat.i.ipc
>       1.02           -10.5%       0.91        perf-stat.i.metric.GHz
>     245.40            -1.7%     241.21        perf-stat.i.metric.K/sec
>      19.83            -1.0%      19.63        perf-stat.i.metric.M/sec
>      81125            -3.9%      77994        perf-stat.i.minor-faults
>    9961580            -4.6%    9501596        perf-stat.i.node-loads
>      81127            -3.9%      77996        perf-stat.i.page-faults
>     239.06            +6.3%     254.04        perf-stat.overall.MPKI
>       0.41            +0.0        0.42        perf-stat.overall.branch-miss-rate%
>      45.33            -7.8%      41.81        perf-stat.overall.cpi
>     189.64           -13.2%     164.59        perf-stat.overall.cycles-between-cache-misses
>       0.09            -0.0        0.08        perf-stat.overall.dTLB-load-miss-rate%
>       0.02            +8.4%       0.02        perf-stat.overall.ipc
>       3930            +1.4%       3987        perf-stat.overall.path-length
>  1.044e+09            -2.5%  1.017e+09        perf-stat.ps.branch-instructions
>  1.215e+09            +3.5%  1.257e+09        perf-stat.ps.cache-misses
>  1.329e+09            +2.7%  1.365e+09        perf-stat.ps.cache-references
>       4559           +14.8%       5231        perf-stat.ps.context-switches
>  2.304e+11           -10.2%  2.069e+11        perf-stat.ps.cpu-cycles
>     977167           -11.5%     864759        perf-stat.ps.dTLB-load-misses
>  1.146e+09            -2.5%  1.117e+09        perf-stat.ps.dTLB-loads
>    4393673            -3.1%    4258515        perf-stat.ps.dTLB-store-misses
>  1.006e+09            -3.2%  9.745e+08        perf-stat.ps.dTLB-stores
>  5.082e+09            -2.6%  4.948e+09        perf-stat.ps.instructions
>      82026            -3.8%      78940        perf-stat.ps.minor-faults
>   10075965            -4.4%    9629094        perf-stat.ps.node-loads
>      82028            -3.8%      78942        perf-stat.ps.page-faults
>  1.594e+12            -2.5%  1.555e+12        perf-stat.total.instructions
>      82.91            -2.8       80.13        perf-profile.calltrace.cycles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
>      94.27            -1.2       93.10        perf-profile.calltrace.cycles-pp.testcase
>      92.74            -1.2       91.59        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
>      92.76            -1.1       91.62        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
>      92.82            -1.1       91.69        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
>      92.82            -1.1       91.69        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
>      94.24            -1.0       93.19        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
>      90.44            -1.0       89.46        perf-profile.calltrace.cycles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>      90.76            -0.9       89.81        perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       0.59 ï¿½  2%      -0.2        0.34 ï¿½ 70%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page
>       1.98            -0.2        1.77        perf-profile.calltrace.cycles-pp.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
>       1.98            -0.2        1.76        perf-profile.calltrace.cycles-pp.vma_alloc_folio.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
>       1.80            -0.2        1.60        perf-profile.calltrace.cycles-pp.prep_compound_page.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.vma_alloc_folio
>       1.85            -0.2        1.65        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_huge_pmd_anonymous_page.__handle_mm_fault
>       1.84            -0.2        1.64        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_mpol.vma_alloc_folio.do_huge_pmd_anonymous_page
>       1.85            -0.2        1.66        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.vma_alloc_folio.do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
>       0.98            -0.1        0.84        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault
>       1.33            -0.1        1.28        perf-profile.calltrace.cycles-pp.free_unref_page_prepare.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu
>       1.51            -0.0        1.46        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
>       1.47            -0.0        1.43        perf-profile.calltrace.cycles-pp.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>       1.38            -0.0        1.33        perf-profile.calltrace.cycles-pp.free_unref_page.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region
>       1.46            -0.0        1.42        perf-profile.calltrace.cycles-pp.release_pages.tlb_batch_pages_flush.tlb_finish_mmu.unmap_region.do_vmi_align_munmap
>       1.64            -0.0        1.60        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
>       0.78 ï¿½  3%      +0.2        0.96        perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.64            +0.2        0.82 ï¿½  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.82 ï¿½  3%      +0.3        1.12 ï¿½  4%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
>       0.84 ï¿½  3%      +0.3        1.16 ï¿½  4%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
>       0.26 ï¿½100%      +0.4        0.70        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       1.26 ï¿½  5%      +0.5        1.74 ï¿½  5%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       1.40 ï¿½  4%      +0.5        1.92 ï¿½  4%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       3.45            +0.9        4.35        perf-profile.calltrace.cycles-pp.__cond_resched.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
>       2.75            +1.0        3.70 ï¿½  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       2.88            +1.0        3.87 ï¿½  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       3.08            +1.0        4.12 ï¿½  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.12            +1.1        4.18 ï¿½  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.12            +1.1        4.18 ï¿½  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       3.12            +1.1        4.18 ï¿½  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       3.15            +1.1        4.22 ï¿½  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>      84.16            -2.9       81.22        perf-profile.children.cycles-pp.clear_page_erms
>      92.75            -1.2       91.60        perf-profile.children.cycles-pp.__handle_mm_fault
>      92.77            -1.1       91.63        perf-profile.children.cycles-pp.handle_mm_fault
>      94.98            -1.1       93.84        perf-profile.children.cycles-pp.testcase
>      92.83            -1.1       91.70        perf-profile.children.cycles-pp.do_user_addr_fault
>      92.83            -1.1       91.70        perf-profile.children.cycles-pp.exc_page_fault
>      93.55            -1.1       92.47        perf-profile.children.cycles-pp.asm_exc_page_fault
>      90.13            -1.0       89.13        perf-profile.children.cycles-pp.clear_huge_page
>      90.76            -0.9       89.81        perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
>       1.98            -0.2        1.77        perf-profile.children.cycles-pp.do_huge_pmd_anonymous_page
>       1.98            -0.2        1.76        perf-profile.children.cycles-pp.vma_alloc_folio
>       1.80            -0.2        1.60        perf-profile.children.cycles-pp.prep_compound_page
>       1.88            -0.2        1.69        perf-profile.children.cycles-pp.get_page_from_freelist
>       1.94            -0.2        1.76        perf-profile.children.cycles-pp.__alloc_pages
>       1.94            -0.2        1.76        perf-profile.children.cycles-pp.alloc_pages_mpol
>       0.38            -0.1        0.25 ï¿½  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function
>       1.38            -0.0        1.33        perf-profile.children.cycles-pp.free_unref_page_prepare
>       1.51            -0.0        1.46        perf-profile.children.cycles-pp.tlb_finish_mmu
>       1.39            -0.0        1.34        perf-profile.children.cycles-pp.free_unref_page
>       1.47            -0.0        1.42        perf-profile.children.cycles-pp.release_pages
>       1.47            -0.0        1.43        perf-profile.children.cycles-pp.tlb_batch_pages_flush
>       1.64            -0.0        1.60        perf-profile.children.cycles-pp.unmap_region
>       0.21 ï¿½  3%      -0.0        0.18 ï¿½  3%  perf-profile.children.cycles-pp.task_tick_fair
>       0.12 ï¿½  3%      -0.0        0.10 ï¿½  4%  perf-profile.children.cycles-pp.folio_prep_large_rmappable
>       0.09 ï¿½  4%      +0.0        0.10 ï¿½  4%  perf-profile.children.cycles-pp.free_tail_page_prepare
>       0.17 ï¿½  2%      +0.0        0.19 ï¿½  3%  perf-profile.children.cycles-pp.pte_alloc_one
>       0.17 ï¿½  4%      +0.0        0.19        perf-profile.children.cycles-pp.perf_rotate_context
>       0.06 ï¿½ 11%      +0.0        0.08 ï¿½  8%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.06 ï¿½  7%      +0.0        0.08 ï¿½  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.06 ï¿½  8%      +0.0        0.08 ï¿½  6%  perf-profile.children.cycles-pp.clockevents_program_event
>       0.12 ï¿½  4%      +0.0        0.14 ï¿½  3%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>       0.16 ï¿½  4%      +0.0        0.18 ï¿½  3%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.08 ï¿½  4%      +0.0        0.10 ï¿½  4%  perf-profile.children.cycles-pp.find_busiest_group
>       0.08 ï¿½  6%      +0.0        0.10 ï¿½  4%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.05            +0.0        0.08 ï¿½  8%  perf-profile.children.cycles-pp.__schedule
>       0.11 ï¿½  3%      +0.0        0.14 ï¿½  3%  perf-profile.children.cycles-pp.load_balance
>       0.17 ï¿½  8%      +0.0        0.21 ï¿½  3%  perf-profile.children.cycles-pp.menu_select
>       0.01 ï¿½223%      +0.0        0.06 ï¿½  6%  perf-profile.children.cycles-pp.native_sched_clock
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.irqtime_account_irq
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.run_rebalance_domains
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.rwsem_optimistic_spin
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_blocked_averages
>       0.00            +0.1        0.05 ï¿½  7%  perf-profile.children.cycles-pp.__mmap
>       0.00            +0.1        0.05 ï¿½  7%  perf-profile.children.cycles-pp.vm_mmap_pgoff
>       0.00            +0.1        0.06 ï¿½  8%  perf-profile.children.cycles-pp.lapic_next_deadline
>       0.11 ï¿½  4%      +0.1        0.17 ï¿½  4%  perf-profile.children.cycles-pp.rebalance_domains
>       0.00            +0.1        0.06 ï¿½ 11%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.00            +0.1        0.06 ï¿½  6%  perf-profile.children.cycles-pp.down_write_killable
>       0.00            +0.1        0.06 ï¿½  6%  perf-profile.children.cycles-pp.read_tsc
>       0.00            +0.1        0.06 ï¿½  6%  perf-profile.children.cycles-pp.schedule
>       0.79 ï¿½  4%      +0.1        0.87 ï¿½  3%  perf-profile.children.cycles-pp.tick_nohz_highres_handler
>       0.19 ï¿½  3%      +0.1        0.27 ï¿½  3%  perf-profile.children.cycles-pp.__do_softirq
>       0.21 ï¿½  3%      +0.1        0.31 ï¿½  3%  perf-profile.children.cycles-pp.irq_exit_rcu
>       0.00            +0.1        0.10 ï¿½  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
>       1.17            +0.1        1.29        perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.79 ï¿½  3%      +0.2        0.97        perf-profile.children.cycles-pp.intel_idle_xstate
>       0.50 ï¿½  3%      +0.2        0.70        perf-profile.children.cycles-pp.intel_idle
>       1.45 ï¿½  2%      +0.2        1.67 ï¿½  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       1.48 ï¿½  2%      +0.2        1.73 ï¿½  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       2.50 ï¿½  2%      +0.4        2.89 ï¿½  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       1.94 ï¿½  4%      +0.4        2.35 ï¿½  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       3.60            +0.9        4.50        perf-profile.children.cycles-pp.__cond_resched
>       2.91            +1.0        3.90 ï¿½  2%  perf-profile.children.cycles-pp.cpuidle_enter
>       2.90            +1.0        3.90 ï¿½  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       3.11            +1.0        4.15 ï¿½  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
>       3.12            +1.1        4.18 ï¿½  2%  perf-profile.children.cycles-pp.start_secondary
>       3.15            +1.1        4.22 ï¿½  2%  perf-profile.children.cycles-pp.cpu_startup_entry
>       3.15            +1.1        4.22 ï¿½  2%  perf-profile.children.cycles-pp.do_idle
>       3.15            +1.1        4.22 ï¿½  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>      83.46            -2.9       80.61        perf-profile.self.cycles-pp.clear_page_erms
>       1.79            -0.2        1.59        perf-profile.self.cycles-pp.prep_compound_page
>       1.30            -0.1        1.25        perf-profile.self.cycles-pp.free_unref_page_prepare
>       0.12 ï¿½  3%      -0.0        0.10 ï¿½  4%  perf-profile.self.cycles-pp.folio_prep_large_rmappable
>       0.05            +0.0        0.06 ï¿½  7%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.06 ï¿½ 11%      +0.0        0.08 ï¿½  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.12 ï¿½  4%      +0.0        0.14 ï¿½  3%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>       0.16 ï¿½  4%      +0.0        0.18 ï¿½  3%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.07 ï¿½  6%      +0.0        0.10 ï¿½  5%  perf-profile.self.cycles-pp.menu_select
>       0.20 ï¿½  3%      +0.0        0.25 ï¿½  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
>       0.00            +0.1        0.06 ï¿½  8%  perf-profile.self.cycles-pp.lapic_next_deadline
>       0.00            +0.1        0.06 ï¿½  6%  perf-profile.self.cycles-pp.native_sched_clock
>       0.00            +0.1        0.06 ï¿½ 13%  perf-profile.self.cycles-pp._raw_spin_trylock
>       0.00            +0.1        0.06 ï¿½  9%  perf-profile.self.cycles-pp.read_tsc
>       0.78 ï¿½  3%      +0.2        0.97        perf-profile.self.cycles-pp.intel_idle_xstate
>       0.50 ï¿½  3%      +0.2        0.70        perf-profile.self.cycles-pp.intel_idle
>       2.93            +0.9        3.83        perf-profile.self.cycles-pp.__cond_resched
>       2.59            +1.0        3.61        perf-profile.self.cycles-pp.clear_huge_page
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 


