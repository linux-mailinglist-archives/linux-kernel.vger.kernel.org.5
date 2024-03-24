Return-Path: <linux-kernel+bounces-115997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A788991B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54211C32249
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7E39B0EE;
	Mon, 25 Mar 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTbeZCXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1E23A763;
	Sun, 24 Mar 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322347; cv=none; b=WX0tzaxXKg738mNI/pTQN0WVO8m9l0SPSdwh+a5AXpzS9IdNfDqnHgRy3yUOSVJ7KUVzwxtB1Oa/Cj14WggVCWYYdYxQNnL+5u5eNFRg10Pro8r4W9dcduiVPYmQVgdPhcQLQGFHPX4HXyVrwZyJVByoVhLvYqtNMqCFT8rQngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322347; c=relaxed/simple;
	bh=LfyNrW1+MXXTUsR4zle5oq2vOCRC7TXDDlKggV7YYL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVf/QDMuNHkaFRnR3MAR/rzJCf6hfdCJ4FjG94u2/hFz+C77otbKLoU2mMVJnGn+FcV+sjPATv7yrCNb0u/P31vnf4jCAwW26WSUYiZGMp1a+wDak5TAK2+FovrBLZ7Esy4h/mG1yG39XRvqlyRdYJU3iiYCyKnpMhRMgoDa+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTbeZCXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C410C43399;
	Sun, 24 Mar 2024 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322347;
	bh=LfyNrW1+MXXTUsR4zle5oq2vOCRC7TXDDlKggV7YYL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTbeZCXfPliJc1Ik4Qyn7L72P4ETVNlKwAbjHaRW8OfDUnthhpmZ0Y+N8v9CaGkQK
	 jLGVm+uYFVybQshs9rEAM66aqTd0avuGgMExFBYV6HUBSj26eozMxj/Vk6QunryGzZ
	 M0b32FLCEm0KGHqmkorGqPY4OA18nibSu7x0T04egDEvo7GSJ7aujpVehuuFhKH9oN
	 5LlsDHV12bW3N2GzzLdabw5WXUWomfNSgy9P7cnU8PPnEb7XFD8o91A+qfzZfiCzFm
	 JtKCtDNGqFNIt+MNlVSyCY/MxTeFpKw9tYeOWShdoZK6CJa7ZsRU0bODdymGPKOKkt
	 GGknFzoBl5hsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 429/451] octeontx2-af: add mbox for CPT LF reset
Date: Sun, 24 Mar 2024 19:11:45 -0400
Message-ID: <20240324231207.1351418-430-sashal@kernel.org>
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

[ Upstream commit f58cf765e8f5f4860ea094aa12c156d9195a4c28 ]

On OcteonTX2 SoC, the admin function (AF) is the only one with all
priviliges to configure HW and alloc resources, PFs and it's VFs
have to request AF via mailbox for all their needs.
This patch adds a new mailbox for CPT VFs to request for CPT LF
reset.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  8 +++++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 33 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 03ebabd616353..5decd1919de03 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -196,6 +196,7 @@ M(CPT_STATS,            0xA05, cpt_sts, cpt_sts_req, cpt_sts_rsp)	\
 M(CPT_RXC_TIME_CFG,     0xA06, cpt_rxc_time_cfg, cpt_rxc_time_cfg_req,  \
 			       msg_rsp)                                 \
 M(CPT_CTX_CACHE_SYNC,   0xA07, cpt_ctx_cache_sync, msg_req, msg_rsp)    \
+M(CPT_LF_RESET,         0xA08, cpt_lf_reset, cpt_lf_rst_req, msg_rsp)	\
 /* SDP mbox IDs (range 0x1000 - 0x11FF) */				\
 M(SET_SDP_CHAN_INFO, 0x1000, set_sdp_chan_info, sdp_chan_info_msg, msg_rsp) \
 M(GET_SDP_CHAN_INFO, 0x1001, get_sdp_chan_info, msg_req, sdp_get_chan_info_msg) \
@@ -1702,6 +1703,13 @@ struct cpt_inst_lmtst_req {
 	u64 rsvd;
 };
 
+/* Mailbox message format to request for CPT LF reset */
+struct cpt_lf_rst_req {
+	struct mbox_msghdr hdr;
+	u32 slot;
+	u32 rsvd;
+};
+
 struct sdp_node_info {
 	/* Node to which this PF belons to */
 	u8 node_id;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 1ed16ce515bb1..1cd34914cb86b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -851,6 +851,39 @@ int rvu_mbox_handler_cpt_ctx_cache_sync(struct rvu *rvu, struct msg_req *req,
 	return rvu_cpt_ctx_flush(rvu, req->hdr.pcifunc);
 }
 
+int rvu_mbox_handler_cpt_lf_reset(struct rvu *rvu, struct cpt_lf_rst_req *req,
+				  struct msg_rsp *rsp)
+{
+	u16 pcifunc = req->hdr.pcifunc;
+	struct rvu_block *block;
+	int cptlf, blkaddr, ret;
+	u16 actual_slot;
+	u64 ctl, ctl2;
+
+	blkaddr = rvu_get_blkaddr_from_slot(rvu, BLKTYPE_CPT, pcifunc,
+					    req->slot, &actual_slot);
+	if (blkaddr < 0)
+		return CPT_AF_ERR_LF_INVALID;
+
+	block = &rvu->hw->block[blkaddr];
+
+	cptlf = rvu_get_lf(rvu, block, pcifunc, actual_slot);
+	if (cptlf < 0)
+		return CPT_AF_ERR_LF_INVALID;
+	ctl = rvu_read64(rvu, blkaddr, CPT_AF_LFX_CTL(cptlf));
+	ctl2 = rvu_read64(rvu, blkaddr, CPT_AF_LFX_CTL2(cptlf));
+
+	ret = rvu_lf_reset(rvu, block, cptlf);
+	if (ret)
+		dev_err(rvu->dev, "Failed to reset blkaddr %d LF%d\n",
+			block->addr, cptlf);
+
+	rvu_write64(rvu, blkaddr, CPT_AF_LFX_CTL(cptlf), ctl);
+	rvu_write64(rvu, blkaddr, CPT_AF_LFX_CTL2(cptlf), ctl2);
+
+	return 0;
+}
+
 static void cpt_rxc_teardown(struct rvu *rvu, int blkaddr)
 {
 	struct cpt_rxc_time_cfg_req req;
-- 
2.43.0


