Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD5809A6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjLHDd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjLHDd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:33:28 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2410DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:33:33 -0800 (PST)
X-UUID: 09d5b064ee4344ea83f3188afeeefba2-20231208
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:46e542b3-30b2-4548-a52b-c14424f86ab6,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33,REQID:46e542b3-30b2-4548-a52b-c14424f86ab6,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:364b77b,CLOUDID:f5006dfd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231208113324ZJ22WU93,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULN
X-UUID: 09d5b064ee4344ea83f3188afeeefba2-20231208
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1135093599; Fri, 08 Dec 2023 11:33:23 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     lee@kernel.org, jpanis@baylibre.com
Cc:     kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] mfd: tps6594: Add null pointer check to tps6594_device_init
Date:   Fri,  8 Dec 2023 11:33:20 +0800
Message-Id: <20231208033320.49345-1-chentao@kylinos.cn>
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

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
Suggested-by: Lee Jones <lee@kernel.org>
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
v2
   - Simplified by returning error codes directly
---
 drivers/mfd/tps6594-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 0fb9c5cf213a..783ee59901e8 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -433,6 +433,9 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
 	tps6594_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
 					       dev->driver->name, tps->chip_id, tps->reg);
 
+	if (!tps6594_irq_chip.name)
+		return -ENOMEM;
+
 	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
 				       0, &tps6594_irq_chip, &tps->irq_data);
 	if (ret)
-- 
2.39.2

