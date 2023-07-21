Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749C275BC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGUCmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:42:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803ED2690;
        Thu, 20 Jul 2023 19:41:58 -0700 (PDT)
X-UUID: 254ff3a6277011ee9cb5633481061a41-20230721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cuQcAFun+BnSgG5anPpJsFlDoWtYI8mwMJXr/j2QCQw=;
        b=NEujqncd9Pppb0EJkjNSlljhfszfc7bjDD2nR3jK9awxKb5iaystOEoZd+idoVr8Cow331CoN2CHc4Mn7xKupCX2zvemCJJC6GxKzufqmuAKeaiUy98PSGL2M6pZ5WYdHlz0l1oFEnTXsOIIdyEpA/dy4g/nZ3PrM6/vy+3Aco4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:0dad7ffc-5d50-4929-9843-8a1276bcfedc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:6914d8dc-dc79-4898-9235-1134b97257a8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 254ff3a6277011ee9cb5633481061a41-20230721
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1309599569; Fri, 21 Jul 2023 10:41:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jul 2023 10:41:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jul 2023 10:41:49 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v15 00/13] Add support for MT8195 SCP 2nd core
Date:   Fri, 21 Jul 2023 10:41:19 +0800
Message-ID: <20230721024132.6548-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mediatek remoteproc driver currently only allows bringing up a 
single core SCP, e.g. MT8183. It also only bringing up the 1st 
core in SoCs with a dual-core SCP, e.g. MT8195. This series support 
to bring-up the 2nd core of the dual-core SCP.

v15 -> v14:
1. Use the common SCP registers in struct mtk_scp_of_cluster instead of
   copy it to struct mtk_scp at patchset 5 
2. Use platform_set_drvdata instead of platform_device_add_data at patchset 5 
3. Rename l2tcm_lock to cluster_lock at patchset 8
4. Check l2tcm_refcnt value before decreasing at patchset 8
5. Revise the commit message at patchset 11

v13 -> v14:
1. add review tag to patchset 1,6
2. exchange the order of sram power on and reset assert in
mt8195_scp_c1_before_load at patchset 2
3. Use ERR_CAST in patchset 5
4. Re-write patchset 7 to remove dependency between core 0 and core 1 
5. Add patch set 10 to report watchdot timeout to all cores

v12 -> v13:
1. replace subdevice with new mediatek scp operations in patchset 7 
2. add review tag to patchset 3
3. modify mediatek,scp phandle name of video-codec@18000000 at patchset 11

v11 -> v12:
1. add scp_add_single/multi_core() to patchset 6
2. remove unused comment in patchset 6
3. rename list name from mtk_scp_cluster to mtk_scp_list
4. rewrite the multi-core probe flow 
5. disable rproc->autoboot and boot rproc by request_firmware_nowait at patchset 7 
6. remove patchset 7 review tag  

v10 -> v11:
1. rewrite patchset 5 to probe single-core SCP with the cluster list
2. Also in patchset 5, move the pointer of mtk_scp object from the
   platform data property to the driver data property 
3. move the appearance of mtk_scp cluster property to patcheset 7

v9 -> v10:
1. move the global mtk_scp list into the platform device driver data structure
2. remove an unnecessary if() condition

v8 -> v9:
1. initialize l1tcm_size/l1tcm_phys at patchset 05/11 
2. rewrite patchset 06/11 to unify the flow and remove hacks

v7 -> v8:
1. update the node name of mt8192 asurada SCP rpmsg subnode
2. squash register definitions into driver patches
3. initialize local variables on the declaration at patch v8 06/11 

v6 -> v7:
1. merge the mtk_scp_cluster struct into the mtk_scp structure
   at the "Probe multi-core SCP" patch

v5 -> v6:
1. move the mtk_scp_of_regs structure from mtk_common.h to mtk_scp.c
2. rename the SCP core 0 label from 'scp' to 'scp_c0'

v4 -> v5:
1. move resource release actions to the platform driver remove operation 
2. fix dual-core watchdog handling

v3 -> v4:
1. change the representation of dual-core SCP in dts file and update SCP yaml
2. rewrite SCP driver to reflect the change of dts node
3. drop 'remove redundant call of rproc_boot for SCP' in v3 for further investigation

v2 -> v3:
1. change the representation of dual-core SCP in dts file and update SCP yaml
2. rewrite SCP driver to reflect the change of dts node
3. add SCP core 1 node to mt8195.dtsi
4. remove redundant call of rproc_boot for SCP
5. refine IPI error message

v1 -> v2:
1. update dt-binding property description
2. remove kconfig for scp dual driver
3. merge mtk_scp_dual.c and mtk_scp_subdev.c to mtk_scp.c


Tinghan Shen (13):
  dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
    definition
  arm64: dts: mediatek: Update the node name of SCP rpmsg subnode
  dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
  remoteproc: mediatek: Add MT8195 SCP core 1 operations
  remoteproc: mediatek: Extract SCP common registers
  remoteproc: mediatek: Probe SCP cluster on single-core SCP
  remoteproc: mediatek: Probe SCP cluster on multi-core SCP
  remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power
    control on dual-core SCP
  remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
  remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
  remoteproc: mediatek: Report watchdog crash to all cores
  remoteproc: mediatek: Refine ipi handler error message
  arm64: dts: mediatek: mt8195: Add SCP 2nd core

 .../bindings/remoteproc/mtk,scp.yaml          | 176 +++++-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |   2 +-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   6 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  34 +-
 drivers/remoteproc/mtk_common.h               |  39 +-
 drivers/remoteproc/mtk_scp.c                  | 534 ++++++++++++++----
 drivers/remoteproc/mtk_scp_ipi.c              |   4 +-
 8 files changed, 651 insertions(+), 146 deletions(-)

-- 
2.18.0

