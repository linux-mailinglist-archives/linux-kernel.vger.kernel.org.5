Return-Path: <linux-kernel+bounces-25621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E982D3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8D81F21303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DF3C15;
	Mon, 15 Jan 2024 04:53:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F817CF;
	Mon, 15 Jan 2024 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-26-65a4ba2b41f8
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>
Subject: [RFC PATCH 0/4] DAMON based 2-tier memory management for CXL memory
Date: Mon, 15 Jan 2024 13:52:48 +0900
Message-ID: <20240115045253.1775-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LhesuzUFdn15JUg6OPGC3mrF/DZrHrRojF
	/73HGC2e/P/NanHiZiObRef3pSwWl3fNYbO4t+Y/q8WR9WdZLNbdArI2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj/8HJzF7LD39hs1jQxOQaNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJWxcMdi5oKXKRUbnh1ma2C879vFyMkhIWAicefSLUYYu+PGPyYQm01ATeLKy0lA
	NgeHiICDxKqvCl2MXBzMApNYJLY+WgZWLyzgI/Fs/0E2EJtFQFXi2YXVYL28AmYSM5fMYIWY
	qSnxePtPdoi4oMTJmU9YQGxmAXmJ5q2zmUGGSgisYpeYtn4FVIOkxMEVN1gmMPLOQtIzC0nP
	AkamVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiB8bOs9k/0DsZPF4IPMQpwMCrx8P74uzhViDWx
	rLgy9xCjBAezkgjvwecLUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1I
	LYLJMnFwSjUw+hZZ39rmcyv73xr+SKFe0TO7RP6HrZZ8UrXQxpE9IrzhYHbxtCQxiVcnd20L
	mG3DkmxWE/PZ8rav4G0ZkUyr+bzGN3dxeOp7SixVFxXalTClm8dW/bKchOancz/TXgr59s2e
	63pU4hMfk0ujS9Kd6verH91i4YiXclGuV1mxY+m3f2rxxuuUWIozEg21mIuKEwG5oKXpmwIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LhmqGlp6u9a0mqQdtvWYs569ewWey6EWLx
	f+8xRosn/3+zWpy42chm8fnZa2aLziffGS0Ozz3JatH5fSmLxeVdc9gs7q35z2pxZP1ZFot1
	t4CszWfPMFssXq5mcejac1aLfR0PmCwOf33DZDH50gI2ixdTzjBanJw1mcVi9tF77A5iHv8P
	TmL2WHr6DZvHhiYg0bLvFrvHgk2lHi1H3rJ6LN7zkslj06pONo9Nnyaxe5yY8ZvFY+dDS48X
	m2cyevQ2v2Pz+Hbbw2Pxiw9MHp83yQUIRHHZpKTmZJalFunbJXBlLNyxmLngZUrFhmeH2RoY
	7/t2MXJySAiYSHTc+McEYrMJqElceTkJyObgEBFwkFj1VaGLkYuDWWASi8TWR8sYQWqEBXwk
	nu0/yAZiswioSjy7sBqsl1fATGLmkhmsEDM1JR5v/8kOEReUODnzCQuIzSwgL9G8dTbzBEau
	WUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBLzs/dxAiMmWW1fybuYPxy2f0QowAHoxIP
	74+/i1OFWBPLiitzDzFKcDArifAefL4gVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBA
	emJJanZqakFqEUyWiYNTqoGx58Af33/5cr7BP+KC/55luPF4eVzNpsvzVrq3+BxUX7hejmHr
	v3d6rVfSi2/YfNIvSOw8mlUUX/Or7c9iyxupW4R35ZRWpD+svLWet6adj7vQ+ds/y0Xnmb5s
	fNedamNitkVlperdTXwrPs0MeeR8KXjLgjdO2puNMrQV1/EfODuvLKmltaVAiaU4I9FQi7mo
	OBEA6YqQS5UCAAA=
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
heterogenous having memory systems with different latency and bandwidth
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
  DRAM-only    | 1.00  -     -     -     -     -     -     -    | 1.00
  CXL-only     | 1.18  -     -     -     -     -     -     -    | 1.18
  default      | -     1.16  1.15  1.17  1.18  1.16  1.18  1.15 | 1.17
  DAMON 2-tier | -     1.04  1.04  1.05  1.05  1.06  1.05  1.06 | 1.05
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

Honggyu Kim (2):
  mm/vmscan: refactor reclaim_pages with reclaim_or_migrate_folios
  mm/damon: introduce DAMOS_DEMOTE action for demotion

Hyeongtak Ji (2):
  mm/memory-tiers: add next_promotion_node to find promotion target
  mm/damon: introduce DAMOS_PROMOTE action for promotion

 include/linux/damon.h          |   4 +
 include/linux/memory-tiers.h   |  11 ++
 include/linux/migrate_mode.h   |   1 +
 include/linux/vm_event_item.h  |   1 +
 include/trace/events/migrate.h |   3 +-
 mm/damon/paddr.c               |  46 ++++++-
 mm/damon/sysfs-schemes.c       |   2 +
 mm/internal.h                  |   2 +
 mm/memory-tiers.c              |  43 ++++++
 mm/vmscan.c                    | 231 +++++++++++++++++++++++++++++++--
 mm/vmstat.c                    |   1 +
 11 files changed, 330 insertions(+), 15 deletions(-)


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.34.1


