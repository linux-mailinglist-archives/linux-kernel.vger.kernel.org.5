Return-Path: <linux-kernel+bounces-113788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B001C888698
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A82628F5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630614D2BD;
	Sun, 24 Mar 2024 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLtgq2Ru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC8128368;
	Sun, 24 Mar 2024 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320801; cv=none; b=XP1gja21RC+DRpI8Ukr01fFtUC2idWqpPCx9RsVFJQqaq02li4XXXAQ4kMsj9fw30lEaT351vxmyBoVg3d8YvNUy2X6WSnC0CoehhM2P2snP3GZxHb9D/0lYojSudXp3F2+ojN3JkYIig4cZmcqjS7MSeMx8kApt9qQDKNedpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320801; c=relaxed/simple;
	bh=WTXrESP4wD3TzDbEwiBdO61iJBAqJ9D7jDgdCi3pw6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtXecMf2LThkaGB7C4AcbvkukL3DKuoTWlYT78RONwds4AyUVnRZGWY6SNVTkbVG6hMD7OMmUVtHw2xbSsfdJEeNRUxXImS6iAPn0KJ8+cVkvEsUhKwwkAqErDq1QFpX+hRDJFosb47hovJIOWlYhiDZtDXzMalLb6v2MnKuOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLtgq2Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF23C433F1;
	Sun, 24 Mar 2024 22:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320800;
	bh=WTXrESP4wD3TzDbEwiBdO61iJBAqJ9D7jDgdCi3pw6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLtgq2RusHx1OlQg82lI4VMimP1AcUlDDqNPf+D5jvG5MCV/j8Mb9LzRdgTGtvoJ2
	 gjYfBFuGx0iHmtnwVujgmV+UY18hhjW58b9V9pDOoOZK9Ox2X4x+o4kiV/EC5deKsP
	 NqvU/RVnaphjOe7SUUjV1ECeMaNnNfbSQfbLtlikYH2QcJ58yh4etrSrYLgAuiVbbY
	 Hbi1mAViGZOu7U8Gg/Nsg/YBPgOIXHo87lhza86VleWIxAUJmJ3ZTxvnAALFBkbR+G
	 AXLXfltpgT1ujQj0GzO9bLMS45QaTEzvnrdHfSQLp2EJceqkJw+wkisZwTxqvKDwuM
	 j6r0Otc2+QI+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 365/713] iommu: Fix compilation without CONFIG_IOMMU_INTEL
Date: Sun, 24 Mar 2024 18:41:31 -0400
Message-ID: <20240324224720.1345309-366-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bert Karwatzki <spasswolf@web.de>

[ Upstream commit 70bad345e622c23bb530016925c936ab04a646ac ]

When the kernel is comiled with CONFIG_IRQ_REMAP=y but without
CONFIG_IOMMU_INTEL compilation fails since commit def054b01a8678 with an
undefined reference to device_rbtree_find(). This patch makes sure that
intel specific code is only compiled with CONFIG_IOMMU_INTEL=y.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
Fixes: 80a9b50c0b9e ("iommu/vt-d: Improve ITE fault handling if target  device isn't present")
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20240307194419.15801-1-spasswolf@web.de
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/Kconfig         | 2 +-
 drivers/iommu/intel/Makefile  | 2 ++
 drivers/iommu/irq_remapping.c | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 7673bb82945b6..a66f7df7a2b0b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -195,7 +195,7 @@ source "drivers/iommu/iommufd/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
-	select DMAR_TABLE
+	select DMAR_TABLE if INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 5dabf081a7793..5402b699a1229 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -5,5 +5,7 @@ obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
+ifdef CONFIG_INTEL_IOMMU
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
+endif
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83314b9d8f38b..ee59647c20501 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -99,7 +99,8 @@ int __init irq_remapping_prepare(void)
 	if (disable_irq_remap)
 		return -ENOSYS;
 
-	if (intel_irq_remap_ops.prepare() == 0)
+	if (IS_ENABLED(CONFIG_INTEL_IOMMU) &&
+	    intel_irq_remap_ops.prepare() == 0)
 		remap_ops = &intel_irq_remap_ops;
 	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
 		 amd_iommu_irq_ops.prepare() == 0)
-- 
2.43.0


