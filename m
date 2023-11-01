Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C447DDD74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjKAHuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjKAHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:50:02 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243B101;
        Wed,  1 Nov 2023 00:49:55 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A144Qdi017803;
        Wed, 1 Nov 2023 00:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=SM2epVf6nDHb8xWPQceLmBlNM1r/lEggltHtY9bgEEc=;
 b=ia2ete46676/4j68Uqtxx8MT3B0oIlSwsfAMPBylfxPyRcIYKQcoE422rbocrCvlLIPc
 3xtzNOoCU3M0iS2gCl+2dc922mqEk3Pvz2kPyTYUgE0MCUgkCUUs/OoB2kJTCYQY9bsT
 HUQ+QuALLL4g1P73TlPxDM3Eb6UXuBH+G0YHZPduYhRcVLmHOgc15kK3TITdw2s6MFui
 hrXlbol21HRGc5gBF72L7XeqguoVykQRrqLiv+L0tjexbigpiEzOQuMYeT/hiJYXX6ox
 OykS2O85KFmMr2B7C2E4Y0ELdiexCrEVmQQqDgSB1HZXGgTeylWCrE2ZwGZzqGv0mzCZ ng== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3u11tper0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 00:49:46 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 1 Nov
 2023 00:49:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 1 Nov 2023 00:49:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 603363F70BF;
        Wed,  1 Nov 2023 00:49:23 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [net PATCH] octeontx2: Fix klockwork and coverity issues
Date:   Wed, 1 Nov 2023 13:19:19 +0530
Message-ID: <20231101074919.2614608-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RKjGHjhU5FgotjBfbdsW46e28xIQNHV1
X-Proofpoint-ORIG-GUID: RKjGHjhU5FgotjBfbdsW46e28xIQNHV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_05,2023-10-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all klockwork and coverity issues reported on AF and PF/VF driver.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 14 ++++-
 .../marvell/octeontx2/af/mcs_rvu_if.c         |  8 ++-
 .../net/ethernet/marvell/octeontx2/af/ptp.c   | 11 +++-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   |  2 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 ++-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  2 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  2 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  8 +--
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  3 +
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h | 55 ++++++++++---------
 .../marvell/octeontx2/nic/otx2_txrx.c         |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |  7 ++-
 12 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 6c70c8498690..5a672888577e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -457,12 +457,19 @@ int cgx_lmac_addr_max_entries_get(u8 cgx_id, u8 lmac_id)
 u64 cgx_lmac_addr_get(u8 cgx_id, u8 lmac_id)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
-	struct lmac *lmac = lmac_pdata(lmac_id, cgx_dev);
 	struct mac_ops *mac_ops;
+	struct lmac *lmac;
 	int index;
 	u64 cfg;
 	int id;
 
+	if (!cgx_dev)
+		return 0;
+
+	lmac = lmac_pdata(lmac_id, cgx_dev);
+	if (!lmac)
+		return 0;
+
 	mac_ops = cgx_dev->mac_ops;
 
 	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
@@ -955,6 +962,9 @@ int cgx_lmac_pfc_config(void *cgxd, int lmac_id, u8 tx_pause,
 
 	/* Write source MAC address which will be filled into PFC packet */
 	cfg = cgx_lmac_addr_get(cgx->cgx_id, lmac_id);
+	if (!cfg)
+		return -ENODEV;
+
 	cgx_write(cgx, lmac_id, CGXX_SMUX_SMAC, cfg);
 
 	return 0;
@@ -1617,7 +1627,7 @@ unsigned long cgx_get_lmac_bmap(void *cgxd)
 static int cgx_lmac_init(struct cgx *cgx)
 {
 	struct lmac *lmac;
-	u64 lmac_list;
+	u64 lmac_list = 0;
 	int i, err;
 
 	/* lmac_list specifies which lmacs are enabled
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
index dfd23580e3b8..1b0b022f5493 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c
@@ -625,8 +625,8 @@ int rvu_mbox_handler_mcs_free_resources(struct rvu *rvu,
 {
 	u16 pcifunc = req->hdr.pcifunc;
 	struct mcs_rsrc_map *map;
+	int rc = -EINVAL;
 	struct mcs *mcs;
-	int rc = 0;
 
 	if (req->mcs_id >= rvu->mcs_blk_cnt)
 		return MCS_AF_ERR_INVALID_MCSID;
@@ -675,8 +675,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 {
 	u16 pcifunc = req->hdr.pcifunc;
 	struct mcs_rsrc_map *map;
+	int rsrc_id = -EINVAL, i;
 	struct mcs *mcs;
-	int rsrc_id, i;
 
 	if (req->mcs_id >= rvu->mcs_blk_cnt)
 		return MCS_AF_ERR_INVALID_MCSID;
@@ -737,6 +737,8 @@ int rvu_mbox_handler_mcs_alloc_resources(struct rvu *rvu,
 			rsp->rsrc_cnt++;
 		}
 		break;
+	default:
+		goto exit;
 	}
 
 	rsp->rsrc_type = req->rsrc_type;
@@ -849,7 +851,7 @@ int rvu_mbox_handler_mcs_ctrl_pkt_rule_write(struct rvu *rvu,
 static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
 {
 	struct mcs *mcs = mcs_get_pdata(0);
-	unsigned long lmac_bmap;
+	unsigned long lmac_bmap = 0;
 	int cgx, lmac, port;
 
 	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index bcc96eed2481..a199b1123ba7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -518,6 +518,7 @@ static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
 	struct ptp *ptp;
+	void __iomem * const *base;
 	int err;
 
 	ptp = kzalloc(sizeof(*ptp), GFP_KERNEL);
@@ -536,7 +537,15 @@ static int ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	ptp->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	base = pcim_iomap_table(pdev);
+	if (!base)
+		goto error_free;
+
+	ptp->reg_base = base[PCI_PTP_BAR_NO];
+	if (!ptp->reg_base) {
+		err = -ENODEV;
+		goto error_free;
+	}
 
 	pci_set_drvdata(pdev, ptp);
 	if (!first_ptp_block)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..a1a919fcda47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -43,7 +43,7 @@ static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
 	u64 reg, val;
-	int i, eng;
+	int i, eng = 0;
 	u8 grp;
 
 	reg = rvu_read64(rvu, blkaddr, CPT_AF_FLTX_INT(vec));
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index bd817ee88735..307942ff1b10 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -519,12 +519,16 @@ RVU_DEBUG_SEQ_FOPS(mcs_rx_secy_stats, mcs_rx_secy_stats_display, NULL);
 static void rvu_dbg_mcs_init(struct rvu *rvu)
 {
 	struct mcs *mcs;
-	char dname[10];
+	char *dname = NULL;
 	int i;
 
 	if (!rvu->mcs_blk_cnt)
 		return;
 
+	dname = kmalloc_array(rvu->mcs_blk_cnt, sizeof(char), GFP_KERNEL);
+	if (!dname)
+		return;
+
 	rvu->rvu_dbg.mcs_root = debugfs_create_dir("mcs", rvu->rvu_dbg.root);
 
 	for (i = 0; i < rvu->mcs_blk_cnt; i++) {
@@ -568,6 +572,8 @@ static void rvu_dbg_mcs_init(struct rvu *rvu)
 		debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_tx, mcs,
 				    &rvu_dbg_mcs_tx_port_stats_fops);
 	}
+
+	kfree(dname);
 }
 
 #define LMT_MAPTBL_ENTRY_SIZE 16
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 23c2f2ed2fb8..2fa2ef970e88 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5033,7 +5033,7 @@ static void nix_inline_ipsec_cfg(struct rvu *rvu, struct nix_inline_ipsec_cfg *r
 				 int blkaddr)
 {
 	u8 cpt_idx, cpt_blkaddr;
-	u64 val;
+	u64 val = 0;
 
 	cpt_idx = (blkaddr == BLKADDR_NIX0) ? 0 : 1;
 	if (req->enable) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 16cfc802e348..b25ecd36ca61 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -1734,8 +1734,8 @@ static void npc_load_kpu_profile(struct rvu *rvu)
 				rvu->kpu_prfl_addr = NULL;
 			} else {
 				kfree(rvu->kpu_fwdata);
+				rvu->kpu_fwdata = NULL;
 			}
-			rvu->kpu_fwdata = NULL;
 			rvu->kpu_fwdata_sz = 0;
 			if (retry_fwdb) {
 				retry_fwdb = false;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 1a42bfded872..628251e940e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -648,14 +648,14 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 	} else if (lvl == NIX_TXSCH_LVL_TL4) {
 		parent = schq_list[NIX_TXSCH_LVL_TL3][prio];
 		req->reg[0] = NIX_AF_TL4X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL4X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
 	} else if (lvl == NIX_TXSCH_LVL_TL3) {
 		parent = schq_list[NIX_TXSCH_LVL_TL2][prio];
 		req->reg[0] = NIX_AF_TL3X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL3X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
@@ -670,11 +670,11 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 	} else if (lvl == NIX_TXSCH_LVL_TL2) {
 		parent = schq_list[NIX_TXSCH_LVL_TL1][prio];
 		req->reg[0] = NIX_AF_TL2X_PARENT(schq);
-		req->regval[0] = parent << 16;
+		req->regval[0] = (u64)parent << 16;
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL2X_SCHEDULE(schq);
-		req->regval[1] = TXSCH_TL1_DFLT_RR_PRIO << 24 | dwrr_val;
+		req->regval[1] = (u64)hw->txschq_aggr_lvl_rr_prio << 24 | dwrr_val;
 
 		if (lvl == hw->txschq_link_cfg_lvl) {
 			req->num_regs++;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6daf4d58c25d..62702ff6f3ea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -496,6 +496,9 @@ static void otx2_pfvf_mbox_handler(struct work_struct *work)
 	return;
 
 inval_msg:
+	if (!msg)
+		return;
+
 	otx2_reply_invalid_msg(mbox, vf_idx, 0, msg->id);
 	otx2_mbox_msg_send(mbox, vf_idx);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 45a32e4b49d1..e3aee6e36215 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -139,33 +139,34 @@
 #define	NIX_LF_CINTX_ENA_W1C(a)		(NIX_LFBASE | 0xD50 | (a) << 12)
 
 /* NIX AF transmit scheduler registers */
-#define NIX_AF_SMQX_CFG(a)		(0x700 | (a) << 16)
-#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (a) << 16)
-#define NIX_AF_TL1X_CIR(a)		(0xC20 | (a) << 16)
-#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (a) << 16)
-#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (a) << 16)
-#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (a) << 16)
-#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (a) << 16)
-#define NIX_AF_TL2X_CIR(a)              (0xE20 | (a) << 16)
-#define NIX_AF_TL2X_PIR(a)              (0xE30 | (a) << 16)
-#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (a) << 16)
-#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (a) << 16)
-#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (a) << 16)
-#define NIX_AF_TL3X_CIR(a)		(0x1020 | (a) << 16)
-#define NIX_AF_TL3X_PIR(a)		(0x1030 | (a) << 16)
-#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (a) << 16)
-#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (a) << 16)
-#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (a) << 16)
-#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (a) << 16)
-#define NIX_AF_TL4X_CIR(a)		(0x1220 | (a) << 16)
-#define NIX_AF_TL4X_PIR(a)		(0x1230 | (a) << 16)
-#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (a) << 16)
-#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (a) << 16)
-#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (a) << 16)
-#define NIX_AF_MDQX_CIR(a)		(0x1420 | (a) << 16)
-#define NIX_AF_MDQX_PIR(a)		(0x1430 | (a) << 16)
-#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (a) << 16)
-#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (a) << 16 | (b) << 3)
+#define NIX_AF_SMQX_CFG(a)		(0x700 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SDP_LINK_CFG(a)	(0xB10 | (u64)(a) << 16)
+#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (u64)(a) << 16)
+#define NIX_AF_TL1X_CIR(a)		(0xC20 | (u64)(a) << 16)
+#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (u64)(a) << 16)
+#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (u64)(a) << 16)
+#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (u64)(a) << 16)
+#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (u64)(a) << 16)
+#define NIX_AF_TL2X_CIR(a)		(0xE20 | (u64)(a) << 16)
+#define NIX_AF_TL2X_PIR(a)		(0xE30 | (u64)(a) << 16)
+#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (u64)(a) << 16)
+#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (u64)(a) << 16)
+#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (u64)(a) << 16)
+#define NIX_AF_TL3X_CIR(a)		(0x1020 | (u64)(a) << 16)
+#define NIX_AF_TL3X_PIR(a)		(0x1030 | (u64)(a) << 16)
+#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (u64)(a) << 16)
+#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (u64)(a) << 16)
+#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (u64)(a) << 16)
+#define NIX_AF_TL4X_CIR(a)		(0x1220 | (u64)(a) << 16)
+#define NIX_AF_TL4X_PIR(a)		(0x1230 | (u64)(a) << 16)
+#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (u64)(a) << 16)
+#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (u64)(a) << 16)
+#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (u64)(a) << 16)
+#define NIX_AF_MDQX_CIR(a)		(0x1420 | (u64)(a) << 16)
+#define NIX_AF_MDQX_PIR(a)		(0x1430 | (u64)(a) << 16)
+#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (u64)(a) << 16)
+#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (u64)(a) << 16 | (b) << 3)
 
 /* LMT LF registers */
 #define LMT_LFBASE			BIT_ULL(RVU_FUNC_BLKADDR_SHIFT)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 53b2a4ef5298..04a462b3e638 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -510,7 +510,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 static void otx2_adjust_adaptive_coalese(struct otx2_nic *pfvf, struct otx2_cq_poll *cq_poll)
 {
-	struct dim_sample dim_sample;
+	struct dim_sample dim_sample = { 0 };
 	u64 rx_frames, rx_bytes;
 
 	rx_frames = OTX2_GET_RX_STATS(RX_BCAST) + OTX2_GET_RX_STATS(RX_MCAST) +
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 1e77bbf5d22a..7b23120a3e60 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -153,7 +153,6 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 		num_regs++;
 
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
-
 	} else if (level == NIX_TXSCH_LVL_TL4) {
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
 	} else if (level == NIX_TXSCH_LVL_TL3) {
@@ -528,6 +527,7 @@ otx2_qos_sw_create_leaf_node(struct otx2_nic *pfvf,
 	err = otx2_qos_add_child_node(parent, node);
 	if (err) {
 		mutex_unlock(&pfvf->qos.qos_lock);
+		kfree(node);
 		return ERR_PTR(err);
 	}
 	mutex_unlock(&pfvf->qos.qos_lock);
@@ -1028,8 +1028,9 @@ static int otx2_qos_root_add(struct otx2_nic *pfvf, u16 htb_maj_id, u16 htb_defc
 	new_cfg = kzalloc(sizeof(*new_cfg), GFP_KERNEL);
 	if (!new_cfg) {
 		NL_SET_ERR_MSG_MOD(extack, "Memory allocation error");
-		err = -ENOMEM;
-		goto free_root_node;
+		otx2_qos_sw_node_delete(pfvf, root);
+		mutex_destroy(&pfvf->qos.qos_lock);
+		return -ENOMEM;
 	}
 	/* allocate htb root node */
 	new_cfg->schq[root->level] = 1;
-- 
2.25.1

