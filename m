Return-Path: <linux-kernel+bounces-56241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A884C7CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320A7B25C62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2FA2233E;
	Wed,  7 Feb 2024 09:43:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187220DCF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299020; cv=none; b=seX/HCwTS2qIDYNch1MGzCIqgdlB1sBg1fKL4ezJIiG+5qUEIdiCog1EHEztHGulvU42F8LAnwxKoZVWaB3OFmyQIx1OHyD3igiMTjFuhr7QdYVcpNy8CmmHT4Thb6ZjyWk0oFRHXI/K+j9XkZxWV/Nnk7E1grtYPUYs0dJJK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299020; c=relaxed/simple;
	bh=Bd2Uen+kEEv0rDyXp6hDQY1ojZRMOd7eK03W3Z2GJPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZX0VXeYG3ftwPODP2ASWGnZhGG+mQuSWBQo1e5ZBLnCvA6kHrDqDeZDWaGQcwF5nc8AVWiMtYx7Y2GPeHWSoieUWzdEMN6hq7n8zSPuIIdpIQ9UhSg+KVg36wLPcrJcP/3DrgYf83smFAxi0bShYMhlDdIa3mnpSProB2IdFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVFW62Vw1z1gycc;
	Wed,  7 Feb 2024 17:41:38 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id B6AC91400CF;
	Wed,  7 Feb 2024 17:43:34 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 17:43:34 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <will@kernel.org>, <jonathan.cameron@huawei.com>,
	<linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<yangyicong@huawei.com>, <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH] drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for UC PMU
Date: Wed, 7 Feb 2024 17:42:45 +0800
Message-ID: <20240207094245.34195-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
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

HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU counter
cannot be set due to the lack of clock under power saving mode. This will
lead to error or inaccurate counts. The clock can be enabled by the PMU
global enabling control.

This patch tries to fix this by set the UC PMU enable before set event
period to turn on the clock, and then restore the UC PMU configuration.
The counter register can hold its value without a clock.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 40 ++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
index 636fb79647c8..8e7a9e1f419a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
@@ -287,10 +287,48 @@ static u64 hisi_uc_pmu_read_counter(struct hisi_pmu *uc_pmu,
 	return readq(uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
 }
 
-static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
+static bool hisi_uc_pmu_get_glb_en_state(struct hisi_pmu *uc_pmu)
+{
+	u32 val;
+
+	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
+	return !!FIELD_GET(HISI_UC_EVENT_GLB_EN, val);
+}
+
+static void hisi_uc_pmu_write_counter_quirk_hip09(struct hisi_pmu *uc_pmu,
 				      struct hw_perf_event *hwc, u64 val)
 {
+	bool enable = hisi_uc_pmu_get_glb_en_state(uc_pmu);
+
+	/* Set the UC PMU enable to turn on the clock. */
+	if (!enable)
+		hisi_uc_pmu_start_counters(uc_pmu);
+
 	writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
+
+	/*
+	 * The counter register can hold its value without a clock. We need
+	 * restore the UC PMU configuration. The irq handler will also call
+	 * the function to set period. At this time, PMU is still enabled and
+	 * we cannot directly disable the PMU.
+	 */
+	if (!enable)
+		hisi_uc_pmu_stop_counters(uc_pmu);
+}
+
+static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
+				      struct hw_perf_event *hwc, u64 val)
+{
+	/*
+	 * HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU
+	 * counter cannot be set due to the lack of clock under power saving
+	 * mode. This will lead to error or inaccurate counts. The clock can
+	 * be enabled by the PMU global enabling control.
+	 */
+	if (uc_pmu->identifier == HISI_PMU_V2)
+		hisi_uc_pmu_write_counter_quirk_hip09(uc_pmu, hwc, val);
+	else
+		writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
 }
 
 static void hisi_uc_pmu_enable_counter_int(struct hisi_pmu *uc_pmu,
-- 
2.33.0


