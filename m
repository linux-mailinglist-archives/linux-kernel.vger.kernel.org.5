Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C040802B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjLDGXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:23:09 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0139DF;
        Sun,  3 Dec 2023 22:23:13 -0800 (PST)
X-UUID: dc1967f88d7547b9bb334034848caa36-20231204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:f20d8732-0eeb-4bee-8f43-b9fd4762c27a,IP:5,U
        RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-40
X-CID-INFO: VERSION:1.1.33,REQID:f20d8732-0eeb-4bee-8f43-b9fd4762c27a,IP:5,URL
        :0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACTI
        ON:release,TS:-40
X-CID-META: VersionHash:364b77b,CLOUDID:75ba5f73-1bd3-4f48-b671-ada88705968c,B
        ulkID:231204142249O93CDZ8U,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:2,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: dc1967f88d7547b9bb334034848caa36-20231204
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 559205209; Mon, 04 Dec 2023 14:22:48 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     bhelgaas@google.com, lizhi.hou@amd.com, robh@kernel.org
Cc:     kunwu.chan@hotmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] PCI: Fix null pointer dereference in of_pci_prop_compatible
Date:   Mon,  4 Dec 2023 14:22:45 +0800
Message-Id: <20231204062245.2453512-1-chentao@kylinos.cn>
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
which can be NULL upon failure.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/pci/of_property.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index c2c7334152bc..5e16bbff3ba4 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -304,6 +304,11 @@ static int of_pci_prop_compatible(struct pci_dev *pdev,
 	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =
 		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
 
+	if (!compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] ||
+	    !compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] ||
+	    !compat_strs[PROP_COMPAT_PCICLASS_CCSS])
+		return -ENOMEM;
+
 	ret = of_changeset_add_prop_string_array(ocs, np, "compatible",
 						 compat_strs, PROP_COMPAT_NUM);
 	for (i = 0; i < PROP_COMPAT_NUM; i++)
-- 
2.34.1

