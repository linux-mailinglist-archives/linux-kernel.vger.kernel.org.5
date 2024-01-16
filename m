Return-Path: <linux-kernel+bounces-28055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77982F99E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458EB28913D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE81604D7;
	Tue, 16 Jan 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0rINWR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF61BDFF;
	Tue, 16 Jan 2024 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434998; cv=none; b=pB2ztEbe+7XFx7yUrdTx3dv2ic/wfeg2ZGVqiYPFQIJWGKzIeRSQNUoejysaQ9jdiCoaqpQ/M5CzvMEyfEM+mitoLvcZvvlDiM91lOP1J/abxdAtPKudzMF1WnX2mHDpeIu9V//OxCAWUBoQP72jgak9SuTY9vzRH5PISa4AGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434998; c=relaxed/simple;
	bh=cXwjYZ3PVa2Gz0IHRLbE2hLMYgJG1Q4uxce8s4wYxbQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Yz3vu1iVOqDL/Qraa+QUARezQSbXj3YxLIqUhZN9bgVgdgnC7TMPY5TKHq91Qd7AUdzHb1J6/tef04rk+X8HqtVwBGrtow4uyZiDwck8V0bhpAf5pJz/E6Nc4AQ5kpnbdyJK0njoZmKhbnpuynEaPvj5NnMkHx/usQxTNFweE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0rINWR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D090C433F1;
	Tue, 16 Jan 2024 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434997;
	bh=cXwjYZ3PVa2Gz0IHRLbE2hLMYgJG1Q4uxce8s4wYxbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0rINWR63wY3sDIYzf+GjGMQut+EG6CnE34m2snLQrXsMqJnE8Xv/KE4+vVAQTZAz
	 XHx6YRu1qayKL9CeGrMzJcqKSeswhlDzCghDsiMQ0imuH81vAdA1L2S5agr+OuM/ju
	 uApEwqpdtWIQb1rTbPb38WvKz0ciM/GnevNgGT26rCcjUyPswZPOCM4GnFvj/cdxuh
	 5639B1er5M0HQIL9oSHxGQGfKsTwbFPbC1aPuOlZpuWSAaDDeeeA/FjgmS4FpohYH7
	 MDGzvVQb0HL7G1nHl4mNWr1lVjdwDpZoyJBAOnT7YjfsNhPpgh8tbTAiV4Bw+WuaNH
	 9KU3zNxcXKjig==
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
Subject: [PATCH AUTOSEL 6.1 37/68] ionic: pass opcode to devcmd_wait
Date: Tue, 16 Jan 2024 14:53:36 -0500
Message-ID: <20240116195511.255854-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 344a3924627d..7adfcd7c2f3a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -293,6 +293,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 13dfcf9f75da..c10da629ef6e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -150,6 +150,7 @@ struct ionic_dev {
 	bool fw_hb_ready;
 	bool fw_status_ready;
 	u8 fw_generation;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 79272f5f380c..9ecbbe7a02ec 100644
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


