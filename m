Return-Path: <linux-kernel+bounces-141747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8978A8A22E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B881C22A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFD4437;
	Fri, 12 Apr 2024 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J1y1zYHa"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0C635;
	Fri, 12 Apr 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881072; cv=none; b=TeymST36GxKPudpYV1b5dG6ItMPIf18jJl9eRkgjEKD3dbpMGKyoMVKjAeE8upFxCdFtpDSR05ka9OdMeO/0VbhesWWirJg/FiZ1yL36dVY+4mut3TuDvxYEWR6cKfKgWzOUj/EJsARklWXqm4+aa/NzxWz3FxW/lViyYbJbdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881072; c=relaxed/simple;
	bh=fv6XGHb6Pnhi1qBITnZVPVYufjPcayV7v5fU19yiQ/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KmPAScDn7ED4/ZioRW8Lm6ZkEQjivLAACHmlR7QYHbLExBh+Pd41BQyUIhR5qpvr6Cw/qu9snaNUnl6GsEw58cDFrStgB0nkxGzrPNk8i4hKph55MIYuoFinckcvqPbhf3SqFEOf6OhmcAFJkzJsTEyW/uEtcQM8FgJUDhu7PK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J1y1zYHa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.125])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB65920EC32E;
	Thu, 11 Apr 2024 17:17:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB65920EC32E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712881070;
	bh=SwITDiVDGjFy3sgpbd7fUst/YZztJdWrz5P1Xp8PliE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1y1zYHalt+p0FSBl1FqKBKyTGUXK3M4VFLVLO5wheOrmxQftG+6sWc8eK42fLyIU
	 F0r7lfL56lv1+qeqYtdfsaVTJTGWEmgYeyurv1SNzJ7qcsopEMeuAKpzjQ1LbVIZOX
	 5DKZ96qyI8RJTj8sXl/LfQfDR8TZo6UOBZ+qbD6g=
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
Subject: [RFC PATCH 4/4] perf/x86/core: Add tls dump support
Date: Fri, 12 Apr 2024 00:17:32 +0000
Message-Id: <20240412001732.475-5-beaub@linux.microsoft.com>
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

Now that perf supports TLS dumps, x86-64 can provide the details for how
to get TLS data for user threads.

Enable HAVE_PERF_USER_TLS_DUMP Kconfig only for x86-64. I do not have
access to x86 to validate 32-bit.

Utilize mmap_is_ia32() to determine 32/64 bit threads. Use fsbase for
64-bit and gsbase for 32-bit with appropriate size.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/events/core.c            | 14 ++++++++++++++
 arch/x86/include/asm/perf_event.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4fff6ed46e90..8d46ec8ded0c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -263,6 +263,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PERF_USER_TLS_DUMP		if X86_64
 	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..3f851db4c591 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -41,6 +41,7 @@
 #include <asm/desc.h>
 #include <asm/ldt.h>
 #include <asm/unwind.h>
+#include <asm/elf.h>
 
 #include "perf_event.h"
 
@@ -3002,3 +3003,16 @@ u64 perf_get_hw_event_config(int hw_event)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_get_hw_event_config);
+
+#ifdef CONFIG_X86_64
+void arch_perf_user_tls_pointer(struct perf_tls *tls)
+{
+	if (!mmap_is_ia32()) {
+		tls->base = current->thread.fsbase;
+		tls->size = sizeof(u64);
+	} else {
+		tls->base = current->thread.gsbase;
+		tls->size = sizeof(u32);
+	}
+}
+#endif
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3736b8a46c04..d0f65e572c20 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -628,4 +628,9 @@ static __always_inline void perf_lopwr_cb(bool lopwr_in)
 
 #define arch_perf_out_copy_user copy_from_user_nmi
 
+#ifdef CONFIG_HAVE_PERF_USER_TLS_DUMP
+struct perf_tls;
+extern void arch_perf_user_tls_pointer(struct perf_tls *tls);
+#endif
+
 #endif /* _ASM_X86_PERF_EVENT_H */
-- 
2.34.1


