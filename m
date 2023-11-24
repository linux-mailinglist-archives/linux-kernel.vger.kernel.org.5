Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B47F6D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjKXHuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:50:40 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15497D44;
        Thu, 23 Nov 2023 23:50:45 -0800 (PST)
X-UUID: 1552beee8cc441bbb03aba778b822927-20231124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f220a046-a202-49f3-b93b-e8478b749bcf,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:f220a046-a202-49f3-b93b-e8478b749bcf,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:7462e7fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231124155029R77NN2E6,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1552beee8cc441bbb03aba778b822927-20231124
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2127809040; Fri, 24 Nov 2023 15:50:29 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        sre@kernel.org, caleb.connolly@linaro.org
Cc:     kunwu.chan@hotmail.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] power: supply: Fix null pointer dereference in smb2_probe
Date:   Fri, 24 Nov 2023 15:50:21 +0800
Message-Id: <20231124075021.1335289-1-chentao@kylinos.cn>
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

devm_kasprintf and devm_kzalloc return a pointer to dynamically
allocated memory which can be NULL upon failure.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 8acf63ee6897..9bb777406013 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -972,10 +972,14 @@ static int smb2_probe(struct platform_device *pdev)
 	supply_config.of_node = pdev->dev.of_node;
 
 	desc = devm_kzalloc(chip->dev, sizeof(smb2_psy_desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
 	memcpy(desc, &smb2_psy_desc, sizeof(smb2_psy_desc));
 	desc->name =
 		devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
 			       (const char *)device_get_match_data(chip->dev));
+	if (!desc->name)
+		return -ENOMEM;
 
 	chip->chg_psy =
 		devm_power_supply_register(chip->dev, desc, &supply_config);
-- 
2.34.1

