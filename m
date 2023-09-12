Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196F79CAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjILJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjILJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:00:11 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD4A9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:00:06 -0700 (PDT)
X-UUID: 1b208d654f514db6ab615f053c02d5c0-20230912
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:0df1d1f6-bd20-45d5-95d9-0e2e93b66f7c,IP:20,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:10
X-CID-INFO: VERSION:1.1.31,REQID:0df1d1f6-bd20-45d5-95d9-0e2e93b66f7c,IP:20,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:10
X-CID-META: VersionHash:0ad78a4,CLOUDID:66bdbdbe-14cc-44ca-b657-2d2783296e72,B
        ulkID:230912165507KG6SZBFD,BulkQuantity:1,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 1b208d654f514db6ab615f053c02d5c0-20230912
X-User: liujinlong@kylinos.cn
Received: from kylin-thinkpad-pc.. [(116.128.244.171)] by mailgw
        (envelope-from <liujinlong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 727084725; Tue, 12 Sep 2023 16:59:26 +0800
From:   liujinlong <liujinlong@kylinos.cn>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     liujinlong <liujinlong@kylinos.cn>
Subject: [PATCH] mm: vmscan: modify an easily misunderstood function name
Date:   Tue, 12 Sep 2023 16:59:23 +0800
Message-Id: <20230912085923.27238-1-liujinlong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking at the code in the memory part, I found that the purpose of
the function prepare_scan_countis very different from the function name.
It is easy to misunderstand when reading.The function prepare_scan_count
mainly completes the assignment of the scan_control structure.Therefore,
I suggest that the function name can be changed to prepare_scan_control,
which is easier to understand.

Signed-off-by: liujinlong <liujinlong@kylinos.cn>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112ea..4e1d2b8ced91a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2909,7 +2909,7 @@ enum scan_balance {
 	SCAN_FILE,
 };
 
-static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
+static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 {
 	unsigned long file;
 	struct lruvec *target_lruvec;
@@ -6535,7 +6535,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	nr_reclaimed = sc->nr_reclaimed;
 	nr_scanned = sc->nr_scanned;
 
-	prepare_scan_count(pgdat, sc);
+	prepare_scan_control(pgdat, sc);
 
 	shrink_node_memcgs(pgdat, sc);
 
-- 
2.34.1

