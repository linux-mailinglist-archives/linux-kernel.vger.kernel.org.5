Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FDB7AEA31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjIZKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:19:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50DBE;
        Tue, 26 Sep 2023 03:19:21 -0700 (PDT)
X-UUID: 23f7105a5c5611ee8051498923ad61e6-20230926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9pAB4vHxgXuOrF3cQ2v7MgCCwLtC7aUzC54ZVS4HYqQ=;
        b=K8bbdp7gq1NlWfol4J5gyjwhwQRd431TAgeFUo+8LQzkjfnkyJwQV7udbjxAInoKdjl/BfdY78D5v5YRqFl0/4hNuLUsjEVhISr/Hr1Rl8Dx3s3oUjl7HXimQ+gO4lmw+sd1oYscZVbI1eiUEntCaXBM9jWYR3cQIWf1Eg5JLaY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c203cc9a-560b-47d2-864c-7ac8f240f8c7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:5f214abf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 23f7105a5c5611ee8051498923ad61e6-20230926
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1048358028; Tue, 26 Sep 2023 18:19:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Sep 2023 18:19:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Sep 2023 18:19:10 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Subject: [PATCH 1/2] media: mediatek: vcodec: Fix encoder access NULL pointer
Date:   Tue, 26 Sep 2023 18:19:08 +0800
Message-ID: <20230926101909.15030-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.105600-8.000000
X-TMASE-MatchedRID: GEfnc4mEQr+uhCBFl/b63nQIOMndeKgE5Y0kb0hqatxnerzbhugqspVD
        ZsT0rYWCzpwM53iUVtXbCHv011Gy9dS7ezKc1AokngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIx1F
        PlNAAmcDr4JEOMLTOvRaDB3e61dbj0hR2WQtXdazG0iw/N0V7hZ6oP1a0mRIj
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.105600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F52746FEAA883B08C25F18637D5B84EC5699F7FD68D85E3D7C3A99FE851EC73F2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to set the private data with encoder device, or will access
NULL pointer in encoder handler.

Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
index d299cc2962a5..ae6290d28f8e 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
@@ -138,7 +138,8 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
 	vpu->ctx->vpu_inst = vpu;
 
 	status = mtk_vcodec_fw_ipi_register(vpu->ctx->dev->fw_handler, vpu->id,
-					    vpu_enc_ipi_handler, "venc", NULL);
+					    vpu_enc_ipi_handler, "venc",
+					    vpu->ctx->dev);
 
 	if (status) {
 		mtk_venc_err(vpu->ctx, "vpu_ipi_register fail %d", status);
-- 
2.25.1

