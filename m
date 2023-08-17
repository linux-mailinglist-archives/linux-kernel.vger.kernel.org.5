Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224077F51B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350286AbjHQLZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbjHQLYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:24:48 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F492D58;
        Thu, 17 Aug 2023 04:24:47 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H40ZA6017037;
        Thu, 17 Aug 2023 04:24:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=RyJ/uHSPDNaab5kS2BnFEMOg0mgJk4d9fXfN3jHpmp8=;
 b=Zk3fjeh1pm0rbIMHqwtdEgTRYwkl5AlkrsEEXyuhBa4hBPqbVLrvfH69qbF22m2hNQBV
 3oKXN3W9R4ZG4vs2jCs3TKiiaCMHZnzUbmtkfe6a6hE2CgSk0sqmMzTCFIC0Ok3u06fH
 IcJgrGQ0a7Ly3kcFyHKb7vZzOtXscKjwxWW4hLsEX4UGCgp3eebVCOFesKgKo1LBbQIz
 isuApR/vMuHqkYmprJ/FCUYAJfZLm8QdZfr9i3vjvv+2kyPfruvwCBMCTH9JA+3IYIKU
 UwchTGliyrXcsv7jvtAJQMswy7X6GTjrzaKw6iZp02v3AWBXs90FijLDvK/pNzhqW1Cu CQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sgptkwmg9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 04:24:40 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 04:24:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 17 Aug 2023 04:24:34 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 81B783F705C;
        Thu, 17 Aug 2023 04:24:29 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next Patch 5/5] octeontx2-af: print error message incase of invalid pf mapping
Date:   Thu, 17 Aug 2023 16:53:57 +0530
Message-ID: <20230817112357.25874-6-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817112357.25874-1-hkelam@marvell.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YadIiLGREVF5O8x260eFhIRKafHUlGTK
X-Proofpoint-GUID: YadIiLGREVF5O8x260eFhIRKafHUlGTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During AF driver initialization, it creates a mapping between pf to
cgx,lmac pair. Whenever there is a physical link change, using this
mapping driver forwards the message to the associated netdev.

This patch prints error message incase of cgx,lmac pair is not
associated with any pf netdev.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index c96a94303a54..8845d50c5b78 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -236,6 +236,11 @@ static void cgx_notify_pfs(struct cgx_link_event *event, struct rvu *rvu)
 
 	linfo = &event->link_uinfo;
 	pfmap = cgxlmac_to_pfmap(rvu, event->cgx_id, event->lmac_id);
+	if (!pfmap) {
+		dev_err(rvu->dev, "CGX port%d:%d not mapped with PF\n",
+			event->cgx_id, event->lmac_id);
+		return;
+	}
 
 	do {
 		pfid = find_first_bit(&pfmap,
-- 
2.17.1

