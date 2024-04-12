Return-Path: <linux-kernel+bounces-143031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9F8A3369
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A58F1C2115B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB079148FEB;
	Fri, 12 Apr 2024 16:14:34 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043505491F;
	Fri, 12 Apr 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938474; cv=none; b=p1tqY5n7iIhgaYxOZ6Ih6yE6Hsn63AXz44hcK4oM1Ee5S7jb4ihbtMXyah6zOf7PdzIzscr9E7aCtO6hJhOcbCN/AKpUkyFUSHx/5eYB2VKRFMyKJuq4tnPgh1Zrwdkpdq4i52hg0TqPiQqhxBgGqdpsvmgItvc3V3174jU0Ams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938474; c=relaxed/simple;
	bh=p06OpvC2AIuj5o4k6GXceeMNnldcodHgVRHyGIW19es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWvlf0LL6kHVI313b1Qcplh+NljY6MzDEX9Jkg8ZUluPvdFpIc1Omt605aPS8EY5ZVLuWXLzPKdVCaiBIacibZK8d1ILPucwKfJE8A95z6D5nNJFaDrLzsISq1B8mnO3+dHfv6cj7d/DJ95IKkzWkAadnxx9XqSKKwrg5BgeGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM6N67tzz6J9hN;
	Sat, 13 Apr 2024 00:12:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BE15E1400F4;
	Sat, 13 Apr 2024 00:14:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:14:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Will Deacon <will@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<gregkh@linuxfoundation.org>
CC: <linuxarm@huawei.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Yicong
 Yang <yangyicong@hisilicon.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>, Atish Patra
	<atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Andy Gross
	<agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Frank Li
	<Frank.li@nxp.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Vineet Gupta
	<vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fenghua Yu
	<fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Wu Hao
	<hao.wu@intel.com>, Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Liang Kan
	<kan.liang@linux.intel.com>
Subject: [PATCH v2 07/30] perf/arm_cspmu: Assign parents for event_source devices
Date: Fri, 12 Apr 2024 17:10:34 +0100
Message-ID: <20240412161057.14099-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Currently all these devices appear directly under /sys/devices/
Only root busses should appear there, so instead assign the pmu->dev
parents to be the platform device.

Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index b9a252272f1e..601d7d0d81d4 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1206,6 +1206,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 	cspmu->pmu = (struct pmu){
 		.task_ctx_nr	= perf_invalid_context,
 		.module		= cspmu->impl.module,
+		.parent		= cspmu->dev,
 		.pmu_enable	= arm_cspmu_enable,
 		.pmu_disable	= arm_cspmu_disable,
 		.event_init	= arm_cspmu_event_init,
-- 
2.39.2


