Return-Path: <linux-kernel+bounces-61468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA088512B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCC41C2315A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B086C39FEF;
	Mon, 12 Feb 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JxVqIPVY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E5A39FCC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738926; cv=none; b=Cl53nD5csR2hr0Sxt8P0xUXJw4yvod27aGW6eJXAhNRjz4WwoKOIf0dGieRcjIB7cb9FW7P7ta5dGdd+KFz6m3o+gJ2Svi/iIsl67vLSdo71JECzjiruvtvAftVf6oPMWZDRZMdGS/qFEPpdsP5aEBVN6dhlGzbejkwHOMkajEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738926; c=relaxed/simple;
	bh=dOlTuXKsYcsEMhZKV2ceENM9VxEjCmjj6RlMrSCfXDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ggok+kcvGHN9Gxc19GmmmqrQ9/9tpr9TWECcMhg4MCuw2jBTfHMLa9dhuz1JpE2Z3Pbq2cvPUYNRexft1aBiAPsr1PU7Hza6+v0KsglSQITX4vuxoNM1v3HSeNC3C2/g7eAST/7zt3oFFFE9/BuG9SThbNVdWgZqtk6N1g/jAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JxVqIPVY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4016122a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738922; x=1708343722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVvOwBrSuMtITWpqoDUBeLSYkEYOwFFiivjQgOkA3M0=;
        b=JxVqIPVYAqpg/J8kR/i67x4jI4LXhQo3QMRSeVI3WzMAbQdtn6MvjeBe4YD0p3yPNR
         AqFkfVCLfQq190+YCJ5DsC725lp0DhP9Iqql/rKidplAe/mZ6eO2izD45svYUmUzjxDt
         vQ4RC2/Kj971uVdnAjV3jUhyq3HtIrSOY4nfdeLG0SV+dZCO/h+1eBuOnYzQ6XsNg/xS
         gX7JosUfGJsvAPeurcNYohJxoM4JxiTdDY1ZAr4DVSFrB1ndxk9WeZ5spxJzqv9JyyGe
         cTZoGuNv3WRuBCMk2IQMvBQ0MmwkV5a0vvKerOlnbEhYi3DNkDwrHPiHm2Kf1qTlJ8iG
         K1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738922; x=1708343722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVvOwBrSuMtITWpqoDUBeLSYkEYOwFFiivjQgOkA3M0=;
        b=jho7Ke9/XeFn675Bf+uKilXgv8U8btmPuec3B5gYV+bAGXWH6ls1cDr5odVeWWoldN
         FD4XCg/kiAUtLu93Cb+GDiDkboddJMf5UTusNyEOol3GajAIV8BHtbYW2f5bjOb6GakT
         q9Svc9tvMrfO7GCw3GTmpfsZkXUH8SbDPBIa/H1Op0bSEOKQAMdVu+NjMDGXqwxztXyW
         9aLStQOGuLkzkVu6c8qn275gR+wVh17su16LFnr5Q+jgmSKpKsvUZzud+Ez9BilEP8LS
         Yf/yARWsg1J7YdPvPIE+7jjMlCDC36DbLxzIbKcXzjWvLpARnMR/v03AHuPG9SWJhdAC
         Hr1w==
X-Gm-Message-State: AOJu0Yzif71lYDgai48mQy39y9OJ0+Jh3VR7dLJwbW2Ov2pi5/PqY4cb
	GneX5cQksg+xUOhVqoAK4AjXe4R02Nl3SnSNU1GEGvPGTFZYknNilEA7dQHkrLl7rUU/cJNr9uJ
	Z
X-Google-Smtp-Source: AGHT+IF2ixGq9KnH7zOquRoPKoSh5QSQYG+1VLcM/K56cdsMifWfUmgwq/xiRMTVq8xQ+lH1pSGmBg==
X-Received: by 2002:a17:906:fc01:b0:a38:3693:aea1 with SMTP id ov1-20020a170906fc0100b00a383693aea1mr4118831ejb.52.1707738922297;
        Mon, 12 Feb 2024 03:55:22 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:21 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 10/35] uprobes.h: move declarations to uprobes_types.h
Date: Mon, 12 Feb 2024 12:54:35 +0100
Message-Id: <20240212115500.2078463-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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
index 425b1bc17a3f..e54be587723d 100644
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


