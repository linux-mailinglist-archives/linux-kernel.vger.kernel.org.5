Return-Path: <linux-kernel+bounces-27971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6C182F883
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB891F26BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789A1F19D;
	Tue, 16 Jan 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3FUSeol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478837F7D7;
	Tue, 16 Jan 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434714; cv=none; b=uZBN5qly3+FbbTu3RLlIr7zEfYAUd4e/Bd9hnvDZINp6MQ3CIJtMvzoWNcnxHDNMPOzyVEAaq6oDNYL7JDfdZ6LT+tAbGqJTPPaAHjrTUcbt8ATO6JkJPo9N4Lj5WT4EmvMPxUlcaLZUQWw0bjAJXQGjDBAENTBgAxOqI4dVL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434714; c=relaxed/simple;
	bh=7YXe3ADN7fnF7Ev541THmz4uS1qnlQIWpTKvm5bZzJk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=imyAhaO+Bl/KPxQ94MFp2Dp/IXZf5PTC3QXRcRunxOp0+F+n9+Bizo3HqAmbcl8mwoRmeZWgYU9dPztP2l4TBcT7QhIYv2KRJBisZO3UmJ0E0UyO/RCjGKcetTrkyfXyQ+tEM7Ou3RTz3BynqSmE4bmvavpHlm4wbxNjaTrX4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3FUSeol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66378C433F1;
	Tue, 16 Jan 2024 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434714;
	bh=7YXe3ADN7fnF7Ev541THmz4uS1qnlQIWpTKvm5bZzJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3FUSeolw0xIsjlSNQWwp91iWjnR5CricSB0hUEoZTlmBg1xR10uv+16cYYKb7jzI
	 cdEA2PVvr93UqO++li6bj6rXuap8TfbEZdHdbCIF14qczYTpmJAly1JVkMR02VPj5Y
	 C/7Osm99wq95Fi3UCpa0LvTjT9+BJziPuWdiWLdZrzum4C5gZ7TGVuMJSW/3fXJ0lu
	 3MhjayOGaZQmq9IDAft3gsm293SrQHeA2+d/S5zVwgOBeTW59ZSoqTFtJig+E1POcI
	 1QmzC4oJvnqxMzvVdyvK+Gd3e4rh0WHT5hG2K9BPdY6k0GZAyLwwE5IOXnY3luLGLG
	 4EqjALnS340RA==
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
	leon@kernel.org,
	justinstitt@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 060/104] ionic: pass opcode to devcmd_wait
Date: Tue, 16 Jan 2024 14:46:26 -0500
Message-ID: <20240116194908.253437-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index c06576f43916..22ab0a44fa8c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -321,6 +321,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index bd2d4a26f543..23f9d3b8029a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -152,6 +152,7 @@ struct ionic_dev {
 	bool fw_hb_ready;
 	bool fw_status_ready;
 	u8 fw_generation;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 1dc79cecc5cc..baa865af49ad 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -465,7 +465,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
-	opcode = readb(&idev->dev_cmd_regs->cmd.cmd.opcode);
+	opcode = idev->opcode;
 	start_time = jiffies;
 	for (fw_up = ionic_is_fw_running(idev);
 	     !done && fw_up && time_before(jiffies, max_wait);
-- 
2.43.0


