Return-Path: <linux-kernel+bounces-113265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507458882F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26522835E5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9101189A54;
	Sun, 24 Mar 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7quGLt4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9A189A38;
	Sun, 24 Mar 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320065; cv=none; b=Cuq/REdD9IKCjltHyJJjmweMYZPBr/wB6liVjJjXrnr+1RqibfcZMZATkyWtVfr0O51Tivwed2wNhobAICWQavyMmjJkLVZTeE/C5FeWxt1Q6UWDIPTBCfys5ZT3QPX/YiLRtre9+/uCi1aL6Vz3XICdkRyVwnmdyjFIZHWoZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320065; c=relaxed/simple;
	bh=Bi+CbrTK4iD6H6njG6um+soEi21PZdr3qsucuDdlk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmjxeRvdo19df0GPA7f/E7N1HoT7nyUs3tuBg7SESXGwYm120wVVRAGDICLhkWvu96CTMBnIgCcsB61Qq6DfHJur8dOqw11AEzTpKv6GNC9Ig+KLSEaT16Nph7vqYhOAD1wcC+C6wMOjps7rCvFH1m3CwKKitM8B1AZNN6cHarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7quGLt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5E1C433F1;
	Sun, 24 Mar 2024 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320064;
	bh=Bi+CbrTK4iD6H6njG6um+soEi21PZdr3qsucuDdlk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7quGLt4gvan3PXumkrefb3EAeZaGxUq4CPkzXtqyICzinx+ss0gwMtp0LZ+lXIxZ
	 tcsoXwxms0lAhGIUoLvA9ZSfMnBepXQ2rq3hkX3k8K7PB3jWuRi0SPW7N6SKFiobtJ
	 qSsMr+C/OQfYiXWlGDfjK3W1RqxOmRq6h8q+lRuYy91b80/SnV42DHljHFLh8t2xdF
	 b9Fbl6qEns3+E8MGIURgGdKgrK7yJ4/ByDAxkN3n256G4hL4a5Z0aSFmyDFg3Ops3E
	 MK+BwHTdgCAM+wDTi+av41m1WPB/zUiuVm8N7Gq1/c2Bxgz9MkGENllfiYTLajmmMF
	 L9h243NiWtf3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 374/715] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 18:29:13 -0400
Message-ID: <20240324223455.1342824-375-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 94111e4382413..e5d7c12854fa0 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -234,7 +234,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
-- 
2.43.0


