Return-Path: <linux-kernel+bounces-143044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44F8A3389
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA1D1F22AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467A14900F;
	Fri, 12 Apr 2024 16:17:46 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10F14A4CF;
	Fri, 12 Apr 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938665; cv=none; b=good3DYhy1fQ838kVB/to7nW8HcENMW8+oTCnzo9R/NlvdKYzSOro1+Ov2bhC+4HOLV+fHhnofqy0Py7WMnpgc5wH+ix3fkW2WCZGgJc8yQmwWdTK3xtOhilplFVTFzAl2ek6XfVrSZYALnkAMUCWM8mq+Ev4CzJT9HANTEvQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938665; c=relaxed/simple;
	bh=BOV8cMImDOBvm8peb+XAJP16YrY2ZoXrm4injsYTtk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOuu2u1APwCQEfXEHQ1x97zpdIfwkfOskL+51/FTISnel2Kz7MUkkTkVCNFiwkb84y6RKYxWP9c5G1V4MRi5MG300jcJcjvaEofv+M/EyiBTmTu6mEwpFUr3BDxnP7TvDVI5lPg43bVkiq5VabIKKrvie/J81pIAn/Izw6ft5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM9y5mlnz67ZR2;
	Sat, 13 Apr 2024 00:15:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 574A21400F4;
	Sat, 13 Apr 2024 00:17:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:17:34 +0100
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
Subject: [PATCH v2 13/30] Documentation: qcom-pmu: Use /sys/bus/event_source/devices paths
Date: Fri, 12 Apr 2024 17:10:40 +0100
Message-ID: <20240412161057.14099-14-Jonathan.Cameron@huawei.com>
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
 Documentation/admin-guide/perf/qcom_l2_pmu.rst | 2 +-
 Documentation/admin-guide/perf/qcom_l3_pmu.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/perf/qcom_l2_pmu.rst b/Documentation/admin-guide/perf/qcom_l2_pmu.rst
index c130178a4a55..c37c6be9b8d8 100644
--- a/Documentation/admin-guide/perf/qcom_l2_pmu.rst
+++ b/Documentation/admin-guide/perf/qcom_l2_pmu.rst
@@ -10,7 +10,7 @@ There is one logical L2 PMU exposed, which aggregates the results from
 the physical PMUs.
 
 The driver provides a description of its available events and configuration
-options in sysfs, see /sys/devices/l2cache_0.
+options in sysfs, see /sys/bus/event_source/devices/l2cache_0.
 
 The "format" directory describes the format of the events.
 
diff --git a/Documentation/admin-guide/perf/qcom_l3_pmu.rst b/Documentation/admin-guide/perf/qcom_l3_pmu.rst
index a3d014a46bfd..a66556b7e985 100644
--- a/Documentation/admin-guide/perf/qcom_l3_pmu.rst
+++ b/Documentation/admin-guide/perf/qcom_l3_pmu.rst
@@ -9,7 +9,7 @@ PMU with device name l3cache_<socket>_<instance>. User space is responsible
 for aggregating across slices.
 
 The driver provides a description of its available events and configuration
-options in sysfs, see /sys/devices/l3cache*. Given that these are uncore PMUs
+options in sysfs, see /sys/bus/event_source/devices/l3cache*. Given that these are uncore PMUs
 the driver also exposes a "cpumask" sysfs attribute which contains a mask
 consisting of one CPU per socket which will be used to handle all the PMU
 events on that socket.
-- 
2.39.2


