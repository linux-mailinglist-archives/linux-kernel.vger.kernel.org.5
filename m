Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4F7EDE4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345023AbjKPKQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjKPKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:16:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC719E;
        Thu, 16 Nov 2023 02:16:25 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG9AvW2007353;
        Thu, 16 Nov 2023 02:16:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=RgyItddmJ09vEOz3IEXinlZ4v0hBVHqUIS1pzyMcA1Q=;
 b=UYf577XCJA1Tm6ZkYDqtUKT5Rr2wpHmgTxNa4hduObWOMPwbvVv97XnidlJOdQGwllxJ
 TWqWqZd+ohpvirQaislni3oShuvvXbBPA+Y32a0FF5ml4t9C/ZD6AMcrzFN42mgfpCqd
 dwGeRyOcf1YURxKIMU4X4v9tDpEKbPWvdStnTsg7Td5pmfDO53Sx5raR89AT0pRGvarm
 ad4M7UuHehgZYOkEkmi1jDDPzI0zxC7P1Yd6Fv3irEhLMrmXk+pGI2xz9gC/lfqf07jI
 CArxlgOhoMzauNPWNWUXteDM/cp70aEEn7hQwnKtWsnCzHHcGx1U9eaBn1eZHa9XvrTU 2w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uc5vmu5jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 02:16:17 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 02:16:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 16 Nov 2023 02:16:15 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 43D6D3F7085;
        Thu, 16 Nov 2023 02:16:11 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 1/2] octeontx2-af: Add new mbox to support multicast/mirror offload
Date:   Thu, 16 Nov 2023 15:46:00 +0530
Message-ID: <20231116101601.3188711-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116101601.3188711-1-sumang@marvell.com>
References: <20231116101601.3188711-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Tvkjy6WUjbTbCwVWPcD6b41FRzoQBM1W
X-Proofpoint-GUID: Tvkjy6WUjbTbCwVWPcD6b41FRzoQBM1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new mailbox is added to support offloading of multicast/mirror
functionality. The mailbox also supports dynamic updation of the
multicast/mirror list.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  64 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 686 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  66 +-
 6 files changed, 839 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 6845556581c3..a833507c449f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -304,6 +304,13 @@ M(NIX_BANDPROF_GET_HWINFO, 0x801f, nix_bandprof_get_hwinfo, msg_req,		\
 				nix_bandprof_get_hwinfo_rsp)		    \
 M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
 				msg_req, nix_inline_ipsec_cfg)		\
+M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
+				nix_mcast_grp_create_rsp)			\
+M(NIX_MCAST_GRP_DESTROY, 0x802c, nix_mcast_grp_destroy, nix_mcast_grp_destroy_req,	\
+				msg_rsp)					\
+M(NIX_MCAST_GRP_UPDATE, 0x802d, nix_mcast_grp_update,				\
+				nix_mcast_grp_update_req,			\
+				nix_mcast_grp_update_rsp)			\
 /* MCS mbox IDs (range 0xA000 - 0xBFFF) */					\
 M(MCS_ALLOC_RESOURCES,	0xa000, mcs_alloc_resources, mcs_alloc_rsrc_req,	\
 				mcs_alloc_rsrc_rsp)				\
@@ -830,6 +837,9 @@ enum nix_af_status {
 	NIX_AF_ERR_CQ_CTX_WRITE_ERR  = -429,
 	NIX_AF_ERR_AQ_CTX_RETRY_WRITE  = -430,
 	NIX_AF_ERR_LINK_CREDITS  = -431,
+	NIX_AF_ERR_INVALID_MCAST_GRP	= -436,
+	NIX_AF_ERR_INVALID_MCAST_DEL_REQ = -437,
+	NIX_AF_ERR_NON_CONTIG_MCE_LIST = -438,
 };
 
 /* For NIX RX vtag action  */
@@ -1204,6 +1214,60 @@ struct nix_bp_cfg_rsp {
 	u8	chan_cnt; /* Number of channel for which bpids are assigned */
 };
 
+struct nix_mcast_grp_create_req {
+	struct mbox_msghdr hdr;
+#define NIX_MCAST_INGRESS	0
+#define NIX_MCAST_EGRESS	1
+	u8 dir;
+	u8 reserved[11];
+	/* Reserving few bytes for future requirement */
+};
+
+struct nix_mcast_grp_create_rsp {
+	struct mbox_msghdr hdr;
+	/* This mcast_grp_idx should be passed during MCAM
+	 * write entry for multicast. AF will identify the
+	 * corresponding multicast table index associated
+	 * with the group id and program the same to MCAM entry.
+	 * This group id is also needed during group delete
+	 * and update request.
+	 */
+	u32 mcast_grp_idx;
+};
+
+struct nix_mcast_grp_destroy_req {
+	struct mbox_msghdr hdr;
+	/* Group id returned by nix_mcast_grp_create_rsp */
+	u32 mcast_grp_idx;
+};
+
+struct nix_mcast_grp_update_req {
+	struct mbox_msghdr hdr;
+	/* Group id returned by nix_mcast_grp_create_rsp */
+	u32 mcast_grp_idx;
+	/* Number of multicast/mirror entries requested */
+	u32 num_mce_entry;
+#define NIX_MCE_ENTRY_MAX 64
+#define NIX_RX_RQ	0
+#define NIX_RX_RSS	1
+	/* Receive queue or RSS index within pf_func */
+	u32 rq_rss_index[NIX_MCE_ENTRY_MAX];
+	/* pcifunc is required for both ingress and egress multicast */
+	u16 pcifunc[NIX_MCE_ENTRY_MAX];
+	/* channel is required for egress multicast */
+	u16 channel[NIX_MCE_ENTRY_MAX];
+#define NIX_MCAST_OP_ADD_ENTRY	0
+#define NIX_MCAST_OP_DEL_ENTRY	1
+	/* Destination type. 0:Receive queue, 1:RSS*/
+	u8 dest_type[NIX_MCE_ENTRY_MAX];
+	u8 op;
+};
+
+struct nix_mcast_grp_update_rsp {
+	struct mbox_msghdr hdr;
+	u32 mce_start_index;
+};
+
 /* Global NIX inline IPSec configuration */
 struct nix_inline_ipsec_cfg {
 	struct mbox_msghdr hdr;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 22c395c7d040..7cd98f013fde 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -156,7 +156,7 @@ int rvu_alloc_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc)
 	return start;
 }
 
-static void rvu_free_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc, int start)
+void rvu_free_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc, int start)
 {
 	if (!rsrc->bmap)
 		return;
@@ -2614,6 +2614,10 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	 * 2. Flush and reset SSO/SSOW
 	 * 3. Cleanup pools (NPA)
 	 */
+
+	/* Free multicast/mirror node associated with the 'pcifunc' */
+	rvu_nix_mcast_flr_free_entries(rvu, pcifunc);
+
 	rvu_blklf_teardown(rvu, pcifunc, BLKADDR_NIX0);
 	rvu_blklf_teardown(rvu, pcifunc, BLKADDR_NIX1);
 	rvu_blklf_teardown(rvu, pcifunc, BLKADDR_CPT0);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index c4d999ef5ab4..a3de437f309e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -116,11 +116,12 @@ struct rvu_block {
 };
 
 struct nix_mcast {
-	struct qmem	*mce_ctx;
-	struct qmem	*mcast_buf;
-	int		replay_pkind;
-	int		next_free_mce;
-	struct mutex	mce_lock; /* Serialize MCE updates */
+	struct qmem		*mce_ctx;
+	struct qmem		*mcast_buf;
+	int			replay_pkind;
+	struct rsrc_bmap	mce_counter[2];
+	/* Counters for both ingress and egress mcast lists */
+	struct mutex		mce_lock; /* Serialize MCE updates */
 };
 
 struct nix_mce_list {
@@ -129,6 +130,23 @@ struct nix_mce_list {
 	int			max;
 };
 
+struct nix_mcast_grp_elem {
+	struct nix_mce_list	mcast_mce_list;
+	u32			mcast_grp_idx;
+	u32			pcifunc;
+	int			mcam_index;
+	int			mce_start_index;
+	struct list_head	list;
+	u8			dir;
+};
+
+struct nix_mcast_grp {
+	struct list_head	mcast_grp_head;
+	int			count;
+	int			next_grp_index;
+	struct mutex		mcast_grp_lock; /* Serialize MCE updates */
+};
+
 /* layer metadata to uniquely identify a packet header field */
 struct npc_layer_mdata {
 	u8 lid;
@@ -339,6 +357,7 @@ struct nix_hw {
 	struct rvu *rvu;
 	struct nix_txsch txsch[NIX_TXSCH_LVL_CNT]; /* Tx schedulers */
 	struct nix_mcast mcast;
+	struct nix_mcast_grp mcast_grp;
 	struct nix_flowkey flowkey;
 	struct nix_mark_format mark_format;
 	struct nix_lso lso;
@@ -741,6 +760,7 @@ void rvu_free_rsrc(struct rsrc_bmap *rsrc, int id);
 bool is_rsrc_free(struct rsrc_bmap *rsrc, int id);
 int rvu_rsrc_free_count(struct rsrc_bmap *rsrc);
 int rvu_alloc_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc);
+void rvu_free_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc, int start);
 bool rvu_rsrc_check_contig(struct rsrc_bmap *rsrc, int nrsrc);
 u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
 int rvu_get_pf(u16 pcifunc);
@@ -847,6 +867,11 @@ u32 convert_dwrr_mtu_to_bytes(u8 dwrr_mtu);
 u32 convert_bytes_to_dwrr_mtu(u32 bytes);
 void rvu_nix_tx_tl2_cfg(struct rvu *rvu, int blkaddr, u16 pcifunc,
 			struct nix_txsch *txsch, bool enable);
+void rvu_nix_mcast_flr_free_entries(struct rvu *rvu, u16 pcifunc);
+int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc,
+				u32 mcast_grp_idx);
+int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
+				    u32 mcast_grp_idx, u16 mcam_index);
 
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
@@ -895,6 +920,10 @@ void npc_mcam_enable_flows(struct rvu *rvu, u16 target);
 void npc_mcam_disable_flows(struct rvu *rvu, u16 target);
 void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			   int blkaddr, int index, bool enable);
+u64 npc_get_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
+			int blkaddr, int index);
+void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
+			 int blkaddr, int index, u64 cfg);
 void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 int blkaddr, u16 src, struct mcam_entry *entry,
 			 u8 *intf, u8 *ena);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 23c2f2ed2fb8..e85ca66c5964 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -71,12 +71,19 @@ enum nix_makr_fmt_indexes {
 /* For now considering MC resources needed for broadcast
  * pkt replication only. i.e 256 HWVFs + 12 PFs.
  */
-#define MC_TBL_SIZE	MC_TBL_SZ_512
-#define MC_BUF_CNT	MC_BUF_CNT_128
+#define MC_TBL_SIZE	MC_TBL_SZ_2K
+#define MC_BUF_CNT	MC_BUF_CNT_1024
+
+#define MC_TX_MAX	2048
 
 struct mce {
 	struct hlist_node	node;
+	u32			rq_rss_index;
 	u16			pcifunc;
+	u16			channel;
+	u8			dest_type;
+	u8			is_active;
+	u8			reserved[2];
 };
 
 int rvu_get_next_nix_blkaddr(struct rvu *rvu, int blkaddr)
@@ -164,18 +171,33 @@ static void nix_mce_list_init(struct nix_mce_list *list, int max)
 	list->max = max;
 }
 
-static u16 nix_alloc_mce_list(struct nix_mcast *mcast, int count)
+static int nix_alloc_mce_list(struct nix_mcast *mcast, int count, u8 dir)
 {
+	struct rsrc_bmap *mce_counter;
 	int idx;
 
 	if (!mcast)
-		return 0;
+		return -EINVAL;
 
-	idx = mcast->next_free_mce;
-	mcast->next_free_mce += count;
+	mce_counter = &mcast->mce_counter[dir];
+	if (!rvu_rsrc_check_contig(mce_counter, count))
+		return -ENOSPC;
+
+	idx = rvu_alloc_rsrc_contig(mce_counter, count);
 	return idx;
 }
 
+static void nix_free_mce_list(struct nix_mcast *mcast, int count, int start, u8 dir)
+{
+	struct rsrc_bmap *mce_counter;
+
+	if (!mcast)
+		return;
+
+	mce_counter = &mcast->mce_counter[dir];
+	rvu_free_rsrc_contig(mce_counter, count, start);
+}
+
 struct nix_hw *get_nix_hw(struct rvu_hwinfo *hw, int blkaddr)
 {
 	int nix_blkaddr = 0, i = 0;
@@ -2955,7 +2977,8 @@ int rvu_mbox_handler_nix_vtag_cfg(struct rvu *rvu,
 }
 
 static int nix_blk_setup_mce(struct rvu *rvu, struct nix_hw *nix_hw,
-			     int mce, u8 op, u16 pcifunc, int next, bool eol)
+			     int mce, u8 op, u16 pcifunc, int next,
+			     int index, u8 mce_op, bool eol)
 {
 	struct nix_aq_enq_req aq_req;
 	int err;
@@ -2966,8 +2989,8 @@ static int nix_blk_setup_mce(struct rvu *rvu, struct nix_hw *nix_hw,
 	aq_req.qidx = mce;
 
 	/* Use RSS with RSS index 0 */
-	aq_req.mce.op = 1;
-	aq_req.mce.index = 0;
+	aq_req.mce.op = mce_op;
+	aq_req.mce.index = index;
 	aq_req.mce.eol = eol;
 	aq_req.mce.pf_func = pcifunc;
 	aq_req.mce.next = next;
@@ -2984,6 +3007,208 @@ static int nix_blk_setup_mce(struct rvu *rvu, struct nix_hw *nix_hw,
 	return 0;
 }
 
+static void nix_delete_mcast_mce_list(struct nix_mce_list *mce_list)
+{
+	struct hlist_node *tmp;
+	struct mce *mce;
+
+	/* Scan through the current list */
+	hlist_for_each_entry_safe(mce, tmp, &mce_list->head, node) {
+		hlist_del(&mce->node);
+		kfree(mce);
+	}
+
+	mce_list->count = 0;
+	mce_list->max = 0;
+}
+
+static int nix_get_last_mce_list_index(struct nix_mcast_grp_elem *elem)
+{
+	return elem->mce_start_index + elem->mcast_mce_list.count - 1;
+}
+
+static int nix_update_ingress_mce_list_hw(struct rvu *rvu,
+					  struct nix_hw *nix_hw,
+					  struct nix_mcast_grp_elem *elem)
+{
+	int idx, last_idx, next_idx, err;
+	struct nix_mce_list *mce_list;
+	struct mce *mce, *prev_mce;
+
+	mce_list = &elem->mcast_mce_list;
+	idx = elem->mce_start_index;
+	last_idx = nix_get_last_mce_list_index(elem);
+	hlist_for_each_entry(mce, &mce_list->head, node) {
+		if (idx > last_idx)
+			break;
+
+		if (!mce->is_active) {
+			if (idx == elem->mce_start_index) {
+				idx++;
+				prev_mce = mce;
+				elem->mce_start_index = idx;
+				continue;
+			} else if (idx == last_idx) {
+				err = nix_blk_setup_mce(rvu, nix_hw, idx - 1, NIX_AQ_INSTOP_WRITE,
+							prev_mce->pcifunc, next_idx,
+							prev_mce->rq_rss_index,
+							prev_mce->dest_type,
+							false);
+				if (err)
+					return err;
+
+				break;
+			}
+		}
+
+		next_idx = idx + 1;
+		/* EOL should be set in last MCE */
+		err = nix_blk_setup_mce(rvu, nix_hw, idx, NIX_AQ_INSTOP_WRITE,
+					mce->pcifunc, next_idx,
+					mce->rq_rss_index, mce->dest_type,
+					(next_idx > last_idx) ? true : false);
+		if (err)
+			return err;
+
+		idx++;
+		prev_mce = mce;
+	}
+
+	return 0;
+}
+
+static void nix_update_egress_mce_list_hw(struct rvu *rvu,
+					  struct nix_hw *nix_hw,
+					  struct nix_mcast_grp_elem *elem)
+{
+	struct nix_mce_list *mce_list;
+	int idx, last_idx, next_idx;
+	struct mce *mce, *prev_mce;
+	u64 regval;
+	u8 eol;
+
+	mce_list = &elem->mcast_mce_list;
+	idx = elem->mce_start_index;
+	last_idx = nix_get_last_mce_list_index(elem);
+	hlist_for_each_entry(mce, &mce_list->head, node) {
+		if (idx > last_idx)
+			break;
+
+		if (!mce->is_active) {
+			if (idx == elem->mce_start_index) {
+				idx++;
+				prev_mce = mce;
+				elem->mce_start_index = idx;
+				continue;
+			} else if (idx == last_idx) {
+				regval = (next_idx << 16) | (1 << 12) | prev_mce->channel;
+				rvu_write64(rvu, nix_hw->blkaddr,
+					    NIX_AF_TX_MCASTX(idx - 1),
+					    regval);
+				break;
+			}
+		}
+
+		eol = 0;
+		next_idx = idx + 1;
+		/* EOL should be set in last MCE */
+		if (next_idx > last_idx)
+			eol = 1;
+
+		regval = (next_idx << 16) | (eol << 12) | mce->channel;
+		rvu_write64(rvu, nix_hw->blkaddr,
+			    NIX_AF_TX_MCASTX(idx),
+			    regval);
+		idx++;
+		prev_mce = mce;
+	}
+}
+
+static int nix_del_mce_list_entry(struct rvu *rvu,
+				  struct nix_hw *nix_hw,
+				  struct nix_mcast_grp_elem *elem,
+				  struct nix_mcast_grp_update_req *req)
+{
+	u32 num_entry = req->num_mce_entry;
+	struct nix_mce_list *mce_list;
+	struct mce *mce;
+	bool is_found;
+	int i;
+
+	mce_list = &elem->mcast_mce_list;
+	for (i = 0; i < num_entry; i++) {
+		is_found = false;
+		hlist_for_each_entry(mce, &mce_list->head, node) {
+			/* If already exists, then delete */
+			if (mce->pcifunc == req->pcifunc[i]) {
+				hlist_del(&mce->node);
+				kfree(mce);
+				mce_list->count--;
+				is_found = true;
+				break;
+			}
+		}
+
+		if (!is_found)
+			return NIX_AF_ERR_INVALID_MCAST_DEL_REQ;
+	}
+
+	mce_list->max = mce_list->count;
+	/* Dump the updated list to HW */
+	if (elem->dir == NIX_MCAST_INGRESS)
+		return nix_update_ingress_mce_list_hw(rvu, nix_hw, elem);
+
+	nix_update_egress_mce_list_hw(rvu, nix_hw, elem);
+	return 0;
+}
+
+static int nix_add_mce_list_entry(struct rvu *rvu,
+				  struct nix_hw *nix_hw,
+				  struct nix_mcast_grp_elem *elem,
+				  struct nix_mcast_grp_update_req *req)
+{
+	struct mce *tmp_mce[NIX_MCE_ENTRY_MAX];
+	u32 num_entry = req->num_mce_entry;
+	struct nix_mce_list *mce_list;
+	struct mce *mce;
+	int i;
+
+	mce_list = &elem->mcast_mce_list;
+	for (i = 0; i < num_entry; i++) {
+		mce = kzalloc(sizeof(*mce), GFP_KERNEL);
+		if (!mce)
+			goto free_mce;
+
+		mce->pcifunc = req->pcifunc[i];
+		mce->channel = req->channel[i];
+		mce->rq_rss_index = req->rq_rss_index[i];
+		mce->dest_type = req->dest_type[i];
+		mce->is_active = 1;
+		hlist_add_head(&mce->node, &mce_list->head);
+		tmp_mce[i] = mce;
+		mce_list->count++;
+	}
+
+	mce_list->max += num_entry;
+
+	/* Dump the updated list to HW */
+	if (elem->dir == NIX_MCAST_INGRESS)
+		return nix_update_ingress_mce_list_hw(rvu, nix_hw, elem);
+
+	nix_update_egress_mce_list_hw(rvu, nix_hw, elem);
+	return 0;
+
+free_mce:
+	while (i) {
+		hlist_del(&tmp_mce[i]->node);
+		kfree(tmp_mce[i]);
+		mce_list->count--;
+		i--;
+	}
+
+	return -ENOMEM;
+}
+
 static int nix_update_mce_list_entry(struct nix_mce_list *mce_list,
 				     u16 pcifunc, bool add)
 {
@@ -3079,6 +3304,7 @@ int nix_update_mce_list(struct rvu *rvu, u16 pcifunc,
 		/* EOL should be set in last MCE */
 		err = nix_blk_setup_mce(rvu, nix_hw, idx, NIX_AQ_INSTOP_WRITE,
 					mce->pcifunc, next_idx,
+					0, 1,
 					(next_idx > last_idx) ? true : false);
 		if (err)
 			goto end;
@@ -3159,6 +3385,16 @@ static int nix_update_mce_rule(struct rvu *rvu, u16 pcifunc,
 	return err;
 }
 
+static void nix_setup_mcast_grp(struct nix_hw *nix_hw)
+{
+	struct nix_mcast_grp *mcast_grp = &nix_hw->mcast_grp;
+
+	INIT_LIST_HEAD(&mcast_grp->mcast_grp_head);
+	mutex_init(&mcast_grp->mcast_grp_lock);
+	mcast_grp->next_grp_index = 1;
+	mcast_grp->count = 0;
+}
+
 static int nix_setup_mce_tables(struct rvu *rvu, struct nix_hw *nix_hw)
 {
 	struct nix_mcast *mcast = &nix_hw->mcast;
@@ -3183,15 +3419,15 @@ static int nix_setup_mce_tables(struct rvu *rvu, struct nix_hw *nix_hw)
 			continue;
 
 		/* save start idx of broadcast mce list */
-		pfvf->bcast_mce_idx = nix_alloc_mce_list(mcast, numvfs + 1);
+		pfvf->bcast_mce_idx = nix_alloc_mce_list(mcast, numvfs + 1, NIX_MCAST_INGRESS);
 		nix_mce_list_init(&pfvf->bcast_mce_list, numvfs + 1);
 
 		/* save start idx of multicast mce list */
-		pfvf->mcast_mce_idx = nix_alloc_mce_list(mcast, numvfs + 1);
+		pfvf->mcast_mce_idx = nix_alloc_mce_list(mcast, numvfs + 1, NIX_MCAST_INGRESS);
 		nix_mce_list_init(&pfvf->mcast_mce_list, numvfs + 1);
 
 		/* save the start idx of promisc mce list */
-		pfvf->promisc_mce_idx = nix_alloc_mce_list(mcast, numvfs + 1);
+		pfvf->promisc_mce_idx = nix_alloc_mce_list(mcast, numvfs + 1, NIX_MCAST_INGRESS);
 		nix_mce_list_init(&pfvf->promisc_mce_list, numvfs + 1);
 
 		for (idx = 0; idx < (numvfs + 1); idx++) {
@@ -3206,7 +3442,7 @@ static int nix_setup_mce_tables(struct rvu *rvu, struct nix_hw *nix_hw)
 			err = nix_blk_setup_mce(rvu, nix_hw,
 						pfvf->bcast_mce_idx + idx,
 						NIX_AQ_INSTOP_INIT,
-						pcifunc, 0, true);
+						pcifunc, 0, 0, 1, true);
 			if (err)
 				return err;
 
@@ -3214,7 +3450,7 @@ static int nix_setup_mce_tables(struct rvu *rvu, struct nix_hw *nix_hw)
 			err = nix_blk_setup_mce(rvu, nix_hw,
 						pfvf->mcast_mce_idx + idx,
 						NIX_AQ_INSTOP_INIT,
-						pcifunc, 0, true);
+						pcifunc, 0, 0, 1, true);
 			if (err)
 				return err;
 
@@ -3222,7 +3458,7 @@ static int nix_setup_mce_tables(struct rvu *rvu, struct nix_hw *nix_hw)
 			err = nix_blk_setup_mce(rvu, nix_hw,
 						pfvf->promisc_mce_idx + idx,
 						NIX_AQ_INSTOP_INIT,
-						pcifunc, 0, true);
+						pcifunc, 0, 0, 1, true);
 			if (err)
 				return err;
 		}
@@ -3237,11 +3473,25 @@ static int nix_setup_mcast(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
 	int err, size;
 
 	size = (rvu_read64(rvu, blkaddr, NIX_AF_CONST3) >> 16) & 0x0F;
-	size = (1ULL << size);
+	size = BIT_ULL(size);
+
+	/* Allocate bitmap for rx mce entries */
+	mcast->mce_counter[NIX_MCAST_INGRESS].max = 256UL << MC_TBL_SIZE;
+	err = rvu_alloc_bitmap(&mcast->mce_counter[NIX_MCAST_INGRESS]);
+	if (err)
+		return -ENOMEM;
+
+	/* Allocate bitmap for tx mce entries */
+	mcast->mce_counter[NIX_MCAST_EGRESS].max = MC_TX_MAX;
+	err = rvu_alloc_bitmap(&mcast->mce_counter[NIX_MCAST_EGRESS]);
+	if (err) {
+		rvu_free_bitmap(&mcast->mce_counter[NIX_MCAST_INGRESS]);
+		return -ENOMEM;
+	}
 
 	/* Alloc memory for multicast/mirror replication entries */
 	err = qmem_alloc(rvu->dev, &mcast->mce_ctx,
-			 (256UL << MC_TBL_SIZE), size);
+			 mcast->mce_counter[NIX_MCAST_INGRESS].max, size);
 	if (err)
 		return -ENOMEM;
 
@@ -3271,6 +3521,8 @@ static int nix_setup_mcast(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
 
 	mutex_init(&mcast->mce_lock);
 
+	nix_setup_mcast_grp(nix_hw);
+
 	return nix_setup_mce_tables(rvu, nix_hw);
 }
 
@@ -4794,6 +5046,78 @@ void rvu_nix_freemem(struct rvu *rvu)
 	}
 }
 
+static void nix_mcast_update_action(struct rvu *rvu,
+				    struct nix_mcast_grp_elem *elem)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct nix_rx_action rx_action = { 0 };
+	struct nix_tx_action tx_action = { 0 };
+	int npc_blkaddr;
+
+	npc_blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (elem->dir == NIX_MCAST_INGRESS) {
+		*(u64 *)&rx_action = npc_get_mcam_action(rvu, mcam,
+							 npc_blkaddr,
+							 elem->mcam_index);
+		rx_action.index = elem->mce_start_index;
+		npc_set_mcam_action(rvu, mcam, npc_blkaddr, elem->mcam_index,
+				    *(u64 *)&rx_action);
+	} else {
+		*(u64 *)&tx_action = npc_get_mcam_action(rvu, mcam,
+							 npc_blkaddr,
+							 elem->mcam_index);
+		tx_action.index = elem->mce_start_index;
+		npc_set_mcam_action(rvu, mcam, npc_blkaddr, elem->mcam_index,
+				    *(u64 *)&tx_action);
+	}
+}
+
+static void nix_mcast_update_mce_entry(struct rvu *rvu, u16 pcifunc, u8 is_active)
+{
+	struct nix_mcast_grp_elem *elem;
+	struct nix_mcast_grp *mcast_grp;
+	struct nix_hw *nix_hw;
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return;
+
+	mcast_grp = &nix_hw->mcast_grp;
+
+	mutex_lock(&mcast_grp->mcast_grp_lock);
+	list_for_each_entry(elem, &mcast_grp->mcast_grp_head, list) {
+		struct nix_mce_list *mce_list;
+		struct mce *mce;
+
+		/* Iterate the group elements and disable the element which
+		 * received the disable request.
+		 */
+		mce_list = &elem->mcast_mce_list;
+		hlist_for_each_entry(mce, &mce_list->head, node) {
+			if (mce->pcifunc == pcifunc) {
+				if (is_active)
+					mce->is_active = 1;
+				else
+					mce->is_active = 0;
+
+				break;
+			}
+		}
+
+		/* Dump the updated list to HW */
+		if (elem->dir == NIX_MCAST_INGRESS)
+			nix_update_ingress_mce_list_hw(rvu, nix_hw, elem);
+		else
+			nix_update_egress_mce_list_hw(rvu, nix_hw, elem);
+
+		/* Update the multicast index in NPC rule */
+		nix_mcast_update_action(rvu, elem);
+	}
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+}
+
 int rvu_mbox_handler_nix_lf_start_rx(struct rvu *rvu, struct msg_req *req,
 				     struct msg_rsp *rsp)
 {
@@ -4805,6 +5129,9 @@ int rvu_mbox_handler_nix_lf_start_rx(struct rvu *rvu, struct msg_req *req,
 	if (err)
 		return err;
 
+	/* Enable the interface if it is in any multicast list */
+	nix_mcast_update_mce_entry(rvu, pcifunc, 1);
+
 	rvu_npc_enable_default_entries(rvu, pcifunc, nixlf);
 
 	npc_mcam_enable_flows(rvu, pcifunc);
@@ -4829,6 +5156,9 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 		return err;
 
 	rvu_npc_disable_mcam_entries(rvu, pcifunc, nixlf);
+	/* Disable the interface if it is in any multicast list */
+	nix_mcast_update_mce_entry(rvu, pcifunc, 0);
+
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	clear_bit(NIXLF_INITIALIZED, &pfvf->flags);
@@ -5797,3 +6127,325 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(struct rvu *rvu, struct msg_req *re
 
 	return 0;
 }
+
+static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix_mcast_grp *mcast_grp,
+							      u32 mcast_grp_idx)
+{
+	struct nix_mcast_grp_elem *iter;
+
+	mutex_lock(&mcast_grp->mcast_grp_lock);
+	list_for_each_entry(iter, &mcast_grp->mcast_grp_head, list) {
+		if (iter->mcast_grp_idx == mcast_grp_idx) {
+			mutex_unlock(&mcast_grp->mcast_grp_lock);
+			return iter;
+		}
+	}
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+
+	return NULL;
+}
+
+int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc, u32 mcast_grp_idx)
+{
+	struct nix_mcast_grp_elem *elem;
+	struct nix_mcast_grp *mcast_grp;
+	struct nix_hw *nix_hw;
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return NIX_AF_ERR_INVALID_NIXBLK;
+
+	mcast_grp = &nix_hw->mcast_grp;
+	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
+	if (!elem)
+		return NIX_AF_ERR_INVALID_MCAST_GRP;
+
+	return elem->mce_start_index;
+}
+
+void rvu_nix_mcast_flr_free_entries(struct rvu *rvu, u16 pcifunc)
+{
+	struct nix_mcast_grp_destroy_req dreq = { 0 };
+	struct nix_mcast_grp_update_req ureq = { 0 };
+	struct nix_mcast_grp_update_rsp ursp = { 0 };
+	struct nix_mcast_grp_elem *elem, *tmp;
+	struct nix_mcast_grp *mcast_grp;
+	struct nix_hw *nix_hw;
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return;
+
+	mcast_grp = &nix_hw->mcast_grp;
+
+	mutex_lock(&mcast_grp->mcast_grp_lock);
+	list_for_each_entry_safe(elem, tmp, &mcast_grp->mcast_grp_head, list) {
+		struct nix_mce_list *mce_list;
+		struct hlist_node *tmp;
+		struct mce *mce;
+
+		/* If the pcifunc which created the multicast/mirror
+		 * group received an FLR, then delete the entire group.
+		 */
+		if (elem->pcifunc == pcifunc) {
+			mutex_unlock(&mcast_grp->mcast_grp_lock);
+			/* Delete group */
+			dreq.hdr.pcifunc = elem->pcifunc;
+			dreq.mcast_grp_idx = elem->mcast_grp_idx;
+			rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
+			mutex_lock(&mcast_grp->mcast_grp_lock);
+			continue;
+		}
+
+		/* Iterate the group elements and delete the element which
+		 * received the FLR.
+		 */
+		mce_list = &elem->mcast_mce_list;
+		hlist_for_each_entry_safe(mce, tmp, &mce_list->head, node) {
+			if (mce->pcifunc == pcifunc) {
+				mutex_unlock(&mcast_grp->mcast_grp_lock);
+				ureq.hdr.pcifunc = pcifunc;
+				ureq.num_mce_entry = 1;
+				ureq.mcast_grp_idx = elem->mcast_grp_idx;
+				ureq.op = NIX_MCAST_OP_DEL_ENTRY;
+				ureq.pcifunc[0] = pcifunc;
+				rvu_mbox_handler_nix_mcast_grp_update(rvu, &ureq, &ursp);
+				mutex_lock(&mcast_grp->mcast_grp_lock);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+}
+
+int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
+				    u32 mcast_grp_idx, u16 mcam_index)
+{
+	struct nix_mcast_grp_elem *elem;
+	struct nix_mcast_grp *mcast_grp;
+	struct nix_hw *nix_hw;
+	int blkaddr;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return NIX_AF_ERR_INVALID_NIXBLK;
+
+	mcast_grp = &nix_hw->mcast_grp;
+	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
+	if (!elem)
+		return NIX_AF_ERR_INVALID_MCAST_GRP;
+
+	elem->mcam_index = mcam_index;
+
+	return 0;
+}
+
+int rvu_mbox_handler_nix_mcast_grp_create(struct rvu *rvu,
+					  struct nix_mcast_grp_create_req *req,
+					  struct nix_mcast_grp_create_rsp *rsp)
+{
+	struct nix_mcast_grp_elem *elem;
+	struct nix_mcast_grp *mcast_grp;
+	struct nix_hw *nix_hw;
+	int blkaddr, err;
+
+	err = nix_get_struct_ptrs(rvu, req->hdr.pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
+
+	mcast_grp = &nix_hw->mcast_grp;
+	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
+	if (!elem)
+		return -ENOMEM;
+
+	INIT_HLIST_HEAD(&elem->mcast_mce_list.head);
+	elem->mcam_index = -1;
+	elem->mce_start_index = -1;
+	elem->pcifunc = req->hdr.pcifunc;
+	elem->dir = req->dir;
+	elem->mcast_grp_idx = mcast_grp->next_grp_index++;
+
+	mutex_lock(&mcast_grp->mcast_grp_lock);
+	list_add_tail(&elem->list, &mcast_grp->mcast_grp_head);
+	mcast_grp->count++;
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+
+	rsp->mcast_grp_idx = elem->mcast_grp_idx;
+	return 0;
+}
+
+int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
+					   struct nix_mcast_grp_destroy_req *req,
+					   struct msg_rsp *rsp)
+{
+	struct npc_delete_flow_req uninstall_req = { 0 };
+	struct npc_delete_flow_rsp uninstall_rsp = { 0 };
+	struct nix_mcast_grp_elem *elem;
+	struct nix_mcast_grp *mcast_grp;
+	struct nix_mcast *mcast;
+	struct nix_hw *nix_hw;
+	int blkaddr, err;
+
+	err = nix_get_struct_ptrs(rvu, req->hdr.pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
+
+	mcast_grp = &nix_hw->mcast_grp;
+	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
+	if (!elem)
+		return NIX_AF_ERR_INVALID_MCAST_GRP;
+
+	/* If no mce entries are associated with the group
+	 * then just remove it from the global list.
+	 */
+	if (!elem->mcast_mce_list.count)
+		goto delete_grp;
+
+	/* Delete the associated mcam entry and
+	 * remove all mce entries from the group
+	 */
+	mcast = &nix_hw->mcast;
+	mutex_lock(&mcast->mce_lock);
+	if (elem->mcam_index != -1) {
+		uninstall_req.hdr.pcifunc = req->hdr.pcifunc;
+		uninstall_req.entry = elem->mcam_index;
+		rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
+	}
+
+	nix_free_mce_list(mcast, elem->mcast_mce_list.count,
+			  elem->mce_start_index, elem->dir);
+	nix_delete_mcast_mce_list(&elem->mcast_mce_list);
+	mutex_unlock(&mcast->mce_lock);
+
+delete_grp:
+	mutex_lock(&mcast_grp->mcast_grp_lock);
+	list_del(&elem->list);
+	kfree(elem);
+	mcast_grp->count--;
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+	return 0;
+}
+
+int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
+					  struct nix_mcast_grp_update_req *req,
+					  struct nix_mcast_grp_update_rsp *rsp)
+{
+	struct nix_mcast_grp_destroy_req dreq = { 0 };
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct nix_mcast_grp_elem *elem;
+	struct nix_mcast_grp *mcast_grp;
+	int blkaddr, err, npc_blkaddr;
+	u16 prev_count, new_count;
+	struct nix_mcast *mcast;
+	struct nix_hw *nix_hw;
+	int i, ret;
+
+	if (!req->num_mce_entry)
+		return 0;
+
+	err = nix_get_struct_ptrs(rvu, req->hdr.pcifunc, &nix_hw, &blkaddr);
+	if (err)
+		return err;
+
+	mcast_grp = &nix_hw->mcast_grp;
+	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
+	if (!elem)
+		return NIX_AF_ERR_INVALID_MCAST_GRP;
+
+	/* If any pcifunc matches the group's pcifunc, then we can
+	 * delete the entire group.
+	 */
+	if (req->op == NIX_MCAST_OP_DEL_ENTRY) {
+		for (i = 0; i < req->num_mce_entry; i++) {
+			if (elem->pcifunc == req->pcifunc[i]) {
+				/* Delete group */
+				dreq.hdr.pcifunc = elem->pcifunc;
+				dreq.mcast_grp_idx = elem->mcast_grp_idx;
+				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
+				return 0;
+			}
+		}
+	}
+
+	mcast = &nix_hw->mcast;
+	mutex_lock(&mcast->mce_lock);
+	npc_blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (elem->mcam_index != -1)
+		npc_enable_mcam_entry(rvu, mcam, npc_blkaddr, elem->mcam_index, false);
+
+	prev_count = elem->mcast_mce_list.count;
+	if (req->op == NIX_MCAST_OP_ADD_ENTRY) {
+		new_count = prev_count + req->num_mce_entry;
+		if (prev_count)
+			nix_free_mce_list(mcast, prev_count, elem->mce_start_index, elem->dir);
+
+		elem->mce_start_index = nix_alloc_mce_list(mcast, new_count, elem->dir);
+
+		/* It is possible not to get contiguous memory */
+		if (elem->mce_start_index < 0) {
+			if (elem->mcam_index != -1) {
+				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
+						      elem->mcam_index, true);
+				mutex_unlock(&mcast->mce_lock);
+				return NIX_AF_ERR_NON_CONTIG_MCE_LIST;
+			}
+		}
+
+		ret = nix_add_mce_list_entry(rvu, nix_hw, elem, req);
+		if (ret) {
+			nix_free_mce_list(mcast, new_count, elem->mce_start_index, elem->dir);
+			if (prev_count)
+				elem->mce_start_index = nix_alloc_mce_list(mcast,
+									   prev_count,
+									   elem->dir);
+
+			if (elem->mcam_index != -1)
+				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
+						      elem->mcam_index, true);
+
+			mutex_unlock(&mcast->mce_lock);
+			return ret;
+		}
+	} else {
+		if (!prev_count || prev_count < req->num_mce_entry) {
+			if (elem->mcam_index != -1)
+				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
+						      elem->mcam_index, true);
+			return NIX_AF_ERR_INVALID_MCAST_DEL_REQ;
+		}
+
+		nix_free_mce_list(mcast, prev_count, elem->mce_start_index, elem->dir);
+		new_count = prev_count - req->num_mce_entry;
+		elem->mce_start_index = nix_alloc_mce_list(mcast, new_count, elem->dir);
+		ret = nix_del_mce_list_entry(rvu, nix_hw, elem, req);
+		if (ret) {
+			nix_free_mce_list(mcast, new_count, elem->mce_start_index, elem->dir);
+			elem->mce_start_index = nix_alloc_mce_list(mcast, prev_count, elem->dir);
+			if (elem->mcam_index != -1)
+				npc_enable_mcam_entry(rvu, mcam,
+						      npc_blkaddr,
+						      elem->mcam_index,
+						      true);
+
+			mutex_unlock(&mcast->mce_lock);
+			return ret;
+		}
+	}
+
+	if (elem->mcam_index == -1) {
+		mutex_unlock(&mcast->mce_lock);
+		rsp->mce_start_index = elem->mce_start_index;
+		return 0;
+	}
+
+	nix_mcast_update_action(rvu, elem);
+	npc_enable_mcam_entry(rvu, mcam, npc_blkaddr, elem->mcam_index, true);
+	mutex_unlock(&mcast->mce_lock);
+	rsp->mce_start_index = elem->mce_start_index;
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 16cfc802e348..49babf968c1b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -589,8 +589,8 @@ static void npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 		    NPC_AF_MCAMEX_BANKX_CFG(dest, dbank), cfg);
 }
 
-static u64 npc_get_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
-			       int blkaddr, int index)
+u64 npc_get_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
+			int blkaddr, int index)
 {
 	int bank = npc_get_bank(mcam, index);
 
@@ -599,6 +599,16 @@ static u64 npc_get_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 			  NPC_AF_MCAMEX_BANKX_ACTION(index, bank));
 }
 
+void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
+			 int blkaddr, int index, u64 cfg)
+{
+	int bank = npc_get_bank(mcam, index);
+
+	index &= (mcam->banksize - 1);
+	return rvu_write64(rvu, blkaddr,
+			   NPC_AF_MCAMEX_BANKX_ACTION(index, bank), cfg);
+}
+
 void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 				 int nixlf, u64 chan, u8 *mac_addr)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 114e4ec21802..bd4324e9aa13 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1106,13 +1106,14 @@ static void rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
 	}
 }
 
-static void npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-				struct mcam_entry *entry,
-				struct npc_install_flow_req *req,
-				u16 target, bool pf_set_vfs_mac)
+static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
+			       struct mcam_entry *entry,
+			       struct npc_install_flow_req *req,
+			       u16 target, bool pf_set_vfs_mac)
 {
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	struct nix_rx_action action;
+	int mce_index;
 
 	if (rswitch->mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && pf_set_vfs_mac)
 		req->chan_mask = 0x0; /* Do not care channel */
@@ -1124,6 +1125,21 @@ static void npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	action.pf_func = target;
 	action.op = req->op;
 	action.index = req->index;
+
+	/* If a PF/VF is installing a multicast rule then it is expected
+	 * that the PF/VF should have created a group for the multicast/mirror
+	 * list. Otherwise reject the configuration.
+	 * During this scenario, req->index is set as multicast/mirror
+	 * group index.
+	 */
+	if (req->hdr.pcifunc && action.op == NIX_RX_ACTIONOP_MCAST) {
+		mce_index = rvu_nix_mcast_get_mce_index(rvu, req->hdr.pcifunc, req->index);
+		if (mce_index < 0)
+			return mce_index;
+
+		action.index = mce_index;
+	}
+
 	action.match_id = req->match_id;
 	action.flow_key_alg = req->flow_key_alg;
 
@@ -1155,14 +1171,17 @@ static void npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			     FIELD_PREP(RX_VTAG1_TYPE_MASK, req->vtag1_type) |
 			     FIELD_PREP(RX_VTAG1_LID_MASK, NPC_LID_LB) |
 			     FIELD_PREP(RX_VTAG1_RELPTR_MASK, 4);
+
+	return 0;
 }
 
-static void npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
-				struct mcam_entry *entry,
-				struct npc_install_flow_req *req, u16 target)
+static int npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
+			       struct mcam_entry *entry,
+			       struct npc_install_flow_req *req, u16 target)
 {
 	struct nix_tx_action action;
 	u64 mask = ~0ULL;
+	int mce_index;
 
 	/* If AF is installing then do not care about
 	 * PF_FUNC in Send Descriptor
@@ -1176,6 +1195,20 @@ static void npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	*(u64 *)&action = 0x00;
 	action.op = req->op;
 	action.index = req->index;
+	/* If a PF/VF is installing a multicast rule then it is expected
+	 * that the PF/VF should have created a group for the multicast/mirror
+	 * list. Otherwise reject the configuration.
+	 * During this scenario, req->index is set as multicast/mirror
+	 * group index.
+	 */
+	if (req->hdr.pcifunc && action.op == NIX_TX_ACTIONOP_MCAST) {
+		mce_index = rvu_nix_mcast_get_mce_index(rvu, req->hdr.pcifunc, req->index);
+		if (mce_index < 0)
+			return mce_index;
+
+		action.index = mce_index;
+	}
+
 	action.match_id = req->match_id;
 
 	entry->action = *(u64 *)&action;
@@ -1191,6 +1224,8 @@ static void npc_update_tx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			     FIELD_PREP(TX_VTAG1_OP_MASK, req->vtag1_op) |
 			     FIELD_PREP(TX_VTAG1_LID_MASK, NPC_LID_LA) |
 			     FIELD_PREP(TX_VTAG1_RELPTR_MASK, 24);
+
+	return 0;
 }
 
 static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
@@ -1220,10 +1255,15 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	npc_update_flow(rvu, entry, features, &req->packet, &req->mask, &dummy,
 			req->intf, blkaddr);
 
-	if (is_npc_intf_rx(req->intf))
-		npc_update_rx_entry(rvu, pfvf, entry, req, target, pf_set_vfs_mac);
-	else
-		npc_update_tx_entry(rvu, pfvf, entry, req, target);
+	if (is_npc_intf_rx(req->intf)) {
+		err = npc_update_rx_entry(rvu, pfvf, entry, req, target, pf_set_vfs_mac);
+		if (err < 0)
+			return err;
+	} else {
+		err = npc_update_tx_entry(rvu, pfvf, entry, req, target);
+		if (err < 0)
+			return err;
+	}
 
 	/* Default unicast rules do not exist for TX */
 	if (is_npc_intf_tx(req->intf))
@@ -1340,6 +1380,10 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 		return rvu_nix_setup_ratelimit_aggr(rvu, req->hdr.pcifunc,
 					     req->index, req->match_id);
 
+	if (owner && req->op == NIX_RX_ACTIONOP_MCAST)
+		return rvu_nix_mcast_update_mcam_entry(rvu, req->hdr.pcifunc,
+						       req->index, entry_index);
+
 	return 0;
 }
 
-- 
2.25.1

