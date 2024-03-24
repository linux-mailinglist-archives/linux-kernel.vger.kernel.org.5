Return-Path: <linux-kernel+bounces-114836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E78891A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5401C2D626
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55B02C40DC;
	Mon, 25 Mar 2024 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLCoUU21"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB6279862;
	Sun, 24 Mar 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323471; cv=none; b=FYjYZcHk0rPSvfh8xx+f2gOYmkUSjhl9SymStdBJ7I5cLCjsJdqzi0FL/665nXyc4GRo9J03Si3d+ALHE6NdRWyrGiPCk0aLIr9whQIS4yjTVD4scNHqsK4Dg31E6OquOBiUvHKMaPhDQa4eurL4Q6JWFj6oIc19QtutNQqN4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323471; c=relaxed/simple;
	bh=BEDj/bZZ8ydWaXAwhh7YWirDihFEP8hae+QSA1Zd6Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTGaIVzuERSUWkne6V2oUwbBBkLXE0qHX8w+gyjm3W+xug6wJs6eKqpv5ho5EGhP/MLNt9pFusC7rPPz8qgRQYGDUl4aK1vzRSa4fD8Y9+1uVkKLiraNEEJj4sDwlrlMUA8f/Bf/YROq6SRBWV1Z576aHxB6O5pq8EL4SUQ2Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLCoUU21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F9C433F1;
	Sun, 24 Mar 2024 23:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323470;
	bh=BEDj/bZZ8ydWaXAwhh7YWirDihFEP8hae+QSA1Zd6Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLCoUU215JGBe5tzmEJZ7AfKDKHCjEUx2ATcvgl7F63MUm98SMrZxE2XQS6shuDr0
	 eax7235RxOgUqzHPZyF74CuCyMISRxSIOBrr1R9qs6H4RU4syVpIeFiETgp+IGNbgT
	 kvUwOEY+5JJgF7nlDRQyUZfwB3h+ji5CyCwELWruKaleM1D9UyiSpG3zbqPPO5Y9TS
	 c/Xw5k3wUPELS1zJqbK8ouDvH+m31psO6ARRg7c4GgFgJjzLOagRJ6k+lS+dhgChMS
	 RVlvJV03enagsxpL47b0KZ7kyYOKiF02DUogwaFbpsqXnlyZOI5C9FeLT4ffJKIDY8
	 l52DEHtqj0NRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 175/317] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 19:32:35 -0400
Message-ID: <20240324233458.1352854-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f21d64ae4ffcc..cf0d4ba2e157a 100644
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


