Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC67BCBE5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 05:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbjJHD3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 23:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344300AbjJHD3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 23:29:44 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5977BD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 20:29:38 -0700 (PDT)
X-UUID: 65fef9d365334aeb8b3bd23711c2f496-20231008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3ad2d6a7-5ef2-49fa-8a01-ac7228f711c0,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:3ad2d6a7-5ef2-49fa-8a01-ac7228f711c0,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:d72ab3bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:231008112927Q8RCSMWZ,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 65fef9d365334aeb8b3bd23711c2f496-20231008
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1372250900; Sun, 08 Oct 2023 11:29:25 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        christophe.jaillet@wanadoo.fr, robh@kernel.org, treding@nvidia.com,
        daniel.baluta@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gehao618@163.com,
        Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()
Date:   Sun,  8 Oct 2023 11:29:08 +0800
Message-Id: <20231008032908.11448-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dsp_chan->name and chan_name points to same block of memory,
because dev_err still needs to be used it,so we need free
it's memory after use to avoid use_after_free.

Fixes: e527adfb9b7d ("firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 drivers/firmware/imx/imx-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 508eab346fc6..a48a58e0c61f 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -114,11 +114,11 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		dsp_chan->idx = i % 2;
 		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(dsp_chan->ch)) {
-			kfree(dsp_chan->name);
 			ret = PTR_ERR(dsp_chan->ch);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
 					chan_name, ret);
+			kfree(dsp_chan->name);
 			goto out;
 		}
 
-- 
2.25.1

