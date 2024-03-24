Return-Path: <linux-kernel+bounces-114240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6F888958
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2591C27CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65315A4B5;
	Sun, 24 Mar 2024 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEo92aax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47071138494;
	Sun, 24 Mar 2024 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321590; cv=none; b=h1RQdpHpQDgnd30yKG4sGg2JTB08eTW6YbQkg/FW4AOwMETfQnEfP1GCYmDl8lYFc8RB59PFVWDBcCV+Mfu0PnIKDC/HtI3YI/P62pfq6ri/i7K3hQkvymJvHdtxxgtao4/gPmNbMgp2HGx6t4NjW9KUAUOTl+mmjwqeL/6YK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321590; c=relaxed/simple;
	bh=5IHzwXFEDLmKBoZe6jt3RYoOyPNjtFhnX/jOGOlGnzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnJWAHmt/kjFactpOxFsu6ElGMEaBOhfaT/pe0Ewh0lZ6d5u0nNId3o+TRl028sKDJFFzjpeCcwW/KYbvcphfI9ZLEt4a6tU7E2h2pSAnc6fxMnPwOmtb++P10T/gE5xriRU6wj56ngrtc2cpcjVUeOwkFCULm7Z+pvCXrnKEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEo92aax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBEDC433C7;
	Sun, 24 Mar 2024 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321589;
	bh=5IHzwXFEDLmKBoZe6jt3RYoOyPNjtFhnX/jOGOlGnzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEo92aaxd0UdlXAV00WMoM8g2lK24nwKFyV5Vi7CJCBavA9vOIinVT96zxDeU9gSH
	 WIawAX/tivb/8TJKdXUafBFrMBa2dwGak/WnqF9UH7At3c6ODMWllvv8cSg8nzm4xj
	 QkpSEHaLt/n+qWkVKQ0GLLVxYN9MdzrttGshmmEP/7Z8zyQnN88UwxI1s/YCtJg+Kr
	 JPw1D7ehfutUp0H13W3TA1nnma0k6M8JnVBfN9Uzf2lPX8bpnuZaYlE1EYfk97UXKb
	 1kzPUdcPoGQVizX3XO93wFJMWM+ZjPG274GJSXS4POn0cy71FOL/923v8f8dMFnvpd
	 kY6+m8tfdybZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 319/638] iommu: Fix compilation without CONFIG_IOMMU_INTEL
Date: Sun, 24 Mar 2024 18:55:56 -0400
Message-ID: <20240324230116.1348576-320-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 2b12b583ef4b1..d57c5adf932e3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -191,7 +191,7 @@ source "drivers/iommu/iommufd/Kconfig"
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


