Return-Path: <linux-kernel+bounces-116029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6E889516
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6A8295996
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D81C26CC13;
	Mon, 25 Mar 2024 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovz/dwuq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7C175CAB;
	Sun, 24 Mar 2024 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323405; cv=none; b=LZ7u2mY4qCTMfcAwTBC+k8YiS6Yzc/cH94efN36eqF29ccCB14Rhw0v/MK+jdamTRBRLlqZmwiVPDXaRpotP8NLrBp7iSvZ07LZT6pRV+fZ/1stOiFQ4tqCSEv4tbuSU9sCDXO64XwpiCySTTIV72VXL8aZRhRyP92SkDXQpZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323405; c=relaxed/simple;
	bh=Xupc0U8JbIbytEqMbadnHXez4ca++rZbhWvNQ4V3vR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib9W2Ld/8tvGTPPH5B26z0bhfex9eFkPzSE8qcn5VGNypWRI2okQSefK+c5p29OFK9ouXT9crfBXratmaHHRi+VSoVLEyV7VoHlQGLx67q1+x+Iknv6b9o8lb0FdPe0dvlQD+WXMLUglcGpqo49clce53QpJYMTjS/plwUKMSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovz/dwuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBBBC43390;
	Sun, 24 Mar 2024 23:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323405;
	bh=Xupc0U8JbIbytEqMbadnHXez4ca++rZbhWvNQ4V3vR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovz/dwuqB/x7yLsgfXE/CoEJFKlvygYf8S3XteSn1tNxloMHqSDojtKTcJnHmayTf
	 WxmjnVm5n3t3ss+sX05AxdRLiIEAyjyq7ZI4jU9V93CobELZfQWyN3f/n1o95MdyAd
	 Ihv50IIt7lNI+L1eI5pAQVTb5SRLeMG2zjeyqozPHm0V+wvbgX2tNZ0g/lHXXU3RER
	 AtELELJeCA36RP7lqtEMq5MZAW7IjcWdwknNU0ZEFtMZRRa0AUVaAT1NxGajLeE571
	 tSH7mHqafaO58p4/q5Qovg7SjmFflED52WKon+JQp2XIP75pfqCuF5VwvGWYEAnH0Y
	 xXAWbe4iyXIUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 106/317] iommu/amd: Mark interrupt as managed
Date: Sun, 24 Mar 2024 19:31:26 -0400
Message-ID: <20240324233458.1352854-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 50ea582be5910..ef855495c210e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1821,6 +1821,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	/* Prevent binding other PCI device drivers to IOMMU devices */
 	iommu->dev->match_driver = false;
 
+	/* ACPI _PRT won't have an IRQ for IOMMU */
+	iommu->dev->irq_managed = 1;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 
-- 
2.43.0


