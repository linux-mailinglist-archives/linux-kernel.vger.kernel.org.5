Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1332C80FAED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377946AbjLLXCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjLLXCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:02:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B5BD;
        Tue, 12 Dec 2023 15:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422165; x=1733958165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JWEGSR5qyfVg9jh3rB8ZCwyPfZtwfWj1GdI64zLzEhs=;
  b=Rruh9J4+mkaBJPCKI/VkKvF2t5Zu/K0fo3xxWOauvPMiICYWxh0hRh9U
   xJeTDF5qprO2Y2bN9uu3S1gGZ44V3IboBZn93Ey51AaJU9DblGsfSPPk0
   TKxjU+nAmXAYzF5IdTR2Whnk1MPNgMTAxq5LZCuu6Hd3jxeXwUe5IdLnY
   FMmYYxmYp5wjo+Oqfh9T7kvegbJjngvJGs4W+pOi1+oasu86irUQNVgJN
   5W0lnHJvrxgcSAyodo42ocwdFMDHcCvruWcUHp87K+Drb0MG39RC7iaOf
   ljydXo2Zre68VQj+XO+Wb+UBeA7CVXJxzOeg97kmtygxkSTzIGuWe55pu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055904"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864391965"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864391965"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:43 -0800
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v3 03/18] perf pmu-events: Add functions in jevent.py to parse counter and event info for hardware aware grouping
Date:   Tue, 12 Dec 2023 15:02:09 -0800
Message-Id: <20231212230224.1473300-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212230224.1473300-1-weilin.wang@intel.com>
References: <20231212230224.1473300-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

These functions are added to parse event counter restrictions and counter
availability info from json files so that the metric grouping method could
do grouping based on the counter restriction of events and the counters
that are available on the system.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/pmu-events/jevents.py   | 171 ++++++++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h |  25 ++++-
 2 files changed, 188 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 0093c998cb6e..16f17d335f8e 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -23,6 +23,8 @@ _metric_tables = []
 _sys_metric_tables = []
 # Mapping between sys event table names and sys metric table names.
 _sys_event_table_to_metric_table_mapping = {}
+# List of regular PMU counter layout tables.
+_pmu_layouts_tables = []
 # Map from an event name to an architecture standard
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
@@ -31,6 +33,9 @@ _arch_std_events = {}
 _pending_events = []
 # Name of events table to be written out
 _pending_events_tblname = None
+# PMU counter layout to write out when the table is closed
+_pending_pmu_counts = [] # Name of PMU counter layout table to be written out
+_pending_pmu_counts_tblname = None
 # Metrics to write out when the table is closed
 _pending_metrics = []
 # Name of metrics table to be written out
@@ -47,10 +52,17 @@ _json_event_attributes = [
     'event',
     # Short things in alphabetical order.
     'compat', 'deprecated', 'perpkg', 'unit',
+    # Counter this event could use
+    'counter',
     # Longer things (the last won't be iterated over during decompress).
     'long_desc'
 ]
 
+# Attributes that are in pmu_unit_layout.
+_json_layout_attributes = [
+    'pmu', 'desc', 'size', 'fixed_size'
+]
+
 # Attributes that are in pmu_metric rather than pmu_event.
 _json_metric_attributes = [
     'metric_name', 'metric_group', 'metric_expr', 'metric_threshold',
@@ -58,7 +70,9 @@ _json_metric_attributes = [
     'default_metricgroup_name', 'aggr_mode', 'event_grouping'
 ]
 # Attributes that are bools or enum int values, encoded as '0', '1',...
-_json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg']
+_json_enum_attributes = ['aggr_mode', 'deprecated', 'event_grouping', 'perpkg',
+    'size', 'fixed_size'
+]
 
 def removesuffix(s: str, suffix: str) -> str:
   """Remove the suffix from a string
@@ -316,6 +330,9 @@ class JsonEvent:
     if 'Errata' in jd:
       extra_desc += '  Spec update: ' + jd['Errata']
     self.pmu = unit_to_pmu(jd.get('Unit'))
+    self.counter = jd.get('Counter')
+    self.size = jd.get('Size')
+    self.fixed_size = jd.get('FixedSize')
     filter = jd.get('Filter')
     self.unit = jd.get('ScaleUnit')
     self.perpkg = jd.get('PerPkg')
@@ -386,8 +403,16 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def build_c_string(self, metric: bool) -> str:
+  def build_c_string(self, metric: bool, layout: bool = False) -> str:
     s = ''
+    if layout:
+      for attr in _json_layout_attributes:
+        x = getattr(self, attr)
+        if attr in _json_enum_attributes:
+          s += x if x else '0'
+        else:
+          s += f'{x}\\000' if x else '\\000'
+      return s
     for attr in _json_metric_attributes if metric else _json_event_attributes:
       x = getattr(self, attr)
       if metric and x and attr == 'metric_expr':
@@ -402,10 +427,10 @@ class JsonEvent:
         s += f'{x}\\000' if x else '\\000'
     return s
 
-  def to_c_string(self, metric: bool) -> str:
+  def to_c_string(self, metric: bool, layout: bool = False) -> str:
     """Representation of the event as a C struct initializer."""
 
-    s = self.build_c_string(metric)
+    s = self.build_c_string(metric, layout)
     return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
 
 
@@ -442,6 +467,8 @@ def preprocess_arch_std_files(archpath: str) -> None:
           _arch_std_events[event.name.lower()] = event
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
+        if event.size:
+          _arch_std_events[event.pmu.lower()] = event
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -451,6 +478,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
       _pending_events.append(e)
     if e.metric_name:
       _pending_metrics.append(e)
+    if e.size:
+      _pending_pmu_counts.append(e)
 
 
 def print_pending_events() -> None:
@@ -564,6 +593,33 @@ const struct pmu_table_entry {_pending_metrics_tblname}[] = {{
 """)
   _args.output_file.write('};\n\n')
 
+def print_pending_pmu_counts() -> None:
+
+  def pmu_counts_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
+    def fix_none(s: Optional[str]) -> str:
+      if s is None:
+        return ''
+      return s
+
+    return (j.desc is not None, fix_none(j.pmu), fix_none(j.size))
+
+  global _pending_pmu_counts
+  if not _pending_pmu_counts:
+    return
+
+  global _pending_pmu_counts_tblname
+  global pmu_layouts_tables
+  _pmu_layouts_tables.append(_pending_pmu_counts_tblname)
+
+  _args.output_file.write(
+      f'static const struct compact_pmu_event {_pending_pmu_counts_tblname}[] = {{\n')
+
+  for pmu_layout in sorted(_pending_pmu_counts, key=pmu_counts_cmp_key):
+    _args.output_file.write(pmu_layout.to_c_string(metric=False, layout=True))
+    _pending_pmu_counts = []
+
+  _args.output_file.write('};\n\n')
+
 def get_topic(topic: str) -> str:
   if topic.endswith('metrics.json'):
     return 'metrics'
@@ -604,6 +660,8 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
     if event.metric_name:
       _bcs.add(pmu_name, metric=True)
       _bcs.add(event.build_c_string(metric=True), metric=True)
+    if event.size:
+      _bcs.add(event.build_c_string(metric=False, layout=True), metric=False)
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
@@ -617,11 +675,14 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if item.is_dir() and is_leaf_dir(item.path):
     print_pending_events()
     print_pending_metrics()
+    print_pending_pmu_counts()
 
     global _pending_events_tblname
     _pending_events_tblname = file_name_to_table_name('pmu_events_', parents, item.name)
     global _pending_metrics_tblname
     _pending_metrics_tblname = file_name_to_table_name('pmu_metrics_', parents, item.name)
+    global _pending_pmu_counts_tblname
+    _pending_pmu_counts_tblname = file_name_to_table_name('pmu_layouts_', parents, item.name)
 
     if item.name == 'sys':
       _sys_event_table_to_metric_table_mapping[_pending_events_tblname] = _pending_metrics_tblname
@@ -655,6 +716,12 @@ struct pmu_metrics_table {
         uint32_t num_pmus;
 };
 
+/* Struct used to make the PMU counter layout table implementation opaque to callers. */
+struct pmu_layouts_table {
+        const struct compact_pmu_event *entries;
+        size_t length;
+};
+
 /*
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
@@ -668,6 +735,7 @@ struct pmu_events_map {
         const char *cpuid;
         struct pmu_events_table event_table;
         struct pmu_metrics_table metric_table;
+        struct pmu_layouts_table layout_table;
 };
 
 /*
@@ -712,6 +780,12 @@ const struct pmu_events_map pmu_events_map[] = {
               metric_size = '0'
             if event_size == '0' and metric_size == '0':
               continue
+            layout_tblname = file_name_to_table_name('pmu_layouts_', [], row[2].replace('/', '_'))
+            if layout_tblname in _pmu_layouts_tables:
+              layout_size = f'ARRAY_SIZE({layout_tblname})'
+            else:
+              layout_tblname = 'NULL'
+              layout_size = '0'
             cpuid = row[0].replace('\\', '\\\\')
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
@@ -723,6 +797,10 @@ const struct pmu_events_map pmu_events_map[] = {
 \t.metric_table = {{
 \t\t.pmus = {metric_tblname},
 \t\t.num_pmus = {metric_size}
+\t}},
+\t.layout_table = {{
+\t\t.entries = {layout_tblname},
+\t\t.length = {layout_size}
 \t}}
 }},
 """)
@@ -733,6 +811,7 @@ const struct pmu_events_map pmu_events_map[] = {
 \t.cpuid = 0,
 \t.event_table = { 0, 0 },
 \t.metric_table = { 0, 0 },
+\t.layout_table = { 0, 0 },
 }
 };
 """)
@@ -821,6 +900,24 @@ static void decompress_metric(int offset, struct pmu_metric *pm)
       _args.output_file.write('\twhile (*p++);')
   _args.output_file.write("""}
 
+static void decompress_layout(int offset, struct pmu_layout *pm)
+{
+\tconst char *p = &big_c_string[offset];
+""")
+  for attr in _json_layout_attributes:
+    _args.output_file.write(f'\n\tpm->{attr} = ')
+    if attr in _json_enum_attributes:
+      _args.output_file.write("*p - '0';\n")
+    else:
+      _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
+    if attr == _json_layout_attributes[-1]:
+      continue
+    if attr in _json_enum_attributes:
+      _args.output_file.write('\tp++;')
+    else:
+      _args.output_file.write('\twhile (*p++);')
+  _args.output_file.write("""}
+
 static int pmu_events_table__for_each_event_pmu(const struct pmu_events_table *table,
                                                 const struct pmu_table_entry *pmu,
                                                 pmu_event_iter_fn fn,
@@ -976,6 +1073,21 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
+int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *table,
+                                     pmu_layout_iter_fn fn,
+                                     void *data) {
+        for (size_t i = 0; i < table->length; i++) {
+                struct pmu_layout pm;
+                int ret;
+
+                decompress_layout(table->entries[i].offset, &pm);
+                ret = fn(&pm, data);
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
 static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
 {
         static struct {
@@ -1071,6 +1183,33 @@ const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pm
         return NULL;
 }
 
+const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf_pmu *pmu)
+{
+        const struct pmu_layouts_table *table = NULL;
+        char *cpuid = perf_pmu__getcpuid(pmu);
+        int i;
+
+        /* on some platforms which uses cpus map, cpuid can be NULL for
+         * PMUs other than CORE PMUs.
+         */
+        if (!cpuid)
+                return NULL;
+
+        i = 0;
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+                if (!map->arch)
+                        break;
+
+                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+                        table = &map->layout_table;
+                        break;
+                }
+        }
+        free(cpuid);
+        return table;
+}
+
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
 {
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
@@ -1092,6 +1231,16 @@ const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const
         }
         return NULL;
 }
+const struct pmu_layouts_table *find_core_layouts_table(const char *arch, const char *cpuid)
+{
+        for (const struct pmu_events_map *tables = &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+                        return &tables->layout_table;
+        }
+        return NULL;
+}
 
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
@@ -1120,6 +1269,19 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
         return 0;
 }
 
+int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data)
+{
+        for (const struct pmu_events_map *tables = &pmu_events_map[0];
+             tables->arch;
+             tables++) {
+                int ret = pmu_layouts_table__for_each_layout(&tables->layout_table, fn, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
 const struct pmu_events_table *find_sys_events_table(const char *name)
 {
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
@@ -1276,6 +1438,7 @@ struct pmu_table_entry {
     ftw(arch_path, [], process_one_file)
     print_pending_events()
     print_pending_metrics()
+    print_pending_pmu_counts()
 
   print_mapping_table(archs)
   print_system_mapping_table()
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index f5aa96f1685c..65e0c5dd8bb4 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -45,6 +45,7 @@ struct pmu_event {
 	const char *desc;
 	const char *topic;
 	const char *long_desc;
+	const char *counter;
 	const char *pmu;
 	const char *unit;
 	bool perpkg;
@@ -67,8 +68,16 @@ struct pmu_metric {
 	enum metric_event_groups event_grouping;
 };
 
+struct pmu_layout {
+	const char *pmu;
+	const char *desc;
+	int size;
+	int fixed_size;
+};
+
 struct pmu_events_table;
 struct pmu_metrics_table;
+struct pmu_layouts_table;
 
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_events_table *table,
@@ -78,15 +87,20 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data);
 
+typedef int (*pmu_layout_iter_fn)(const struct pmu_layout *pm,
+				  void *data);
+
 int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu,
 				    pmu_event_iter_fn fn,
 				    void *data);
 int pmu_events_table__find_event(const struct pmu_events_table *table,
-                                 struct perf_pmu *pmu,
-                                 const char *name,
-                                 pmu_event_iter_fn fn,
-				 void *data);
+				struct perf_pmu *pmu,
+				const char *name,
+				pmu_event_iter_fn fn,
+				void *data);
+int pmu_layouts_table__for_each_layout(const struct pmu_layouts_table *table, pmu_layout_iter_fn fn,
+				     void *data);
 size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 				    struct perf_pmu *pmu);
 
@@ -95,10 +109,13 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pm
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu);
+const struct pmu_layouts_table *perf_pmu__find_layouts_table(struct perf_pmu *pmu);
 const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
 const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
+const struct pmu_layouts_table *find_core_layouts_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
+int pmu_for_each_core_layout(pmu_layout_iter_fn fn, void *data);
 
 const struct pmu_events_table *find_sys_events_table(const char *name);
 const struct pmu_metrics_table *find_sys_metrics_table(const char *name);
-- 
2.39.3

