Return-Path: <linux-kernel+bounces-143032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBBC8A336C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C273B25B00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7FC14882F;
	Fri, 12 Apr 2024 16:15:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E05491F;
	Fri, 12 Apr 2024 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938505; cv=none; b=P6B1gAzKuxErbO7w4NoPCicFSOK0qGUWMR7RO9WM9k4E8RLmF2eGqJNTKQCTTIKKZTjrPWyo7xvghUX3EalpT5lJLKAYCNQxMSnge3i+JER/F1k/qCZAtxfHXlkPNiwjWuv4bskDmRvB6/XuudPVvD14RtL70uEIt1jpPMd/2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938505; c=relaxed/simple;
	bh=+IWy99af1h3JEWXUPm1/plozSegm1w4gAbK6Yqz41xQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjXL2n4ePWQeAqGDtMLbr0KhN7bGi9aYreK2nMMYKCFY2S8pTCYoijJIglFQNzg+jQ9iTjgiM5Yzy7OqQPsDPtsoYWxaFCD0HEgcBC4tuDKmaqKDB3ei7gZm2W71e5RNRBIy7/Cd99yXE1sO+BKXOU8VNaGy08Ld1PsDdHc+hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM3R0Q5nz688p7;
	Sat, 13 Apr 2024 00:10:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 79F991400F4;
	Sat, 13 Apr 2024 00:15:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:15:00 +0100
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
Subject: [PATCH v2 08/30] Documentation: xgene-pmu: Use /sys/bus/event_source/devices paths
Date: Fri, 12 Apr 2024 17:10:35 +0100
Message-ID: <20240412161057.14099-9-Jonathan.Cameron@huawei.com>
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
 Documentation/admin-guide/perf/xgene-pmu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/xgene-pmu.rst b/Documentation/admin-guide/perf/xgene-pmu.rst
index 644f8ed89152..98ccb8e777c4 100644
--- a/Documentation/admin-guide/perf/xgene-pmu.rst
+++ b/Documentation/admin-guide/perf/xgene-pmu.rst
@@ -13,7 +13,7 @@ PMU (perf) driver
 
 The xgene-pmu driver registers several perf PMU drivers. Each of the perf
 driver provides description of its available events and configuration options
-in sysfs, see /sys/devices/<l3cX/iobX/mcbX/mcX>/.
+in sysfs, see /sys/bus/event_source/devices/<l3cX/iobX/mcbX/mcX>/.
 
 The "format" directory describes format of the config (event ID),
 config1 (agent ID) fields of the perf_event_attr structure. The "events"
-- 
2.39.2


