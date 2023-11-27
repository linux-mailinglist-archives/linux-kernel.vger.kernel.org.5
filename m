Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200C77F9A00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjK0GgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjK0GgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:36:05 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F571A3;
        Sun, 26 Nov 2023 22:36:01 -0800 (PST)
X-UUID: f5e64f129679413891f4ef926f41a2d5-20231127
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:87602af9-271c-4a35-b31d-9ad5ad5bf2f6,IP:15,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-INFO: VERSION:1.1.33,REQID:87602af9-271c-4a35-b31d-9ad5ad5bf2f6,IP:15,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:f47afcfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231127143550DH1I147D,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_FAS
X-UUID: f5e64f129679413891f4ef926f41a2d5-20231127
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2006990806; Mon, 27 Nov 2023 14:35:47 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        vadimp@nvidia.com, jiri@resnulli.us, shravankr@nvidia.com
Cc:     kunwu.chan@hotmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] platform/mellanox: Add a null pointer check in mlxbf_pmc_create_groups
Date:   Mon, 27 Nov 2023 14:34:33 +0800
Message-Id: <20231127063433.1549064-1-chentao@kylinos.cn>
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

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 0b427fc24a96..59bbe5e13f6b 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1882,6 +1882,8 @@ static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
 	pmc->block[blk_num].block_attr_grp.attrs = pmc->block[blk_num].block_attr;
 	pmc->block[blk_num].block_attr_grp.name = devm_kasprintf(
 		dev, GFP_KERNEL, pmc->block_name[blk_num]);
+	if (!pmc->block[blk_num].block_attr_grp.name)
+		return -ENOMEM;
 	pmc->groups[pmc->group_num] = &pmc->block[blk_num].block_attr_grp;
 	pmc->group_num++;
 
-- 
2.34.1

