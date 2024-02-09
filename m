Return-Path: <linux-kernel+bounces-59628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E484F9C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD261F261C1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B637E770;
	Fri,  9 Feb 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="euNl0Jo4"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3117BB08
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496859; cv=none; b=oMOYoHWEnJOrrKZZL9co5+kCPoxiFsYNAvc85b3RAgcBRpdmlm2hfZtVlQYOVjZ/tfRIxJkrHPerwW3giwVbHDg2dxDDXny9aKf5wSTTmxHiw1gg/Q5iPAcBPgjav7Ey98XQDQu2jiCXKKur0JKkyxnRV7Sf/xwnW9A4DWf1zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496859; c=relaxed/simple;
	bh=TbG+/HcM8WovU8Lw/yGM7zI7b8AZCr+y1GKAEztebFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNdy6kAbfejbfSSVw2IOaaFIXcp1Bx5zjBR9ZakV2sqbDG+uG1ir5KAL58mI+9mIqz9Ku26EuNHcBH+JUyoXtP+a/qHcC9Gwhfuvkq3Mp1rCvTI78xnlYAd1z+sRh5ZlLUvU9rQPFKVp0Z/UwztwstpPBkt6DU4iDb5ffZPwSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=euNl0Jo4; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so15802481fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496855; x=1708101655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G421tyom6sWcG+XY6TfN5lZaMdP8BvN/8TI1sJrx5Q=;
        b=euNl0Jo40ozoUCp0+RdyrZsGQlvmWUv/tKK0s/bLpHeWq0Sp0aeyAhh+Fd2Qn/GUJQ
         Og3zVb9FFc3xuyVQGU/xSkrOXJ7R0tl/D98dnvGMT3HHLsIBnypx+ke4KEXIlvNsL8Ff
         36zUhLBd2Lccea9WRbvlMRVlLsWmCpu/AFCWJAjqvBvU8fv34MrMD2YZ/TEY2FbOhUvx
         HFV47bgEZmd4J+mvYjEMtutHRtvN2FwITLdF7A/74xMJmdLr1raw/Ah6+hKtzj/cKjf0
         +QmKSNT+MOA6upt/nt4zT/EuO5HZnotcmLiJnCszjmpd6GN7i9aBnkZsn5xtCnWlxTcq
         QAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496855; x=1708101655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G421tyom6sWcG+XY6TfN5lZaMdP8BvN/8TI1sJrx5Q=;
        b=wAWm0LPUqNbmaxoUDydGvS84rmNmZD70fta5n9uvH+kn//WNeHSLpNNVkNI1aIKLeF
         cQg9pkXJdSgguLvuwZ60iU8P//4x8Sx/UQxXdOVtGLgvSFxKAEu9HEkNpITzraOQpNor
         M1ypnj8F4hj3wi8OKyUZpUE2POfw6SJ6HUuVpQEV6k0H71PrOcWLRJdn/7nKeXlvdyCN
         aAe5R11tnF6ldrNraYMSfBPa0ygfpzMTXLl60IWuC2e9w+WcPZq+iJ2RsEiyk/jCDIV0
         NBykMg8MpjCFZR/EXAdaVEn01jJgALBkFeg0dfaxrm6+XmJRD04RWsIE8fIM6kGC+kDp
         8oDA==
X-Gm-Message-State: AOJu0YwmRy/arD99TGE1z+MKTBUS8CPWSJSg1NDHyZvI5PHoNfwMwhRA
	go43KaZhYnDL1ad+s9noxxgZcj/+/ZwRETisPdTGXk/1fC8PqEDK+uHW0Tf4k7aEqIADjjBD4F6
	X
X-Google-Smtp-Source: AGHT+IFg76oiwZZS8B2gWVgVut3tsMUVLmOc1JO20K7EvFVmhs8CCSLdI+/3PlF+MtTSMw97U/vlnw==
X-Received: by 2002:a2e:a70e:0:b0:2cc:c6e0:fbb with SMTP id s14-20020a2ea70e000000b002ccc6e00fbbmr1505970lje.20.1707496854729;
        Fri, 09 Feb 2024 08:40:54 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:53 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 10/35] uprobes.h: move declarations to uprobes_types.h
Date: Fri,  9 Feb 2024 17:40:02 +0100
Message-Id: <20240209164027.2582906-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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


