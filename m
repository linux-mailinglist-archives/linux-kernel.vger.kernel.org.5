Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFF7EED0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjKQICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:02:14 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEAED50;
        Fri, 17 Nov 2023 00:02:08 -0800 (PST)
X-UUID: 54d04286c9c24d73a5850da049f946f9-20231117
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:179ae52a-1ee6-4cc2-9089-f74a29b274b8,IP:15,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:26
X-CID-INFO: VERSION:1.1.32,REQID:179ae52a-1ee6-4cc2-9089-f74a29b274b8,IP:15,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:26
X-CID-META: VersionHash:5f78ec9,CLOUDID:ff142c60-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2311171602009NUW4FWO,BulkQuantity:0,Recheck:0,SF:17|19|45|66|38|24|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULS
X-UUID: 54d04286c9c24d73a5850da049f946f9-20231117
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 601564670; Fri, 17 Nov 2023 16:01:59 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com, Kunwu Chan <chentao@kylinos.cn>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] scsi: qedi: Fix an endian bug in qedi_ring_doorbell
Date:   Fri, 17 Nov 2023 16:01:51 +0800
Message-Id: <20231117080151.1825970-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/qedi/qedi_fw.c:932:40: sparse: sparse: incorrect type in
assignment (different base types) expected restricted __le16
[usertype] sq_prod got unsigned short [usertype] fw_sq_prod_idx

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202311161351.7sPcpket-lkp@intel.com/
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/scsi/qedi/qedi_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 6901738324da..72da9dce4e6f 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -922,7 +922,7 @@ void qedi_fp_process_cqes(struct qedi_work *work)
 
 static void qedi_ring_doorbell(struct qedi_conn *qedi_conn)
 {
-	qedi_conn->ep->db_data.sq_prod = qedi_conn->ep->fw_sq_prod_idx;
+	qedi_conn->ep->db_data.sq_prod = cpu_to_le16(qedi_conn->ep->fw_sq_prod_idx);
 
 	/* wmb - Make sure fw idx is coherent */
 	wmb();
-- 
2.34.1

