Return-Path: <linux-kernel+bounces-127574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B646E894DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DCC1C21032
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA31481BF;
	Tue,  2 Apr 2024 08:44:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331A3FB14;
	Tue,  2 Apr 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047456; cv=none; b=EKlmClSB9g58b6FqVqvlZgxZvWm+ToLownvJvZECQuWaBkjffmiC5W/bkrXOHRg4DTOvUApHXZqYBHkJMqxkv2yuaETF/zW4zJHo4x+A4Rl8hpa+6BTBgm71Y7C+5WKZ0Uyn5gIGUKPAzEeb2sMTDc1spjQK5prbYd7h9ATx3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047456; c=relaxed/simple;
	bh=2QS9C22Nsp15QOTHapTYNst3qyOy0U2BUE2u6hPUunw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQ5y8P7ZY9UQARBnG1B8kwN/sd2GUYA88FM1kT0lfHmMeSu7+fkjwDFIJJdQE2u0CboI+eoNqsA5tAXOD47TFhjGfcTRv1TYJgteBliD9zOii0DFrObT4Xobpd99DZUTt22Y3vkitgVkdvNarGorW0kY+bkUXUPDSAAK8vOZ1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxvutRxQtmXEIiAA--.13043S3;
	Tue, 02 Apr 2024 16:44:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLBNOxQtmGa9xAA--.23906S2;
	Tue, 02 Apr 2024 16:43:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Ming Wang <wangming01@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf kvm: Add kvm-stat for loongarch64
Date: Tue,  2 Apr 2024 16:43:58 +0800
Message-Id: <20240402084358.205003-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxLBNOxQtmGa9xAA--.23906S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add support for 'perf kvm stat' on loongarch64 platform, now only
kvm exit event is supported.

Here is example output about "perf kvm --host stat report" command

       Event name   Samples   Sample%    Time (ns)   Time%  Mean Time (ns)
     Memory store     73427    50.00%    630743820  10.00%            8590
      Memory read     36110    24.00%    109129170   1.00%            3022
  Privilege Error     18921    12.00%   5231868450  87.00%          276511
        Interrupt     10214     6.00%     13674060   0.00%            1338
        Hypercall      5043     3.00%     14121450   0.00%            2800
      FP Disabled      1850     1.00%      2798020   0.00%            1512
           Ifecth       813     0.00%      2035340   0.00%            2503
    Memory modify       362     0.00%       633070   0.00%            1748
    LASX Disabled         3     0.00%         5440   0.00%            1813
     LSX Disabled         2     0.00%         2670   0.00%            1335

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/perf/arch/loongarch/Makefile        |  1 +
 tools/perf/arch/loongarch/util/Build      |  2 +
 tools/perf/arch/loongarch/util/header.c   | 85 ++++++++++++++++++++
 tools/perf/arch/loongarch/util/kvm-stat.c | 98 +++++++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 tools/perf/arch/loongarch/util/header.c
 create mode 100644 tools/perf/arch/loongarch/util/kvm-stat.c

diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index c392e7af4743..c8be64c5cdb4 100644
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
index 000000000000..c69ab40e3ba6
--- /dev/null
+++ b/tools/perf/arch/loongarch/util/kvm-stat.c
@@ -0,0 +1,98 @@
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
+#define LOONGARCH_EXCEPTION_PNR		5
+#define LOONGARCH_EXCEPTION_PNX		6
+#define LOONGARCH_EXCEPTION_PPI		7
+#define LOONGARCH_EXCEPTION_FPD		15
+#define LOONGARCH_EXCEPTION_SXD		16
+#define LOONGARCH_EXCEPTION_ASXD	17
+#define LOONGARCH_EXCEPTION_GSPR	22
+#define LOONGARCH_EXCEPTION_HVC		23
+#define LOONGARCH_EXCEPTION_GCM		24
+
+#define loongarch_exception_type				\
+	{LOONGARCH_EXCEPTION_INT,  "Interrupt" },		\
+	{LOONGARCH_EXCEPTION_PIL,  "Memory read" },		\
+	{LOONGARCH_EXCEPTION_PIS,  "Memory store" },		\
+	{LOONGARCH_EXCEPTION_PIF,  "Ifecth" },			\
+	{LOONGARCH_EXCEPTION_PME,  "Memory modify" },		\
+	{LOONGARCH_EXCEPTION_PNR,  "Memory NR" },		\
+	{LOONGARCH_EXCEPTION_PNX,  "Memory NX" },		\
+	{LOONGARCH_EXCEPTION_PPI,  "Memory Privilege" },	\
+	{LOONGARCH_EXCEPTION_FPD,  "FP Disabled" },		\
+	{LOONGARCH_EXCEPTION_SXD,  "LSX Disabled" },		\
+	{LOONGARCH_EXCEPTION_ASXD, "LASX Disabled" },		\
+	{LOONGARCH_EXCEPTION_GSPR, "Privilege Error" },		\
+	{LOONGARCH_EXCEPTION_HVC,  "Hypercall" },		\
+	{LOONGARCH_EXCEPTION_GCM,  "CSR modified" }
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
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = exit_event_begin,
+	.is_end_event = event_end,
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
-- 
2.33.0


