Return-Path: <linux-kernel+bounces-54178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CD84ABE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD6B22A97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C271B5676C;
	Tue,  6 Feb 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DyNgFWkn"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595C56755
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185002; cv=none; b=L5a4iiUnmDxNqoBeAS1Q3RtyS2Xf8loKgwu1Jlqu4xnBo5HBxoHnuReDFhdqx14ovb4ACBsq2v2lj4IOKYpymNwYaLgGHYYy1c+M8DI/sWe5Nopk9QbvMw6I6w4si+Eu9lajopJEzliUSDf8m8DxYRHB1lgFx+vU7mscbVQJfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185002; c=relaxed/simple;
	bh=A6c6C805cvInprc5DfIwyhw/cznXAQ4Ac7UCK9u+NGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0B/7fnNeX6Na/JsCanlOSRJGLaLHHs8rdOcnE8vps4JppIwQ5C/EyS9iVBaFndPQNym0t4eEhBdRSQZdxLLCNolR+E+p5FYfpLLIQMjyWyxBE/NqDI8jARspTnqOYuK2wsi6ju/KzruSLcwVvvc1dLPf2JfQoJQ49hkSKn41Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DyNgFWkn; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707185000; x=1738721000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A6c6C805cvInprc5DfIwyhw/cznXAQ4Ac7UCK9u+NGQ=;
  b=DyNgFWknmGn9vnHk8AQKTpcrzgLCFB8bL6YdAzJ/EHqPK4zaiea7dX+F
   6IxtBg8uTpG5v31pVVEOPJUNXAg6mvZTnYjTcNVh1Bm9AbAlZNkWk2uCy
   AHQwb8YAgt3ZjEAXEEeFlAheBx6cu9WH3HHQu34R4aqIPgsHQ1y4O4l7y
   G+hrXi+FplfmiU0EkAmSLAiW8cxfFYprCnBH5riWbJsBUXfyZ4r8s/Zop
   s+Ivm/lKN8R2DWju8Dk+2v2HQyKVVovDYvnpE2oKG3U4Ojj5/zBavVR/a
   oN+UmYTrbgdm2vUwckq8jaPUgNazfEp+7p1+VL8x53bNm9Ka304ujU0k8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="147963445"
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="147963445"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 11:02:06 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DA458D55C6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:02:03 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EB247CFBBF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:02:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 739886B4D8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:02:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9CAD01A009A;
	Tue,  6 Feb 2024 10:02:01 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v2] mm/demotion: print demotion targets
Date: Tue,  6 Feb 2024 10:01:51 +0800
Message-Id: <20240206020151.605516-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28170.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28170.003
X-TMASE-Result: 10--7.256200-10.000000
X-TMASE-MatchedRID: 84oovQVhL8FELNYIFEAu6zmKlJefBFwzvhf/zJ92tsM6Zx3YUNQTGzAW
	5be84JTB+7QmOJudfuM0MAPuOAsAkxvtxLq45qm9Ojf3A4DTYuEfimmlcABuN+g3wNKii1r5gKe
	r2q0Zy9XA2G3OXMO97Otno5Fr47QU0ekSi+00U24ReM8i8p3vgEyQ5fRSh26513Gq5v1TibNVcX
	P3eMLfFyuV2J6ODXDa78NWCssKwqTSTldzGIIsPnaNJ/iTxXCafS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtJC9jS54qtzWMv0MkyTdeRcnUaQwUzbCHhhYN1k2z0iGM878aKTOCmQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently, when a demotion occurs, it will prioritize selecting a node
from the preferred targets as the destination node for the demotion. If
the preferred node does not meet the requirements, it will try from all
the lower memory tier nodes until it finds a suitable demotion destination
node or ultimately fails.

However, the demotion target information isn't exposed to the users,
especially the preferred target information, which relies on more factors.
This makes users hard to understand the exact demotion behavior.

Rather than having a new sys interface to expose this information,
printing directly to kernel messages, just like the current page
allocation fallback order does.

A dmesg example with this patch is as follows:
[    0.704860] Demotion targets for Node 0: null
[    0.705456] Demotion targets for Node 1: null
// node 2 is onlined
[   32.259775] Demotion targets for Node 0: perferred: 2, fallback: 2
[   32.261290] Demotion targets for Node 1: perferred: 2, fallback: 2
[   32.262726] Demotion targets for Node 2: null
// node 3 is onlined
[   42.448809] Demotion targets for Node 0: perferred: 2, fallback: 2-3
[   42.450704] Demotion targets for Node 1: perferred: 2, fallback: 2-3
[   42.452556] Demotion targets for Node 2: perferred: 3, fallback: 3
[   42.454136] Demotion targets for Node 3: null
// node 4 is onlined
[   52.676833] Demotion targets for Node 0: perferred: 2, fallback: 2-4
[   52.678735] Demotion targets for Node 1: perferred: 2, fallback: 2-4
[   52.680493] Demotion targets for Node 2: perferred: 4, fallback: 3-4
[   52.682154] Demotion targets for Node 3: null
[   52.683405] Demotion targets for Node 4: null
// node 5 is onlined
[   62.931902] Demotion targets for Node 0: perferred: 2, fallback: 2-5
[   62.938266] Demotion targets for Node 1: perferred: 5, fallback: 2-5
[   62.943515] Demotion targets for Node 2: perferred: 4, fallback: 3-4
[   62.947471] Demotion targets for Node 3: null
[   62.949908] Demotion targets for Node 4: null
[   62.952137] Demotion targets for Node 5: perferred: 3, fallback: 3-4

CC: "Huang, Ying" <ying.huang@intel.com>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
Regarding this requirement, we have previously discussed [1].
The initial proposal involved introducing a new sys interface.
However, due to concerns about potential changes and compatibility
issues with the interface in the future, a consensus was not
reached with the community. Therefore, this time, we are directly
printing out the information.

[1] https://lore.kernel.org/all/d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com/
---
 mm/memory-tiers.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 5462d9e3c84c..4d3506a290b7 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -359,6 +359,26 @@ static void disable_all_demotion_targets(void)
 	synchronize_rcu();
 }
 
+static void dump_demotion_targets(void)
+{
+	int node;
+
+	for_each_node_state(node, N_MEMORY) {
+		struct memory_tier *memtier = __node_get_memory_tier(node);
+		nodemask_t preferred = node_demotion[node].preferred;
+
+		if (!memtier)
+			continue;
+
+		if (nodes_empty(preferred))
+			pr_info("Demotion targets for Node %d: null\n", node);
+		else
+			pr_info("Demotion targets for Node %d: preferred: %*pbl, fallback: %*pbl\n",
+				node, nodemask_pr_args(&preferred),
+				nodemask_pr_args(&memtier->lower_tier_mask));
+	}
+}
+
 /*
  * Find an automatic demotion target for all memory
  * nodes. Failing here is OK.  It might just indicate
@@ -443,7 +463,7 @@ static void establish_demotion_targets(void)
 	 * Now build the lower_tier mask for each node collecting node mask from
 	 * all memory tier below it. This allows us to fallback demotion page
 	 * allocation to a set of nodes that is closer the above selected
-	 * perferred node.
+	 * preferred node.
 	 */
 	lower_tier = node_states[N_MEMORY];
 	list_for_each_entry(memtier, &memory_tiers, list) {
@@ -456,6 +476,8 @@ static void establish_demotion_targets(void)
 		nodes_andnot(lower_tier, lower_tier, tier_nodes);
 		memtier->lower_tier_mask = lower_tier;
 	}
+
+	dump_demotion_targets();
 }
 
 #else
-- 
2.29.2


