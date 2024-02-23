Return-Path: <linux-kernel+bounces-78150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AA3860F92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E7A1C21BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768E63119;
	Fri, 23 Feb 2024 10:38:29 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A27C6E9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684708; cv=none; b=Eip37PyWnFhHOrl+umP0r+czlwQUi5ZP/kifjYFjreNJooeeaVD8TYU66qd8EUjZa/fFATZSTcutiiYy4GJyLSvDYdMkRI8JjRniTRy+TFPC3J2HcY5jgBs2buNr7YC/0Oz8r5ukD3GsmbahZFiAQx+HZcr9y4VkPrpasvVbIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684708; c=relaxed/simple;
	bh=S3xPAtQF7swkXy6bnNjhtG6oQlPODcCGOzyNeLx94YY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4eD+mWPWy0XBDgbQZHquaK3y5VJTy0zmxkjQYA/pJMLX3+3kmfeQ75t7wxbsxBq1DP6HlzQOYszLw5g4XtXlP0Wh4Wwd+7CWEhGaIk/CcipsUZfYBm7xm3hycNx6KDqUv9ResAJmAuz34zZkGJI3HBWc/J7AMDmV+I5+HsU8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Th5zV0CGVzNlm7;
	Fri, 23 Feb 2024 18:36:54 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DE611400FD;
	Fri, 23 Feb 2024 18:38:19 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:18 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 3/8] drivers/perf: hisi_pcie: Fix incorrect counting under metric mode
Date: Fri, 23 Feb 2024 18:33:54 +0800
Message-ID: <20240223103359.18669-4-yangyicong@huawei.com>
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

From: Yicong Yang <yangyicong@hisilicon.com>

The metric counting shows incorrect results if the events in the
metric group using the same event but different filter options.
This is because we only judge the event code to decide whether
the event in the metric group should share the same hardware
counter, but ignore the settings of the filter.

For example, on a platform of 2 ports 0x1 and 0x2 but only port
0x1 has a downstream PCIe NVME device. The metric counting
shows both ports have the same counts because we misassign these
two events to one same hardware counter:
[root@localhost perf-iostat]# ./perf stat -e '{hisi_pcie0_core1/event=0x0104,port=0x2/,hisi_pcie0_core1/event=0x0104,port=0x1/}'

 Performance counter stats for 'system wide':

        7907484924      hisi_pcie0_core1/event=0x0104,port=0x2/
        7907484924      hisi_pcie0_core1/event=0x0104,port=0x1/

      10.153863691 seconds time elapsed

Fix this by using the whole config rather than the event only
to judge whether two events are the same and should share the
same hardware counter. With this patch, the metric counting in
the above case tends to be corrected:

[root@localhost perf-iostat]# ./perf stat -e '{hisi_pcie0_core1/event=0x0104,port=0x2/,hisi_pcie0_core1/event=0x0104,port=0x1/}'

 Performance counter stats for 'system wide':

                 0      hisi_pcie0_core1/event=0x0104,port=0x2/
        8123122077      hisi_pcie0_core1/event=0x0104,port=0x1/

      10.152875631 seconds time elapsed

Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 2468cf3b007c..9176242eadb3 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -314,10 +314,16 @@ static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
 	return true;
 }
 
+/*
+ * Check Whether two events share the same config. The same config means not
+ * only the event code, but also the filter settings of the two events are
+ * the same.
+ */
 static bool hisi_pcie_pmu_cmp_event(struct perf_event *target,
 					struct perf_event *event)
 {
-	return hisi_pcie_get_real_event(target) == hisi_pcie_get_real_event(event);
+	return hisi_pcie_pmu_get_event_ctrl_val(target) ==
+	       hisi_pcie_pmu_get_event_ctrl_val(event);
 }
 
 static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
-- 
2.24.0


