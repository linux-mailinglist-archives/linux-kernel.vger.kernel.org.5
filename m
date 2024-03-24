Return-Path: <linux-kernel+bounces-113215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A29888260
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3DE28D292
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3913C81E;
	Sun, 24 Mar 2024 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuyHl2oQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098317EB82;
	Sun, 24 Mar 2024 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320016; cv=none; b=Qm3rkXIlvR3vxi/A5xptE5haJosCLHykg5iNGiZatosWxZiQYZKOCssLD1tnk6tUeYz18blEm82nDv1J+dpIp23bMkcn9lk31S2I0dehHwA1ExS9IshOjXdP3BmOcPjyQg0KeO/SRCXkmSWEAAptfcb8iYoiZ3kMPOyYfdP424w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320016; c=relaxed/simple;
	bh=b7ejtDltFIu6hTTp3AUM0Hnm/ru5scpjy7t1uf24Ek4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLAqpkya/KXeTzO5vhRns/4wyQ6c2kA3gv6MKwYJrPFxLbaDA4Fj7uL/+eYFnmzbfnyIphI/RHzb2deAbLirfCfxAZpoUryW6ImlBzZg+kvQfFsqbstEnqahvmxoWI9/pkEbJsk/h+tIXoA4O2gGAXZ9O3G8+D02nE5cpPew6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuyHl2oQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B66DC43399;
	Sun, 24 Mar 2024 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320016;
	bh=b7ejtDltFIu6hTTp3AUM0Hnm/ru5scpjy7t1uf24Ek4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuyHl2oQZ8pqKcRhXCmHAs+zDXEpq9sf5gHn0go/c8TflszLeltD1pwprJ3+EAC04
	 r7lrjJ2R50Mudgs+ReQbKxjquRXkwdofncx8gB1brFAoz0n0MBQYdsQTOyA3xXj/NM
	 S/pmbBuAZmYuRaRblQ+YD56OFh7p4eNyixFjyFMEdMPwB7f5AdiQ51qrJXZsuu+t1Z
	 wTkXLmiRFidvS/lAzvpxp5pQVFeqCQqu+9ubWnNdG0lcRHNL0HXYvKoxa/3zZJyB2k
	 g63NbpmZZMePD0P/P5D7zHsSeLcStdnyfAKjl9/BvlJHX6xA+zz7Tn33erEpFeu4fk
	 yrePC+Pvv3BWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 324/715] iommu: Fix compilation without CONFIG_IOMMU_INTEL
Date: Sun, 24 Mar 2024 18:28:23 -0400
Message-ID: <20240324223455.1342824-325-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 9a29d742617e3..9dbb55e745bd9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -196,7 +196,7 @@ source "drivers/iommu/iommufd/Kconfig"
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


