Return-Path: <linux-kernel+bounces-51505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846D848BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F3A1C20F2E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145E414012;
	Sun,  4 Feb 2024 07:49:45 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD213AD8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032984; cv=none; b=ZZ+TH7Y0SLRkFtHf53AkTpuCqLkp8AmoTGjiDk02VJbdfn9wXAhcr6SneT6nJ1SIqm+Twh7O85CHcxc70OcgwNB1DZgvO83U9Wng+EXgkwsYxCcwikrOT8OBVw0JXvXwlNVLQm5nKUW0UV7p0rrT+w5B17lKEnQRvhN7HOiW4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032984; c=relaxed/simple;
	bh=TKRofWhs3zGlYCdkuuvozkIm/3tjTK+ONGEbc3I8K3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvzFrQCUDqCt+TL1U+kh2ko8kUdw0nokS8w8Vt4A9tdXW4dpONFeQtNvIL7HRE4YFlHB8ifdYjyUCQAL6EOSKlzzSKAUT8HEjk7ge+iEekTs95Ha1bpex+PJS6Ggm184WK8Rzm4j4SA2gUf/M4MxNxv4QWlSeRZYHPdWVF4w65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TSM7120Rfz1Q8cR;
	Sun,  4 Feb 2024 15:47:41 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 75F101A0178;
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
Subject: [PATCH 3/7] drivers/perf: hisi_pcie: Add more events for counting TLP bandwidth
Date: Sun, 4 Feb 2024 15:45:23 +0800
Message-ID: <20240204074527.47110-4-yangyicong@huawei.com>
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

A typical PCIe transaction is consisted of various TLP packets in both
direction. For counting bandwidth only memory read events are exported
currently. Add memory write and completion counting events of both
direction to complementation.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_pcie_pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 9623bed93876..83be3390686c 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -726,10 +726,18 @@ static struct attribute *hisi_pcie_pmu_events_attr[] = {
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


