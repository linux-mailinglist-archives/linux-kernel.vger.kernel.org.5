Return-Path: <linux-kernel+bounces-83266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 594938690FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBD7B24763
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F5F13AA42;
	Tue, 27 Feb 2024 12:54:12 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1955E63
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038452; cv=none; b=OBsYgiqJmcsYfJuh+Ys37yJmh46U0ITJ9NJfCrWQMa5+09p5CLCny5oXsrE0mSeFruezZnrsCLFF+wLN06bARBLKeYa6EpKUqqZhlP0+Ws36MAPcF7tJfglOPQBSSUzRHCoCuboor/02dZ+W0FounKKsMHOMna3TBv3D1DJu8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038452; c=relaxed/simple;
	bh=DDg8SNYYRHT/ZFNymojeroVxG1EQZrDGaP+SnpQoRVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXE6nRivyePub7YwFWeB5H/ELHGw9116uwRwvw5/hhOoLpSdr9I6bKebVrQi1E6vRooyDn3oLfbANccUTGSGn51QAO0cMSC8HVeCYOjq8uvY+lnoYnhwY1IFe3xDM5eO+5WzsHN5WF1ElVAYRjTQH9rwvo+NBUUmSg5TAJZwhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkcnM4TnRz1h0gk;
	Tue, 27 Feb 2024 20:51:51 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id A2E5518005F;
	Tue, 27 Feb 2024 20:54:05 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 20:54:05 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <will@kernel.org>, <jonathan.cameron@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <yangyicong@huawei.com>, <prime.zeng@hisilicon.com>,
	<hejunhao3@huawei.com>
Subject: [PATCH v2] drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09
Date: Tue, 27 Feb 2024 20:52:31 +0800
Message-ID: <20240227125231.53127-1-hejunhao3@huawei.com>
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

Changes since V1:
- Updated the comment regarding the quirk function.
- Extract write counter normal to a helper function.
Link: https://lore.kernel.org/all/20240207094245.34195-1-hejunhao3@huawei.com/

 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 42 ++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
index 636fb79647c8..481dcc9e8fbf 100644
--- a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
@@ -287,12 +287,52 @@ static u64 hisi_uc_pmu_read_counter(struct hisi_pmu *uc_pmu,
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
+static void hisi_uc_pmu_write_counter_normal(struct hisi_pmu *uc_pmu,
 				      struct hw_perf_event *hwc, u64 val)
 {
 	writeq(val, uc_pmu->base + HISI_UC_CNTR_REGn(hwc->idx));
 }
 
+static void hisi_uc_pmu_write_counter_quirk_v2(struct hisi_pmu *uc_pmu,
+				      struct hw_perf_event *hwc, u64 val)
+{
+	hisi_uc_pmu_start_counters(uc_pmu);
+	hisi_uc_pmu_write_counter_normal(uc_pmu, hwc, val);
+	hisi_uc_pmu_stop_counters(uc_pmu);
+}
+
+static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
+				      struct hw_perf_event *hwc, u64 val)
+{
+	bool enable = hisi_uc_pmu_get_glb_en_state(uc_pmu);
+	bool erratum = uc_pmu->identifier == HISI_PMU_V2;
+
+	/*
+	 * HiSilicon UC PMU v2 suffers the erratum 162700402 that the
+	 * PMU counter cannot be set due to the lack of clock under power
+	 * saving mode. This will lead to error or inaccurate counts.
+	 * The clock can be enabled by the PMU global enabling control.
+	 * The irq handler and pmu_start() will call the function to set
+	 * period. If the function under irq context, the PMU has been
+	 * enabled therefore we set counter directly. Other situations
+	 * the PMU is disabled, we need to enable it to turn on the
+	 * counter clock to set period, and then restore PMU enable
+	 * status, the counter can hold its value without a clock.
+	 */
+	if (enable || !erratum)
+		hisi_uc_pmu_write_counter_normal(uc_pmu, hwc, val);
+	else
+		hisi_uc_pmu_write_counter_quirk_v2(uc_pmu, hwc, val);
+}
+
 static void hisi_uc_pmu_enable_counter_int(struct hisi_pmu *uc_pmu,
 					   struct hw_perf_event *hwc)
 {
-- 
2.33.0


