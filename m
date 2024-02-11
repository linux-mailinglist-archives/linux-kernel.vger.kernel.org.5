Return-Path: <linux-kernel+bounces-60738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7EF850904
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D960281E46
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623581E480;
	Sun, 11 Feb 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LgKjrBJr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7310A16
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654629; cv=none; b=D0n8zK11YaOpYtML3WoTh4Hbqs7KsVx33FJzwpbOT+LKmdXntnVY+UT8EQ14S0Dtqhv6dRNf1jbO+MRfYKs+4zjIEwf3VgckaSyEDf4jbuHxIQmFBoHZlaOAYW4mciZ+SJABMnXCusvOBWbEDPbZXvagcCdrNEWvm8ASTcg5sZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654629; c=relaxed/simple;
	bh=TbG+/HcM8WovU8Lw/yGM7zI7b8AZCr+y1GKAEztebFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oOCguLUX3/xefeDQ0bNIyEmd8X39rhLDqcJPZEKXWNL4A4Oz8NwyJ/NVJQqszXG1iDBAmVmcmqVxPxBSzL3W/pn4hs/pW+3XEpSAFVVTIrDOYFqDyx4U3aI4EPAMUSFnxOJT7hxhT72pI1/UFfEqdAswkHxc1l0t91+xCJusGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LgKjrBJr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so2845876e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654623; x=1708259423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G421tyom6sWcG+XY6TfN5lZaMdP8BvN/8TI1sJrx5Q=;
        b=LgKjrBJrR+bBFSa5H56ppQCfLwpr0jsHkjpsmCkyri2co3w6apjihBDFYChMTi/ZYW
         owPs0MHIj0YWDftfGOHxB6I9Le4FrMNBF7j6VDNDgtS/pShqoBeMt1BGZMjc04Whkkm0
         la5JdKTMzhp+zvzwy87OCqgjrZZwtL7JcJ6E1vNZ9KsJczbOBbcF5es57ogYhMGGs37i
         MdDTTEP8nV9PTFxgYr3sErQVB6GelctT1AmAIBKitJehXg2+8IlxfF0eTCZlCM/tbj5/
         0Osdxh6cThfIXnGQWOo3ZdJP4/JAE/wy3foBP2p34HFGsQYbKNKlpKbHVMvTLeE/8rp0
         lpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654623; x=1708259423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G421tyom6sWcG+XY6TfN5lZaMdP8BvN/8TI1sJrx5Q=;
        b=gJXXxFSfvirgTkLv41moxK66gQiarLZXZgYxqywCxAN7J1GN0soQjnrZ2qdtWH9Y/i
         CbYJic3d1Zu9wv6F+HBIBm1Ve6BAov+IeUs5Q8J9JpvrTXxq7rjn7ZuHHBEni33cKH4T
         hEN9fVy1DDnast4iCTnAStICDdJ4kq3vZTmuXDSTsK+NdYIUMd8jBZ0Lec/TycQGIZJZ
         eVXgPqbHeFoQZrpUKhOcH/A5QVdSAX0gZUYtgamKZQtKGfOyopxlknE89FnUGY95dCIt
         ZU1bwQV+kOpoJbashE22mSPrit5mUzmgwtDymwA1ez50YpdkiynDV7buVWw9LEzfHFqF
         LVFQ==
X-Gm-Message-State: AOJu0YwUxy5+80/tjVvjEvG4lP9gv0qGBvKW29FyMAW24+92H3DuYWn8
	xFj3myDGM50f5iTxcnxCo2Z+0eiUcspv6Uy5Iv89N26XomsStZGmQKgdSVct6ZV2Fb2eaSPhP8J
	e
X-Google-Smtp-Source: AGHT+IH+5LoU8yCeQ85GyACNTji8Q495k/bFQ8EsDoWxyMyuVVu/g5edxybJ0x3Oig5ZFrpcJ4VdKQ==
X-Received: by 2002:a05:6512:1091:b0:510:206b:e94a with SMTP id j17-20020a056512109100b00510206be94amr3310216lfg.53.1707654623554;
        Sun, 11 Feb 2024 04:30:23 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:23 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 10/35] uprobes.h: move declarations to uprobes_types.h
Date: Sun, 11 Feb 2024 13:29:35 +0100
Message-Id: <20240211123000.3359365-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
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


