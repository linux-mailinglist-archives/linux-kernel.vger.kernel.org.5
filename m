Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515BA77F5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbjHQMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350469AbjHQMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:02:03 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F862136;
        Thu, 17 Aug 2023 05:01:48 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qWbh3-0001ko-02;
        Thu, 17 Aug 2023 12:01:38 +0000
Date:   Thu, 17 Aug 2023 13:01:11 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset
Message-ID: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a hardware reset is triggered on devices not initializing WED the
calls to mtk_wed_fe_reset and mtk_wed_fe_reset_complete dereference a
pointer on uninitialized stack memory.
Initialize the hw_list will 0s and break out of both functions in case
a hw_list entry is 0.

Fixes: 08a764a7c51b ("net: ethernet: mtk_wed: add reset/reset_complete callbacks")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 00aeee0d5e45f..d14f5137379b9 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -41,7 +41,7 @@
 #define MTK_WED_RRO_QUE_CNT		8192
 #define MTK_WED_MIOD_ENTRY_CNT		128
 
-static struct mtk_wed_hw *hw_list[2];
+static struct mtk_wed_hw *hw_list[2] = {};
 static DEFINE_MUTEX(hw_lock);
 
 struct mtk_wed_flow_block_priv {
@@ -222,9 +222,13 @@ void mtk_wed_fe_reset(void)
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
 		struct mtk_wed_hw *hw = hw_list[i];
-		struct mtk_wed_device *dev = hw->wed_dev;
+		struct mtk_wed_device *dev;
 		int err;
 
+		if (!hw)
+			break;
+
+		dev = hw->wed_dev;
 		if (!dev || !dev->wlan.reset)
 			continue;
 
@@ -245,8 +249,12 @@ void mtk_wed_fe_reset_complete(void)
 
 	for (i = 0; i < ARRAY_SIZE(hw_list); i++) {
 		struct mtk_wed_hw *hw = hw_list[i];
-		struct mtk_wed_device *dev = hw->wed_dev;
+		struct mtk_wed_device *dev;
+
+		if (!hw)
+			break;
 
+		dev = hw->wed_dev;
 		if (!dev || !dev->wlan.reset_complete)
 			continue;
 
-- 
2.41.0

