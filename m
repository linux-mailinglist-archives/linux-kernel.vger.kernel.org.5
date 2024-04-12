Return-Path: <linux-kernel+bounces-143024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D7A8A335A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DBA283A50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E61494D7;
	Fri, 12 Apr 2024 16:12:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593DB1487E4;
	Fri, 12 Apr 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938351; cv=none; b=h938hvGczyoHHSJaloe5myTy31N2iNpdSBGxwotZRRXKlqnaEvo3loix5jx6TEe+ye1RmlZXWR7L4FcLpsUuEd4xJJShnygDlnZAXBJ+q5ZUTuQs/jYR4NW4UKdMX0WbChl7UP1aDw7j3IsJnd11hdJt3qkC7F3Ibn0TiCMo9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938351; c=relaxed/simple;
	bh=ZB+kqkDFMBi520BBY6bwYCKsFdTW+wu7W+V5/gnp8jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6a6gTGHqnyQS8xmo/sRP0lh3UsDi5PltF0dI0hzWh9qQ9U2Cacjgcn7fCJqV5pQeK+I1nYlHYdghJbToaE0goPk0dNUoJo+uAf1Z5nVz7C4W1TjGwRvLNM/xt/ydxfQJ8h7SRq49ul/dKu8+i3pSYU4tQMegSwBBwRcTj53R/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM4206Ntz689rj;
	Sat, 13 Apr 2024 00:10:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE80B140B3C;
	Sat, 13 Apr 2024 00:12:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:12:27 +0100
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
Subject: [PATCH v2 03/30] perf/hisi-uncore: Assign parents for event_source devices
Date: Fri, 12 Apr 2024 17:10:30 +0100
Message-ID: <20240412161057.14099-4-Jonathan.Cameron@huawei.com>
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..5519965600dc 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -538,6 +538,7 @@ void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
 	struct pmu *pmu = &hisi_pmu->pmu;
 
 	pmu->module             = module;
+	pmu->parent             = hisi_pmu->dev;
 	pmu->task_ctx_nr        = perf_invalid_context;
 	pmu->event_init         = hisi_uncore_pmu_event_init;
 	pmu->pmu_enable         = hisi_uncore_pmu_enable;
-- 
2.39.2


