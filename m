Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E3773D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjHHQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjHHQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:11:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850D7DAA;
        Tue,  8 Aug 2023 08:46:53 -0700 (PDT)
X-UUID: d29ef40e35c511eeb20a276fd37b9834-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wurtuNfvllp7E5NLBLiT2rgzUIDAAvhWN0jPuBJRcQQ=;
        b=aPAUPytw2YNqa1NHOGGsRELxV8FqWqFgQ5/hXC5mtSvC/olgL8UUQ0Q/yn0/unYCpNe+x2jEnWm1ylB34AhBURheKbh4/1PT7hFe0oTEQrXQorthIOD8aJrItGfiu5LPofjMAZirhX7n44naC0sbhQ/oXEJyQNZ1nuBL9lRhH4U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:952c92a6-1d8e-4d95-8ee2-d506ed29b404,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:773a04a1-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d29ef40e35c511eeb20a276fd37b9834-20230808
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 912501661; Tue, 08 Aug 2023 16:30:25 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:24 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
        <casper.li@mediatek.com>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/8] Add GDB memory helper commands
Date:   Tue, 8 Aug 2023 16:30:10 +0800
Message-ID: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've created some GDB commands I think useful when I debug
some memory issues and kernel module issue.

For memory issue, we would like to get slabinfo, slabtrace,
page_owner and vmallocinfo to debug the memory issues.

For module issue, we would like to query kernel module name
when we get a module text address and load module
symbol by specific path.

Patch 1-2:
 - Add kernel module related command.
Patch 3-5:
 - Prepares for the memory-related command.
Patch 6-8:
 - Add memory-related commands.

V1->V2:
 - Fix s390 build error with defconfig (Stephen)
 - Use freeptr_t structure for dereference freepointer
   in slab
 - Add CONFIG_STACKDEPOT statement to handle stackdepot
   is disable
 - Add CONFIG_PAGE_OWNER statement to handle page owner
   is disable
 - Rebase to linux-next/next-20230808

Kuan-Ying Lee (8):
  scripts/gdb/symbols: add specific ko module load command
  scripts/gdb/modules: add get module text support
  scripts/gdb/utils: add common type usage
  scripts/gdb/aarch64: add aarch64 page operation helper commands and
    configs
  scripts/gdb/stackdepot: Add stackdepot support
  scripts/gdb/page_owner: add page owner support
  scripts/gdb/slab: Add slab support
  scripts/gdb/vmalloc: add vmallocinfo support

 scripts/gdb/linux/constants.py.in |  52 +++
 scripts/gdb/linux/mm.py           | 582 +++++++++++++++++++-----------
 scripts/gdb/linux/modules.py      |  32 +-
 scripts/gdb/linux/page_owner.py   | 190 ++++++++++
 scripts/gdb/linux/pgtable.py      | 222 ++++++++++++
 scripts/gdb/linux/slab.py         | 326 +++++++++++++++++
 scripts/gdb/linux/stackdepot.py   |  55 +++
 scripts/gdb/linux/symbols.py      |  23 +-
 scripts/gdb/linux/utils.py        |  20 +
 scripts/gdb/linux/vmalloc.py      |  56 +++
 scripts/gdb/vmlinux-gdb.py        |   7 +-
 11 files changed, 1358 insertions(+), 207 deletions(-)
 create mode 100644 scripts/gdb/linux/page_owner.py
 create mode 100644 scripts/gdb/linux/pgtable.py
 create mode 100644 scripts/gdb/linux/slab.py
 create mode 100644 scripts/gdb/linux/stackdepot.py
 create mode 100644 scripts/gdb/linux/vmalloc.py

-- 
2.18.0

