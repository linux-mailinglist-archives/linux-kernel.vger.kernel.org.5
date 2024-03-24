Return-Path: <linux-kernel+bounces-113098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7047888171
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1151F20FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B45491A;
	Sun, 24 Mar 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7EW2lNu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE00154C03;
	Sun, 24 Mar 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319906; cv=none; b=HyvT1UL2ttHUAvSNPUt+YHXxHID9Z41jtwCf2O4URDnA3s4BT4Gf8viA5GVxuZMg9ECDYgVxrw2tO14IJzOfaAZfpNcCLEcL2+SERBPBc6rnGrSJoxihrrb+BqUJ9f3YS2OWQjvxB0N4OWA/4+e37bqTn03gMQ5puS7zUw3hEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319906; c=relaxed/simple;
	bh=2x/Hes09mX+HIrCaUeu20eEQs98dHEZBfJlCTJyvmVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbrFatRhXIohpBfVDMfc2tIqIAl+WPRmo1KaH3hxW2E6UrSYMlm1qeTW3V5QLCj1LTdI57Nt7ajo6jY7GP9jnL0oa7EPJSAvWERFumkt/aoIyx9LkpIgBq5mIed4FoC+DSGgtdNWuqyIdbjf3Ln5OUnn2b+SyJvMIfYrJtbLbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7EW2lNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525FEC433F1;
	Sun, 24 Mar 2024 22:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319906;
	bh=2x/Hes09mX+HIrCaUeu20eEQs98dHEZBfJlCTJyvmVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7EW2lNusJJKRS2FgZIR53Nk+qMrUClyEI/TIckZFSztLcok6Z72/7615utoYXI/Z
	 E99o8s0VCgvoFL7dsd9GVYpFDQQBA5usyp4lbB2jAymDvNfmlU8jDyBflDihTfaAMZ
	 8Gu7HSzXscJqV87eGebaOa560IWKjK6sSWntlXs2G1zFaUaxI6MU4jS0taXXM2GnpJ
	 qQoUp+M8oTBHwAQnhEsITEXYcuSw/0S+6elUTIxclwVywjRf8xEbKQJojUwrvIYCWF
	 ZJ9u1IalGy6iX3afkBRhML36IiR1qjljJqF7COBGRkTEitOdfHdd11/Tpaihjy+BJ1
	 i/xXYQtFeTC4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 211/715] iommu/amd: Mark interrupt as managed
Date: Sun, 24 Mar 2024 18:26:30 -0400
Message-ID: <20240324223455.1342824-212-sashal@kernel.org>
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
 drivers/iommu/amd/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c83bd0c2a1c92..40979b0f5250f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2068,6 +2068,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
+	/* ACPI _PRT won't have an IRQ for IOMMU */
+	iommu->dev->irq_managed = 1;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 
-- 
2.43.0


