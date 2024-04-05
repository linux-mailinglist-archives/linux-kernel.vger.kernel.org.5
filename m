Return-Path: <linux-kernel+bounces-132451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0F89950C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C061D1C22912
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728B25630;
	Fri,  5 Apr 2024 06:09:16 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF1481DE;
	Fri,  5 Apr 2024 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297354; cv=none; b=BBCKFTakuo81SxaZ8ItmvPUthpryuK+pR3IKKJp2347uLc7ehzKupBY5I0tVDCu89CgpnihyWxYdcp1iN76Narf1nfb4aDDFIfPIfqdD9bbjSIoIddutFU/GxJLcmSu3wc5xn47b7EccZm2ix0G8a68Wdbs3wXH2Rj1gm7D1D3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297354; c=relaxed/simple;
	bh=VBWw2k8/sgjWGBuTNFnUMU7by1Vnc47qrR19Rim8fO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4J/JvNxsnn0f5HhhrkrTpUZRVOgtbvjsXZPIvJQIgFBM694f0KwqdxqWN5L4Uj9U6edSIWwfosQrerFYPRJ6H69g3bcUOBVzqUhpGzZOgLpskcIBJpXsS/VzgMpQnQ+CRwzi4+I+o4lropmSwHwwzpla7n6xlu/HKwQfcqwllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-7b-660f957ecaed
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL memory
Date: Fri,  5 Apr 2024 15:08:49 +0900
Message-ID: <20240405060858.2818-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LhesuzSLduKn+awdWZwhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLDq/L2WxuLxrDpvFvTX/WS2OrD/LYrH57Blmi8XL
	1Sz2dTxgsjj89Q2TxeRLC9gsXkw5w2hxctZkFovZR++xOwh7LD39hs1jQxOQ2DnrLrtHy75b
	7B4LNpV6tBx5y+qxeM9LJo9NqzrZPDZ9msTucWLGbxaPnQ8tPV5snsno0dv8js3j8ya5AL4o
	LpuU1JzMstQifbsErozd8xpZCr7mVry5/Ye1gfFRSBcjJ4eEgIlE74XJjDD23btdrCA2m4Ca
	xJWXk5i6GDk4RAQcJFZ9Vehi5OJgFvjPLHG59xcrSFxYwF+i/3YWSDmLgKrEzp7nTCA2r4CZ
	xNTOXUwQIzUlHm//yQ4RF5Q4OfMJC4jNLCAv0bx1NjPITAmBdewSjecWs0E0SEocXHGDZQIj
	7ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERhFy2r/RO9g/HQh+BCjAAejEg+v
	x1y+NCHWxLLiytxDjBIczEoivN0OvGlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQn
	lqRmp6YWpBbBZJk4OKUaGEOW9R3fPGOl+Wwfqe67p7qymyUF2lmOtLD82yD332s+zxHRb6sL
	lVNiq6x+216+6Fm+JnRO3bpfFzfKZS/XWc3OHBZlvoQl7dtus7P1qUIWkmdCOHVjUzZarr61
	7OkjZfEb/1ZsSI5j2/Ou435PVed9lRkeZxnbPhh+4n32YPUkvvUfdoiEL1JiKc5INNRiLipO
	BAAy7bafngIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LhmqGlp1s3lT/NYBqfxcQeA4s569ewWey6
	EWJx/8Frdov/e48xWjz5/5vV4sTNRjaLz89eM1t0PvnOaHF47klWi87vS1ksLu+aw2Zxb81/
	Vosj68+yWGw+e4bZYvFyNYtD156zWuzreMBkcfjrGyaLyZcWsFm8mHKG0eLkrMksFrOP3mN3
	EPdYevoNm8eGJiCxc9Zddo+WfbfYPRZsKvVoOfKW1WPxnpdMHptWdbJ5bPo0id3jxIzfLB47
	H1p6vNg8k9Gjt/kdm8e32x4ei198YPL4vEkuQCCKyyYlNSezLLVI3y6BK2P3vEaWgq+5FW9u
	/2FtYHwU0sXIySEhYCJx924XK4jNJqAmceXlJKYuRg4OEQEHiVVfFboYuTiYBf4zS1zu/cUK
	EhcW8Jfov50FUs4ioCqxs+c5E4jNK2AmMbVzFxPESE2Jx9t/skPEBSVOznzCAmIzC8hLNG+d
	zTyBkWsWktQsJKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAuNmWe2fiTsYv1x2P8Qo
	wMGoxMPrMZcvTYg1say4MvcQowQHs5IIb7cDb5oQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w
	1AQhgfTEktTs1NSC1CKYLBMHp1QD473k1cnCfLtLvnUXGB/yYtiRm7BdTDdKqfWtTvs0pplh
	QjH3n24X8bVWP9A4R5JpjrGt/1W9DfEfjPPYWmbHqwtftfvL/H++aB3zvfnrF9fdVDx7xydN
	sdCrXjH9bfnXgIkHN24Kmr9778X5XtNL+IQW+E05vZTp/zwfh6T7Gv91z4os3PvNRomlOCPR
	UIu5qDgRAKdaX+SXAgAA
X-CFilter-Loop: Reflected

There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
posted at [1].

It says there is no implementation of the demote/promote DAMOS action
are made.  This RFC is about its implementation for physical address
space.


Changes from RFC v2:
  1. Rename DAMOS_{PROMOTE,DEMOTE} actions to DAMOS_MIGRATE_{HOT,COLD}.
  2. Create 'target_nid' to set the migration target node instead of
     depending on node distance based information.
  3. Instead of having page level access check in this patch series,
     delegate the job to a new DAMOS filter type YOUNG[2].
  4. Introduce vmstat counters "damon_migrate_{hot,cold}".
  5. Rebase from v6.7 to v6.8.

Changes from RFC:
  1. Move most of implementation from mm/vmscan.c to mm/damon/paddr.c.
  2. Simplify some functions of vmscan.c and used in paddr.c, but need
     to be reviewed more in depth.
  3. Refactor most functions for common usage for both promote and
     demote actions and introduce an enum migration_mode for its control.
  4. Add "target_nid" sysfs knob for migration destination node for both
     promote and demote actions.
  5. Move DAMOS_PROMOTE before DAMOS_DEMOTE and move then even above
     DAMOS_STAT.


Introduction
============

With the advent of CXL/PCIe attached DRAM, which will be called simply
as CXL memory in this cover letter, some systems are becoming more
heterogeneous having memory systems with different latency and bandwidth
characteristics.  They are usually handled as different NUMA nodes in
separate memory tiers and CXL memory is used as slow tiers because of
its protocol overhead compared to local DRAM.

In this kind of systems, we need to be careful placing memory pages on
proper NUMA nodes based on the memory access frequency.  Otherwise, some
frequently accessed pages might reside on slow tiers and it makes
performance degradation unexpectedly.  Moreover, the memory access
patterns can be changed at runtime.

To handle this problem, we need a way to monitor the memory access
patterns and migrate pages based on their access temperature.  The
DAMON(Data Access MONitor) framework and its DAMOS(DAMON-based Operation
Schemes) can be useful features for monitoring and migrating pages.
DAMOS provides multiple actions based on DAMON monitoring results and it
can be used for proactive reclaim, which means swapping cold pages out
with DAMOS_PAGEOUT action, but it doesn't support migration actions such
as demotion and promotion between tiered memory nodes.

This series supports two new DAMOS actions; DAMOS_MIGRATE_HOT for
promotion from slow tiers and DAMOS_MIGRATE_COLD for demotion from fast
tiers.  This prevents hot pages from being stuck on slow tiers, which
makes performance degradation and cold pages can be proactively demoted
to slow tiers so that the system can increase the chance to allocate
more hot pages to fast tiers.

The DAMON provides various tuning knobs but we found that the proactive
demotion for cold pages is especially useful when the system is running
out of memory on its fast tier nodes.

Our evaluation result shows that it reduces the performance slowdown
compared to the default memory policy from 17~18% to 4~5% when the
system runs under high memory pressure on its fast tier DRAM nodes.


DAMON configuration
===================

The specific DAMON configuration doesn't have to be in the scope of this
patch series, but some rough idea is better to be shared to explain the
evaluation result.

The DAMON provides many knobs for fine tuning but its configuration file
is generated by HMSDK[3].  It includes gen_config.py script that
generates a json file with the full config of DAMON knobs and it creates
multiple kdamonds for each NUMA node when the DAMON is enabled so that
it can run hot/cold based migration for tiered memory.


Evaluation Workload
===================

The performance evaluation is done with redis[4], which is a widely used
in-memory database and the memory access patterns are generated via
YCSB[5].  We have measured two different workloads with zipfian and
latest distributions but their configs are slightly modified to make
memory usage higher and execution time longer for better evaluation.

The idea of evaluation using these migrate_{hot,cold} actions covers
system-wide memory management rather than partitioning hot/cold pages of
a single workload.  The default memory allocation policy creates pages
to the fast tier DRAM node first, then allocates newly created pages to
the slow tier CXL node when the DRAM node has insufficient free space.
Once the page allocation is done then those pages never move between
NUMA nodes.  It's not true when using numa balancing, but it is not the
scope of this DAMON based tiered memory management support.

If the working set of redis can be fit fully into the DRAM node, then
the redis will access the fast DRAM only.  Since the performance of DRAM
only is faster than partially accessing CXL memory in slow tiers, this
environment is not useful to evaluate this patch series.

To make pages of redis be distributed across fast DRAM node and slow
CXL node to evaluate our migrate_{hot,cold} actions, we pre-allocate
some cold memory externally using mmap and memset before launching
redis-server.  We assumed that there are enough amount of cold memory in
datacenters as TMO[6] and TPP[7] papers mentioned.

The evaluation sequence is as follows.

1. Turn on DAMON with DAMOS_MIGRATE_COLD action for DRAM node and
   DAMOS_MIGRATE_HOT action for CXL node.  It demotes cold pages on DRAM
   node and promotes hot pages on CXL node in a regular interval.
2. Allocate a huge block of cold memory by calling mmap and memset at
   the fast tier DRAM node, then make the process sleep to make the fast
   tier has insufficient space for redis-server.
3. Launch redis-server and load prebaked snapshot image, dump.rdb.  The
   redis-server consumes 52GB of anon pages and 33GB of file pages, but
   due to the cold memory allocated at 2, it fails allocating the entire
   memory of redis-server on the fast tier DRAM node so it partially
   allocates the remaining on the slow tier CXL node.  The ratio of
   DRAM:CXL depends on the size of the pre-allocated cold memory.
4. Run YCSB to make zipfian or latest distribution of memory accesses to
   redis-server, then measure its execution time when it's completed.
5. Repeat 4 over 50 times to measure the average execution time for each
   run.
6. Increase the cold memory size then repeat goes to 2.

For each test at 4 took about a minute so repeating it 50 times almost
took about 1 hour for each test with a specific cold memory from 440GB
to 500GB in 10GB increments for each evaluation.  So it took about more
than 10 hours for both zipfian and latest workloads to get the entire
evaluation results.  Repeating the same test set multiple times doesn't
show much difference so I think it might be enough to make the result
reliable.


Evaluation Results
==================

All the result values are normalized to DRAM-only execution time because
the workload cannot be faster than DRAM-only unless the workload hits
the peak bandwidth but our redis test doesn't go beyond the bandwidth
limit.

So the DRAM-only execution time is the ideal result without affected by
the gap between DRAM and CXL performance difference.  The NUMA node
environment is as follows.

  node0 - local DRAM, 512GB with a CPU socket (fast tier)
  node1 - disabled
  node2 - CXL DRAM, 96GB, no CPU attached (slow tier)

The following is the result of generating zipfian distribution to
redis-server and the numbers are averaged by 50 times of execution.

  1. YCSB zipfian distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  =============+================================================+=========
               |       cold memory occupied by mmap and memset  |
               |   0G  440G  450G  460G  470G  480G  490G  500G |
  =============+================================================+=========
  Execution time normalized to DRAM-only values                 | GEOMEAN
  -------------+------------------------------------------------+---------
  DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only     | 1.22     -     -     -     -     -     -     - | 1.22
  default      |    -  1.12  1.13  1.14  1.16  1.19  1.21  1.21 | 1.17 
  DAMON tiered |    -  1.04  1.03  1.04  1.06  1.05  1.05  1.05 | 1.05 
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  20.4  27.0  33.1  39.5  45.6  50.5  50.3 | 38.1
  DAMON tiered |    -   0.1   0.3   0.8   0.6   0.7   1.3   0.9 |  0.7
  =============+================================================+=========

Each test result is based on the exeuction environment as follows.

  DRAM-only   : redis-server uses only local DRAM memory.
  CXL-only    : redis-server uses only CXL memory.
  default     : default memory policy(MPOL_DEFAULT).
                numa balancing disabled.
  DAMON tiered: DAMON enabled with DAMOS_MIGRATE_COLD for DRAM nodes and
                DAMOS_MIGRATE_HOT for CXL nodes.

The above result shows the "default" execution time goes up as the size
of cold memory is increased from 440G to 500G because the more cold
memory used, the more CXL memory is used for the target redis workload
and this makes the execution time increase.

However, "DAMON tiered" result shows less slowdown because the
DAMOS_MIGRATE_COLD action at DRAM node proactively demotes pre-allocated
cold memory to CXL node and this free space at DRAM increases more
chance to allocate hot or warm pages of redis-server to fast DRAM node.
Moreover, DAMOS_MIGRATE_HOT action at CXL node also promotes hot pages
of redis-server to DRAM node actively.

As a result, it makes more memory of redis-server stay in DRAM node
compared to "default" memory policy and this makes the performance
improvement.

The following result of latest distribution workload shows similar data.

  2. YCSB latest distribution read only workload
  memory pressure with cold memory on node0 with 512GB of local DRAM.
  =============+================================================+=========
               |       cold memory occupied by mmap and memset  |
               |   0G  440G  450G  460G  470G  480G  490G  500G |
  =============+================================================+=========
  Execution time normalized to DRAM-only values                 | GEOMEAN
  -------------+------------------------------------------------+---------
  DRAM-only    | 1.00     -     -     -     -     -     -     - | 1.00
  CXL-only     | 1.18     -     -     -     -     -     -     - | 1.18
  default      |    -  1.18  1.19  1.18  1.18  1.17  1.19  1.18 | 1.18 
  DAMON tiered |    -  1.04  1.04  1.04  1.05  1.04  1.05  1.05 | 1.04 
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  20.5  27.1  33.2  39.5  45.5  50.4  50.5 | 38.1
  DAMON tiered |    -   0.2   0.4   0.7   1.6   1.2   1.1   3.4 |  1.2
  =============+================================================+=========

In summary of both results, our evaluation shows that "DAMON tiered"
memory management reduces the performance slowdown compared to the
"default" memory policy from 17~18% to 4~5% when the system runs with
high memory pressure on its fast tier DRAM nodes.

Having these DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD actions can make
tiered memory systems run more efficiently under high memory pressures.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>

[1] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org
[2] https://lore.kernel.org/damon/20240311204545.47097-1-sj@kernel.org
[3] https://github.com/skhynix/hmsdk
[4] https://github.com/redis/redis/tree/7.0.0
[5] https://github.com/brianfrankcooper/YCSB/tree/0.17.0
[6] https://dl.acm.org/doi/10.1145/3503222.3507731
[7] https://dl.acm.org/doi/10.1145/3582016.3582063


Honggyu Kim (5):
  mm/damon/paddr: refactor DAMOS_PAGEOUT with migration_mode
  mm: make alloc_demote_folio externally invokable for migration
  mm/migrate: add MR_DAMON to migrate_reason
  mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
  mm/damon: Add "damon_migrate_{hot,cold}" vmstat

Hyeongtak Ji (2):
  mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
  mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion

 include/linux/damon.h          |  15 ++-
 include/linux/migrate_mode.h   |   1 +
 include/linux/mmzone.h         |   4 +
 include/trace/events/migrate.h |   3 +-
 mm/damon/core.c                |   5 +-
 mm/damon/dbgfs.c               |   2 +-
 mm/damon/lru_sort.c            |   3 +-
 mm/damon/paddr.c               | 191 +++++++++++++++++++++++++++++++--
 mm/damon/reclaim.c             |   3 +-
 mm/damon/sysfs-schemes.c       |  39 ++++++-
 mm/internal.h                  |   1 +
 mm/vmscan.c                    |  10 +-
 mm/vmstat.c                    |   4 +
 13 files changed, 265 insertions(+), 16 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.34.1


