Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E4B760F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjGYJhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjGYJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:36:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506F3C0F;
        Tue, 25 Jul 2023 02:35:40 -0700 (PDT)
X-UUID: 9b799b022ace11ee9cb5633481061a41-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yPZv3tM9vTtpWd34AkCCKWUdpVmNx/aOuZOzG2VcV74=;
        b=r2NxIXm8d7FUY+Nyld7O5AzqQjHDZ6hIX0c+G1WwpEfMiiUxWmCkSIOPDzJWExF2/+gdoL9BaeXCyAj2SOnFsjmbxKhII/uZQct7ZG52cRk38a/HSBmUhTotz2q+MCZUaeTXdYRMIUKVWwUZsucyvQbDlzZc8oHnDOBI0FUKcUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:a4a64595-c37b-47f3-bf56-263a4859d1b5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:4f244dd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9b799b022ace11ee9cb5633481061a41-20230725
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1194019998; Tue, 25 Jul 2023 17:35:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 17:35:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 17:35:34 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
        <casper.li@mediatek.com>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5/8] scripts/gdb/stackdepot: Add stackdepot support
Date:   Tue, 25 Jul 2023 17:34:55 +0800
Message-ID: <20230725093458.30064-6-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
References: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for printing the backtrace of stackdepot handle.

This is the preparation patch for dumping page_owner,
slabtrace usage.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/constants.py.in |  1 +
 scripts/gdb/linux/stackdepot.py   | 54 +++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |  1 +
 3 files changed, 56 insertions(+)
 create mode 100644 scripts/gdb/linux/stackdepot.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 7c44222bbf23..ec88c9affdd2 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -133,3 +133,4 @@ LX_CONFIG(CONFIG_VMAP_STACK)
 if IS_BUILTIN(CONFIG_NUMA):
     LX_VALUE(CONFIG_NODES_SHIFT)
 LX_CONFIG(CONFIG_DEBUG_VIRTUAL)
+LX_CONFIG(CONFIG_STACKDEPOT)
diff --git a/scripts/gdb/linux/stackdepot.py b/scripts/gdb/linux/stackdepot.py
new file mode 100644
index 000000000000..03b5eb19f056
--- /dev/null
+++ b/scripts/gdb/linux/stackdepot.py
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 MediaTek Inc.
+#
+# Authors:
+#  Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
+#
+
+import gdb
+from linux import utils, constants
+
+stack_record_type = utils.CachedType('struct stack_record')
+DEPOT_STACK_ALIGN = 4
+
+def stack_depot_fetch(handle):
+    global DEPOT_STACK_ALIGN
+    global stack_record_type
+
+    stack_depot_disabled = gdb.parse_and_eval('stack_depot_disabled')
+
+    if stack_depot_disabled:
+        raise gdb.GdbError("stack_depot_disabled\n")
+
+    handle_parts_t = gdb.lookup_type("union handle_parts")
+    parts = handle.cast(handle_parts_t)
+    offset = parts['offset'] << DEPOT_STACK_ALIGN
+    pool_index_cached = gdb.parse_and_eval('pool_index')
+
+    if parts['pool_index'] > pool_index_cached:
+        gdb.write("pool index %d out of bounds (%d) for stack id 0x%08x\n" % (parts['pool_index'], pool_index_cached, handle))
+        return gdb.Value(0), 0
+
+    stack_pools = gdb.parse_and_eval('stack_pools')
+
+    try:
+        pool = stack_pools[parts['pool_index']]
+        stack = (pool + gdb.Value(offset).cast(utils.get_size_t_type())).cast(stack_record_type.get_type().pointer())
+        size = int(stack['size'].cast(utils.get_ulong_type()))
+        return stack['entries'], size
+    except Exception as e:
+        gdb.write("%s\n" % e)
+        return gdb.Value(0), 0
+
+def stack_depot_print(handle):
+    if not constants.LX_CONFIG_STACKDEPOT:
+        raise gdb.GdbError("CONFIG_STACKDEPOT is not enabled")
+
+    entries, nr_entries = stack_depot_fetch(handle)
+    if nr_entries > 0:
+        for i in range(0, nr_entries):
+            try:
+                gdb.execute("x /i 0x%x" % (int(entries[i])))
+            except Exception as e:
+                gdb.write("%s\n" % e)
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index fd24574bcec9..24f149694b81 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -45,3 +45,4 @@ else:
     import linux.radixtree
     import linux.interrupts
     import linux.mm
+    import linux.stackdepot
-- 
2.18.0

