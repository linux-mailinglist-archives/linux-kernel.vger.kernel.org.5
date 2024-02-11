Return-Path: <linux-kernel+bounces-60998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8E850C35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C741C20F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441872B9C0;
	Sun, 11 Feb 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NWQItVnS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7817BDF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693353; cv=none; b=I5wnkzt6qxGprMv0/6KwkoxR9zdlvsAIzD4QrOhbZZWsTP3BK/1EZ9z1GrY1Rxmw8trXwZP3vV4gG2BDrRjEAagKcPfX4EXa8D7hj037kiSmBvk4Qjshu8nkML3O8sqWaP9NnZwABFLmyNfmDTVKt+INoN7ZuMo9zSu/Vww9kbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693353; c=relaxed/simple;
	bh=TbG+/HcM8WovU8Lw/yGM7zI7b8AZCr+y1GKAEztebFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TF9LxCxgo5XyBESLUCx3htOynRhUNGjSmp247tbWjYhNj78Qqq95U6tqGC92SC55vM7RFMY9W+njFRRsv7k7LnZ0XnkpnSHYYdlefY44DO1zm51dEjjqEeCxjq8AAQDFeJLCR3zx1EFW1nhstyfKDf9//cKIvrcGdeDgFpbpf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NWQItVnS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116ec49365so2887095e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693348; x=1708298148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G421tyom6sWcG+XY6TfN5lZaMdP8BvN/8TI1sJrx5Q=;
        b=NWQItVnSvzhJijZf5fTGqe0hnUTPU0Di+k1hFgLDvtsnQ6rjwjF1nn/7nBjGzsjLmm
         eBYmRVAdR71fqSnmu776AkG/8615qObWq1ENXdVgYhurH1JugCnp2Ng3zCYd4ppxVNoa
         x9rOS/j69YkcfSAQMZyIdyOigrQb5IloNtVl7iC/8LmqnostFlmqzhWZl+iznnzMv4Rg
         nMyPwTz1nzTsqGiSZqCSAgxdfQIRzhB/ScMHH0/ARgMzJOOmw28386i/h/diCnhy6/Ji
         7o1IKRiYdaML2i40Agt1cc2kKodlvfBc9+1t97fFpabK+324iSnNCzpCV2Ofgu7Fuexi
         GNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693348; x=1708298148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G421tyom6sWcG+XY6TfN5lZaMdP8BvN/8TI1sJrx5Q=;
        b=TAFDEzpaRVbRN6aOqpWDtycGsLTFCK9+pQEWvlo/tAIQvyxIHq5HuhX6Yna9LwNUE8
         MiAU9aeWzTW2b5lcN5kpoL1AdLDXnjrcJ/cOP87l4pHsUOo6ErClG4GNIvDO0hAjpVhU
         44qrHHk88BCHPVdPPozZ99fw+ra913Wwx9SNt1ToZQhRou8hmmVGaiv7tw4uTTM2zrpS
         FngM72C/U7KljvQH6kKIDU/arvvjYPg+aTMX8A/zZnkBxLQY1TamYrFIAsrcqmt7ik9T
         Hby8rY5jKTrjUgT/2CYxkSWPRm+A5EOqFDiV6Ou8DamOagf734PU+E+ryAGDStmCB66l
         8FtQ==
X-Gm-Message-State: AOJu0Yyh6xKA2Jn6lzZv1L2jUkhmbNFTafAYHIHA2LZ8ylgVnAXTvfW5
	eNb4ZdDhBb63/he/w85iuYfbE60VLc3dwUmXDkhAhRj2ghsoLUOzfzxYQxz+ieWPHhj1xdvNDAX
	f
X-Google-Smtp-Source: AGHT+IEBGwAqcxYaRRzPkRWV+YK4IFKdR5QatmrYOTgXLB3jAC7XGQ+Yl0V1Ng1xNTxBIBUMAqPI3g==
X-Received: by 2002:ac2:485b:0:b0:511:5ef9:ebb0 with SMTP id 27-20020ac2485b000000b005115ef9ebb0mr2920185lfy.25.1707693343328;
        Sun, 11 Feb 2024 15:15:43 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 10/35] uprobes.h: move declarations to uprobes_types.h
Date: Mon, 12 Feb 2024 00:14:53 +0100
Message-Id: <20240211231518.349442-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/kernel/signal.c    |  1 +
 include/linux/mm_types.h      |  2 +-
 include/linux/uprobes.h       | 10 +---------
 include/linux/uprobes_types.h | 25 +++++++++++++++++++++++++
 kernel/entry/common.c         |  1 +
 kernel/trace/bpf_trace.c      |  1 +
 mm/memory.c                   |  1 +
 7 files changed, 31 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/uprobes_types.h

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0e8beb3349ea..8990975d0c37 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -14,6 +14,7 @@
 #include <linux/freezer.h>
 #include <linux/stddef.h>
 #include <linux/uaccess.h>
+#include <linux/uprobes.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/resume_user_mode.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ed764511bc23..54caee378e77 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -14,7 +14,7 @@
 #include <linux/maple_tree_types.h>
 #include <linux/rwsem_types.h>
 #include <linux/cpumask.h>
-#include <linux/uprobes.h>
+#include <linux/uprobes_types.h>
 #include <linux/rcupdate.h>
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue_types.h>
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a76155cf8ceb..6ab950cce8a9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -11,6 +11,7 @@
  * Copyright (C) 2011-2012 Red Hat, Inc., Peter Zijlstra
  */
 
+#include <linux/uprobes_types.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 
@@ -94,12 +95,6 @@ enum rp_check {
 	RP_CHECK_RET,
 };
 
-struct xol_area;
-
-struct uprobes_state {
-	struct xol_area		*xol_area;
-};
-
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
@@ -137,9 +132,6 @@ extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
 #else /* !CONFIG_UPROBES */
-struct uprobes_state {
-};
-
 static inline void uprobes_init(void)
 {
 }
diff --git a/include/linux/uprobes_types.h b/include/linux/uprobes_types.h
new file mode 100644
index 000000000000..0ce0fe3801ea
--- /dev/null
+++ b/include/linux/uprobes_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_UPROBES_TYPES_H
+#define _LINUX_UPROBES_TYPES_H
+/*
+ * User-space Probes (UProbes)
+ *
+ * Copyright (C) IBM Corporation, 2008-2012
+ * Authors:
+ *	Srikar Dronamraju
+ *	Jim Keniston
+ * Copyright (C) 2011-2012 Red Hat, Inc., Peter Zijlstra
+ */
+
+#ifdef CONFIG_UPROBES
+
+struct xol_area;
+
+struct uprobes_state {
+	struct xol_area		*xol_area;
+};
+#else /* !CONFIG_UPROBES */
+struct uprobes_state {
+};
+#endif /* !CONFIG_UPROBES */
+#endif	/* _LINUX_UPROBES_TYPES_H */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 88cb3c88aaa5..364ea38c868e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -9,6 +9,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/uprobes.h>
 
 #include "common.h"
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..e74430389877 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -11,6 +11,7 @@
 #include <linux/btf.h>
 #include <linux/filter.h>
 #include <linux/uaccess.h>
+#include <linux/uprobes.h>
 #include <linux/ctype.h>
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
diff --git a/mm/memory.c b/mm/memory.c
index 7c3ca41a7610..68abe5dccb5b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -70,6 +70,7 @@
 #include <linux/string.h>
 #include <linux/memory-tiers.h>
 #include <linux/debugfs.h>
+#include <linux/uprobes.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/dax.h>
 #include <linux/oom.h>
-- 
2.39.2


