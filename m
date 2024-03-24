Return-Path: <linux-kernel+bounces-114696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837AF8890B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E051C2C83A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29352B9304;
	Mon, 25 Mar 2024 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLgRH1N6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D414F9C9;
	Sun, 24 Mar 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322350; cv=none; b=rrZbtf6soZnngnCSuv57hoBOhY5oHzsK57g3kyghNiMCNNYwEWmCkm/jgmIJsqsh5JFzn36YRBpSW7cOgIEkbaGSy4XbadiB/ueXgFqIwd1pCyCc+EFcnKWnAxRWVkTsGYK6R8aKSX05zzw5v0MupAY2vMVGd1pNz5e2gqPUhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322350; c=relaxed/simple;
	bh=G3rk+WATCGrZVuhwcQVIlEgNMvvzQraXVmEAhedWwI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IF6+x403Bv+pavaaDfunArZu2G1KFa3ehCJUeE6Qs/hRLxxagGHndmv8yQolYKNk4N9GwbiWB3iduLaMq3odLPMQq8D1FwxEHc9iWhBsrSKZioei0ERjMek7gaEBvpxwbnSvVu7sfKRvlYo/I+74wE1mVvxQ8GwgY7UzZjnmees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLgRH1N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA3AC433F1;
	Sun, 24 Mar 2024 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322349;
	bh=G3rk+WATCGrZVuhwcQVIlEgNMvvzQraXVmEAhedWwI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLgRH1N6nKK0VdwNTM4dRtwvALV1czQ2xDBwDSfjKJLN03w3KA+Q9/ySPcMot3tbS
	 VV+nBg4zNaoke8e951fmv2l0E1FKMQEnDL0OkSgHnnuqnEN0VZWf4R2YUi29vREE00
	 yEbDJDwE1kpRyVbuXG2qSVACHpA70UgN+un4yXxxhHfpohF6fKfrE1+jKmE6qnTSVv
	 pxZFTIRfYHIn3sA+IyfLmKzgRGH9qXnxU0p0rpXpAYOofwDu34dBnxTa9DQYVris23
	 y7c1ZVWyvwt9mBRqGA2smr2jmMafNqa3BysDrvcW1G/QxkZXzm27GtAT5UOB89h3jY
	 35vXRtvJIkUmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 431/451] octeontx2-af: add mbox to return CPT_AF_FLT_INT info
Date: Sun, 24 Mar 2024 19:11:47 -0400
Message-ID: <20240324231207.1351418-432-sashal@kernel.org>
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

[ Upstream commit 8299ffe3dc3dc9ac2bd60e3a8332008f03156aca ]

CPT HW would trigger the CPT AF FLT interrupt when CPT engines
hits some uncorrectable errors and AF is the one which receives
the interrupt and recovers the engines.
This patch adds a mailbox for CPT VFs to request for CPT faulted
and recovered engines info.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 17 +++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  4 +++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 35 +++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 5decd1919de03..bbb6658420f1d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -197,6 +197,8 @@ M(CPT_RXC_TIME_CFG,     0xA06, cpt_rxc_time_cfg, cpt_rxc_time_cfg_req,  \
 			       msg_rsp)                                 \
 M(CPT_CTX_CACHE_SYNC,   0xA07, cpt_ctx_cache_sync, msg_req, msg_rsp)    \
 M(CPT_LF_RESET,         0xA08, cpt_lf_reset, cpt_lf_rst_req, msg_rsp)	\
+M(CPT_FLT_ENG_INFO,     0xA09, cpt_flt_eng_info, cpt_flt_eng_info_req,	\
+			       cpt_flt_eng_info_rsp)			\
 /* SDP mbox IDs (range 0x1000 - 0x11FF) */				\
 M(SET_SDP_CHAN_INFO, 0x1000, set_sdp_chan_info, sdp_chan_info_msg, msg_rsp) \
 M(GET_SDP_CHAN_INFO, 0x1001, get_sdp_chan_info, msg_req, sdp_get_chan_info_msg) \
@@ -1710,6 +1712,21 @@ struct cpt_lf_rst_req {
 	u32 rsvd;
 };
 
+/* Mailbox message format to request for CPT faulted engines */
+struct cpt_flt_eng_info_req {
+	struct mbox_msghdr hdr;
+	int blkaddr;
+	bool reset;
+	u32 rsvd;
+};
+
+struct cpt_flt_eng_info_rsp {
+	struct mbox_msghdr hdr;
+	u64 flt_eng_map[CPT_10K_AF_INT_VEC_RVU];
+	u64 rcvrd_eng_map[CPT_10K_AF_INT_VEC_RVU];
+	u64 rsvd;
+};
+
 struct sdp_node_info {
 	/* Node to which this PF belons to */
 	u8 node_id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e1760f9298b17..6a39006c334d7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -109,6 +109,8 @@ struct rvu_block {
 	u64  lfreset_reg;
 	unsigned char name[NAME_SIZE];
 	struct rvu *rvu;
+	u64 cpt_flt_eng_map[3];
+	u64 cpt_rcvrd_eng_map[3];
 };
 
 struct nix_mcast {
@@ -521,6 +523,8 @@ struct rvu {
 	struct list_head	mcs_intrq_head;
 	/* mcs interrupt queue lock */
 	spinlock_t		mcs_intrq_lock;
+	/* CPT interrupt lock */
+	spinlock_t		cpt_intr_lock;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 923af460db296..6fb02b93c1718 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -70,6 +70,14 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 
 		rvu_write64(rvu, blkaddr, CPT_AF_EXEX_CTL2(eng), grp);
 		rvu_write64(rvu, blkaddr, CPT_AF_EXEX_CTL(eng), val | 1ULL);
+
+		spin_lock(&rvu->cpt_intr_lock);
+		block->cpt_flt_eng_map[vec] |= BIT_ULL(i);
+		val = rvu_read64(rvu, blkaddr, CPT_AF_EXEX_STS(eng));
+		val = val & 0x3;
+		if (val == 0x1 || val == 0x2)
+			block->cpt_rcvrd_eng_map[vec] |= BIT_ULL(i);
+		spin_unlock(&rvu->cpt_intr_lock);
 	}
 	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT(vec), reg);
 
@@ -884,6 +892,31 @@ int rvu_mbox_handler_cpt_lf_reset(struct rvu *rvu, struct cpt_lf_rst_req *req,
 	return 0;
 }
 
+int rvu_mbox_handler_cpt_flt_eng_info(struct rvu *rvu, struct cpt_flt_eng_info_req *req,
+				      struct cpt_flt_eng_info_rsp *rsp)
+{
+	struct rvu_block *block;
+	unsigned long flags;
+	int blkaddr, vec;
+
+	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
+	if (blkaddr < 0)
+		return blkaddr;
+
+	block = &rvu->hw->block[blkaddr];
+	for (vec = 0; vec < CPT_10K_AF_INT_VEC_RVU; vec++) {
+		spin_lock_irqsave(&rvu->cpt_intr_lock, flags);
+		rsp->flt_eng_map[vec] = block->cpt_flt_eng_map[vec];
+		rsp->rcvrd_eng_map[vec] = block->cpt_rcvrd_eng_map[vec];
+		if (req->reset) {
+			block->cpt_flt_eng_map[vec] = 0x0;
+			block->cpt_rcvrd_eng_map[vec] = 0x0;
+		}
+		spin_unlock_irqrestore(&rvu->cpt_intr_lock, flags);
+	}
+	return 0;
+}
+
 static void cpt_rxc_teardown(struct rvu *rvu, int blkaddr)
 {
 	struct cpt_rxc_time_cfg_req req;
@@ -1172,5 +1205,7 @@ int rvu_cpt_init(struct rvu *rvu)
 {
 	/* Retrieve CPT PF number */
 	rvu->cpt_pf_num = get_cpt_pf_num(rvu);
+	spin_lock_init(&rvu->cpt_intr_lock);
+
 	return 0;
 }
-- 
2.43.0


