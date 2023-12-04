Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37DD802E78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjLDJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:25:09 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F1C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:25:14 -0800 (PST)
X-UUID: ca51dacefc1d4e65b834832015ee8d7b-20231204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:2ddbf53d-f3cd-4a14-8e9e-fa6542c7399c,IP:5,U
        RL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-45
X-CID-INFO: VERSION:1.1.33,REQID:2ddbf53d-f3cd-4a14-8e9e-fa6542c7399c,IP:5,URL
        :0,TC:0,Content:-5,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
        ION:release,TS:-45
X-CID-META: VersionHash:364b77b,CLOUDID:4991ca60-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231204172511L5AJDDL3,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
        02,TC:nil,Content:0,EDM:2,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULN
X-UUID: ca51dacefc1d4e65b834832015ee8d7b-20231204
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1216688055; Mon, 04 Dec 2023 17:25:08 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     lee@kernel.org, arnd@arndb.de, s-anna@ti.com
Cc:     kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] mfd: syscon: Fix null pointer dereference in of_syscon_register
Date:   Mon,  4 Dec 2023 17:24:43 +0800
Message-Id: <20231204092443.2462115-1-chentao@kylinos.cn>
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

Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/mfd/syscon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 57b29c325131..c9550368d9ea 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -105,6 +105,10 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	}
 
 	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
+	if (!syscon_config.name) {
+		ret = -ENOMEM;
+		goto err_regmap;
+	}
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
-- 
2.34.1

