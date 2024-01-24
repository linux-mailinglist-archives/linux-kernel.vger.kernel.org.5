Return-Path: <linux-kernel+bounces-36517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4583A230
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA7F1C244FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0F101CA;
	Wed, 24 Jan 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BmAdsXVG"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066F16428;
	Wed, 24 Jan 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078544; cv=none; b=UcQxa3JzETaJ5MHbPkMetw6ae/5QgdROfYd93BGnu4gvljX+jnFt0d9IoagcOe9EqT+aE+Tl0GewvXeQDKEGpli/tToYFDPWy9LHKKxNFu2iEVKe9qtDLToraxZLux04ENazDiM+/H51p1Wh4vepnW1NILHk6BYkze/dqrACQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078544; c=relaxed/simple;
	bh=U7zBOXW/NAyjh0RzXQdKSzAgrfxTaNv996kYwAl7LSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vu3NmS4EYqCbaPFSh2o6ou4BhsO2ZTbd5sYJjh5jR36yas4LqONjipkSpJgiqHr8ZcA2Mb/DoCalKiMA9Bcz/UEJ0qfrtFh1unTSH/iI/vVKLopl1dbkiZaZH0jg7pjcK2UaS1IFHmRbWXsy/BzvXOLoAyl0qlF+9zkGd2y/NYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BmAdsXVG; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NKRgUL008119;
	Tue, 23 Jan 2024 22:42:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=yS1cY+IR
	1klCtL7VLr4rlfO6cmrbAs8LJwsEk0E7Ybk=; b=BmAdsXVGxmEp+ZfJQEh+GY5Q
	L9krQ6h/1Rf7ZDYNUeshHNjn5Y8EOFY1ckyPVoTV8mwxuNsv0feUffGIG+6vAxUY
	NRM2MVJ+ZWwIave+IRcqRTW30KnWSpA8Z3Q6MX+BzkfaNCdwESysL9ql0udoKbd2
	KKRWycdoCiw11TFGvNH4FqeLRWh0yCDsVW6aXNxnwR1j2JittGqvyqkz6JkAWsSq
	miANoxzY4u87TkF/+hf+GJoiqSFu67SU/39U19lzcp39HyGAE6wAUt3u1SyI8qsk
	0YmML2h0yLS+OVjwCNic6wf2qgqHjNug6z52lkqL7Z3DtUOz3wr0L5dXk8phPQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vtmgvhmwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 22:42:14 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 23 Jan
 2024 22:42:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 23 Jan 2024 22:42:12 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
	by maili.marvell.com (Postfix) with ESMTP id CEB505B6947;
	Tue, 23 Jan 2024 22:42:08 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <richardcochran@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: [net-next PATCH] octeontx2: Add PTP clock driver for Octeon PTM clock.
Date: Wed, 24 Jan 2024 12:11:56 +0530
Message-ID: <20240124064156.2577119-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EaYoWtsslpcI_rVtJwgLsHeWlK_zvKrg
X-Proofpoint-GUID: EaYoWtsslpcI_rVtJwgLsHeWlK_zvKrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_02,2024-01-23_02,2023-05-22_02

The PCIe PTM(Precision time measurement) protocol provides precise
coordination of events across multiple components like PCIe host
clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
support for ptp clock based PTM clock. We can use this PTP device
to sync the PTM time with CLOCK_REALTIME or other PTP PHC
devices using phc2sys.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/ptp/Kconfig          |  10 ++
 drivers/ptp/Makefile         |   1 +
 drivers/ptp/ptp_octeon_ptm.c | 254 +++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 drivers/ptp/ptp_octeon_ptm.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 5dd5f188e14f..afa82555dbd9 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -212,4 +212,14 @@ config PTP_DFL_TOD
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_dfl_tod.
 
+config PTP_CLOCK_OCTEON
+	tristate "OCTEON PTM PTP clock"
+	depends on PTP_1588_CLOCK
+	default n
+	help
+	  This driver adds support for using Octeon PTM device clock as
+	  a PTP clock.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_octeon_ptm.
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index dea0cebd2303..e811ae6df5c0 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
+obj-$(CONFIG_PTP_CLOCK_OCTEON)		+= ptp_octeon_ptm.o
diff --git a/drivers/ptp/ptp_octeon_ptm.c b/drivers/ptp/ptp_octeon_ptm.c
new file mode 100644
index 000000000000..da069645ebf7
--- /dev/null
+++ b/drivers/ptp/ptp_octeon_ptm.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell PTP PHC clock driver for PCIe PTM (Precision Time Measurement) EP
+ *
+ * Copyright (c) 2023 Marvell.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include <linux/ptp_clock_kernel.h>
+
+#include "ptp_private.h"
+
+#define PEMX_PFX_CSX_PFCFGX(pem, pf, _offset)	({typeof(_offset) (offset) = (_offset); \
+						((0x8e0000008000 | (u64)(pem) << 36 \
+						| (pf) << 18 \
+						| (((offset) >> 16) & 1) << 16 \
+						| ((offset) >> 3) << 3) \
+						+ ((((offset) >> 2) & 1) << 2)); })
+
+#define PEMX_CFG_WR(a)			(0x8E0000000018ull | (u64)(a) << 36)
+#define PEMX_CFG_RD(a)			(0x8E0000000020ull | (u64)(a) << 36)
+
+/* Octeon CSRs   */
+#define PEMX_CFG                        0x8e00000000d8ULL
+#define PEMX_PTM_CTL			0x8e0000000098ULL
+#define PEMX_PTM_CTL_CAP		BIT_ULL(10)
+#define PEMX_PTM_LCL_TIME		0x8e00000000a0ULL /* PTM time */
+#define PEMX_PTM_MAS_TIME		0x8e00000000a8ULL /* PTP time */
+#define PTM_DEBUG			0
+
+struct oct_ptp_clock {
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info caps;
+	bool cn10k_variant;
+};
+
+static struct oct_ptp_clock oct_ptp_clock;
+static void __iomem *ptm_ctl_addr;
+static void __iomem *ptm_lcl_addr;
+
+/* Config space registers   */
+#define PCIEEPX_PTM_REQ_STAT		(oct_ptp_clock.cn10k_variant ? 0x3a8 : 0x474)
+#define PCIEEPX_PTM_REQ_T1L		(oct_ptp_clock.cn10k_variant ? 0x3b4 : 0x480)
+#define PCIEEPX_PTM_REQ_T1M		(oct_ptp_clock.cn10k_variant ? 0x3b8 : 0x484)
+#define PCIEEPX_PTM_REQ_T4L		(oct_ptp_clock.cn10k_variant ? 0x3c4 : 0x490)
+#define PCIEEPX_PTM_REQ_T4M		(oct_ptp_clock.cn10k_variant ? 0x3c8 : 0x494)
+
+#define PCI_VENDOR_ID_CAVIUM			0x177d
+#define PCI_DEVID_OCTEONTX2_PTP			0xA00C
+#define PCI_SUBSYS_DEVID_95XX			0xB300
+#define PCI_SUBSYS_DEVID_95XXN			0xB400
+#define PCI_SUBSYS_DEVID_95XXMM			0xB500
+#define PCI_SUBSYS_DEVID_96XX			0xB200
+#define PCI_SUBSYS_DEVID_98XX			0xB100
+#define PCI_SUBSYS_DEVID_CN10K_A		0xB900
+#define PCI_SUBSYS_DEVID_CN10K_B		0xBD00
+#define PCI_SUBSYS_DEVID_CNF10K_A		0xBA00
+#define PCI_SUBSYS_DEVID_CNF10K_B		0xBC00
+
+static bool is_otx2_support_ptm(struct pci_dev *pdev)
+{
+	return (pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XX ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XXN ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_98XX ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_95XXMM);
+}
+
+static bool is_cn10k_support_ptm(struct pci_dev *pdev)
+{
+	return (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_A ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_B ||
+		pdev->subsystem_device == PCI_SUBSYS_DEVID_CNF10K_B);
+}
+
+static int ptp_oct_ptm_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_oct_ptm_settime(struct ptp_clock_info *ptp,
+			       const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+static u32 read_pcie_config32(int ep_pem, int cfg_addr)
+{
+	void __iomem *addr;
+	u64 val;
+
+	if (oct_ptp_clock.cn10k_variant) {
+		addr  = ioremap(PEMX_PFX_CSX_PFCFGX(ep_pem, 0, cfg_addr), 8);
+		if (!addr) {
+			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
+			return -1U;
+		}
+		val = readl(addr);
+		iounmap(addr);
+	} else {
+		addr  = ioremap(PEMX_CFG_RD(ep_pem), 8);
+		if (!addr) {
+			pr_err("PTM_EP: Failed to ioremap Octeon CSR space\n");
+			return -1U;
+		}
+		val = ((1 << 15) | (cfg_addr & 0xfff));
+		writeq(val, addr);
+		val = readq(addr) >> 32;
+		iounmap(addr);
+	}
+	return (val & 0xffffffff);
+}
+
+static uint64_t octeon_csr_read(u64 csr_addr)
+{
+	u64 val;
+	void __iomem *addr;
+
+	addr = ioremap(csr_addr, 8);
+	if (!addr) {
+		pr_err("PTM_EP: Failed to ioremap CSR space\n");
+		return -1UL;
+	}
+	val = (u64)READ_ONCE(*(u64 __iomem *)addr);
+	iounmap(addr);
+	return val;
+}
+
+static int ptp_oct_ptm_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	u64 ptp_time, val64;
+#if PTM_DEBUG
+	u64 ptm_time;
+#endif
+	u32 val32;
+
+	/* Check for valid PTM context */
+	val32 = read_pcie_config32(0, PCIEEPX_PTM_REQ_STAT);
+	if (!(val32 & 0x1)) {
+		pr_err("PTM_EP: ERROR: PTM context not valid: 0x%x\n", val32);
+#if PTM_DEBUG
+		ptm_time = 0;
+#endif
+		ptp_time = 0;
+
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+
+		return -EINVAL;
+	}
+
+	/* Trigger PTM/PTP capture */
+	val64 = (u64)READ_ONCE(*(u64 __iomem *)ptm_ctl_addr);
+	val64 |= PEMX_PTM_CTL_CAP;
+	WRITE_ONCE(*(u64 __iomem *)ptm_ctl_addr, val64);
+	/* Read PTM/PTP clocks  */
+	ptp_time = (u64)READ_ONCE(*(u64 __iomem *)ptm_lcl_addr);
+	ts->tv_sec = ptp_time / NSEC_PER_SEC;
+	ts->tv_nsec = ptp_time % NSEC_PER_SEC;
+
+#if PTM_DEBUG
+	ptm_time = octeon_csr_read(PEMX_PTM_MAS_TIME);
+	pr_info("PTM_EP: system %lld ptm time: %lld\n", ptp_time, ptm_time);
+#endif
+
+	return 0;
+}
+
+static int ptp_oct_ptm_enable(struct ptp_clock_info *ptp,
+			      struct ptp_clock_request *rq, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct ptp_clock_info ptp_oct_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "OCTEON PTM PHC",
+	.max_adj	= 0,
+	.n_ext_ts	= 0,
+	.n_pins		= 0,
+	.pps		= 0,
+	.adjtime	= ptp_oct_ptm_adjtime,
+	.gettime64	= ptp_oct_ptm_gettime,
+	.settime64	= ptp_oct_ptm_settime,
+	.enable		= ptp_oct_ptm_enable,
+};
+
+static void __exit ptp_oct_ptm_exit(void)
+{
+	iounmap(ptm_ctl_addr);
+	iounmap(ptm_lcl_addr);
+	ptp_clock_unregister(oct_ptp_clock.ptp_clock);
+}
+
+static int __init ptp_oct_ptm_init(void)
+{
+	struct pci_dev *pdev = NULL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+			      PCI_DEVID_OCTEONTX2_PTP, pdev);
+	if (!pdev)
+		return 0;
+
+	if (octeon_csr_read(PEMX_CFG) & 0x1ULL) {
+		pr_err("PEM0 is configured as RC\n");
+		return 0;
+	}
+
+	if (is_otx2_support_ptm(pdev)) {
+		oct_ptp_clock.cn10k_variant = 0;
+	} else if (is_cn10k_support_ptm(pdev)) {
+		oct_ptp_clock.cn10k_variant = 1;
+	} else {
+		/* PTM_EP: unsupported processor */
+		return 0;
+	}
+
+	ptm_ctl_addr = ioremap(PEMX_PTM_CTL, 8);
+	if (!ptm_ctl_addr) {
+		pr_err("PTM_EP: Failed to ioremap CSR space\n");
+		return 0;
+	}
+
+	ptm_lcl_addr = ioremap(PEMX_PTM_LCL_TIME, 8);
+	if (!ptm_lcl_addr) {
+		pr_err("PTM_EP: Failed to ioremap CSR space\n");
+		return 0;
+	}
+
+	oct_ptp_clock.caps = ptp_oct_caps;
+
+	oct_ptp_clock.ptp_clock = ptp_clock_register(&oct_ptp_clock.caps, NULL);
+
+	pr_info("PTP device index for PTM clock:%d\n", oct_ptp_clock.ptp_clock->index);
+	pr_info("cn10k_variant %d\n", oct_ptp_clock.cn10k_variant);
+
+	return PTR_ERR_OR_ZERO(oct_ptp_clock.ptp_clock);
+}
+
+module_init(ptp_oct_ptm_init);
+module_exit(ptp_oct_ptm_exit);
+
+MODULE_AUTHOR("Marvell Inc.");
+MODULE_DESCRIPTION("PTP PHC clock using PTM");
+MODULE_LICENSE("GPL");
-- 
2.25.1


