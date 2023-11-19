Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA66D7F0682
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjKSNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjKSNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:40:43 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E479E6;
        Sun, 19 Nov 2023 05:40:37 -0800 (PST)
X-UUID: acb510e49d924fe2a26b7b2e735369e7-20231119
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:818b19ef-3f45-4b5d-9838-c3dd21cdabbd,IP:15,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:818b19ef-3f45-4b5d-9838-c3dd21cdabbd,IP:15,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:25298f95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231119214015QRM3A46K,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: acb510e49d924fe2a26b7b2e735369e7-20231119
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 141419594; Sun, 19 Nov 2023 21:40:13 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     kunwu.chan@hotmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] scsi: qedi: Fix warning of restricted __le32 degrades to integer in qedi_main.c
Date:   Sun, 19 Nov 2023 21:40:09 +0800
Message-Id: <20231119134009.8015-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/qedi/qedi_main.c:1867:37: warning: restricted __le32 degrades to integer

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/scsi/qedi/qedi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cd0180b1f5b9..3f5b148347d2 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1864,7 +1864,7 @@ void qedi_get_task_tid(struct qedi_ctx *qedi, u32 itt, s16 *tid)
 	u16 i;
 
 	for (i = 0; i < MAX_ISCSI_TASK_ENTRIES; i++) {
-		if (qedi->itt_map[i].itt == itt) {
+		if (le32_to_cpu(qedi->itt_map[i].itt) == itt) {
 			*tid = i;
 			QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_CONN,
 				  "Ref itt=0x%x, found at tid=0x%x\n",
-- 
2.34.1

