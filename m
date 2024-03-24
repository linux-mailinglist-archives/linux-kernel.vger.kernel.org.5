Return-Path: <linux-kernel+bounces-114513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25661888ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32BF28B167
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90045181BBF;
	Sun, 24 Mar 2024 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmiArw3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7A15AD94;
	Sun, 24 Mar 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322135; cv=none; b=HpOwU/I5nbVST3yon6E2QXcCSZR2fkbyjNgRUp3uhFfuGpJzbTJZr0mu4kAhuqym19WxvdC/1nlpAmRIqAzvheglNaF6zGp7YLNwA9jCdRpqkAd0S1YmaM1MwGkCB32dmM0fXg7tCDbHxB6tcvLwFlqKAQ+C2kI4A3QiQXMOKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322135; c=relaxed/simple;
	bh=nCs+Qu0fNcdDB4NtVje1fOGf+FDvMywzyoNoEfxqsSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr4zfiCZr3wLLQzF9rHOZXHtDTPMSbpP1N/K+QZGqI1V6g0Dh5grPTNi8Dz6R/tYhbNZnpum1aADw3YlwC2Byj4d8LoLzPZj2rR4jgYUiRUncV8WVGfmXsZ6BkjJmSithNWnaEQ0bR/WA/uc+Ey9XFPOmxROQHPsaaOe9paWiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmiArw3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A5C43394;
	Sun, 24 Mar 2024 23:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322135;
	bh=nCs+Qu0fNcdDB4NtVje1fOGf+FDvMywzyoNoEfxqsSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmiArw3VDi94k2vRUqyD+X1rCPEcnZaZFdNvHcG1Kw4R9jDgqEtDe0P9ItMX1JOQc
	 3INPTBkiSkIx240t7d1inX6x1NHKXsETBHxm9fZiQEUI+nV6aw3n3pnU1/k2mn0MOq
	 Uk7pAfJmBMupyzrSnW7nWMa8I6zJC6LYLUEZVbMTv7VNa5mGtZCq0w8OcP2xJ49T3C
	 gxeze46iuvkiK9+iuHCwfMNKvezSc34Li8vqEIUTve6384tFv40ikAnc5evnR4T0ME
	 R7zmOoClM1bukr92aCWCADBwwQBCeny685ptEJejg7yK9Vd3ZMcivxpVM+mYW0mrh6
	 hK+kzLOt24jhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 212/451] iommu: Fix compilation without CONFIG_IOMMU_INTEL
Date: Sun, 24 Mar 2024 19:08:08 -0400
Message-ID: <20240324231207.1351418-213-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index dc5f7a156ff5e..dc19e7fb07cfe 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -192,7 +192,7 @@ source "drivers/iommu/intel/Kconfig"
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
-	select DMAR_TABLE
+	select DMAR_TABLE if INTEL_IOMMU
 	help
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 7af3b8a4f2a00..29d26a4371327 100644
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


