Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBA7D4AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJXIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjJXIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:44:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A91199;
        Tue, 24 Oct 2023 01:44:12 -0700 (PDT)
X-UUID: 7d13e7f4724911ee8051498923ad61e6-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iN/cYNw0UBNU6pS7nhFH1FIimWvZP96iaW/lpJmIqTw=;
        b=hb5ZPBvOHXRMszD2tulqM6eEWslsMET4yNvb50MwB1e6BgAQ8b56WhUveCOD23wgaUi5JVz5XqjFsAi3P7JFuW4VJAiSml0wl+YVaRzI4UX9JpHNXfB/pqspnD+rVtBdvy/epr8VhKMP4xRRN1/xI67so4y70QRs0BP5Io5mASI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:55f39eb6-88a8-45b1-94c7-3648bf8656d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:b48840d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7d13e7f4724911ee8051498923ad61e6-20231024
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1507860021; Tue, 24 Oct 2023 16:44:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 16:44:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 16:44:03 +0800
From:   <alice.chao@mediatek.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
        <peter.wang@mediatek.com>, <powen.kao@mediatek.com>,
        <naomi.chu@mediatek.com>, <cc.chou@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <casper.li@mediatek.com>, Alice Chao <alice.chao@mediatek.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] core: ufs: fix racing issue between force complete and isr
Date:   Tue, 24 Oct 2023 16:43:21 +0800
Message-ID: <20231024084324.12197-1-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.717400-8.000000
X-TMASE-MatchedRID: 4PO3xRYykVLSny9D3D7cj0Zakoam9+aebd6rGhWOAwRNShtWKzkFv8bB
        l+mdYPNDSJ98p/k48isBtjkcfRMmqZH0YXYnbGozFEUknJ/kEl7dB/CxWTRRuzBqYATSOgWj78T
        SUWAmEuXDhdFgIBeVjG+CyFalGpOx8YHPyIbJBEDSU+hTwCSC7435hht3qJMTDFM6+OpJabFtlz
        Lk1e/pyNvWO5JXDjg6gITnGkK0NFNRskXKHhdfKpij9M86UwHhsKHfMTjCprzAgTvs8QFuaX7cG
        d19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.717400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4F8ECFD8968BA5811C9F2C3A81AE4EDBFB36B326E3EB9A5C89A185A3FA9E72622000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Chao <alice.chao@mediatek.com>

While error handler force complete command (Thread A) and completion irq
raising (Thread B) of the same command, it may cause race condition.

Below is racing step (from 1 to 6):
	ufshcd_mcq_compl_pending_transfer (Thread A)
1	if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
5		spin_lock_irqsave(&hwq->cq_lock, flags);	// wait lock release
		set_host_byte(cmd, DID_REQUEUE);
6		ufshcd_release_scsi_cmd(hba, lrbp);	// access null pointer
		scsi_done(cmd);
		spin_unlock_irqrestore(&hwq->cq_lock, flags);
	}

	ufshcd_mcq_poll_cqe_lock (Thread B)
2	spin_lock_irqsave(&hwq->cq_lock, flags);
	 ufshcd_mcq_poll_cqe_nolock()
	  ufshcd_compl_one_cqe()
3	   ufshcd_release_scsi_cmd()	// lrbp->cmd = NULL;
4	spin_unlock_irqrestore(&hwq->cq_lock, flags);

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8382e8cfa414..ef6bd146a767 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5518,13 +5518,13 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 			 * For those cmds of which the cqes are not present
 			 * in the cq, complete them explicitly.
 			 */
+			spin_lock_irqsave(&hwq->cq_lock, flags);
 			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
-				spin_lock_irqsave(&hwq->cq_lock, flags);
 				set_host_byte(cmd, DID_REQUEUE);
 				ufshcd_release_scsi_cmd(hba, lrbp);
 				scsi_done(cmd);
-				spin_unlock_irqrestore(&hwq->cq_lock, flags);
 			}
+			spin_unlock_irqrestore(&hwq->cq_lock, flags);
 		} else {
 			ufshcd_mcq_poll_cqe_lock(hba, hwq);
 		}
-- 
2.18.0

