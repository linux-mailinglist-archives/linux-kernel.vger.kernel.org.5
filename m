Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEBC80C310
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjLKIZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjLKIZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:25:23 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319CDED;
        Mon, 11 Dec 2023 00:25:27 -0800 (PST)
X-UUID: 3e989875f99e4d8eb39bd82da1667e6e-20231211
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:58c0d297-7572-4453-a73f-1fd9a016948b,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:58c0d297-7572-4453-a73f-1fd9a016948b,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:5286a573-1bd3-4f48-b671-ada88705968c,B
        ulkID:231211162515Q51SE72Y,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3e989875f99e4d8eb39bd82da1667e6e-20231211
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 342527585; Mon, 11 Dec 2023 16:25:14 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     colyli@suse.de, kent.overstreet@gmail.com
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>,
        Kunwu Chan <kunwu.chan@hotmail.com>
Subject: [PATCH] bcache: Fix NULL pointer dereference in bch_cached_dev_run
Date:   Mon, 11 Dec 2023 16:25:10 +0800
Message-Id: <20231211082510.262292-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
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

Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/md/bcache/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1402096b8076..40b657887d3b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1053,6 +1053,12 @@ int bch_cached_dev_run(struct cached_dev *dc)
 		NULL,
 	};
 
+	if (!env[1] || !env[2]) {
+		pr_err("Couldn't create bcache dev <-> fail to allocate memory\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	if (dc->io_disable) {
 		pr_err("I/O disabled on cached dev %pg\n", dc->bdev);
 		ret = -EIO;
-- 
2.39.2

