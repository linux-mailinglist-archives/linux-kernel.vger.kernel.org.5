Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4197F3B69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjKVBmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKVBmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:42:32 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93DDD;
        Tue, 21 Nov 2023 17:42:26 -0800 (PST)
X-UUID: 56764a2aa4d047c38f14754d997f3d46-20231122
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:221a0807-ac66-439a-ba02-0d2e78cf7bc5,IP:15,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-INFO: VERSION:1.1.32,REQID:221a0807-ac66-439a-ba02-0d2e78cf7bc5,IP:15,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:0305ec72-1bd3-4f48-b671-ada88705968c,B
        ulkID:231122094217U0J17LEI,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULN
X-UUID: 56764a2aa4d047c38f14754d997f3d46-20231122
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1824473249; Wed, 22 Nov 2023 09:42:17 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     gregkh@linuxfoundation.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, andriy.shevchenko@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kunwu.chan@hotmail.com, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in ast_vhub_alloc_epn
Date:   Wed, 22 Nov 2023 09:42:12 +0800
Message-Id: <20231122014212.304254-1-chentao@kylinos.cn>
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

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 148d7ec3ebf4..e0854e878411 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
 	ep->vhub = vhub;
 	ep->ep.ops = &ast_vhub_epn_ops;
 	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
+	if (!ep->ep.name)
+		return NULL;
 	d->epns[addr-1] = ep;
 	ep->epn.g_idx = i;
 	ep->epn.regs = vhub->regs + 0x200 + (i * 0x10);
-- 
2.34.1

