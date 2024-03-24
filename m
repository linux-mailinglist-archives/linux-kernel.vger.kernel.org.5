Return-Path: <linux-kernel+bounces-115458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA8889BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644DD2C204A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507B21C177;
	Mon, 25 Mar 2024 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac27vTSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6C1292DC;
	Sun, 24 Mar 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320845; cv=none; b=MNalWw+J28NOSB+PLnVAGrx736hBihIfYdy+yTw3SUuCieiOcKGk329BuCqSvc0h8B9Y2pdgy6UrNv8kquOg2U3ArYS3xtbsZG6VN/5Svd92gx9gl+1kmAGFj4GkMJDgcC3SUHV/3a66XzMVEC1Z7HaClOQ5QFvC1SAgH6S7Tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320845; c=relaxed/simple;
	bh=Bi+CbrTK4iD6H6njG6um+soEi21PZdr3qsucuDdlk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhhqJ+k4aNCgR3qyrHbyuNK/J/TKNDsztDVDp2lzWBucaN6iFsEimmtjCSEiXrTT0dSDJkBb99QR8SrBmF6IQNt6P5Z7VFJfzAMuh9juadlr5i2Ip8eYFf0E6/N/eHPGYcgsI026Lcbeayuo7VAT+ilxM2Q4wZyppWmbNfjf/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac27vTSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A871C433C7;
	Sun, 24 Mar 2024 22:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320844;
	bh=Bi+CbrTK4iD6H6njG6um+soEi21PZdr3qsucuDdlk/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ac27vTShsFsPZu1VGC4xKsI2Jeiawi3CJxFIjHf02PwouBZCapobLcsL9lCX+TaTu
	 nwlP7OfteQkV0HTy+Km3NZDENZCZ4wSs4NIdtwIMmPEIbp3hczzLvmTLa+ZWVPakC7
	 AM07e/d/VzQffJOhlEZJOXXV0i4WJ7qet1+wSZqDxK5v4oMMersPyzqUchTdXckR4L
	 dX1178k2Wz9a4NFnQWQQLTLUalEl/HLM/rRd2f8USBSoZKRlBzvohjQ25O4dITuboc
	 8FzW0tGcqYMQMyz3XsrWvGV0Io6A13nhRS3Ci9tfch/PafK/OpqZxT4T08HVRdxN7s
	 bORo+cjdu0CKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 410/713] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 18:42:16 -0400
Message-ID: <20240324224720.1345309-411-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


