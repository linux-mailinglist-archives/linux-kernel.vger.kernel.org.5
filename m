Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7736F7FEA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjK3H6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344820AbjK3H6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:58:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024411709;
        Wed, 29 Nov 2023 23:58:46 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU78Xpd027659;
        Wed, 29 Nov 2023 23:58:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=pqgT8/te6zTWsZfVion+jdpco4hDORcq6oDMHSPiFJM=;
 b=CqeTgPiH+k9H6NAt9s+j7RmOHK8Ll/+sZC+mgtp3iR5WfTKQCtSQgR3EqyaWLU4jlOTQ
 LDDG3e9Ju0kDjdxayJkWqSi/FlYGWl+x2LLuezMAJaem0+1aoxrAgnUaozmtoKP138Qk
 fWUPLbR+Mz6HVQX6vc9HM7APe51kGcsBvdrMuwCMJbaHaFZl+hzUx4oIfA8UJafFDM15
 4/foMoCP9alMrBc/altmtXNapuPkQuFqogd8VrR/lwla8FKOrhJJzOU+QIzSZdTYB9o+
 L0jUEKDkzIa3ipsKrbsy9quU+GcAPCY1EDAlXEXRpon17ioBJ7OtNQECiMzh3YRTGTjl Sg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3upc1v2j09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 23:58:41 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 23:58:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 29 Nov 2023 23:58:40 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 5D4323F7044;
        Wed, 29 Nov 2023 23:58:36 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v3 PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Date:   Thu, 30 Nov 2023 13:28:17 +0530
Message-ID: <20231130075818.18401-5-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130075818.18401-1-gakula@marvell.com>
References: <20231130075818.18401-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 1AGVGIdDU1rdU7UcRjgOsLd9DqTx9lqP
X-Proofpoint-ORIG-GUID: 1AGVGIdDU1rdU7UcRjgOsLd9DqTx9lqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_05,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mcs resources are attached to PF/VF. These resources need
to be freed on FLR. This patch add missing mcs flr call on PF FLR.

Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v2-v3:
 Fixed typo error in commit message.

 drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 22c395c7d040..731bb82b577c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2631,6 +2631,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	rvu_npc_free_mcam_entries(rvu, pcifunc, -1);
 	rvu_mac_reset(rvu, pcifunc);
 
+	if (rvu->mcs_blk_cnt)
+		rvu_mcs_flr_handler(rvu, pcifunc);
+
 	mutex_unlock(&rvu->flr_lock);
 }
 
-- 
2.25.1

