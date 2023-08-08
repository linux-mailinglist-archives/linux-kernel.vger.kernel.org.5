Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1F773D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjHHQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjHHQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:14:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D183D0;
        Tue,  8 Aug 2023 08:48:02 -0700 (PDT)
X-UUID: d995d2a035c511eeb20a276fd37b9834-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KkKl47yr9p1LdaLrQw4ux4p7T6jvHHScktOtGmDcFH0=;
        b=Be3erY+BCgnclOYey5Lmx4RH4YB+tTD1dGRVXk3st2OruxqOClkmWCvvK6xcc+OuIhaR7cc5DKKjliDsLIot/azLE9VMfO6Od2CZP3zpIVaAytref8WQ/IH//JW2oB/f6F+4mtw16eHKyXDbCM3eStuErKdYBaestdpRr76Lk6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:22775343-9ffc-4a68-a5b0-369fc9784842,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:203b04a1-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: d995d2a035c511eeb20a276fd37b9834-20230808
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 978280723; Tue, 08 Aug 2023 16:30:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:36 +0800
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
Subject: [PATCH v2 4/8] scripts/gdb/aarch64: add aarch64 page operation helper commands and configs
Date:   Tue, 8 Aug 2023 16:30:14 +0800
Message-ID: <20230808083020.22254-5-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
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

1. Move page table debugging from mm.py to pgtable.py.

2. Add aarch64 kernel config and memory constants value.

3. Add below aarch64 page operation helper commands.
   page_to_pfn, page_to_phys, pfn_to_page, page_address,
   virt_to_phys, sym_to_pfn, pfn_to_kaddr, virt_to_page.

4. Only support CONFIG_SPARSEMEM_VMEMMAP=y now.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/constants.py.in |  23 ++
 scripts/gdb/linux/mm.py           | 582 +++++++++++++++++++-----------
 scripts/gdb/linux/pgtable.py      | 222 ++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   3 +-
 4 files changed, 626 insertions(+), 204 deletions(-)
 create mode 100644 scripts/gdb/linux/pgtable.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index fab74ca9df6f..0805aeab3dcd 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -105,3 +105,26 @@ LX_CONFIG(CONFIG_X86_MCE_AMD)
 LX_CONFIG(CONFIG_X86_MCE)
 LX_CONFIG(CONFIG_X86_IO_APIC)
 LX_CONFIG(CONFIG_HAVE_KVM)
+LX_CONFIG(CONFIG_NUMA)
+LX_CONFIG(CONFIG_ARM64)
+LX_CONFIG(CONFIG_ARM64_4K_PAGES)
+LX_CONFIG(CONFIG_ARM64_16K_PAGES)
+LX_CONFIG(CONFIG_ARM64_64K_PAGES)
+if IS_BUILTIN(CONFIG_ARM64):
+    LX_VALUE(CONFIG_ARM64_PA_BITS)
+    LX_VALUE(CONFIG_ARM64_VA_BITS)
+    LX_VALUE(CONFIG_ARM64_PAGE_SHIFT)
+    LX_VALUE(CONFIG_ARCH_FORCE_MAX_ORDER)
+LX_CONFIG(CONFIG_SPARSEMEM)
+LX_CONFIG(CONFIG_SPARSEMEM_EXTREME)
+LX_CONFIG(CONFIG_SPARSEMEM_VMEMMAP)
+LX_CONFIG(CONFIG_KASAN)
+LX_CONFIG(CONFIG_KASAN_GENERIC)
+LX_CONFIG(CONFIG_KASAN_SW_TAGS)
+LX_CONFIG(CONFIG_KASAN_HW_TAGS)
+if IS_BUILTIN(CONFIG_KASAN_GENERIC) or IS_BUILTIN(CONFIG_KASAN_SW_TAGS):
+    LX_VALUE(CONFIG_KASAN_SHADOW_OFFSET)
+LX_CONFIG(CONFIG_VMAP_STACK)
+if IS_BUILTIN(CONFIG_NUMA):
+    LX_VALUE(CONFIG_NODES_SHIFT)
+LX_CONFIG(CONFIG_DEBUG_VIRTUAL)
diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index 30d837f3dfae..ad5641dcb068 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -1,222 +1,398 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0
 #
-# gdb helper commands and functions for Linux kernel debugging
-#
-#  routines to introspect page table
+# Copyright (c) 2023 MediaTek Inc.
 #
 # Authors:
-#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
+#  Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
 #
 
 import gdb
+import math
+from linux import utils, constants
+
+def DIV_ROUND_UP(n,d):
+    return ((n) + (d) - 1) // (d)
 
-from linux import utils
+def test_bit(nr, addr):
+    if addr.dereference() & (0x1 << nr):
+        return True
+    else:
+        return False
 
-PHYSICAL_ADDRESS_MASK = gdb.parse_and_eval('0xfffffffffffff')
+class page_ops():
+    ops = None
+    def __init__(self):
+        if not constants.LX_CONFIG_SPARSEMEM_VMEMMAP:
+            raise gdb.GdbError('Only support CONFIG_SPARSEMEM_VMEMMAP now')
+        if constants.LX_CONFIG_ARM64 and utils.is_target_arch('aarch64'):
+            self.ops = aarch64_page_ops()
+        else:
+            raise gdb.GdbError('Only support aarch64 now')
 
+class aarch64_page_ops():
+    def __init__(self):
+        self.SUBSECTION_SHIFT = 21
+        self.SEBSECTION_SIZE = 1 << self.SUBSECTION_SHIFT
+        self.MODULES_VSIZE = 128 * 1024 * 1024
 
-def page_mask(level=1):
-    # 4KB
-    if level == 1:
-        return gdb.parse_and_eval('(u64) ~0xfff')
-    # 2MB
-    elif level == 2:
-        return gdb.parse_and_eval('(u64) ~0x1fffff')
-    # 1GB
-    elif level == 3:
-        return gdb.parse_and_eval('(u64) ~0x3fffffff')
-    else:
-        raise Exception(f'Unknown page level: {level}')
-
-
-#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
-POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
-def _page_offset_base():
-    pob_symbol = gdb.lookup_global_symbol('page_offset_base')
-    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
-    return gdb.parse_and_eval(pob)
-
-
-def is_bit_defined_tupled(data, offset):
-    return offset, bool(data >> offset & 1)
-
-def content_tupled(data, bit_start, bit_end):
-    return (bit_start, bit_end), data >> bit_start & ((1 << (1 + bit_end - bit_start)) - 1)
-
-def entry_va(level, phys_addr, translating_va):
-        def start_bit(level):
-            if level == 5:
-                return 48
-            elif level == 4:
-                return 39
-            elif level == 3:
-                return 30
-            elif level == 2:
-                return 21
-            elif level == 1:
-                return 12
+        if constants.LX_CONFIG_ARM64_64K_PAGES:
+            self.SECTION_SIZE_BITS = 29
+        else:
+            self.SECTION_SIZE_BITS = 27
+        self.MAX_PHYSMEM_BITS = constants.LX_CONFIG_ARM64_VA_BITS
+
+        self.PAGE_SHIFT = constants.LX_CONFIG_ARM64_PAGE_SHIFT
+        self.PAGE_SIZE = 1 << self.PAGE_SHIFT
+        self.PAGE_MASK = (~(self.PAGE_SIZE - 1)) & ((1 << 64) - 1)
+
+        self.VA_BITS = constants.LX_CONFIG_ARM64_VA_BITS
+        if self.VA_BITS > 48:
+            self.VA_BITS_MIN = 48
+            self.vabits_actual = gdb.parse_and_eval('vabits_actual')
+        else:
+            self.VA_BITS_MIN = self.VA_BITS
+            self.vabits_actual = self.VA_BITS
+        self.kimage_voffset = gdb.parse_and_eval('kimage_voffset') & ((1 << 64) - 1)
+
+        self.SECTIONS_SHIFT = self.MAX_PHYSMEM_BITS - self.SECTION_SIZE_BITS
+
+        if str(constants.LX_CONFIG_ARCH_FORCE_MAX_ORDER).isdigit():
+            self.MAX_ORDER = constants.LX_CONFIG_ARCH_FORCE_MAX_ORDER
+        else:
+            self.MAX_ORDER = 11
+
+        self.MAX_ORDER_NR_PAGES = 1 << (self.MAX_ORDER - 1)
+        self.PFN_SECTION_SHIFT = self.SECTION_SIZE_BITS - self.PAGE_SHIFT
+        self.NR_MEM_SECTIONS = 1 << self.SECTIONS_SHIFT
+        self.PAGES_PER_SECTION = 1 << self.PFN_SECTION_SHIFT
+        self.PAGE_SECTION_MASK = (~(self.PAGES_PER_SECTION - 1)) & ((1 << 64) - 1)
+
+        if constants.LX_CONFIG_SPARSEMEM_EXTREME:
+            self.SECTIONS_PER_ROOT = self.PAGE_SIZE // gdb.lookup_type("struct mem_section").sizeof
+        else:
+            self.SECTIONS_PER_ROOT = 1
+
+        self.NR_SECTION_ROOTS = DIV_ROUND_UP(self.NR_MEM_SECTIONS, self.SECTIONS_PER_ROOT)
+        self.SECTION_ROOT_MASK = self.SECTIONS_PER_ROOT - 1
+        self.SUBSECTION_SHIFT = 21
+        self.SEBSECTION_SIZE = 1 << self.SUBSECTION_SHIFT
+        self.PFN_SUBSECTION_SHIFT = self.SUBSECTION_SHIFT - self.PAGE_SHIFT
+        self.PAGES_PER_SUBSECTION = 1 << self.PFN_SUBSECTION_SHIFT
+
+        self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
+        self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
+
+        self.struct_page_size = utils.get_page_type().sizeof
+        self.STRUCT_PAGE_MAX_SHIFT = (int)(math.log(self.struct_page_size, 2))
+
+        self.PAGE_OFFSET = self._PAGE_OFFSET(self.VA_BITS)
+        self.MODULES_VADDR = self._PAGE_END(self.VA_BITS_MIN)
+        self.MODULES_END = self.MODULES_VADDR + self.MODULES_VSIZE
+
+        self.VMEMMAP_SHIFT = (self.PAGE_SHIFT - self.STRUCT_PAGE_MAX_SHIFT)
+        self.VMEMMAP_SIZE = ((self._PAGE_END(self.VA_BITS_MIN) - self.PAGE_OFFSET) >> self.VMEMMAP_SHIFT)
+        self.VMEMMAP_START = (-(1 << (self.VA_BITS - self.VMEMMAP_SHIFT))) & 0xffffffffffffffff
+        self.VMEMMAP_END = self.VMEMMAP_START + self.VMEMMAP_SIZE
+
+        self.VMALLOC_START = self.MODULES_END
+        self.VMALLOC_END = self.VMEMMAP_START - 256 * 1024 * 1024
+
+        self.memstart_addr = gdb.parse_and_eval("memstart_addr")
+        self.PHYS_OFFSET = self.memstart_addr
+        self.vmemmap = gdb.Value(self.VMEMMAP_START).cast(utils.get_page_type().pointer()) - (self.memstart_addr >> self.PAGE_SHIFT)
+
+        self.KERNEL_START = gdb.parse_and_eval("_text")
+        self.KERNEL_END = gdb.parse_and_eval("_end")
+
+        if constants.LX_CONFIG_KASAN_GENERIC or constants.LX_CONFIG_KASAN_SW_TAGS:
+            if constants.LX_CONFIG_KASAN_GENERIC:
+                self.KASAN_SHADOW_SCALE_SHIFT = 3
             else:
-                raise Exception(f'Unknown level {level}')
-
-        entry_offset =  ((translating_va >> start_bit(level)) & 511) * 8
-        entry_va = _page_offset_base() + phys_addr + entry_offset
-        return entry_va
-
-class Cr3():
-    def __init__(self, cr3, page_levels):
-        self.cr3 = cr3
-        self.page_levels = page_levels
-        self.page_level_write_through = is_bit_defined_tupled(cr3, 3)
-        self.page_level_cache_disabled = is_bit_defined_tupled(cr3, 4)
-        self.next_entry_physical_address = cr3 & PHYSICAL_ADDRESS_MASK & page_mask()
-
-    def next_entry(self, va):
-        next_level = self.page_levels
-        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
-
-    def mk_string(self):
-            return f"""\
-cr3:
-    {'cr3 binary data': <30} {hex(self.cr3)}
-    {'next entry physical address': <30} {hex(self.next_entry_physical_address)}
-    ---
-    {'bit' : <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
-    {'bit' : <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
-"""
-
-
-class PageHierarchyEntry():
-    def __init__(self, address, level):
-        data = int.from_bytes(
-            memoryview(gdb.selected_inferior().read_memory(address, 8)),
-            "little"
-        )
-        if level == 1:
-            self.is_page = True
-            self.entry_present = is_bit_defined_tupled(data, 0)
-            self.read_write = is_bit_defined_tupled(data, 1)
-            self.user_access_allowed = is_bit_defined_tupled(data, 2)
-            self.page_level_write_through = is_bit_defined_tupled(data, 3)
-            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
-            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
-            self.dirty = is_bit_defined_tupled(data, 6)
-            self.pat = is_bit_defined_tupled(data, 7)
-            self.global_translation = is_bit_defined_tupled(data, 8)
-            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level)
-            self.next_entry_physical_address = None
-            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
-            self.protection_key = content_tupled(data, 59, 62)
-            self.executed_disable = is_bit_defined_tupled(data, 63)
+                self.KASAN_SHADOW_SCALE_SHIFT = 4
+            self.KASAN_SHADOW_OFFSET = constants.LX_CONFIG_KASAN_SHADOW_OFFSET
+            self.KASAN_SHADOW_END = (1 << (64 - self.KASAN_SHADOW_SCALE_SHIFT)) + self.KASAN_SHADOW_OFFSET
+            self.PAGE_END = self.KASAN_SHADOW_END - (1 << (self.vabits_actual - self.KASAN_SHADOW_SCALE_SHIFT))
+        else:
+            self.PAGE_END = self._PAGE_END(self.VA_BITS_MIN)
+
+        if constants.LX_CONFIG_NUMA and constants.LX_CONFIG_NODES_SHIFT:
+            self.NODE_SHIFT = constants.LX_CONFIG_NODES_SHIFT
+        else:
+            self.NODE_SHIFT = 0
+
+        self.MAX_NUMNODES = 1 << self.NODE_SHIFT
+
+    def SECTION_NR_TO_ROOT(self, sec):
+        return sec // self.SECTIONS_PER_ROOT
+
+    def __nr_to_section(self, nr):
+        root = self.SECTION_NR_TO_ROOT(nr)
+        mem_section = gdb.parse_and_eval("mem_section")
+        return mem_section[root][nr & self.SECTION_ROOT_MASK]
+
+    def pfn_to_section_nr(self, pfn):
+        return pfn >> self.PFN_SECTION_SHIFT
+
+    def section_nr_to_pfn(self, sec):
+        return sec << self.PFN_SECTION_SHIFT
+
+    def __pfn_to_section(self, pfn):
+        return self.__nr_to_section(self.pfn_to_section_nr(pfn))
+
+    def pfn_to_section(self, pfn):
+        return self.__pfn_to_section(pfn)
+
+    def subsection_map_index(self, pfn):
+        return (pfn & ~(self.PAGE_SECTION_MASK)) // self.PAGES_PER_SUBSECTION
+
+    def pfn_section_valid(self, ms, pfn):
+        if constants.LX_CONFIG_SPARSEMEM_VMEMMAP:
+            idx = self.subsection_map_index(pfn)
+            return test_bit(idx, ms['usage']['subsection_map'])
+        else:
+            return True
+
+    def valid_section(self, mem_section):
+        if mem_section != None and (mem_section['section_mem_map'] & self.SECTION_HAS_MEM_MAP):
+            return True
+        return False
+
+    def early_section(self, mem_section):
+        if mem_section != None and (mem_section['section_mem_map'] & self.SECTION_IS_EARLY):
+            return True
+        return False
+
+    def pfn_valid(self, pfn):
+        ms = None
+        if self.PHYS_PFN(self.PFN_PHYS(pfn)) != pfn:
+            return False
+        if self.pfn_to_section_nr(pfn) >= self.NR_MEM_SECTIONS:
+            return False
+        ms = self.__pfn_to_section(pfn)
+
+        if not self.valid_section(ms):
+            return False
+        return self.early_section(ms) or self.pfn_section_valid(ms, pfn)
+
+    def _PAGE_OFFSET(self, va):
+        return (-(1 << (va))) & 0xffffffffffffffff
+
+    def _PAGE_END(self, va):
+        return (-(1 << (va - 1))) & 0xffffffffffffffff
+
+    def kasan_reset_tag(self, addr):
+        if constants.LX_CONFIG_KASAN_SW_TAGS or constants.LX_CONFIG_KASAN_HW_TAGS:
+            return int(addr) | (0xff << 56)
+        else:
+            return addr
+
+    def __is_lm_address(self, addr):
+        if (addr - self.PAGE_OFFSET) < (self.PAGE_END - self.PAGE_OFFSET):
+            return True
+        else:
+            return False
+    def __lm_to_phys(self, addr):
+        return addr - self.PAGE_OFFSET + self.PHYS_OFFSET
+
+    def __kimg_to_phys(self, addr):
+        return addr - self.kimage_voffset
+
+    def __virt_to_phys_nodebug(self, va):
+        untagged_va = self.kasan_reset_tag(va)
+        if self.__is_lm_address(untagged_va):
+            return self.__lm_to_phys(untagged_va)
+        else:
+            return self.__kimg_to_phys(untagged_va)
+
+    def __virt_to_phys(self, va):
+        if constants.LX_CONFIG_DEBUG_VIRTUAL:
+            if not self.__is_lm_address(self.kasan_reset_tag(va)):
+                raise gdb.GdbError("Warning: virt_to_phys used for non-linear address: 0x%lx\n" % va)
+        return self.__virt_to_phys_nodebug(va)
+
+    def virt_to_phys(self, va):
+        return self.__virt_to_phys(va)
+
+    def PFN_PHYS(self, pfn):
+        return pfn << self.PAGE_SHIFT
+
+    def PHYS_PFN(self, phys):
+        return phys >> self.PAGE_SHIFT
+
+    def __phys_to_virt(self, pa):
+        return (pa - self.PHYS_OFFSET) | self.PAGE_OFFSET
+
+    def __phys_to_pfn(self, pa):
+        return self.PHYS_PFN(pa)
+
+    def __pfn_to_phys(self, pfn):
+        return self.PFN_PHYS(pfn)
+
+    def __pa_symbol_nodebug(self, x):
+        return self.__kimg_to_phys(x)
+
+    def __phys_addr_symbol(self, x):
+        if constants.LX_CONFIG_DEBUG_VIRTUAL:
+            if x < self.KERNEL_START or x > self.KERNEL_END:
+                raise gdb.GdbError("0x%x exceed kernel range" % x)
+        return self.__pa_symbol_nodebug(x)
+
+    def __pa_symbol(self, x):
+        return self.__phys_addr_symbol(x)
+
+    def __va(self, pa):
+        return self.__phys_to_virt(pa)
+
+    def pfn_to_kaddr(self, pfn):
+        return self.__va(pfn << self.PAGE_SHIFT)
+
+    def virt_to_pfn(self, va):
+        return self.__phys_to_pfn(self.__virt_to_phys(va))
+
+    def sym_to_pfn(self, x):
+        return self.__phys_to_pfn(self.__pa_symbol(x))
+
+    def page_to_pfn(self, page):
+        return int(page.cast(utils.get_page_type().pointer()) - self.vmemmap.cast(utils.get_page_type().pointer()))
+
+    def page_to_phys(self, page):
+        return self.__pfn_to_phys(self.page_to_pfn(page))
+
+    def pfn_to_page(self, pfn):
+        return (self.vmemmap + pfn).cast(utils.get_page_type().pointer())
+
+    def page_to_virt(self, page):
+        if constants.LX_CONFIG_DEBUG_VIRTUAL:
+            return self.__va(self.page_to_phys(page))
         else:
-            page_size = is_bit_defined_tupled(data, 7)
-            page_size_bit = page_size[1]
-            self.is_page = page_size_bit
-            self.entry_present = is_bit_defined_tupled(data, 0)
-            self.read_write = is_bit_defined_tupled(data, 1)
-            self.user_access_allowed = is_bit_defined_tupled(data, 2)
-            self.page_level_write_through = is_bit_defined_tupled(data, 3)
-            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
-            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
-            self.page_size = page_size
-            self.dirty = is_bit_defined_tupled(
-                data, 6) if page_size_bit else None
-            self.global_translation = is_bit_defined_tupled(
-                data, 8) if page_size_bit else None
-            self.pat = is_bit_defined_tupled(
-                data, 12) if page_size_bit else None
-            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level) if page_size_bit else None
-            self.next_entry_physical_address = None if page_size_bit else data & PHYSICAL_ADDRESS_MASK & page_mask()
-            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
-            self.protection_key = content_tupled(data, 59, 62) if page_size_bit else None
-            self.executed_disable = is_bit_defined_tupled(data, 63)
-        self.address = address
-        self.page_entry_binary_data = data
-        self.page_hierarchy_level = level
-
-    def next_entry(self, va):
-        if self.is_page or not self.entry_present[1]:
-            return None
-
-        next_level = self.page_hierarchy_level - 1
-        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
-
-
-    def mk_string(self):
-        if not self.entry_present[1]:
-            return f"""\
-level {self.page_hierarchy_level}:
-    {'entry address': <30} {hex(self.address)}
-    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
-    ---
-    PAGE ENTRY IS NOT PRESENT!
-"""
-        elif self.is_page:
-            def page_size_line(ps_bit, ps, level):
-                return "" if level == 1 else f"{'bit': <3} {ps_bit: <5} {'page size': <30} {ps}"
-
-            return f"""\
-level {self.page_hierarchy_level}:
-    {'entry address': <30} {hex(self.address)}
-    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
-    {'page size': <30} {'1GB' if self.page_hierarchy_level == 3 else '2MB' if self.page_hierarchy_level == 2 else '4KB' if self.page_hierarchy_level == 1 else 'Unknown page size for level:' + self.page_hierarchy_level}
-    {'page physical address': <30} {hex(self.page_physical_address)}
-    ---
-    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
-    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
-    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
-    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
-    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
-    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
-    {"" if self.page_hierarchy_level == 1 else f"{'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}"}
-    {'bit': <4} {self.dirty[0]: <10} {'page dirty': <30} {self.dirty[1]}
-    {'bit': <4} {self.global_translation[0]: <10} {'global translation': <30} {self.global_translation[1]}
-    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
-    {'bit': <4} {self.pat[0]: <10} {'pat': <30} {self.pat[1]}
-    {'bits': <4} {str(self.protection_key[0]): <10} {'protection key': <30} {self.protection_key[1]}
-    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
-"""
+            __idx = int((page.cast(gdb.lookup_type("unsigned long")) - self.VMEMMAP_START).cast(utils.get_ulong_type())) // self.struct_page_size
+            return self.PAGE_OFFSET + (__idx * self.PAGE_SIZE)
+
+    def virt_to_page(self, va):
+        if constants.LX_CONFIG_DEBUG_VIRTUAL:
+            return self.pfn_to_page(self.virt_to_pfn(va))
         else:
-            return f"""\
-level {self.page_hierarchy_level}:
-    {'entry address': <30} {hex(self.address)}
-    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
-    {'next entry physical address': <30} {hex(self.next_entry_physical_address)}
-    ---
-    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
-    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
-    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
-    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
-    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
-    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
-    {'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}
-    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
-    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
-"""
-
-
-class TranslateVM(gdb.Command):
-    """Prints the entire paging structure used to translate a given virtual address.
-
-Having an address space of the currently executed process translates the virtual address
-and prints detailed information of all paging structure levels used for the transaltion.
-Currently supported arch: x86"""
+            __idx = int(self.kasan_reset_tag(va) - self.PAGE_OFFSET) // self.PAGE_SIZE
+            addr = self.VMEMMAP_START + (__idx * self.struct_page_size)
+            return gdb.Value(addr).cast(utils.get_page_type().pointer())
+
+    def page_address(self, page):
+        return self.page_to_virt(page)
+
+    def folio_address(self, folio):
+        return self.page_address(folio['page'].address)
+
+class LxPFN2Page(gdb.Command):
+    """PFN to struct page"""
 
     def __init__(self):
-        super(TranslateVM, self).__init__('translate-vm', gdb.COMMAND_USER)
+        super(LxPFN2Page, self).__init__("lx-pfn_to_page", gdb.COMMAND_USER)
 
     def invoke(self, arg, from_tty):
-        if utils.is_target_arch("x86"):
-            vm_address = gdb.parse_and_eval(f'{arg}')
-            cr3_data = gdb.parse_and_eval('$cr3')
-            cr4 = gdb.parse_and_eval('$cr4')
-            page_levels = 5 if cr4 & (1 << 12) else 4
-            page_entry = Cr3(cr3_data, page_levels)
-            while page_entry:
-                gdb.write(page_entry.mk_string())
-                page_entry = page_entry.next_entry(vm_address)
-        else:
-            gdb.GdbError("Virtual address translation is not"
-                         "supported for this arch")
+        argv = gdb.string_to_argv(arg)
+        pfn = int(argv[0])
+        page = page_ops().ops.pfn_to_page(pfn)
+        gdb.write("pfn_to_page(0x%x) = 0x%x\n" % (pfn, page))
+
+LxPFN2Page()
+
+class LxPage2PFN(gdb.Command):
+    """struct page to PFN"""
+
+    def __init__(self):
+        super(LxPage2PFN, self).__init__("lx-page_to_pfn", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        struct_page_addr = int(argv[0], 16)
+        page = gdb.Value(struct_page_addr).cast(utils.get_page_type().pointer())
+        pfn = page_ops().ops.page_to_pfn(page)
+        gdb.write("page_to_pfn(0x%x) = 0x%x\n" % (page, pfn))
+
+LxPage2PFN()
+
+class LxPageAddress(gdb.Command):
+    """struct page to linear mapping address"""
+
+    def __init__(self):
+        super(LxPageAddress, self).__init__("lx-page_address", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        struct_page_addr = int(argv[0], 16)
+        page = gdb.Value(struct_page_addr).cast(utils.get_page_type().pointer())
+        addr = page_ops().ops.page_address(page)
+        gdb.write("page_address(0x%x) = 0x%x\n" % (page, addr))
 
+LxPageAddress()
+
+class LxPage2Phys(gdb.Command):
+    """struct page to physical address"""
+
+    def __init__(self):
+        super(LxPage2Phys, self).__init__("lx-page_to_phys", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        struct_page_addr = int(argv[0], 16)
+        page = gdb.Value(struct_page_addr).cast(utils.get_page_type().pointer())
+        phys_addr = page_ops().ops.page_to_phys(page)
+        gdb.write("page_to_phys(0x%x) = 0x%x\n" % (page, phys_addr))
+
+LxPage2Phys()
+
+class LxVirt2Phys(gdb.Command):
+    """virtual address to physical address"""
+
+    def __init__(self):
+        super(LxVirt2Phys, self).__init__("lx-virt_to_phys", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        linear_addr = int(argv[0], 16)
+        phys_addr = page_ops().ops.virt_to_phys(linear_addr)
+        gdb.write("virt_to_phys(0x%x) = 0x%x\n" % (linear_addr, phys_addr))
+
+LxVirt2Phys()
+
+class LxVirt2Page(gdb.Command):
+    """virtual address to struct page"""
+
+    def __init__(self):
+        super(LxVirt2Page, self).__init__("lx-virt_to_page", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        linear_addr = int(argv[0], 16)
+        page = page_ops().ops.virt_to_page(linear_addr)
+        gdb.write("virt_to_page(0x%x) = 0x%x\n" % (linear_addr, page))
+
+LxVirt2Page()
+
+class LxSym2PFN(gdb.Command):
+    """symbol address to PFN"""
+
+    def __init__(self):
+        super(LxSym2PFN, self).__init__("lx-sym_to_pfn", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        sym_addr = int(argv[0], 16)
+        pfn = page_ops().ops.sym_to_pfn(sym_addr)
+        gdb.write("sym_to_pfn(0x%x) = %d\n" % (sym_addr, pfn))
+
+LxSym2PFN()
+
+class LxPFN2Kaddr(gdb.Command):
+    """PFN to kernel address"""
+
+    def __init__(self):
+        super(LxPFN2Kaddr, self).__init__("lx-pfn_to_kaddr", gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        argv = gdb.string_to_argv(arg)
+        pfn = int(argv[0])
+        kaddr = page_ops().ops.pfn_to_kaddr(pfn)
+        gdb.write("pfn_to_kaddr(%d) = 0x%x\n" % (pfn, kaddr))
 
-TranslateVM()
+LxPFN2Kaddr()
diff --git a/scripts/gdb/linux/pgtable.py b/scripts/gdb/linux/pgtable.py
new file mode 100644
index 000000000000..30d837f3dfae
--- /dev/null
+++ b/scripts/gdb/linux/pgtable.py
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# gdb helper commands and functions for Linux kernel debugging
+#
+#  routines to introspect page table
+#
+# Authors:
+#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
+#
+
+import gdb
+
+from linux import utils
+
+PHYSICAL_ADDRESS_MASK = gdb.parse_and_eval('0xfffffffffffff')
+
+
+def page_mask(level=1):
+    # 4KB
+    if level == 1:
+        return gdb.parse_and_eval('(u64) ~0xfff')
+    # 2MB
+    elif level == 2:
+        return gdb.parse_and_eval('(u64) ~0x1fffff')
+    # 1GB
+    elif level == 3:
+        return gdb.parse_and_eval('(u64) ~0x3fffffff')
+    else:
+        raise Exception(f'Unknown page level: {level}')
+
+
+#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
+POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
+def _page_offset_base():
+    pob_symbol = gdb.lookup_global_symbol('page_offset_base')
+    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
+    return gdb.parse_and_eval(pob)
+
+
+def is_bit_defined_tupled(data, offset):
+    return offset, bool(data >> offset & 1)
+
+def content_tupled(data, bit_start, bit_end):
+    return (bit_start, bit_end), data >> bit_start & ((1 << (1 + bit_end - bit_start)) - 1)
+
+def entry_va(level, phys_addr, translating_va):
+        def start_bit(level):
+            if level == 5:
+                return 48
+            elif level == 4:
+                return 39
+            elif level == 3:
+                return 30
+            elif level == 2:
+                return 21
+            elif level == 1:
+                return 12
+            else:
+                raise Exception(f'Unknown level {level}')
+
+        entry_offset =  ((translating_va >> start_bit(level)) & 511) * 8
+        entry_va = _page_offset_base() + phys_addr + entry_offset
+        return entry_va
+
+class Cr3():
+    def __init__(self, cr3, page_levels):
+        self.cr3 = cr3
+        self.page_levels = page_levels
+        self.page_level_write_through = is_bit_defined_tupled(cr3, 3)
+        self.page_level_cache_disabled = is_bit_defined_tupled(cr3, 4)
+        self.next_entry_physical_address = cr3 & PHYSICAL_ADDRESS_MASK & page_mask()
+
+    def next_entry(self, va):
+        next_level = self.page_levels
+        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
+
+    def mk_string(self):
+            return f"""\
+cr3:
+    {'cr3 binary data': <30} {hex(self.cr3)}
+    {'next entry physical address': <30} {hex(self.next_entry_physical_address)}
+    ---
+    {'bit' : <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
+    {'bit' : <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
+"""
+
+
+class PageHierarchyEntry():
+    def __init__(self, address, level):
+        data = int.from_bytes(
+            memoryview(gdb.selected_inferior().read_memory(address, 8)),
+            "little"
+        )
+        if level == 1:
+            self.is_page = True
+            self.entry_present = is_bit_defined_tupled(data, 0)
+            self.read_write = is_bit_defined_tupled(data, 1)
+            self.user_access_allowed = is_bit_defined_tupled(data, 2)
+            self.page_level_write_through = is_bit_defined_tupled(data, 3)
+            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
+            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
+            self.dirty = is_bit_defined_tupled(data, 6)
+            self.pat = is_bit_defined_tupled(data, 7)
+            self.global_translation = is_bit_defined_tupled(data, 8)
+            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level)
+            self.next_entry_physical_address = None
+            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
+            self.protection_key = content_tupled(data, 59, 62)
+            self.executed_disable = is_bit_defined_tupled(data, 63)
+        else:
+            page_size = is_bit_defined_tupled(data, 7)
+            page_size_bit = page_size[1]
+            self.is_page = page_size_bit
+            self.entry_present = is_bit_defined_tupled(data, 0)
+            self.read_write = is_bit_defined_tupled(data, 1)
+            self.user_access_allowed = is_bit_defined_tupled(data, 2)
+            self.page_level_write_through = is_bit_defined_tupled(data, 3)
+            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
+            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
+            self.page_size = page_size
+            self.dirty = is_bit_defined_tupled(
+                data, 6) if page_size_bit else None
+            self.global_translation = is_bit_defined_tupled(
+                data, 8) if page_size_bit else None
+            self.pat = is_bit_defined_tupled(
+                data, 12) if page_size_bit else None
+            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level) if page_size_bit else None
+            self.next_entry_physical_address = None if page_size_bit else data & PHYSICAL_ADDRESS_MASK & page_mask()
+            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
+            self.protection_key = content_tupled(data, 59, 62) if page_size_bit else None
+            self.executed_disable = is_bit_defined_tupled(data, 63)
+        self.address = address
+        self.page_entry_binary_data = data
+        self.page_hierarchy_level = level
+
+    def next_entry(self, va):
+        if self.is_page or not self.entry_present[1]:
+            return None
+
+        next_level = self.page_hierarchy_level - 1
+        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
+
+
+    def mk_string(self):
+        if not self.entry_present[1]:
+            return f"""\
+level {self.page_hierarchy_level}:
+    {'entry address': <30} {hex(self.address)}
+    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
+    ---
+    PAGE ENTRY IS NOT PRESENT!
+"""
+        elif self.is_page:
+            def page_size_line(ps_bit, ps, level):
+                return "" if level == 1 else f"{'bit': <3} {ps_bit: <5} {'page size': <30} {ps}"
+
+            return f"""\
+level {self.page_hierarchy_level}:
+    {'entry address': <30} {hex(self.address)}
+    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
+    {'page size': <30} {'1GB' if self.page_hierarchy_level == 3 else '2MB' if self.page_hierarchy_level == 2 else '4KB' if self.page_hierarchy_level == 1 else 'Unknown page size for level:' + self.page_hierarchy_level}
+    {'page physical address': <30} {hex(self.page_physical_address)}
+    ---
+    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
+    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
+    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
+    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
+    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
+    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
+    {"" if self.page_hierarchy_level == 1 else f"{'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}"}
+    {'bit': <4} {self.dirty[0]: <10} {'page dirty': <30} {self.dirty[1]}
+    {'bit': <4} {self.global_translation[0]: <10} {'global translation': <30} {self.global_translation[1]}
+    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
+    {'bit': <4} {self.pat[0]: <10} {'pat': <30} {self.pat[1]}
+    {'bits': <4} {str(self.protection_key[0]): <10} {'protection key': <30} {self.protection_key[1]}
+    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
+"""
+        else:
+            return f"""\
+level {self.page_hierarchy_level}:
+    {'entry address': <30} {hex(self.address)}
+    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
+    {'next entry physical address': <30} {hex(self.next_entry_physical_address)}
+    ---
+    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
+    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
+    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
+    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
+    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
+    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
+    {'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}
+    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
+    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
+"""
+
+
+class TranslateVM(gdb.Command):
+    """Prints the entire paging structure used to translate a given virtual address.
+
+Having an address space of the currently executed process translates the virtual address
+and prints detailed information of all paging structure levels used for the transaltion.
+Currently supported arch: x86"""
+
+    def __init__(self):
+        super(TranslateVM, self).__init__('translate-vm', gdb.COMMAND_USER)
+
+    def invoke(self, arg, from_tty):
+        if utils.is_target_arch("x86"):
+            vm_address = gdb.parse_and_eval(f'{arg}')
+            cr3_data = gdb.parse_and_eval('$cr3')
+            cr4 = gdb.parse_and_eval('$cr4')
+            page_levels = 5 if cr4 & (1 << 12) else 4
+            page_entry = Cr3(cr3_data, page_levels)
+            while page_entry:
+                gdb.write(page_entry.mk_string())
+                page_entry = page_entry.next_entry(vm_address)
+        else:
+            gdb.GdbError("Virtual address translation is not"
+                         "supported for this arch")
+
+
+TranslateVM()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 2d32308c3f7a..fd24574bcec9 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -41,6 +41,7 @@ else:
     import linux.genpd
     import linux.device
     import linux.vfs
-    import linux.mm
+    import linux.pgtable
     import linux.radixtree
     import linux.interrupts
+    import linux.mm
-- 
2.18.0

