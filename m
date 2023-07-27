Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50A57650D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjG0KUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjG0KT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:19:57 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998061FFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:19:45 -0700 (PDT)
X-UUID: efdee9600b8242dab6b8f45134d09719-20230727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:cd34a3cc-68f4-4daf-8285-83140148c9bd,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-INFO: VERSION:1.1.28,REQID:cd34a3cc-68f4-4daf-8285-83140148c9bd,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:3f028542-d291-4e62-b539-43d7d78362ba,B
        ulkID:230727181935Q0FGY2OS,BulkQuantity:0,Recheck:0,SF:44|38|24|17|19|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: efdee9600b8242dab6b8f45134d09719-20230727
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1232940138; Thu, 27 Jul 2023 18:19:32 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] nvme-pci: add quirk to disable APST feature for BIWIN AP443 256GB SSD
Date:   Thu, 27 Jul 2023 18:19:28 +0800
Message-Id: <20230727101928.1366179-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk to disable APST feature for BIWIN AP443 256GB SSD.
It drops off the PCIe bus on a Lenovo board, board name
 is LXKT-ZXFG-N6 or LXKT-ZXE-N70.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f25c0fe3a0b..240e8e946e01 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2897,7 +2897,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
-	}
+	} else if (pdev->vendor == 0x1dee && pdev->device == 0x5216) {
+		/*
+		 * BIWIN AP443 256GB SSD drops off the PCIe bus on a
+		 * Lenovo or KaiTian board, board name is LXKT-ZXFG-N6
+		 * or LXKT-ZXE-N70
+		 */
+		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO") ||
+		     dmi_match(DMI_BOARD_VENDOR, "KaiTian")) &&
+		    (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6") ||
+		     dmi_match(DMI_BOARD_NAME, "LXKT-ZXE-N70")))
+			return NVME_QUIRK_NO_APST;
+		}
 
 	return 0;
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
