Return-Path: <linux-kernel+bounces-37079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D083AB34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CCE293D65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2027277F35;
	Wed, 24 Jan 2024 13:55:06 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD877F16;
	Wed, 24 Jan 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104505; cv=none; b=NeR449l+qFzXSH1mf8XXSHYvkUPx3GWhun1aAsK2qRi+Po6n9gJl6YlhXkP/FNNcO155f56k02V8MTUFgmB04AS9YAKslFu0qTb/xa07sYT4H3w/On6d8D/j/6synkRElya/iN+osumQn40TzYtfY9kx8i66lg+xBIU5h++GnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104505; c=relaxed/simple;
	bh=8haVjCiq+vlCoXGm5UH6s23J8C9hHt3qKegbnlAICkc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2djWK9+Y548zv63XfA4KVJhNd+plpeNWnfnDlXteQKbEz9y59swd2/10mwV1j/RnVptDSITNmSSfowuofvyE2q7alMnsXC0ZyndnVvzgjEpl92R3kJLe6mu6cAGw99781hcmHDH5Wq2xfhNgUkWVdJ14nnu8LksT7eCQO7wMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id E658E7F712; Wed, 24 Jan 2024 15:54:58 +0200 (EET)
Date: Wed, 24 Jan 2024 15:54:58 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] ahci: add 43-bit DMA address quirk for ASMedia ASM106x
 controllers
Message-ID: <ZbEWsp4KT-V9YUaC@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With one of the on-board ASM1061 AHCI controllers (1b21:0612) on an
ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, a controller hang was
observed that was immediately preceded by the following kernel messages:

[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]

The first message is produced by code in drivers/iommu/dma-iommu.c which
is accompanied by the following comment that seems to apply:

        /*
         * Try to use all the 32-bit PCI addresses first. The original SAC vs.
         * DAC reasoning loses relevance with PCIe, but enough hardware and
         * firmware bugs are still lurking out there that it's safest not to
         * venture into the 64-bit space until necessary.
         *
         * If your device goes wrong after seeing the notice then likely either
         * its driver is not setting DMA masks accurately, the hardware has
         * some inherent bug in handling >32-bit addresses, or not all the
         * expected address bits are wired up between the device and the IOMMU.
         */

Asking the ASM1061 on a discrete PCIe card to DMA from I/O virtual
address 0xffffffff00000000 produces the following I/O page faults:

[Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
[Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000500 flags=0x0010]

Note that the upper 21 bits of the logged DMA address are zero.  (When
asking a different PCIe device in the same PCIe slot to DMA to the same
I/O virtual address, we do see all the upper 32 bits of the DMA address
as 1, so this is not an issue with the chipset or IOMMU configuration on
the test system.)

Finally, hacking libahci to always set the upper 21 bits of all DMA
addresses to 1 produces no discernible effect on the behavior of the
ASM1061, and mkfs/mount/scrub/etc work as without this hack.

This all strongly suggests that the ASM1061 has a 43 bit DMA address
limit, and this commit therefore adds a quirk to deal with this limit.
We apply the quirk to the other known ASMedia parts as well, since they
are similar and likely to be affected by the same issue.

Link: https://lore.kernel.org/linux-ide/ZaZ2PIpEId-rl6jv@wantstofly.org/
Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
---
 drivers/ata/ahci.c | 38 +++++++++++++++++++++++++++-----------
 drivers/ata/ahci.h |  1 +
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 08745e7db820..dc86c73019ce 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -58,6 +58,7 @@ enum board_ids {
 
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
+	board_ahci_asm106x,
 	board_ahci_avn,
 	board_ahci_mcp65,
 	board_ahci_mcp77,
@@ -185,6 +186,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_asm106x] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_avn] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
@@ -596,14 +604,14 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3f20), board_ahci },	/* PDC42819 */
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
-	/* Asmedia */
-	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
+	/* ASMedia, 43 bit DMA address limit */
+	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_asm106x },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_asm106x },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_asm106x },	/* ASM1061 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_asm106x },	/* ASM1061/1062 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_asm106x },   /* ASM1061R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_asm106x },   /* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_asm106x },   /* ASM1062+JMB575 */
 
 	/*
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
@@ -943,11 +951,19 @@ static int ahci_pci_device_resume(struct device *dev)
 
 #endif /* CONFIG_PM */
 
-static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
+static int ahci_configure_dma_masks(struct pci_dev *pdev,
+				    struct ahci_host_priv *hpriv)
 {
-	const int dma_bits = using_dac ? 64 : 32;
+	int dma_bits;
 	int rc;
 
+	if (!(hpriv->cap & HOST_CAP_64))
+		dma_bits = 32;
+	else if (hpriv->flags & AHCI_HFLAG_43BIT_ONLY)
+		dma_bits = 43;
+	else
+		dma_bits = 64;
+
 	/*
 	 * If the device fixup already set the dma_mask to some non-standard
 	 * value, don't extend it here. This happens on STA2X11, for example.
@@ -1920,7 +1936,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ahci_gtf_filter_workaround(host);
 
 	/* initialize adapter */
-	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
+	rc = ahci_configure_dma_masks(pdev, hpriv);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 4bae95b06ae3..df8f8a1a3a34 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -247,6 +247,7 @@ enum {
 	AHCI_HFLAG_SUSPEND_PHYS		= BIT(26), /* handle PHYs during
 						      suspend/resume */
 	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
+	AHCI_HFLAG_43BIT_ONLY		= BIT(29), /* 43bit DMA addr limit */
 
 	/* ap->flags bits */
 
-- 
2.43.0

