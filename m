Return-Path: <linux-kernel+bounces-114702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380578890BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD831F2AEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2C2BAA4E;
	Mon, 25 Mar 2024 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toscVocd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048615FA92;
	Sun, 24 Mar 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322355; cv=none; b=Crr2JpeURz3oE/aB1K6WQORFM7xhoPmzV3HWuom1JPcoT520YZ0g9Qnou6RVD3S8c30NXSKue3Ao8V1lwl2gK+W/eqT3zbcPzMLFuWjBSgIo3axOja+6r3rok8W2PNoOZtQ3qbeIv3rZHAphw8PewIGU2Pyv4TVQnMvOWI2xuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322355; c=relaxed/simple;
	bh=nm/x47Sv9iDVQn/XHhCqWw8l31ohfCSWKv1uW9t//e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldAwF3g8gy1srm27aMyQjXhga6CJ/ctXWyWMFqkCJtfIFAoMplEwlaKpCcaOzYWf3qgi+fSQcbkCLGIRx0XjTXJoJUZrmfFxu/dgoxp55hMNKbMr3DXZWWPiUVHKo5tS/ZjjPo5/gdFgdLl4u3aj21xisb68hAx1dU0FOAcBBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toscVocd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD561C43394;
	Sun, 24 Mar 2024 23:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322354;
	bh=nm/x47Sv9iDVQn/XHhCqWw8l31ohfCSWKv1uW9t//e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toscVocdCipl6BBZXfyRsNWveL7ha1KBAHDphjMp11Y2V1vMsD3kEI26i4tuIWT2X
	 XTwW78w0ukJwd1K9HfzWz1Hi/Er28STYK2FPNi/se7NTvn7edDfiR4tLMYcNl8MCfi
	 j/w3JPqJIQ+gv2PSCJyNFuKAAp8JxfxDH06Jw/RTxzWslgAu9u2FYgDgrdQ1Zyqjd1
	 SI3AiPVHHGjI90wb7lJMAHmuvzMPwGwN3uSaPWq+9LvFJfDTRwsRFHWAfuTGJ5bJzc
	 akYZpBuaRyLNvB0rAZzT6ttHtNniatrjhzE0vwqRCZAFSqOQukaXIb0H4o/v2/6ED3
	 kHKRHjXp+CIjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 436/451] octeontx2-af: Use separate handlers for interrupts
Date: Sun, 24 Mar 2024 19:11:52 -0400
Message-ID: <20240324231207.1351418-437-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit 50e60de381c342008c0956fd762e1c26408f372c ]

For PF to AF interrupt vector and VF to AF vector same
interrupt handler is registered which is causing race condition.
When two interrupts are raised to two CPUs at same time
then two cores serve same event corrupting the data.

Fixes: 7304ac4567bc ("octeontx2-af: Add mailbox IRQ and msg handlers")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index a7965b457bee9..a7034b47ed6c9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2528,10 +2528,9 @@ static void rvu_queue_work(struct mbox_wq_info *mw, int first,
 	}
 }
 
-static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq)
 {
 	struct rvu *rvu = (struct rvu *)rvu_irq;
-	int vfs = rvu->vfs;
 	u64 intr;
 
 	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
@@ -2545,6 +2544,18 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 
 	rvu_queue_work(&rvu->afpf_wq_info, 0, rvu->hw->total_pfs, intr);
 
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu *rvu = (struct rvu *)rvu_irq;
+	int vfs = rvu->vfs;
+	u64 intr;
+
+	/* Sync with mbox memory region */
+	rmb();
+
 	/* Handle VF interrupts */
 	if (vfs > 64) {
 		intr = rvupf_read64(rvu, RVU_PF_VFPF_MBOX_INTX(1));
@@ -2881,7 +2892,7 @@ static int rvu_register_interrupts(struct rvu *rvu)
 	/* Register mailbox interrupt handler */
 	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
 	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu_mbox_intr_handler, 0,
+			  rvu_mbox_pf_intr_handler, 0,
 			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
 	if (ret) {
 		dev_err(rvu->dev,
-- 
2.43.0


