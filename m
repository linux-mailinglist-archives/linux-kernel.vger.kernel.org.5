Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC42773D59
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjHHQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjHHQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:14:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3983CC;
        Tue,  8 Aug 2023 08:48:01 -0700 (PDT)
X-UUID: df44968235c511eeb20a276fd37b9834-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hGt7NeNlML1MGMWhcOV6ROE/8hYT1LCj/C58WEanJig=;
        b=UZ0fwCL3Iktwnfr82e/B9uUO+D5oysKiU41pabgBiutGFgNf2EmQ9+oPahLoLuHK/RRAcgW7dbBchZjQIpws2LGR+3LR9ZVGBrGLI0dlVUQ1CNIVvaLy7q1JrKphyTkWXaatelcvo2YSXfFCE2ZKhuZY+6So5IL/gCHfYSVBuFk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7fafc22f-d69e-45df-8b80-e2b30dc585fc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:7fafc22f-d69e-45df-8b80-e2b30dc585fc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:a8e7cfd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230808163049VCAOXA3Y,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: df44968235c511eeb20a276fd37b9834-20230808
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1422125080; Tue, 08 Aug 2023 16:30:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:45 +0800
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
Subject: [PATCH v2 7/8] scripts/gdb/slab: Add slab support
Date:   Tue, 8 Aug 2023 16:30:17 +0800
Message-ID: <20230808083020.22254-8-Kuan-Ying.Lee@mediatek.com>
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

Add 'lx-slabinfo' and 'lx-slabtrace' support.

This GDB scripts print slabinfo and slabtrace for user
to analyze slab memory usage.

Example output like below:
(gdb) lx-slabinfo
     Pointer       |         name         | active_objs  |   num_objs   | objsize  | objperslab  | pagesperslab
------------------ | -------------------- | ------------ | ------------ | -------- | ----------- | -------------
0xffff0000c59df480 | p9_req_t             | 0            | 0            | 280      | 29          | 2
0xffff0000c59df280 | isp1760_qh           | 0            | 0            | 160      | 25          | 1
0xffff0000c59df080 | isp1760_qtd          | 0            | 0            | 184      | 22          | 1
0xffff0000c59dee80 | isp1760_urb_listite  | 0            | 0            | 136      | 30          | 1
0xffff0000c59dec80 | asd_sas_event        | 0            | 0            | 256      | 32          | 2
0xffff0000c59dea80 | sas_task             | 0            | 0            | 448      | 36          | 4
0xffff0000c59de880 | bio-120              | 18           | 21           | 384      | 21          | 2
0xffff0000c59de680 | io_kiocb             | 0            | 0            | 448      | 36          | 4
0xffff0000c59de480 | bfq_io_cq            | 0            | 0            | 1504     | 21          | 8
0xffff0000c59de280 | bfq_queue            | 0            | 0            | 720      | 22          | 4
0xffff0000c59de080 | mqueue_inode_cache   | 1            | 28           | 1152     | 28          | 8
0xffff0000c59dde80 | v9fs_inode_cache     | 0            | 0            | 832      | 39          | 8
...

(gdb) lx-slabtrace --cache_name kmalloc-1k
63 <tty_register_device_attr+508> waste=16632/264 age=46856/46871/46888 pid=1 cpus=6,
   0xffff800008720240 <__kmem_cache_alloc_node+236>:    mov     x22, x0
   0xffff80000862a4fc <kmalloc_trace+64>:       mov     x21, x0
   0xffff8000095d086c <tty_register_device_attr+508>:   mov     x19, x0
   0xffff8000095d0f98 <tty_register_driver+704>:        cmn     x0, #0x1, lsl #12
   0xffff80000c2677e8 <vty_init+620>:   Cannot access memory at address 0xffff80000c2677e8
   0xffff80000c265a10 <tty_init+276>:   Cannot access memory at address 0xffff80000c265a10
   0xffff80000c26d3c4 <chr_dev_init+204>:       Cannot access memory at address 0xffff80000c26d3c4
   0xffff8000080161d4 <do_one_initcall+176>:    mov     w21, w0
   0xffff80000c1c1b58 <kernel_init_freeable+956>:       Cannot access memory at address 0xffff80000c1c1b58
   0xffff80000acf1334 <kernel_init+36>: bl      0xffff8000081ac040 <async_synchronize_full>
   0xffff800008018d00 <ret_from_fork+16>:       mrs     x28, sp_el0

(gdb) lx-slabtrace --cache_name kmalloc-1k --free
428 <not-available> age=4294958600 pid=0 cpus=0,

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/constants.py.in |  13 ++
 scripts/gdb/linux/slab.py         | 326 ++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py        |   1 +
 3 files changed, 340 insertions(+)
 create mode 100644 scripts/gdb/linux/slab.py

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 52f61d65f430..03fa6d2cfe01 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -20,6 +20,7 @@
 #include <linux/of_fdt.h>
 #include <linux/page_ext.h>
 #include <linux/radix-tree.h>
+#include <linux/slab.h>
 #include <linux/threads.h>
 
 /* We need to stringify expanded macros so that they can be parsed */
@@ -95,6 +96,16 @@ if IS_BUILTIN(CONFIG_PAGE_OWNER):
     LX_GDBPARSED(PAGE_EXT_OWNER)
     LX_GDBPARSED(PAGE_EXT_OWNER_ALLOCATED)
 
+/* linux/slab.h */
+LX_GDBPARSED(SLAB_RED_ZONE)
+LX_GDBPARSED(SLAB_POISON)
+LX_GDBPARSED(SLAB_KMALLOC)
+LX_GDBPARSED(SLAB_HWCACHE_ALIGN)
+LX_GDBPARSED(SLAB_CACHE_DMA)
+LX_GDBPARSED(SLAB_CACHE_DMA32)
+LX_GDBPARSED(SLAB_STORE_USER)
+LX_GDBPARSED(SLAB_PANIC)
+
 /* Kernel Configs */
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS)
 LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
@@ -136,3 +147,5 @@ if IS_BUILTIN(CONFIG_NUMA):
 LX_CONFIG(CONFIG_DEBUG_VIRTUAL)
 LX_CONFIG(CONFIG_STACKDEPOT)
 LX_CONFIG(CONFIG_PAGE_OWNER)
+LX_CONFIG(CONFIG_SLUB_DEBUG)
+LX_CONFIG(CONFIG_SLAB_FREELIST_HARDENED)
diff --git a/scripts/gdb/linux/slab.py b/scripts/gdb/linux/slab.py
new file mode 100644
index 000000000000..f012ba38c7d9
--- /dev/null
+++ b/scripts/gdb/linux/slab.py
@@ -0,0 +1,326 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2023 MediaTek Inc.
+#
+# Authors:
+#  Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
+#
+
+import gdb
+import re
+import traceback
+from linux import lists, utils, stackdepot, constants, mm
+
+SLAB_RED_ZONE       = constants.LX_SLAB_RED_ZONE
+SLAB_POISON         = constants.LX_SLAB_POISON
+SLAB_KMALLOC        = constants.LX_SLAB_KMALLOC
+SLAB_HWCACHE_ALIGN  = constants.LX_SLAB_HWCACHE_ALIGN
+SLAB_CACHE_DMA      = constants.LX_SLAB_CACHE_DMA
+SLAB_CACHE_DMA32    = constants.LX_SLAB_CACHE_DMA32
+SLAB_STORE_USER     = constants.LX_SLAB_STORE_USER
+SLAB_PANIC          = constants.LX_SLAB_PANIC
+
+OO_SHIFT = 16
+OO_MASK = (1 << OO_SHIFT) - 1
+
+if constants.LX_CONFIG_SLUB_DEBUG:
+    slab_type = utils.CachedType("struct slab")
+    slab_ptr_type = slab_type.get_type().pointer()
+    kmem_cache_type = utils.CachedType("struct kmem_cache")
+    kmem_cache_ptr_type = kmem_cache_type.get_type().pointer()
+    freeptr_t = utils.CachedType("freeptr_t")
+    freeptr_t_ptr = freeptr_t.get_type().pointer()
+
+    track_type = gdb.lookup_type('struct track')
+    track_alloc = int(gdb.parse_and_eval('TRACK_ALLOC'))
+    track_free = int(gdb.parse_and_eval('TRACK_FREE'))
+
+def slab_folio(slab):
+    return slab.cast(gdb.lookup_type("struct folio").pointer())
+
+def slab_address(slab):
+    p_ops = mm.page_ops().ops
+    folio = slab_folio(slab)
+    return p_ops.folio_address(folio)
+
+def for_each_object(cache, addr, slab_objects):
+    p = addr
+    if cache['flags'] & SLAB_RED_ZONE:
+        p += int(cache['red_left_pad'])
+    while p < addr + (slab_objects * cache['size']):
+        yield p
+        p = p + int(cache['size'])
+
+def get_info_end(cache):
+    if (cache['offset'] >= cache['inuse']):
+        return cache['inuse'] + gdb.lookup_type("void").pointer().sizeof
+    else:
+        return cache['inuse']
+
+def get_orig_size(cache, obj):
+    if cache['flags'] & SLAB_STORE_USER and cache['flags'] & SLAB_KMALLOC:
+        p = mm.page_ops().ops.kasan_reset_tag(obj)
+        p += get_info_end(cache)
+        p += gdb.lookup_type('struct track').sizeof * 2
+        p = p.cast(utils.get_uint_type().pointer())
+        return p.dereference()
+    else:
+        return cache['object_size']
+
+def get_track(cache, object_pointer, alloc):
+    p = object_pointer + get_info_end(cache)
+    p += (alloc * track_type.sizeof)
+    return p
+
+def oo_objects(x):
+    return int(x['x']) & OO_MASK
+
+def oo_order(x):
+    return int(x['x']) >> OO_SHIFT
+
+def reciprocal_divide(a, R):
+    t = (a * int(R['m'])) >> 32
+    return (t + ((a - t) >> int(R['sh1']))) >> int(R['sh2'])
+
+def __obj_to_index(cache, addr, obj):
+    return reciprocal_divide(int(mm.page_ops().ops.kasan_reset_tag(obj)) - addr, cache['reciprocal_size'])
+
+def swab64(x):
+    result = (((x & 0x00000000000000ff) << 56) |   \
+    ((x & 0x000000000000ff00) << 40) |   \
+    ((x & 0x0000000000ff0000) << 24) |   \
+    ((x & 0x00000000ff000000) <<  8) |   \
+    ((x & 0x000000ff00000000) >>  8) |   \
+    ((x & 0x0000ff0000000000) >> 24) |   \
+    ((x & 0x00ff000000000000) >> 40) |   \
+    ((x & 0xff00000000000000) >> 56))
+    return result
+
+def freelist_ptr_decode(cache, ptr, ptr_addr):
+    if constants.LX_CONFIG_SLAB_FREELIST_HARDENED:
+        return ptr['v'] ^ cache['random'] ^ swab64(int(ptr_addr))
+    else:
+        return ptr['v']
+
+def get_freepointer(cache, obj):
+    obj = mm.page_ops().ops.kasan_reset_tag(obj)
+    ptr_addr = obj + cache['offset']
+    p = ptr_addr.cast(freeptr_t_ptr).dereference()
+    return freelist_ptr_decode(cache, p, ptr_addr)
+
+def loc_exist(loc_track, addr, handle, waste):
+    for loc in loc_track:
+        if loc['addr'] == addr and loc['handle'] == handle and loc['waste'] == waste:
+            return loc
+    return None
+
+def add_location(loc_track, cache, track, orig_size):
+    jiffies = gdb.parse_and_eval("jiffies_64")
+    age = jiffies - track['when']
+    handle = 0
+    waste = cache['object_size'] - int(orig_size)
+    pid = int(track['pid'])
+    cpuid = int(track['cpu'])
+    addr = track['addr']
+    if constants.LX_CONFIG_STACKDEPOT:
+        handle = track['handle']
+
+    loc = loc_exist(loc_track, addr, handle, waste)
+    if loc:
+        loc['count'] += 1
+        if track['when']:
+            loc['sum_time'] += age
+            loc['min_time'] = min(loc['min_time'], age)
+            loc['max_time'] = max(loc['max_time'], age)
+            loc['min_pid'] = min(loc['min_pid'], pid)
+            loc['max_pid'] = max(loc['max_pid'], pid)
+            loc['cpus'].add(cpuid)
+    else:
+        loc_track.append({
+            'count' : 1,
+            'addr' : addr,
+            'sum_time' : age,
+            'min_time' : age,
+            'max_time' : age,
+            'min_pid' : pid,
+            'max_pid' : pid,
+            'handle' : handle,
+            'waste' : waste,
+            'cpus' : {cpuid}
+            }
+        )
+
+def slabtrace(alloc, cache_name):
+
+    def __fill_map(obj_map, cache, slab):
+        p = slab['freelist']
+        addr = slab_address(slab)
+        while p != gdb.Value(0):
+            index = __obj_to_index(cache, addr, p)
+            obj_map[index] = True # free objects
+            p = get_freepointer(cache, p)
+
+    # process every slab page on the slab_list (partial and full list)
+    def process_slab(loc_track, slab_list, alloc, cache):
+        for slab in lists.list_for_each_entry(slab_list, slab_ptr_type, "slab_list"):
+            obj_map[:] = [False] * oo_objects(cache['oo'])
+            __fill_map(obj_map, cache, slab)
+            addr = slab_address(slab)
+            for object_pointer in for_each_object(cache, addr, slab['objects']):
+                if obj_map[__obj_to_index(cache, addr, object_pointer)] == True:
+                    continue
+                p = get_track(cache, object_pointer, alloc)
+                track = gdb.Value(p).cast(track_type.pointer())
+                if alloc == track_alloc:
+                    size = get_orig_size(cache, object_pointer)
+                else:
+                    size = cache['object_size']
+                add_location(loc_track, cache, track, size)
+                continue
+
+    slab_caches = gdb.parse_and_eval("slab_caches")
+    if mm.page_ops().ops.MAX_NUMNODES > 1:
+        nr_node_ids = int(gdb.parse_and_eval("nr_node_ids"))
+    else:
+        nr_node_ids = 1
+
+    target_cache = None
+    loc_track = []
+
+    for cache in lists.list_for_each_entry(slab_caches, kmem_cache_ptr_type, 'list'):
+        if cache['name'].string() == cache_name:
+            target_cache = cache
+            break
+
+    obj_map = [False] * oo_objects(target_cache['oo'])
+
+    if target_cache['flags'] & SLAB_STORE_USER:
+        for i in range(0, nr_node_ids):
+            cache_node = target_cache['node'][i]
+            if cache_node['nr_slabs']['counter'] == 0:
+                continue
+            process_slab(loc_track, cache_node['partial'], alloc, target_cache)
+            process_slab(loc_track, cache_node['full'], alloc, target_cache)
+    else:
+        raise gdb.GdbError("SLAB_STORE_USER is not set in %s" % target_cache['name'].string())
+
+    for loc in sorted(loc_track, key=lambda x:x['count'], reverse=True):
+        if loc['addr']:
+            addr = loc['addr'].cast(utils.get_ulong_type().pointer())
+            gdb.write("%d %s" % (loc['count'], str(addr).split(' ')[-1]))
+        else:
+            gdb.write("%d <not-available>" % loc['count'])
+
+        if loc['waste']:
+            gdb.write(" waste=%d/%d" % (loc['count'] * loc['waste'], loc['waste']))
+
+        if loc['sum_time'] != loc['min_time']:
+            gdb.write(" age=%d/%d/%d" % (loc['min_time'], loc['sum_time']/loc['count'], loc['max_time']))
+        else:
+            gdb.write(" age=%d" % loc['min_time'])
+
+        if loc['min_pid'] != loc['max_pid']:
+            gdb.write(" pid=%d-%d" % (loc['min_pid'], loc['max_pid']))
+        else:
+            gdb.write(" pid=%d" % loc['min_pid'])
+
+        if constants.LX_NR_CPUS > 1:
+            nr_cpu = gdb.parse_and_eval('__num_online_cpus')['counter']
+            if nr_cpu > 1:
+                gdb.write(" cpus=")
+                for i in loc['cpus']:
+                    gdb.write("%d," % i)
+        gdb.write("\n")
+        if constants.LX_CONFIG_STACKDEPOT:
+            if loc['handle']:
+                stackdepot.stack_depot_print(loc['handle'])
+        gdb.write("\n")
+
+def help():
+    t = """Usage: lx-slabtrace --cache_name [cache_name] [Options]
+    Options:
+        --alloc
+            print information of allocation trace of the allocated objects
+        --free
+            print information of freeing trace of the allocated objects
+    Example:
+        lx-slabtrace --cache_name kmalloc-1k --alloc
+        lx-slabtrace --cache_name kmalloc-1k --free\n"""
+    gdb.write("Unrecognized command\n")
+    raise gdb.GdbError(t)
+
+class LxSlabTrace(gdb.Command):
+    """Show specific cache slabtrace"""
+
+    def __init__(self):
+        super(LxSlabTrace, self).__init__("lx-slabtrace", gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        if not constants.LX_CONFIG_SLUB_DEBUG:
+            raise gdb.GdbError("CONFIG_SLUB_DEBUG is not enabled")
+
+        argv = gdb.string_to_argv(arg)
+        alloc = track_alloc # default show alloc_traces
+
+        if len(argv) == 3:
+            if argv[2] == '--alloc':
+                alloc = track_alloc
+            elif argv[2] == '--free':
+                alloc = track_free
+            else:
+                help()
+        if len(argv) >= 2 and argv[0] == '--cache_name':
+            slabtrace(alloc, argv[1])
+        else:
+            help()
+LxSlabTrace()
+
+def slabinfo():
+    nr_node_ids = None
+
+    if not constants.LX_CONFIG_SLUB_DEBUG:
+        raise gdb.GdbError("CONFIG_SLUB_DEBUG is not enabled")
+
+    def count_free(slab):
+        total_free = 0
+        for slab in lists.list_for_each_entry(slab, slab_ptr_type, 'slab_list'):
+            total_free += int(slab['objects'] - slab['inuse'])
+        return total_free
+
+    gdb.write("{:^18} | {:^20} | {:^12} | {:^12} | {:^8} | {:^11} | {:^13}\n".format('Pointer', 'name', 'active_objs', 'num_objs', 'objsize', 'objperslab', 'pagesperslab'))
+    gdb.write("{:-^18} | {:-^20} | {:-^12} | {:-^12} | {:-^8} | {:-^11} | {:-^13}\n".format('', '', '', '', '', '', ''))
+
+    slab_caches = gdb.parse_and_eval("slab_caches")
+    if mm.page_ops().ops.MAX_NUMNODES > 1:
+        nr_node_ids = int(gdb.parse_and_eval("nr_node_ids"))
+    else:
+        nr_node_ids = 1
+
+    for cache in lists.list_for_each_entry(slab_caches, kmem_cache_ptr_type, 'list'):
+        nr_objs = 0
+        nr_free = 0
+        nr_slabs = 0
+        for i in range(0, nr_node_ids):
+            cache_node = cache['node'][i]
+            try:
+                nr_slabs += cache_node['nr_slabs']['counter']
+                nr_objs = int(cache_node['total_objects']['counter'])
+                nr_free = count_free(cache_node['partial'])
+            except:
+                raise gdb.GdbError(traceback.format_exc())
+        active_objs = nr_objs - nr_free
+        num_objs = nr_objs
+        active_slabs = nr_slabs
+        objects_per_slab = oo_objects(cache['oo'])
+        cache_order = oo_order(cache['oo'])
+        gdb.write("{:18s} | {:20.19s} | {:12} | {:12} | {:8} | {:11} | {:13}\n".format(hex(cache), cache['name'].string(), str(active_objs), str(num_objs), str(cache['size']), str(objects_per_slab), str(1 << cache_order)))
+
+class LxSlabInfo(gdb.Command):
+    """Show slabinfo"""
+
+    def __init__(self):
+        super(LxSlabInfo, self).__init__("lx-slabinfo", gdb.COMMAND_DATA)
+
+    def invoke(self, arg, from_tty):
+        slabinfo()
+LxSlabInfo()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 89465f0de548..2526364f31fd 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -47,3 +47,4 @@ else:
     import linux.mm
     import linux.stackdepot
     import linux.page_owner
+    import linux.slab
-- 
2.18.0

