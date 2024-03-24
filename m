Return-Path: <linux-kernel+bounces-115996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664748896B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4691C305F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4BB39B0E6;
	Mon, 25 Mar 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moIqEMx5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E223A750;
	Sun, 24 Mar 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322346; cv=none; b=VyRLiLuHM+bzuiV5ZotxENk/Yf8VUOXy9tab/T8p0VD8KNaKiTMsMOZ1I4gh+3nalu3JkZ/NQmTUTzMfjApkXI/lCsCjHisMNMeDON9bKnuZ5MPU8bgGwjMXnLDF4WnzLLxgjDw8v8WUH8ASlvpgxu1hhYYrvTSOSQHt9NmSrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322346; c=relaxed/simple;
	bh=wq1NU6b4yh8pENqwqKMnwfMu+mw7da+AGRLm2NEShzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9GSie7RIVWWaHkP8HtkB2HZFJM5mm12aaFUdoNpfjBpgw1UlRTVhiVPS68V2eH1QrZstHiQwYT/P74GaaXuU7PYLcODN+Rcf2DGy3sUuvr3EBamKSGnDMQzhfiLfVt0bXdBFtcbxTfVgi9V9NZ9pY2DCmnfaxtOvDra1tvGLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moIqEMx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BC2C43390;
	Sun, 24 Mar 2024 23:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322346;
	bh=wq1NU6b4yh8pENqwqKMnwfMu+mw7da+AGRLm2NEShzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moIqEMx58NXEVwq/aorsMFv6lPE69dOmZ/HVy1FFTYfKUPSBky45n0CsyyBu4oMDf
	 a25TpxdG4OKIgn5IvH7FkTk1XgLYzyW0QBrttGuCBpFSTtze//pgxaBD6s26nQkFUg
	 Yzzs6et9T/zS2gwtSV6XgA4SSVchi62X0EPJoGhTRKgkOpDGP0vIYKKTAN+0eF6g2z
	 oY5HaA8cPB5rCGDE1L/6YKgI5vpDs0HXmcq0zMWlxnlT0J9mn0KPXYrhhuiWuZIZg0
	 /aau7CkqOiMYmjQIL3Kyki2RkrMnYV185fiSVE4oRYXpEFmYAZWiVp8i19yFMIXqt+
	 Zke5UxGtoJ1Yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 428/451] octeontx2-af: recover CPT engine when it gets fault
Date: Sun, 24 Mar 2024 19:11:44 -0400
Message-ID: <20240324231207.1351418-429-sashal@kernel.org>
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

From: Srujana Challa <schalla@marvell.com>

[ Upstream commit 07ea567d84cdf0add274d66db7c02b55b818d517 ]

When CPT engine has uncorrectable errors, it will get halted and
must be disabled and re-enabled. This patch adds code for the same.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 110 +++++++++++++-----
 1 file changed, 80 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 38bbae5d9ae05..1ed16ce515bb1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -37,34 +37,60 @@
 	(_rsp)->free_sts_##etype = free_sts;                        \
 })
 
-static irqreturn_t rvu_cpt_af_flt_intr_handler(int irq, void *ptr)
+static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 {
 	struct rvu_block *block = ptr;
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
-	u64 reg0, reg1, reg2;
-
-	reg0 = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(0));
-	reg1 = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(1));
-	if (!is_rvu_otx2(rvu)) {
-		reg2 = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(2));
-		dev_err_ratelimited(rvu->dev,
-				    "Received CPTAF FLT irq : 0x%llx, 0x%llx, 0x%llx",
-				     reg0, reg1, reg2);
-	} else {
-		dev_err_ratelimited(rvu->dev,
-				    "Received CPTAF FLT irq : 0x%llx, 0x%llx",
-				     reg0, reg1);
+	u64 reg, val;
+	int i, eng;
+	u8 grp;
+
+	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
+	dev_err_ratelimited(rvu->dev, "Received CPTAF FLT%d irq : 0x%llx", vec, reg);
+
+	i = -1;
+	while ((i = find_next_bit((unsigned long *)&reg, 64, i + 1)) < 64) {
+		switch (vec) {
+		case 0:
+			eng = i;
+			break;
+		case 1:
+			eng = i + 64;
+			break;
+		case 2:
+			eng = i + 128;
+			break;
+		}
+		grp = rvu_read64(rvu, blkaddr, CPT_AF_EXEX_CTL2(eng)) & 0xFF;
+		/* Disable and enable the engine which triggers fault */
+		rvu_write64(rvu, blkaddr, CPT_AF_EXEX_CTL2(eng), 0x0);
+		val = rvu_read64(rvu, blkaddr, CPT_AF_EXEX_CTL(eng));
+		rvu_write64(rvu, blkaddr, CPT_AF_EXEX_CTL(eng), val & ~1ULL);
+
+		rvu_write64(rvu, blkaddr, CPT_AF_EXEX_CTL2(eng), grp);
+		rvu_write64(rvu, blkaddr, CPT_AF_EXEX_CTL(eng), val | 1ULL);
 	}
-
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT(0), reg0);
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT(1), reg1);
-	if (!is_rvu_otx2(rvu))
-		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT(2), reg2);
+	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT(vec), reg);
 
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rvu_cpt_af_flt0_intr_handler(int irq, void *ptr)
+{
+	return cpt_af_flt_intr_handler(CPT_AF_INT_VEC_FLT0, ptr);
+}
+
+static irqreturn_t rvu_cpt_af_flt1_intr_handler(int irq, void *ptr)
+{
+	return cpt_af_flt_intr_handler(CPT_AF_INT_VEC_FLT1, ptr);
+}
+
+static irqreturn_t rvu_cpt_af_flt2_intr_handler(int irq, void *ptr)
+{
+	return cpt_af_flt_intr_handler(CPT_10K_AF_INT_VEC_FLT2, ptr);
+}
+
 static irqreturn_t rvu_cpt_af_rvu_intr_handler(int irq, void *ptr)
 {
 	struct rvu_block *block = ptr;
@@ -119,8 +145,10 @@ static void cpt_10k_unregister_interrupts(struct rvu_block *block, int off)
 	int i;
 
 	/* Disable all CPT AF interrupts */
-	for (i = 0; i < CPT_10K_AF_INT_VEC_RVU; i++)
-		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i), 0x1);
+	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(0), ~0ULL);
+	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(1), ~0ULL);
+	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(2), 0xFFFF);
+
 	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1C, 0x1);
 	rvu_write64(rvu, blkaddr, CPT_AF_RAS_INT_ENA_W1C, 0x1);
 
@@ -151,7 +179,7 @@ static void cpt_unregister_interrupts(struct rvu *rvu, int blkaddr)
 
 	/* Disable all CPT AF interrupts */
 	for (i = 0; i < CPT_AF_INT_VEC_RVU; i++)
-		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i), 0x1);
+		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i), ~0ULL);
 	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1C, 0x1);
 	rvu_write64(rvu, blkaddr, CPT_AF_RAS_INT_ENA_W1C, 0x1);
 
@@ -172,16 +200,31 @@ static int cpt_10k_register_interrupts(struct rvu_block *block, int off)
 {
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
+	irq_handler_t flt_fn;
 	int i, ret;
 
 	for (i = CPT_10K_AF_INT_VEC_FLT0; i < CPT_10K_AF_INT_VEC_RVU; i++) {
 		sprintf(&rvu->irq_name[(off + i) * NAME_SIZE], "CPTAF FLT%d", i);
+
+		switch (i) {
+		case CPT_10K_AF_INT_VEC_FLT0:
+			flt_fn = rvu_cpt_af_flt0_intr_handler;
+			break;
+		case CPT_10K_AF_INT_VEC_FLT1:
+			flt_fn = rvu_cpt_af_flt1_intr_handler;
+			break;
+		case CPT_10K_AF_INT_VEC_FLT2:
+			flt_fn = rvu_cpt_af_flt2_intr_handler;
+			break;
+		}
 		ret = rvu_cpt_do_register_interrupt(block, off + i,
-						    rvu_cpt_af_flt_intr_handler,
-						    &rvu->irq_name[(off + i) * NAME_SIZE]);
+						    flt_fn, &rvu->irq_name[(off + i) * NAME_SIZE]);
 		if (ret)
 			goto err;
-		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), 0x1);
+		if (i == CPT_10K_AF_INT_VEC_FLT2)
+			rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), 0xFFFF);
+		else
+			rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), ~0ULL);
 	}
 
 	ret = rvu_cpt_do_register_interrupt(block, off + CPT_10K_AF_INT_VEC_RVU,
@@ -208,8 +251,8 @@ static int cpt_register_interrupts(struct rvu *rvu, int blkaddr)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	struct rvu_block *block;
+	irq_handler_t flt_fn;
 	int i, offs, ret = 0;
-	char irq_name[16];
 
 	if (!is_block_implemented(rvu->hw, blkaddr))
 		return 0;
@@ -226,13 +269,20 @@ static int cpt_register_interrupts(struct rvu *rvu, int blkaddr)
 		return cpt_10k_register_interrupts(block, offs);
 
 	for (i = CPT_AF_INT_VEC_FLT0; i < CPT_AF_INT_VEC_RVU; i++) {
-		snprintf(irq_name, sizeof(irq_name), "CPTAF FLT%d", i);
+		sprintf(&rvu->irq_name[(offs + i) * NAME_SIZE], "CPTAF FLT%d", i);
+		switch (i) {
+		case CPT_AF_INT_VEC_FLT0:
+			flt_fn = rvu_cpt_af_flt0_intr_handler;
+			break;
+		case CPT_AF_INT_VEC_FLT1:
+			flt_fn = rvu_cpt_af_flt1_intr_handler;
+			break;
+		}
 		ret = rvu_cpt_do_register_interrupt(block, offs + i,
-						    rvu_cpt_af_flt_intr_handler,
-						    irq_name);
+						    flt_fn, &rvu->irq_name[(offs + i) * NAME_SIZE]);
 		if (ret)
 			goto err;
-		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), 0x1);
+		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), ~0ULL);
 	}
 
 	ret = rvu_cpt_do_register_interrupt(block, offs + CPT_AF_INT_VEC_RVU,
-- 
2.43.0


