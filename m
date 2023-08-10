Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B93777267
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjHJILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjHJILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:11:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E152106;
        Thu, 10 Aug 2023 01:11:48 -0700 (PDT)
X-UUID: 8a204296375511ee9cb5633481061a41-20230810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gSYhZkHSCCzdMmaFCeh8M3KuCNiXviLZbYMre67Qkt0=;
        b=HK5L6f1Z2liObSb8txe8/5gpgOEFeczh+XvZ2QacdBpurD4zmA+mLIOympFzYQkOLeQRTfxmZj58pZS1Wk16i9L4x89Dom6DTiTCLC4G0r443K1sXLZakAS+T8H9bVAXxgrzHc/ZVOILwtO8vrmIJMUqHBnCH4X3DyyADsH8DIc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:c3a9e1f0-5acc-4cd6-a9a1-71dfd6476b7b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:fbab9c12-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8a204296375511ee9cb5633481061a41-20230810
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 842907020; Thu, 10 Aug 2023 16:11:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 10 Aug 2023 16:11:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 10 Aug 2023 16:11:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] ASoC: mt8188-mt6359: add SOF support
Date:   Thu, 10 Aug 2023 16:11:36 +0800
Message-ID: <20230810081139.27957-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces dynamic pinctrl and adds support for the SOF on
the mt8188-mt6359 machine driver.

Changes since v2:
  - revise mtk_sof_check_tplg_be_dai_link_fixup().
  
Changes since v1:
  - minor changes to incorporate the suggestions from the reviewer.

Trevor Wu (3):
  ASoC: mediatek: mt8188-mt6359: support dynamic pinctrl
  ASoC: mediatek: common: revise SOF common code
  ASoC: mediatek: mt8188-mt6359: add SOF support

 .../soc/mediatek/common/mtk-dsp-sof-common.c  | 113 +++++++--
 .../soc/mediatek/common/mtk-dsp-sof-common.h  |   8 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 239 +++++++++++++++++-
 3 files changed, 332 insertions(+), 28 deletions(-)

-- 
2.18.0

