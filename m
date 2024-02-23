Return-Path: <linux-kernel+bounces-78144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C920860F89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBFB1F246C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D976911;
	Fri, 23 Feb 2024 10:38:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F86306D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684704; cv=none; b=PvicNor+8Q6BbPCFM/BuD5ODB42HWAXO3HyLaMjZDdyN8nHR4ONReR1MnemVCRYOyRwrgzAXQlFBwlGq+BW+ld0S7nG6t/c67nhS9/HkS62PQiHQ92mOHOOxj4ibI/E3NasoOzTLVhfaKO4cjmZSMZKi+OGFIwLn376sLa164zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684704; c=relaxed/simple;
	bh=XfzDTM55JnKi9GmEEmEXI8Y/oikyBoFxPQs6RKvi91U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzPyOfKfD5J/2zSG7mmacS4lN2hWwekyhjFDfMREYTZx+mhDVuxST/Tv1PZHFdvLANBuQ4c/QJTeNr5Dl8PO78AnfNlx/kF2J2sjZdKuaZ03DNGHm0DmaSPbfKKKum8c/C/0WiNpJlbQ4WNmdEZFXySm00lIpE3za+4okGHFG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Th5yd4SQ1z1h0KH;
	Fri, 23 Feb 2024 18:36:09 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 1155214011F;
	Fri, 23 Feb 2024 18:38:20 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:19 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 7/8] drivers/perf: hisi_pcie: Merge find_related_event() and get_event_idx()
Date: Fri, 23 Feb 2024 18:33:58 +0800
Message-ID: <20240223103359.18669-8-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240223103359.18669-1-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Junhao He <hejunhao3@huawei.com>

The function xxx_find_related_event() scan all working events to find
related events. During this process, we also can find the idle counters.
If not found related events, return the first idle counter to simplify
the code.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 51 ++++++++++----------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 5b15f3698188..5d1f0e9fdb08 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -398,16 +398,24 @@ static u64 hisi_pcie_pmu_read_counter(struct perf_event *event)
 	return hisi_pcie_pmu_readq(pcie_pmu, event->hw.event_base, idx);
 }
 
-static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
-					    struct perf_event *event)
+/*
+ * Check all work events, if a relevant event is found then we return it
+ * first, otherwise return the first idle counter (need to reset).
+ */
+static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu,
+					struct perf_event *event)
 {
+	int first_idle = -EAGAIN;
 	struct perf_event *sibling;
 	int idx;
 
 	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
 		sibling = pcie_pmu->hw_events[idx];
-		if (!sibling)
+		if (!sibling) {
+			if (first_idle == -EAGAIN)
+				first_idle = idx;
 			continue;
+		}
 
 		/* Related events must be used in group */
 		if (hisi_pcie_pmu_cmp_event(sibling, event) &&
@@ -415,19 +423,7 @@ static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
 			return idx;
 	}
 
-	return idx;
-}
-
-static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu)
-{
-	int idx;
-
-	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
-		if (!pcie_pmu->hw_events[idx])
-			return idx;
-	}
-
-	return -EINVAL;
+	return first_idle;
 }
 
 static void hisi_pcie_pmu_event_update(struct perf_event *event)
@@ -553,27 +549,18 @@ static int hisi_pcie_pmu_add(struct perf_event *event, int flags)
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
 
-	/* Check all working events to find a related event. */
-	idx = hisi_pcie_pmu_find_related_event(pcie_pmu, event);
-	if (idx < 0)
-		return idx;
-
-	/* Current event shares an enabled counter with the related event */
-	if (idx < HISI_PCIE_MAX_COUNTERS) {
-		hwc->idx = idx;
-		goto start_count;
-	}
-
-	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu);
+	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu, event);
 	if (idx < 0)
 		return idx;
 
 	hwc->idx = idx;
-	pcie_pmu->hw_events[idx] = event;
-	/* Reset Counter to avoid previous statistic interference. */
-	hisi_pcie_pmu_reset_counter(pcie_pmu, idx);
 
-start_count:
+	/* No enabled counter found with related event, reset it */
+	if (!pcie_pmu->hw_events[idx]) {
+		hisi_pcie_pmu_reset_counter(pcie_pmu, idx);
+		pcie_pmu->hw_events[idx] = event;
+	}
+
 	if (flags & PERF_EF_START)
 		hisi_pcie_pmu_start(event, PERF_EF_RELOAD);
 
-- 
2.24.0


