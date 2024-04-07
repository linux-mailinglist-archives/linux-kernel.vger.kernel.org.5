Return-Path: <linux-kernel+bounces-134255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9B89AFB5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06659B21A9D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE0111AA;
	Sun,  7 Apr 2024 08:37:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8DD8F66;
	Sun,  7 Apr 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479047; cv=none; b=ug/05J8YOcQAHgmADQc0S8OnpVbuNb3tTlQjxj/nK+Y87qE834wLUsjqZOCuZGGizgv2hg6g+vgL5ZIbwCW2/C0EYXUpbFQYYJRIDV2PKoCWo57DW6HPSUtd+hYJsIYGq2mf+1Jsark2CwM0SXazVQ/mhBDmUSkL8+2vkV89v28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479047; c=relaxed/simple;
	bh=MXeC9BXxotjbIWyCRJS9bnfR7LpF54OtfaVtR/+NUWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7qp4uKRqVSIx6UpvMmA55niyiPCs8rSn3IgaoeeyurIlRFgErkEu3w1e/nXIxLvH2MNYOa0ZN2ZjWa+VKX4usUAWW0X0/Q+lkmu7nLDSPpvc2S6Bb8gBuWs+ycVBqVea7ERHNa5p5H1nYspnGr1F+NFMZxMwg3NxUsrWYR9GTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxqro_WxJmdgEkAA--.1779S3;
	Sun, 07 Apr 2024 16:37:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZMw7WxJmnYZ0AA--.34647S2;
	Sun, 07 Apr 2024 16:37:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Ming Wang <wangming01@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v2] perf kvm: Add kvm-stat for loongarch64
Date: Sun,  7 Apr 2024 16:37:15 +0800
Message-Id: <20240407083715.851461-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZMw7WxJmnYZ0AA--.34647S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add support for 'perf kvm stat' on loongarch64 platform, now only
kvm exit event is supported.

Here is example output about "perf kvm --host stat report" command

   Event name   Samples   Sample%     Time (ns)   Time%   Mean Time (ns)
    Mem store     83969    51.00%     625697070   8.00%             7451
     Mem read     37641    22.00%     112485730   1.00%             2988
    Interrupt     15542     9.00%      20620190   0.00%             1326
        Iocsr     15207     9.00%      94296190   1.00%             6200
    Hypercall      4873     2.00%      12265280   0.00%             2516
         Idle      3713     2.00%    6322055860  87.00%          1702681
          FPU      1819     1.00%       2750300   0.00%             1511
       Ifecth       502     0.00%       1341740   0.00%             2672
   Mem modify       324     0.00%        602240   0.00%             1858
       Cpucfg        55     0.00%         77610   0.00%             1411
          Csr        12     0.00%         19690   0.00%             1640
         LASX         3     0.00%          4870   0.00%             1623
          LSX         2     0.00%          2100   0.00%             1050

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
v1 --- v2:
  1. Add child_ops for kvm exit event, split kvm:kvm_exit_gspr events
into cpucfg/csr/iocsr/idle child events by decoding detailed gspr
instruction.
  2. Remove some exception code type which does not happen in current
kvm implementation, such as meomry NR/NX/priviledge exception.
---
 tools/perf/arch/loongarch/Makefile        |   1 +
 tools/perf/arch/loongarch/util/Build      |   2 +
 tools/perf/arch/loongarch/util/header.c   |  85 +++++++++++++
 tools/perf/arch/loongarch/util/kvm-stat.c | 141 ++++++++++++++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 tools/perf/arch/loongarch/util/header.c
 create mode 100644 tools/perf/arch/loongarch/util/kvm-stat.c

diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 3992a67a87d9..c89d6bb6b184 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
+HAVE_KVM_STAT_SUPPORT := 1
 
 #
 # Syscall table generation for perf
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index d776125a2d06..e1a13761037b 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,5 +1,7 @@
 perf-y += perf_regs.o
+perf-y += header.o
 
+perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/loongarch/util/header.c
new file mode 100644
index 000000000000..8f7061cf6977
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/header.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implementation of get_cpuid().
+ *
+ * Author: Nikita Shubin <n.shubin@yadro.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <api/fs/fs.h>
+#include <errno.h>
+#include "util/debug.h"
+#include "util/header.h"
+
+#define CPUINFO_MODEL	"Model Name"
+#define CPUINFO		"/proc/cpuinfo"
+
+static char *_get_field(const char *line)
+{
+	char *line2, *nl;
+
+	line2 = strrchr(line, ' ');
+	if (!line2)
+		return NULL;
+
+	line2++;
+	nl = strrchr(line, '\n');
+	if (!nl)
+		return NULL;
+
+	return strndup(line2, nl - line2);
+}
+
+static char *_get_cpuid(void)
+{
+	char *line = NULL;
+	char *model = NULL;
+	char *cpuid = NULL;
+	int read;
+	unsigned long line_sz;
+	FILE *cpuinfo;
+
+	cpuinfo = fopen(CPUINFO, "r");
+	if (cpuinfo == NULL)
+		return cpuid;
+
+	while ((read = getline(&line, &line_sz, cpuinfo)) != -1) {
+		if (strncmp(line, CPUINFO_MODEL, strlen(CPUINFO_MODEL)))
+			continue;
+
+		model = _get_field(line);
+		if (!model)
+			goto free;
+		break;
+	}
+
+	if (asprintf(&cpuid, "%s", model) < 0)
+		cpuid = NULL;
+
+free:
+	fclose(cpuinfo);
+	free(model);
+	return cpuid;
+}
+
+int get_cpuid(char *buffer, size_t sz)
+{
+	char *cpuid = _get_cpuid();
+	int ret = 0;
+
+	if (sz < strlen(cpuid)) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	scnprintf(buffer, sz, "%s", cpuid);
+free:
+	free(cpuid);
+	return ret;
+}
+
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	return _get_cpuid();
+}
diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/arch/loongarch/util/kvm-stat.c
new file mode 100644
index 000000000000..2c21d73cd855
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/kvm-stat.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <memory.h>
+#include <errno.h>
+#include "util/kvm-stat.h"
+#include "util/parse-events.h"
+#include "util/debug.h"
+#include "util/evsel.h"
+#include "util/evlist.h"
+#include "util/pmus.h"
+
+#define LOONGARCH_EXCEPTION_INT		0
+#define LOONGARCH_EXCEPTION_PIL		1
+#define LOONGARCH_EXCEPTION_PIS		2
+#define LOONGARCH_EXCEPTION_PIF		3
+#define LOONGARCH_EXCEPTION_PME		4
+#define LOONGARCH_EXCEPTION_FPD		15
+#define LOONGARCH_EXCEPTION_SXD		16
+#define LOONGARCH_EXCEPTION_ASXD	17
+#define LOONGARCH_EXCEPTION_GSPR	22
+#define  LOONGARCH_EXCEPTION_CPUCFG	100
+#define  LOONGARCH_EXCEPTION_CSR	101
+#define  LOONGARCH_EXCEPTION_IOCSR	102
+#define  LOONGARCH_EXCEPTION_IDLE	103
+#define  LOONGARCH_EXCEPTION_OTHERS	104
+#define LOONGARCH_EXCEPTION_HVC		23
+
+#define loongarch_exception_type				\
+	{LOONGARCH_EXCEPTION_INT,  "Interrupt" },		\
+	{LOONGARCH_EXCEPTION_PIL,  "Mem read" },		\
+	{LOONGARCH_EXCEPTION_PIS,  "Mem store" },		\
+	{LOONGARCH_EXCEPTION_PIF,  "Ifecth" },			\
+	{LOONGARCH_EXCEPTION_PME,  "Mem modify" },		\
+	{LOONGARCH_EXCEPTION_FPD,  "FPU" },		\
+	{LOONGARCH_EXCEPTION_SXD,  "LSX" },		\
+	{LOONGARCH_EXCEPTION_ASXD, "LASX" },		\
+	{LOONGARCH_EXCEPTION_GSPR, "Privilege Error" },		\
+	{LOONGARCH_EXCEPTION_HVC,  "Hypercall" },		\
+	{LOONGARCH_EXCEPTION_CPUCFG, "Cpucfg" },		\
+	{LOONGARCH_EXCEPTION_CSR,    "Csr" },			\
+	{LOONGARCH_EXCEPTION_IOCSR,  "Iocsr" },			\
+	{LOONGARCH_EXCEPTION_IDLE,   "Idle" },			\
+	{LOONGARCH_EXCEPTION_OTHERS, "Others" }
+
+
+define_exit_reasons_table(loongarch_exit_reasons, loongarch_exception_type);
+
+const char *vcpu_id_str = "vcpu_id";
+const char *kvm_exit_reason = "reason";
+const char *kvm_entry_trace = "kvm:kvm_enter";
+const char *kvm_reenter_trace = "kvm:kvm_reenter";
+const char *kvm_exit_trace = "kvm:kvm_exit";
+
+const char *kvm_events_tp[] = {
+	"kvm:kvm_enter",
+	"kvm:kvm_reenter",
+	"kvm:kvm_exit",
+	"kvm:kvm_exit_gspr",
+	NULL,
+};
+
+static bool event_end(struct evsel *evsel,
+		struct perf_sample *sample __maybe_unused,
+		struct event_key *key __maybe_unused)
+{
+	/*
+	 * LoongArch kvm is a little different with other architectures
+	 *
+	 * There is kvm:kvm_reenter and kvm:kvm_enter event adjacent with
+	 * kvm:kvm_exit event.
+	 *   kvm:kvm_reenter means returning to guest immediately
+	 *   kvm:kvm_enter   means returning to vmm and then to guest
+	 */
+	return evsel__name_is(evsel, kvm_entry_trace) ||
+		evsel__name_is(evsel, kvm_reenter_trace);
+}
+
+static void event_gspr_get_key(struct evsel *evsel,
+			struct perf_sample *sample,
+			struct event_key *key)
+{
+	unsigned int insn;
+
+	key->key = LOONGARCH_EXCEPTION_OTHERS;
+	insn = evsel__intval(evsel, sample, "inst_word");
+	switch (insn >> 24) {
+	case 0:
+		/* cpucfg inst trap */
+		if ((insn >> 10) == 0x1b)
+			key->key = LOONGARCH_EXCEPTION_CPUCFG;
+		break;
+	case 4:
+		/* csr inst trap */
+		key->key = LOONGARCH_EXCEPTION_CSR;
+		break;
+	case 6:
+		/* iocsr inst trap */
+		if ((insn >> 15) == 0xc90)
+			key->key = LOONGARCH_EXCEPTION_IOCSR;
+		else if ((insn >> 15) == 0xc91)
+			/* idle inst trap */
+			key->key = LOONGARCH_EXCEPTION_IDLE;
+		break;
+	default:
+		key->key = LOONGARCH_EXCEPTION_OTHERS;
+		break;
+	}
+}
+
+static struct child_event_ops child_events[] = {
+	{ .name = "kvm:kvm_exit_gspr",
+	.get_key = event_gspr_get_key },
+	{ NULL, NULL },
+};
+
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = exit_event_begin,
+	.is_end_event = event_end,
+	.child_ops = child_events,
+	.decode_key = exit_event_decode_key,
+	.name = "VM-EXIT"
+};
+
+struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+	{
+		.name	= "vmexit",
+		.ops	= &exit_events,
+	},
+	{ NULL, NULL },
+};
+
+const char * const kvm_skip_events[] = {
+	NULL,
+};
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	kvm->exit_reasons_isa = "loongarch64";
+	kvm->exit_reasons = loongarch_exit_reasons;
+	return 0;
+}

base-commit: f2f80ac809875855ac843f9e5e7480604b5cbff5
-- 
2.39.3


