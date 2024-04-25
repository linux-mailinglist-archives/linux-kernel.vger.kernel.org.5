Return-Path: <linux-kernel+bounces-158545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661858B21E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B95C1F22EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9851494CA;
	Thu, 25 Apr 2024 12:48:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736827715
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049327; cv=none; b=WoBWZBRvdv8RoyyPvZ+bMRu1GeVUZv7q1oayj3TPLg14tcLcwKbQaDQ6z8qhhl3teYggoHlVoWZ46WOEYhmRvLkazRiwfbIT7Hvb2C++N1ksqme9hPaCjcsau/lmpGBa3WLFAPd+1dm1J33ecSjsILHDCHx3cS9sqOP4BmuzPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049327; c=relaxed/simple;
	bh=gXeNCjxT3gJZfn41DbjCUhvZyt8PxO6qbccvtxOwzgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTVbycanbahQAX/bp8lHnXKZVgxeP7/WQGAqsBh7h3aJaDoYjwQmn5yCgUD8G1Jo9yT2OGDOhKFYZTlDNvMnuLMC0+Xsnikm9aj2a0wqr+5FJYzhP+eGDpwJCHnr+2EFaxKIai2ofExHRBNisD82IRfaog6/OW8zLA6FeMgIZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQFvH16Y8zwTrt;
	Thu, 25 Apr 2024 20:45:31 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 21A23140258;
	Thu, 25 Apr 2024 20:48:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 20:48:42 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <will@kernel.org>, <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<shaojijie@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
	<chenhao418@huawei.com>
Subject: [PATCH 1/3] drivers/perf: hisi_pcie: Fix out-of-bound access when valid event group
Date: Thu, 25 Apr 2024 20:46:25 +0800
Message-ID: <20240425124627.13764-2-hejunhao3@huawei.com>
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
cmd [1], but the driver does not check whether the array index is out of
bounds when writing data to the event_group array. If the number of events
in an event_group is greater than HISI_PCIE_MAX_COUNTERS, the memory write
overflow of event_group array occurs.

Add array index check to fix the possible array out of bounds violation,
and return directly when write new events are written to array bounds.

There are 9 different events in an event_group.
[1] perf stat -e '{pmu/event1/, ... ,pmu/event9/}'

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 5d1f0e9fdb08..dba399125658 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -350,15 +350,27 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
 			return false;
 
 		for (num = 0; num < counters; num++) {
+			/*
+			 * If we find a related event, then it's a valid group
+			 * since we don't need to allocate a new counter for it.
+			 */
 			if (hisi_pcie_pmu_cmp_event(event_group[num], sibling))
 				break;
 		}
 
+		/*
+		 * Otherwise it's a new event but if there's no available counter,
+		 * fail the check since we cannot schedule all the events in
+		 * the group simultaneously.
+		 */
+		if (num == HISI_PCIE_MAX_COUNTERS)
+			return false;
+
 		if (num == counters)
 			event_group[counters++] = sibling;
 	}
 
-	return counters <= HISI_PCIE_MAX_COUNTERS;
+	return true;
 }
 
 static int hisi_pcie_pmu_event_init(struct perf_event *event)
-- 
2.33.0


