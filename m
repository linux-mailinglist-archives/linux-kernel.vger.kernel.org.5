Return-Path: <linux-kernel+bounces-143038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ACF8A337E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31C61C21232
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF239149DE2;
	Fri, 12 Apr 2024 16:16:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DE1487FF;
	Fri, 12 Apr 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938566; cv=none; b=UlGpfDuMTKGqz3hNuw5DwYof4tzaiRsod5UicQUg/mun1JoTqZG7cx0QbBzkP0UOfKNnzXJRAaroxID9rJnx3027DyKsVcGZRuSUSC4MaxZdBHkUEgn5kfiKfiPWjYfpO0B9EONtE5le1JI2mf2Ei1HL0AhOaLa7xRFGAtgXo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938566; c=relaxed/simple;
	bh=R7LerIn/HSC7R8/axKcxrEFTXj4LE1SX89SZ9pIIKSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN/o7LzKn46XbrpLzH9f9/vc5dEAIs9UCbkYGKyoQl8zBj0zvzfYqPkgDlTJ6NhCyxsO/FT0JG7AKB5qoBEx+gEmUW7070DbL7M1lVU+v/uhwaSAEZIyFNIKFq3BUERZcaVZJg70DOUXH6rnAFUyfCI2SHoUj+FMq/S3giuz6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM4c4M1Sz6K6hC;
	Sat, 13 Apr 2024 00:11:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 064E7140119;
	Sat, 13 Apr 2024 00:16:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:16:02 +0100
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
Subject: [PATCH v2 10/30] Documentation: thunderx2-pmu: Use /sys/bus/event_source/devices paths
Date: Fri, 12 Apr 2024 17:10:37 +0100
Message-ID: <20240412161057.14099-11-Jonathan.Cameron@huawei.com>
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

To allow setting an appropriate parent for the struct pmu device
remove existing references to /sys/devices/ path.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/admin-guide/perf/thunderx2-pmu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/thunderx2-pmu.rst b/Documentation/admin-guide/perf/thunderx2-pmu.rst
index 01f158238ae1..9255f7bf9452 100644
--- a/Documentation/admin-guide/perf/thunderx2-pmu.rst
+++ b/Documentation/admin-guide/perf/thunderx2-pmu.rst
@@ -22,7 +22,7 @@ The thunderx2_pmu driver registers per-socket perf PMUs for the DMC and
 L3C devices.  Each PMU can be used to count up to 4 (DMC/L3C) or up to 8
 (CCPI2) events simultaneously. The PMUs provide a description of their
 available events and configuration options under sysfs, see
-/sys/devices/uncore_<l3c_S/dmc_S/ccpi2_S/>; S is the socket id.
+/sys/bus/event_source/devices/uncore_<l3c_S/dmc_S/ccpi2_S/>; S is the socket id.
 
 The driver does not support sampling, therefore "perf record" will not
 work. Per-task perf sessions are also not supported.
-- 
2.39.2


