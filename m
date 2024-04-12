Return-Path: <linux-kernel+bounces-143030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83578A3366
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E907E1C20D90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AF148852;
	Fri, 12 Apr 2024 16:14:04 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A555491F;
	Fri, 12 Apr 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938444; cv=none; b=bdEHJ/nK73NU08M90UOvKeVSlsW9VyS9yKVbu9C74TJ3he8+49uX1kydCfvtUz9xQmW4VpisC8EXhEMacN1Z35jSU9UNwgIx2xSq3ngbIDPGs6Hxg6AF8P5gaLOLCX4n5MD3OxRYyTaxrFQt13IA91ha6q8RoW/jAE/4iqPCONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938444; c=relaxed/simple;
	bh=E1FkTll9y9ACmFO9o1vmBlbFQqYqfpIrDsoLnG1hZrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=np0GijZAs3I4XPeOSSZmdkqxVdSsZiw5gI8cja4Kcey+pyglShxggMGROAddWrKMtKsFz/l/nbuzlp/rjLf1Y4zysuFCy/mSrMLiwDEU471+6NEUR9s3KIG4eAvoZpOfiCmuwPEYArlINYt6ANuLuylUWRjoppmdCFvTPDbA19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM2F4dmTz6K90J;
	Sat, 13 Apr 2024 00:09:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 166AB1400CF;
	Sat, 13 Apr 2024 00:14:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:13:59 +0100
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
Subject: [PATCH v2 06/30] perf/amlogic: Assign parents for event_source devices
Date: Fri, 12 Apr 2024 17:10:33 +0100
Message-ID: <20240412161057.14099-7-Jonathan.Cameron@huawei.com>
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
Reviewed-by: Jiucheng Xu <jiucheng.xu@amlogic.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/amlogic/meson_ddr_pmu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/amlogic/meson_ddr_pmu_core.c b/drivers/perf/amlogic/meson_ddr_pmu_core.c
index bbc7285fd934..07446d784a1a 100644
--- a/drivers/perf/amlogic/meson_ddr_pmu_core.c
+++ b/drivers/perf/amlogic/meson_ddr_pmu_core.c
@@ -492,6 +492,7 @@ int meson_ddr_pmu_create(struct platform_device *pdev)
 	*pmu = (struct ddr_pmu) {
 		.pmu = {
 			.module		= THIS_MODULE,
+			.parent		= &pdev->dev,
 			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 			.task_ctx_nr	= perf_invalid_context,
 			.attr_groups	= attr_groups,
-- 
2.39.2


