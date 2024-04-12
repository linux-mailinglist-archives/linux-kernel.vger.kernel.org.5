Return-Path: <linux-kernel+bounces-143053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672898A339F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983991C21770
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610371487F6;
	Fri, 12 Apr 2024 16:20:14 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3C149C4C;
	Fri, 12 Apr 2024 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938813; cv=none; b=crITsuVgtpV1esSuw0W9NYpguE1SL2g6w4JW1avBoz4mfMF9c4n9NvslPnLRiVQpaeSf37pSFEjvYh0fxSq0LXpphvQIV9OXvTbzxJPLlgkobrOM/f/C6TMccZCiGU53R8+IgUNN2GzJwBxW8Xv9dUlagDixFjXI6kumGAHJ1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938813; c=relaxed/simple;
	bh=0qrYwaqfdvUjWOJJnNV5Jz5XmUlpEiLxFrP0SFtaR3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxZ76M5eu3dG8hi9UNDrHiHgtb0+kVwQQmgYYYe5chLGJ8zAjV8QnILNQidaJc7dBldEErIdZmYhrr1Kq58vmtHVVTUDhrgcMYtrCr1nZ3LKLAXdab0uRCwZ2TZ8COSQyAh5InhKlcCj2p7m/PB+fRU0CM56KqXxc1eOifI2BBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGMDw2YRQz685ZJ;
	Sat, 13 Apr 2024 00:18:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E228E1400F4;
	Sat, 13 Apr 2024 00:20:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:08 +0100
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
Subject: [PATCH v2 18/30] perf/arm-cci: Assign parents for event_source device
Date: Fri, 12 Apr 2024 17:10:45 +0100
Message-ID: <20240412161057.14099-19-Jonathan.Cameron@huawei.com>
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

Currently the PMU device appears directly under /sys/devices/
Only root busses should appear there, so instead assign the pmu->dev
parent to be the platform device.

Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/arm-cci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 6be03f81ae5d..a7fd80677919 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1409,6 +1409,7 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 
 	cci_pmu->pmu = (struct pmu) {
 		.module		= THIS_MODULE,
+		.parent		= &pdev->dev,
 		.name		= cci_pmu->model->name,
 		.task_ctx_nr	= perf_invalid_context,
 		.pmu_enable	= cci_pmu_enable,
-- 
2.39.2


