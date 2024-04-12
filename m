Return-Path: <linux-kernel+bounces-141749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA5F8A22E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E70A1F235B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9BF505;
	Fri, 12 Apr 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ddlglKL+"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FF360;
	Fri, 12 Apr 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881073; cv=none; b=PCBdLsUqbvn266RED+NtjxY0n7Invcas8sB7/Fsu0iufKLKTvNxTbsX0PW4hSJP9fyL7i9/3tBxjabAAoMsjhmyy/17TUZ+6PYv+uCa/i9NePi2IbRfKCXqddf9PpJaQMkfi45rzNn51K+dbxDyv0QCJsSSuHsUsQ32wQN/C+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881073; c=relaxed/simple;
	bh=xj6QGik4xvsN4lQj/YHP4pSr4CLFuW5i5RgEQz//Dw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNDSycgUuKE+HPokBPUGpbH/R887E1Yw5tWC4NVbONwjZFCM673Eh0C1g8L7+Hyxj+/XlRV4soge8IR1kCeOrlUMislPz/JRBAofUFFfGgwgKvv9/tmZ7RGTO3IcBkffXK5Sqr9PbaiHeADw3aDvZlb50RSvTz+AIbHk48O9ZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ddlglKL+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.125])
	by linux.microsoft.com (Postfix) with ESMTPSA id 715BA20EC327;
	Thu, 11 Apr 2024 17:17:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 715BA20EC327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712881070;
	bh=eaw3h+lPrjxdh5uerWDCtaQEhq8uGqBARjhEDVRDDbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddlglKL+mK3nW5AG9GRMnLlhSlx6QEDk+w8xDhRnmmbAADOfnyFJQOkAooA3UJyvZ
	 kSB6XMtc7zEAhVPoP+1Yha/hP09gMN5n7jqika65Cgi79T/vIKnfvt6AZw/Nghn2HW
	 WALVmt3n5eEHbTX5ZLKQ67/wnJPWIlW1n8Uz4T1Q=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	primiano@google.com,
	aahringo@redhat.com,
	dcook@linux.microsoft.com
Subject: [RFC PATCH 2/4] perf: Introduce PERF_SAMPLE_TLS_USER sample type
Date: Fri, 12 Apr 2024 00:17:30 +0000
Message-Id: <20240412001732.475-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412001732.475-1-beaub@linux.microsoft.com>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When samples are generated, there is no way via the perf_event ABI to
fetch per-thread data. This data is very useful in tracing scenarios
that involve correlation IDs, such as OpenTelemetry. They are also
useful for tracking per-thread performance details directly within a
cooperating user process.

The newly establish OpenTelemetry profiling group requires a way to get
tracing correlations on both Linux and Windows. On Windows this
correlation is on a per-thread basis directly via ETW. On Linux we need
a fast mechanism to store these details and TLS seems like the best
option, see links for more details.

Add a new sample type (PERF_SAMPLE_TLS_USER) that fetches TLS data up to
X bytes per-sample. Use the existing PERF_SAMPLE_STACK_USER ABI for
outputting data out to consumers. Store requested data size by the user
in the previously reserved u16 (__reserved_2) within perf_event_attr.

Add tls_addr and tls_user_size to perf_sample_data and calculate them
during sample preparation. This allows the output side to know if
truncation is going to occur and not having to re-fetch the TLS value
from the user process a second time.

Add CONFIG_HAVE_PERF_USER_TLS_DUMP so that architectures can specify if
they have a TLS specific register (or other logic) that can be used for
dumping. This does not yet enable any architecture to do TLS dump, it
simply makes it possible by allowing a arch defined method named
arch_perf_user_tls_pointer().

Add perf_tls struct that arch_perf_user_tls_pointer() utilizes to set
TLS details of the address and size (for 32bit on 64bit compat cases).

Link: https://opentelemetry.io/blog/2024/profiling/
Link: https://www.elastic.co/blog/continuous-profiling-distributed-tracing-correlation
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 arch/Kconfig                    |   7 +++
 include/linux/perf_event.h      |   7 +++
 include/uapi/linux/perf_event.h |   5 +-
 kernel/events/core.c            | 105 +++++++++++++++++++++++++++++++-
 kernel/events/internal.h        |  16 +++++
 5 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71..6afaf5f46e2f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -430,6 +430,13 @@ config HAVE_PERF_USER_STACK_DUMP
 	  access to the user stack pointer which is not unified across
 	  architectures.
 
+config HAVE_PERF_USER_TLS_DUMP
+	bool
+	help
+	  Support user tls dumps for perf event samples. This needs
+	  access to the user tls pointer which is not unified across
+	  architectures.
+
 config HAVE_ARCH_JUMP_LABEL
 	bool
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..7fac81929eed 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1202,8 +1202,15 @@ struct perf_sample_data {
 	u64				data_page_size;
 	u64				code_page_size;
 	u64				aux_size;
+	u64				tls_addr;
+	u64				tls_user_size;
 } ____cacheline_aligned;
 
+struct perf_tls {
+	unsigned long base; /* Base address for TLS */
+	unsigned long size; /* Size of base address */
+};
+
 /* default value for data source */
 #define PERF_MEM_NA (PERF_MEM_S(OP, NA)   |\
 		    PERF_MEM_S(LVL, NA)   |\
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..b62669cfe581 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -162,8 +162,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_TLS_USER			= 1U << 25,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 26,		/* non-ABI */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
@@ -509,7 +510,7 @@ struct perf_event_attr {
 	 */
 	__u32	aux_watermark;
 	__u16	sample_max_stack;
-	__u16	__reserved_2;
+	__u16	sample_tls_user; /* Size of TLS data to dump on samples */
 	__u32	aux_sample_size;
 	__u32	__reserved_3;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 07de5cc2aa25..f848bf4be9bd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6926,6 +6926,45 @@ static u64 perf_ustack_task_size(struct pt_regs *regs)
 	return TASK_SIZE - addr;
 }
 
+/*
+ * Get remaining task size from user tls pointer.
+ *
+ * Outputs the address to use for the dump to avoid doing
+ * this twice (prepare and output).
+ */
+static u64
+perf_utls_task_size(struct pt_regs *regs, u64 dump_size, u64 *tls_addr)
+{
+	struct perf_tls tls;
+	unsigned long addr;
+
+	*tls_addr = 0;
+
+	/* No regs, no tls pointer, no dump. */
+	if (!regs)
+		return 0;
+
+	perf_user_tls_pointer(&tls);
+
+	if (WARN_ONCE(tls.size > sizeof(addr), "perf: Bad TLS size.\n"))
+		return 0;
+
+	addr = 0;
+	arch_perf_out_copy_user(&addr, (void *)tls.base, tls.size);
+
+	if (addr < dump_size)
+		return 0;
+
+	addr -= dump_size;
+
+	if (!addr || addr >= TASK_SIZE)
+		return 0;
+
+	*tls_addr = addr;
+
+	return TASK_SIZE - addr;
+}
+
 static u16
 perf_sample_dump_size(u16 dump_size, u16 header_size, u64 task_size)
 {
@@ -6997,6 +7036,43 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 	}
 }
 
+static void
+perf_output_sample_utls(struct perf_output_handle *handle, u64 addr,
+			u64 dump_size, struct pt_regs *regs)
+{
+	/* Case of a kernel thread, nothing to dump */
+	if (!regs) {
+		u64 size = 0;
+		perf_output_put(handle, size);
+	} else {
+		unsigned int rem;
+		u64 dyn_size;
+
+		/*
+		 * We dump:
+		 * static size
+		 *   - the size requested by user or the best one we can fit
+		 *     in to the sample max size
+		 * data
+		 *   - user tls dump data
+		 * dynamic size
+		 *   - the actual dumped size
+		 */
+
+		/* Static size. */
+		perf_output_put(handle, dump_size);
+
+		/* Data. */
+		rem = __output_copy_user(handle, (void *)addr, dump_size);
+		dyn_size = dump_size - rem;
+
+		perf_output_skip(handle, rem);
+
+		/* Dynamic size. */
+		perf_output_put(handle, dyn_size);
+	}
+}
+
 static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 					  struct perf_sample_data *data,
 					  size_t size)
@@ -7474,6 +7550,13 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
 		perf_output_put(handle, data->code_page_size);
 
+	if (sample_type & PERF_SAMPLE_TLS_USER) {
+		perf_output_sample_utls(handle,
+					data->tls_addr,
+					data->tls_user_size,
+					data->regs_user.regs);
+	}
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -7759,6 +7842,19 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->sample_flags |= PERF_SAMPLE_STACK_USER;
 	}
 
+	if (filtered_sample_type & PERF_SAMPLE_TLS_USER) {
+		u16 tls_size = event->attr.sample_tls_user;
+		u64 task_size = perf_utls_task_size(data->regs_user.regs,
+						    tls_size,
+						    &data->tls_addr);
+
+		tls_size = perf_prepare_dump_data(data, event, regs,
+						  tls_size, task_size);
+
+		data->tls_user_size = tls_size;
+		data->sample_flags |= PERF_SAMPLE_TLS_USER;
+	}
+
 	if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		data->weight.full = 0;
 		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
@@ -12159,7 +12255,7 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 
 	attr->size = size;
 
-	if (attr->__reserved_1 || attr->__reserved_2 || attr->__reserved_3)
+	if (attr->__reserved_1 || attr->__reserved_3)
 		return -EINVAL;
 
 	if (attr->sample_type & ~(PERF_SAMPLE_MAX-1))
@@ -12225,6 +12321,13 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			return -EINVAL;
 	}
 
+	if (attr->sample_type & PERF_SAMPLE_TLS_USER) {
+		if (!arch_perf_have_user_tls_dump())
+			return -ENOSYS;
+		else if (!IS_ALIGNED(attr->sample_tls_user, sizeof(u64)))
+			return -EINVAL;
+	}
+
 	if (!attr->sample_max_stack)
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c03..b42747b1eb04 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -243,4 +243,20 @@ static inline bool arch_perf_have_user_stack_dump(void)
 #define perf_user_stack_pointer(regs) 0
 #endif /* CONFIG_HAVE_PERF_USER_STACK_DUMP */
 
+#ifdef CONFIG_HAVE_PERF_USER_TLS_DUMP
+static inline bool arch_perf_have_user_tls_dump(void)
+{
+	return true;
+}
+
+#define perf_user_tls_pointer(tls) arch_perf_user_tls_pointer(tls)
+#else
+static inline bool arch_perf_have_user_tls_dump(void)
+{
+	return false;
+}
+
+#define perf_user_tls_pointer(tls) memset(tls, 0, sizeof(*tls))
+#endif /* CONFIG_HAVE_PERF_USER_TLS_DUMP */
+
 #endif /* _KERNEL_EVENTS_INTERNAL_H */
-- 
2.34.1


