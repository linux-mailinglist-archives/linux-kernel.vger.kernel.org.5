Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9F7EFD68
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjKRDaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRDad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:30:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF650D7E;
        Fri, 17 Nov 2023 19:30:24 -0800 (PST)
X-UUID: c978fc1085c211ee8051498923ad61e6-20231118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Bstjx1naY+ACD44JpQLykCLyHHU2RE59YMPPwiAKQfo=;
        b=o9MSK6U2cW1lSMWf3RP8tdxppe6xAVpw7U1TwkwFySyp2/p1TAde2/oFuAi/AmwSz6CWnKjdscQL167RgEElNb5t5TmTeD2IcL70NVjs8a3KrgMWx9+j2pQ1fh41ISsK/SALZ8OY3G3RXx/QwoFp6L6OZVXjH9NBPeIfFQia4nc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:82b35d89-1985-41cc-bca5-9483f0a1d4b5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:19893260-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: c978fc1085c211ee8051498923ad61e6-20231118
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 378944915; Sat, 18 Nov 2023 11:30:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 18 Nov 2023 11:30:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 18 Nov 2023 11:30:12 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH] usb: xhci-mtk: fix in-ep's start-split check failure
Date:   Sat, 18 Nov 2023 11:30:11 +0800
Message-ID: <20231118033011.22033-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's wrong to use the data length in a CS (in uframe x) to check whether
there is a SS (in uframe x-2), because for a isoc-in ep, it may need some
CS to receive data;
Save the count of SS in a uframe for isoc/intr in-eps to fix the issue.

Fixes: 5c954e030f55 ("usb: xhci-mtk: improve split scheduling by separate IN/OUT budget")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 13 ++++++++++---
 drivers/usb/host/xhci-mtk.h     |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 5b3cd455adec..61f3f8bbdcea 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -650,9 +650,8 @@ static int check_isoc_ss_overlap(struct mu3h_sch_ep_info *sch_ep, u32 offset)
 
 		if (sch_ep->ep_type == ISOC_OUT_EP) {
 			for (j = 0; j < sch_ep->num_budget_microframes; j++) {
-				k = XHCI_MTK_BW_INDEX(base + j + CS_OFFSET);
-				/* use cs to indicate existence of in-ss @(base+j) */
-				if (tt->fs_bus_bw_in[k])
+				k = XHCI_MTK_BW_INDEX(base + j);
+				if (tt->in_ss_cnt[k])
 					return -ESCH_SS_OVERLAP;
 			}
 		} else if (sch_ep->ep_type == ISOC_IN_EP || sch_ep->ep_type == INT_IN_EP) {
@@ -769,6 +768,14 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
 				tt->fs_frame_bw[f] -= (u16)sch_ep->bw_budget_table[j];
 			}
 		}
+
+		if (sch_ep->ep_type == ISOC_IN_EP || sch_ep->ep_type == INT_IN_EP) {
+			k = XHCI_MTK_BW_INDEX(base);
+			if (used)
+				tt->in_ss_cnt[k]++;
+			else
+				tt->in_ss_cnt[k]--;
+		}
 	}
 
 	if (used)
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 865b55e23b15..39f7ae7d3087 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -38,6 +38,7 @@
  * @fs_bus_bw_in: save bandwidth used by FS/LS IN eps in each uframes
  * @ls_bus_bw: save bandwidth used by LS eps in each uframes
  * @fs_frame_bw: save bandwidth used by FS/LS eps in each FS frames
+ * @in_ss_cnt: the count of Start-Split for IN eps
  * @ep_list: Endpoints using this TT
  */
 struct mu3h_sch_tt {
@@ -45,6 +46,7 @@ struct mu3h_sch_tt {
 	u16 fs_bus_bw_in[XHCI_MTK_MAX_ESIT];
 	u8 ls_bus_bw[XHCI_MTK_MAX_ESIT];
 	u16 fs_frame_bw[XHCI_MTK_FRAMES_CNT];
+	u8 in_ss_cnt[XHCI_MTK_MAX_ESIT];
 	struct list_head ep_list;
 };
 
-- 
2.25.1

