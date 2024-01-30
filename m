Return-Path: <linux-kernel+bounces-44536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2D842364
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45349B286BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45703679E4;
	Tue, 30 Jan 2024 11:41:14 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090B67E85;
	Tue, 30 Jan 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614873; cv=none; b=VMj49Dkr/aFlMZ+bZSvSqSkpALAzehVffiAwgiVtDM+HUCn5XBJXN+jgcyUZ/In7LOOgMehzSLShPH01SRPSSx485De6z+SZ1M6ZCEEMY4qtox9VDg7bRU06DeM3r73BbqgcNflVDGMOSkGBoNioULVsLuD/LCfLut6ZZuwC/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614873; c=relaxed/simple;
	bh=M1ByWR7A/0OZJyiu8/QxYUCOsnZ1i0g7QJiaIPAWjt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aNeMPPKWufH6mgcIigx0xB3PxXHneUsnDfXy3QQORdueCobuXmuXmp+Kg9KQ9637OZlE1l14eSTYS7GttYiEQdSjsYdftUXvVV7XuzTW2NoSLm+Lyv6xv6YNr+Gqm9zhTXitfOwJcYJM2pwxcp+W0wgGqwnQDyc9mL4kSX127jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id DF1C47F711; Tue, 30 Jan 2024 13:41:02 +0200 (EET)
Date: Tue, 30 Jan 2024 13:41:02 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
Message-ID: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ASMedia have confirmed that all ASM106x parts currently listed in
ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
into on the ASM1061, and therefore, we need to apply the quirk added by
commit 20730e9b2778 to the other supported ASM106x parts as well.

Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
---
 drivers/ata/ahci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d2460fa985b7..da2e74fce2d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
 
 	/* ASMedia */
-	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
-	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
-	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
+	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
+	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
 	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
 	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
 	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */
-- 
2.43.0

