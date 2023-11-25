Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618E7F8C73
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjKYQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjKYQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:35:21 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C110D7;
        Sat, 25 Nov 2023 08:35:12 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3APGQdxW031342;
        Sat, 25 Nov 2023 08:35:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=1ewM6MqFrt1Nn4jz3SiK0ncDnmr3if++qJDwehzsdVs=;
 b=bFGjg40aa74WZm2WvVuWgZEFyX1IgEF+yXniCAhCy7w9EP8Fr2X5xJKm1luGcMFBP5fH
 zrBhDU1Q+qa1+DB1zC+M3gE8vsGgmqpsyeuWVR9LbJsM2b8Gmvl0PD3grp6gikwqGa3a
 6EXzAHA8AjCkr2GDhwlKCiOft0GBTIA0bOmHcLA93Avow0P3VSy+C3qNYO6OMpgT50Pl
 wz3pblCzTnKTQ2yevTA61O6pQiNT/wyByWPqBOjzAAPZMxEGgWH4mqS8hVxXzozYMU8D
 8j7oQ9Wkr8+1RUyKjiMzMxRemO+5s3NuKBWly++msHxWSt/LXlJgDTIgmhDkQysyNQSd Kw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ukhauga7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 08:35:05 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 25 Nov
 2023 08:35:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 25 Nov 2023 08:35:03 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
        by maili.marvell.com (Postfix) with ESMTP id 550DC5C68EA;
        Sat, 25 Nov 2023 08:35:00 -0800 (PST)
From:   Subbaraya Sundeep <sbhatta@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-af: Check return value of nix_get_nixlf before using nixlf
Date:   Sat, 25 Nov 2023 22:04:58 +0530
Message-ID: <1700930098-5483-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y0GSHBAhKzz3jiJ0plfk7mdBjibKYs-Z
X-Proofpoint-GUID: Y0GSHBAhKzz3jiJ0plfk7mdBjibKYs-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_16,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

