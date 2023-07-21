Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC36775BC83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGUCm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGUCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:42:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80764272D;
        Thu, 20 Jul 2023 19:42:02 -0700 (PDT)
X-UUID: 265c45ba277011ee9cb5633481061a41-20230721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i634ZhMfSzfCWgqPzYo892EfK/lf78npMnhCjtYSpK4=;
        b=G8CsWhZnhH2DhybhO0Mg0IHuwnkVVyuHUxy5w57lkM00w3VgxrMGNGLDcWrIk4jgPAYdjevu5EmeSGr2XvkeYSxAf4pGCZh2fvs1MXpSAUx1bnnpPSjRrb+O5xpaHE6Hl6OsFbHhwJDYGOQsIF12V8EQdovHKF/NDabA9RcgOao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:99143d0a-992e-47ec-a7aa-0367688a419c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.28,REQID:99143d0a-992e-47ec-a7aa-0367688a419c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:176cd25,CLOUDID:d911de87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:230721104154FISEE1YH,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 265c45ba277011ee9cb5633481061a41-20230721
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 811468357; Fri, 21 Jul 2023 10:41:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jul 2023 10:41:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jul 2023 10:41:51 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v15 11/13] remoteproc: mediatek: Report watchdog crash to all cores
Date:   Fri, 21 Jul 2023 10:41:30 +0800
Message-ID: <20230721024132.6548-12-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230721024132.6548-1-tinghan.shen@mediatek.com>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure consistent behavior, the watchdog timeout handling of the
multi-core SCP should reset the whole SCP sub-system when watchdog
timeout. Triggering the rproc recovery flow on all instances will
ensure proper recovery of the SCP sub-system.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_scp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index fcd1dd9b3580..9ed2e18e36ba 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -68,8 +68,14 @@ EXPORT_SYMBOL_GPL(scp_put);
 
 static void scp_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
 {
+	struct mtk_scp_of_cluster *scp_cluster = scp->cluster;
+	struct mtk_scp *scp_node;
+
 	dev_err(scp->dev, "SCP watchdog timeout! 0x%x", scp_to_host);
-	rproc_report_crash(scp->rproc, RPROC_WATCHDOG);
+
+	/* report watchdog timeout to all cores */
+	list_for_each_entry(scp_node, &scp_cluster->mtk_scp_list, elem)
+		rproc_report_crash(scp_node->rproc, RPROC_WATCHDOG);
 }
 
 static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
-- 
2.18.0

