Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E075BF56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGUHJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUHJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:09:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4E2710
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:09:28 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6gZf0J1PztRTg;
        Fri, 21 Jul 2023 15:06:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 15:09:26 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <baolin.wang@linux.alibaba.com>
CC:     <shikemeng@huawei.com>
Subject: [PATCH v2 2/2] mm/compaction: avoid unneeded pageblock_end_pfn when no_set_skip_hint is set
Date:   Fri, 21 Jul 2023 23:09:57 +0800
Message-ID: <20230721150957.2058634-3-shikemeng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230721150957.2058634-1-shikemeng@huawei.com>
References: <20230721150957.2058634-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pageblock_end_pfn after no_set_skip_hint check to avoid unneeded
pageblock_end_pfn if no_set_skip_hint is set.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/compaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c0d8d08fc163..9b7a0a69e19f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -458,12 +458,12 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
 {
 	struct zone *zone = cc->zone;
 
-	pfn = pageblock_end_pfn(pfn);
-
 	/* Set for isolation rather than compaction */
 	if (cc->no_set_skip_hint)
 		return;
 
+	pfn = pageblock_end_pfn(pfn);
+
 	if (pfn > zone->compact_cached_migrate_pfn[0])
 		zone->compact_cached_migrate_pfn[0] = pfn;
 	if (cc->mode != MIGRATE_ASYNC &&
-- 
2.30.0

