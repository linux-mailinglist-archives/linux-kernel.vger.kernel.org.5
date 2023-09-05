Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574B9792B41
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjIEQuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353582AbjIEGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:48:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5612B1B4;
        Mon,  4 Sep 2023 23:48:40 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384LrkRT017196;
        Mon, 4 Sep 2023 23:48:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=I7QsQtpzfUbZvSXNhaojvmUw6Aywv2VTTH6a9TUm1Zk=;
 b=W/n0J9MXtnnBYMg8wmq2mbkQLstpNC2pA+7GcwQR8eoZUM+zhj1oOQtZr1lNdaVDmjYH
 FOh84XotrW8WVCMAVvCJmwfgpms9WXND0gqkD+S8yS+dPH3GUUzoRJezmjTIwN7nrPpt
 QbVHeKA6UqIZnXBR6aLqOZs6A+hgCTGlxYQE65cYqlhp+P4WtFPiGmmY9wDZ5E9cR94S
 sfTAV4I03R8gbwCgpqqdoUFwNBAsCcOEMH/+EuqmqRu/8J5XDyguEa8edgXZPSR5SV2/
 XbhsLUs67chjuRi5xKUU4w35sHUYZ98lD0S7NFAJWLxElr68bFkkQupdWxN4kaU7f/UN Dg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3swdqyk31y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 23:48:24 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Sep
 2023 23:48:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Sep 2023 23:48:22 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id AEFB85B6977;
        Mon,  4 Sep 2023 23:48:18 -0700 (PDT)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue  mbox handler
Date:   Tue, 5 Sep 2023 12:18:16 +0530
Message-ID: <20230905064816.27514-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: WCwObZb_LfVJD2NlAB9YbwEo5u6J-il7
X-Proofpoint-ORIG-GUID: WCwObZb_LfVJD2NlAB9YbwEo5u6J-il7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_05,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smq value used in the CN10K NIX AQ instruction enqueue mailbox
handler was truncated to 9-bit value from 10-bit value because of
typecasting the CN10K mbox request structure to the CN9K structure.
Though this hasn't caused any problems when programming the NIX SQ
context to the HW because the context structure is the same size.
However, this causes a problem when accessing the structure parameters.
This patch reads the right smq value for each platform.

Fixes: 30077d210c83 ("octeontx2-af: cn10k: Update NIX/NPA context structure")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index c2f68678e947..23c2f2ed2fb8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -846,6 +846,21 @@ static int nix_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
 	return 0;
 }
 
+static void nix_get_aq_req_smq(struct rvu *rvu, struct nix_aq_enq_req *req,
+			       u16 *smq, u16 *smq_mask)
+{
+	struct nix_cn10k_aq_enq_req *aq_req;
+
+	if (!is_rvu_otx2(rvu)) {
+		aq_req = (struct nix_cn10k_aq_enq_req *)req;
+		*smq = aq_req->sq.smq;
+		*smq_mask = aq_req->sq_mask.smq;
+	} else {
+		*smq = req->sq.smq;
+		*smq_mask = req->sq_mask.smq;
+	}
+}
+
 static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 				   struct nix_aq_enq_req *req,
 				   struct nix_aq_enq_rsp *rsp)
@@ -857,6 +872,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	struct rvu_block *block;
 	struct admin_queue *aq;
 	struct rvu_pfvf *pfvf;
+	u16 smq, smq_mask;
 	void *ctx, *mask;
 	bool ena;
 	u64 cfg;
@@ -928,13 +944,14 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (rc)
 		return rc;
 
+	nix_get_aq_req_smq(rvu, req, &smq, &smq_mask);
 	/* Check if SQ pointed SMQ belongs to this PF/VF or not */
 	if (req->ctype == NIX_AQ_CTYPE_SQ &&
 	    ((req->op == NIX_AQ_INSTOP_INIT && req->sq.ena) ||
 	     (req->op == NIX_AQ_INSTOP_WRITE &&
-	      req->sq_mask.ena && req->sq_mask.smq && req->sq.ena))) {
+	      req->sq_mask.ena && req->sq.ena && smq_mask))) {
 		if (!is_valid_txschq(rvu, blkaddr, NIX_TXSCH_LVL_SMQ,
-				     pcifunc, req->sq.smq))
+				     pcifunc, smq))
 			return NIX_AF_ERR_AQ_ENQUEUE;
 	}
 
-- 
2.25.1

