Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511E67F9AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjK0HFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjK0HFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:05:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D5134;
        Sun, 26 Nov 2023 23:05:23 -0800 (PST)
X-UUID: 52a7dde48cf311ee8051498923ad61e6-20231127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9bckHyNJG5IsDCmEKDwalIObMqsZcNV3+pMVYGOWkZA=;
        b=Ir7dyl8PjdmMjC+E7j7WJKdu7+hMtFfdIN58H9s//k+s7NSqJSzGhW86Vxfc6zWzeQVyThe33zlJ/oSxxEjzKQ2OFFg2OSgpkYT7+DXd9XHueqj4wspARvc+3LBdMRyIG6JfYuYsPX8AUS7ktTJTrce9aa9tdw9wQCbf/D1+z48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:141674e6-33b4-4460-8dc4-d6d024cc2d02,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:7cd7fcfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 52a7dde48cf311ee8051498923ad61e6-20231127
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1260820394; Mon, 27 Nov 2023 15:05:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 27 Nov 2023 15:05:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 27 Nov 2023 15:05:16 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
CC:     <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
        <qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/3] scripts/gdb/tasks: Fix lx-ps command error
Date:   Mon, 27 Nov 2023 15:04:01 +0800
Message-ID: <20231127070404.4192-2-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
References: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.762900-8.000000
X-TMASE-MatchedRID: TCPSmmY0AVNXKLar1IWcqhIRh9wkXSlFBdebOqawiLujC1E/zCEIr8Rk
        oeJ3OFRc3k+CPiKHMcLBSaBGgOy3GNEdmUPXI8FxWd1vvclMcXUUqWKocoJo6WrVm7PW4m4IaUX
        s6FguVy2veSUy9VcQXIAy6p60ZV62fJ5/bZ6npdjKayT/BQTiGmKd6TrD/tOxJTyu087Bl/3dU/
        0piiw/KVY8fik7GhBq/WJMB7lBUBeC/0zoitWvtG59So5u9ctjsIj++Y58d/rqkfDrTAOo86CjN
        WMcfCKKdATQdtPksR+3/JiWOe6GXXSWgQ2GpXdZbxffl9hhCBw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.762900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 29868F287BE6268FBBD8E35727CAA5215BC88AFF032D54227874052E0B4452B82000:8
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

Since commit 8e1f385104ac ("kill task_struct->thread_group") remove
the thread_group, we will encounter below issue.

(gdb) lx-ps
      TASK          PID    COMM
0xffff800086503340   0   swapper/0
Python Exception <class 'gdb.error'>: There is no member named thread_group.
Error occurred in Python: There is no member named thread_group.

We use signal->thread_head to iterate all threads instead.

Fixes: 8e1f385104ac ("kill task_struct->thread_group")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/tasks.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
index 17ec19e9b5bf..7c32f4c8284b 100644
--- a/scripts/gdb/linux/tasks.py
+++ b/scripts/gdb/linux/tasks.py
@@ -13,7 +13,7 @@
 
 import gdb
 
-from linux import utils
+from linux import utils, lists
 
 
 task_type = utils.CachedType("struct task_struct")
@@ -25,13 +25,9 @@ def task_lists():
     t = g = init_task
 
     while True:
-        while True:
-            yield t
-
-            t = utils.container_of(t['thread_group']['next'],
-                                   task_ptr_type, "thread_group")
-            if t == g:
-                break
+        thread_head = t['signal']['thread_head']
+        for thread in lists.list_for_each_entry(thread_head, task_ptr_type, 'thread_node'):
+            yield thread
 
         t = g = utils.container_of(g['tasks']['next'],
                                    task_ptr_type, "tasks")
-- 
2.18.0

