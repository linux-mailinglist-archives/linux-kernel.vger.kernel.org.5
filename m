Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782497803F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357311AbjHRCqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357288AbjHRCp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:45:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDC63A91;
        Thu, 17 Aug 2023 19:45:53 -0700 (PDT)
X-UUID: 56f1cfee3d7111ee9cb5633481061a41-20230818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YuRpMYUsTz6Ix5NA6ot3RfU99bP5fMTtwrOEIpm5/iw=;
        b=Q+KkmEJplkWQ3wvg8gJqN75bq8PaDmxieM2XfBdPmENuBLPx73yGOBBhmyUHn+8bTCUH5ocsjjwuV8o0zKE3KMuoJL+YhNYcxnIT9QWMI+3y2j+MKUFPaNoz3W3I9sQZ9xcRdLep8fs1qFBsgrAwcn0ixx/tsGFP2fPb7+CW0TY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:9f084b76-bdc2-4d3c-9b22-826d6f28bca4,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.31,REQID:9f084b76-bdc2-4d3c-9b22-826d6f28bca4,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:0ad78a4,CLOUDID:c248fdc1-1e57-4345-9d31-31ad9818b39f,B
        ulkID:230818104550QUCSL7YS,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 56f1cfee3d7111ee9cb5633481061a41-20230818
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <sharp.xia@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 984509178; Fri, 18 Aug 2023 10:45:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 18 Aug 2023 10:45:48 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 18 Aug 2023 10:45:47 +0800
From:   <Sharp.Xia@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@medaitek.com>, Sharp Xia <Sharp.Xia@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Date:   Fri, 18 Aug 2023 10:28:15 +0800
Message-ID: <20230818022817.3341-1-Sharp.Xia@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sharp Xia <Sharp.Xia@mediatek.com>

MMC does not set readahead and uses the default VM_READAHEAD_PAGES
resulting in slower reading speed.
Use the max_req_size reported by host driver to set the optimal
I/O size to improve performance.

Signed-off-by: Sharp Xia <Sharp.Xia@mediatek.com>
---
 drivers/mmc/core/queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b396e3900717..fc83c4917360 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -359,6 +359,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
+	blk_queue_io_opt(mq->queue, host->max_req_size);
 	if (host->can_dma_map_merge)
 		WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
 							mmc_dev(host)),
-- 
2.18.0

