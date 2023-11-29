Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4247FCE62
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376954AbjK2FmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjK2FmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:42:00 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDFF1AE;
        Tue, 28 Nov 2023 21:42:06 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3jmaU006444;
        Tue, 28 Nov 2023 21:41:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=PsaOol7ocb/iGZfJuZJyDf0wjuc8qFIf2hC77PzevFs=;
 b=gaQuH1lbTAHggIpox5x9SWpbbZ+ZT9V6jqYWxGBsonWiu66v5HvL8nnzxbkg4MTSW2Vp
 +DF81TNjvqn3l96bhoSHTDvQ9M9UnBc3a4IuMD5ebCFmDgwdyXCw+HkiiUeaKfB6fCIh
 7wrvSqDq65lSRtQAQOG7/DC7lpxnellGbbWzo7vYyFhuKW02ZIaYLfWIiG4YCSDhkSmL
 TkFGcid58eFM76lOv+EQp8CA0blzE5F/XZgbqQQ0B1H6qtam622K9HlzcUM+DKH6J2/j
 DoK9SjDjeyn6q3o6LiiOiaQIH1kYajcahtRpAll2v1cT/nxPPJEsy5Dp/LJL60ijs/3O IA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3una4dmhgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 21:41:59 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 21:41:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 21:41:57 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
        by maili.marvell.com (Postfix) with ESMTP id C4A4C3F7048;
        Tue, 28 Nov 2023 21:41:51 -0800 (PST)
From:   Subbaraya Sundeep <sbhatta@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <naveenm@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH v3 net] octeontx2-af: Check return value of nix_get_nixlf before using nixlf
Date:   Wed, 29 Nov 2023 11:11:48 +0530
Message-ID: <1701236508-22930-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: idnKMRQx-GUERl9VfTFrPLJ75Zi3pvKj
X-Proofpoint-ORIG-GUID: idnKMRQx-GUERl9VfTFrPLJ75Zi3pvKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_03,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a NIXLF is not attached to a PF/VF device then
nix_get_nixlf function fails and returns proper error
code. But npc_get_default_entry_action does not check it
and uses garbage value in subsequent calls. Fix this
by cheking the return value of nix_get_nixlf.

Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
v3 changes:
	Added version history
v2 changes:
	CCed AF driver maintainers and original author of patch
	
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 16cfc80..f658058 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -389,7 +389,13 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank, nixlf, index;
 
 	/* get ucast entry rule entry index */
-	nix_get_nixlf(rvu, pf_func, &nixlf, NULL);
+	if (nix_get_nixlf(rvu, pf_func, &nixlf, NULL)) {
+		dev_err(rvu->dev, "%s: nixlf not attached to pcifunc:0x%x\n",
+			__func__, pf_func);
+		/* Action 0 is drop */
+		return 0;
+	}
+
 	index = npc_get_nixlf_mcam_index(mcam, pf_func, nixlf,
 					 NIXLF_UCAST_ENTRY);
 	bank = npc_get_bank(mcam, index);
-- 
2.7.4

