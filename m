Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46547EBAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjKOAtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 19:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKOAtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 19:49:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30DFC7;
        Tue, 14 Nov 2023 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700009380; x=1731545380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wfhA46q41WEOL7PbjWmN9cpFEBaXc9ktlraGhXgmPlo=;
  b=VnvdovSIuJQCR7FVWzDsW1iXf8FRtjzBrd28Mn/0YDg0aDIb6ASZldxQ
   9msepRCC7oqZCCN2PA4LIu57fwcVhLTFITHgXXSdg7Fth/VbyQSFxJGOO
   FoOTBwJ5WrVmRg6WkolO1K5ZXZojalflLuAuSqx6AO52x8otsGotHm7Pn
   nFisPXYTbRM+NSH2tcFzrnXcTwrwcA3D7R4gkLlpcVzV4dm5mbMqMBbJB
   vX4i6rWzQOWgMT7ySfC/Wsz/XZ76KTNfBiseYlRgA7tyH1jzjKuWyUMBI
   T4LptgHxmxeb/ZuZjcuEab1O5e3gYI702+3dwYMSkSUXGSZBKTNFTBeLK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="381175886"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="381175886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 16:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="6243376"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 16:49:39 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] kbuild: Add inline-account tool
Date:   Tue, 14 Nov 2023 16:49:32 -0800
Message-ID: <20231115004932.650702-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common cause of binary code bloat is excessive inlining. Traditional
tools (like nm --size-sort -t d) don't address that directly because
they only see the final functions, but don't know about inlines.

This patch adds inline-account that makes it easy to track that down
by accounting code bytes to all functions visible in the debug information,
as well as code lines.

Here are some examples:

Show all inlines that increase code size by >1K in the core scheduler:

$ inline-account.py --min-bytes=1000 kernel/sched/core.o
Total code bytes seen 75690

Code bytes by functions:
Function                                           Total          Avg   Num
rq_pin_lock                                        1401  (0.02%)  35    39
__sched_setscheduler                               1277  (0.02%)  41    31
perf_fetch_caller_regs                             1012  (0.01%)  17    58

Code bytes by nearby source line blocks:
prefix /home/ak/lsrc/git/linux/
Line                                               Total
kernel/sched/sched.h:1610                          1387  (0.02%)
include/trace/events/sched.h:16                    1172  (0.02%)
include/trace/events/sched.h:222                   1058  (0.01%)

This indicates that rq_pin_lock should likely be not inline,
and perhaps perf_fetch_caller_regs not either.

Note that not all large inlines are necessary bloat. If there is only
a single call site it isn't bloat (the tool currently cannot distinguish
that case). For example it is commonly seen with syscall definitions
that use single large inlines with only a single caller. In the example
above I think it's the case with __sched_setscheduler.

Show the >1K inlines in lib/maple_tree.o, which for some reason
comes in at a incredible 73k of code size:

$ inline-account.py --min-bytes 1000 lib/maple_tree.o
Total code bytes seen 73578

Code bytes by functions:
Function                                           Total          Avg   Num
mas_mab_cp                                         5537  (0.08%)  37    149
mas_pop_node                                       3798  (0.05%)  28    131
ma_slots                                           2368  (0.03%)  14    162
ma_pivots                                          2353  (0.03%)  10    222
mas_destroy_rebalance                              2056  (0.03%)  42    48
mas_start                                          1661  (0.02%)  13    125
mas_set_parent                                     1454  (0.02%)  20    72
mas_set_alloc_req                                  1410  (0.02%)  17    80
mte_node_type                                      1360  (0.02%)  5     228
mas_data_end                                       1189  (0.02%)  16    74
mte_to_node                                        1085  (0.01%)  3     276
mas_split                                          1053  (0.01%)  65    16
mas_topiary_replace                                1033  (0.01%)  38    27
mas_root_expand                                    1001  (0.01%)  35    28

Code bytes by nearby source line blocks:
prefix /home/ak/lsrc/git/linux/
Line                                               Total
lib/maple_tree.c:210                               1360  (0.02%)
include/trace/events/maple_tree.h:80               1283  (0.02%)
lib/maple_tree.c:649                               1193  (0.02%)
lib/maple_tree.c:288                               1097  (0.01%)

It's clear there is a lot of potential for shrinking here, as a quick
experiment shows:

$ size lib/maple_tree.o
   text    data     bss     dec     hex filename
  72257    5312       8   77577   12f09 lib/maple_tree.o
$ sed -i -e s/__always_inline// -e 's/ inline/ /' lib/maple_tree.c
$ make -s lib/maple_tree.o
$ size lib/maple_tree.o
   text    data     bss     dec     hex filename
  47774    4720       8   52502    cd16 lib/maple_tree.o

34% reduction just from trusting the compiler. Most of it seems
to come from abuse of __always_inline. I suppose a large scale
tree purge of that would give some decent binary size results.

$ inline-account.py --show=5 kernel/workqueue.o
Total code bytes seen 40403

Code bytes by functions:
Function                                           Total          Avg   Num
bitmap_copy                                        1477  (0.04%)  26    56
show_pwq                                           912   (0.02%)  76    12
workqueue_init_early                               846   (0.02%)  29    29
__flush_workqueue                                  753   (0.02%)  31    24
alloc_and_link_pwqs                                558   (0.01%)  69    8

Code bytes by nearby source line blocks:
prefix /home/ak/lsrc/git/linux/
Line                                               Total
include/linux/bitmap.h:268                         1336  (0.03%)
include/trace/events/workqueue.h:23                1038  (0.03%)
include/trace/events/workqueue.h:108               732   (0.02%)
include/trace/events/workqueue.h:59                694   (0.02%)
include/trace/events/workqueue.h:82                670   (0.02%)
$

This is an interesting case because bitmap_copy is just

static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
                        unsigned int nbits)
{
        unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);

        if (small_const_nbits(nbits))
                *dst = *src;
        else
                memcpy(dst, src, len);
}

memcpy (which is a macro) must sometimes generate a lot of
code. The small_const_nbits case definitely should be inlined though
because it's likely even smaller than a call. Would need
more investigation.

The other large inlines are trace points. Perhaps there is something
there that could be done to shrink that a bit.

Finally we can do a global accounting (currently with multiple runs):

(ignore the percentage numbers since they are just for the local file)

$ find -name '*.o' | xargs -n1 inline-account.py > a
$ sort -n -r -k 2 a | head -30
ZSTD_count                                         81799 (0.19%)  32    2514
ZSTD_count                                         52233 (0.25%)  33    1544
kmalloc                                            43324 (0.00%)  12    3334
pv_queued_spin_unlock                              42027 (0.00%)  9     4580
constant_test_bit                                  41667 (0.00%)  5     8005
arch/x86/include/asm/paravirt.h:591                41044 (0.00%)
arch/x86/include/asm/bitops.h:207                  40153 (0.00%)
__refcount_add                                     37968 (0.00%)  24    1532
page_fixed_fake_head                               36368 (0.00%)  19    1832
include/linux/slab.h:599                           35654 (0.00%)
arch/x86/include/asm/jump_label.h:27               35156 (0.00%)
spin_lock                                          32170 (0.00%)  10    3007
__refcount_sub_and_test                            32068 (0.00%)  17    1842
include/linux/spinlock.h:351                       31102 (0.00%)
arch_static_branch                                 30874 (0.00%)  4     7022
get_current                                        30714 (0.00%)  9     3351
arch/x86/include/asm/current.h:41                  29912 (0.00%)
trace_trigger_soft_disabled                        29814 (0.00%)  21    1368
perf_fetch_caller_regs                             27504 (0.00%)  16    1634
ZSTD_storeSeq                                      26060 (0.06%)  30    862
hid_map_usage                                      25582 (0.00%)  88    288
ZSTD_compressBlock_lazy_generic                    24953 (0.12%)  46    535
ZSTD_compressBlock_lazy_generic                    24953 (0.06%)  46    535
paravirt_ret0                                      24152 (0.00%)  24152 1
spin_unlock_irqrestore                             23253 (0.00%)  10    2281
include/linux/spinlock.h:406                       22526 (0.00%)
ZSTD_RowFindBestMatch                              21527 (0.10%)  23    922
ZSTD_RowFindBestMatch                              21527 (0.05%)  23    922
__list_add                                         21209 (0.00%)  11    1851
include/linux/refcount.h:283                       20642 (0.00%)

- So my kernel is spending around ~30K just for getting task_structs in
current.
- I'm sure ZSTD is great, but is it >200K in duplicated code worth great?
- page_fixed_fake_head probably shouldn't be inlined
- There might be some potential in out lining reference counts
(although that one might be truly performance critical)
- There's maybe some potential in shrinking trace point bloat?

... and more similar insights.

Also of course there can be critical inlines that really need
to be inline in many sites for best performance. But that's rarely the case
if they are big because it's unlikely the small call overhead is making
a significant difference for a large chunk of code.

In any case the tool is useful, so I think it deserves its place
in scripts/

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Address review comments. Change balancing to be address based.
Add option to set objdump binary.
---
 scripts/inline-account.py | 201 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100755 scripts/inline-account.py

diff --git a/scripts/inline-account.py b/scripts/inline-account.py
new file mode 100755
index 000000000000..c32cb0547172
--- /dev/null
+++ b/scripts/inline-account.py
@@ -0,0 +1,201 @@
+#!/usr/bin/env python3
+# account code bytes per source code / functions from objdump -Sl output
+# useful to find inline bloat
+#
+# SPDX-License-Identifier: GPL-2.0-only
+# Author: Andi Kleen
+
+import os
+import sys
+import re
+import argparse
+import bisect
+import multiprocessing
+from collections import Counter
+from functools import reduce, partial
+
+def get_args():
+    p = argparse.ArgumentParser(
+            description="""
+Account code bytes per source code / functions from objdump.
+Useful to find inline bloat.
+
+The line numbers are the beginning of a block, so the actual code can be later.
+Line numbers can be a also little off due to objdump bugs
+also some misaccounting can happen due to inexact gcc debug information.
+The number output for functions may account a single large function multiple
+times.  program/object files need to be built with -g.
+
+This is somewhat slow due to objdump -S being slow. It helps to have
+plenty of cores.""")
+    p.add_argument('--min-bytes', type=int, help='minimum bytes to report', default=100)
+    p.add_argument('--threads', '-t', type=int, default=multiprocessing.cpu_count(),
+                   help='Number of objdump processes to run')
+    p.add_argument('--verbose', '-v', action='store_true', help="Print more")
+    p.add_argument('--show', type=int, help='Number of results to show')
+    p.add_argument('--objdump', default="objdump", help="Set objdump binary to run")
+    p.add_argument('file', help='object file/program as input')
+    return p.parse_args()
+
+def get_syms(fn):
+    syms = []
+    pc = None
+    with os.popen("nm -n --print-size " + fn) as f:
+        for l in f:
+            n = l.split()
+            if len(n) > 2 and n[2].upper() == "T":
+                pc = int(n[0], 16)
+                syms.append(pc)
+                ln = int(n[1], 16)
+    if not pc:
+        sys.exit(fn + " has no symbols")
+    syms.append(pc + ln)
+    return syms
+
+class Account:
+    def __init__(self):
+        self.funcbytes = Counter()
+        self.linebytes = Counter()
+        self.funccount = Counter()
+        self.nolinebytes = 0
+        self.nofuncbytes = 0
+        self.total = 0
+
+    def add(self, b):
+        self.funcbytes += b.funcbytes
+        self.linebytes += b.linebytes
+        self.funccount += b.funccount
+        self.nolinebytes += b.nolinebytes
+        self.nofuncbytes += b.nofuncbytes
+        self.total += b.total
+        return self
+
+# dont add sys.exit here, causes deadlocks
+def account_range(args, r):
+    a = Account()
+    line = None
+    func = None
+    codefunc = None
+
+    cmd = ("%s -Sl %s --start-address=%#x --stop-address=%#x" %
+                (args.objdump, args.file, r[0], r[1]))
+    if args.verbose:
+        print(cmd)
+    with os.popen(cmd) as f:
+        for l in f:
+            #      250:       e8 00 00 00 00          callq  255 <proc_skip_spaces+0x5>
+            m = re.match(r'\s*([0-9a-fA-F]+):\s+(.*)', l)
+            if m:
+                bytes = len(re.findall(r'[0-9a-f][0-9a-f] ', m.group(2)))
+                if not func:
+                    a.nofuncbytes += bytes
+                    continue
+                if not line:
+                    a.nolinebytes += bytes
+                    continue
+                a.total += bytes
+                a.funcbytes[func] += bytes
+                a.linebytes[(file, line)] += bytes
+                codefunc = func
+                continue
+
+            # sysctl_init():
+            m = re.match(r'([a-zA-Z_][a-zA-Z0-9_]*)\(\):$', l)
+            if m:
+                if codefunc and m.group(1) != codefunc:
+                    a.funccount[codefunc] += 1
+                    codefunc = None
+                func = m.group(1)
+                continue
+
+            # /sysctl.c:1666
+            m = re.match(r'^([^:]+):(\d+)$', l)
+            if m:
+                file, line = m.group(1), int(m.group(2))
+                continue
+
+    if codefunc:
+        a.funccount[codefunc] += 1
+    return a
+
+def get_boundaries(syms, sym_sizes, chunk):
+    run = 0
+    boundaries = [syms[0]]
+    for i, x in enumerate(sym_sizes):
+        run += x
+        if run >= chunk:
+            boundaries.append(syms[i])
+            run = 0
+    boundaries.append(syms[-1])
+    return boundaries
+
+
+def process(args):
+    # objdump -S is slow, so we parallelize
+
+    # split symbol table into chunks for parallelization
+    # we split on functions boundaries to avoid mis-accounting
+    syms = get_syms(args.file)
+    if len(syms) < 2:
+        print("not enough symbols")
+        return
+    sym_sizes = [syms[x + 1] - syms[x] for x, _ in enumerate(syms[:-1])]
+    sym_total = sum(sym_sizes)
+    chunk = max(int(sym_total / args.threads), 1)
+    boundaries = get_boundaries(syms, sym_sizes, chunk)
+    ranges = [(boundaries[x], boundaries[x+1]) for x in range(0, len(boundaries) - 1)]
+    assert ranges[0][0] == syms[0]
+    assert ranges[-1][1] == syms[-1]
+
+    # map-reduce
+    account_func = partial(account_range, args)
+    if args.threads == 1:
+        al = list(map(account_func, ranges))
+    else:
+        al = multiprocessing.Pool(args.threads).map(account_func, ranges)
+    a = reduce(lambda a, b: a.add(b), al)
+
+    print("Total code bytes seen", a.total)
+    if args.verbose:
+        print("Bytes with no function %d (%.2f%%)" % (a.nofuncbytes, 100.0*(float(a.nofuncbytes)/a.total)))
+        print("Bytes with no lines %d (%.2f%%)" % (a.nolinebytes, 100.0*(float(a.nolinebytes)/a.total)))
+
+    def sort_map(m):
+        return sorted(list(m.keys()), key=lambda x: m[x], reverse=True)
+
+    print("\nCode bytes by functions:")
+    print("%-50s %-5s  %-5s   %-5s %-5s" % ("Function", "Total", "", "Avg", "Num"))
+    for i, j in enumerate(sort_map(a.funcbytes)):
+        if a.funcbytes[j] < args.min_bytes:
+            break
+        if args.show and i >= args.show:
+            break
+        print("%-50s %-5d (%.2f%%)  %-5d %-5d" % (
+                j,
+                a.funcbytes[j],
+                a.funcbytes[j] / float(a.total),
+                a.funcbytes[j] / a.funccount[j],
+                a.funccount[j]))
+
+    for j in list(a.linebytes.keys()):
+        if a.linebytes[j] < args.min_bytes:
+            del a.linebytes[j]
+
+    prefix = os.path.commonprefix([x[0] for x in list(a.linebytes.keys())])
+
+    print("\nCode bytes by nearby source line blocks:")
+    print("prefix", prefix)
+
+    print("%-50s %-5s" % ("Line", "Total"))
+    for i, j in enumerate(sort_map(a.linebytes)):
+        if args.show and i >= args.show:
+            break
+        print("%-50s %-5d (%.2f%%)" % (
+                "%s:%d" % (j[0][len(prefix):], j[1]),
+                a.linebytes[j],
+                a.linebytes[j] / float(a.total)))
+    if len(a.linebytes) == 0:
+        print("Nothing found. enable CONFIG_DEBUG_INFO / -g?")
+
+if __name__ == '__main__':
+    process(get_args())
-- 
2.41.0

