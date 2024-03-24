Return-Path: <linux-kernel+bounces-115112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE39888DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3046B2E090
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8813E6A2;
	Mon, 25 Mar 2024 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ydr9DINa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E99181476;
	Sun, 24 Mar 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324098; cv=none; b=iFInKKRFA3WsU+ygVAf+9UTeI8aLLIH46aicaoAjyI6aKbSBP4V8kHGFl2UckGR1AN313+jHeec55/Bq2G0bCf0fIMmCn6KUICNoBq2WgiAK1JBucSRAJ0HpZMh3i9nYJei2dhF3sYwxLn+YzRtCou0PrQiZJydlRJ9frKAkN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324098; c=relaxed/simple;
	bh=sJQ8UZ4SBoO1+vqNVm8qn6td0Err00uTMoDvqacQoPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcjSyf0BRl0ADdAihSQ0wOi9MYmcBp/QijeI0iniCOst80XTFbubHJcnDLdIvy2Z55rnD4kENQgh7AGWvSOkRhSOVj6DdeJYGmWgewtIkwrayjWQhfsBn+q/0AzJvGvCne4IWrgQPHnz56DbLlHXMfkjbiGzRVptXhWLqI7O8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ydr9DINa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A80C433C7;
	Sun, 24 Mar 2024 23:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324097;
	bh=sJQ8UZ4SBoO1+vqNVm8qn6td0Err00uTMoDvqacQoPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ydr9DINanPRQpHpb5N1DNptWHKYj8/5lep5kqpf6JI7MgzUFVm19J+XguDcw5FH/3
	 Vt2HYacXMdBsl0BegJzxhZWxiNWgGc/DLS1dXa2MlmECKPEmWoBTGxTy+RhhDrG7p3
	 FfTNpWbZjberV+0nce1QBKe1Ul7DUaefsc3hvf3Umv0ZmxqDeZaHNe8NlvKqdTZ8Zx
	 1bvbSFGr2R5zxZnKhicvbDkUBBqh8Csaeft6Pw1U2nxYCix66cPW4pi6KOjQ1hHM+6
	 mcXsi7rahGV7gNk5k984r6gd3DpTNxHFSDI762ce5IyFKqRw5CVt3s05pAAjLFLQyc
	 Ia8CYHXxV7KuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/183] PCI/DPC: Print all TLP Prefixes, not just the first
Date: Sun, 24 Mar 2024 19:45:09 -0400
Message-ID: <20240324234638.1355609-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index a32ec3487a8d0..d5734a83606fb 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -195,7 +195,7 @@ static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 
 	for (i = 0; i < dpc->rp_log_size - 5; i++) {
 		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG, &prefix);
+			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
 	}
  clear_status:
-- 
2.43.0


