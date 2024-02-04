Return-Path: <linux-kernel+bounces-51504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF68848BFB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70151F22C89
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A042134C4;
	Sun,  4 Feb 2024 07:49:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5470FBE4
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032982; cv=none; b=DPiuSHdpQbMPn7yC7ZOoNthlRop0pOxDC537rCXkVbiOFZ09eoYJYxT10NUTnKxddEtSx13me+Gno3y4JBuSjDS4cPFCHFd0v0mDWS4R1kfu9QwkM1r3aJxxRD20WN/mPxPCixyFyskIfuhQkn6peY8kdySnapGkLi/zc/57LWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032982; c=relaxed/simple;
	bh=1UkIr5V/52bHREXY34P/myH6Vo5bhtQZ1nGTyQc/848=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGXN//llTF4VzGbxjs19WnfQPTDRD5pku1HFqv8NrhUFikZdOGmuKR9mZaIsN3OpWnoXFY2iffapvpzeSdEclFomDx95rAXSe7xkMvR0JkB7Kr1yRxCVeMIXPaBIE4hE2sqfzHg34Bhoe9Uqw/CHxkNzsOE6/aSkKqzTwFLB0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TSM722wJdz1gyTn;
	Sun,  4 Feb 2024 15:47:42 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 1507818002F;
	Sun,  4 Feb 2024 15:49:36 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 15:49:35 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH 6/7] drivers/perf: hisi_pcie: Merge find_related_event() and get_event_idx()
Date: Sun, 4 Feb 2024 15:45:26 +0800
Message-ID: <20240204074527.47110-7-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20240204074527.47110-1-yangyicong@huawei.com>
References: <20240204074527.47110-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Junhao He <hejunhao3@huawei.com>

The function xxx_find_related_event() scan all working events to find
related events. During this process, we also can find the idle counters.
If not found related events, return the first idle counter to simplify
the code.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 55 ++++++++++----------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 1b45aeb82859..2edde66675e7 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -397,16 +397,24 @@ static u64 hisi_pcie_pmu_read_counter(struct perf_event *event)
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
+	int first_idle = HISI_PCIE_MAX_COUNTERS;
 	struct perf_event *sibling;
 	int idx;
 
 	for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
 		sibling = pcie_pmu->hw_events[idx];
-		if (!sibling)
+		if (!sibling) {
+			if (first_idle == HISI_PCIE_MAX_COUNTERS)
+				first_idle = idx;
 			continue;
+		}
 
 		/* Related events must be used in group */
 		if (hisi_pcie_pmu_cmp_event(sibling, event) &&
@@ -414,19 +422,7 @@ static int hisi_pcie_pmu_find_related_event(struct hisi_pcie_pmu *pcie_pmu,
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
@@ -552,27 +548,18 @@ static int hisi_pcie_pmu_add(struct perf_event *event, int flags)
 
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
-	if (idx < 0)
-		return idx;
+	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu, event);
+	if (idx == HISI_PCIE_MAX_COUNTERS)
+		return -EAGAIN;
 
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


