Return-Path: <linux-kernel+bounces-14216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1244821946
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367A71F2230B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1ECA68;
	Tue,  2 Jan 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dksuIRZo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A5D267;
	Tue,  2 Jan 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4025LBJ2008070;
	Tue, 2 Jan 2024 01:56:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=FTSpJy0A
	q4rFJvL4roKCciWgRvUmm3i6wq1eB/Y9HcE=; b=dksuIRZo7Fg8IamY04T/IbDa
	ipgXXac7gRUgzN7NwjVa8I4fjHa0JHhacZS4GVi9bLKZMNDR/3GQlaH/yDu1Dwl2
	WXuDs7zD2f+H+JKHriO03WwqUV5OVUn9HQmiCHb451hD+3+/WGNVCvBEEKKhDr5p
	Eo8vlt/pPt3yJ1jXlByv1wYEhwVV/JKc0MOkchYfy+T56HiOqtVJOO7h135CW1+w
	kHAy4fv8/GecbE5v4uXiQNAGXf1St2IKPFdWcw8gVLCLTk8aI2zFj+wn3965nK7J
	TMzOzwPeerozw7OGsKq8VWbBnW5vWEnhpfCxQGrkhq5h+BZv+u4R+WjSx5IKDA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vcc908kqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 01:56:53 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 2 Jan
 2024 01:56:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 2 Jan 2024 01:56:48 -0800
Received: from #hyd1583.marvell.com (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 234A63F7080;
	Tue,  2 Jan 2024 01:56:44 -0800 (PST)
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Naveen Mamindlapalli <naveenm@marvell.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: [net PATCH] octeontx2-af: Always configure NIX TX link credits based on max frame size
Date: Tue, 2 Jan 2024 15:26:43 +0530
Message-ID: <20240102095643.25296-1-naveenm@marvell.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZOxB7fPrklyLKuI25OwHv2wael--o0rf
X-Proofpoint-GUID: ZOxB7fPrklyLKuI25OwHv2wael--o0rf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Currently the NIX TX link credits are initialized based on the max frame
size that can be transmitted on a link but when the MTU is changed, the
NIX TX link credits are reprogrammed by the SW based on the new MTU value.
Since SMQ max packet length is programmed to max frame size by default,
there is a chance that NIX TX may stall while sending a max frame sized
packet on the link with insufficient credits to send the packet all at
once. This patch avoids stall issue by not changing the link credits
dynamically when the MTU is changed.

Fixes: 1c74b89171c3 ("octeontx2-af: Wait for TX link idle for credits change")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 110 +-----------------
 1 file changed, 3 insertions(+), 107 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 4227ebb4a758..2b6ab748ce25 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4143,90 +4143,18 @@ static void nix_find_link_frs(struct rvu *rvu,
 		req->minlen = minlen;
 }
 
-static int
-nix_config_link_credits(struct rvu *rvu, int blkaddr, int link,
-			u16 pcifunc, u64 tx_credits)
-{
-	struct rvu_hwinfo *hw = rvu->hw;
-	int pf = rvu_get_pf(pcifunc);
-	u8 cgx_id = 0, lmac_id = 0;
-	unsigned long poll_tmo;
-	bool restore_tx_en = 0;
-	struct nix_hw *nix_hw;
-	u64 cfg, sw_xoff = 0;
-	u32 schq = 0;
-	u32 credits;
-	int rc;
-
-	nix_hw = get_nix_hw(rvu->hw, blkaddr);
-	if (!nix_hw)
-		return NIX_AF_ERR_INVALID_NIXBLK;
-
-	if (tx_credits == nix_hw->tx_credits[link])
-		return 0;
-
-	/* Enable cgx tx if disabled for credits to be back */
-	if (is_pf_cgxmapped(rvu, pf)) {
-		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
-		restore_tx_en = !rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu),
-						    lmac_id, true);
-	}
-
-	mutex_lock(&rvu->rsrc_lock);
-	/* Disable new traffic to link */
-	if (hw->cap.nix_shaping) {
-		schq = nix_get_tx_link(rvu, pcifunc);
-		sw_xoff = rvu_read64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq));
-		rvu_write64(rvu, blkaddr,
-			    NIX_AF_TL1X_SW_XOFF(schq), BIT_ULL(0));
-	}
-
-	rc = NIX_AF_ERR_LINK_CREDITS;
-	poll_tmo = jiffies + usecs_to_jiffies(200000);
-	/* Wait for credits to return */
-	do {
-		if (time_after(jiffies, poll_tmo))
-			goto exit;
-		usleep_range(100, 200);
-
-		cfg = rvu_read64(rvu, blkaddr,
-				 NIX_AF_TX_LINKX_NORM_CREDIT(link));
-		credits = (cfg >> 12) & 0xFFFFFULL;
-	} while (credits != nix_hw->tx_credits[link]);
-
-	cfg &= ~(0xFFFFFULL << 12);
-	cfg |= (tx_credits << 12);
-	rvu_write64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link), cfg);
-	rc = 0;
-
-	nix_hw->tx_credits[link] = tx_credits;
-
-exit:
-	/* Enable traffic back */
-	if (hw->cap.nix_shaping && !sw_xoff)
-		rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq), 0);
-
-	/* Restore state of cgx tx */
-	if (restore_tx_en)
-		rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu), lmac_id, false);
-
-	mutex_unlock(&rvu->rsrc_lock);
-	return rc;
-}
-
 int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 				    struct msg_rsp *rsp)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
 	int pf = rvu_get_pf(pcifunc);
-	int blkaddr, schq, link = -1;
-	struct nix_txsch *txsch;
-	u64 cfg, lmac_fifo_len;
+	int blkaddr, link = -1;
 	struct nix_hw *nix_hw;
 	struct rvu_pfvf *pfvf;
 	u8 cgx = 0, lmac = 0;
 	u16 max_mtu;
+	u64 cfg;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	if (blkaddr < 0)
@@ -4247,25 +4175,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (req->update_minlen && req->minlen < NIC_HW_MIN_FRS)
 		return NIX_AF_ERR_FRS_INVALID;
 
-	/* Check if requester wants to update SMQ's */
-	if (!req->update_smq)
-		goto rx_frscfg;
-
-	/* Update min/maxlen in each of the SMQ attached to this PF/VF */
-	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_SMQ];
-	mutex_lock(&rvu->rsrc_lock);
-	for (schq = 0; schq < txsch->schq.max; schq++) {
-		if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
-			continue;
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq));
-		cfg = (cfg & ~(0xFFFFULL << 8)) | ((u64)req->maxlen << 8);
-		if (req->update_minlen)
-			cfg = (cfg & ~0x7FULL) | ((u64)req->minlen & 0x7F);
-		rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq), cfg);
-	}
-	mutex_unlock(&rvu->rsrc_lock);
-
-rx_frscfg:
 	/* Check if config is for SDP link */
 	if (req->sdp_link) {
 		if (!hw->sdp_links)
@@ -4288,7 +4197,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-
 linkcfg:
 	nix_find_link_frs(rvu, req, pcifunc);
 
@@ -4298,19 +4206,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 		cfg = (cfg & ~0xFFFFULL) | req->minlen;
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link), cfg);
 
-	if (req->sdp_link || pf == 0)
-		return 0;
-
-	/* Update transmit credits for CGX links */
-	lmac_fifo_len = rvu_cgx_get_lmac_fifolen(rvu, cgx, lmac);
-	if (!lmac_fifo_len) {
-		dev_err(rvu->dev,
-			"%s: Failed to get CGX/RPM%d:LMAC%d FIFO size\n",
-			__func__, cgx, lmac);
-		return 0;
-	}
-	return nix_config_link_credits(rvu, blkaddr, link, pcifunc,
-				       (lmac_fifo_len - req->maxlen) / 16);
+	return 0;
 }
 
 int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
-- 
2.39.0.198.ga38d39a4c5


