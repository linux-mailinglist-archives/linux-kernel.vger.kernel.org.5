Return-Path: <linux-kernel+bounces-124868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88F891D56
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17302B2754B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190731CE6B7;
	Fri, 29 Mar 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqpzFu03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD41CE6A5;
	Fri, 29 Mar 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716318; cv=none; b=j1tAr/3EmPRoYHQmdOJ1plxzZlBHKrplujaHveC5Cbrwna0/l2jpXwTW3ct7XFygzP/e9iSZqx2lowDR3kRCHLxkmT3z5rs4sm58KQ5etnxIADQLgM6UijmcdeAPsA3uOPvvWJDO+khEM+l/Dw8g/rQh34fSMeORfTC/G9r2VAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716318; c=relaxed/simple;
	bh=D5Ui/gp8sF9f1UzEJQ3vaUwkLLb4ponSFyCgCJx7zIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9N3RrF6eCSrcp+JmcbsAwqWOyEaVntQ24x4G5jW0YnqDKnEKSZDjKAps5GJRR5+4E9ECKb0guqD4ANiYg9wGQUv97oZPPjDGu/hATcLSNL9mJE9k7PHdgRkRb7+SEEcHKtGO425bxjf5uXfe27B/ELpP+OfDJL+MO59ViidLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqpzFu03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC9EC433C7;
	Fri, 29 Mar 2024 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716318;
	bh=D5Ui/gp8sF9f1UzEJQ3vaUwkLLb4ponSFyCgCJx7zIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqpzFu03QBArd6hbAOhqcxn48noWw8dQ6XsN7Cq+MHhMHx5+AfRvRMNUGi1MgRL83
	 LWNrpsosOzRS6fENJKMU5zQ60tPwNnunSc2iZhGBpdFHjQt8q1jnSaqF6TUHkAz/Vi
	 RMGggrbu6sCrPBsJwDt/Ovbg0f2n8mVMuqv2ENzvA+EhfyF+V5wPodI3R+WmXPNs3o
	 HHmUkgRylexQcM82Hy1f5Sq8uG8zpnkt1OsFcRt9sOAQYTWTJT7cO4a39GJT95dSMo
	 tgyJqBkb+mVOIiAYnszNjNGm7ysaq7FTU9vwwRP3YErBTQWDL72xQdtJ6rN7oeIKzs
	 EyYcaS9Zz2szg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Junhao He <hejunhao3@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.cameron@huawei.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 59/75] drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09
Date: Fri, 29 Mar 2024 08:42:40 -0400
Message-ID: <20240329124330.3089520-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Junhao He <hejunhao3@huawei.com>

[ Upstream commit e10b6976f6b9afdf3564f88c851e42d139bb19c0 ]

HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU counter
cannot be set due to the lack of clock under power saving mode. This will
lead to error or inaccurate counts. The clock can be enabled by the PMU
global enabling control.

This patch tries to fix this by set the UC PMU enable before set event
period to turn on the clock, and then restore the UC PMU configuration.
The counter register can hold its value without a clock.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Link: https://lore.kernel.org/r/20240227125231.53127-1-hejunhao3@huawei.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 42 ++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
index 636fb79647c8c..481dcc9e8fbf8 100644
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
2.43.0


