Return-Path: <linux-kernel+bounces-81580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09408677D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC011F2BC00
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89A12A14A;
	Mon, 26 Feb 2024 14:06:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DA128363;
	Mon, 26 Feb 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956380; cv=none; b=i8/4Rhf+r5J+jVW9rquFz6zQqFN7g1dNpHRFO8KoO/TEJ47z6r9trhu5vqyrVwnDnnb/HE4ypsfsfqPPaaMPtReC6G7KVFzAjwf5EAoTu09IVcOv5zBXwTAamaf8ZFRPOkLeXAEUYAQfnN7TkVZaO+6AfelariGtWCcouKM1WmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956380; c=relaxed/simple;
	bh=6J5lzZzJ2s6aeUaBDM+mo7+6ip9QBH9WEYMKkcPKvQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFzFzW89cO0MZxKrHT8W3KOAb3tjh4zwVceDfkvRVfWYmwka4KdNIo4gIu38dnNtH/atTYrvZUdUl3Z/JZH6s/ONQgy/zYlbQ3V0OWCQgvLwBHTUp5mHS85Yo5YrnueBmZzuLKO2Qw/ifrB/SzuVUyrkCR1lNOhb4Ab62vL1MVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-5a-65dc9ad4fbd9
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
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Mon, 26 Feb 2024 23:05:46 +0900
Message-ID: <20240226140555.1615-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC9ZZnoe6VWXdSDbZv1rGY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBlrH96mrHgQ3bFn+W/WBoYfwZ1MXJySAiYSOxoOsAIY09pWsIM
	YrMJqElceTmJqYuRg0NEwEFi1VeFLkYuDmaBBhaJH58vsYDUCAv4S+z5NRHMZhFQlVjXNgds
	Dq+AmcTy1kZWiJmaEo+3/2SHiAtKnJz5BKyeWUBeonnrbGaQoRIC69gltvfNZ4ZokJQ4uOIG
	ywRG3llIemYh6VnAyLSKUSgzryw3MTPHRC+jMi+zQi85P3cTIzCiltX+id7B+OlC8CFGAQ5G
	JR5eh9o7qUKsiWXFlbmHGCU4mJVEeMNlbqYK8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4i
	JJCeWJKanZpakFoEk2Xi4JRqYFRPuXQs1uzq9COu1uvXVG9+cOnb2miu04wpB9R/8v//mxvC
	MG/N3MVrvMUnfrJ0kTY7/pqf98yb5wqcRjzeFvd43m2JUOCYsPjx8U3Pnm7fMiHvz6wZzbUP
	XsW92Pth7YF/R+JTF15cnD7npFdTzP/i7Xe0tGOytc/E69rtufqnV1X3o67JvoZpSizFGYmG
	WsxFxYkA5nVRkqQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LhmqGlp3tl1p1Ug845khYTewws5qxfw2ax
	60aIxf+9xxgtnvz/zWpx4mYjm8XnZ6+ZLTqffGe0ODz3JKtF5/elLBaXd81hs7i35j+rxZH1
	Z1ks1t0CsjafPcNssXi5msWha89ZLfZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7
	iHv8PziJ2WPp6TdsHhuagMTOWXfZPVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8T
	M36zeOx8aOnxYvNMRo/e5ndsHt9ue3gsfvGBKUAwissmJTUnsyy1SN8ugStj/dPTjAUfsiv+
	LP/F0sD4M6iLkZNDQsBEYkrTEmYQm01ATeLKy0lMXYwcHCICDhKrvip0MXJxMAs0sEj8+HyJ
	BaRGWMBfYs+viWA2i4CqxLq2OYwgNq+AmcTy1kZWiJmaEo+3/2SHiAtKnJz5BKyeWUBeonnr
	bOYJjFyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERg9y2r/TNzB+OWy+yFG
	AQ5GJR5eh9o7qUKsiWXFlbmHGCU4mJVEeMNlbqYK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UK
	T00QEkhPLEnNTk0tSC2CyTJxcEo1MIZdeRoa+9WWx0PiOss9ke9ftFLLRbYJiFaXyHFcTZ8S
	t2LjvUeST6OztkrvUdm/8Awj413hvc256k1nHB4JzP2RYKgt88HnxmmZu/6lb3KMfdlNT2l3
	78jOljzfeuD431dneCpOvN79cfGpLu4tUmd658i+ZPKuOZ6UHyYZ5PQ3b97zVo6ra5RYijMS
	DbWYi4oTATv31NWaAgAA
X-CFilter-Loop: Reflected

There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
posted at [1].

It says there is no implementation of the demote/promote DAMOS action
are made.  This RFC is about its implementation for physical address
space.


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

This series supports two new DAMOS actions; DAMOS_DEMOTE for demotion
from fast tiers and DAMOS_PROMOTE for promotion from slow tiers.  This
prevents hot pages from being stuck on slow tiers, which makes
performance degradation and cold pages can be proactively demoted to
slow tiers so that the system can increase the chance to allocate more
hot pages to fast tiers.

The DAMON provides various tuning knobs but we found that the proactive
demotion for cold pages is especially useful when the system is running
out of memory on its fast tier nodes.

Our evaluation result shows that it reduces the performance slowdown
compared to the default memory policy from 15~17% to 4~5% when the
system runs under high memory pressure on its fast tier DRAM nodes.


DAMON configuration
===================

The specific DAMON configuration doesn't have to be in the scope of this
patch series, but some rough idea is better to be shared to explain the
evaluation result.

The DAMON provides many knobs for fine tuning but its configuration file
is generated by HMSDK[2].  It includes gen_config.py script that
generates a json file with the full config of DAMON knobs and it creates
multiple kdamonds for each NUMA node when the DAMON is enabled so that
it can run hot/cold based migration for tiered memory.


Evaluation Workload
===================

The performance evaluation is done with redis[3], which is a widely used
in-memory database and the memory access patterns are generated via
YCSB[4].  We have measured two different workloads with zipfian and
latest distributions but their configs are slightly modified to make
memory usage higher and execution time longer for better evaluation.

The idea of evaluation using these demote and promote actions covers
system-wide memory management rather than partitioning hot/cold pages of
a single workload.  The default memory allocation policy creates pages
to the fast tier DRAM node first, then allocates newly created pages to
the slow tier CXL node when the DRAM node has insufficient free space.
Once the page allocation is done then those pages never move between
NUMA nodes.  It's not true when using numa balancing, but it is not the
scope of this DAMON based 2-tier memory management support.

If the working set of redis can be fit fully into the DRAM node, then
the redis will access the fast DRAM only.  Since the performance of DRAM
only is faster than partially accessing CXL memory in slow tiers, this
environment is not useful to evaluate this patch series.

To make pages of redis be distributed across fast DRAM node and slow
CXL node to evaluate our demote and promote actions, we pre-allocate
some cold memory externally using mmap and memset before launching
redis-server.  We assumed that there are enough amount of cold memory in
datacenters as TMO[5] and TPP[6] papers mentioned.

The evaluation sequence is as follows.

1. Turn on DAMON with DAMOS_DEMOTE action for DRAM node and
   DAMOS_PROMOTE action for CXL node.  It demotes cold pages on DRAM
   node and promotes hot pages on CXL node in a regular interval.
2. Allocate a huge block of cold memory by calling mmap and memset at
   the fast tier DRAM node, then make the process sleep to make the fast
   tier has insufficient memory for redis-server.
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
the bandwidth peak but our redis test doesn't go beyond the bandwidth
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
  CXL-only     | 1.21     -     -     -     -     -     -     - | 1.21
  default      |    -  1.09  1.10  1.13  1.15  1.18  1.21  1.21 | 1.15
  DAMON 2-tier |    -  1.02  1.04  1.05  1.04  1.05  1.05  1.06 | 1.04
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  19.4  26.1  32.3  38.5  44.7  50.5  50.3 | 37.4
  DAMON 2-tier |    -   0.1   1.6   5.2   8.0   9.1  11.8  13.6 |  7.1
  =============+================================================+=========

Each test result is based on the exeuction environment as follows.

  DRAM-only   : redis-server uses only local DRAM memory.
  CXL-only    : redis-server uses only CXL memory.
  default     : default memory policy(MPOL_DEFAULT).
                numa balancing disabled.
  DAMON 2-tier: DAMON enabled with DAMOS_DEMOTE for DRAM nodes and
                DAMOS_PROMOTE for CXL nodes.

The above result shows the "default" execution time goes up as the size
of cold memory is increased from 440G to 500G because the more cold
memory used, the more CXL memory is used for the target redis workload
and this makes the execution time increase.

However, "DAMON 2-tier" result shows less slowdown because the
DAMOS_DEMOTE action at DRAM node proactively demotes pre-allocated cold
memory to CXL node and this free space at DRAM increases more chance to
allocate hot or warm pages of redis-server to fast DRAM node.  Moreover,
DEMOS_PROMOTE action at CXL node also promotes hot pages of redis-server
to DRAM node actively.

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
  default      |    -  1.16  1.15  1.17  1.18  1.16  1.18  1.15 | 1.17
  DAMON 2-tier |    -  1.04  1.04  1.05  1.05  1.06  1.05  1.06 | 1.05
  =============+================================================+=========
  CXL usage of redis-server in GB                               | AVERAGE
  -------------+------------------------------------------------+---------
  DRAM-only    |  0.0     -     -     -     -     -     -     - |  0.0
  CXL-only     | 52.6     -     -     -     -     -     -     - | 52.6
  default      |    -  19.3  26.1  32.2  38.5  44.6  50.5  50.6 | 37.4
  DAMON 2-tier |    -   1.3   3.8   7.0   4.1   9.4  12.5  16.7 |  7.8
  =============+================================================+=========

In summary of both results, our evaluation shows that "DAMON 2-tier"
memory management reduces the performance slowdown compared to the
"default" memory policy from 15~17% to 4~5% when the system runs with
high memory pressure on its fast tier DRAM nodes.

The similar evaluation was done in another machine that has 256GB of
local DRAM and 96GB of CXL memory.  The performance slowdown is reduced
from 20~24% for "default" to 5~7% for "DAMON 2-tier".

Having these DAMOS_DEMOTE and DAMOS_PROMOTE actions can make 2-tier
memory systems run more efficiently under high memory pressures.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>

[1] https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org
[2] https://github.com/skhynix/hmsdk
[3] https://github.com/redis/redis/tree/7.0.0
[4] https://github.com/brianfrankcooper/YCSB/tree/0.17.0
[5] https://dl.acm.org/doi/10.1145/3503222.3507731
[6] https://dl.acm.org/doi/10.1145/3582016.3582063

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

Honggyu Kim (3):
  mm/damon: refactor DAMOS_PAGEOUT with migration_mode
  mm: make alloc_demote_folio externally invokable for migration
  mm/damon: introduce DAMOS_DEMOTE action for demotion

Hyeongtak Ji (4):
  mm/memory-tiers: add next_promotion_node to find promotion target
  mm/damon: introduce DAMOS_PROMOTE action for promotion
  mm/damon/sysfs-schemes: add target_nid on sysfs-schemes
  mm/damon/sysfs-schemes: apply target_nid for promote and demote
    actions

 include/linux/damon.h          |  15 +-
 include/linux/memory-tiers.h   |  11 ++
 include/linux/migrate_mode.h   |   1 +
 include/linux/vm_event_item.h  |   1 +
 include/trace/events/migrate.h |   3 +-
 mm/damon/core.c                |   5 +-
 mm/damon/dbgfs.c               |   2 +-
 mm/damon/lru_sort.c            |   3 +-
 mm/damon/paddr.c               | 282 ++++++++++++++++++++++++++++++++-
 mm/damon/reclaim.c             |   3 +-
 mm/damon/sysfs-schemes.c       |  39 ++++-
 mm/internal.h                  |   1 +
 mm/memory-tiers.c              |  43 +++++
 mm/vmscan.c                    |  10 +-
 mm/vmstat.c                    |   1 +
 15 files changed, 404 insertions(+), 16 deletions(-)


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.34.1


