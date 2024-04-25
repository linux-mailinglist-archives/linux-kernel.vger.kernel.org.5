Return-Path: <linux-kernel+bounces-158547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4772D8B21E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0481A2896DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31AC149C51;
	Thu, 25 Apr 2024 12:48:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696221494B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049329; cv=none; b=O7v+XP8RJckIc5QGMpghlYt4YappQKmYLnQL6eCx0YUUYEWicBtu7pFFi2dEDqXPT1psZnlflcotAfe32sXWuvREMQ7/wdTxnBDTp99ZHgBDuHmWNGcNbngxi5EkdPsXdh+JTMqrIsmd1J9Dm7PJ1/RNPVX3OPnhJ/BZyQfDjEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049329; c=relaxed/simple;
	bh=slRugwnP921pIxWBVI6GNhjGlZd6X4SBQW6Z9Mm1TIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYS8kAefwcFqiUjF9L5i5V4SirVRZNh7G2KAkhB09Su7jV98+Ata0TTamMMV39+WC7I6rA5CdXEknA0DOYi2Oo9S1yiP820wgHaSw2dfbr8CVmk2Kpq4MBMqmVTFaIszXM5CPi9/fv8Mi3Jta+OyyuHLjTeyO/Hu73Sa8EPBYW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VQFxk1HNzzcc1t;
	Thu, 25 Apr 2024 20:47:38 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 493AA1401E9;
	Thu, 25 Apr 2024 20:48:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 20:48:43 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <will@kernel.org>, <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<shaojijie@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
	<chenhao418@huawei.com>
Subject: [PATCH 2/3] drivers/perf: hisi: hns3: Fix out-of-bound access when valid event group
Date: Thu, 25 Apr 2024 20:46:26 +0800
Message-ID: <20240425124627.13764-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240425124627.13764-1-hejunhao3@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)

The perf tool allows users to create event groups through following
cmd [1], but the driver does not check whether the array index is out
of bounds when writing data to the event_group array. If the number of
events in an event_group is greater than HNS3_PMU_MAX_HW_EVENTS, the
memory write overflow of event_group array occurs.

Add array index check to fix the possible array out of bounds violation,
and return directly when write new events are written to array bounds.

There are 9 different events in an event_group.
[1] perf stat -e '{pmu/event1/, ... ,pmu/event9/}

Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Signed-off-by: Hao Chen <chenhao418@huawei.com>
---
 drivers/perf/hisilicon/hns3_pmu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 16869bf5bf4c..cbdd53b0a034 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1085,15 +1085,27 @@ static bool hns3_pmu_validate_event_group(struct perf_event *event)
 			return false;
 
 		for (num = 0; num < counters; num++) {
+			/*
+			 * If we find a related event, then it's a valid group
+			 * since we don't need to allocate a new counter for it.
+			 */
 			if (hns3_pmu_cmp_event(event_group[num], sibling))
 				break;
 		}
 
+		/*
+		 * Otherwise it's a new event but if there's no available counter,
+		 * fail the check since we cannot schedule all the events in
+		 * the group simultaneously.
+		 */
+		if (num == HNS3_PMU_MAX_HW_EVENTS)
+			return false;
+
 		if (num == counters)
 			event_group[counters++] = sibling;
 	}
 
-	return counters <= HNS3_PMU_MAX_HW_EVENTS;
+	return true;
 }
 
 static u32 hns3_pmu_get_filter_condition(struct perf_event *event)
-- 
2.33.0


