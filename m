Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651DC779E49
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjHLIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjHLIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FD2D52;
        Sat, 12 Aug 2023 01:52:12 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNDrL5DLrzTmPP;
        Sat, 12 Aug 2023 16:50:10 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:09 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 15/16] perf kwork top: Add BPF-based statistics on hardirq event support
Date:   Sat, 12 Aug 2023 08:49:16 +0000
Message-ID: <20230812084917.169338-16-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20230812084917.169338-1-yangjihong1@huawei.com>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bpf to collect statistics on hardirq events based on perf BPF skeletons.

Example usage:

  # perf kwork top -k sched,irq -b
  Starting trace, Hit <Ctrl+C> to stop and report
  ^C
  Total  : 136717.945 ms, 8 cpus
  %Cpu(s):  17.10% id,   0.01% hi,   0.00% si
  %Cpu0   [|||||||||||||||||||||||||       84.26%]
  %Cpu1   [|||||||||||||||||||||||||       84.77%]
  %Cpu2   [||||||||||||||||||||||||        83.22%]
  %Cpu3   [||||||||||||||||||||||||        80.37%]
  %Cpu4   [||||||||||||||||||||||||        81.49%]
  %Cpu5   [|||||||||||||||||||||||||       84.68%]
  %Cpu6   [|||||||||||||||||||||||||       84.48%]
  %Cpu7   [||||||||||||||||||||||||        80.21%]

        PID     SPID    %CPU           RUNTIME  COMMMAND
    -------------------------------------------------------------
          0        0   19.78       3482.833 ms  [swapper/7]
          0        0   19.62       3454.219 ms  [swapper/3]
          0        0   18.50       3258.339 ms  [swapper/4]
          0        0   16.76       2842.749 ms  [swapper/2]
          0        0   15.71       2627.905 ms  [swapper/0]
          0        0   15.51       2598.206 ms  [swapper/6]
          0        0   15.31       2561.820 ms  [swapper/5]
          0        0   15.22       2548.708 ms  [swapper/1]
      13253    13018    2.95        513.108 ms  sched-messaging
      13092    13018    2.67        454.167 ms  sched-messaging
      13401    13018    2.66        454.790 ms  sched-messaging
      13240    13018    2.64        454.587 ms  sched-messaging
      13251    13018    2.61        442.273 ms  sched-messaging
      13075    13018    2.61        438.932 ms  sched-messaging
      13220    13018    2.60        443.245 ms  sched-messaging
      13235    13018    2.59        443.268 ms  sched-messaging
      13222    13018    2.50        426.344 ms  sched-messaging
      13410    13018    2.49        426.191 ms  sched-messaging
      13228    13018    2.46        425.121 ms  sched-messaging
      13379    13018    2.38        409.950 ms  sched-messaging
      13236    13018    2.37        413.159 ms  sched-messaging
      13095    13018    2.36        396.572 ms  sched-messaging
      13325    13018    2.35        408.089 ms  sched-messaging
      13242    13018    2.32        394.750 ms  sched-messaging
      13386    13018    2.31        396.997 ms  sched-messaging
      13046    13018    2.29        383.833 ms  sched-messaging
      13109    13018    2.28        388.482 ms  sched-messaging
      13388    13018    2.28        393.576 ms  sched-messaging
      13238    13018    2.26        388.487 ms  sched-messaging
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/bpf_kwork_top.c          | 11 ++++
 tools/perf/util/bpf_skel/kwork_top.bpf.c | 79 ++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 42897ea22c61..3998bd2a938f 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -79,6 +79,16 @@ void perf_kwork__top_finish(void)
 	pr_debug("perf kwork top finish at: %lld\n", skel->bss->to_timestamp);
 }
 
+static void irq_load_prepare(void)
+{
+	bpf_program__set_autoload(skel->progs.on_irq_handler_entry, true);
+	bpf_program__set_autoload(skel->progs.on_irq_handler_exit, true);
+}
+
+static struct kwork_class_bpf kwork_irq_bpf = {
+	.load_prepare = irq_load_prepare,
+};
+
 static void sched_load_prepare(void)
 {
 	bpf_program__set_autoload(skel->progs.on_switch, true);
@@ -90,6 +100,7 @@ static struct kwork_class_bpf kwork_sched_bpf = {
 
 static struct kwork_class_bpf *
 kwork_class_bpf_supported_list[KWORK_CLASS_MAX] = {
+	[KWORK_CLASS_IRQ]	= &kwork_irq_bpf,
 	[KWORK_CLASS_SCHED]	= &kwork_sched_bpf,
 };
 
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 47ad61608ec7..9c7dc62386c7 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -54,6 +54,13 @@ struct {
 	__type(value, struct time_data);
 } kwork_top_task_time SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(key_size, sizeof(struct work_key));
+	__uint(value_size, sizeof(struct time_data));
+	__uint(max_entries, MAX_ENTRIES);
+} kwork_top_irq_time SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(struct task_key));
@@ -184,4 +191,76 @@ int on_switch(u64 *ctx)
 	return 0;
 }
 
+SEC("tp_btf/irq_handler_entry")
+int on_irq_handler_entry(u64 *cxt)
+{
+	struct task_struct *task;
+
+	if (!enabled)
+		return 0;
+
+	__u32 cpu = bpf_get_smp_processor_id();
+
+	if (cpu_is_filtered(cpu))
+		return 0;
+
+	__u64 ts = bpf_ktime_get_ns();
+
+	task = (struct task_struct *)bpf_get_current_task();
+	if (!task)
+		return 0;
+
+	struct work_key key = {
+		.type = KWORK_CLASS_IRQ,
+		.pid = BPF_CORE_READ(task, pid),
+		.task_p = (__u64)task,
+	};
+
+	struct time_data data = {
+		.timestamp = ts,
+	};
+
+	bpf_map_update_elem(&kwork_top_irq_time, &key, &data, BPF_ANY);
+
+	return 0;
+}
+
+SEC("tp_btf/irq_handler_exit")
+int on_irq_handler_exit(u64 *cxt)
+{
+	__u64 delta;
+	struct task_struct *task;
+	struct time_data *pelem;
+
+	if (!enabled)
+		return 0;
+
+	__u32 cpu = bpf_get_smp_processor_id();
+
+	if (cpu_is_filtered(cpu))
+		return 0;
+
+	__u64 ts = bpf_ktime_get_ns();
+
+	task = (struct task_struct *)bpf_get_current_task();
+	if (!task)
+		return 0;
+
+	struct work_key key = {
+		.type = KWORK_CLASS_IRQ,
+		.pid = BPF_CORE_READ(task, pid),
+		.task_p = (__u64)task,
+	};
+
+	pelem = bpf_map_lookup_elem(&kwork_top_irq_time, &key);
+	if (pelem && pelem->timestamp != 0)
+		delta = ts - pelem->timestamp;
+	else
+		delta = ts - from_timestamp;
+
+	update_work(&key, delta);
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
-- 
2.30.GIT

