Return-Path: <linux-kernel+bounces-78146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73926860F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267221F2379A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5278667;
	Fri, 23 Feb 2024 10:38:25 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC406166C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684704; cv=none; b=CNdm3d9mSam4qbKm6shZaiu1yyyk3enOiqj4FOHmzVPMa4BjdfoGEy7tWTsvgYvau9YluHyrw1MO1TmQ4CHpoLBcj0/KzdkLDz9yU24sihoSnuuGDLCY8n5/xjm1e5x3Obg0UgRWs3+zYexIlf1KpeUFIoJ6qSuOUJO+EaU03eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684704; c=relaxed/simple;
	bh=pk+IyGIGi9yJjgkMjhMmpH6GqxmlnEiNPeUiPwjsYzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHqCIOhnMJ/RxDI5Ednlc/I8IRYfeSddZ/CQ5zi70HPOxg54uoCbsMihYupoO/HJ5zXe8shkhPDqWGITdcmTlA+dlByBtXsKN4D2lT05MlubTep6ybL7fNzvbD5iIKDRwsvrtYarGO6sHbsJwTqRvl73XueMZHfXlCPVmERpzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Th5yc5vTjz2BdRP;
	Fri, 23 Feb 2024 18:36:08 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 750D01400CC;
	Fri, 23 Feb 2024 18:38:19 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 18:38:19 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <jonathan.cameron@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<hejunhao3@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: [PATCH v2 4/8] drivers/perf: hisi_pcie: Add more events for counting TLP bandwidth
Date: Fri, 23 Feb 2024 18:33:55 +0800
Message-ID: <20240223103359.18669-5-yangyicong@huawei.com>
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

A typical PCIe transaction is consisted of various TLP packets in both
direction. For counting bandwidth only memory read events are exported
currently. Add memory write and completion counting events of both
direction to complete the bandwidth counting.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 9176242eadb3..6f39cb82661e 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -727,10 +727,18 @@ static struct attribute *hisi_pcie_pmu_events_attr[] = {
 	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_cnt, 0x10210),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_latency, 0x0011),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_cnt, 0x10011),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_flux, 0x0104),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_mwr_time, 0x10104),
 	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_flux, 0x0804),
 	HISI_PCIE_PMU_EVENT_ATTR(rx_mrd_time, 0x10804),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_cpl_flux, 0x2004),
+	HISI_PCIE_PMU_EVENT_ATTR(rx_cpl_time, 0x12004),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_mwr_flux, 0x0105),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_mwr_time, 0x10105),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_flux, 0x0405),
 	HISI_PCIE_PMU_EVENT_ATTR(tx_mrd_time, 0x10405),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_cpl_flux, 0x1005),
+	HISI_PCIE_PMU_EVENT_ATTR(tx_cpl_time, 0x11005),
 	NULL
 };
 
-- 
2.24.0


