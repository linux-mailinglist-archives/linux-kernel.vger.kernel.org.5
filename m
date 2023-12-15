Return-Path: <linux-kernel+bounces-893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4481478E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D2C1F21ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5428DDD;
	Fri, 15 Dec 2023 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="abbT9bxI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377232C865;
	Fri, 15 Dec 2023 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF9ectE000660;
	Fri, 15 Dec 2023 04:01:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=e8Wj5dnD
	ytfit1K+JFRaEPgFmyfOIEMx7SyXJrlNV50=; b=abbT9bxIoH8D/Iq5HO0EaZAk
	dfNd6sWhUx0kxoNioDkXmVu2dV5aReF+eXC3om5ZT2ZMu3vCWJX0oqfvcLE/N/bA
	4/Tou+g7Jj1hkVvWdtaX6wJR/FHqHmaPQ6LXQmKUSGoJjPPuUxW0sjzPqqYplBdn
	Smfm5iSmN+5ElHR+YBGyEmiIB5P1yOaNMDuETmcMNDUYm+IC0IcPDWX4fqyKqyWN
	f60nhKfI2V6xfN7t2I6uhUzAbLLWQQLZp39h0+xzR4HauoTZtO88aYfBJuCOVy+p
	lmQSUPtWsbeeVXBUPejrFtKyRvrtjkG49W+vlv0YGnnwVY89TIBno0+r4Cqmbw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v0mckrbft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 04:01:57 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 15 Dec
 2023 04:01:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 15 Dec 2023 04:01:55 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id A0C6F3F70BD;
	Fri, 15 Dec 2023 04:01:51 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs
Date: Fri, 15 Dec 2023 17:31:49 +0530
Message-ID: <20231215120149.160122-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FZ-WBl7pAfArgmfqykTHZDY7xrTFK1G2
X-Proofpoint-GUID: FZ-WBl7pAfArgmfqykTHZDY7xrTFK1G2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

On some silicon variants the number of available CAM entries are
less. Reserving one entry for each NIX-LF for default DMAC based pkt
forwarding rules will reduce the number of available CAM entries
further. Hence add configurability via devlink to set maximum number of
NIX-LFs needed which inturn frees up some CAM entries.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  2 +
 .../marvell/octeontx2/af/rvu_devlink.c        | 80 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 75 +++++++++++------
 3 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 1f3ff4bb8753..6446dc389989 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -949,6 +949,8 @@ int npc_install_mcam_drop_rule(struct rvu *rvu, int mcam_idx, u16 *counter_idx,
 			       u64 bcast_mcast_val, u64 bcast_mcast_mask);
 void npc_mcam_rsrcs_reserve(struct rvu *rvu, int blkaddr, int entry_idx);
 bool npc_is_feature_supported(struct rvu *rvu, u64 features, u8 intf);
+int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr);
+void npc_mcam_rsrcs_deinit(struct rvu *rvu);
 
 /* CPT APIs */
 int rvu_cpt_register_interrupts(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 21b5d71c1e37..bb5fdb225dab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1237,6 +1237,7 @@ enum rvu_af_dl_param_id {
 	RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_EXACT_FEATURE_DISABLE,
 	RVU_AF_DEVLINK_PARAM_ID_NPC_MCAM_ZONE_PERCENT,
+	RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
 };
 
 static int rvu_af_npc_exact_feature_get(struct devlink *devlink, u32 id,
@@ -1354,6 +1355,79 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
 	return 0;
 }
 
+static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
+				   struct devlink_param_gset_ctx *ctx)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+
+	ctx->val.vu16 = (u16)rvu_get_nixlf_count(rvu);
+
+	return 0;
+}
+
+static int rvu_af_dl_nix_maxlf_set(struct devlink *devlink, u32 id,
+				   struct devlink_param_gset_ctx *ctx)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	struct rvu_block *block;
+	int blkaddr = 0;
+
+	npc_mcam_rsrcs_deinit(rvu);
+	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
+	while (blkaddr) {
+		block = &rvu->hw->block[blkaddr];
+		block->lf.max = ctx->val.vu16;
+		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
+	}
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	npc_mcam_rsrcs_init(rvu, blkaddr);
+
+	return 0;
+}
+
+static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
+					union devlink_param_value val,
+					struct netlink_ext_ack *extack)
+{
+	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
+	struct rvu *rvu = rvu_dl->rvu;
+	u16 max_nix0_lf, max_nix1_lf;
+	struct npc_mcam *mcam;
+	u64 cfg;
+
+	cfg = rvu_read64(rvu, BLKADDR_NIX0, NIX_AF_CONST2);
+	max_nix0_lf = cfg & 0xFFF;
+	cfg = rvu_read64(rvu, BLKADDR_NIX1, NIX_AF_CONST2);
+	max_nix1_lf = cfg & 0xFFF;
+
+	/* Do not allow user to modify maximum NIX LFs while mcam entries
+	 * have already been assigned.
+	 */
+	mcam = &rvu->hw->mcam;
+	if (mcam->bmap_fcnt < mcam->bmap_entries) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "mcam entries have already been assigned, can't resize");
+		return -EPERM;
+	}
+
+	if (max_nix0_lf && val.vu16 > max_nix0_lf) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "requested nixlf is greater than the max supported nix0_lf");
+		return -EPERM;
+	}
+
+	if (max_nix1_lf && val.vu16 > max_nix1_lf) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "requested nixlf is greater than the max supported nix1_lf");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct devlink_param rvu_af_dl_params[] = {
 	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_DWRR_MTU,
 			     "dwrr_mtu", DEVLINK_PARAM_TYPE_U32,
@@ -1375,6 +1449,12 @@ static const struct devlink_param rvu_af_dl_param_exact_match[] = {
 			     rvu_af_dl_npc_mcam_high_zone_percent_get,
 			     rvu_af_dl_npc_mcam_high_zone_percent_set,
 			     rvu_af_dl_npc_mcam_high_zone_percent_validate),
+	DEVLINK_PARAM_DRIVER(RVU_AF_DEVLINK_PARAM_ID_NIX_MAXLF,
+			     "nix_maxlf", DEVLINK_PARAM_TYPE_U16,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     rvu_af_dl_nix_maxlf_get,
+			     rvu_af_dl_nix_maxlf_set,
+			     rvu_af_dl_nix_maxlf_validate),
 };
 
 /* Devlink switch mode */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 2897a8b8e558..513c4fe86967 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1846,7 +1846,21 @@ static void npc_parser_profile_init(struct rvu *rvu, int blkaddr)
 		npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
 }
 
-static int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
+void npc_mcam_rsrcs_deinit(struct rvu *rvu)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+
+	kfree(mcam->bmap);
+	kfree(mcam->bmap_reverse);
+	kfree(mcam->entry2pfvf_map);
+	kfree(mcam->cntr2pfvf_map);
+	kfree(mcam->entry2cntr_map);
+	kfree(mcam->cntr_refcnt);
+	kfree(mcam->entry2target_pffunc);
+	kfree(mcam->counters.bmap);
+}
+
+int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 {
 	int nixlf_count = rvu_get_nixlf_count(rvu);
 	struct npc_mcam *mcam = &rvu->hw->mcam;
@@ -1890,24 +1904,23 @@ static int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
 
 	/* Allocate bitmaps for managing MCAM entries */
-	mcam->bmap = devm_kcalloc(rvu->dev, BITS_TO_LONGS(mcam->bmap_entries),
-				  sizeof(long), GFP_KERNEL);
+	mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
+				   sizeof(long), GFP_KERNEL);
 	if (!mcam->bmap)
 		return -ENOMEM;
 
-	mcam->bmap_reverse = devm_kcalloc(rvu->dev,
-					  BITS_TO_LONGS(mcam->bmap_entries),
-					  sizeof(long), GFP_KERNEL);
+	mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
+					   sizeof(long), GFP_KERNEL);
 	if (!mcam->bmap_reverse)
-		return -ENOMEM;
+		goto free_bmap;
 
 	mcam->bmap_fcnt = mcam->bmap_entries;
 
 	/* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
-	mcam->entry2pfvf_map = devm_kcalloc(rvu->dev, mcam->bmap_entries,
-					    sizeof(u16), GFP_KERNEL);
+	mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
+					     sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2pfvf_map)
-		return -ENOMEM;
+		goto free_bmap_reverse;
 
 	/* Reserve 1/8th of MCAM entries at the bottom for low priority
 	 * allocations and another 1/8th at the top for high priority
@@ -1926,31 +1939,31 @@ static int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 	 */
 	err = rvu_alloc_bitmap(&mcam->counters);
 	if (err)
-		return err;
+		goto free_entry_map;
 
-	mcam->cntr2pfvf_map = devm_kcalloc(rvu->dev, mcam->counters.max,
-					   sizeof(u16), GFP_KERNEL);
+	mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
+					    sizeof(u16), GFP_KERNEL);
 	if (!mcam->cntr2pfvf_map)
-		goto free_mem;
+		goto free_cntr_bmap;
 
 	/* Alloc memory for MCAM entry to counter mapping and for tracking
 	 * counter's reference count.
 	 */
-	mcam->entry2cntr_map = devm_kcalloc(rvu->dev, mcam->bmap_entries,
-					    sizeof(u16), GFP_KERNEL);
+	mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
+					     sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2cntr_map)
-		goto free_mem;
+		goto free_cntr_map;
 
-	mcam->cntr_refcnt = devm_kcalloc(rvu->dev, mcam->counters.max,
-					 sizeof(u16), GFP_KERNEL);
+	mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
+					  sizeof(u16), GFP_KERNEL);
 	if (!mcam->cntr_refcnt)
-		goto free_mem;
+		goto free_entry_cntr_map;
 
 	/* Alloc memory for saving target device of mcam rule */
-	mcam->entry2target_pffunc = devm_kcalloc(rvu->dev, mcam->total_entries,
-						 sizeof(u16), GFP_KERNEL);
+	mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
+						  sizeof(u16), GFP_KERNEL);
 	if (!mcam->entry2target_pffunc)
-		goto free_mem;
+		goto free_cntr_refcnt;
 
 	for (index = 0; index < mcam->bmap_entries; index++) {
 		mcam->entry2pfvf_map[index] = NPC_MCAM_INVALID_MAP;
@@ -1964,8 +1977,21 @@ static int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
 
 	return 0;
 
-free_mem:
+free_cntr_refcnt:
+	kfree(mcam->cntr_refcnt);
+free_entry_cntr_map:
+	kfree(mcam->entry2cntr_map);
+free_cntr_map:
+	kfree(mcam->cntr2pfvf_map);
+free_cntr_bmap:
+	kfree(mcam->counters.bmap);
+free_entry_map:
+	kfree(mcam->entry2pfvf_map);
+free_bmap_reverse:
+	kfree(mcam->bmap_reverse);
+free_bmap:
 	kfree(mcam->counters.bmap);
+
 	return -ENOMEM;
 }
 
@@ -2173,6 +2199,7 @@ void rvu_npc_freemem(struct rvu *rvu)
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 
 	kfree(pkind->rsrc.bmap);
+	npc_mcam_rsrcs_deinit(rvu);
 	kfree(mcam->counters.bmap);
 	if (rvu->kpu_prfl_addr)
 		iounmap(rvu->kpu_prfl_addr);
-- 
2.25.1


