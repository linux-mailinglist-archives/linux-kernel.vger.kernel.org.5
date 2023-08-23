Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD973785BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjHWPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjHWPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2402E6D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:14:02 -0700 (PDT)
X-UUID: ac7ae97841c711ee9cb5633481061a41-20230823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vjHuAJtTxIQICn+XE23r+luFt5cxy+hHcBNHmzHlyYE=;
        b=DDgYc9n/xAvvDAUdioDFCXUKq2dw8cqegi0XG+pB3Y12d0T5qP/SzdN834r61ownZ4fqrfw0KZ6q9Jq4EuYwSZuckdnRBFSpW8vOLMQILu8Tq1PFDRelYbwsG6uIXh6ljhQUtkp5Ld7lzTKCIhgcwXxpvX8ZFSQB4L06HoBAGfU=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.31,REQID:3dbafdc2-e34d-4a73-99ba-c8bb347e4b3d,IP:0,U
        RL:0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:195
X-CID-INFO: VERSION:1.1.31,REQID:3dbafdc2-e34d-4a73-99ba-c8bb347e4b3d,IP:0,URL
        :0,TC:0,Content:100,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_US65DF41,ACTI
        ON:quarantine,TS:195
X-CID-META: VersionHash:0ad78a4,CLOUDID:0d6bddee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230823231355BXHISX8G,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|8
        01,TC:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: ac7ae97841c711ee9cb5633481061a41-20230823
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 980679952; Wed, 23 Aug 2023 23:13:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Aug 2023 23:13:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Aug 2023 23:13:52 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH 04/15] mailbox: mtk-cmdq: Support GCE thread loop
Date:   Wed, 23 Aug 2023 23:13:21 +0800
Message-ID: <20230823151332.28811-5-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230823151332.28811-1-shawn.sung@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not disable CMDQ thread if it is a loop.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 5 +++++
 include/linux/mailbox/mtk-cmdq-mailbox.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index b18d47ea13a0..88ff39a28415 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -264,6 +264,11 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) << cmdq->pdata->shift;
 
+	task = list_first_entry_or_null(&thread->task_busy_list,
+					struct cmdq_task, list_entry);
+	if (task && task->pkt->loop)
+		return;
+
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
 		task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index a8f0070c7aa9..f78a08e7c6ed 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -76,6 +76,7 @@ struct cmdq_pkt {
 	size_t			cmd_buf_size; /* command occupied size */
 	size_t			buf_size; /* real buffer size */
 	void			*cl;
+	bool			loop;
 };
 
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
-- 
2.18.0

