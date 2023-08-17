Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCB77F08B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348247AbjHQGan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348246AbjHQGam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:30:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED7C94;
        Wed, 16 Aug 2023 23:30:40 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H3cvAl015665;
        Wed, 16 Aug 2023 23:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=w7FREuKkr9nJ74I47sTDisM1sI6qcd5kPgS7uw9CZ+s=;
 b=A3wGG5Qq8V4RKOba1rGF8ovyXwQ6RBsIkIzzNQ9Iy5eE8FgRCHDKAPiOToxxjrnSl0RF
 L0VUefOoAgLzkEDBRUDzDZUdN+cA6aX1TZJosoCfbW9cIUV3rBwXI4ex+c1FnN3wS+kg
 bP9aiPmc/f4vo2mI3EVW1Zx41bQsktaPn5EQyIfTV+5QgZT+FYOl/6SMV25Decj1jiW6
 pusXaQ8oyDRF1NYGZZS6dS+N9hgQvwsZ3gefvfRn/K/Te4Eaq0FM+sRctzZ0eR2FWn2k
 Zi22mr3egR9T285/vyE1IG86y/HIgUwp5DzQgA/6vSJO/X57eFS8m+1k087awGhiMufF WA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sgptkvsm2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 23:30:27 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 23:30:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 16 Aug 2023 23:30:11 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 5343B3F7087;
        Wed, 16 Aug 2023 23:30:07 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net Patch] octeontx2-af: SDP: fix receive link config
Date:   Thu, 17 Aug 2023 12:00:06 +0530
Message-ID: <20230817063006.10366-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KKcojXTu6uGObrC8rRLCpp3JueMw-7EI
X-Proofpoint-GUID: KKcojXTu6uGObrC8rRLCpp3JueMw-7EI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SDP interfaces, frame oversize and undersize errors are
observed as driver is not considering packet sizes of all
subscribers of the link before updating the link config.

This patch fixes the same.

Fixes: 9b7dd87ac071 ("octeontx2-af: Support to modify min/max allowed packet lengths")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 04b0e885f9d2..c2f68678e947 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4270,9 +4270,10 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-	nix_find_link_frs(rvu, req, pcifunc);
 
 linkcfg:
+	nix_find_link_frs(rvu, req, pcifunc);
+
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link));
 	cfg = (cfg & ~(0xFFFFULL << 16)) | ((u64)req->maxlen << 16);
 	if (req->update_minlen)
-- 
2.17.1

