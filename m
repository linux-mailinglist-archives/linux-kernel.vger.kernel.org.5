Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F4802A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjLDCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjLDCHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:07:53 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D77A6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:07:57 -0800 (PST)
X-UUID: 014ab063981c49b5bb30737bf10e66c6-20231204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:a05bcdc4-b345-4b04-9792-be9ac9b1cfed,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-5
X-CID-INFO: VERSION:1.1.33,REQID:a05bcdc4-b345-4b04-9792-be9ac9b1cfed,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:b172c560-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:23120410075314KM9WVT,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 014ab063981c49b5bb30737bf10e66c6-20231204
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 124436007; Mon, 04 Dec 2023 10:07:49 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpe@ellerman.id.au,
        mrochs@linux.vnet.ibm.com
Cc:     kunwu.chan@hotmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] cxl: Fix null pointer dereference in cxl_get_fd
Date:   Mon,  4 Dec 2023 10:07:45 +0800
Message-Id: <20231204020745.2445944-1-chentao@kylinos.cn>
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

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: bdecf76e319a ("cxl: Fix coredump generation when cxl_get_fd() is used")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/misc/cxl/api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index d85c56530863..bfd7ccd4d7e1 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -419,6 +419,10 @@ struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
 		fops = (struct file_operations *)&afu_fops;
 
 	name = kasprintf(GFP_KERNEL, "cxl:%d", ctx->pe);
+	if (!name) {
+		put_unused_fd(fdtmp);
+		return ERR_PTR(-ENOMEM);
+	}
 	file = cxl_getfile(name, fops, ctx, flags);
 	kfree(name);
 	if (IS_ERR(file))
-- 
2.34.1

