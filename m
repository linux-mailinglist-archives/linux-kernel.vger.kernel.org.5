Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39D77F8C71
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjKYQfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjKYQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:34:40 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9B1A6;
        Sat, 25 Nov 2023 08:34:27 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3APGUF86003778;
        Sat, 25 Nov 2023 08:34:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=TEkupid8sBlLpSL/3VjNIN1K1+OhyKNF+UyoG9pF3cc=;
 b=jisgnSV1dx2kCVFd0y+QYuj+MWrEqT+Xho0eLKpQn6i+eDFgtnF4q9fMV7iIjkX1S3ln
 gbmZKrK2bVCsjUgrFw9iO8jYqNtWtU4wzQgKfjT5YUjDiwooWfC7L+/XITz145LE0vnk
 vUexBCoy42Vr9Vx8gL7dH0INxEdxcbftAXnztkFWL/bD22lZzxU7LeSPMpK7zR0EHqXb
 PaafgWObufiVlw/s543M8aYz+H9KG0Lh+3wKSwpEvvK6EUfVc3z7beFsl7Z95t52Dcu2
 7EeCsKeCtgz6SEMOplapxGez49+7Jqlz7/VqKNsIgH1UD6r4bDSyX+clH5sv/JdKg3zP ug== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ukhauga5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 08:34:16 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 25 Nov
 2023 08:34:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 25 Nov 2023 08:34:14 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
        by maili.marvell.com (Postfix) with ESMTP id 265325C68EA;
        Sat, 25 Nov 2023 08:34:10 -0800 (PST)
From:   Subbaraya Sundeep <sbhatta@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64
Date:   Sat, 25 Nov 2023 22:04:02 +0530
Message-ID: <1700930042-5400-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hfRqkjpy2dM6dk8JfR1WPjA2bU5zDA_a
X-Proofpoint-GUID: hfRqkjpy2dM6dk8JfR1WPjA2bU5zDA_a
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

From: Geetha sowjanya <gakula@marvell.com>

When more than 64 VFs are enabled for a PF then mbox communication
between VF and PF is not working as mbox work queueing for few VFs
are skipped due to wrong calculation of VF numbers.

Fixes: d424b6c02415 ("octeontx2-pf: Enable SRIOV and added VF mbox handling")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ba95ac9..6d56fc1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -566,7 +566,9 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 		otx2_write64(pf, RVU_PF_VFPF_MBOX_INTX(1), intr);
 		otx2_queue_work(mbox, pf->mbox_pfvf_wq, 64, vfs, intr,
 				TYPE_PFVF);
-		vfs -= 64;
+		if (intr)
+			trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+		vfs = 64;
 	}
 
 	intr = otx2_read64(pf, RVU_PF_VFPF_MBOX_INTX(0));
@@ -574,7 +576,8 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 
 	otx2_queue_work(mbox, pf->mbox_pfvf_wq, 0, vfs, intr, TYPE_PFVF);
 
-	trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+	if (intr)
+		trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4

