Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2979A141
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjIKCbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKCbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:31:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61B1B9;
        Sun, 10 Sep 2023 19:30:50 -0700 (PDT)
X-UUID: 36af3e00504b11eea33bb35ae8d461a2-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+87uOL2WQvYvX9g5bStM5h9swQ1laB4yxiMeMo2iqXc=;
        b=uf2/Wzg+L7T9MTAwoxRWPDfyQUIyCXE0Hxfbpd3z4Ot7lzyqPcWbk4O4xh7hh9E8y45mJKqChOgOFP9EF9naY5Gdk/LEGyxBY3/4r3IOo4Os4WsSemPu36wTXwRLsVKa+x8NEqVQB2TXZtAhjvT8S2sZri8wfjQveu6OzbfAAG8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:2fcd4e6f-6799-4aa9-ab3f-fbfa01e6997a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:1d59adbe-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 36af3e00504b11eea33bb35ae8d461a2-20230911
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 141108311; Mon, 11 Sep 2023 10:30:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 10:30:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 10:30:44 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, <tjmercier@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jianjiao.zeng@mediatek.com>,
        <kuohong.wang@mediatek.com>
Subject: [PATCH 0/9] dma-buf: heaps: Add MediaTek secure heap
Date:   Mon, 11 Sep 2023 10:30:29 +0800
Message-ID: <20230911023038.30649-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consists of two parts, the first is from John and TJ.
It adds some heap interfaces, then our kernel users could allocate buffer
from special heap. The second part is adding MTK secure heap for SVP
(Secure Video Path). A total of two heaps are added, one is mtk_svp and
the other is mtk_svp_cma. The mtk_svp buffer is reserved for the secure
world after bootup and it is used for ES/working buffer, while the
mtk_svp_cma buffer is dynamically reserved for the secure world and will
be get ready when we start playing secure videos, this heap is used for the
frame buffer. Once the security video playing is complete, the CMA will be
released.

For easier viewing, I've split the new heap file into several patches.

The consumers of new heap and new interfaces are our codec and drm which
will send upstream soon, probably this week.

Base on v6.6-rc1.

John Stultz (2):
  dma-heap: Add proper kref handling on dma-buf heaps
  dma-heap: Provide accessors so that in-kernel drivers can allocate
    dmabufs from specific heaps

T.J. Mercier (1):
  dma-buf: heaps: Deduplicate docs and adopt common format

Yong Wu (6):
  dma-buf: heaps: Initialise MediaTek secure heap
  dma-buf: heaps: mtk_sec_heap: Initialise tee session
  dma-buf: heaps: mtk_sec_heap: Add tee service call for buffer
    allocating/freeing
  dma-buf: heaps: mtk_sec_heap: Add dma_ops
  dt-bindings: reserved-memory: MediaTek: Add reserved memory for SVP
  dma_buf: heaps: mtk_sec_heap: Add a new CMA heap

 .../mediatek,secure_cma_chunkmem.yaml         |  42 ++
 drivers/dma-buf/dma-heap.c                    | 127 +++--
 drivers/dma-buf/heaps/Kconfig                 |   8 +
 drivers/dma-buf/heaps/Makefile                |   1 +
 drivers/dma-buf/heaps/mtk_secure_heap.c       | 458 ++++++++++++++++++
 include/linux/dma-heap.h                      |  42 +-
 6 files changed, 630 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mediatek,secure_cma_chunkmem.yaml
 create mode 100644 drivers/dma-buf/heaps/mtk_secure_heap.c

-- 
2.18.0


