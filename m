Return-Path: <linux-kernel+bounces-113587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D1888584
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D564BB2226F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92A1CB666;
	Sun, 24 Mar 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X41zSqJQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DA1CADD2;
	Sun, 24 Mar 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320390; cv=none; b=e59ptfvjWNhJWbND5vpovWGv/buxsXQbI3Xudk+9wMmSwMVIkHeFcmIH64phZlEiVRTnt6Xt0uQzLzTiJLcFRwkQNrBrCNxxMn4X45vfGDTUrx26AnDJYOAFR1X43g2Mglu4BX5mZmF0nOBNRxZsCPBfxRXH9Wa99emBetFiFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320390; c=relaxed/simple;
	bh=akyCiPipqbgH9uYcbISvXDEQx3ozMU+L37j//NWRLHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUopytKjTbpuNjrWTwqT9hpdrrOyqEwGzi2gCx4YnDIQHCN9WZfOBmj79/6uwMyP3UcOS9hpS+UVev3r8icAXcpb2mAVEUooL3B/pBGvWKC+Vf8WHKecX+LrCE9EKlrxqJzYI5jC87e7zQgfNWx2045vKGTtahu0jjOwXfbKaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X41zSqJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD109C43394;
	Sun, 24 Mar 2024 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320390;
	bh=akyCiPipqbgH9uYcbISvXDEQx3ozMU+L37j//NWRLHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X41zSqJQtKXyp/dSW+vUc4jiuvP/iLTnkTZR7m1H1saF7f+w4jZPe74fSCoVR8PD1
	 kADs8PpatqpOn4awAWyDpXQqPCZgCQudKcR7cunNe2d05WuyoIrasRx3jDTmGvXVM1
	 Mn+L/7gmq+QOPZiihtzgGZgpMA0cHvc8fQ4aEKQ/wOLSdnqjuyWyci5T140ymJHXUe
	 4mUAujbgADkp1ZrH/xXNNTce0ftcisZzNzWHvRAr+U4ixTEfHBUEQE9qAoiGTsECqS
	 nGyBeWv+pVRKBwH58GGVAsbXbuesxFYQ3GU+uEhFNkqc+vbLEcjXjcLilzs3Bw6gp3
	 V4VY+zV7h6Opw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 696/715] octeontx2-af: Use separate handlers for interrupts
Date: Sun, 24 Mar 2024 18:34:35 -0400
Message-ID: <20240324223455.1342824-697-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index d2a575a645d8a..6a911ea0cff9b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2531,10 +2531,9 @@ static void rvu_queue_work(struct mbox_wq_info *mw, int first,
 	}
 }
 
-static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq)
 {
 	struct rvu *rvu = (struct rvu *)rvu_irq;
-	int vfs = rvu->vfs;
 	u64 intr;
 
 	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
@@ -2548,6 +2547,18 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 
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
@@ -2889,7 +2900,7 @@ static int rvu_register_interrupts(struct rvu *rvu)
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


