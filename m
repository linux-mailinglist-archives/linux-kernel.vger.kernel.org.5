Return-Path: <linux-kernel+bounces-114544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6F888AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1290328BC28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC4184103;
	Sun, 24 Mar 2024 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1gQUpZ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE122C640;
	Sun, 24 Mar 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322176; cv=none; b=u8D7xds/Kqwur3PYRaP7nSyPNHnxpa5ThA5Lj5Ow/TYErr4QL3zt8FE98uYuLMRjCw7tbw2z5x721cVZgWG4+Kqtod/cPr9i0nGkaqoMKsOpQaTZ8I++AHXhYRk3KIArlXCpYWCsI28+IAZGFUnOC4SYz4dIp4qExmjQ/nTEUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322176; c=relaxed/simple;
	bh=46kJzhy80nj07sywNc6/IBShEzaZS6Mpfoy6P4z2SL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5Yod7I0w3RfwpjvSwFNmDxeORIdGriQ5oqjQ2lsdIr9Y0hXBbF1ibPLpmPLii/LJGob+bQMzWDN0gFS1yT4I+Qdlt9MHfU6KKFnd3hGAx8ZEQjJp/oE/XHGRNN9ZehP+iBJpTxr8JMrUqOZBEP+dpBzTcykFMao6xSBdHjxsxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1gQUpZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB2AC43399;
	Sun, 24 Mar 2024 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322175;
	bh=46kJzhy80nj07sywNc6/IBShEzaZS6Mpfoy6P4z2SL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1gQUpZ4Rsa1ih1JbEi8n6yaRw5vjdBR/WuCllyR5gfxaeMFTTlon7OyQ5ZOlsmyu
	 wfH1bdIehHlcFgCySoi9UErNQzXiTVkn44PG++PVsmkk2DPIyIaABWxQEs8XR2SQF+
	 ziGT0rdVOQCIfMgm2A1U4Wm86Lyz//xTzd+mtvhILb4IpZW5p+C0HLwx+mZQXQARj8
	 NDPirHS9XUeqtuqAeVvynWIAUASPQdh3TsHYT92dzCzXQuhRFq0TNx0T0Yt7GFBkf9
	 JE0g83Z7Ri91F6p5d2YuramofPnpOswFNrkgTeUyz4spCTtblFAphry/qSagSt022R
	 IIzi9ZC/jvVvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 254/451] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 19:08:50 -0400
Message-ID: <20240324231207.1351418-255-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 6568d82512b0a64809acff3d7a747362fa4288c8 ]

The TLP Prefix Log Register consists of multiple DWORDs (PCIe r6.1 sec
7.9.14.13) but the loop in dpc_process_rp_pio_error() keeps reading from
the first DWORD, so we print only the first PIO TLP Prefix (duplicated
several times), and we never print the second, third, etc., Prefixes.

Add the iteration count based offset calculation into the config read.

Fixes: f20c4ea49ec4 ("PCI/DPC: Add eDPC support")
Link: https://lore.kernel.org/r/20240118110815.3867-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[bhelgaas: add user-visible details to commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a5d7c69b764e0..08800282825e1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -231,7 +231,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
-- 
2.43.0


