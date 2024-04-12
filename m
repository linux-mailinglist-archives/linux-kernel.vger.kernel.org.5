Return-Path: <linux-kernel+bounces-143025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B128A335C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3666B21534
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC07148FFC;
	Fri, 12 Apr 2024 16:13:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDABB148313;
	Fri, 12 Apr 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938382; cv=none; b=NA2iYWcL1IkjvOxn9I/uGSoEnU5pmO78/iX6Y3fwARJbjlepVlL+XWp+LwH1YmSP0RM5GiuKDPV7V+2E/KN9IITKx3FvhTz8HqKpqSir+JueIZ/uTQXhNxB7cPms/IACDj/nvLs0mDm12DnCc7OMyFRvEIWDyOiQQnfe9i0Imlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938382; c=relaxed/simple;
	bh=JIdm2DYz2lilYR3ajuwXs1ec1aKJM0YI7TKLW6JFx2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHsw9G8nvJXm4HeaqqQZk4wzdZle+RqpHLCb7pYV9TlHe73wCgFmKLlBcVuuSIjpk4eMc52XyzggpsfzK4IwRKD5IBJjmZoMGEK1paiw78bvlSHxL6eEmVgxnZLhXV4c2ANBIw3R/R8Lo7rIh/2cvOPUZ2DCWwqpX+3oce9YFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM4c5Y7cz6J9hN;
	Sat, 13 Apr 2024 00:11:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A96E41400CF;
	Sat, 13 Apr 2024 00:12:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:12:58 +0100
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
Subject: [PATCH v2 04/30] Documentation: hns-pmu: Use /sys/bus/event_source/devices paths
Date: Fri, 12 Apr 2024 17:10:31 +0100
Message-ID: <20240412161057.14099-5-Jonathan.Cameron@huawei.com>
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

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/admin-guide/perf/hns3-pmu.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/perf/hns3-pmu.rst b/Documentation/admin-guide/perf/hns3-pmu.rst
index 75a40846d47f..1195e570f2d6 100644
--- a/Documentation/admin-guide/perf/hns3-pmu.rst
+++ b/Documentation/admin-guide/perf/hns3-pmu.rst
@@ -16,7 +16,7 @@ HNS3 PMU driver
 
 The HNS3 PMU driver registers a perf PMU with the name of its sicl id.::
 
-  /sys/devices/hns3_pmu_sicl_<sicl_id>
+  /sys/bus/event_source/devices/hns3_pmu_sicl_<sicl_id>
 
 PMU driver provides description of available events, filter modes, format,
 identifier and cpumask in sysfs.
@@ -40,9 +40,9 @@ device.
 
 Example usage of checking event code and subevent code::
 
-  $# cat /sys/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_time
+  $# cat /sys/bus/event_source/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_time
   config=0x00204
-  $# cat /sys/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_packet_num
+  $# cat /sys/bus/event_source/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_packet_num
   config=0x10204
 
 Each performance statistic has a pair of events to get two values to
@@ -60,7 +60,7 @@ computation to calculate real performance data is:::
 
 Example usage of checking supported filter mode::
 
-  $# cat /sys/devices/hns3_pmu_sicl_0/filtermode/bw_ssu_rpu_byte_num
+  $# cat /sys/bus/event_source/devices/hns3_pmu_sicl_0/filtermode/bw_ssu_rpu_byte_num
   filter mode supported: global/port/port-tc/func/func-queue/
 
 Example usage of perf::
-- 
2.39.2


