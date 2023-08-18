Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB697803BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357215AbjHRCR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357211AbjHRCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:17:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0E3589;
        Thu, 17 Aug 2023 19:17:50 -0700 (PDT)
X-UUID: 6b5f923a3d6d11ee9cb5633481061a41-20230818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2Z2wzmI8dgxrpulUWgeoh6/Sd2+6AGOoVETN0WTE9p8=;
        b=sneZgkzYS0MAm93o2qcyOIC/zR6QZVmHLs06UH1e9g5Ket936tHNTtDhxU4qeRnUFlsiOfzqfUI+ycmR9qsLGZSr9DHO1+IslyQuueSw8Swdy9Xi0U1Ikyz2gwRsmzmby97eqtdHg4O5OtJgMdfhokPVyAlcDl9pJm3JUGKifig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f05789b7-a5f4-43f3-b176-e3aa465d622c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:f05789b7-a5f4-43f3-b176-e3aa465d622c,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:4013a9ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:2308181017462TQ0VDES,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 6b5f923a3d6d11ee9cb5633481061a41-20230818
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 322382278; Fri, 18 Aug 2023 10:17:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 18 Aug 2023 10:17:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 18 Aug 2023 10:17:44 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH] PM / devfreq: mediatek: protect oop in critical session
Date:   Fri, 18 Aug 2023 10:17:41 +0800
Message-ID: <20230818021741.6173-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_ccifreq_opp_notifier is reenter function when policy0 / policy6
change freq, so metex_lock should protect all OPP event.

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/devfreq/mtk-cci-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 83a73f0ccd80..b0ed25e33f2b 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -137,6 +137,8 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 	if (drv->pre_freq == *freq)
 		return 0;
 
+	mutex_lock(&drv->reg_lock);
+
 	inter_voltage = drv->inter_voltage;
 	cci_pll = clk_get_parent(drv->cci_clk);
 
@@ -147,8 +149,6 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 		return PTR_ERR(opp);
 	}
 
-	mutex_lock(&drv->reg_lock);
-
 	voltage = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
 
@@ -227,9 +227,9 @@ static int mtk_ccifreq_opp_notifier(struct notifier_block *nb,
 	drv = container_of(nb, struct mtk_ccifreq_drv, opp_nb);
 
 	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
+		mutex_lock(&drv->reg_lock);
 		freq = dev_pm_opp_get_freq(opp);
 
-		mutex_lock(&drv->reg_lock);
 		/* current opp item is changed */
 		if (freq == drv->pre_freq) {
 			volt = dev_pm_opp_get_voltage(opp);
-- 
2.18.0

