Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5337E1A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKFGkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjKFGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:40:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198D0F2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699252845; x=1730788845;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WUsSuhljzBJYBGdO1GTpha4nnC+McT8OEbZ/SD4iCaU=;
  b=S+U85XJav2dy5/olHmYEfFeVs2aMoepL76IfjICT1Z0UMKWJbPSe9meD
   Gi53RoWr6wLx+qhzOUHhPk9qs0fM45PAU+sg+9n1xN5dKOcnLuYOgtcUO
   2ODR+17cRLrj3eUoGXD+w3n9ykY5p76YROjhP5+8Vc/dDotkhZgLOKhHj
   xmShd5Dh68K+uBxapyfq51V22zHY/yfktfb9DuYWGqG4dLiNodgwAFEFY
   JdmXMmS8sOMjJmYcplP4pBdsshu77VhO4NZgylQk9gw5OrHCkvXvT3T1R
   pxeRsaP8hpa6omFzKfeocIdSP2gBvmRp5zR+aNRNY/0lmgvn9BgECQ336
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379609333"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="379609333"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="879341309"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="879341309"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:40:38 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        Arjan Van De Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -V3 3/9] mm, pcp: reduce lock contention for draining
 high-order pages
In-Reply-To: <202311061311.8d63998-oliver.sang@intel.com> (kernel test robot's
        message of "Mon, 6 Nov 2023 14:22:50 +0800")
References: <202311061311.8d63998-oliver.sang@intel.com>
Date:   Mon, 06 Nov 2023 14:38:37 +0800
Message-ID: <87ttpzv11u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot <oliver.sang@intel.com> writes:

> hi, Huang Ying,
>
> sorry for late of this report.
> we reported
> "a 14.6% improvement of netperf.Throughput_Mbps"
> in
> https://lore.kernel.org/all/202310271441.71ce0a9-oliver.sang@intel.com/
>
> later, our auto-bisect tool captured a regression on a netperf test with
> different configurations, however, unfortunately, regarded it as 'reported'
> so we missed this report at the first time.
>
> now send again FYI.
>
>
> Hello,
>
> kernel test robot noticed a -60.4% regression of netperf.Throughput_Mbps on:
>
>
> commit: f5ddc662f07d7d99e9cfc5e07778e26c7394caf8 ("[PATCH -V3 3/9] mm, pcp: reduce lock contention for draining high-order pages")
> url: https://github.com/intel-lab-lkp/linux/commits/Huang-Ying/mm-pcp-avoid-to-drain-PCP-when-process-exit/20231017-143633
> base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git 36b2d7dd5a8ac95c8c1e69bdc93c4a6e2dc28a23
> patch link: https://lore.kernel.org/all/20231016053002.756205-4-ying.huang@intel.com/
> patch subject: [PATCH -V3 3/9] mm, pcp: reduce lock contention for draining high-order pages
>
> testcase: netperf
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> parameters:
>
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 50%
> 	cluster: cs-localhost
> 	test: UDP_STREAM
> 	cpufreq_governor: performance
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202311061311.8d63998-oliver.sang@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20231106/202311061311.8d63998-oliver.sang@intel.com
>
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
>   cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/50%/debian-11.1-x86_64-20220510.cgz/300s/lkp-icl-2sp2/UDP_STREAM/netperf
>
> commit: 
>   c828e65251 ("cacheinfo: calculate size of per-CPU data cache slice")
>   f5ddc662f0 ("mm, pcp: reduce lock contention for draining high-order pages")
>
> c828e65251502516 f5ddc662f07d7d99e9cfc5e0777 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       7321   4%     +28.2%       9382        uptime.idle
>      50.65   4%      -4.0%      48.64        boot-time.boot
>       6042   4%      -4.2%       5785        boot-time.idle
>  1.089e+09   2%    +232.1%  3.618e+09        cpuidle..time
>    1087075   2%  +24095.8%   2.63e+08        cpuidle..usage
>    3357014           +99.9%    6710312        vmstat.memory.cache
>      48731  19%   +4666.5%    2322787        vmstat.system.cs
>     144637          +711.2%    1173334        vmstat.system.in
>       2.59   2%      +6.2        8.79        mpstat.cpu.all.idle%
>       1.01            +0.7        1.66        mpstat.cpu.all.irq%
>       6.00            -3.2        2.79        mpstat.cpu.all.soft%
>       1.13   2%      -0.1        1.02        mpstat.cpu.all.usr%
>  1.407e+09   3%     -28.2%  1.011e+09        numa-numastat.node0.local_node
>  1.407e+09   3%     -28.2%   1.01e+09        numa-numastat.node0.numa_hit
>  1.469e+09   8%     -32.0%  9.979e+08        numa-numastat.node1.local_node
>  1.469e+09   8%     -32.1%  9.974e+08        numa-numastat.node1.numa_hit
>     103.00  19%     -44.0%      57.67  20%  perf-c2c.DRAM.local
>       8970  12%     -89.4%     951.00   4%  perf-c2c.DRAM.remote
>       8192   5%     +68.5%      13807        perf-c2c.HITM.local
>       6675  11%     -92.6%     491.00   2%  perf-c2c.HITM.remote
>    1051014   2%  +24922.0%   2.63e+08        turbostat.C1
>       2.75   2%      +6.5        9.29        turbostat.C1%
>       2.72   2%    +178.3%       7.57        turbostat.CPU%c1
>       0.09           -22.2%       0.07        turbostat.IPC
>   44589125          +701.5%  3.574e+08        turbostat.IRQ
>     313.00  57%   +1967.0%       6469   8%  turbostat.POLL
>      70.33            +3.3%      72.67        turbostat.PkgTmp
>      44.23   4%     -31.8%      30.15   2%  turbostat.RAMWatt
>     536096          +583.7%    3665194        meminfo.Active
>     535414          +584.4%    3664543        meminfo.Active(anon)
>    3238301          +103.2%    6579677        meminfo.Cached
>    1204424          +278.9%    4563575        meminfo.Committed_AS
>     469093           +47.9%     693889   3%  meminfo.Inactive
>     467250           +48.4%     693496   3%  meminfo.Inactive(anon)
>      53615          +562.5%     355225   4%  meminfo.Mapped
>    5223078           +64.1%    8571212        meminfo.Memused
>     557305          +599.6%    3899111        meminfo.Shmem
>    5660207           +58.9%    8993642        meminfo.max_used_kB
>      78504   3%     -30.1%      54869        netperf.ThroughputBoth_Mbps
>    5024292   3%     -30.1%    3511666        netperf.ThroughputBoth_total_Mbps
>       7673   5%    +249.7%      26832        netperf.ThroughputRecv_Mbps
>     491074   5%    +249.7%    1717287        netperf.ThroughputRecv_total_Mbps
>      70831   2%     -60.4%      28037        netperf.Throughput_Mbps
>    4533217   2%     -60.4%    1794379        netperf.Throughput_total_Mbps

This is a UDP test.  So the sender will not wait for receiver.  In the
result, you can find that the sender throughput reduces 60.4%, while the
receiver throughput increases 249.7%.  And, much less packets are
dropped during the test, and this is good too.

All in all, considering the performance of both the sender and the
receiver, I think the patch helps the performance.

--
Best Regards,
Huang, Ying

>       5439            +9.4%       5949        netperf.time.percent_of_cpu_this_job_got
>      16206            +9.4%      17728        netperf.time.system_time
>     388.14           -51.9%     186.53        netperf.time.user_time
>  2.876e+09   3%     -30.1%   2.01e+09        netperf.workload
>     177360  30%     -36.0%     113450  20%  numa-meminfo.node0.AnonPages
>     255926  12%     -40.6%     152052  12%  numa-meminfo.node0.AnonPages.max
>      22582  61%    +484.2%     131916  90%  numa-meminfo.node0.Mapped
>     138287  17%     +22.6%     169534  12%  numa-meminfo.node1.AnonHugePages
>     267468  20%     +29.1%     345385   6%  numa-meminfo.node1.AnonPages
>     346204  18%     +34.5%     465696   2%  numa-meminfo.node1.AnonPages.max
>     279416  19%     +77.0%     494652  18%  numa-meminfo.node1.Inactive
>     278445  19%     +77.6%     494393  18%  numa-meminfo.node1.Inactive(anon)
>      31726  45%    +607.7%     224533  45%  numa-meminfo.node1.Mapped
>       4802   6%     +19.4%       5733   3%  numa-meminfo.node1.PageTables
>     297323  12%    +792.6%    2653850  63%  numa-meminfo.node1.Shmem
>      44325  30%     -36.0%      28379  20%  numa-vmstat.node0.nr_anon_pages
>       5590  61%    +491.0%      33042  90%  numa-vmstat.node0.nr_mapped
>  1.407e+09   3%     -28.2%   1.01e+09        numa-vmstat.node0.numa_hit
>  1.407e+09   3%     -28.2%  1.011e+09        numa-vmstat.node0.numa_local
>      66858  20%     +29.2%      86385   6%  numa-vmstat.node1.nr_anon_pages
>      69601  20%     +77.8%     123729  18%  numa-vmstat.node1.nr_inactive_anon
>       7953  45%    +608.3%      56335  45%  numa-vmstat.node1.nr_mapped
>       1201   6%     +19.4%       1434   3%  numa-vmstat.node1.nr_page_table_pages
>      74288  11%    +792.6%     663111  63%  numa-vmstat.node1.nr_shmem
>      69601  20%     +77.8%     123728  18%  numa-vmstat.node1.nr_zone_inactive_anon
>  1.469e+09   8%     -32.1%  9.974e+08        numa-vmstat.node1.numa_hit
>  1.469e+09   8%     -32.0%  9.979e+08        numa-vmstat.node1.numa_local
>     133919          +584.2%     916254        proc-vmstat.nr_active_anon
>     111196            +3.3%     114828        proc-vmstat.nr_anon_pages
>    5602484            -1.5%    5518799        proc-vmstat.nr_dirty_background_threshold
>   11218668            -1.5%   11051092        proc-vmstat.nr_dirty_threshold
>     809646          +103.2%    1645012        proc-vmstat.nr_file_pages
>   56374629            -1.5%   55536913        proc-vmstat.nr_free_pages
>     116775           +48.4%     173349   3%  proc-vmstat.nr_inactive_anon
>      13386   2%    +563.3%      88793   4%  proc-vmstat.nr_mapped
>       2286            +6.5%       2434        proc-vmstat.nr_page_table_pages
>     139393          +599.4%     974869        proc-vmstat.nr_shmem
>      29092            +6.6%      31019        proc-vmstat.nr_slab_reclaimable
>     133919          +584.2%     916254        proc-vmstat.nr_zone_active_anon
>     116775           +48.4%     173349   3%  proc-vmstat.nr_zone_inactive_anon
>      32135  11%    +257.2%     114797  21%  proc-vmstat.numa_hint_faults
>      20858  16%    +318.3%      87244   6%  proc-vmstat.numa_hint_faults_local
>  2.876e+09   3%     -30.2%  2.008e+09        proc-vmstat.numa_hit
>  2.876e+09   3%     -30.2%  2.008e+09        proc-vmstat.numa_local
>      25453   7%     -75.2%       6324  30%  proc-vmstat.numa_pages_migrated
>     178224   2%     +76.6%     314680   7%  proc-vmstat.numa_pte_updates
>     160889   3%    +267.6%     591393   6%  proc-vmstat.pgactivate
>  2.295e+10   3%     -30.2%  1.601e+10        proc-vmstat.pgalloc_normal
>    1026605           +21.9%    1251671        proc-vmstat.pgfault
>  2.295e+10   3%     -30.2%  1.601e+10        proc-vmstat.pgfree
>      25453   7%     -75.2%       6324  30%  proc-vmstat.pgmigrate_success
>      39208   2%      -6.1%      36815        proc-vmstat.pgreuse
>    3164416           -20.3%    2521344   2%  proc-vmstat.unevictable_pgs_scanned
>   19248627           -22.1%   14989905        sched_debug.cfs_rq:/.avg_vruntime.avg
>   20722680           -24.9%   15569530        sched_debug.cfs_rq:/.avg_vruntime.max
>   17634233           -22.5%   13663168        sched_debug.cfs_rq:/.avg_vruntime.min
>     949063   2%     -70.5%     280388        sched_debug.cfs_rq:/.avg_vruntime.stddev
>       0.78  10%    -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_running.min
>       0.16   8%    +113.3%       0.33   2%  sched_debug.cfs_rq:/.h_nr_running.stddev
>       0.56 141%  +2.2e+07%     122016  52%  sched_debug.cfs_rq:/.left_vruntime.avg
>      45.01 141%  +2.2e+07%   10035976  28%  sched_debug.cfs_rq:/.left_vruntime.max
>       4.58 141%  +2.3e+07%    1072762  36%  sched_debug.cfs_rq:/.left_vruntime.stddev
>       5814  10%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
>       5.39   9%     -73.2%       1.44  10%  sched_debug.cfs_rq:/.load_avg.min
>   19248627           -22.1%   14989905        sched_debug.cfs_rq:/.min_vruntime.avg
>   20722680           -24.9%   15569530        sched_debug.cfs_rq:/.min_vruntime.max
>   17634233           -22.5%   13663168        sched_debug.cfs_rq:/.min_vruntime.min
>     949063   2%     -70.5%     280388        sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.78  10%    -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
>       0.06   8%    +369.2%       0.30   3%  sched_debug.cfs_rq:/.nr_running.stddev
>       4.84  26%   +1611.3%      82.79  67%  sched_debug.cfs_rq:/.removed.load_avg.avg
>      27.92  12%   +3040.3%     876.79  68%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>       0.56 141%  +2.2e+07%     122016  52%  sched_debug.cfs_rq:/.right_vruntime.avg
>      45.06 141%  +2.2e+07%   10035976  28%  sched_debug.cfs_rq:/.right_vruntime.max
>       4.59 141%  +2.3e+07%    1072762  36%  sched_debug.cfs_rq:/.right_vruntime.stddev
>     900.25           -10.4%     806.45        sched_debug.cfs_rq:/.runnable_avg.avg
>     533.28   4%     -87.0%      69.56  39%  sched_debug.cfs_rq:/.runnable_avg.min
>     122.77   2%     +92.9%     236.86        sched_debug.cfs_rq:/.runnable_avg.stddev
>     896.13           -10.8%     799.44        sched_debug.cfs_rq:/.util_avg.avg
>     379.06   4%     -83.4%      62.94  37%  sched_debug.cfs_rq:/.util_avg.min
>     116.35   8%     +99.4%     232.04        sched_debug.cfs_rq:/.util_avg.stddev
>     550.87           -14.2%     472.66   2%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>       1124   8%     +18.2%       1329   3%  sched_debug.cfs_rq:/.util_est_enqueued.max
>     134.17  30%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
>     558243   6%     -66.9%     184666        sched_debug.cpu.avg_idle.avg
>      12860  11%     -56.1%       5644        sched_debug.cpu.avg_idle.min
>     365635           -53.5%     169863   5%  sched_debug.cpu.avg_idle.stddev
>       9.56   3%     -28.4%       6.84   8%  sched_debug.cpu.clock.stddev
>       6999   2%     -85.6%       1007   3%  sched_debug.cpu.clock_task.stddev
>       3985  10%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
>     491.71  10%    +209.3%       1520   4%  sched_debug.cpu.curr->pid.stddev
>     270.19 141%   +1096.6%       3233  51%  sched_debug.cpu.max_idle_balance_cost.stddev
>       0.78  10%    -100.0%       0.00        sched_debug.cpu.nr_running.min
>       0.15   6%    +121.7%       0.34   2%  sched_debug.cpu.nr_running.stddev
>      62041  15%   +4280.9%    2717948        sched_debug.cpu.nr_switches.avg
>    1074922  14%    +292.6%    4220307   2%  sched_debug.cpu.nr_switches.max
>       1186   2%  +1.2e+05%    1379073   4%  sched_debug.cpu.nr_switches.min
>     132392  21%    +294.6%     522476   5%  sched_debug.cpu.nr_switches.stddev
>       6.44   4%     +21.4%       7.82  12%  sched_debug.cpu.nr_uninterruptible.stddev
>       6.73  13%     -84.8%       1.02   5%  perf-stat.i.MPKI
>  1.652e+10   2%     -22.2%  1.285e+10        perf-stat.i.branch-instructions
>       0.72            +0.0        0.75        perf-stat.i.branch-miss-rate%
>   1.19e+08   3%     -19.8%   95493630        perf-stat.i.branch-misses
>      27.46  12%     -26.2        1.30   4%  perf-stat.i.cache-miss-rate%
>  5.943e+08  10%     -88.6%   67756219   5%  perf-stat.i.cache-misses
>  2.201e+09          +143.7%  5.364e+09        perf-stat.i.cache-references
>      48911  19%   +4695.4%    2345525        perf-stat.i.context-switches
>       3.66   2%     +28.5%       4.71        perf-stat.i.cpi
>  3.228e+11            -4.1%  3.097e+11        perf-stat.i.cpu-cycles
>     190.51         +1363.7%       2788  10%  perf-stat.i.cpu-migrations
>     803.99   6%    +510.2%       4905   5%  perf-stat.i.cycles-between-cache-misses
>       0.00  16%      +0.0        0.01  14%  perf-stat.i.dTLB-load-miss-rate%
>     755654  18%    +232.4%    2512024  14%  perf-stat.i.dTLB-load-misses
>  2.385e+10   2%     -26.9%  1.742e+10        perf-stat.i.dTLB-loads
>       0.00  31%      +0.0        0.01  35%  perf-stat.i.dTLB-store-miss-rate%
>     305657  36%    +200.0%     916822  35%  perf-stat.i.dTLB-store-misses
>  1.288e+10   2%     -28.8%  9.179e+09        perf-stat.i.dTLB-stores
>  8.789e+10   2%     -25.2%  6.578e+10        perf-stat.i.instructions
>       0.28   2%     -21.6%       0.22        perf-stat.i.ipc
>       2.52            -4.1%       2.42        perf-stat.i.metric.GHz
>     873.89  12%     -67.0%     288.04   8%  perf-stat.i.metric.K/sec
>     435.61   2%     -19.6%     350.06        perf-stat.i.metric.M/sec
>       2799           +29.9%       3637   2%  perf-stat.i.minor-faults
>      99.74            -2.6       97.11        perf-stat.i.node-load-miss-rate%
>  1.294e+08  12%     -92.4%    9879207   7%  perf-stat.i.node-load-misses
>      76.55           +16.4       92.92        perf-stat.i.node-store-miss-rate%
>  2.257e+08  10%     -90.4%   21721672   8%  perf-stat.i.node-store-misses
>   69217511  13%     -97.7%    1625810   7%  perf-stat.i.node-stores
>       2799           +29.9%       3637   2%  perf-stat.i.page-faults
>       6.79  13%     -84.9%       1.03   5%  perf-stat.overall.MPKI
>       0.72            +0.0        0.74        perf-stat.overall.branch-miss-rate%
>      27.06  12%     -25.8        1.26   4%  perf-stat.overall.cache-miss-rate%
>       3.68   2%     +28.1%       4.71        perf-stat.overall.cpi
>     549.38  10%    +736.0%       4592   5%  perf-stat.overall.cycles-between-cache-misses
>       0.00  18%      +0.0        0.01  14%  perf-stat.overall.dTLB-load-miss-rate%
>       0.00  36%      +0.0        0.01  35%  perf-stat.overall.dTLB-store-miss-rate%
>       0.27   2%     -22.0%       0.21        perf-stat.overall.ipc
>      99.80            -2.4       97.37        perf-stat.overall.node-load-miss-rate%
>      76.60           +16.4       93.03        perf-stat.overall.node-store-miss-rate%
>       9319            +5.8%       9855        perf-stat.overall.path-length
>  1.646e+10   2%     -22.2%  1.281e+10        perf-stat.ps.branch-instructions
>  1.186e+08   3%     -19.8%   95167897        perf-stat.ps.branch-misses
>  5.924e+08  10%     -88.6%   67384354   5%  perf-stat.ps.cache-misses
>  2.193e+09          +143.4%  5.339e+09        perf-stat.ps.cache-references
>      49100  19%   +4668.0%    2341074        perf-stat.ps.context-switches
>  3.218e+11            -4.1%  3.087e+11        perf-stat.ps.cpu-cycles
>     189.73         +1368.4%       2786  10%  perf-stat.ps.cpu-migrations
>     753056  18%    +229.9%    2484575  14%  perf-stat.ps.dTLB-load-misses
>  2.377e+10   2%     -26.9%  1.737e+10        perf-stat.ps.dTLB-loads
>     304509  36%    +199.1%     910856  35%  perf-stat.ps.dTLB-store-misses
>  1.284e+10   2%     -28.7%  9.152e+09        perf-stat.ps.dTLB-stores
>   8.76e+10   2%     -25.2%  6.557e+10        perf-stat.ps.instructions
>       2791           +28.2%       3580   2%  perf-stat.ps.minor-faults
>   1.29e+08  12%     -92.4%    9815672   7%  perf-stat.ps.node-load-misses
>   2.25e+08  10%     -90.4%   21575943   8%  perf-stat.ps.node-store-misses
>   69002373  13%     -97.7%    1615410   7%  perf-stat.ps.node-stores
>       2791           +28.2%       3580   2%  perf-stat.ps.page-faults
>   2.68e+13   2%     -26.1%  1.981e+13        perf-stat.total.instructions
>       0.00  35%   +2600.0%       0.04  23%  perf-sched.sch_delay.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
>       1.18   9%     -98.1%       0.02  32%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       0.58   3%     -62.1%       0.22  97%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.51  22%     -82.7%       0.09  11%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.25  23%     -59.6%       0.10  10%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.03  42%     -64.0%       0.01  15%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.04   7%    +434.6%       0.23  36%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       1.00  20%     -84.1%       0.16  78%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>       0.01   7%     -70.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>       0.02   2%    +533.9%       0.12  43%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.03   7%    +105.9%       0.06  33%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.01  15%     +67.5%       0.02   8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       0.09  50%     -85.7%       0.01  33%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>       0.04   7%    +343.4%       0.16   6%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
>       0.06  41%   +3260.7%       1.88  30%  perf-sched.sch_delay.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
>       3.78           -96.2%       0.14   3%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       2.86   4%     -72.6%       0.78 113%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       4.09   7%     -34.1%       2.69   7%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       3.09  37%     -64.1%       1.11   5%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.00 141%   +6200.0%       0.13  82%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       3.94           -40.5%       2.35  48%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       1.63  21%     -77.0%       0.38  90%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>       7.29  39%    +417.5%      37.72  16%  perf-sched.sch_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>       3.35  14%     -51.7%       1.62   3%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       0.05  13%   +2245.1%       1.13  40%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       3.01  26%    +729.6%      25.01  91%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       1.93  59%     -85.5%       0.28  62%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>       0.01           -50.0%       0.00        perf-sched.total_sch_delay.average.ms
>       7.29  39%    +468.8%      41.46  26%  perf-sched.total_sch_delay.max.ms
>       6.04   4%     -94.1%       0.35        perf-sched.total_wait_and_delay.average.ms
>     205790   3%   +1811.0%    3932742        perf-sched.total_wait_and_delay.count.ms
>       6.03   4%     -94.2%       0.35        perf-sched.total_wait_time.average.ms
>      75.51  41%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>      23.01  17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>      23.82   7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>      95.27  41%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
>      55.86 141%   +1014.6%     622.64   5%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.07  23%     -82.5%       0.01        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>     137.41   3%    +345.1%     611.63   2%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.04   5%     -49.6%       0.02        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>     536.33   5%     -46.5%     287.00        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      21.67  32%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       5.67   8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>       1.67  56%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>       5.67  29%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
>       5.33  23%     +93.8%      10.33  25%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>     101725   3%     +15.3%     117243  10%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>     100.00   7%     -80.3%      19.67   2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>      97762   4%   +3794.8%    3807606        perf-sched.wait_and_delay.count.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>       1091   9%    +111.9%       2311   3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>     604.50  43%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>      37.41   9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>      27.08  13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>     275.41  32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
>       1313  69%    +112.1%       2786  15%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>     333.38 141%    +200.4%       1001        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       1000           -96.8%      31.85  48%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      17.99  33%    +387.5%      87.71   8%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>       0.33  19%     -74.1%       0.09  10%  perf-sched.wait_time.avg.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
>       0.02  53%    +331.4%       0.10  50%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>       0.09  65%     -75.9%       0.02   9%  perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
>       0.02  22%     -70.2%       0.01 141%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>      75.51  41%    -100.0%       0.04  42%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       0.10  36%     -80.3%       0.02   9%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       0.55  61%     -94.9%       0.03  45%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>      23.01  17%    -100.0%       0.00 141%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>      23.82   7%     -99.7%       0.07  57%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>      95.27  41%    -100.0%       0.03  89%  perf-sched.wait_time.avg.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
>      56.30 139%   +1005.5%     622.44   5%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       2.78  66%     -98.2%       0.05  52%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       0.07  23%     -82.5%       0.01        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>     137.37   3%    +345.1%     611.40   2%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.02   5%     -41.9%       0.01   3%  perf-sched.wait_time.avg.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>     536.32   5%     -46.5%     286.98        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       4.66  20%     -56.7%       2.02  26%  perf-sched.wait_time.max.ms.__cond_resched.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
>       0.03  63%    +995.0%       0.37  26%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom
>       1.67  87%     -92.6%       0.12  57%  perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.__sys_sendto
>       0.54 117%     -95.1%       0.03 105%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       0.06  49%     -89.1%       0.01 141%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
>     604.50  43%    -100.0%       0.16  83%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
>       2.77  45%     -95.4%       0.13  64%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
>       2.86  45%     -94.3%       0.16  91%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
>      37.41   9%    -100.0%       0.01 141%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>      27.08  13%     -99.7%       0.08  61%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>     275.41  32%    -100.0%       0.03  89%  perf-sched.wait_time.max.ms.__cond_resched.shmem_inode_acct_block.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
>       1313  69%    +112.1%       2786  15%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>     334.74 140%    +198.9%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>      21.74  58%     -95.4%       1.00 103%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       1000           -97.6%      24.49  50%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>      10.90  27%    +682.9%      85.36   6%  perf-sched.wait_time.max.ms.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>      32.91  58%     -63.5%      12.01 115%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>     169.97   7%     -49.2%      86.29  15%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      44.08           -19.8       24.25        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.skb_release_data.__consume_stateless_skb
>      44.47           -19.6       24.87        perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page.skb_release_data.__consume_stateless_skb.udp_recvmsg
>      43.63           -19.5       24.15        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page.skb_release_data
>      45.62           -19.2       26.39        perf-profile.calltrace.cycles-pp.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg
>      45.62           -19.2       26.40        perf-profile.calltrace.cycles-pp.__consume_stateless_skb.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>      45.00           -19.1       25.94        perf-profile.calltrace.cycles-pp.free_unref_page.skb_release_data.__consume_stateless_skb.udp_recvmsg.inet_recvmsg
>      50.41           -16.8       33.64  39%  perf-profile.calltrace.cycles-pp.accept_connections.main.__libc_start_main
>      50.41           -16.8       33.64  39%  perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main.__libc_start_main
>      50.41           -16.8       33.64  39%  perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main.__libc_start_main
>      50.41           -16.8       33.64  39%  perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
>      99.92           -14.2       85.72  15%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
>      99.96           -14.2       85.77  15%  perf-profile.calltrace.cycles-pp.__libc_start_main
>      50.10            -8.6       41.52        perf-profile.calltrace.cycles-pp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
>      50.11            -8.6       41.55        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
>      50.13            -8.5       41.64        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      50.28            -8.0       42.27        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
>      50.29            -8.0       42.29        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni
>      50.31            -7.9       42.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests
>      50.32            -7.8       42.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom.recv_omni.process_requests.spawn_child
>      50.36            -7.6       42.78        perf-profile.calltrace.cycles-pp.recvfrom.recv_omni.process_requests.spawn_child.accept_connection
>      50.41            -7.3       43.07        perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
>      19.93   2%      -6.6       13.36        perf-profile.calltrace.cycles-pp.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
>      19.44   2%      -6.3       13.16        perf-profile.calltrace.cycles-pp._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb.udp_sendmsg
>      18.99   2%      -6.1       12.90        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.ip_generic_getfrag.__ip_append_data.ip_make_skb
>       8.95            -5.1        3.82        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
>       8.70            -5.0        3.71        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
>       8.10            -4.6        3.45        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.sock_sendmsg
>       7.69            -4.4        3.27        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
>       6.51            -3.7        2.78        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
>       6.47            -3.7        2.75        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
>       6.41            -3.7        2.71        perf-profile.calltrace.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
>       5.88            -3.5        2.43        perf-profile.calltrace.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
>       5.73            -3.4        2.35        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip
>       5.69            -3.4        2.33        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_softirq
>       5.36            -3.2        2.19        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__do_softirq
>       4.59            -2.7        1.89        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
>       4.55   2%      -2.7        1.88        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
>       4.40   2%      -2.6        1.81        perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
>       3.81   2%      -2.2        1.57        perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
>       3.75   2%      -2.2        1.55        perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
>       2.21   2%      -1.6        0.63        perf-profile.calltrace.cycles-pp.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
>       1.94   2%      -1.4        0.51   2%  perf-profile.calltrace.cycles-pp.__ip_select_ident.__ip_make_skb.ip_make_skb.udp_sendmsg.sock_sendmsg
>       1.14            -0.6        0.51        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
>       0.00            +0.5        0.53   2%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
>       0.00            +0.7        0.71        perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb
>       0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.__sk_mem_schedule.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv
>       0.00            +1.0        0.99  20%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp
>       0.00            +1.0        1.01  20%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg
>       0.00            +1.1        1.05  20%  perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg
>       0.00            +1.1        1.12        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       0.00            +1.2        1.18  20%  perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg
>       0.00            +1.3        1.32        perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
>       0.00            +2.2        2.23        perf-profile.calltrace.cycles-pp.__skb_recv_udp.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>      49.51            +2.6       52.08        perf-profile.calltrace.cycles-pp.send_udp_stream.main.__libc_start_main
>      49.49            +2.6       52.07        perf-profile.calltrace.cycles-pp.send_omni_inner.send_udp_stream.main.__libc_start_main
>       0.00            +3.0        2.96   2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>      48.71            +3.0       51.73        perf-profile.calltrace.cycles-pp.sendto.send_omni_inner.send_udp_stream.main.__libc_start_main
>       0.00            +3.1        3.06   2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.00            +3.1        3.09        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>      48.34            +3.2       51.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream.main
>       0.00            +3.3        3.33   2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      48.13            +3.8       51.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner.send_udp_stream
>      47.82            +4.0       51.82        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto.send_omni_inner
>      47.70            +4.1       51.76        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
>       0.00            +4.1        4.08        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +4.1        4.10        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +4.1        4.10        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       0.00            +4.1        4.14        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       0.00            +4.3        4.35   2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
>      46.52            +4.8       51.27        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      46.04            +5.0       51.08        perf-profile.calltrace.cycles-pp.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
>       3.67            +8.0       11.63        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg
>       3.71            +8.1       11.80        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg
>       3.96            +8.5       12.42        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg
>       3.96            +8.5       12.44        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.udp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
>      35.13           +11.3       46.39        perf-profile.calltrace.cycles-pp.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
>      32.68   2%     +13.0       45.65        perf-profile.calltrace.cycles-pp.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg.__sys_sendto
>      10.27           +20.3       30.59        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg.sock_sendmsg
>      10.24           +20.3       30.58        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb.udp_sendmsg
>       9.84           +20.5       30.32        perf-profile.calltrace.cycles-pp.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data.ip_make_skb
>       9.59           +20.5       30.11        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.__ip_append_data
>       8.40           +21.0       29.42        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill
>       6.13           +21.9       28.05        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rmqueue_bulk.rmqueue.get_page_from_freelist
>       6.20           +22.0       28.15        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages
>       6.46           +22.5       28.91        perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages.skb_page_frag_refill
>      48.24           -21.8       26.43        perf-profile.children.cycles-pp.skb_release_data
>      47.19           -21.2       25.98        perf-profile.children.cycles-pp.free_unref_page
>      44.48           -19.6       24.88        perf-profile.children.cycles-pp.free_pcppages_bulk
>      45.62           -19.2       26.40        perf-profile.children.cycles-pp.__consume_stateless_skb
>      99.95           -14.2       85.76  15%  perf-profile.children.cycles-pp.main
>      99.96           -14.2       85.77  15%  perf-profile.children.cycles-pp.__libc_start_main
>      50.10            -8.6       41.53        perf-profile.children.cycles-pp.udp_recvmsg
>      50.11            -8.6       41.56        perf-profile.children.cycles-pp.inet_recvmsg
>      50.13            -8.5       41.65        perf-profile.children.cycles-pp.sock_recvmsg
>      50.29            -8.0       42.28        perf-profile.children.cycles-pp.__sys_recvfrom
>      50.29            -8.0       42.30        perf-profile.children.cycles-pp.__x64_sys_recvfrom
>      50.38            -7.5       42.86        perf-profile.children.cycles-pp.recvfrom
>      50.41            -7.3       43.07        perf-profile.children.cycles-pp.accept_connections
>      50.41            -7.3       43.07        perf-profile.children.cycles-pp.accept_connection
>      50.41            -7.3       43.07        perf-profile.children.cycles-pp.spawn_child
>      50.41            -7.3       43.07        perf-profile.children.cycles-pp.process_requests
>      50.41            -7.3       43.07        perf-profile.children.cycles-pp.recv_omni
>      19.96   2%      -6.5       13.50        perf-profile.children.cycles-pp.ip_generic_getfrag
>      19.46   2%      -6.2       13.28        perf-profile.children.cycles-pp._copy_from_iter
>      19.21   2%      -6.1       13.14        perf-profile.children.cycles-pp.copyin
>       8.96            -5.1        3.86        perf-profile.children.cycles-pp.udp_send_skb
>       8.72            -5.0        3.75        perf-profile.children.cycles-pp.ip_send_skb
>       8.11            -4.6        3.49        perf-profile.children.cycles-pp.ip_finish_output2
>       7.72            -4.4        3.32        perf-profile.children.cycles-pp.__dev_queue_xmit
>      98.71            -4.1       94.59        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      98.51            -4.0       94.46        perf-profile.children.cycles-pp.do_syscall_64
>       6.49            -3.7        2.78        perf-profile.children.cycles-pp.do_softirq
>       6.51            -3.7        2.82        perf-profile.children.cycles-pp.__local_bh_enable_ip
>       6.43            -3.7        2.78        perf-profile.children.cycles-pp.__do_softirq
>       5.90            -3.4        2.46        perf-profile.children.cycles-pp.net_rx_action
>       5.74            -3.4        2.38        perf-profile.children.cycles-pp.__napi_poll
>       5.71            -3.4        2.36        perf-profile.children.cycles-pp.process_backlog
>       5.37            -3.2        2.21        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
>       4.60            -2.7        1.91        perf-profile.children.cycles-pp.ip_local_deliver_finish
>       4.57   2%      -2.7        1.90        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
>       4.42   2%      -2.6        1.83        perf-profile.children.cycles-pp.__udp4_lib_rcv
>       3.82   2%      -2.2        1.58   2%  perf-profile.children.cycles-pp.udp_unicast_rcv_skb
>       3.78   2%      -2.2        1.57   2%  perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
>       2.23   2%      -1.6        0.65   2%  perf-profile.children.cycles-pp.__ip_make_skb
>       1.95   2%      -1.4        0.52   3%  perf-profile.children.cycles-pp.__ip_select_ident
>       1.51   4%      -1.2        0.34        perf-profile.children.cycles-pp.free_unref_page_commit
>       1.17            -0.7        0.51   2%  perf-profile.children.cycles-pp.ip_route_output_flow
>       1.15            -0.6        0.52        perf-profile.children.cycles-pp.sock_alloc_send_pskb
>       0.91            -0.5        0.39        perf-profile.children.cycles-pp.alloc_skb_with_frags
>       0.86            -0.5        0.37        perf-profile.children.cycles-pp.__alloc_skb
>       0.83            -0.5        0.36   2%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
>       0.75            -0.4        0.32        perf-profile.children.cycles-pp.dev_hard_start_xmit
>       0.72            -0.4        0.31   3%  perf-profile.children.cycles-pp.fib_table_lookup
>       0.67            -0.4        0.28        perf-profile.children.cycles-pp.loopback_xmit
>       0.70   2%      -0.4        0.33        perf-profile.children.cycles-pp.__zone_watermark_ok
>       0.47   4%      -0.3        0.15        perf-profile.children.cycles-pp.kmem_cache_free
>       0.57            -0.3        0.26        perf-profile.children.cycles-pp.kmem_cache_alloc_node
>       0.46            -0.3        0.18   2%  perf-profile.children.cycles-pp.ip_rcv
>       0.42            -0.3        0.17        perf-profile.children.cycles-pp.move_addr_to_kernel
>       0.41            -0.2        0.16   2%  perf-profile.children.cycles-pp.__udp4_lib_lookup
>       0.32            -0.2        0.13        perf-profile.children.cycles-pp.__netif_rx
>       0.30            -0.2        0.12        perf-profile.children.cycles-pp.netif_rx_internal
>       0.30            -0.2        0.12        perf-profile.children.cycles-pp._copy_from_user
>       0.31            -0.2        0.13        perf-profile.children.cycles-pp.kmalloc_reserve
>       0.63            -0.2        0.46   2%  perf-profile.children.cycles-pp.free_unref_page_prepare
>       0.28            -0.2        0.11        perf-profile.children.cycles-pp.enqueue_to_backlog
>       0.27            -0.2        0.11        perf-profile.children.cycles-pp.udp4_lib_lookup2
>       0.29            -0.2        0.13   6%  perf-profile.children.cycles-pp.send_data
>       0.25            -0.2        0.10        perf-profile.children.cycles-pp.__netif_receive_skb_core
>       0.23   2%      -0.1        0.10   4%  perf-profile.children.cycles-pp.security_socket_sendmsg
>       0.19   2%      -0.1        0.06        perf-profile.children.cycles-pp.ip_rcv_core
>       0.37            -0.1        0.24        perf-profile.children.cycles-pp.irqtime_account_irq
>       0.21            -0.1        0.08        perf-profile.children.cycles-pp.sock_wfree
>       0.21   3%      -0.1        0.08        perf-profile.children.cycles-pp.validate_xmit_skb
>       0.20   2%      -0.1        0.08        perf-profile.children.cycles-pp.ip_output
>       0.22   2%      -0.1        0.10   4%  perf-profile.children.cycles-pp.ip_rcv_finish_core
>       0.20   6%      -0.1        0.09   5%  perf-profile.children.cycles-pp.__mkroute_output
>       0.21   2%      -0.1        0.09   5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       0.28            -0.1        0.18        perf-profile.children.cycles-pp._raw_spin_trylock
>       0.34   3%      -0.1        0.25        perf-profile.children.cycles-pp.__slab_free
>       0.13   3%      -0.1        0.05        perf-profile.children.cycles-pp.siphash_3u32
>       0.12   4%      -0.1        0.03  70%  perf-profile.children.cycles-pp.ipv4_pktinfo_prepare
>       0.14   3%      -0.1        0.06   7%  perf-profile.children.cycles-pp.__ip_local_out
>       0.20   2%      -0.1        0.12        perf-profile.children.cycles-pp.aa_sk_perm
>       0.18   2%      -0.1        0.10        perf-profile.children.cycles-pp.get_pfnblock_flags_mask
>       0.12   3%      -0.1        0.05        perf-profile.children.cycles-pp.sk_filter_trim_cap
>       0.13            -0.1        0.06        perf-profile.children.cycles-pp.ip_setup_cork
>       0.13   7%      -0.1        0.06   8%  perf-profile.children.cycles-pp.fib_lookup_good_nhc
>       0.15   3%      -0.1        0.08   5%  perf-profile.children.cycles-pp.skb_set_owner_w
>       0.11   4%      -0.1        0.05        perf-profile.children.cycles-pp.dst_release
>       0.23   2%      -0.1        0.17   2%  perf-profile.children.cycles-pp.__entry_text_start
>       0.11            -0.1        0.05        perf-profile.children.cycles-pp.ipv4_mtu
>       0.20   2%      -0.1        0.15   3%  perf-profile.children.cycles-pp.__list_add_valid_or_report
>       0.10            -0.1        0.05        perf-profile.children.cycles-pp.ip_send_check
>       0.31   2%      -0.0        0.26   3%  perf-profile.children.cycles-pp.sockfd_lookup_light
>       0.27            -0.0        0.22   2%  perf-profile.children.cycles-pp.__fget_light
>       0.63            -0.0        0.58        perf-profile.children.cycles-pp.__check_object_size
>       0.15   3%      -0.0        0.11        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.13            -0.0        0.09   5%  perf-profile.children.cycles-pp.alloc_pages
>       0.27            -0.0        0.24        perf-profile.children.cycles-pp.sched_clock_cpu
>       0.11   4%      -0.0        0.08   6%  perf-profile.children.cycles-pp.__cond_resched
>       0.14   3%      -0.0        0.11        perf-profile.children.cycles-pp.free_tail_page_prepare
>       0.11            -0.0        0.08   5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       0.09   9%      -0.0        0.06   7%  perf-profile.children.cycles-pp.__xfrm_policy_check2
>       0.23   2%      -0.0        0.21   2%  perf-profile.children.cycles-pp.sched_clock
>       0.14   3%      -0.0        0.11   4%  perf-profile.children.cycles-pp.prep_compound_page
>       0.21   2%      -0.0        0.20   2%  perf-profile.children.cycles-pp.native_sched_clock
>       0.06            -0.0        0.05        perf-profile.children.cycles-pp.task_tick_fair
>       0.06            -0.0        0.05        perf-profile.children.cycles-pp.check_stack_object
>       0.18   2%      +0.0        0.20   2%  perf-profile.children.cycles-pp.perf_event_task_tick
>       0.18   2%      +0.0        0.19   2%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
>       0.31   3%      +0.0        0.33        perf-profile.children.cycles-pp.tick_sched_handle
>       0.31   3%      +0.0        0.33        perf-profile.children.cycles-pp.update_process_times
>       0.41   2%      +0.0        0.43        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.40   2%      +0.0        0.42        perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.32   2%      +0.0        0.34        perf-profile.children.cycles-pp.tick_sched_timer
>       0.36   2%      +0.0        0.39        perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.06   7%      +0.0        0.10   4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.05   8%      +0.0        0.10        perf-profile.children.cycles-pp._raw_spin_lock_bh
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_cfs_group
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.cpuidle_governor_latency_req
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       0.00            +0.1        0.05   8%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
>       0.07            +0.1        0.13   3%  perf-profile.children.cycles-pp.__mod_zone_page_state
>       0.00            +0.1        0.06  13%  perf-profile.children.cycles-pp.cgroup_rstat_updated
>       0.00            +0.1        0.06        perf-profile.children.cycles-pp.__x2apic_send_IPI_dest
>       0.00            +0.1        0.06        perf-profile.children.cycles-pp.security_socket_recvmsg
>       0.00            +0.1        0.06        perf-profile.children.cycles-pp.select_task_rq_fair
>       0.00            +0.1        0.06        perf-profile.children.cycles-pp.tick_irq_enter
>       0.00            +0.1        0.06        perf-profile.children.cycles-pp.tick_nohz_idle_enter
>       0.42   2%      +0.1        0.49   2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.00            +0.1        0.07   7%  perf-profile.children.cycles-pp.ktime_get
>       0.00            +0.1        0.07        perf-profile.children.cycles-pp.__get_user_4
>       0.00            +0.1        0.07        perf-profile.children.cycles-pp.update_rq_clock
>       0.00            +0.1        0.07        perf-profile.children.cycles-pp.select_task_rq
>       0.00            +0.1        0.07        perf-profile.children.cycles-pp.native_apic_msr_eoi
>       0.49            +0.1        0.57   2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.11  11%      +0.1        0.19   2%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.00            +0.1        0.08        perf-profile.children.cycles-pp.update_rq_clock_task
>       0.00            +0.1        0.08        perf-profile.children.cycles-pp.__update_load_avg_se
>       0.00            +0.1        0.09   5%  perf-profile.children.cycles-pp.irq_enter_rcu
>       0.00            +0.1        0.09   5%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.00            +0.1        0.09        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.00            +0.1        0.09        perf-profile.children.cycles-pp.update_blocked_averages
>       0.00            +0.1        0.09        perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.00            +0.1        0.09   5%  perf-profile.children.cycles-pp.set_next_entity
>       0.00            +0.1        0.10        perf-profile.children.cycles-pp.__switch_to_asm
>       0.00            +0.1        0.11  12%  perf-profile.children.cycles-pp._copy_to_user
>       0.00            +0.1        0.12   3%  perf-profile.children.cycles-pp.menu_select
>       0.00            +0.1        0.12   3%  perf-profile.children.cycles-pp.recv_data
>       0.00            +0.1        0.12   3%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.00            +0.1        0.13   3%  perf-profile.children.cycles-pp.native_irq_return_iret
>       0.00            +0.1        0.13   3%  perf-profile.children.cycles-pp.__switch_to
>       0.00            +0.1        0.13   3%  perf-profile.children.cycles-pp.find_busiest_group
>       0.00            +0.1        0.14        perf-profile.children.cycles-pp.finish_task_switch
>       0.00            +0.1        0.15   3%  perf-profile.children.cycles-pp.update_curr
>       0.00            +0.2        0.15   3%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
>       0.00            +0.2        0.16        perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.05            +0.2        0.22   2%  perf-profile.children.cycles-pp.page_counter_try_charge
>       0.00            +0.2        0.17   2%  perf-profile.children.cycles-pp.load_balance
>       0.00            +0.2        0.17   2%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.02 141%      +0.2        0.19   2%  perf-profile.children.cycles-pp.page_counter_uncharge
>       0.33            +0.2        0.52        perf-profile.children.cycles-pp.__free_one_page
>       0.02 141%      +0.2        0.21   2%  perf-profile.children.cycles-pp.drain_stock
>       0.00            +0.2        0.20   2%  perf-profile.children.cycles-pp.prepare_task_switch
>       0.16   3%      +0.2        0.38   2%  perf-profile.children.cycles-pp.simple_copy_to_iter
>       0.07  11%      +0.2        0.31        perf-profile.children.cycles-pp.refill_stock
>       0.07   6%      +0.2        0.31   4%  perf-profile.children.cycles-pp.move_addr_to_user
>       0.00            +0.2        0.24        perf-profile.children.cycles-pp.enqueue_entity
>       0.00            +0.2        0.25        perf-profile.children.cycles-pp.update_load_avg
>       0.21   2%      +0.3        0.48        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
>       0.00            +0.3        0.31   4%  perf-profile.children.cycles-pp.dequeue_entity
>       0.08   5%      +0.3        0.40   3%  perf-profile.children.cycles-pp.try_charge_memcg
>       0.00            +0.3        0.33        perf-profile.children.cycles-pp.enqueue_task_fair
>       0.00            +0.4        0.35   2%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.00            +0.4        0.35   2%  perf-profile.children.cycles-pp.activate_task
>       0.00            +0.4        0.36   2%  perf-profile.children.cycles-pp.try_to_wake_up
>       0.00            +0.4        0.37   2%  perf-profile.children.cycles-pp.autoremove_wake_function
>       0.00            +0.4        0.39   3%  perf-profile.children.cycles-pp.newidle_balance
>       0.12   8%      +0.4        0.51   2%  perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
>       0.00            +0.4        0.39        perf-profile.children.cycles-pp.ttwu_do_activate
>       0.00            +0.4        0.40   2%  perf-profile.children.cycles-pp.__wake_up_common
>       0.18   4%      +0.4        0.59        perf-profile.children.cycles-pp.udp_rmem_release
>       0.11   7%      +0.4        0.52        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
>       0.00            +0.4        0.43        perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.00            +0.5        0.46        perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.00            +0.5        0.49        perf-profile.children.cycles-pp.sock_def_readable
>       0.00            +0.5        0.53   2%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.00            +0.5        0.54   2%  perf-profile.children.cycles-pp.schedule_idle
>       0.00            +0.6        0.55        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.15   3%      +0.6        0.73   2%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
>       0.00            +0.6        0.57        perf-profile.children.cycles-pp.__sysvec_call_function_single
>       0.16   5%      +0.6        0.74   2%  perf-profile.children.cycles-pp.__sk_mem_schedule
>       0.00            +0.8        0.78        perf-profile.children.cycles-pp.sysvec_call_function_single
>       0.41   3%      +0.9        1.33   2%  perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
>       0.00            +1.2        1.16   2%  perf-profile.children.cycles-pp.schedule
>       0.00            +1.2        1.21   2%  perf-profile.children.cycles-pp.schedule_timeout
>       0.00            +1.3        1.33   2%  perf-profile.children.cycles-pp.__skb_wait_for_more_packets
>       0.00            +1.7        1.66   2%  perf-profile.children.cycles-pp.__schedule
>       0.27   3%      +2.0        2.25        perf-profile.children.cycles-pp.__skb_recv_udp
>      50.41            +2.4       52.81        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.00            +2.7        2.68        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>      49.78            +2.7       52.49        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.00            +3.0        2.98        perf-profile.children.cycles-pp.acpi_safe_halt
>       0.00            +3.0        3.00        perf-profile.children.cycles-pp.acpi_idle_enter
>      49.51            +3.1       52.57        perf-profile.children.cycles-pp.send_udp_stream
>      49.50            +3.1       52.56        perf-profile.children.cycles-pp.send_omni_inner
>       0.00            +3.1        3.10        perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.00            +3.1        3.12        perf-profile.children.cycles-pp.cpuidle_enter
>       0.00            +3.4        3.37        perf-profile.children.cycles-pp.cpuidle_idle_call
>      48.90            +3.4       52.30        perf-profile.children.cycles-pp.sendto
>      47.85            +4.0       51.83        perf-profile.children.cycles-pp.__x64_sys_sendto
>      47.73            +4.0       51.77        perf-profile.children.cycles-pp.__sys_sendto
>       0.00            +4.1        4.10        perf-profile.children.cycles-pp.start_secondary
>       0.00            +4.1        4.13        perf-profile.children.cycles-pp.do_idle
>       0.00            +4.1        4.14        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       0.00            +4.1        4.14        perf-profile.children.cycles-pp.cpu_startup_entry
>      46.54            +4.7       51.28        perf-profile.children.cycles-pp.sock_sendmsg
>      46.10            +5.0       51.11        perf-profile.children.cycles-pp.udp_sendmsg
>       3.70            +8.0       11.71        perf-profile.children.cycles-pp.copyout
>       3.71            +8.1       11.80        perf-profile.children.cycles-pp._copy_to_iter
>       3.96            +8.5       12.43        perf-profile.children.cycles-pp.__skb_datagram_iter
>       3.96            +8.5       12.44        perf-profile.children.cycles-pp.skb_copy_datagram_iter
>      35.14           +11.3       46.40        perf-profile.children.cycles-pp.ip_make_skb
>      32.71   2%     +13.0       45.66        perf-profile.children.cycles-pp.__ip_append_data
>      10.28           +20.6       30.89        perf-profile.children.cycles-pp.sk_page_frag_refill
>      10.25           +20.6       30.88        perf-profile.children.cycles-pp.skb_page_frag_refill
>       9.86           +20.8       30.63        perf-profile.children.cycles-pp.__alloc_pages
>       9.62           +20.8       30.42        perf-profile.children.cycles-pp.get_page_from_freelist
>       8.42           +21.3       29.72        perf-profile.children.cycles-pp.rmqueue
>       6.47           +22.8       29.22        perf-profile.children.cycles-pp.rmqueue_bulk
>      19.11   2%      -6.0       13.08        perf-profile.self.cycles-pp.copyin
>       1.81   2%      -1.4        0.39        perf-profile.self.cycles-pp.rmqueue
>       1.81   2%      -1.3        0.46   2%  perf-profile.self.cycles-pp.__ip_select_ident
>       1.47   4%      -1.2        0.31        perf-profile.self.cycles-pp.free_unref_page_commit
>       1.29   2%      -0.5        0.75        perf-profile.self.cycles-pp.__ip_append_data
>       0.71            -0.4        0.29        perf-profile.self.cycles-pp.udp_sendmsg
>       0.68   2%      -0.4        0.32        perf-profile.self.cycles-pp.__zone_watermark_ok
>       0.50            -0.3        0.16        perf-profile.self.cycles-pp.skb_release_data
>       0.59   3%      -0.3        0.26   3%  perf-profile.self.cycles-pp.fib_table_lookup
>       0.46   4%      -0.3        0.15   3%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.63            -0.3        0.33   2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.47            -0.3        0.19        perf-profile.self.cycles-pp.__sys_sendto
>       0.44            -0.2        0.21   2%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
>       0.36            -0.2        0.16   3%  perf-profile.self.cycles-pp.send_omni_inner
>       0.35   2%      -0.2        0.15   3%  perf-profile.self.cycles-pp.ip_finish_output2
>       0.29            -0.2        0.12        perf-profile.self.cycles-pp._copy_from_user
>       0.24            -0.1        0.10   4%  perf-profile.self.cycles-pp.__netif_receive_skb_core
>       0.22   2%      -0.1        0.08   5%  perf-profile.self.cycles-pp.free_unref_page
>       0.19   2%      -0.1        0.06        perf-profile.self.cycles-pp.ip_rcv_core
>       0.21   2%      -0.1        0.08        perf-profile.self.cycles-pp.__alloc_skb
>       0.20   2%      -0.1        0.08        perf-profile.self.cycles-pp.sock_wfree
>       0.22   2%      -0.1        0.10   4%  perf-profile.self.cycles-pp.send_data
>       0.21            -0.1        0.09        perf-profile.self.cycles-pp.sendto
>       0.21   2%      -0.1        0.10   4%  perf-profile.self.cycles-pp.ip_rcv_finish_core
>       0.21   2%      -0.1        0.09   5%  perf-profile.self.cycles-pp.__ip_make_skb
>       0.20   4%      -0.1        0.09   5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.21   2%      -0.1        0.10   4%  perf-profile.self.cycles-pp.__dev_queue_xmit
>       0.38   3%      -0.1        0.27        perf-profile.self.cycles-pp.get_page_from_freelist
>       0.20   2%      -0.1        0.09        perf-profile.self.cycles-pp.udp_send_skb
>       0.18   2%      -0.1        0.07        perf-profile.self.cycles-pp.__udp_enqueue_schedule_skb
>       0.18   4%      -0.1        0.08   6%  perf-profile.self.cycles-pp.__mkroute_output
>       0.25            -0.1        0.15   3%  perf-profile.self.cycles-pp._copy_from_iter
>       0.27   4%      -0.1        0.17   2%  perf-profile.self.cycles-pp.skb_page_frag_refill
>       0.16            -0.1        0.06   7%  perf-profile.self.cycles-pp.sock_sendmsg
>       0.33   2%      -0.1        0.24        perf-profile.self.cycles-pp.__slab_free
>       0.15   3%      -0.1        0.06        perf-profile.self.cycles-pp.udp4_lib_lookup2
>       0.38   2%      -0.1        0.29   2%  perf-profile.self.cycles-pp.free_unref_page_prepare
>       0.26            -0.1        0.17        perf-profile.self.cycles-pp._raw_spin_trylock
>       0.15            -0.1        0.06        perf-profile.self.cycles-pp.ip_output
>       0.14            -0.1        0.05   8%  perf-profile.self.cycles-pp.process_backlog
>       0.14            -0.1        0.06        perf-profile.self.cycles-pp.ip_route_output_flow
>       0.14            -0.1        0.06        perf-profile.self.cycles-pp.__udp4_lib_lookup
>       0.21   2%      -0.1        0.13   3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.12   3%      -0.1        0.05        perf-profile.self.cycles-pp.siphash_3u32
>       0.13   3%      -0.1        0.06   8%  perf-profile.self.cycles-pp.ip_send_skb
>       0.17            -0.1        0.10        perf-profile.self.cycles-pp.__do_softirq
>       0.15   3%      -0.1        0.08   5%  perf-profile.self.cycles-pp.skb_set_owner_w
>       0.17   2%      -0.1        0.10   4%  perf-profile.self.cycles-pp.aa_sk_perm
>       0.12            -0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_sendto
>       0.12   6%      -0.1        0.05        perf-profile.self.cycles-pp.fib_lookup_good_nhc
>       0.19   2%      -0.1        0.13        perf-profile.self.cycles-pp.__list_add_valid_or_report
>       0.14   3%      -0.1        0.07   6%  perf-profile.self.cycles-pp.net_rx_action
>       0.16   2%      -0.1        0.10        perf-profile.self.cycles-pp.do_syscall_64
>       0.11            -0.1        0.05        perf-profile.self.cycles-pp.__udp4_lib_rcv
>       0.16   3%      -0.1        0.10   4%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
>       0.11   4%      -0.1        0.05        perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
>       0.10   4%      -0.1        0.05        perf-profile.self.cycles-pp.ip_generic_getfrag
>       0.10            -0.1        0.05        perf-profile.self.cycles-pp.ipv4_mtu
>       0.26            -0.0        0.21   2%  perf-profile.self.cycles-pp.__fget_light
>       0.15   3%      -0.0        0.11   4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.24            -0.0        0.20   2%  perf-profile.self.cycles-pp.__alloc_pages
>       0.15   3%      -0.0        0.12        perf-profile.self.cycles-pp.__check_object_size
>       0.11            -0.0        0.08   6%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.08   5%      -0.0        0.05        perf-profile.self.cycles-pp.loopback_xmit
>       0.13            -0.0        0.11   4%  perf-profile.self.cycles-pp.prep_compound_page
>       0.11            -0.0        0.09   5%  perf-profile.self.cycles-pp.irqtime_account_irq
>       0.09  10%      -0.0        0.06   7%  perf-profile.self.cycles-pp.__xfrm_policy_check2
>       0.07            -0.0        0.05        perf-profile.self.cycles-pp.alloc_pages
>       0.08            -0.0        0.06   7%  perf-profile.self.cycles-pp.__entry_text_start
>       0.09   5%      -0.0        0.07        perf-profile.self.cycles-pp.free_tail_page_prepare
>       0.10            +0.0        0.11        perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
>       0.06            +0.0        0.08   6%  perf-profile.self.cycles-pp.free_pcppages_bulk
>       0.05   8%      +0.0        0.10   4%  perf-profile.self.cycles-pp._raw_spin_lock_bh
>       0.07            +0.0        0.12        perf-profile.self.cycles-pp.__mod_zone_page_state
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.cpuidle_idle_call
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.udp_rmem_release
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.sock_def_readable
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.update_cfs_group
>       0.11  11%      +0.1        0.17   2%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.00            +0.1        0.05   8%  perf-profile.self.cycles-pp.finish_task_switch
>       0.00            +0.1        0.05   8%  perf-profile.self.cycles-pp.cgroup_rstat_updated
>       0.00            +0.1        0.06        perf-profile.self.cycles-pp.do_idle
>       0.00            +0.1        0.06        perf-profile.self.cycles-pp.__skb_wait_for_more_packets
>       0.00            +0.1        0.06        perf-profile.self.cycles-pp.__x2apic_send_IPI_dest
>       0.00            +0.1        0.06   7%  perf-profile.self.cycles-pp.enqueue_entity
>       0.00            +0.1        0.07   7%  perf-profile.self.cycles-pp.schedule_timeout
>       0.00            +0.1        0.07   7%  perf-profile.self.cycles-pp.move_addr_to_user
>       0.00            +0.1        0.07   7%  perf-profile.self.cycles-pp.menu_select
>       0.00            +0.1        0.07   7%  perf-profile.self.cycles-pp.native_apic_msr_eoi
>       0.00            +0.1        0.07   7%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.00            +0.1        0.07        perf-profile.self.cycles-pp.__update_load_avg_se
>       0.00            +0.1        0.07        perf-profile.self.cycles-pp.__get_user_4
>       0.00            +0.1        0.08   6%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
>       0.00            +0.1        0.08        perf-profile.self.cycles-pp.update_curr
>       0.00            +0.1        0.08   5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.00            +0.1        0.09   5%  perf-profile.self.cycles-pp.try_to_wake_up
>       0.00            +0.1        0.09        perf-profile.self.cycles-pp.recvfrom
>       0.00            +0.1        0.09        perf-profile.self.cycles-pp.mem_cgroup_charge_skmem
>       0.00            +0.1        0.09        perf-profile.self.cycles-pp.update_load_avg
>       0.00            +0.1        0.09   5%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.00            +0.1        0.10   4%  perf-profile.self.cycles-pp._copy_to_iter
>       0.00            +0.1        0.10   4%  perf-profile.self.cycles-pp.newidle_balance
>       0.00            +0.1        0.10   4%  perf-profile.self.cycles-pp.recv_data
>       0.00            +0.1        0.10        perf-profile.self.cycles-pp.refill_stock
>       0.00            +0.1        0.10        perf-profile.self.cycles-pp.__switch_to_asm
>       0.00            +0.1        0.11  15%  perf-profile.self.cycles-pp._copy_to_user
>       0.00            +0.1        0.12        perf-profile.self.cycles-pp.recv_omni
>       0.00            +0.1        0.12        perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
>       0.00            +0.1        0.13   3%  perf-profile.self.cycles-pp.native_irq_return_iret
>       0.00            +0.1        0.13        perf-profile.self.cycles-pp.__switch_to
>       0.06            +0.1        0.20   2%  perf-profile.self.cycles-pp.rmqueue_bulk
>       0.09   5%      +0.1        0.23   4%  perf-profile.self.cycles-pp.udp_recvmsg
>       0.00            +0.1        0.14   3%  perf-profile.self.cycles-pp.__skb_recv_udp
>       0.00            +0.1        0.14   3%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.08            +0.1        0.22   2%  perf-profile.self.cycles-pp.__skb_datagram_iter
>       0.03  70%      +0.2        0.20   4%  perf-profile.self.cycles-pp.page_counter_try_charge
>       0.02 141%      +0.2        0.18   4%  perf-profile.self.cycles-pp.__sys_recvfrom
>       0.00            +0.2        0.17   2%  perf-profile.self.cycles-pp.__schedule
>       0.00            +0.2        0.17   2%  perf-profile.self.cycles-pp.try_charge_memcg
>       0.00            +0.2        0.17   2%  perf-profile.self.cycles-pp.page_counter_uncharge
>       0.00            +0.2        0.21   2%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
>       0.14   3%      +0.2        0.36        perf-profile.self.cycles-pp.__free_one_page
>       0.20   2%      +0.3        0.47        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
>       0.00            +2.1        2.07   2%  perf-profile.self.cycles-pp.acpi_safe_halt
>      49.78            +2.7       52.49        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       3.68            +8.0       11.64        perf-profile.self.cycles-pp.copyout
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
