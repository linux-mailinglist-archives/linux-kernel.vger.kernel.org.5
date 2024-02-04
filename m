Return-Path: <linux-kernel+bounces-51506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0129848BFD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDFA284B4A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291813FFA;
	Sun,  4 Feb 2024 07:49:45 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956D134D3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032984; cv=none; b=dIVzENyrpnq2/GcH3GFt4FDIxE4YyfIZROWO3lideCJXvwOFzzdjGk/zJJejF3yZSVnT0caOLJxIrlJz0HSMZtta11JNOQpTx2lDrKnWBl8HcIcV2V/+lHBOmQLByP1u2Zk5zeY93Y4WchSSTFsIFMcHlyOCidV/fBiBMLSubiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032984; c=relaxed/simple;
	bh=fXY6v3dlHX7XEig/rjz/9i1sF+CRbwLSuen9ujNtZtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOrqB3sM/vyaTzfxtBWu7W6+iKfQOWaSKNONnzF4d2hll6dDOzE7HYprAVfxk2pmf5pljtzltXtNREzCRzNncYCvgynMfP3C+7Mkiy1S1Ujy8ywllJfKWOj9iaQGLP4BwBQQDVAGfO6TQGh2ZLkeAQ8V6sC7I4lZLIYeEt3X9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TSM8h3fjfz1vt7q;
	Sun,  4 Feb 2024 15:49:08 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A44A1404D8;
	Sun,  4 Feb 2024 15:49:35 +0800 (CST)
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
Subject: [PATCH 2/7] drivers/perf: hisi_pcie: Fix incorrect counting under metric mode
Date: Sun, 4 Feb 2024 15:45:22 +0800
Message-ID: <20240204074527.47110-3-yangyicong@huawei.com>
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
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 11a819cd07f2..9623bed93876 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -314,10 +314,15 @@ static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
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
+	return hisi_pcie_pmu_get_filter(target) == hisi_pcie_pmu_get_filter(event);
 }
 
 static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
-- 
2.24.0


