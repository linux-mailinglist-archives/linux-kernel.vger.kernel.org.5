Return-Path: <linux-kernel+bounces-51500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F62848BF7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E712849FC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90CD10A36;
	Sun,  4 Feb 2024 07:49:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA700DDCD
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032980; cv=none; b=Lu+E7P601pC3fobjuBa87UCao9herzYhq/9w0ArF+AKaNVc7zyuw30SG2CD5mPFNmWuTC0EdMJUGdLSNs6hHU/8mIH5YLfa6QSeyPEXmNvsvHjL+FfYIk37zRiY3IyEOer0LLcXx28GS66gUVK88W18CVYBJI/nwsRmp4K8K32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032980; c=relaxed/simple;
	bh=sOc43RaryoxfnEBRW0kyQI6mjTChmUA4iigSXM/y/A4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlmSknwP1Qj0Gl/SZjmuyRF4ojdQiHDwtWA6Mt3yBCgsMWk5kMFn/oFatD1PURET7ZBnOQwRSPp0ohVqWYyK2NYPEvEig3eXzQ8uZPhOvCbq/FYj+l3cfqawIJ+Nl7pNoMu1RGAGywIy65O+mSe+9FpAlIr6gMTUyZOc3JceDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TSM7y6sd4z1xnC4;
	Sun,  4 Feb 2024 15:48:30 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FE591404D8;
	Sun,  4 Feb 2024 15:49:35 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 15:49:34 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH 1/7] drivers/perf: hisi_pcie: Introduce hisi_pcie_pmu_get_filter()
Date: Sun, 4 Feb 2024 15:45:21 +0800
Message-ID: <20240204074527.47110-2-yangyicong@huawei.com>
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

Factor out retrieving of the register value for the
corresponding event from hisi_pcie_config_filter() into a
new function hisi_pcie_pmu_get_filter() allowing future reuse.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index b90ba8aca3fa..11a819cd07f2 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -216,10 +216,8 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
 	writeq_relaxed(val, pcie_pmu->base + offset);
 }
 
-static void hisi_pcie_pmu_config_filter(struct perf_event *event)
+static u64 hisi_pcie_pmu_get_filter(struct perf_event *event)
 {
-	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
 	u64 port, trig_len, thr_len, len_mode;
 	u64 reg = HISI_PCIE_INIT_SET;
 
@@ -256,6 +254,15 @@ static void hisi_pcie_pmu_config_filter(struct perf_event *event)
 	else
 		reg |= FIELD_PREP(HISI_PCIE_LEN_M, HISI_PCIE_LEN_M_DEFAULT);
 
+	return reg;
+}
+
+static void hisi_pcie_pmu_config_filter(struct perf_event *event)
+{
+	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 reg = hisi_pcie_pmu_get_filter(event);
+
 	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
 }
 
-- 
2.24.0


