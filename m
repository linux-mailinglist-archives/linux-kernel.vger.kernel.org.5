Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A627AAA97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjIVHmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjIVHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:42:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972F18F;
        Fri, 22 Sep 2023 00:41:52 -0700 (PDT)
X-UUID: 7d265c96591b11ee8051498923ad61e6-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+/pJuaWVfK0hGb+ThWfQw2tcR3ge/i6YNChUHLyY9i0=;
        b=E/y9Us4SS8G5vmy+ynW28R1J2jHaAQUK1jjseQmZSOzHDB3g+uMmBg2Iw2k4wpeCtZxtSjYfzwAg98a817wHI58eeRQN34Dy/ErYUPv/rfq7D0MfxCvMmOTkfRrVNIU6ghL9Bw/cewOFQw2s7CpomSYwScvlej8bBiWyPuyREDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:511b6493-76e5-4ff5-b7f5-dd77204c6917,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:636724bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7d265c96591b11ee8051498923ad61e6-20230922
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1704723435; Fri, 22 Sep 2023 15:41:49 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 15:41:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 15:41:48 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v6 13/13] media: platform: mtk-mdp3: fix uninitialized variable in mdp_path_config()
Date:   Fri, 22 Sep 2023 15:41:45 +0800
Message-ID: <20230922074145.11977-14-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230922074145.11977-1-moudy.ho@mediatek.com>
References: <20230922074145.11977-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.823600-8.000000
X-TMASE-MatchedRID: KmnKUkn6ieOhL93N5VXnFISvKOGqLLPKFKliqHKCaOkqNag3uuW+4vhT
        6/pHvNpJzmy+RYEtL0m0k1objFiL4GGN6M1vhJ4HXP5rFAucBUG4vBuE2X0HlVxTR00Ss4P6+Vi
        hXqn9xLHGUnHlYVkOyLEivwZSlRnNGbjm5ZdalUGeAiCmPx4NwGmRqNBHmBvepuP9zg477pEqtq
        5d3cxkNRM5v80OeBIlEWExHZty1DxGMYElNJjuepGZ9wEbtJXwDMBYsHoRkg0CoZVi1XtD0xZOM
        F5EGm8nofEg3HTMQR5X0aNkMmvjXK/XFoPK0hZ9dATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZhztL
        VWA1eE9DDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.823600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 97E294BC74714BAF4319193F36B1863E47EFD0E8B321CD7A9527EA9A416A7C542000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the build warnings that were detected by the linux-media
build scripts tool:

drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
	In function 'mdp_path_config.isra':
drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:443:51:
	warning: 'ctx' may be used uninitialized [-Wmaybe-uninitialized]
  443 |                    out = CFG_COMP(MT8195, ctx->param, outputs[0]);
      |                                           ~~~^~~~~~~
drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h:137:25: note:
	in definition of macro 'CFG_COMP'
  137 |         (IS_ERR_OR_NULL(comp) ? 0 : _CFG_COMP(plat, comp, mem))
      |                         ^~~~
drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:396:30:
	note: 'ctx' was declared here
  396 |         struct mdp_comp_ctx *ctx;
      |

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 15a0b944745e..4a8d941178aa 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -436,13 +436,13 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 		if (mdp_cfg_comp_is_dummy(path->mdp_dev, inner_id))
 			continue;
 
+		ctx = &path->comps[index];
 		if (CFG_CHECK(MT8183, p_id))
 			out = CFG_COMP(MT8183, ctx->param, outputs[0]);
 		else if (CFG_CHECK(MT8195, p_id))
 			out = CFG_COMP(MT8195, ctx->param, outputs[0]);
 
 		compose = path->composes[out];
-		ctx = &path->comps[index];
 		ret = call_op(ctx, config_frame, cmd, compose);
 		if (ret)
 			return ret;
-- 
2.18.0

