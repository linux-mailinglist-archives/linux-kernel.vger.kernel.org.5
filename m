Return-Path: <linux-kernel+bounces-116104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF00889955
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF811C2CA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B029229BE8;
	Mon, 25 Mar 2024 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diiEXJF8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033D27F095;
	Sun, 24 Mar 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323600; cv=none; b=cW+F+LRwKdjhsRrKW9hPkE6jJ/O9AiqFsOEmr0jLeXhZoHzrv9SgaOkbovTq1v2yONG43yqgLI7M7O4aNzzKcOrPpXzquNNE5WjFkQGAu2l/iPPtaRRmult14ITn/pVRbfsVyDSR192ZP5OamVxhg28bmmt1Ji0dHoTGto6ARlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323600; c=relaxed/simple;
	bh=XRGuTil339vx5L3x3APITUtg4LgUNQ85iCV4CT+4v1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3wMG+GDkrbOIWbkXEIEAqIXJThyKeQlF108AEw3m66oyobmC2r1Cf5tT5pkXdEGXzWUR3YVf60ITnNx7Q8jWBxt/6vRx4bxb87gC/9fa7vfd12A1Mq+ox21oY/RCSJybmsgF9SUx6wX2avrncxg2DYDns+HkFUv9TTzFNEkVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diiEXJF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A4BC433C7;
	Sun, 24 Mar 2024 23:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323599;
	bh=XRGuTil339vx5L3x3APITUtg4LgUNQ85iCV4CT+4v1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diiEXJF80GVHrRfSWnrUBqjFSyPSYfufgi5SeoZ4fcSIemSc/ivorwepnjLQQKRHg
	 H3iKDjvAYQOaiRnz3wsW1XBHswoMjfcSlUL2M1tvOuHMI4K+G2pHxlwD66xORcetBg
	 wLdKuV7W6tlW9WX5oxkjkxlGlPTTvxmObMRNy+ArGHqLebFikF9aZzE8NWyZR3Jkbg
	 BGaLj28k6g/JVQnj7MQX+y13foC1HhrZveakmD1X1v5lJ2Vo6V8oMrkMtTLC75MBXv
	 Zff/51HJYTkJf9d2mmMX21aGzRFEgbPDj7gxdVafrHRkGIKpJL7DqZCw0jDhr2/f6w
	 3WRfnC2FyqydA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 305/317] octeontx2-af: Use separate handlers for interrupts
Date: Sun, 24 Mar 2024 19:34:45 -0400
Message-ID: <20240324233458.1352854-306-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f64509b1d120c..bac42e0065c6c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2435,10 +2435,9 @@ static void rvu_queue_work(struct mbox_wq_info *mw, int first,
 	}
 }
 
-static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq)
 {
 	struct rvu *rvu = (struct rvu *)rvu_irq;
-	int vfs = rvu->vfs;
 	u64 intr;
 
 	intr = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT);
@@ -2452,6 +2451,18 @@ static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq)
 
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
@@ -2779,7 +2790,7 @@ static int rvu_register_interrupts(struct rvu *rvu)
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


