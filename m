Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85FF7C4811
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjJKDAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJKDAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:00:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE194;
        Tue, 10 Oct 2023 20:00:47 -0700 (PDT)
X-UUID: 5d26760867e211eea33bb35ae8d461a2-20231011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pQ3H7eMV35hy7ja7ums4idnErqHQoC8PfzxJOKFzSow=;
        b=SrWkQsG9MY4WOgoCuXWQT5YAWmjFx9Re4PtxcSlAzRbhoDNRZpWZZM7CLJ6pVqjP23c5pVXITF8SDmLOsmNfCjE2DHuKCeOEqzPcWa0Sw/XtTY3S/yKVYeqjxum02uqneA/hsEUkokoTGszrhmOa6JWLQbN1vxSR/PerAvW+ZS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:b5b04fbd-cb32-4c1c-98fd-ed8b45f822c8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:196ce314-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5d26760867e211eea33bb35ae8d461a2-20231011
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1032919163; Wed, 11 Oct 2023 11:00:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Oct 2023 11:00:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Oct 2023 11:00:40 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v1] media: platform: mtk-mdp3: fix uninitialized variable in mdp_path_config()
Date:   Wed, 11 Oct 2023 11:00:37 +0800
Message-ID: <20231011030037.22337-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.284500-8.000000
X-TMASE-MatchedRID: bY/LIBxtflqhL93N5VXnFISvKOGqLLPKFKliqHKCaOkqNag3uuW+4vhT
        6/pHvNpJzmy+RYEtL0m0k1objFiL4GGN6M1vhJ4HXP5rFAucBUG4vBuE2X0HlVxTR00Ss4P6+Vi
        hXqn9xLHGUnHlYVkOyLEivwZSlRnNGbjm5ZdalUGeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8ifEz
        J5hPndGReGaqZX6qKuiwzXnJrC++m6MyiN7oOAsXqfy2ud4VgwTKhkjXNSrgLRCxYxv/T7kv9Lo
        A0/wXk89cAlb/C44ftWe8HxcmwrG3mVKZusLp922v9OjYWA2uMMswg45VMfPadst5iAforfVlxr
        1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.284500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CFF5A348E27B8ED8314AC7FD146001B5EB4CB8BE0F65BFDF7A204414EE8423BE2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
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
drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
	warning: 'ctx' may be used uninitialized [-Wmaybe-uninitialized]
      |                    out = CFG_COMP(MT8195, ctx->param, outputs[0]);
      |                                           ~~~^~~~~~~
drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h: note:
	in definition of macro 'CFG_COMP'
      |         (IS_ERR_OR_NULL(comp) ? 0 : _CFG_COMP(plat, comp, mem))
      |                         ^~~~
drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
	note: 'ctx' was declared here
      |         struct mdp_comp_ctx *ctx;
      |

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index 3177592490be..6adac857a477 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -261,11 +261,11 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 		const struct v4l2_rect *compose;
 		u32 out = 0;
 
+		ctx = &path->comps[index];
 		if (CFG_CHECK(MT8183, p_id))
 			out = CFG_COMP(MT8183, ctx->param, outputs[0]);
 
 		compose = path->composes[out];
-		ctx = &path->comps[index];
 		ret = call_op(ctx, config_frame, cmd, compose);
 		if (ret)
 			return ret;
-- 
2.18.0

