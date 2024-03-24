Return-Path: <linux-kernel+bounces-116173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A85889A04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98062A7D94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD03B7163;
	Mon, 25 Mar 2024 03:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOBgcZ09"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119517BB13;
	Sun, 24 Mar 2024 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323750; cv=none; b=m+XHDkN3E2VSvVCQga9OAYzaSuHRihqJzN3SvOng+PuVqZz+K1flB+M3FEnpjHEdNJtUQE5onnxvLn9GaHMhs/G2QlpGiFkhyKnTeB0VTyQrqfj4mEReK6mDX6mLf7qUiJchyPVgE7XKefHkLMZc/SpZK/Ao121ybudaboPWKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323750; c=relaxed/simple;
	bh=BEDj/bZZ8ydWaXAwhh7YWirDihFEP8hae+QSA1Zd6Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfvLc82HAB7eVKJSnXNAUNE9iZNH6jUlg8bwxyUj5gewwBGc/mHLVYaWtKmqBrvuMl1fJwqITCjJzAc7wYw1V/TCOj1K2vbcpfAeUPJY7rVsvEBCEAtAA/euzp7BR8gsbGW9oVXedFguVYeNelxIaFVfz4sboZ1BZD8THag5E1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOBgcZ09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858BC43390;
	Sun, 24 Mar 2024 23:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323750;
	bh=BEDj/bZZ8ydWaXAwhh7YWirDihFEP8hae+QSA1Zd6Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOBgcZ09KuQgk9rAZVZPN4mCdpIkdYkjNfSAinZn/S2KGsc/EJU222CBajyTlQX37
	 FVpJo2kpSEyz2tMJFQ4+/Iv6Xz7lLjGGE1S7BKB2toiRybCoPChgXlbw3oX9iu6mMS
	 ap8Ihgm6RvU9lzmq1N2oqHBAWoEDrewXNtQVMn1YF2m08p3PZ4lvU/R6T2CqYRR7h3
	 0i1Hy1yhDFEwTKiAPB0hK7SbkD9nG+WfWbNPqk2BBTa/guR84ODN5gmr4piifYfqNQ
	 rR+w2otggq2drIvE4hHeJothtvQlMJJqVswVxJ67ukeGBbuItBi2z9kjelUbe5xk49
	 2io9FcRTSIpjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 125/238] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 19:38:33 -0400
Message-ID: <20240324234027.1354210-126-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


