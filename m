Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC877BC08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjHNOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHNOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:50:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98A183
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692024634; x=1723560634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IKAY+moDvnAnlf1oJO+pFO3n2ors4yrVLCdi4MBjXDA=;
  b=SpbLnu3VmoRpu21qjntzPFuTvgOIfaG5tgJVJ7aYh3TKJfes0iTrH4dS
   oV3tydI5mj9WQHBKsYev/mrzJUFJuo0z5q5OEz35OACBjcmy9ulz6t4KN
   rRprNdjB8+W+2eanMyjnx3ErvfLpCTwD/lT8SQOEusnr0GkXyh72f6H2O
   atyzoBNCZV+nJI8KYm2qejgfyN7wMYsWd7QhiJPTDGq3DXnRo/hiSQ0nl
   qIhA6P9IS12La4mju8uV2Ry/C7fHHpVnJpWIiowlCjjpWVp2EHBfy8j3Y
   TkWiNYPbIWB4TO1WcZgg8tmAQoFJwMQ5PwIpbx2RhOWSZ04bUv2mpb8ng
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="458415296"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="458415296"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="980000027"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="980000027"
Received: from linux-pnp-server-22.sh.intel.com ([10.239.147.143])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 07:50:30 -0700
From:   Deng Pan <pan.deng@intel.com>
To:     tim.c.chen@intel.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        tianyou.li@intel.com, yu.ma@intel.com, lipeng.zhu@intel.com,
        yu.c.chen@intel.com, Deng Pan <pan.deng@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v3] sched/task_group: Re-layout structure to reduce false sharing
Date:   Mon, 14 Aug 2023 22:55:48 +0800
Message-Id: <20230814145548.151073-1-pan.deng@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running UnixBench/Pipe-based Context Switching case, we observed
high false sharing for accessing ‘load_avg’ against rt_se and rt_rq
when config CONFIG_RT_GROUP_SCHED is turned on. Although the config
CONFIG_RT_GROUP_SCHED is not popular, it is enabled in some build
environment, e.g. https://elrepo.org/linux/kernel/el8/SRPMS/

Pipe-based Context Switching case is a typical sleep/wakeup scenario,
in which load_avg is frequenly loaded and stored, at the meantime, rt_se
and rt_rq are frequently loaded. Unfortunately, they are in the same
cacheline.

This change re-layouts the structure:
1. Move rt_se and rt_rq to a 2nd cacheline.
2. Keep ‘parent’ field in the 2nd cacheline since it's also accessed
very often when cgroups are nested, thanks Tim Chen for providing the
insight.

Tested on Intel Icelake 2 sockets 80C/160T platform, based on v6.4-rc5.

With this change, Pipe-based Context Switching 160 parallel score is
improved ~9.6%, perf record tool reports rt_se and rt_rq access cycles
are reduced from ~14.5% to ~0.3%, perf c2c tool shows the false-sharing
is resolved as expected:

Baseline:
=================================================
      Shared Cache Line Distribution Pareto
=================================================
  ----------------------------------------------------------------------
      0     1031     3927     3322       50        0  0xff284d17b5c0fa00
  ----------------------------------------------------------------------
          63.72%   65.16%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffffffa134934e      4247      3249      4057    13874       160  [k] update_cfs_group       [kernel.kallsyms]  update_cfs_group+78          0  1
           7.47%    3.23%   98.43%    0.00%    0.00%                 0x0     1       1  0xffffffffa13478ac     12034     13166      7699     8149       160  [k] update_load_avg        [kernel.kallsyms]  update_load_avg+940          0  1
           0.58%    0.18%    0.39%   98.00%    0.00%                 0x0     1       1  0xffffffffa13478b4     40713     44343     33768      158        95  [k] update_load_avg        [kernel.kallsyms]  update_load_avg+948          0  1
           0.00%    0.08%    1.17%    0.00%    0.00%                 0x0     1       1  0xffffffffa1348076         0     14303      6006       75        61  [k] __update_blocked_fair  [kernel.kallsyms]  __update_blocked_fair+998    0  1
           0.19%    0.03%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffffffa1349355     30718      2820     23693      246       117  [k] update_cfs_group       [kernel.kallsyms]  update_cfs_group+85          0  1
           0.00%    0.00%    0.00%    2.00%    0.00%                 0x0     1       1  0xffffffffa134807e         0         0     24401        2         2  [k] __update_blocked_fair  [kernel.kallsyms]  __update_blocked_fair+1006   0  1
          14.16%   16.30%    0.00%    0.00%    0.00%                 0x8     1       1  0xffffffffa133c5c7      5101      4028      4839     7354       160  [k] set_task_cpu           [kernel.kallsyms]  set_task_cpu+279             0  1
           0.00%    0.03%    0.00%    0.00%    0.00%                 0x8     1       1  0xffffffffa133c5ce         0     18646     25195       30        28  [k] set_task_cpu           [kernel.kallsyms]  set_task_cpu+286             0  1
          13.87%   14.97%    0.00%    0.00%    0.00%                0x10     1       1  0xffffffffa133c5b5      4138      3738      5608     6321       160  [k] set_task_cpu           [kernel.kallsyms]  set_task_cpu+261             0  1
           0.00%    0.03%    0.00%    0.00%    0.00%                0x10     1       1  0xffffffffa133c5bc         0      6321     26398      149        88  [k] set_task_cpu           [kernel.kallsyms]  set_task_cpu+268             0  1

With this change:
=================================================
      Shared Cache Line Distribution Pareto
=================================================
  ----------------------------------------------------------------------
      0     1118     3340     3118       57        0  0xff1d6ca01ecc5e80
  ----------------------------------------------------------------------
          91.59%   94.46%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffffff8914934e      4710      4211      5158    14218       160  [k] update_cfs_group       [kernel.kallsyms]  update_cfs_group+78          0  1
           7.42%    4.82%   97.98%    0.00%    0.00%                 0x0     1       1  0xffffffff891478ac     15225     14713      8593     7858       160  [k] update_load_avg        [kernel.kallsyms]  update_load_avg+940          0  1
           0.81%    0.66%    0.58%   98.25%    0.00%                 0x0     1       1  0xffffffff891478b4     38486     44799     33123      186       107  [k] update_load_avg        [kernel.kallsyms]  update_load_avg+948          0  1
           0.18%    0.06%    0.00%    0.00%    0.00%                 0x0     1       1  0xffffffff89149355     20077     32046     22302      388       144  [k] update_cfs_group       [kernel.kallsyms]  update_cfs_group+85          0  1
           0.00%    0.00%    1.41%    0.00%    0.00%                 0x0     1       1  0xffffffff89148076         0         0      6804       85        64  [k] __update_blocked_fair  [kernel.kallsyms]  __update_blocked_fair+998    0  1
           0.00%    0.00%    0.03%    1.75%    0.00%                 0x0     1       1  0xffffffff8914807e         0         0     26581        3         3  [k] __update_blocked_fair  [kernel.kallsyms]  __update_blocked_fair+1006   0  1

Besides above, Hackbench, netperf and schbench were also tested, no
obvious regression detected.

hackbench
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  0.87)   -0.95 (  1.72)
process-pipe            2-groups         1.00 (  0.57)   +9.11 ( 14.44)
process-pipe            4-groups         1.00 (  0.64)   +6.77 (  2.50)
process-pipe            8-groups         1.00 (  0.28)   -4.39 (  2.02)
process-sockets         1-groups         1.00 (  2.37)   +1.13 (  0.76)
process-sockets         2-groups         1.00 (  7.83)   -3.41 (  4.78)
process-sockets         4-groups         1.00 (  2.24)   +0.71 (  2.13)
process-sockets         8-groups         1.00 (  0.39)   +1.05 (  0.19)
threads-pipe            1-groups         1.00 (  1.85)   -2.22 (  0.66)
threads-pipe            2-groups         1.00 (  2.36)   +3.48 (  6.44)
threads-pipe            4-groups         1.00 (  3.07)   -7.92 (  5.82)
threads-pipe            8-groups         1.00 (  1.00)   +2.68 (  1.28)
threads-sockets         1-groups         1.00 (  0.34)   +1.19 (  1.96)
threads-sockets         2-groups         1.00 (  6.24)   -4.88 (  2.10)
threads-sockets         4-groups         1.00 (  2.26)   +0.41 (  1.58)
threads-sockets         8-groups         1.00 (  0.46)   +0.07 (  2.19)

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  40-threads       1.00 (  0.78)   -0.18 (  1.80)
TCP_RR                  80-threads       1.00 (  0.72)   -1.62 (  0.84)
TCP_RR                  120-threads      1.00 (  0.74)   -0.35 (  0.99)
TCP_RR                  160-threads      1.00 ( 30.79)   -1.75 ( 29.57)
TCP_RR                  200-threads      1.00 ( 17.45)   -2.89 ( 16.64)
TCP_RR                  240-threads      1.00 ( 27.73)   -2.46 ( 19.35)
TCP_RR                  280-threads      1.00 ( 32.76)   -3.00 ( 30.65)
TCP_RR                  320-threads      1.00 ( 41.73)   -3.14 ( 37.84)
UDP_RR                  40-threads       1.00 (  1.21)   +0.02 (  1.68)
UDP_RR                  80-threads       1.00 (  0.33)   -0.47 (  9.59)
UDP_RR                  120-threads      1.00 ( 12.38)   +0.30 ( 13.42)
UDP_RR                  160-threads      1.00 ( 29.10)   +8.17 ( 34.51)
UDP_RR                  200-threads      1.00 ( 21.04)   -1.72 ( 20.96)
UDP_RR                  240-threads      1.00 ( 38.11)   -2.54 ( 38.15)
UDP_RR                  280-threads      1.00 ( 31.56)   -0.73 ( 32.70)
UDP_RR                  320-threads      1.00 ( 41.54)   -2.00 ( 44.39)

schbench
========
case                    load            baseline(std%)  compare%( std%)
normal                  1-mthreads       1.00 (  4.16)   +3.53 (  0.86)
normal                  2-mthreads       1.00 (  2.86)   +1.69 (  2.91)
normal                  4-mthreads       1.00 (  4.97)   -6.53 (  8.20)
normal                  8-mthreads       1.00 (  0.86)   -0.70 (  0.54)

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Deng Pan <pan.deng@intel.com>
---
V1 -> V2:
 - Add comment in data structure
 - More data support in commit log
V2 -> V3:
 - Update comment around parent field
 - Update commit log for CONFIG_RT_GROUP_SCHED

 kernel/sched/sched.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e93e006a942b..1d040d392eb2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -383,6 +383,19 @@ struct task_group {
 #endif
 #endif
 
+	struct rcu_head		rcu;
+	struct list_head	list;
+
+	struct list_head	siblings;
+	struct list_head	children;
+
+	/*
+	 * load_avg can also cause cacheline bouncing with parent, rt_se
+	 * and rt_rq, current layout is optimized to make sure they are in
+	 * different cachelines.
+	 */
+	struct task_group	*parent;
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity	**rt_se;
 	struct rt_rq		**rt_rq;
@@ -390,13 +403,6 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
-	struct rcu_head		rcu;
-	struct list_head	list;
-
-	struct task_group	*parent;
-	struct list_head	siblings;
-	struct list_head	children;
-
 #ifdef CONFIG_SCHED_AUTOGROUP
 	struct autogroup	*autogroup;
 #endif
-- 
2.39.3

