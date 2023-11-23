Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF03F7F6366
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346216AbjKWPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346182AbjKWPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:55:07 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B6D4E;
        Thu, 23 Nov 2023 07:55:10 -0800 (PST)
X-UUID: 97d46d5f29044d088e11efa0f1ac5bc6-20231123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:62ac3e0a-0465-42cd-a288-8d13baaadfb3,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:62ac3e0a-0465-42cd-a288-8d13baaadfb3,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:aa25ff72-1bd3-4f48-b671-ada88705968c,B
        ulkID:231123235502KLXVUUK3,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 97d46d5f29044d088e11efa0f1ac5bc6-20231123
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 164031110; Thu, 23 Nov 2023 23:54:59 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, chao.song@intel.com
Cc:     kunwu.chan@hotmail.com, sound-open-firmware@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ASoC: SOF: Fix null pointer dereference in sof_pci_probe
Date:   Thu, 23 Nov 2023 23:54:24 +0800
Message-Id: <20231123155424.1275919-1-chentao@kylinos.cn>
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

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 46207ca24545 ("ASoC: SOF: pci: change the default firmware path when the community key is used")
Fixes: 25bbc0c59ee1 ("ASoC: SOF: Add path definition for external firmware libraries")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 sound/soc/sof/sof-pci-dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 64b326e3ef85..75a9bfa5bfbe 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -282,6 +282,10 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 			devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
 				       sof_pdata->desc->default_fw_path[sof_pdata->ipc_type],
 				       "community");
+		if (!sof_pdata->fw_filename_prefix) {
+			ret = -ENOMEM;	
+			goto out;
+		}
 
 		dev_dbg(dev,
 			"Platform uses community key, changed fw path to %s\n",
@@ -303,6 +307,10 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 				devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
 					sof_pdata->desc->default_lib_path[sof_pdata->ipc_type],
 					"community");
+			if (!sof_pdata->fw_lib_prefix) {
+				ret = -ENOMEM;
+				goto out;
+			}
 
 			dev_dbg(dev,
 				"Platform uses community key, changed fw_lib path to %s\n",
-- 
2.34.1

