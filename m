Return-Path: <linux-kernel+bounces-115186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470D888E08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECABB33C74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461241C9ED8;
	Mon, 25 Mar 2024 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvLte50v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6718412C;
	Sun, 24 Mar 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324264; cv=none; b=kELIPhS+ZfTtq0Sfy1vh8RF9go7gFfc30N2S7QimxO0Fkqkzs+b26tpS67/q/7mS7xVYKaH86lpdEVJhvcWZ0XcZlhndTvaMsV2BNjrBkGgAqMLV+wEEZYSoIrI4PF02SD72dnJhBYu9PLyWCebYmZ821q7G3KuMgujvUvKomvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324264; c=relaxed/simple;
	bh=j05TyZE3A4IyBcXu/JkFUxDlnIVdQ1ayF1VviiH1ODE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxTTEMjhH08sVVg57Z8x9KmBjyHIvPsk7Ql8RxbdLgzFt/YT4DjSo3NtY2yOf9uRhx5tYZoxKoAJXEtuTlesivdzqJz3+z0XHf+eshkGaWsX7559EtyVcp4apY3l/KqUDisv/clEhuGOlLH0eHXZwXt5tKE30+dqhd9ge3RBFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvLte50v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7418C43390;
	Sun, 24 Mar 2024 23:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324263;
	bh=j05TyZE3A4IyBcXu/JkFUxDlnIVdQ1ayF1VviiH1ODE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvLte50vfljFWHZ/LfEC/WmZKaW63ehBq8hh/mXOd2I9iUoEz03vEFKr+KK6l4A/y
	 fNj9MBZdZpQkCisZbxfU0iTLz16k9fzr22uk9OKSepqNyYV+H9FthSOGSIwiQIQ3fj
	 wm5oPA3oUZhe8Y81E256sMNA88fxpO7MyitEB55VtZWtqZd+Shucpv0VA/ZUrp+G6n
	 //Hl29okoRnOkYPHGz4Iy6UY5HR6F4rmnGV3DXKxMZxUs/V+/i6HVNT71jahRYMxak
	 Tm8/wkOX8G5vMHc46zv9H81OsqlL/HtYEaeQU9WHjApzADhkGOcQmVDQyuQ0IVn2iB
	 EAXgkvReU0Bqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/148] iommu/amd: Mark interrupt as managed
Date: Sun, 24 Mar 2024 19:48:27 -0400
Message-ID: <20240324235012.1356413-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 0feda94c868d396fac3b3cb14089d2d989a07c72 ]

On many systems that have an AMD IOMMU the following sequence of
warnings is observed during bootup.

```
pci 0000:00:00.2  can't derive routing for PCI INT A
pci 0000:00:00.2: PCI INT A: not connected
```

This series of events happens because of the IOMMU initialization
sequence order and the lack of _PRT entries for the IOMMU.

During initialization the IOMMU driver first enables the PCI device
using pci_enable_device().  This will call acpi_pci_irq_enable()
which will check if the interrupt is declared in a PCI routing table
(_PRT) entry. According to the PCI spec [1] these routing entries
are only required under PCI root bridges:
	The _PRT object is required under all PCI root bridges

The IOMMU is directly connected to the root complex, so there is no
parent bridge to look for a _PRT entry. The first warning is emitted
since no entry could be found in the hierarchy. The second warning is
then emitted because the interrupt hasn't yet been configured to any
value.  The pin was configured in pci_read_irq() but the byte in
PCI_INTERRUPT_LINE return 0xff which means "Unknown".

After that sequence of events pci_enable_msi() is called and this
will allocate an interrupt.

That is both of these warnings are totally harmless because the IOMMU
uses MSI for interrupts.  To avoid even trying to probe for a _PRT
entry mark the IOMMU as IRQ managed. This avoids both warnings.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html?highlight=_prt#prt-pci-routing-table [1]
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Fixes: cffe0a2b5a34 ("x86, irq: Keep balance of IOAPIC pin reference count")
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20240122233400.1802-1-mario.limonciello@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 12e7254b39489..efb11ca91dd72 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1733,6 +1733,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
+	/* ACPI _PRT won't have an IRQ for IOMMU */
+	iommu->dev->irq_managed = 1;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_RANGE_OFFSET,
-- 
2.43.0


