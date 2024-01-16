Return-Path: <linux-kernel+bounces-28161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8882FAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64C71F29F52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4E3FB0D;
	Tue, 16 Jan 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAn6Rq/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1B2032B;
	Tue, 16 Jan 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435314; cv=none; b=uVLGkUtX44BLj7xkf2dKEwM8HwTnEHVjHHacZY5Vgw6WYXb4Ped9Dzv7QkRKn9plXmNPnuDj8es37Fr65uefiiWXFBTvOYDqK/FpNv0Re/wmxMvrEW7qNNJBoRezIPOSoXnas5LP7h2Zq4WMI9S6Hg9Y2TCjjLxIHQC8v5rIs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435314; c=relaxed/simple;
	bh=jy1p6ywFMR7kkdFtIwAUEx/6OTZPztTtL/Zk00n+ZmI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=cFNaSi1tnfsCvbpUYX1lNpJ5dlc7sLtUF9qoFE2Mf4PpsIG7MbA1XfuXpufiliWQRQQsz74FzdUP2CmSVp0kosP+1+Xu51zbLjFZTF8Qc7PXHs5AJ1hVRjNvJTfDCkCLtaowJbVUCZrBD1JgeDGgikAwm0ud8rB3c3W0USob3Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAn6Rq/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C14C433F1;
	Tue, 16 Jan 2024 20:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435314;
	bh=jy1p6ywFMR7kkdFtIwAUEx/6OTZPztTtL/Zk00n+ZmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAn6Rq/1rNpSVDE2DK2qYwho8ndb5+Eg3xQa+JUWojMMiP5PxJ359cMGb+iAvueJ3
	 NdvKLMA8C+E6doExhUD5c0Aapm30QqFEOcE5IsVhmUIlpc1yq+piU3+Wobi4g6WYyR
	 HTUyWYNqWFxJxdOOHUai3zMo3LS5ez2ugs60LyWSV/HNV6Vyle0G5kzppNbgjqF0WE
	 +wL/ZvImd+fAaBT13aYraP/CJgr5rxZ4sKQp6g/DHL6UkSbkkkXYB2yaa6sRNPVYdX
	 FIxLf9uUEb6scdGbWP4zGsXvwPzrGZdatECeRIgcUyru/DBzOsidI4nbEz1XShFoGP
	 0jsbBBeokNPRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	drivers@pensando.io,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	allen.hubbe@amd.com,
	drc@linux.vnet.ibm.com,
	yuehaibing@huawei.com,
	keescook@chromium.org,
	justinstitt@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 25/44] ionic: pass opcode to devcmd_wait
Date: Tue, 16 Jan 2024 14:59:54 -0500
Message-ID: <20240116200044.258335-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 24f110240c03c6b5368f1203bac72883d511e606 ]

Don't rely on the PCI memory for the devcmd opcode because we
read a 0xff value if the PCI bus is broken, which can cause us
to report a bogus dev_cmd opcode later.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c  | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h  | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index dc5fbc2704f3..b5f681918f6e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -200,6 +200,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 64d27e8e0772..1ce0d307a9d0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -136,6 +136,7 @@ struct ionic_dev {
 	unsigned long last_hb_time;
 	u32 last_hb;
 	u8 last_fw_status;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 00b6985edea0..694e710244e6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -333,7 +333,7 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds)
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
-	opcode = readb(&idev->dev_cmd_regs->cmd.cmd.opcode);
+	opcode = idev->opcode;
 	start_time = jiffies;
 	do {
 		done = ionic_dev_cmd_done(idev);
-- 
2.43.0


