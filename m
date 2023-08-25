Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAFF788524
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbjHYKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbjHYKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:41:00 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BD173F;
        Fri, 25 Aug 2023 03:40:57 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P3d5Ut002288;
        Fri, 25 Aug 2023 03:40:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=t2pvIFE8MQJaMYgyaaNRppZgy+XMWUXObDnC2oe1/8Y=;
 b=e8r4hNcZY18+iTmP2AaICWVrzXvkDqOElcIIaj1TsrAc/3j5pfSYLu2HfW13T/zj9iLZ
 MMfylXLaTaiztKpFV9lI9W0VSOi4+m5FImdp8T7NJCKMzUWvk4Mn8HffXkxC+38GKDka
 tmCNSRv1sv/831ScNi07eV+JPRB70pddOduzlq5P0ncSNw2/SaECoolWb8EBy6RFiuBe
 u/lzoL1c1cjF2FKma4ezkucLZk6MsUPY+xtzKb1cOwGQOgQI5t9V2WsrYSFVoLJ0Pwed
 N3OrYoEk7nY+ONfe0Jq8HyaLuUjUsPrq+S5D/SXhOIK0p4lH0khUeHGzMLEAOgLyHQPF qg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3spmk291vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 03:40:49 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 03:40:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 25 Aug 2023 03:40:47 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 29CC63F7096;
        Fri, 25 Aug 2023 03:40:42 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2 4/4] octeontx2-af: print error message incase of invalid pf mapping
Date:   Fri, 25 Aug 2023 16:10:22 +0530
Message-ID: <20230825104022.16288-5-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825104022.16288-1-hkelam@marvell.com>
References: <20230825104022.16288-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WvhABB_kl5CMKMkUS4FACsPLJtvZkLQx
X-Proofpoint-GUID: WvhABB_kl5CMKMkUS4FACsPLJtvZkLQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 4e3aec7bdbee..f2b1edf1bb43 100644
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

