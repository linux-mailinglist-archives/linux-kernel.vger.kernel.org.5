Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25F7AEA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjIZKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjIZKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:19:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280DCB3;
        Tue, 26 Sep 2023 03:19:18 -0700 (PDT)
X-UUID: 24bd6b605c5611eea33bb35ae8d461a2-20230926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=40Z60dywDiXam7OraAE9s6YIBV6xPjNlnKiDsQUuJu8=;
        b=ZJYpMlQezmvm/RmzGzn6vV5ZFBg1gKBchkKwIG6vxZTAA0mrYk7dUZgCaENnaOsqD7L2ODhzHn8WC2URQcL8D25I7nO4Hc7TCArzm/pNVPlGALw6DVmpy+FP/xoqa7yl0W9Ui56Tui6wKaE8zxUybJETEl7mqkHs9SDuVbfWGD0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:930616cf-7dfb-41c7-abd0-f72459a68d0a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:72214abf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 24bd6b605c5611eea33bb35ae8d461a2-20230926
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 560594802; Tue, 26 Sep 2023 18:19:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Sep 2023 18:19:14 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Sep 2023 18:19:13 +0800
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
Subject: [PATCH 2/2] media: mediatek: vcodec: Handle encoder vsi NULL pointer case
Date:   Tue, 26 Sep 2023 18:19:09 +0800
Message-ID: <20230926101909.15030-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926101909.15030-1-irui.wang@mediatek.com>
References: <20230926101909.15030-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.091600-8.000000
X-TMASE-MatchedRID: cp51Uxq7L6sEshQLfIZrysnlbo5l7mGFJwFLIHVZ6fvfc2Xd6VJ+yrx1
        VMA+w2QulTJXKqh1ne29cOdjc/43lZH0YXYnbGozFEUknJ/kEl4YSQiB0ZTudfoLR4+zsDTtIFg
        EzOKKV2ZWlXDJGO9dw1RaeKIGTQfJwTnaD7mFxuQCohBZVD+eQlZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.091600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5C163453A2C201611508BB54AA4306416D94492B541BA8C6922B690B29CF1F5F2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be a kernel null pointer exception if 'vsi' is NULL, check
'vsi' is not NULL before assign it to encoder instance.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/encoder/venc/venc_h264_if.c     | 5 +++++
 .../platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
index a68dac72c4e4..385bcc0d14f3 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
@@ -597,6 +597,11 @@ static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
 
 	ret = vpu_enc_init(&inst->vpu_inst);
+	if (!inst->vpu_inst.vsi) {
+		mtk_venc_err(ctx, "share buffer is NULL");
+		kfree(inst);
+		return -EFAULT;
+	}
 
 	if (MTK_ENC_IOVA_IS_34BIT(ctx))
 		inst->vsi_34 = (struct venc_h264_vsi_34 *)inst->vpu_inst.vsi;
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
index 05abca91e742..23ca0d93324f 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
@@ -326,6 +326,11 @@ static int vp8_enc_init(struct mtk_vcodec_enc_ctx *ctx)
 	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_LT_SYS);
 
 	ret = vpu_enc_init(&inst->vpu_inst);
+	if (!inst->vpu_inst.vsi) {
+		mtk_venc_err(ctx, "share buffer is NULL");
+		kfree(inst);
+		return -EFAULT;
+	}
 
 	inst->vsi = (struct venc_vp8_vsi *)inst->vpu_inst.vsi;
 
-- 
2.25.1

