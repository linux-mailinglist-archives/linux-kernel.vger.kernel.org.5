Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75BC773D74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjHHQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHHQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:15:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF983DB;
        Tue,  8 Aug 2023 08:48:04 -0700 (PDT)
X-UUID: ddfef96635c511ee9cb5633481061a41-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z/V/cug+yRVLoW4a8oKn71hM6nDUiC44a/iWC7mxXGg=;
        b=apSLlkmnSGmmDUfpyzp+Gh3oErlUdheBYpcAJECWkuGF7Q2JsR7fYe/3I7U/5ha2PlFostjoP50oH9YsHOqoRKa2m651cQwiuvtSBnSWHFqQXCd/4VUxBGYD2nKRN5wlIT3/ZYbdw2oC0F+fbGKRpeL++jxWRIqKDLjmsS9vksc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:05ca33ab-c3d5-499d-8ab5-722c41ac493d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:05ca33ab-c3d5-499d-8ab5-722c41ac493d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:7ae7cfd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230808163045V7DYIVP9,BulkQuantity:1,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: ddfef96635c511ee9cb5633481061a41-20230808
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 615150699; Tue, 08 Aug 2023 16:30:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:43 +0800
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
Subject: [PATCH v2 6/8] scripts/gdb/page_owner: add page owner support
Date:   Tue, 8 Aug 2023 16:30:16 +0800
Message-ID: <20230808083020.22254-7-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GDB scripts print page owner information for user to
analyze the memory usage or memory corruption issue.

Example output from an aarch64 system:

(gdb) lx-dump-page-owner --pfn 655360
page_owner tracks the page as allocated
Page last allocated via order 0, gfp_mask: 0x8, pid: 1, tgid: 1 ("swapper/0\000\000\000\000\000\000"), ts 1295948880 ns, free_ts 1011852016 ns
PFN: 655360, Flags: 0x3fffc0000000000
   0xffff8000086ab964 <post_alloc_hook+452>:    ldp     x19, x20, [sp, #16]
   0xffff80000862e4e0 <split_map_pages+344>:    cbnz    w22, 0xffff80000862e57c <split_map_pages+500>
   0xffff8000086370c4 <isolate_freepages_range+556>:    mov     x0, x27
   0xffff8000086bc1cc <alloc_contig_range+808>: mov     x24, x0
   0xffff80000877d6d8 <cma_alloc+772>:  mov     w1, w0
   0xffff8000082c8d18 <dma_alloc_from_contiguous+104>:  ldr     x19, [sp, #16]
   0xffff8000082ce0e8 <atomic_pool_expand+208>: mov     x19, x0
   0xffff80000c1e41b4 <__dma_atomic_pool_init+172>:     Cannot access memory at address 0xffff80000c1e41b4
   0xffff80000c1e4298 <dma_atomic_pool_init+92>:        Cannot access memory at address 0xffff80000c1e4298
   0xffff8000080161d4 <do_one_initcall+176>:    mov     w21, w0
   0xffff80000c1c1b50 <kernel_init_freeable+952>:       Cannot access memory at address 0xffff80000c1c1b50
   0xffff80000acf87dc <kernel_init+36>: bl      0xffff8000081ab100 <async_synchronize_full>
   0xffff800008018d00 <ret_from_fork+16>:       mrs     x28, sp_el0
page last free stack trace:
   0xffff8000086a6e8c <free_unref_page_prepare+796>:    mov     w2, w23
   0xffff8000086aee1c <free_unref_page+96>:     tst     w0, #0xff
   0xffff8000086af3f8 <__free_pages+292>:       ldp     x19, x20, [sp, #16]
   0xffff80000c1f3214 <init_cma_reserved_pageblock+220>:        Cannot access memory at address 0xffff80000c1f3214
   0xffff80000c20363c <cma_init_reserved_areas+1284>:   Cannot access memory at address 0xffff80000c20363c
   0xffff8000080161d4 <do_one_initcall+176>:    mov     w21, w0
   0xffff80000c1c1b50 <kernel_init_freeable+952>:       Cannot access memory at address 0xffff80000c1c1b50
   0xffff80000acf87dc <kernel_init+36>: bl      0xffff8000081ab100 <async_synchronize_full>
   0xffff800008018d00 <ret_from_fork+16>:       mrs     x28, sp_el0

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/constants.py.in |   7 ++
 scripts/gdb/linux/page_owner.py   | 190 ++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   1 +
 3 files changed, 198 insertions(+)
 create mode 100644 scripts/gdb/linux/page_owner.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index f33be26253d2..52f61d65f430 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/mount.h>
 #include <linux/of_fdt.h>
+#include <linux/page_ext.h>
 #include <linux/radix-tree.h>
 #include <linux/threads.h>
 
@@ -89,6 +90,11 @@ LX_GDBPARSED(RADIX_TREE_MAP_SIZE)
 LX_GDBPARSED(RADIX_TREE_MAP_SHIFT)
 LX_GDBPARSED(RADIX_TREE_MAP_MASK)
 
+/* linux/page_ext.h */
+if IS_BUILTIN(CONFIG_PAGE_OWNER):
+    LX_GDBPARSED(PAGE_EXT_OWNER)
+    LX_GDBPARSED(PAGE_EXT_OWNER_ALLOCATED)
+
 /* Kernel Configs */
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS)
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
@@ -129,3 +135,4 @@ if IS_BUILTIN(CONFIG_NUMA):
     LX_VALUE(CONFIG_NODES_SHIFT)
 LX_CONFIG(CONFIG_DEBUG_VIRTUAL)
 LX_CONFIG(CONFIG_STACKDEPOT)
+LX_CONFIG(CONFIG_PAGE_OWNER)
diff --git a/scripts/gdb/linux/page_owner.py b/scripts/gdb/linux/page_owner.py
new file mode 100644
index 000000000000..844fd5d0c912
--- /dev/null
+++ b/scripts/gdb/linux/page_owner.py
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 MediaTek Inc.
+#
+# Authors:
+#  Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
+#
+
+import gdb
+from linux import utils, stackdepot, constants, mm
+
+if constants.LX_CONFIG_PAGE_OWNER:
+    page_ext_t = utils.CachedType('struct page_ext')
+    page_owner_t = utils.CachedType('struct page_owner')
+
+    PAGE_OWNER_STACK_DEPTH = 16
+    PAGE_EXT_OWNER = constants.LX_PAGE_EXT_OWNER
+    PAGE_EXT_INVALID = 0x1
+    PAGE_EXT_OWNER_ALLOCATED = constants.LX_PAGE_EXT_OWNER_ALLOCATED
+
+def help():
+    t = """Usage: lx-dump-page-owner [Option]
+    Option:
+        --pfn [Decimal pfn]
+    Example:
+        lx-dump-page-owner --pfn 655360\n"""
+    gdb.write("Unrecognized command\n")
+    raise gdb.GdbError(t)
+
+class DumpPageOwner(gdb.Command):
+    """Dump page owner"""
+
+    min_pfn = None
+    max_pfn = None
+    p_ops = None
+    migrate_reason_names = None
+
+    def __init__(self):
+        super(DumpPageOwner, self).__init__("lx-dump-page-owner", gdb.COMMAND_SUPPORT)
+
+    def invoke(self, args, from_tty):
+        if not constants.LX_CONFIG_PAGE_OWNER:
+            raise gdb.GdbError('CONFIG_PAGE_OWNER does not enable')
+
+        page_owner_inited = gdb.parse_and_eval('page_owner_inited')
+        if page_owner_inited['key']['enabled']['counter'] != 0x1:
+            raise gdb.GdbError('page_owner_inited is not enabled')
+
+        self.p_ops = mm.page_ops().ops
+        self.get_page_owner_info()
+        argv = gdb.string_to_argv(args)
+        if len(argv) == 0:
+              self.read_page_owner()
+        elif len(argv) == 2:
+            if argv[0] == "--pfn":
+                pfn = int(argv[1])
+                self.read_page_owner_by_addr(self.p_ops.pfn_to_page(pfn))
+            else:
+                help()
+        else:
+            help()
+
+    def get_page_owner_info(self):
+        self.min_pfn = int(gdb.parse_and_eval("min_low_pfn"))
+        self.max_pfn = int(gdb.parse_and_eval("max_pfn"))
+        self.page_ext_size = int(gdb.parse_and_eval("page_ext_size"))
+        self.migrate_reason_names = gdb.parse_and_eval('migrate_reason_names')
+
+    def page_ext_invalid(self, page_ext):
+        if page_ext == gdb.Value(0):
+            return True
+        if page_ext.cast(utils.get_ulong_type()) & PAGE_EXT_INVALID == PAGE_EXT_INVALID:
+            return True
+        return False
+
+    def get_entry(self, base, index):
+        return (base.cast(utils.get_ulong_type()) + self.page_ext_size * index).cast(page_ext_t.get_type().pointer())
+
+    def lookup_page_ext(self, page):
+        pfn = self.p_ops.page_to_pfn(page)
+        section = self.p_ops.pfn_to_section(pfn)
+        page_ext = section["page_ext"]
+        if self.page_ext_invalid(page_ext):
+            return gdb.Value(0)
+        return self.get_entry(page_ext, pfn)
+
+    def page_ext_get(self, page):
+        page_ext = self.lookup_page_ext(page)
+        if page_ext != gdb.Value(0):
+            return page_ext
+        else:
+            return gdb.Value(0)
+
+    def get_page_owner(self, page_ext):
+        addr = page_ext.cast(utils.get_ulong_type()) + gdb.parse_and_eval("page_owner_ops")["offset"].cast(utils.get_ulong_type())
+        return addr.cast(page_owner_t.get_type().pointer())
+
+    def read_page_owner_by_addr(self, struct_page_addr):
+        page = gdb.Value(struct_page_addr).cast(utils.get_page_type().pointer())
+        pfn = self.p_ops.page_to_pfn(page)
+
+        if pfn < self.min_pfn or pfn > self.max_pfn or (not self.p_ops.pfn_valid(pfn)):
+            gdb.write("pfn is invalid\n")
+            return
+
+        page = self.p_ops.pfn_to_page(pfn)
+        page_ext = self.page_ext_get(page)
+
+        if page_ext == gdb.Value(0):
+            gdb.write("page_ext is null\n")
+            return
+
+        if not (page_ext['flags'] & (1 << PAGE_EXT_OWNER)):
+            gdb.write("page_owner flag is invalid\n")
+            raise gdb.GdbError('page_owner info is not present (never set?)\n')
+
+        if mm.test_bit(PAGE_EXT_OWNER_ALLOCATED, page_ext['flags'].address):
+            gdb.write('page_owner tracks the page as allocated\n')
+        else:
+            gdb.write('page_owner tracks the page as freed\n')
+
+        if not (page_ext['flags'] & (1 << PAGE_EXT_OWNER_ALLOCATED)):
+            gdb.write("page_owner is not allocated\n")
+
+        try:
+            page_owner = self.get_page_owner(page_ext)
+            gdb.write("Page last allocated via order %d, gfp_mask: 0x%x, pid: %d, tgid: %d (%s), ts %u ns, free_ts %u ns\n" %\
+                    (page_owner["order"], page_owner["gfp_mask"],\
+                    page_owner["pid"], page_owner["tgid"], page_owner["comm"],\
+                    page_owner["ts_nsec"], page_owner["free_ts_nsec"]))
+            gdb.write("PFN: %d, Flags: 0x%x\n" % (pfn, page['flags']))
+            if page_owner["handle"] == 0:
+                gdb.write('page_owner allocation stack trace missing\n')
+            else:
+                stackdepot.stack_depot_print(page_owner["handle"])
+
+            if page_owner["free_handle"] == 0:
+                gdb.write('page_owner free stack trace missing\n')
+            else:
+                gdb.write('page last free stack trace:\n')
+                stackdepot.stack_depot_print(page_owner["free_handle"])
+            if page_owner['last_migrate_reason'] != -1:
+                gdb.write('page has been migrated, last migrate reason: %s\n' % self.migrate_reason_names[page_owner['last_migrate_reason']])
+        except:
+            gdb.write("\n")
+
+    def read_page_owner(self):
+        pfn = self.min_pfn
+
+        # Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area
+        while ((not self.p_ops.pfn_valid(pfn)) and (pfn & (self.p_ops.MAX_ORDER_NR_PAGES - 1))) != 0:
+            pfn += 1
+
+        while pfn < self.max_pfn:
+            #
+            # If the new page is in a new MAX_ORDER_NR_PAGES area,
+            # validate the area as existing, skip it if not
+            #
+            if ((pfn & (self.p_ops.MAX_ORDER_NR_PAGES - 1)) == 0) and (not self.p_ops.pfn_valid(pfn)):
+                pfn += (self.p_ops.MAX_ORDER_NR_PAGES - 1)
+                continue;
+
+            page = self.p_ops.pfn_to_page(pfn)
+            page_ext = self.page_ext_get(page)
+            if page_ext == gdb.Value(0):
+                pfn += 1
+                continue
+
+            if not (page_ext['flags'] & (1 << PAGE_EXT_OWNER)):
+                pfn += 1
+                continue
+            if not (page_ext['flags'] & (1 << PAGE_EXT_OWNER_ALLOCATED)):
+                pfn += 1
+                continue
+
+            try:
+                page_owner = self.get_page_owner(page_ext)
+                gdb.write("Page allocated via order %d, gfp_mask: 0x%x, pid: %d, tgid: %d (%s), ts %u ns, free_ts %u ns\n" %\
+                        (page_owner["order"], page_owner["gfp_mask"],\
+                        page_owner["pid"], page_owner["tgid"], page_owner["comm"],\
+                        page_owner["ts_nsec"], page_owner["free_ts_nsec"]))
+                gdb.write("PFN: %d, Flags: 0x%x\n" % (pfn, page['flags']))
+                stackdepot.stack_depot_print(page_owner["handle"])
+                pfn += (1 << page_owner["order"])
+                continue
+            except:
+                gdb.write("\n")
+            pfn += 1
+
+DumpPageOwner()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 24f149694b81..89465f0de548 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -46,3 +46,4 @@ else:
     import linux.interrupts
     import linux.mm
     import linux.stackdepot
+    import linux.page_owner
-- 
2.18.0

