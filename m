Return-Path: <linux-kernel+bounces-116485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EBB889FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E8D2A3CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F2219D1A1;
	Mon, 25 Mar 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKuC+jlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C707352F;
	Mon, 25 Mar 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350642; cv=none; b=J5AlZjYERpwxyrQegOptFDrWMRZjQ0k53/oMAwCCCTNKs36muG4WktrwbNa9gU3ijKuXdDcZE4V4483C5JzhjLhMlcbJra3Ra87TMoUqqYR2D1N/OthsVHwBzmV4LW5BDzgsfxHHdBjWKb7MFLLfWgmhnXvhnEJM75jyz8yX0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350642; c=relaxed/simple;
	bh=OmWC4u7/olcC3uHIhbPfvkwAK9DJXzZPo8ow7g20qSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj0+qER0maiJL5CEen6BKLbxiGyCf7ijQTSkTV8hEdSqSDUdlmNSC72yoQSxGWv68akEb94C4qiW51adAQN8f94OZGVUPpwYjZ5+slENvN1eRVG5uhQB8NGRoxVQdSlfbk/2vrv0MNAk5g3KlegSpqJ8d8VRHmsRp6UwmrPU73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKuC+jlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B558C43390;
	Mon, 25 Mar 2024 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711350642;
	bh=OmWC4u7/olcC3uHIhbPfvkwAK9DJXzZPo8ow7g20qSs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MKuC+jlA+mRfHMfmSKKv78QSW+WSz9J7DOIRN/RSAMSOhpWl+7zovZPRm8D1DFfRm
	 XLo1+8eBt88H6kz7NK0kW8rOru79NjtwH13Q1sjIpmPZY7b/Xw7qPWcpwi1FdDjLk+
	 MHUjx+jflFd/Hz4PxGMWU/BK9PlUmAsDJRS4WmbSfYlAQIMwkvJp3iHiLXGcYumX+7
	 ZXv8Tk87JZxkQeiE8HKqYpdXKN2/7n0Nh3aMRviPoGAI+siUgm8GQh4OTZEIvtDeav
	 lKW8lr5oU/OoN1gBl4jY1H/jdkPzAr6IekdUA79mnxYFxfvL5D9suh4Zz2FAr1cEt8
	 rzeYBfdQPD3wg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/28] net: xgbe: Use PCI_IRQ_INTX
Date: Mon, 25 Mar 2024 16:09:25 +0900
Message-ID: <20240325070944.3600338-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325070944.3600338-1-dlemoal@kernel.org>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
macro.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..c5e5fac49779 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -170,7 +170,7 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 		goto out;
 
 	ret = pci_alloc_irq_vectors(pdata->pcidev, 1, 1,
-				    PCI_IRQ_LEGACY | PCI_IRQ_MSI);
+				    PCI_IRQ_INTX | PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_info(pdata->dev, "single IRQ enablement failed\n");
 		return ret;
-- 
2.44.0


