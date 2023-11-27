Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A17F9ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjK0HFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjK0HFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:05:19 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D9181
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:05:24 -0800 (PST)
X-UUID: 541d4b6e8cf311ee8051498923ad61e6-20231127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FfM/LFHjkcBsRth/jK9IUe/5rqKeTocfopTS7wMKfnY=;
        b=ng3Bo+YQnERGOnT7ztC4R8StCtj6WolnTE4LvIKZ7dQT1JRUJWO2rFGHgENgExbBCUxQjeahPu+IECoaC/rWwRT5tf/rFt8mTxlerbQsluTRymZdmQRtIAiqb7+02OPzctgqTUc5B3PIcv9hVCxU+mZs7nUXIQ0S+1/xQ6f9llI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:403e8a92-2faa-417e-be93-6edd30c92748,IP:0,U
        RL:0,TC:0,Content:42,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:42
X-CID-META: VersionHash:364b77b,CLOUDID:a9d7fcfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 541d4b6e8cf311ee8051498923ad61e6-20231127
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1800567617; Mon, 27 Nov 2023 15:05:21 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 27 Nov 2023 15:05:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 27 Nov 2023 15:05:19 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
        <qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/3] scripts/gdb: Remove exception handling and refine print format
Date:   Mon, 27 Nov 2023 15:04:03 +0800
Message-ID: <20231127070404.4192-4-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
References: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.929400-8.000000
X-TMASE-MatchedRID: Av/pE9tNfKGWHmpvkeKJB0hwlOfYeSqx3xlpFMX5MCCQ2TbICkFOdk69
        FgKoS/097PSkEF73uYd7VWtw6SMI5Kawq2pdPD7UA9lly13c/gGb/LTS0T1K1k4K0IMk2m3GwVB
        JSJ8GjJw3fJWouRpjSXrw5BSR88yeSoBVPxvX5SSQOktEo73GFOTWKSbLQnNI0w5IABkoK4ejxY
        yRBa/qJcFwgTvxipFa9xS3mVzWUuAojN1lLei7RYYOtKqE9TMltcW9OiWFpt72ZzE2SrN70Z+eC
        VfOOV58l0THHo7ATW+guLN8VZYRFDky1wRoSxJfiCCOl1JcKQZai0D30EU35nmVKZusLp922v9O
        jYWA2uMMswg45VMfPXY3pGDmoik6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.929400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 847D7A48C3336C1D5104C7B296990B2AD0769F6D258E074659F3A149850583532000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. When we crash on a page, we want to check what
happened on this page instead of skipping this page by
try-except block. Thus, removing the try-except block.

2. Remove redundant comma and print the task name properly.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/page_owner.py | 58 ++++++++++++++-------------------
 scripts/gdb/linux/slab.py       |  3 +-
 2 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/scripts/gdb/linux/page_owner.py b/scripts/gdb/linux/page_owner.py
index 844fd5d0c912..8e713a09cfe7 100644
--- a/scripts/gdb/linux/page_owner.py
+++ b/scripts/gdb/linux/page_owner.py
@@ -122,27 +122,24 @@ class DumpPageOwner(gdb.Command):
         if not (page_ext['flags'] & (1 << PAGE_EXT_OWNER_ALLOCATED)):
             gdb.write("page_owner is not allocated\n")
 
-        try:
-            page_owner = self.get_page_owner(page_ext)
-            gdb.write("Page last allocated via order %d, gfp_mask: 0x%x, pid: %d, tgid: %d (%s), ts %u ns, free_ts %u ns\n" %\
-                    (page_owner["order"], page_owner["gfp_mask"],\
-                    page_owner["pid"], page_owner["tgid"], page_owner["comm"],\
-                    page_owner["ts_nsec"], page_owner["free_ts_nsec"]))
-            gdb.write("PFN: %d, Flags: 0x%x\n" % (pfn, page['flags']))
-            if page_owner["handle"] == 0:
-                gdb.write('page_owner allocation stack trace missing\n')
-            else:
-                stackdepot.stack_depot_print(page_owner["handle"])
+        page_owner = self.get_page_owner(page_ext)
+        gdb.write("Page last allocated via order %d, gfp_mask: 0x%x, pid: %d, tgid: %d (%s), ts %u ns, free_ts %u ns\n" %\
+                (page_owner["order"], page_owner["gfp_mask"],\
+                page_owner["pid"], page_owner["tgid"], page_owner["comm"].string(),\
+                page_owner["ts_nsec"], page_owner["free_ts_nsec"]))
+        gdb.write("PFN: %d, Flags: 0x%x\n" % (pfn, page['flags']))
+        if page_owner["handle"] == 0:
+            gdb.write('page_owner allocation stack trace missing\n')
+        else:
+            stackdepot.stack_depot_print(page_owner["handle"])
 
-            if page_owner["free_handle"] == 0:
-                gdb.write('page_owner free stack trace missing\n')
-            else:
-                gdb.write('page last free stack trace:\n')
-                stackdepot.stack_depot_print(page_owner["free_handle"])
-            if page_owner['last_migrate_reason'] != -1:
-                gdb.write('page has been migrated, last migrate reason: %s\n' % self.migrate_reason_names[page_owner['last_migrate_reason']])
-        except:
-            gdb.write("\n")
+        if page_owner["free_handle"] == 0:
+            gdb.write('page_owner free stack trace missing\n')
+        else:
+            gdb.write('page last free stack trace:\n')
+            stackdepot.stack_depot_print(page_owner["free_handle"])
+        if page_owner['last_migrate_reason'] != -1:
+            gdb.write('page has been migrated, last migrate reason: %s\n' % self.migrate_reason_names[page_owner['last_migrate_reason']])
 
     def read_page_owner(self):
         pfn = self.min_pfn
@@ -173,18 +170,13 @@ class DumpPageOwner(gdb.Command):
                 pfn += 1
                 continue
 
-            try:
-                page_owner = self.get_page_owner(page_ext)
-                gdb.write("Page allocated via order %d, gfp_mask: 0x%x, pid: %d, tgid: %d (%s), ts %u ns, free_ts %u ns\n" %\
-                        (page_owner["order"], page_owner["gfp_mask"],\
-                        page_owner["pid"], page_owner["tgid"], page_owner["comm"],\
-                        page_owner["ts_nsec"], page_owner["free_ts_nsec"]))
-                gdb.write("PFN: %d, Flags: 0x%x\n" % (pfn, page['flags']))
-                stackdepot.stack_depot_print(page_owner["handle"])
-                pfn += (1 << page_owner["order"])
-                continue
-            except:
-                gdb.write("\n")
-            pfn += 1
+            page_owner = self.get_page_owner(page_ext)
+            gdb.write("Page allocated via order %d, gfp_mask: 0x%x, pid: %d, tgid: %d (%s), ts %u ns, free_ts %u ns\n" %\
+                    (page_owner["order"], page_owner["gfp_mask"],\
+                    page_owner["pid"], page_owner["tgid"], page_owner["comm"].string(),\
+                    page_owner["ts_nsec"], page_owner["free_ts_nsec"]))
+            gdb.write("PFN: %d, Flags: 0x%x\n" % (pfn, page['flags']))
+            stackdepot.stack_depot_print(page_owner["handle"])
+            pfn += (1 << page_owner["order"])
 
 DumpPageOwner()
diff --git a/scripts/gdb/linux/slab.py b/scripts/gdb/linux/slab.py
index f012ba38c7d9..0e2d93867fe2 100644
--- a/scripts/gdb/linux/slab.py
+++ b/scripts/gdb/linux/slab.py
@@ -228,8 +228,7 @@ def slabtrace(alloc, cache_name):
             nr_cpu = gdb.parse_and_eval('__num_online_cpus')['counter']
             if nr_cpu > 1:
                 gdb.write(" cpus=")
-                for i in loc['cpus']:
-                    gdb.write("%d," % i)
+                gdb.write(','.join(str(cpu) for cpu in loc['cpus']))
         gdb.write("\n")
         if constants.LX_CONFIG_STACKDEPOT:
             if loc['handle']:
-- 
2.18.0

