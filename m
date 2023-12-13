Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8088C810E06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjLMJyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjLMJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:54:12 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC0D5;
        Wed, 13 Dec 2023 01:54:18 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD3XRb5012398;
        Wed, 13 Dec 2023 01:53:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=pfpt0220; bh=+vCULqN2
        NAFRiIia8IlWbiO7867SysuiJx0r0ou4aYM=; b=FqzNlehv7LKcfN9LB9CMwjVP
        3tN18WdRBiU0qJ3eu4tJB2vLoPtX2uGnPhKq40yZS3PnNmddPZUtwXmPJPs9oDRV
        jrTiPkFiO8xyCGX+7ombqJUiyzfqiMVyqPXdf5wlfaiLr1yAbSsCLqSLMvcNlL30
        kiS1NJxLVWMN6TObYZ024TaNWQdqWI+xX9amGqM/Mq+5phyczrH93v/NY+f4k5W5
        ZEIiciZ40TxFzDpCTEzO7DzS49ZbPMRHe8PZV3Jh7AbMDUay5IAuYj0kg70adT7/
        mN4Al6HeftsrxaBJPwwkspaFiU/co5H6cKTc3w7t70eHV0hZpyoaBupaW2W07w==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uy4tgh84t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 01:53:57 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Dec
 2023 01:53:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 13 Dec 2023 01:53:56 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id A98CE3F709F;
        Wed, 13 Dec 2023 01:53:51 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <wojciech.drewek@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v2] octeontx2-af: Fix multicast/mirror group lock/unlock issue
Date:   Wed, 13 Dec 2023 15:23:49 +0530
Message-ID: <20231213095349.69895-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: phSdFZ0EI3PkG7UIwwIQfkLS1Q9ljdBh
X-Proofpoint-GUID: phSdFZ0EI3PkG7UIwwIQfkLS1Q9ljdBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the existing implementation, there exists a race between finding
a multicast/mirror group entry and deleting that entry. The group lock
was taken and released independently by rvu_nix_mcast_find_grp_elem()
function. Which is incorrect and group lock should be taken during the
entire operation of group updation/deletion. This patch fixes the same.

Fixes: 51b2804c19cd ("octeontx2-af: Add new mbox to support multicast/mirror offload")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
Note: This is a follow up of

https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_netdev_net-2Dnext_c_51b2804c19cd&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=7si3Xn9Ly-Se1a655kvEPIYU0nQ9HPeN280sEUv5ROU&m=NjKPoTkYVlL5Dh4aSr3-dVo-AukiIperlvB0S4_Mqzkyl_VcYAAKrWhkGZE5Cx-p&s=AkBf0454Xm-0adqV0Os7ZE8peaCXtYyuNbCS5kit6Jk&e=

v2 changes:
- Addresed review comments from Simon about a missed unlock and re-org the code
  with some goto labels.

 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 84 ++++++++++++-------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index b01503acd520..72e0a7717c3e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -6142,14 +6142,12 @@ static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix_mcast_g
 	struct nix_mcast_grp_elem *iter;
 	bool is_found = false;
 
-	mutex_lock(&mcast_grp->mcast_grp_lock);
 	list_for_each_entry(iter, &mcast_grp->mcast_grp_head, list) {
 		if (iter->mcast_grp_idx == mcast_grp_idx) {
 			is_found = true;
 			break;
 		}
 	}
-	mutex_unlock(&mcast_grp->mcast_grp_lock);
 
 	if (is_found)
 		return iter;
@@ -6162,7 +6160,7 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc, u32 mcast_grp_idx)
 	struct nix_mcast_grp_elem *elem;
 	struct nix_mcast_grp *mcast_grp;
 	struct nix_hw *nix_hw;
-	int blkaddr;
+	int blkaddr, ret;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	nix_hw = get_nix_hw(rvu->hw, blkaddr);
@@ -6170,11 +6168,15 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc, u32 mcast_grp_idx)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
 	mcast_grp = &nix_hw->mcast_grp;
+	mutex_lock(&mcast_grp->mcast_grp_lock);
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
 	if (!elem)
-		return NIX_AF_ERR_INVALID_MCAST_GRP;
+		ret = NIX_AF_ERR_INVALID_MCAST_GRP;
+	else
+		ret = elem->mce_start_index;
 
-	return elem->mce_start_index;
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+	return ret;
 }
 
 void rvu_nix_mcast_flr_free_entries(struct rvu *rvu, u16 pcifunc)
@@ -6238,7 +6240,7 @@ int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 	struct nix_mcast_grp_elem *elem;
 	struct nix_mcast_grp *mcast_grp;
 	struct nix_hw *nix_hw;
-	int blkaddr;
+	int blkaddr, ret = 0;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	nix_hw = get_nix_hw(rvu->hw, blkaddr);
@@ -6246,13 +6248,15 @@ int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
 	mcast_grp = &nix_hw->mcast_grp;
+	mutex_lock(&mcast_grp->mcast_grp_lock);
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, mcast_grp_idx);
 	if (!elem)
-		return NIX_AF_ERR_INVALID_MCAST_GRP;
-
-	elem->mcam_index = mcam_index;
+		ret = NIX_AF_ERR_INVALID_MCAST_GRP;
+	else
+		elem->mcam_index = mcam_index;
 
-	return 0;
+	mutex_unlock(&mcast_grp->mcast_grp_lock);
+	return ret;
 }
 
 int rvu_mbox_handler_nix_mcast_grp_create(struct rvu *rvu,
@@ -6297,18 +6301,27 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
 	struct npc_delete_flow_rsp uninstall_rsp = { 0 };
 	struct nix_mcast_grp_elem *elem;
 	struct nix_mcast_grp *mcast_grp;
+	int blkaddr, err, ret = 0;
 	struct nix_mcast *mcast;
 	struct nix_hw *nix_hw;
-	int blkaddr, err;
 
 	err = nix_get_struct_ptrs(rvu, req->hdr.pcifunc, &nix_hw, &blkaddr);
 	if (err)
 		return err;
 
 	mcast_grp = &nix_hw->mcast_grp;
+
+	/* If AF is requesting for the deletion,
+	 * then AF is already taking the lock
+	 */
+	if (!req->is_af)
+		mutex_lock(&mcast_grp->mcast_grp_lock);
+
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
-	if (!elem)
-		return NIX_AF_ERR_INVALID_MCAST_GRP;
+	if (!elem) {
+		ret = NIX_AF_ERR_INVALID_MCAST_GRP;
+		goto unlock_grp;
+	}
 
 	/* If no mce entries are associated with the group
 	 * then just remove it from the global list.
@@ -6333,19 +6346,15 @@ int rvu_mbox_handler_nix_mcast_grp_destroy(struct rvu *rvu,
 	mutex_unlock(&mcast->mce_lock);
 
 delete_grp:
-	/* If AF is requesting for the deletion,
-	 * then AF is already taking the lock
-	 */
-	if (!req->is_af)
-		mutex_lock(&mcast_grp->mcast_grp_lock);
-
 	list_del(&elem->list);
 	kfree(elem);
 	mcast_grp->count--;
+
+unlock_grp:
 	if (!req->is_af)
 		mutex_unlock(&mcast_grp->mcast_grp_lock);
 
-	return 0;
+	return ret;
 }
 
 int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
@@ -6370,9 +6379,18 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 		return err;
 
 	mcast_grp = &nix_hw->mcast_grp;
+
+	/* If AF is requesting for the updation,
+	 * then AF is already taking the lock
+	 */
+	if (!req->is_af)
+		mutex_lock(&mcast_grp->mcast_grp_lock);
+
 	elem = rvu_nix_mcast_find_grp_elem(mcast_grp, req->mcast_grp_idx);
-	if (!elem)
-		return NIX_AF_ERR_INVALID_MCAST_GRP;
+	if (!elem) {
+		ret = NIX_AF_ERR_INVALID_MCAST_GRP;
+		goto unlock_grp;
+	}
 
 	/* If any pcifunc matches the group's pcifunc, then we can
 	 * delete the entire group.
@@ -6383,9 +6401,10 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 				/* Delete group */
 				dreq.hdr.pcifunc = elem->pcifunc;
 				dreq.mcast_grp_idx = elem->mcast_grp_idx;
-				dreq.is_af = req->is_af;
+				dreq.is_af = 1;
 				rvu_mbox_handler_nix_mcast_grp_destroy(rvu, &dreq, NULL);
-				return 0;
+				ret = 0;
+				goto unlock_grp;
 			}
 		}
 	}
@@ -6410,7 +6429,7 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
 						      elem->mcam_index, true);
 				ret = NIX_AF_ERR_NON_CONTIG_MCE_LIST;
-				goto done;
+				goto unlock_mce;
 			}
 		}
 
@@ -6426,7 +6445,7 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
 						      elem->mcam_index, true);
 
-			goto done;
+			goto unlock_mce;
 		}
 	} else {
 		if (!prev_count || prev_count < req->num_mce_entry) {
@@ -6434,7 +6453,7 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 				npc_enable_mcam_entry(rvu, mcam, npc_blkaddr,
 						      elem->mcam_index, true);
 			ret = NIX_AF_ERR_INVALID_MCAST_DEL_REQ;
-			goto done;
+			goto unlock_mce;
 		}
 
 		nix_free_mce_list(mcast, prev_count, elem->mce_start_index, elem->dir);
@@ -6450,14 +6469,14 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 						      elem->mcam_index,
 						      true);
 
-			goto done;
+			goto unlock_mce;
 		}
 	}
 
 	if (elem->mcam_index == -1) {
 		rsp->mce_start_index = elem->mce_start_index;
 		ret = 0;
-		goto done;
+		goto unlock_mce;
 	}
 
 	nix_mcast_update_action(rvu, elem);
@@ -6465,7 +6484,12 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 	rsp->mce_start_index = elem->mce_start_index;
 	ret = 0;
 
-done:
+unlock_mce:
 	mutex_unlock(&mcast->mce_lock);
+
+unlock_grp:
+	if (!req->is_af)
+		mutex_unlock(&mcast_grp->mcast_grp_lock);
+
 	return ret;
 }
-- 
2.25.1

