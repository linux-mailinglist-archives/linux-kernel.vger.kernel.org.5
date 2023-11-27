Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D136E7F97A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjK0Cvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjK0Cvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:51:40 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5310F;
        Sun, 26 Nov 2023 18:51:44 -0800 (PST)
X-UUID: fd0efa77564d405599e0cadfb6d7a94b-20231127
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:3717ac65-0896-4eaa-b5b9-085e5572100f,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:3717ac65-0896-4eaa-b5b9-085e5572100f,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:a9718160-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231127105132JY97HUR8,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: fd0efa77564d405599e0cadfb6d7a94b-20231127
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1705106248; Mon, 27 Nov 2023 10:51:31 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     manoj@linux.ibm.com, mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     kunwu.chan@hotmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] scsi: cxlflash: Fix null pointer dereference in ocxlflash_get_fd
Date:   Mon, 27 Nov 2023 10:51:27 +0800
Message-Id: <20231127025127.1545877-1-chentao@kylinos.cn>
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

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 926a62f9bd53 ("scsi: cxlflash: Support adapter file descriptors for OCXL")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 6542818e595a..aa5703a69bc0 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1231,6 +1231,11 @@ static struct file *ocxlflash_get_fd(void *ctx_cookie,
 		fops = (struct file_operations *)&ocxl_afu_fops;
 
 	name = kasprintf(GFP_KERNEL, "ocxlflash:%d", ctx->pe);
+	if (!name) {
+		rc = -ENOMEM;
+		dev_err(dev, "%s: kasprintf allocation failed\n", __func__);
+		goto err2;
+	}
 	file = ocxlflash_getfile(dev, name, fops, ctx, flags);
 	kfree(name);
 	if (IS_ERR(file)) {
-- 
2.34.1

