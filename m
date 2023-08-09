Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E85775306
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjHIGk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHIGk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:40:57 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA310CF;
        Tue,  8 Aug 2023 23:40:57 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379661kq023099;
        Tue, 8 Aug 2023 23:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=Yx9yKTjG6oSu+ogeiBB9HVwjJYXMB5oiDs93tZ82S6Y=;
 b=CJc9HDD6fLFnwrJPoAtsXonXITzMsORXmLKUKl+sSnRuXpMhBPXnGZaz8JZ3mgJMkwyw
 jK0LbHwAUSwRbDNN7A7/Upmdc+1mfkNyOfY/lTnHY6cN3rG6ib9WnfE9hYYgyKO51pAG
 nULgmWScZetIQydv502A6NfgGS/FLW5xgxHIkye7eygtTsjj9ebv4M9yxXpKTvH/0qHe
 x8o+f5riCnkghjBNAyCZudI92Cx5OEti0MFVgwIJ+wocrUReFG8tGOo/5Sx6aG2BE4AG
 Id+lpCFvW20DpjItPDQG+TFCZGUi/BmSeu0r4/An5DWDhoLKQeRxK2mm9HpW8V82NxyT Hg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sc57sg3db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 23:40:48 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Aug
 2023 23:40:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 8 Aug 2023 23:40:46 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 8CF4D3F705A;
        Tue,  8 Aug 2023 23:40:42 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: Harden rule validation.
Date:   Wed, 9 Aug 2023 12:10:39 +0530
Message-ID: <20230809064039.1167803-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: p8UOcCxHr2z4ruJRnT98wdnww5h5Osn7
X-Proofpoint-ORIG-GUID: p8UOcCxHr2z4ruJRnT98wdnww5h5Osn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept TC offload classifier rule only if SPI field
can be extracted by HW.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 5c8f9fc15ff8..237f82082ebe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -580,7 +580,9 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		if (!npc_check_field(rvu, blkaddr, NPC_LB, intf))
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
-	if (*features & (BIT_ULL(NPC_IPPROTO_AH) | BIT_ULL(NPC_IPPROTO_ESP)))
+	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
+	if (npc_check_field(rvu, blkaddr, NPC_IPSEC_SPI, intf) &&
+	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
 
 	/* for vlan ethertypes corresponding layer type should be in the key */
-- 
2.25.1

