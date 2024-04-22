Return-Path: <linux-kernel+bounces-153963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C558AD55E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA96B2247D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFE1553A0;
	Mon, 22 Apr 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KDrk3IC/"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A615539E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815958; cv=none; b=Y8Mz33VF2To1hfMuNqjaWJraajGe3uLlQs4hwjujsW3tc5mPIKb2OiK0/Lx8ddFTB8usjMBl3gpMRRHnUApTqBSKbVZl15Z51DWZBx59RP/PjN2lhYXh2YCVZmfTVEV8q9qUzHmckSVvzMgoDLWyZF1sZcAlk1YrLaWlaur6BRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815958; c=relaxed/simple;
	bh=LwPdmR8T/aH1kw3i4JjBM2eMK60qsGACKxgdXHID3TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ravq6x2iAUnoYy8l7fZDHC0n3hH5rqEuk28HfU6x2MS8B40KMJg9VaYmDUfhBA7SItcaa96E53AEPOxi6VrnJRKz4ZEC330dbT2LshcimdPtM390pHW7ilA8nm46w2noLXCrKKIPIUUe6/mBn5CORrDYRlOul+xb9ZUfgx+shyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KDrk3IC/; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxrzEwSyavPBOJlQAif9+5rStSFz6W1Ij1Eu/oUzLnc=;
	b=KDrk3IC/L4fgCZN/+vzk/pxjOzeiz0gYdiIHpjWJENRhHn8pIipO19ki11qyDlB8u34hio
	NF7rl9Pu5kg1b+4vqLwV1dxPUHh4nm0dOv1LQMmzw1Fvo3f9dJk/uAsKji5Ie0B+dwB47o
	NQ2SaLoRQrxUHYYLeQVokHsiz3pXmXI=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: [PATCH 2/7] PCI: xilinx-nwl: Fix off-by-one
Date: Mon, 22 Apr 2024 15:58:59 -0400
Message-Id: <20240422195904.3591683-3-sean.anderson@linux.dev>
In-Reply-To: <20240422195904.3591683-1-sean.anderson@linux.dev>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

IRQs start at 0, so we don't need to subtract 1.

Fixes: 9a181e1093af ("PCI: xilinx-nwl: Modify IRQ chip for legacy interrupts")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pci/controller/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 0408f4d612b5..437927e3bcca 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -371,7 +371,7 @@ static void nwl_mask_intx_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val & (~mask)), MSGF_LEG_MASK);
@@ -385,7 +385,7 @@ static void nwl_unmask_intx_irq(struct irq_data *data)
 	u32 mask;
 	u32 val;
 
-	mask = 1 << (data->hwirq - 1);
+	mask = 1 << data->hwirq;
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
 	nwl_bridge_writel(pcie, (val | mask), MSGF_LEG_MASK);
-- 
2.35.1.1320.gc452695387.dirty


