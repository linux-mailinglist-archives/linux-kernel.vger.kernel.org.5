Return-Path: <linux-kernel+bounces-78142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C4860F86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E03286F72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD176313F;
	Fri, 23 Feb 2024 10:38:23 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC005DF25
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684703; cv=none; b=fREwX9CJngV7uWNoATIYGIkKxM6cSkwP9LPKCvPbfxk/1lpCq44+p0asyCI2638LKlpksFUW4wfuXBpmfEJmFN5cJhWORGw6LQKGqADfKLw8oopE/oaflaGSvYNIRAjukU2WTL/k2fz2z37rlTzxT9uI2ekfxdRN30Svng5OUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684703; c=relaxed/simple;
	bh=2aGsE8mFtWNm5k18rp6bVdMp20XjRknEP+SUteZ5vfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry3Ni0NF4ofcH09oThhpOVnMWi6uZHHVACc7vnrcR2vlpcdNc5cRD2AAGabv4YaE6UYjlIluGM+ymBVWMKgcxPHsaDO7jh9fGRnfNorTQOtzzEcdOJZ0ijOlAw16zREPQRlvBqaYG5hvfPYIIW6ZwAqcjQlNKcsfgCxGDbfXMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Th5yc31stz2BdPS;
	Fri, 23 Feb 2024 18:36:08 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 1385C1A016B;
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
Subject: [PATCH v2 2/8] drivers/perf: hisi_pcie: Introduce hisi_pcie_pmu_get_event_ctrl_val()
Date: Fri, 23 Feb 2024 18:33:53 +0800
Message-ID: <20240223103359.18669-3-yangyicong@huawei.com>
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

Factor out retrieving of the register value for the
corresponding event from hisi_pcie_config_event_ctrl() into a
new function hisi_pcie_pmu_get_event_ctrl_val() allowing future
reuse.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 9760ddde46fd..2468cf3b007c 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -216,10 +216,8 @@ static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32 reg_offset,
 	writeq_relaxed(val, pcie_pmu->base + offset);
 }
 
-static void hisi_pcie_pmu_config_event_ctrl(struct perf_event *event)
+static u64 hisi_pcie_pmu_get_event_ctrl_val(struct perf_event *event)
 {
-	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
-	struct hw_perf_event *hwc = &event->hw;
 	u64 port, trig_len, thr_len, len_mode;
 	u64 reg = HISI_PCIE_INIT_SET;
 
@@ -256,6 +254,15 @@ static void hisi_pcie_pmu_config_event_ctrl(struct perf_event *event)
 	else
 		reg |= FIELD_PREP(HISI_PCIE_LEN_M, HISI_PCIE_LEN_M_DEFAULT);
 
+	return reg;
+}
+
+static void hisi_pcie_pmu_config_event_ctrl(struct perf_event *event)
+{
+	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 reg = hisi_pcie_pmu_get_event_ctrl_val(event);
+
 	hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx, reg);
 }
 
-- 
2.24.0


