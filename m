Return-Path: <linux-kernel+bounces-143019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228C8A3351
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CCC1F23EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA7148852;
	Fri, 12 Apr 2024 16:11:02 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD591487F6;
	Fri, 12 Apr 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938262; cv=none; b=nU9pbeqrPgbmL5pR2eOSq/NMdalY4dwHwoWPT3hpbD/6+7UCYPMf0TV3h0HsGzYKI/ZdZ1OtlsvI/YPro0iewD8J2SxlIU0dMnRxHHtCN2p+2z9TwLSucMOoA+Ffs6im9Z4ms5SkTQ3xzTIwgTwe4b5w5fbqtsEROvi8DxulVP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938262; c=relaxed/simple;
	bh=dzWGOiLimSBZrDtlr7rjGJQge1jpYnra93ATu1ihuSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i5x3V3Mh667pL4Ao4zm/bvx1EORmyMfOr5CzCTZol3H3w17SwyekbP/t3FQols0xgDiDCwbNeaqgPmm3GrCshtdw8739Vb6JrsJ1GIrJhSc1LpRLYIWZOjNCUnYPGPldIV6jRQEcWTU9JusK6vHEywW/nUOJD7FFBLnpFs/nUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VGM2F3Pbyz6J9xD;
	Sat, 13 Apr 2024 00:09:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 64041140B3C;
	Sat, 13 Apr 2024 00:10:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:10:54 +0100
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
Subject: [PATCH v2 00/30] Add parents to struct pmu -> dev
Date: Fri, 12 Apr 2024 17:10:27 +0100
Message-ID: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Robin posted a patch for the cmn and that reminded me that I never
sent a v2.

v2: Drop first patch that added a parent to struct pmu as that has been
    upstream for a year.
    Drop the arm-cmn change as Robin has dealt with that one.
    Gathered tags.

Updated cover letter:

These are the low hanging fruit following GregKH's feedback that
all the devices registered via perf_pmu_register() should have parents.

Note that this causes potential ABI breakage.

It may fall in the category of it isn't breakage if no one notices
but I can't be certain of that.  Whilst it is arguable that
no one should be been accessing PMUs except via the event_source
bus, there was documentation suggesting /sys/devices/ for particular
PMUs (because it was a shorter path?)

Addressing all the other instances of struct pmu not covered by this series
is likely to be a more complex discussion but unlikely to have an affect
on what is proposed here.

Documentation updates deliberately 'fixed' in separate patches before
changing the path to highlight that using /sys/bus/event_source/devices
path is unchanged by this series and that is presumed to be the
most common way these files are accessed.

Jonathan Cameron (30):
  perf/hisi-pcie: Assign parent for event_source device
  Documentation: hisi-pmu: Drop reference to /sys/devices path
  perf/hisi-uncore: Assign parents for event_source devices
  Documentation: hns-pmu: Use /sys/bus/event_source/devices paths
  perf/hisi-hns3: Assign parents for event_source device
  perf/amlogic: Assign parents for event_source devices
  perf/arm_cspmu: Assign parents for event_source devices
  Documentation: xgene-pmu: Use /sys/bus/event_source/devices paths
  perf/xgene: Assign parents for event_source devices
  Documentation: thunderx2-pmu: Use /sys/bus/event_source/devices paths
  perf/thunderx2: Assign parents for event_source devices
  perf/riscv: Assign parents for event_source devices
  Documentation: qcom-pmu: Use /sys/bus/event_source/devices paths
  perf/qcom: Assign parents for event_source devices
  perf/imx_ddr: Assign parents for event_source devices
  perf/arm_pmu: Assign parents for event_source devices
  perf/alibaba_uncore: Assign parents for event_source device
  perf/arm-cci: Assign parents for event_source device
  perf/arm-ccn: Assign parents for event_source device
  perf/arm-dmc620: Assign parents for event_source device
  perf/arm-dsu: Assign parents for event_source device
  perf/arm-smmuv3: Assign parents for event_source device
  perf/arm-spe: Assign parents for event_source device
  arc: Assign parents for event_source devices
  ARM: imx: Assign parents for mmdc event_source devices
  dmaengine: idxd: Assign parent for event_source device
  fpga: dfl: Assign parent for event_source device
  drivers/nvdimm: Assign parent for event_source device
  Documentation: ABI + trace: hisi_ptt: update paths to bus/event_source
  hwtracing: hisi_ptt: Assign parent for event_source device

 ...i_ptt => sysfs-bus-event_source-devices-hisi_ptt} | 12 ++++++------
 Documentation/admin-guide/perf/hisi-pmu.rst          |  1 -
 Documentation/admin-guide/perf/hns3-pmu.rst          |  8 ++++----
 Documentation/admin-guide/perf/qcom_l2_pmu.rst       |  2 +-
 Documentation/admin-guide/perf/qcom_l3_pmu.rst       |  2 +-
 Documentation/admin-guide/perf/thunderx2-pmu.rst     |  2 +-
 Documentation/admin-guide/perf/xgene-pmu.rst         |  2 +-
 Documentation/trace/hisi-ptt.rst                     |  4 ++--
 MAINTAINERS                                          |  2 +-
 arch/arc/kernel/perf_event.c                         |  1 +
 arch/arm/mach-imx/mmdc.c                             |  1 +
 drivers/dma/idxd/perfmon.c                           |  1 +
 drivers/fpga/dfl-fme-perf.c                          |  1 +
 drivers/hwtracing/ptt/hisi_ptt.c                     |  1 +
 drivers/nvdimm/nd_perf.c                             |  1 +
 drivers/perf/alibaba_uncore_drw_pmu.c                |  1 +
 drivers/perf/amlogic/meson_ddr_pmu_core.c            |  1 +
 drivers/perf/arm-cci.c                               |  1 +
 drivers/perf/arm-ccn.c                               |  1 +
 drivers/perf/arm_cspmu/arm_cspmu.c                   |  1 +
 drivers/perf/arm_dmc620_pmu.c                        |  1 +
 drivers/perf/arm_dsu_pmu.c                           |  1 +
 drivers/perf/arm_pmu_platform.c                      |  1 +
 drivers/perf/arm_smmuv3_pmu.c                        |  1 +
 drivers/perf/arm_spe_pmu.c                           |  1 +
 drivers/perf/fsl_imx8_ddr_perf.c                     |  1 +
 drivers/perf/hisilicon/hisi_pcie_pmu.c               |  1 +
 drivers/perf/hisilicon/hisi_uncore_pmu.c             |  1 +
 drivers/perf/hisilicon/hns3_pmu.c                    |  1 +
 drivers/perf/qcom_l2_pmu.c                           |  1 +
 drivers/perf/qcom_l3_pmu.c                           |  1 +
 drivers/perf/riscv_pmu_legacy.c                      |  1 +
 drivers/perf/riscv_pmu_sbi.c                         |  1 +
 drivers/perf/thunderx2_pmu.c                         |  1 +
 drivers/perf/xgene_pmu.c                             |  1 +
 35 files changed, 43 insertions(+), 18 deletions(-)
 rename Documentation/ABI/testing/{sysfs-devices-hisi_ptt => sysfs-bus-event_source-devices-hisi_ptt} (90%)

-- 
2.39.2


