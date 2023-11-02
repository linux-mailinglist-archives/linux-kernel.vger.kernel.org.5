Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C37DEC3F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbjKBF0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348523AbjKBF0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:26:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617A6116;
        Wed,  1 Nov 2023 22:26:21 -0700 (PDT)
X-UUID: 5377e546794011ee8051498923ad61e6-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rlsif4ZFTca+eY2ZA2T8CDailYwP0BK2oKzGYMrtj/o=;
        b=BFvcSfqFYIzavPXUJ+5MjrGZ4Nwh+0rDZOz1kbaoLZQ3Q2TDgR6y2Aux4ZGYP+oDu2QwsPS1FgGfOKJy+ZkhOH16cyyJhd+gKzfRmzhHqW8+qMRiWvtzF9TXpmAug/WLS6hElxpwLAgdxN15DTTVbHF3Z7WvgZwIlg5ej/BQWEc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:b962db98-cb79-4301-a7e9-1dc1344e5a7e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:88ea965f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5377e546794011ee8051498923ad61e6-20231102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <naomi.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1726038131; Thu, 02 Nov 2023 13:26:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 13:26:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 13:26:06 +0800
From:   <naomi.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <casper.li@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to DeviceQueueDepth + 1
Date:   Thu, 2 Nov 2023 13:24:24 +0800
Message-ID: <20231102052426.12006-2-naomi.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231102052426.12006-1-naomi.chu@mediatek.com>
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.972200-8.000000
X-TMASE-MatchedRID: zfURmU8ZpfFehll0JtAbYS1Hx9UxMGjdP2/oiZRTnW/nD8OB/Tc9os7P
        jWXN0Yiv0UKtSUr3c5JNLy5V2gDccNkPtqv8VrRJ7spMO3HwKCBCX8V1FiRRktVTZaI6TuNo4nP
        T8jZv1NHi8zVgXoAltsIJ+4gwXrEtWBd6ltyXuvu54yg6atPTl9jC2YE+B5qM7bPFPqc46vfpvj
        PU/kx5iJ5Hk4JddbJQC1BC+x/F4/rZtHw34RTA7rmywIZuCO7ltYzBRJiBZNuAhOcaQrQ0U1GyR
        coeF18qmKP0zzpTAeGwod8xOMKmvMCBO+zxAW5pftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.972200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C9DCDF7A4917A6AB6CA69165C494FC7E94109658CA567B084E43FB4D3418AD782000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naomi Chu <naomi.chu@mediatek.com>

The UFSHCI 4.0 specification mandates that there should always be at
least one empty slot in each queue for distinguishing between full and
empty states. Enlarge the `hwq->max_entries` to `DeviceQueueDepth +1`
to allow UFSHCI 4.0 controllers to fully utilize MCQ queue slots.

Fixes: 4682abfae2eb ("scsi: ufs: core: mcq: Allocate memory for MCQ mode")
Signed-off-by: Naomi Chu <naomi.chu@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 2ba8ec254dce..5c75ab9d6bb5 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -436,7 +436,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 
 	for (i = 0; i < hba->nr_hw_queues; i++) {
 		hwq = &hba->uhq[i];
-		hwq->max_entries = hba->nutrs;
+		hwq->max_entries = hba->nutrs + 1;
 		spin_lock_init(&hwq->sq_lock);
 		spin_lock_init(&hwq->cq_lock);
 		mutex_init(&hwq->sq_mutex);
-- 
2.18.0

