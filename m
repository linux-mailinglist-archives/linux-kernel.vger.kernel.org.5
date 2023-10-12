Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC517C7746
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442949AbjJLTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442789AbjJLTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:03 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC12D61
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:41 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fce245bf6so53221239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140121; x=1697744921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te8bxAntMAIcUysxac/XF+SiTDKrojbnDxZw68jqwCo=;
        b=DxmPRx4UiAZlzBSXiZ2shoT9t033IefvbTTXhhNsoooGn7KhIfGv5CBjz4s9cFiyYw
         7QXPd/sLGVFKzVbkeVVk09ClaKKIhkMEvxaEzfUrcCfpUzSTsnUIVNelEKvdI/bj3+T7
         +rVktLl1IVg842mF3LeGHsK6irZFY9/b76Gc803iMiZDKCUae2hV8KcZgXai4MVVJt89
         d4WP+bUc5Hc9s6SN4PcmqfLzCMTGyXxY4sdO1YjirRZs//cwOsvI7/hHqotyEnH1erae
         grOV+yNEaoQ1bqKUsocwCkO5QR/obpHl4yt4yLAnZpeaeIQbb9II+kwHqiZh8f+stK0L
         HNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140121; x=1697744921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te8bxAntMAIcUysxac/XF+SiTDKrojbnDxZw68jqwCo=;
        b=PGzta50/QYsk4oZA7uvkfgwFIW3835yX3df9L2KfLLMJddbHaAkn5tyLDna8WbvZE/
         b1bKdo9eAeZZ3hPKSAZe4FJr09MTEwsmNgnhh3ml24TthOSZXRkdQwEqybwuo7E0uM4Z
         VJQifLH0tPJWWZjOfgJT8AfPUEWwpxoFZDhi2m8Q1xi7hMb+eQpSLbITZN9K3ZHMCDMY
         z1malddFwldX8pY76S329kOq5sVkVsvc3VXAOw7ltYPGPpPMAX58smc6BNLR9CBUvs0Y
         dwgRWXiW5Ccxx39ru4P/WUNjb4JA/D//j0HyoqMiKlLeKSYaneooPM1AvQf4rmegRsO3
         h7LA==
X-Gm-Message-State: AOJu0YwWkI1nz+/0MigosyqjlqPNyWcKcYSp+rkkZtXEsaJJDPDtLhk3
        VF7OWgjQWie0FnjzzLVU3xCdlSBKhRPwcw==
X-Google-Smtp-Source: AGHT+IH7Q0tZJDS4rnV1h1A7dfwtAKU66e0auNCbZdhdzYU7yxzCJw57bGNtF534Ne+eXLim0uw81A==
X-Received: by 2002:a6b:7e05:0:b0:79f:cb49:f476 with SMTP id i5-20020a6b7e05000000b0079fcb49f476mr26160758iom.21.1697140120888;
        Thu, 12 Oct 2023 12:48:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 04/10] dyndbg: save _ddebug_site mod,file,func fields into maple-trees
Date:   Thu, 12 Oct 2023 13:48:28 -0600
Message-ID: <20231012194834.3288085-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194834.3288085-1-jim.cromie@gmail.com>
References: <20231012194834.3288085-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __dyndbg_sites section contains the "code organization"
hierarchical callsite info used to select & alter pr_debugs.

The table's 3 columns: modname, filename, function have substantial
repetition; this can be efficiently represented with intervals/ranges.

So this add 3 private maple trees, and ddebug_add_module() now calls
new ddebug_condense_sites() to scan the module's ddebug_sites, find
the 3 intervals, and call dd_store_range() to save them into their
respective trees.

dd_mt_scan() iterates thru these 3 trees and prints to syslog, it is
exposed via /sys/module/dynamic_debug/parameters/do_scan to give some
observability/testability.

3 accessors are coded, but unused atm.

Some Invariants (not all are relevant):

the pr_debugs are strictly "sorted" by linkage order; that is by
module, filename, function, line.  The 1st 3 are pointers into some
string table(s)? somewhere.

repeating column values are identical pointers, not just strcmp equal.

the descriptors (for builtin modules' or a loadable module) are all in
narrow/high memory ranges.  They wont conflict with maple-tree's
0-4096 value constraints.

the string table also has a knowable limited address range, or there
could be 3 tables, one for each column.  The table(s) contents may
also be sorted by linkage order.  Again, this might be useful.

the lineno is not repeating, except for some rare nested macro
expansions (amdgpu iirc, its not important).

NOTES:

I tried, but didnt succeed, to combine all 3 nested intervals into one
tree.  This is what I thought:

ISTM (1/2 baked WAG):

- the 3 columns could be compactly rep'd with run-length-encoding.
- the repeating blocks are intervals.
- the linker guarantees full ordering.
- maple-tree is good at these kind of intervals.

- using &descriptor (align-8) as insertion index provides gaps.
- inserting markers at those gaps allows "nesting" intervals.

The nested intervals of the columns' repetitions could be carefully
packed into a maple-tree, and efficiently retrieved.

So this tries:

adds a maple-tree field: _ddebug_info.sites_mt, to hold a
compressed copy of the .sites table.

ddebug_add_module() calls new ddebug_condense_sites(*_ddebug_info), which

scans the descriptors, finds the spans for each function, and stores
it as a range into the maple-tree, with 1st descriptor as index.

Some of those intervals also start larger filename and module
intervals, we mark these by inserting the file/module value
just "before" the function-range just stored.

This depends upon the
align(8) of all descriptor pointers to afford the -1 and -2 offsets for the modname and filename en

[    2.340903] dyndbg: add-module: i2c_designware_core 10 sites 0.0 classes.refs
[    2.341161] dyndbg:  mod name: i2c_designware_core ffffffff8311a43d
[    2.342045] dyndbg:  file name: drivers/i2c/busses/i2c-designware-common.c ffffffff8311a43e
[    2.342155] dyndbg:  function: i2c_dw_handle_tx_abort, 1 debugs ffffffff8311a440-ffffffff8311a468
[    2.343151] dyndbg:  function: i2c_dw_set_sda_hold, 1 debugs ffffffff8311a468-ffffffff8311a490
[    2.344155] dyndbg:  file name: drivers/i2c/busses/i2c-designware-master.c ffffffff8311a48e
[    2.345150] dyndbg:  function: i2c_dw_init_recovery_info, 1 debugs ffffffff8311a490-ffffffff8311a4b8
[    2.346151] dyndbg:  function: i2c_dw_isr, 1 debugs ffffffff8311a4b8-ffffffff8311a4e0
[    2.347151] dyndbg:  function: i2c_dw_xfer, 1 debugs ffffffff8311a4e0-ffffffff8311a508
[    2.348151] dyndbg:  function: i2c_dw_set_timings_master, 4 debugs ffffffff8311a508-ffffffff8311a5a8
[    2.349165] dyndbg:  file name: drivers/i2c/busses/i2c-designware-slave.c ffffffff8311a5a6
[    2.350152] dyndbg:  function: i2c_dw_isr_slave, 1 debugs ffffffff8311a5a8-ffffffff8311a5d0
[    2.351154] dyndbg:  10 debug prints in module i2c_designware_core

intervals of those called by a

, to
scan the .sites table, and do mtree_insert() to save each new module,
filename, or function found.  The insert index is offset by -N=3,2,1
for the respective columns.

TODO: use mtree_store_range(), with 0 offset, for function blocks.

This does a few things:

- it encodes the kind of interval (function, filename, modname).
- it yields a pre-order, top-down traversal: modname, filename, function

this is ddebug_condense_sites() in action:

[    1.506878] dyndbg: add-module: kobject 10 sites 0.0
[    1.507383] dyndbg:  modname: kobject
[    1.507763] dyndbg:  filename: lib/kobject.c
[    1.507877] dyndbg:  function: kset_release
[    1.508305] dyndbg:  function: dynamic_kobj_release
[    1.508803] dyndbg:  function: kobject_cleanup
[    1.508880] dyndbg:  function: __kobject_del
[    1.509313] dyndbg:  function: kobject_add_internal
[    1.509817] dyndbg:  function: fill_kobj_path
[    1.509882] dyndbg:  10 debug prints in module kobject

[    1.529907] dyndbg: 3424 prdebugs in 307 modules, 19 KiB ....

And heres the tail of the test-mod's do_print traversal of the tree.
kobject is the last builtin, i2c-piix4 is 1st loaded module.
2864 is #intervals, deduplicated from 3424 * 3 fields.
Looks like a 62% shrink, if you squint.

[  142.226760] test_dd:   2854: kobject
[  142.227013] test_dd:   2855: lib/kobject.c
[  142.227285] test_dd:   2856: kset_release
[  142.227568] test_dd:   2857: dynamic_kobj_release
[  142.227885] test_dd:   2858: kobject_cleanup
[  142.228180] test_dd:   2859: __kobject_del
[  142.228456] test_dd:   2860: kobject_add_internal
[  142.228780] test_dd:   2861: fill_kobj_path
[  142.229069] test_dd:   2862: kobject_uevent
[  142.229356] test_dd:   2863: lib/kobject_uevent.c
[  142.229687] test_dd:   2864: kobject_uevent_env
[  142.229998] test_dd:   2865: i2c_piix4
[  142.230253] test_dd:   2866: drivers/i2c/busses/i2c-piix4.c
[  142.230632] test_dd:   2867: piix4_transaction
[  142.230936] test_dd:   2868: piix4_setup_aux
[  142.231227] test_dd:   2869: piix4_setup_sb800
[  142.231527] test_dd:   2870: piix4_setup
[  142.231806] test_dd:   2871: serio_raw
[  142.232066] test_dd:   2872: drivers/input/serio/serio_raw.c
[  142.232447] test_dd:   2873: serio_raw_reconnect
[  142.232769] test_dd:   2874: serio_raw_connect
[  142.233079] test_dd:   2875: intel_rapl_common
[  142.233375] test_dd:   2876: drivers/powercap/intel_rapl_common.c
[  142.233788] test_dd:   2877: rapl_remove_package
[  142.234107] test_dd:   2878: rapl_detect_domains
[  142.234417] test_dd:   2879: rapl_package_register_powercap
[  142.234798] test_dd:   2880: rapl_update_domain_data
[  142.235145] test_dd:   2881: rapl_check_unit_tpmi
[  142.235469] test_dd:   2882: rapl_check_unit_atom
[  142.235804] test_dd:   2883: rapl_check_unit_core
[  142.236131] test_dd:   2884: rapl_read_data_raw
[  142.236445] test_dd:   2885: contraint_to_pl
[  142.236756] test_dd:   2886: intel_rapl_msr
[  142.237053] test_dd:   2887: drivers/powercap/intel_rapl_msr.c
[  142.237446] test_dd:   2888: rapl_msr_probe
[  142.237742] test_dd:   2889: rapl_msr_read_raw
[  142.238048] test_dd:   2890: test_dynamic_debug
[  142.238355] test_dd:   2891: lib/test_dynamic_debug.c
[  142.238720] test_dd:   2892: test_dynamic_debug_exit
[  142.239058] test_dd:   2893: test_dynamic_debug_init
[  142.239395] test_dd:   2894: do_prints
[  142.239660] test_dd:   2895: do_levels
[  142.239924] test_dd:   2896: do_cats
[  142.240168] test_dd:   2897: test_dynamic_debug_submod
[  142.240521] test_dd:   2898: lib/test_dynamic_debug.c
[  142.240871] test_dd:   2899: test_dynamic_debug_exit
[  142.241183] test_dd:   2900: test_dynamic_debug_init
[  142.241484] test_dd:   2901: do_prints
[  142.241725] test_dd:   2902: do_levels
[  142.241962] test_dd:   2903: do_cats

If this proves practical for accessors to traverse well (seems
likely), it will be simple to:

- move the 3 columns to _debug_site, linked from _ddebug
- scan them at boot, copy to the tree
- reclaim the whole memory block,
  which is all ptrs into a (one, or more/segmented) string.symbol table
- store the &tree into struct _ddebug_info,
  for both builtins and modules

Its slightly inconvenient that the fn-ptr is a string, with align(1),
but the "encoding" done in ddebug_condense_sites() could force the
insertion of an end-of-function-array token (marked by N, in &desc -
N).  With N=4, we'd get a marker ahead of module, yielding a proper
"framing".

The tree would be basically read-only for its respective lifetime,
its presumed virtue for this app is primarily size, speed is bonus.

(I probably need to look at advanced api...)

I added the MT_FLAGS_ALLOC_RANGE flag to the tree, thinking maybe I
could stuff the nested interval starters (each distinct function,
filename, modname) into the internal RANGE containing nodes.  Thats
probably nonsense, but it helped me figure out the N option.

(this needs further thinking)

Then magically, an augmented _find would return a vector of modname,
filename, function when needed.  Or maybe a sequence of calls to
mtree_find_upper_range() could collect the internal node values of the
nested intervals {module, filename, function} a descriptor is part of.

And thats about where the souffle collapses.

Any suggestions ?

And how to get the maple-tree size ?

cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: linux-mm@kvack.org
Cc: jbaron@akamai.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 142 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 51af6a75ae92..3dc17922a1d1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -25,6 +25,9 @@
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+
+#include <linux/maple_tree.h>
+
 #include <linux/parser.h>
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
@@ -83,6 +86,32 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+/* fill from __dyndbg_sites */
+static DEFINE_MTREE(mt_funcs);
+static DEFINE_MTREE(mt_files);
+static DEFINE_MTREE(mt_mods);
+
+static void dd_mt_scan(struct maple_tree *mt, const char *kind);
+static int param_set_do_scan(const char *instr, const struct kernel_param *kp)
+{
+	dd_mt_scan(&mt_funcs, "funcs");
+	dd_mt_scan(&mt_files, "files");
+	dd_mt_scan(&mt_mods, "mods");
+	return 0;
+}
+static int param_get_do_scan(char *buffer, const struct kernel_param *kp)
+{
+	dd_mt_scan(&mt_funcs, "funcs");
+	dd_mt_scan(&mt_files, "files");
+	dd_mt_scan(&mt_mods, "mods");
+	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+}
+static const struct kernel_param_ops param_ops_do_scan = {
+	.set = param_set_do_scan,
+	.get = param_get_do_scan,
+};
+module_param_cb(do_scan, &param_ops_do_scan, NULL, 0600);
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -132,6 +161,7 @@ do {								\
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 #define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
+#define v5pr_info(fmt, ...)	vnpr_info(5, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -196,6 +226,48 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 #define desc_modname(d)		(d)->site->_modname
 #define desc_filename(d)	(d)->site->_filename
 #define desc_function(d)	(d)->site->_function
+/*
+ * tmp accessors, they cheat and seek a match in builtins.  Obviously
+ * this wont work for loaded modules, but doesnt work at all yet.
+ */
+static const char * __desc_function(struct _ddebug const *dp)
+{
+	struct maple_tree *mt = &mt_funcs;
+
+	void *ret = mtree_load(mt, (unsigned long)dp);
+
+	if (ret != desc_function(dp))
+		pr_err("mt-load func %lx got %s want %s\n",
+		       (unsigned long)dp, (char*)ret, desc_function(dp));
+
+	return ret;
+}
+
+static const char * __desc_filename(struct _ddebug const *dp)
+{
+	struct maple_tree *mt = &mt_files;
+
+	void *ret = mtree_load(mt, (unsigned long)dp);
+
+	if (ret != desc_filename(dp))
+		pr_err("mt-load file %lx got %s want %s\n",
+		       (unsigned long)dp, (char*)ret, desc_filename(dp));
+
+	return ret;
+}
+
+static const char * __desc_modname(struct _ddebug const *dp)
+{
+	struct maple_tree *mt = &mt_mods;
+
+	void *ret = mtree_load(mt, (unsigned long)dp);
+
+	if (ret != desc_modname(dp))
+		pr_err("mt-load mod %lx got %s want %s\n",
+		       (unsigned long)dp, (char*)ret, desc_modname(dp));
+
+	return ret;
+}
 
 /*
  * Search the tables for _ddebug's which match the given `query' and
@@ -1314,6 +1386,74 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	vpr_dt_info(dt, "attach-client-module: ");
 }
 
+/*
+ * use a maple-tree to hold the intervals in all 3 columns of the
+ * __dyndbg_sites section (struct _ddebug_sites table[])
+ */
+
+static void dd_mt_scan(struct maple_tree *mt, const char *kind)
+{
+	long unsigned int idx = 0;
+	void * ent;
+	int ct = 0;
+
+	mt_for_each(mt, ent, idx, ULONG_MAX) {
+		v3pr_info("  %d: %lx %s\n", ct, idx, (char*)ent);
+		ct++;
+	}
+	v2pr_info("mt-%s has %d entries\n", kind, ct);
+}
+
+static void dd_store_range(struct maple_tree *mt, const struct _ddebug *start,
+			   const struct _ddebug *next, const char *kind, const char *name)
+{
+	unsigned long first = (unsigned long)start;
+	unsigned long last = (unsigned long)(next - 1); /* cast after decrement */
+	int rc, reps = next - start;
+	char *val;
+
+	v3pr_info("  %s: %s,\t%d debugs %lx-%lx\n", kind, name, reps, first, last);
+	rc = mtree_insert_range(mt, first, last, (void*)name, GFP_KERNEL);
+	if (rc)
+		pr_err("%s:%s range store failed: %d\n", kind, name, rc);
+	else
+		v4pr_info("  OK %s: %s, %d debugs %lx-%lx\n", kind, name, reps, first, last);
+
+	val = (char*) mtree_load(mt, first);
+	if (!val)
+		pr_err("%s:%s find on range store failed\n", kind, name);
+	else
+		v4pr_info("  ok %s at %lx\n", val, first);
+}
+
+static void ddebug_condense_sites(struct _ddebug_info *di)
+{
+	struct _ddebug *cur, *funcp, *filep, *modp;
+	int i;
+
+	funcp = filep = modp = di->descs;
+	for_each_boxed_vector(di, descs, num_descs, i, cur) {
+
+		if (!strcmp(desc_function(cur), desc_function(funcp)))
+			continue;
+		dd_store_range(&mt_funcs, funcp, cur, "func", desc_function(funcp));
+		funcp = cur;
+
+		if (!strcmp(desc_filename(cur), desc_filename(filep)))
+			continue;
+		dd_store_range(&mt_files, filep, cur, "file", desc_filename(filep));
+		filep = cur;
+
+		if (!strcmp(desc_modname(cur), desc_modname(modp)))
+			continue;
+		dd_store_range(&mt_mods, modp, cur, "mod", desc_modname(modp));
+		modp = cur;
+	}
+	dd_store_range(&mt_funcs, funcp, cur, "func:", desc_function(funcp));
+	dd_store_range(&mt_files, filep, cur, "file:", desc_filename(filep));
+	dd_store_range(&mt_mods, modp, cur, "mod:", desc_modname(modp));
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1346,6 +1486,8 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 
 	INIT_LIST_HEAD(&dt->link);
 
+	ddebug_condense_sites(di);
+
 	for_each_boxed_vector(di, descs, num_descs, i, iter)
 		if (iter->class_id != _DPRINTK_CLASS_DFLT)
 			class_ct++;
-- 
2.41.0

