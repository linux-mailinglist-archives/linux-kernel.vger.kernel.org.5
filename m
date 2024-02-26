Return-Path: <linux-kernel+bounces-81584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E038677D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC578288212
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75A412CD83;
	Mon, 26 Feb 2024 14:06:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118CF12C53D;
	Mon, 26 Feb 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956383; cv=none; b=eJT2kB8XUbZHIB0mJqgshuzgHbPwNG2+gfFgJ9MHnlEpkL7i2NCf57I7rSKkpDPMUHvGe17uWs3Ju6+qmjeU8zFCAcbs8qHceZ8bbdtZ2TvtbdI0n7gSshY+WumTZxCXjZl8wZrUqLVGggsvjkAj5BXoToSZ6coY5ehiq3SfppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956383; c=relaxed/simple;
	bh=tP11PJE+B44zfRXa8blWSPevKcbSiOSl0SgRA/mAjGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvySXC2re05mUgHRLI9PI54eGCY53kaKFYpSMQZe6FWF1T1fOZ74z/mVunr7rp5SjUYWQZlMulK4GvPjPm3TOf9L8d4tvi5F/cKgm9esdFHNBkbW29PV4duMFmHlQ2x98uKGracACylobV6Hez+8cazLrQyxSANX4eihyfFNYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-7c-65dc9ad909a7
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
Subject: [PATCH v2 4/7] mm/memory-tiers: add next_promotion_node to find promotion target
Date: Mon, 26 Feb 2024 23:05:50 +0900
Message-ID: <20240226140555.1615-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240226140555.1615-1-honggyu.kim@sk.com>
References: <20240226140555.1615-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXC9ZZnoe6tWXdSDb7/YrOY2GNgMWf9GjaL
	XTdCLP7vPcZo8eT/b1aLEzcb2Sw6vy9lsbi8aw6bxb01/1ktjqw/y2Kx7haQtfnsGWaLxcvV
	LPZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7CHv8PziJ2WPp6TdsHhuagMTOWXfZ
	PVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8TM36zeOx8aOnxYvNMRo/e5ndsHp83
	yQXwR3HZpKTmZJalFunbJXBl7FvZwFrwSLziz+vJzA2M+4S7GDk5JARMJF6+3sMGY1/cspYJ
	xGYTUJO48nISkM3BISLgILHqq0IXIxcHs0ADi8SPz5dYQGqEBSIlZkxuYgWxWQRUJVpPXWIE
	sXkFzCSuP9nHCjFTU+Lx9p/sIDangLnE/8PtbCAzhYBqjt5mhigXlDg58wnYSGYBeYnmrbOZ
	QXZJCJxil9h0YC/UHEmJgytusExg5J+FpGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3
	MQLjb1ntn+gdjJ8uBB9iFOBgVOLhdai9kyrEmlhWXJl7iFGCg1lJhDdc5maqEG9KYmVValF+
	fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsZ1bw5O7DnF3tp751DZCdvF
	SZc3nJBMjJE8kaukLfLu0KoGno1X57gtVPktNfkX87orou/rHqcrGKrOaozWVr6mMb+o7NPs
	1cURJ/UNo17N4WxQLdD9ev+6ZJxgk+HNFgPzlx/3lE1mEQkx3nWkLcLCKbjw085lJwrmT+V7
	/0L2VEalS/Y01UQlluKMREMt5qLiRAATmp6xuwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXCNUNLT/fmrDupBj39phYTewws5qxfw2ax
	60aIxf+9xxgtnvz/zWpx4mYjm8XnZ6+ZLTqffGe0ODz3JKtF5/elLBaXd81hs7i35j+rxZH1
	Z1ks1t0CsjafPcNssXi5msWha89ZLfZ1PGCyOPz1DZPF5EsL2CxeTDnDaHFy1mQWi9lH77E7
	iHv8PziJ2WPp6TdsHhuagMTOWXfZPVr23WL3WLCp1KPlyFtWj8V7XjJ5bFrVyeax6dMkdo8T
	M36zeOx8aOnxYvNMRo/e5ndsHt9ue3gsfvGBKUAwissmJTUnsyy1SN8ugStj38oG1oJH4hV/
	Xk9mbmDcJ9zFyMkhIWAicXHLWiYQm01ATeLKy0lANgeHiICDxKqvCl2MXBzMAg0sEj8+X2IB
	qREWiJSYMbmJFcRmEVCVaD11iRHE5hUwk7j+ZB8rxExNicfbf7KD2JwC5hL/D7ezgcwUAqo5
	epsZolxQ4uTMJ2AjmQXkJZq3zmaewMgzC0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ
	+bmbGIGxtqz2z8QdjF8uux9iFOBgVOLhdai9kyrEmlhWXJl7iFGCg1lJhDdc5maqEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA+PaINdoLfZf91+us46d
	M+uS9dVZPGz5fwVbW9xXNF27aR175kvOuZl+M6Tc2xjtV9hLXT3SNv32Qf/yvKWX7ZYkSpxm
	ur3k8ve/hVWzpmVtMmFR29aY9PC4cbLtp4U72J6/UF6+XuXSfvaQ7p0GDrz/q7uEtlbM5zYx
	mm2td+9xbItPYfdB704lluKMREMt5qLiRABxHBSHsQIAAA==
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


