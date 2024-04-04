Return-Path: <linux-kernel+bounces-131586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A88989C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A81C291A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8777112A145;
	Thu,  4 Apr 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2OjDFbV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E2126F11
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240290; cv=none; b=WXjUQ2aRXfhXTToXjAJVeqPrx2N3ZrgcSIp7vmmwQx9+aD3liyEq/xMOE/lQWo9vPgcBw2OMdKrOfDzqvNUx4ygJYM+V7u0lrgDttgNc4zUKLCZ2dBJwnucpzH5FHBff8bK2F4uAP2QU7UjvMS7lIeDxWpSZjTQiAidZc6Uh++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240290; c=relaxed/simple;
	bh=0S+oR25+79lKZWWwbRegFOj5KyLL3zn68gthwqbdnlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/SMlQUzAQ1RGS2XNIy4LBPspjvaWVTdupASe43IjpL18o/oLCXagvWMyUGCbxSfr3SJcjWwQtDNqLIkKchXGiymK7Woq4/tW/duklQNXM1ADcUGTDzGJs9wGucWosTwsky3luOtqfTfh5Q1zPnz2196NrVNu8I1bSyftd6iAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2OjDFbV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712240290; x=1743776290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0S+oR25+79lKZWWwbRegFOj5KyLL3zn68gthwqbdnlM=;
  b=D2OjDFbVJkobgxkKxdS1FvaYn79S8LEWAxqOMkB65K0eyhOO2WIi4gVV
   ebBCdX2L2iv6H6PZVYYN/EScawKnSigbjoZ1r+pvOVyK9WMMTYAE/VNnS
   +RsizyuGuJtHnFclTOGWY2xTXVFZ4K/ZRu5z7m0gak+lmb53GB0v68rzv
   4Sos4qD/s4xSwCZwoFe/Dvos9neeU/QQEeM+e/CpKimoibt5D5DkLPeTd
   jB/zKs1/Jcc9bEKyE5wGpk0yMYZyP8c3XdFsoSNz8emxXMGHhW6XAhE41
   jQfk4EeGiv4ek/gGC6uCOpVqf96jg3VFDRkmM4HFAx5PqyH8JPT5qBMyd
   A==;
X-CSE-ConnectionGUID: VEk0kaPNTH6V7v5/zmK+Ow==
X-CSE-MsgGUID: 29/0a+bdT0OV4wPog0rQMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7632419"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7632419"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:18:08 -0700
X-CSE-ConnectionGUID: 4F/1dvAKRgabWLPY9bt5uw==
X-CSE-MsgGUID: 6m3By+qiQnelYpdNV9x9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23448349"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa004.fm.intel.com with ESMTP; 04 Apr 2024 07:18:07 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf/x86/intel/uncore: Factor out common MMIO init and ops functions
Date: Thu,  4 Apr 2024 07:17:03 -0700
Message-Id: <20240404141706.1235531-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240404141706.1235531-1-kan.liang@linux.intel.com>
References: <20240404141706.1235531-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Some uncore PMON registers are located in the MMIO space. For the client
machine, the MMIO space is usually located at D0:F0 but in a different
BAR. For example, some uncore PMON registers are located in the SAF BAR,
not the MCHBAR in the Lunar Lake.

The current __uncore_imc_init_box() hard code the BAR information.
Factor out the uncore_get_box_mmio_addr() which uses the BAR information
as a parameter.
The only change is the error output message. The hardcode name 'MCHBAR'
is replaced by the offset of a BAR.

Add a new macro, MMIO_UNCORE_COMMON_OPS(), since the MMIO ops functions
are usually the same among different generations.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 47 +++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 9462fd9f3b7a..05fe6e90bd8e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1481,33 +1481,35 @@ static struct pci_dev *tgl_uncore_get_mc_dev(void)
 #define TGL_UNCORE_MMIO_IMC_MEM_OFFSET		0x10000
 #define TGL_UNCORE_PCI_IMC_MAP_SIZE		0xe000
 
-static void __uncore_imc_init_box(struct intel_uncore_box *box,
-				  unsigned int base_offset)
+static void
+uncore_get_box_mmio_addr(struct intel_uncore_box *box,
+			 unsigned int base_offset,
+			 int bar_offset, int step)
 {
 	struct pci_dev *pdev = tgl_uncore_get_mc_dev();
 	struct intel_uncore_pmu *pmu = box->pmu;
 	struct intel_uncore_type *type = pmu->type;
 	resource_size_t addr;
-	u32 mch_bar;
+	u32 bar;
 
 	if (!pdev) {
 		pr_warn("perf uncore: Cannot find matched IMC device.\n");
 		return;
 	}
 
-	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET, &mch_bar);
-	/* MCHBAR is disabled */
-	if (!(mch_bar & BIT(0))) {
-		pr_warn("perf uncore: MCHBAR is disabled. Failed to map IMC free-running counters.\n");
+	pci_read_config_dword(pdev, bar_offset, &bar);
+	if (!(bar & BIT(0))) {
+		pr_warn("perf uncore: BAR 0x%x is disabled. Failed to map %s counters.\n",
+			bar_offset, type->name);
 		pci_dev_put(pdev);
 		return;
 	}
-	mch_bar &= ~BIT(0);
-	addr = (resource_size_t)(mch_bar + TGL_UNCORE_MMIO_IMC_MEM_OFFSET * pmu->pmu_idx);
+	bar &= ~BIT(0);
+	addr = (resource_size_t)(bar + step * pmu->pmu_idx);
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	pci_read_config_dword(pdev, SNB_UNCORE_PCI_IMC_BAR_OFFSET + 4, &mch_bar);
-	addr |= ((resource_size_t)mch_bar << 32);
+	pci_read_config_dword(pdev, bar_offset + 4, &bar);
+	addr |= ((resource_size_t)bar << 32);
 #endif
 
 	addr += base_offset;
@@ -1518,6 +1520,14 @@ static void __uncore_imc_init_box(struct intel_uncore_box *box,
 	pci_dev_put(pdev);
 }
 
+static void __uncore_imc_init_box(struct intel_uncore_box *box,
+				  unsigned int base_offset)
+{
+	uncore_get_box_mmio_addr(box, base_offset,
+				 SNB_UNCORE_PCI_IMC_BAR_OFFSET,
+				 TGL_UNCORE_MMIO_IMC_MEM_OFFSET);
+}
+
 static void tgl_uncore_imc_freerunning_init_box(struct intel_uncore_box *box)
 {
 	__uncore_imc_init_box(box, 0);
@@ -1612,14 +1622,17 @@ static void adl_uncore_mmio_enable_box(struct intel_uncore_box *box)
 	writel(0, box->io_addr + uncore_mmio_box_ctl(box));
 }
 
+#define MMIO_UNCORE_COMMON_OPS()				\
+	.exit_box	= uncore_mmio_exit_box,		\
+	.disable_box	= adl_uncore_mmio_disable_box,	\
+	.enable_box	= adl_uncore_mmio_enable_box,	\
+	.disable_event	= intel_generic_uncore_mmio_disable_event,	\
+	.enable_event	= intel_generic_uncore_mmio_enable_event,	\
+	.read_counter	= uncore_mmio_read_counter,
+
 static struct intel_uncore_ops adl_uncore_mmio_ops = {
 	.init_box	= adl_uncore_imc_init_box,
-	.exit_box	= uncore_mmio_exit_box,
-	.disable_box	= adl_uncore_mmio_disable_box,
-	.enable_box	= adl_uncore_mmio_enable_box,
-	.disable_event	= intel_generic_uncore_mmio_disable_event,
-	.enable_event	= intel_generic_uncore_mmio_enable_event,
-	.read_counter	= uncore_mmio_read_counter,
+	MMIO_UNCORE_COMMON_OPS()
 };
 
 #define ADL_UNC_CTL_CHMASK_MASK			0x00000f00
-- 
2.35.1


