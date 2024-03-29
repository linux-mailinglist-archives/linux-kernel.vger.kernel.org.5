Return-Path: <linux-kernel+bounces-124789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6F891C87
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122B71F229A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C0C189A35;
	Fri, 29 Mar 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW1fqsRU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C418925D;
	Fri, 29 Mar 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716144; cv=none; b=pJOHjGPS17IFGfAVVSoBS0vcns10ST3i167H8PtlL6OLKFdOEOyNkxgdcIXy+1iYpVQey4tuH8au4O/NZ7QWd+13E29rVgArmfDp077KYoU3Pu/yP2kcK//soS4Xd4U9zHJX89L54QhG1amjWALFVHLghQNzhdntaM91y/6+RYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716144; c=relaxed/simple;
	bh=D5Ui/gp8sF9f1UzEJQ3vaUwkLLb4ponSFyCgCJx7zIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZeuWLakFvdodeTMx9xVb/tIsvLErLIH9rQWvpAHaxkDdzkka4N/E6HaGoJDt8rGoiq6ofiXvh2OYThTNfDTS7U7fYPVgn/vy8+KGNawVb+Wp8J4oksPecaEkz11mtqowgVIlhDzAY8zTjFRfWIndfttgrUeERAAKuiv/KJ8By4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW1fqsRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83220C433F1;
	Fri, 29 Mar 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716143;
	bh=D5Ui/gp8sF9f1UzEJQ3vaUwkLLb4ponSFyCgCJx7zIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW1fqsRUhs5+0bZvOwFSPNgUjgUdh02C5tk9h7nJGGXTrtE0d1VOX0dMASRxQYBBj
	 u4NJL7GtIsW45nE7cfjKrZ/XEosFgpATl5r1M7qgIw1j9VIMwqlNxBmmxwZ2M7OrHU
	 Yd95jOm220dwoLWF4P/Wnpr78iRHFbd0xlSIv+OvIh9+JQjTwAGuN3qqPE+t5KYLTB
	 UF/dk0xms+R56zWpvQ0i8VaZqhnvj0tTS6FeFxALQW+D4pB3lTCP8qu44zdHLEw9i5
	 USTNGuLmDhlAf8lsDOjd3rgnNCDz8EXNtYX98uq0TrXTEhubFvRi+QHA5/2VECnU6/
	 KTvahVRGfA+IQ==
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
Subject: [PATCH AUTOSEL 6.8 79/98] drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09
Date: Fri, 29 Mar 2024 08:37:50 -0400
Message-ID: <20240329123919.3087149-79-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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


