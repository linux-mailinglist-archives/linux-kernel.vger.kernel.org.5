Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4249B78E05A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbjH3TP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbjH3LOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:14:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C67E1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:14:12 -0700 (PDT)
X-UUID: 53d1071c472611eeb20a276fd37b9834-20230830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Z/l9vVKd4IJQQlkUTiNKpXnzdHF7Q11R3pXMQApTJ1Q=;
        b=OOoZY4DAyUchQHlZQE65hqNoRbHkbQSNIwX5lhL19UmxbC3lAL0xGAIym1QIQUsKFgyNK4xzZ4QDvRj/yAF7tQEd1Yy/Xi9YycWZot+ZuZwekSBuZ/Je2muhOLyTgtbS83MH9lFUOItCr9G275eh7CtkKqRqk+SnYwx1dzvGzzI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:542eee97-7dcd-45d0-803d-1fa3c711cc26,IP:0,U
        RL:0,TC:0,Content:22,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:22
X-CID-META: VersionHash:0ad78a4,CLOUDID:04691eef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 53d1071c472611eeb20a276fd37b9834-20230830
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 655950684; Wed, 30 Aug 2023 19:14:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Aug 2023 19:14:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Aug 2023 19:14:02 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <vbabka@suse.cz>, <nsaenzju@redhat.com>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-pk Tsai <mark-pk.tsai@mediatek.com>,
        Joe Liu <joe.liu@mediatek.com>
Subject: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue fallback
Date:   Wed, 30 Aug 2023 19:13:33 +0800
Message-ID: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a
spinlock") fallback freeing page to free_one_page() if pcp trylock
failed. This make MIGRATE_CMA be able to fallback and be stolen
whole pageblock by MIGRATE_UNMOVABLE in the page allocation.

PCP free is fine because free_pcppages_bulk() will always get
migratetype again before freeing the page, thus this only happen when
someone tried to put CMA page in to other MIGRATE_TYPE's freelist.

Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
Reported-by: Joe Liu <joe.liu@mediatek.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Mark-pk Tsai <mark-pk.tsai@mediatek.com>
Cc: Joe Liu <joe.liu@mediatek.com>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 452459836b71..0ea88c031838 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2428,6 +2428,14 @@ void free_unref_page(struct page *page, unsigned int order)
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
+#ifdef CONFIG_CMA
+		/*
+		 * CMA must be back to its freelist. Otherwise CMA pageblock may
+		 * be stolen by fallback flow while getting free page.
+		 */
+		if (get_pcppage_migratetype(page) == MIGRATE_CMA)
+			migratetype = MIGRATE_CMA;
+#endif
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
 	}
 	pcp_trylock_finish(UP_flags);
-- 
2.18.0

