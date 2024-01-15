Return-Path: <linux-kernel+bounces-25623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDF82D3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6CD28172F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53463AE;
	Mon, 15 Jan 2024 04:53:09 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B0A23C9;
	Mon, 15 Jan 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-69-65a4ba2f659a
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
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [RFC PATCH 3/4] mm/memory-tiers: add next_promotion_node to find promotion target
Date: Mon, 15 Jan 2024 13:52:51 +0900
Message-ID: <20240115045253.1775-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240115045253.1775-1-honggyu.kim@sk.com>
References: <20240115045253.1775-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsXC9ZZnoa7BriWpBoubmCzmrF/DZrHrRojF
	/73HGC2e/P/NanHiZiObRef3pSwWl3fNYbO4t+Y/q8WR9WdZLNbdArI2nz3DbLF4uZrFvo4H
	TBaHv75hsph8aQGbxYspZxgtTs6azGIx++g9dgchj/8HJzF7LD39hs1jQxOQaNl3i91jwaZS
	j5Yjb1k9Fu95yeSxaVUnm8emT5PYPU7M+M3isfOhpceLzTMZPXqb37F5fN4kF8AXxWWTkpqT
	WZZapG+XwJWxb2UDa8Ej8Yo/ryczNzDuE+5i5OSQEDCR+HNkFTOMPevYUkYQm01ATeLKy0lM
	XYwcHCICDhKrvip0MXJxMAucY5bo/3IFLC4sECXx74ItSDmLgKrEj0UdrCA2r4CZxLueLiaI
	kZoSj7f/ZAexOQXMJV63vwFbJQRU07j2GztEvaDEyZlPWEBsZgF5ieats5lBdkkIbGKXuHXl
	IBvEIEmJgytusExg5J+FpGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQKjbVntn+gd
	jJ8uBB9iFOBgVOLh/fF3caoQa2JZcWXuIUYJDmYlEd6DzxekCvGmJFZWpRblxxeV5qQWH2KU
	5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamAUqFjkHJtYNEmFKdWLhY2P0yzjmX3Rrw8y
	3FuOJZnFys9JW3q54Jrnp6/11e4Tpyt/mn/n6uvi9OvSgTVH5u3oe32ad82Mmxaedbp/Fu/e
	KN477865GTzTTj4W6LjImRmWmVC8+moP+y215J67M78eeMXv17B2n3Oql/Nz5p7kggeBeyUv
	J+xXYinOSDTUYi4qTgQAoUES4bICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LhmqGlp6u/a0mqwfXzBhZz1q9hs9h1I8Ti
	/95jjBZP/v9mtThxs5HNovPJd0aLw3NPslp0fl/KYnF51xw2i3tr/rNaHFl/lsVi3S0ga/PZ
	M8wWi5erWezreMBkcfjrGyaLyZcWsFm8mHKG0eLkrMksFrOP3mN3EPH4f3ASs8fS02/YPDY0
	AYmWfbfYPRZsKvVoOfKW1WPxnpdMHptWdbJ5bPo0id3jxIzfLB47H1p6vNg8k9Gjt/kdm8e3
	2x4ei198YPL4vEkuQCCKyyYlNSezLLVI3y6BK2PfygbWgkfiFX9eT2ZuYNwn3MXIySEhYCIx
	69hSRhCbTUBN4srLSUxdjBwcIgIOEqu+KnQxcnEwC5xjluj/cgUsLiwQJfHvgi1IOYuAqsSP
	RR2sIDavgJnEu54uJoiRmhKPt/9kB7E5BcwlXre/YQaxhYBqGtd+Y4eoF5Q4OfMJC4jNLCAv
	0bx1NvMERp5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECIymZbV/Ju5g/HLZ
	/RCjAAejEg/vj7+LU4VYE8uKK3MPMUpwMCuJ8B58viBViDclsbIqtSg/vqg0J7X4EKM0B4uS
	OK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgVFvYlqLYfQvfaty+3MGra/Lrldbn5lxs/FgWkHw
	rcUyNSd6RMol1glfkLFMFNJfVV3YaHjvQmzkSdlGodL0GJGcxjLbDVzsHk8m9ktOyzA9kFL0
	12XnrPQF5xcu2u+5hGlSfQhvwOSShpa2wz58h67veago21WaFlDhYyVXE5gSNClJdVaOEktx
	RqKhFnNRcSIAY1YS0aICAAA=
X-CFilter-Loop: Reflected

From: Hyeongtak Ji <hyeongtak.ji@sk.com>

This patch adds next_promotion_node that can be used to identify the
appropriate promotion target based on memory tiers.  When multiple
promotion target nodes are available, the nearest node is selected based
on numa distance.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 include/linux/memory-tiers.h | 11 +++++++++
 mm/memory-tiers.c            | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 1e39d27bee41..0788e435fc50 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -50,6 +50,7 @@ int mt_set_default_dram_perf(int nid, struct node_hmem_attrs *perf,
 int mt_perf_to_adistance(struct node_hmem_attrs *perf, int *adist);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
+int next_promotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
 #else
@@ -58,6 +59,11 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 
+static inline int next_promotion_node(int node)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 {
 	*targets = NODE_MASK_NONE;
@@ -101,6 +107,11 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 
+static inline int next_promotion_node(int node)
+{
+	return NUMA_NO_NODE;
+}
+
 static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 {
 	*targets = NODE_MASK_NONE;
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 8d5291add2bc..0060ee571cf4 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -335,6 +335,49 @@ int next_demotion_node(int node)
 	return target;
 }
 
+/*
+ * Select a promotion target that is close to the from node among the given
+ * two nodes.
+ *
+ * TODO: consider other decision policy as node_distance may not be precise.
+ */
+static int select_promotion_target(int a, int b, int from)
+{
+	if (node_distance(from, a) < node_distance(from, b))
+		return a;
+	else
+		return b;
+}
+
+/**
+ * next_promotion_node() - Get the next node in the promotion path
+ * @node: The starting node to lookup the next node
+ *
+ * Return: node id for next memory node in the promotion path hierarchy
+ * from @node; NUMA_NO_NODE if @node is the toptier.
+ */
+int next_promotion_node(int node)
+{
+	int target = NUMA_NO_NODE;
+	int nid;
+
+	if (node_is_toptier(node))
+		return NUMA_NO_NODE;
+
+	rcu_read_lock();
+	for_each_node_state(nid, N_MEMORY) {
+		if (node_isset(node, node_demotion[nid].preferred)) {
+			if (target == NUMA_NO_NODE)
+				target = nid;
+			else
+				target = select_promotion_target(nid, target, node);
+		}
+	}
+	rcu_read_unlock();
+
+	return target;
+}
+
 static void disable_all_demotion_targets(void)
 {
 	struct memory_tier *memtier;
-- 
2.34.1


