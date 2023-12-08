Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB2A809C8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjLHGk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHGk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:40:26 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FDD1722;
        Thu,  7 Dec 2023 22:40:29 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SmhNB14MVz14LvP;
        Fri,  8 Dec 2023 14:40:26 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 14:40:27 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <james.clark@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Jonathan.Cameron@huawei.com>, <zhanjie9@hisilicon.com>,
        <21cnbao@gmail.com>, <tim.c.chen@intel.com>,
        <prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v4] perf stat: Support per-cluster aggregation
Date:   Fri, 8 Dec 2023 14:36:40 +0800
Message-ID: <20231208063640.25877-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Some platforms have 'cluster' topology and CPUs in the cluster will
share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
cache (for Intel Jacobsville). Currently parsing and building cluster
topology have been supported since [1].

perf stat has already supported aggregation for other topologies like
die or socket, etc. It'll be useful to aggregate per-cluster to find
problems like L3T bandwidth contention.

This patch add support for "--per-cluster" option for per-cluster
aggregation. Also update the docs and related test. The output will
be like:

[root@localhost tmp]# perf stat -a -e LLC-load --per-cluster -- sleep 5

 Performance counter stats for 'system wide':

S56-D0-CLS158    4      1,321,521,570      LLC-load
S56-D0-CLS594    4        794,211,453      LLC-load
S56-D0-CLS1030    4             41,623      LLC-load
S56-D0-CLS1466    4             41,646      LLC-load
S56-D0-CLS1902    4             16,863      LLC-load
S56-D0-CLS2338    4             15,721      LLC-load
S56-D0-CLS2774    4             22,671      LLC-load
[...]

On a legacy system without cluster or cluster support, the output will
be look like:
[root@localhost perf]# perf stat -a -e cycles --per-cluster -- sleep 1

 Performance counter stats for 'system wide':

S56-D0-CLS0   64         18,011,485      cycles
S7182-D0-CLS0   64         16,548,835      cycles

Note that this patch doesn't mix the cluster information in the outputs
of --per-core to avoid breaking any tools/scripts using it.

Note that perf recently supports "--per-cache" aggregation, but it's not
the same with the cluster although cluster CPUs may share some cache
resources. For example on my machine all clusters within a die share the
same L3 cache:
$ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
0-31
$ cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
0-3

[1] commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")
Tested-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v3:
- Rebase on v6.7-rc4 and resolve the conflicts
Link: https://lore.kernel.org/all/20230404104951.27537-1-yangyicong@huawei.com/

Change since v2:
- Use 0 as cluster ID on legacy system without cluster support, keep consistenct
  with what --per-die does.
Link: https://lore.kernel.org/all/20230328112717.19573-1-yangyicong@huawei.com/

Change since v1:
- Provides the information about how to map the cluster to the CPUs in the manual
- Thanks the review from Tim and test from Jie.
Link: https://lore.kernel.org/all/20230313085911.61359-1-yangyicong@huawei.com/

 tools/perf/Documentation/perf-stat.txt        | 11 ++++
 tools/perf/builtin-stat.c                     | 52 +++++++++++++++++--
 .../tests/shell/lib/perf_json_output_lint.py  |  4 +-
 tools/perf/tests/shell/lib/stat_output.sh     | 12 +++++
 tools/perf/tests/shell/stat+csv_output.sh     |  2 +
 tools/perf/tests/shell/stat+json_output.sh    | 13 +++++
 tools/perf/util/cpumap.c                      | 32 +++++++++++-
 tools/perf/util/cpumap.h                      | 19 +++++--
 tools/perf/util/env.h                         |  1 +
 tools/perf/util/stat-display.c                | 13 +++++
 tools/perf/util/stat.h                        |  1 +
 11 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8f789fa1242e..2a34edda1763 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -308,6 +308,14 @@ use --per-die in addition to -a. (system-wide).  The output includes the
 die number and the number of online processors on that die. This is
 useful to gauge the amount of aggregation.
 
+--per-cluster::
+Aggregate counts per processor cluster for system-wide mode measurement.  This
+is a useful mode to detect imbalance between clusters.  To enable this mode,
+use --per-cluster in addition to -a. (system-wide).  The output includes the
+cluster number and the number of online processors on that cluster. This is
+useful to gauge the amount of aggregation. The information of cluster ID and
+related CPUs can be gotten from /sys/devices/system/cpu/cpuX/topology/cluster_{id, cpus}.
+
 --per-cache::
 Aggregate counts per cache instance for system-wide mode measurements.  By
 default, the aggregation happens for the cache level at the highest index
@@ -396,6 +404,9 @@ Aggregate counts per processor socket for system-wide mode measurements.
 --per-die::
 Aggregate counts per processor die for system-wide mode measurements.
 
+--per-cluster::
+Aggregate counts perf processor cluster for system-wide mode measurements.
+
 --per-cache::
 Aggregate counts per cache instance for system-wide mode measurements.  By
 default, the aggregation happens for the cache level at the highest index
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a3af805a1d57..7cd93d3827b1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1237,6 +1237,8 @@ static struct option stat_options[] = {
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &stat_config.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_SET_UINT(0, "per-cluster", &stat_config.aggr_mode,
+		     "aggregate counts per processor cluster", AGGR_CLUSTER),
 	OPT_CALLBACK_OPTARG(0, "per-cache", &stat_config.aggr_mode, &stat_config.aggr_level,
 			    "cache level", "aggregate count at this cache level (Default: LLC)",
 			    parse_cache_level),
@@ -1427,6 +1429,7 @@ static struct aggr_cpu_id aggr_cpu_id__cache(struct perf_cpu cpu, void *data)
 static const char *const aggr_mode__string[] = {
 	[AGGR_CORE] = "core",
 	[AGGR_CACHE] = "cache",
+	[AGGR_CLUSTER] = "cluster",
 	[AGGR_DIE] = "die",
 	[AGGR_GLOBAL] = "global",
 	[AGGR_NODE] = "node",
@@ -1454,6 +1457,12 @@ static struct aggr_cpu_id perf_stat__get_cache_id(struct perf_stat_config *confi
 	return aggr_cpu_id__cache(cpu, /*data=*/NULL);
 }
 
+static struct aggr_cpu_id perf_stat__get_cluster(struct perf_stat_config *config __maybe_unused,
+						 struct perf_cpu cpu)
+{
+	return aggr_cpu_id__cluster(cpu, /*data=*/NULL);
+}
+
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
 					      struct perf_cpu cpu)
 {
@@ -1506,6 +1515,12 @@ static struct aggr_cpu_id perf_stat__get_die_cached(struct perf_stat_config *con
 	return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
 }
 
+static struct aggr_cpu_id perf_stat__get_cluster_cached(struct perf_stat_config *config,
+							struct perf_cpu cpu)
+{
+	return perf_stat__get_aggr(config, perf_stat__get_cluster, cpu);
+}
+
 static struct aggr_cpu_id perf_stat__get_cache_id_cached(struct perf_stat_config *config,
 							 struct perf_cpu cpu)
 {
@@ -1543,6 +1558,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 		return aggr_cpu_id__socket;
 	case AGGR_DIE:
 		return aggr_cpu_id__die;
+	case AGGR_CLUSTER:
+		return aggr_cpu_id__cluster;
 	case AGGR_CACHE:
 		return aggr_cpu_id__cache;
 	case AGGR_CORE:
@@ -1568,6 +1585,8 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_cached;
 	case AGGR_DIE:
 		return perf_stat__get_die_cached;
+	case AGGR_CLUSTER:
+		return perf_stat__get_cluster_cached;
 	case AGGR_CACHE:
 		return perf_stat__get_cache_id_cached;
 	case AGGR_CORE:
@@ -1736,6 +1755,21 @@ static struct aggr_cpu_id perf_env__get_cache_aggr_by_cpu(struct perf_cpu cpu,
 	return id;
 }
 
+static struct aggr_cpu_id perf_env__get_cluster_aggr_by_cpu(struct perf_cpu cpu,
+							    void *data)
+{
+	struct perf_env *env = data;
+	struct aggr_cpu_id id = aggr_cpu_id__empty();
+
+	if (cpu.cpu != -1) {
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
+		id.cluster = env->cpu[cpu.cpu].cluster_id;
+	}
+
+	return id;
+}
+
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1743,12 +1777,12 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, vo
 
 	if (cpu.cpu != -1) {
 		/*
-		 * core_id is relative to socket and die,
-		 * we need a global id. So we set
-		 * socket, die id and core id
+		 * core_id is relative to socket, die and cluster, we need a
+		 * global id. So we set socket, die id, cluster id and core id.
 		 */
 		id.socket = env->cpu[cpu.cpu].socket_id;
 		id.die = env->cpu[cpu.cpu].die_id;
+		id.cluster = env->cpu[cpu.cpu].cluster_id;
 		id.core = env->cpu[cpu.cpu].core_id;
 	}
 
@@ -1804,6 +1838,12 @@ static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *confi
 	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
+static struct aggr_cpu_id perf_stat__get_cluster_file(struct perf_stat_config *config __maybe_unused,
+						      struct perf_cpu cpu)
+{
+	return perf_env__get_cluster_aggr_by_cpu(cpu, &perf_stat.session->header.env);
+}
+
 static struct aggr_cpu_id perf_stat__get_cache_file(struct perf_stat_config *config __maybe_unused,
 						    struct perf_cpu cpu)
 {
@@ -1841,6 +1881,8 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 		return perf_env__get_socket_aggr_by_cpu;
 	case AGGR_DIE:
 		return perf_env__get_die_aggr_by_cpu;
+	case AGGR_CLUSTER:
+		return perf_env__get_cluster_aggr_by_cpu;
 	case AGGR_CACHE:
 		return perf_env__get_cache_aggr_by_cpu;
 	case AGGR_CORE:
@@ -1866,6 +1908,8 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
 		return perf_stat__get_socket_file;
 	case AGGR_DIE:
 		return perf_stat__get_die_file;
+	case AGGR_CLUSTER:
+		return perf_stat__get_cluster_file;
 	case AGGR_CACHE:
 		return perf_stat__get_cache_file;
 	case AGGR_CORE:
@@ -2397,6 +2441,8 @@ static int __cmd_report(int argc, const char **argv)
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
 		     "aggregate counts per processor die", AGGR_DIE),
+	OPT_SET_UINT(0, "per-cluster", &perf_stat.aggr_mode,
+		     "aggregate counts perf processor cluster", AGGR_CLUSTER),
 	OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_stat.aggr_level,
 			    "cache level",
 			    "aggregate count at this cache level (Default: LLC)",
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index ea55d5ea1ced..abc1fd737782 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -15,6 +15,7 @@ ap.add_argument('--event', action='store_true')
 ap.add_argument('--per-core', action='store_true')
 ap.add_argument('--per-thread', action='store_true')
 ap.add_argument('--per-cache', action='store_true')
+ap.add_argument('--per-cluster', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
@@ -49,6 +50,7 @@ def check_json_output(expected_items):
       'cgroup': lambda x: True,
       'cpu': lambda x: isint(x),
       'cache': lambda x: True,
+      'cluster': lambda x: True,
       'die': lambda x: True,
       'event': lambda x: True,
       'event-runtime': lambda x: isfloat(x),
@@ -88,7 +90,7 @@ try:
     expected_items = 7
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 8
-  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache:
+  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cluster or args.per_cache:
     expected_items = 9
   else:
     # If no option is specified, don't check the number of items.
diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index 3cc158a64326..c81d6a9f7983 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -97,6 +97,18 @@ check_per_cache_instance()
 	echo "[Success]"
 }
 
+check_per_cluster()
+{
+	echo -n "Checking $1 output: per cluster "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-cluster -a $2 true
+	echo "[Success]"
+}
+
 check_per_die()
 {
 	echo -n "Checking $1 output: per die "
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index f1818fa6d9ce..fc2d8cc6e5e0 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -42,6 +42,7 @@ function commachecker()
 	;; "--per-socket")	exp=8
 	;; "--per-node")	exp=8
 	;; "--per-die")		exp=8
+	;; "--per-cluster")	exp=8
 	;; "--per-cache")	exp=8
 	esac
 
@@ -79,6 +80,7 @@ then
 	check_system_wide_no_aggr "CSV" "$perf_cmd"
 	check_per_core "CSV" "$perf_cmd"
 	check_per_cache_instance "CSV" "$perf_cmd"
+	check_per_cluster "CSV" "$perf_cmd"
 	check_per_die "CSV" "$perf_cmd"
 	check_per_socket "CSV" "$perf_cmd"
 else
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 196e22672c50..4e278fb3a9dd 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -132,6 +132,18 @@ check_per_cache_instance()
 	echo "[Success]"
 }
 
+check_per_cluster()
+{
+	echo -n "Checking json output: per cluster "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoia and not root"
+		return
+	fi
+	perf stat -j --per-cluster -a true 2>&1 | $PYTHON $pythonchecker --per-cluster
+	echo "[Success]"
+}
+
 check_per_die()
 {
 	echo -n "Checking json output: per die "
@@ -210,6 +222,7 @@ then
 	check_system_wide_no_aggr
 	check_per_core
 	check_per_cache_instance
+	check_per_cluster
 	check_per_die
 	check_per_socket
 else
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0e090e8bc334..565a8ecb65a8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -222,6 +222,8 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
 		return a->socket - b->socket;
 	else if (a->die != b->die)
 		return a->die - b->die;
+	else if (a->cluster != b->cluster)
+		return a->cluster - b->cluster;
 	else if (a->cache_lvl != b->cache_lvl)
 		return a->cache_lvl - b->cache_lvl;
 	else if (a->cache != b->cache)
@@ -309,6 +311,29 @@ struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 	return id;
 }
 
+int cpu__get_cluster_id(struct perf_cpu cpu)
+{
+	int value, ret = cpu__get_topology_int(cpu.cpu, "cluster_id", &value);
+	return ret ?: value;
+}
+
+struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data)
+{
+	int cluster = cpu__get_cluster_id(cpu);
+	struct aggr_cpu_id id;
+
+	/* There is no cluster_id on legacy system. */
+	if (cluster == -1)
+		cluster = 0;
+
+	id = aggr_cpu_id__die(cpu, data);
+	if (aggr_cpu_id__is_empty(&id))
+		return id;
+
+	id.cluster = cluster;
+	return id;
+}
+
 int cpu__get_core_id(struct perf_cpu cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu.cpu, "core_id", &value);
@@ -320,8 +345,8 @@ struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data)
 	struct aggr_cpu_id id;
 	int core = cpu__get_core_id(cpu);
 
-	/* aggr_cpu_id__die returns a struct with socket and die set. */
-	id = aggr_cpu_id__die(cpu, data);
+	/* aggr_cpu_id__die returns a struct with socket die, and cluster set. */
+	id = aggr_cpu_id__cluster(cpu, data);
 	if (aggr_cpu_id__is_empty(&id))
 		return id;
 
@@ -683,6 +708,7 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->node == b->node &&
 		a->socket == b->socket &&
 		a->die == b->die &&
+		a->cluster == b->cluster &&
 		a->cache_lvl == b->cache_lvl &&
 		a->cache == b->cache &&
 		a->core == b->core &&
@@ -695,6 +721,7 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->node == -1 &&
 		a->socket == -1 &&
 		a->die == -1 &&
+		a->cluster == -1 &&
 		a->cache_lvl == -1 &&
 		a->cache == -1 &&
 		a->core == -1 &&
@@ -708,6 +735,7 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.node = -1,
 		.socket = -1,
 		.die = -1,
+		.cluster = -1,
 		.cache_lvl = -1,
 		.cache = -1,
 		.core = -1,
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 9df2aeb34d3d..26cf76c693f5 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -20,6 +20,8 @@ struct aggr_cpu_id {
 	int socket;
 	/** The die id as read from /sys/devices/system/cpu/cpuX/topology/die_id. */
 	int die;
+	/** The cluster id as read from /sys/devices/system/cpu/cpuX/topology/cluster_id */
+	int cluster;
 	/** The cache level as read from /sys/devices/system/cpu/cpuX/cache/indexY/level */
 	int cache_lvl;
 	/**
@@ -86,6 +88,11 @@ int cpu__get_socket_id(struct perf_cpu cpu);
  * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
  */
 int cpu__get_die_id(struct perf_cpu cpu);
+/**
+ * cpu__get_cluster_id - Returns the cluster id as read from
+ * /sys/devices/system/cpu/cpuX/topology/cluster_id for the given CPU
+ */
+int cpu__get_cluster_id(struct perf_cpu cpu);
 /**
  * cpu__get_core_id - Returns the core id as read from
  * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
@@ -127,9 +134,15 @@ struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
  */
 struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
 /**
- * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
- * populated with the core, die and socket for cpu. The function signature is
- * compatible with aggr_cpu_id_get_t.
+ * aggr_cpu_id__cluster - Create an aggr_cpu_id with cluster, die and socket
+ * populated with the cluster, die and socket for cpu. The function signature
+ * is compatible with aggr_cpu_id_get_t.
+ */
+struct aggr_cpu_id aggr_cpu_id__cluster(struct perf_cpu cpu, void *data);
+/**
+ * aggr_cpu_id__core - Create an aggr_cpu_id with the core, cluster, die and
+ * socket populated with the core, die and socket for cpu. The function
+ * signature is compatible with aggr_cpu_id_get_t.
  */
 struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data);
 /**
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd9..e288649627d5 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -12,6 +12,7 @@ struct perf_cpu_map;
 struct cpu_topology_map {
 	int	socket_id;
 	int	die_id;
+	int	cluster_id;
 	int	core_id;
 };
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index afe6db8e7bf4..7309c43cdba7 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -201,6 +201,9 @@ static void print_aggr_id_std(struct perf_stat_config *config,
 		snprintf(buf, sizeof(buf), "S%d-D%d-L%d-ID%d",
 			 id.socket, id.die, id.cache_lvl, id.cache);
 		break;
+	case AGGR_CLUSTER:
+		snprintf(buf, sizeof(buf), "S%d-D%d-CLS%d", id.socket, id.die, id.cluster);
+		break;
 	case AGGR_DIE:
 		snprintf(buf, sizeof(buf), "S%d-D%d", id.socket, id.die);
 		break;
@@ -251,6 +254,10 @@ static void print_aggr_id_csv(struct perf_stat_config *config,
 		fprintf(config->output, "S%d-D%d-L%d-ID%d%s%d%s",
 			id.socket, id.die, id.cache_lvl, id.cache, sep, aggr_nr, sep);
 		break;
+	case AGGR_CLUSTER:
+		fprintf(config->output, "S%d-D%d-CLS%d%s%d%s",
+			id.socket, id.die, id.cluster, sep, aggr_nr, sep);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "S%d-D%d%s%d%s",
 			id.socket, id.die, sep, aggr_nr, sep);
@@ -300,6 +307,10 @@ static void print_aggr_id_json(struct perf_stat_config *config,
 		fprintf(output, "\"cache\" : \"S%d-D%d-L%d-ID%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, id.cache_lvl, id.cache, aggr_nr);
 		break;
+	case AGGR_CLUSTER:
+		fprintf(output, "\"cluster\" : \"S%d-D%d-CLS%d\", \"aggregate-number\" : %d, ",
+			id.socket, id.die, id.cluster, aggr_nr);
+		break;
 	case AGGR_DIE:
 		fprintf(output, "\"die\" : \"S%d-D%d\", \"aggregate-number\" : %d, ",
 			id.socket, id.die, aggr_nr);
@@ -1248,6 +1259,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
 	case AGGR_NODE:
 	case AGGR_SOCKET:
 	case AGGR_DIE:
+	case AGGR_CLUSTER:
 	case AGGR_CACHE:
 	case AGGR_CORE:
 		fprintf(output, "#%*s %-*s cpus",
@@ -1550,6 +1562,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_CACHE:
+	case AGGR_CLUSTER:
 	case AGGR_DIE:
 	case AGGR_SOCKET:
 	case AGGR_NODE:
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 325d0fad1842..df8732f8f898 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -48,6 +48,7 @@ enum aggr_mode {
 	AGGR_GLOBAL,
 	AGGR_SOCKET,
 	AGGR_DIE,
+	AGGR_CLUSTER,
 	AGGR_CACHE,
 	AGGR_CORE,
 	AGGR_THREAD,
-- 
2.24.0

