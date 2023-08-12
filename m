Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF687779E4A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjHLIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjHLIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 04:52:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30BD2D5B;
        Sat, 12 Aug 2023 01:52:12 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RNDpc5sZLzNmjN;
        Sat, 12 Aug 2023 16:48:40 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 16:52:10 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <sandipan.das@amd.com>, <ravi.bangoria@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v1 16/16] perf kwork top: Add BPF-based statistics on softirq event support
Date:   Sat, 12 Aug 2023 08:49:17 +0000
Message-ID: <20230812084917.169338-17-yangjihong1@huawei.com>
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

Use bpf to collect statistics on softirq events based on perf BPF skeletons.

Example usage:

  # perf kwork top -b
  Starting trace, Hit <Ctrl+C> to stop and report
  ^C
  Total  : 135445.704 ms, 8 cpus
  %Cpu(s):  28.35% id,   0.00% hi,   0.25% si
  %Cpu0   [||||||||||||||||||||            69.85%]
  %Cpu1   [||||||||||||||||||||||          74.10%]
  %Cpu2   [|||||||||||||||||||||           71.18%]
  %Cpu3   [||||||||||||||||||||            69.61%]
  %Cpu4   [||||||||||||||||||||||          74.05%]
  %Cpu5   [||||||||||||||||||||            69.33%]
  %Cpu6   [||||||||||||||||||||            69.71%]
  %Cpu7   [||||||||||||||||||||||          73.77%]

        PID     SPID    %CPU           RUNTIME  COMMMAND
    -------------------------------------------------------------
          0        0   30.43       5271.005 ms  [swapper/5]
          0        0   30.17       5226.644 ms  [swapper/3]
          0        0   30.08       5210.257 ms  [swapper/6]
          0        0   29.89       5177.177 ms  [swapper/0]
          0        0   28.51       4938.672 ms  [swapper/2]
          0        0   25.93       4223.464 ms  [swapper/7]
          0        0   25.69       4181.411 ms  [swapper/4]
          0        0   25.63       4173.804 ms  [swapper/1]
      16665    16265    2.16        360.600 ms  sched-messaging
      16537    16265    2.05        356.275 ms  sched-messaging
      16503    16265    2.01        343.063 ms  sched-messaging
      16424    16265    1.97        336.876 ms  sched-messaging
      16580    16265    1.94        323.658 ms  sched-messaging
      16515    16265    1.92        321.616 ms  sched-messaging
      16659    16265    1.91        325.538 ms  sched-messaging
      16634    16265    1.88        327.766 ms  sched-messaging
      16454    16265    1.87        326.843 ms  sched-messaging
      16382    16265    1.87        322.591 ms  sched-messaging
      16642    16265    1.86        320.506 ms  sched-messaging
      16582    16265    1.86        320.164 ms  sched-messaging
      16315    16265    1.86        326.872 ms  sched-messaging
      16637    16265    1.85        323.766 ms  sched-messaging
      16506    16265    1.82        311.688 ms  sched-messaging
      16512    16265    1.81        304.643 ms  sched-messaging
      16560    16265    1.80        314.751 ms  sched-messaging
      16320    16265    1.80        313.405 ms  sched-messaging
      16442    16265    1.80        314.403 ms  sched-messaging
      16626    16265    1.78        295.380 ms  sched-messaging
      16600    16265    1.77        309.444 ms  sched-messaging
      16550    16265    1.76        301.161 ms  sched-messaging
      16525    16265    1.75        296.560 ms  sched-messaging
      16314    16265    1.75        298.338 ms  sched-messaging
      16595    16265    1.74        304.390 ms  sched-messaging
      16555    16265    1.74        287.564 ms  sched-messaging
      16520    16265    1.74        295.734 ms  sched-messaging
      16507    16265    1.73        293.956 ms  sched-messaging
      16593    16265    1.72        296.443 ms  sched-messaging
      16531    16265    1.72        299.950 ms  sched-messaging
      16281    16265    1.72        301.339 ms  sched-messaging
  <SNIP>

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/bpf_kwork_top.c          | 11 ++++
 tools/perf/util/bpf_skel/kwork_top.bpf.c | 72 ++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 3998bd2a938f..1a607b94f44d 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -89,6 +89,16 @@ static struct kwork_class_bpf kwork_irq_bpf = {
 	.load_prepare = irq_load_prepare,
 };
 
+static void softirq_load_prepare(void)
+{
+	bpf_program__set_autoload(skel->progs.on_softirq_entry, true);
+	bpf_program__set_autoload(skel->progs.on_softirq_exit, true);
+}
+
+static struct kwork_class_bpf kwork_softirq_bpf = {
+	.load_prepare = softirq_load_prepare,
+};
+
 static void sched_load_prepare(void)
 {
 	bpf_program__set_autoload(skel->progs.on_switch, true);
@@ -101,6 +111,7 @@ static struct kwork_class_bpf kwork_sched_bpf = {
 static struct kwork_class_bpf *
 kwork_class_bpf_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_IRQ]	= &kwork_irq_bpf,
+	[KWORK_CLASS_SOFTIRQ]	= &kwork_softirq_bpf,
 	[KWORK_CLASS_SCHED]	= &kwork_sched_bpf,
 };
 
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 9c7dc62386c7..84c15ccbab44 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -263,4 +263,76 @@ int on_irq_handler_exit(u64 *cxt)
 	return 0;
 }
 
+SEC("tp_btf/softirq_entry")
+int on_softirq_entry(u64 *cxt)
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
+		.type = KWORK_CLASS_SOFTIRQ,
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
+SEC("tp_btf/softirq_exit")
+int on_softirq_exit(u64 *cxt)
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
+		.type = KWORK_CLASS_SOFTIRQ,
+		.pid = BPF_CORE_READ(task, pid),
+		.task_p = (__u64)task,
+	};
+
+	pelem = bpf_map_lookup_elem(&kwork_top_irq_time, &key);
+	if (pelem)
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

