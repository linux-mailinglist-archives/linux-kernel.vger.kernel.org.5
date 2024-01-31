Return-Path: <linux-kernel+bounces-46640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83D844243
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC118B24CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4112BF28;
	Wed, 31 Jan 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WXJUOs9v"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971412BEB5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712628; cv=none; b=RRiA0KNu7OZqO5xfK7rEH8VZY04sTNVHYFf4qDcZVUgl4e0rzMnciGst1vqNTiQ7bwcRHHgSDxS8VvPD3lpJi6NuIiVNYyoxd3wjYgDR0oTg6PWGJyRLWSjV/E+0+7XfQY3OwYyN0F74HvVB1UDCT3dpjmRN/vdbMSVBb9NDtP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712628; c=relaxed/simple;
	bh=40oREuaDf793HSspmnNkgOQBM5rh0Q0gFSvvbPlKexI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LuKh/5vl9/f1aARKaitSr0LRJ7KwMg+hMTwhQuF12PRZdZWPK2bPubFy9k9f7pA/LjE0TTLFZdappS5CCSUiupczIGNcV9jWJa/+6H0qu5ZfCDooY9yuEIod9IZLtVKyAXbUbY5slSmw76agfWskM8/ldFGQsdWu/yhgfq91gCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WXJUOs9v; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so74692f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712624; x=1707317424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdyQr9oywwiCwCzVLHztAq9kauvS19ksjDmdRLsKvAE=;
        b=WXJUOs9vA7i+Fgy2IreqqwfWOJHCkBlT0dRIZQHicELyf/b4gZytimmCXKBeaEXsFy
         VaiRJ/Z68M4dbDNlAqWhCLi4rS9TKGylF0QYthSXKdhsRhnli75Ps7fzX1ikpRScCbSB
         iQLMwTaD6Z/H0VgT6acpO7LNM0vEdmqA1bWntqM8rmxNwOtPZ7hDFgqd8a33bGYJPB+r
         bwx1kuMhSqO5ln+86FssyYn4MkN4UkyjbezXKeW7Y1hCeLgkQ9hEyol79Q5+8frpBkq6
         Af1+XrtsQAtTyI6BktgNTUhE2B6TIV3TVhz49KgoqPWtpSTTF6KR4IPI6RKnNPMralw0
         BYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712624; x=1707317424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdyQr9oywwiCwCzVLHztAq9kauvS19ksjDmdRLsKvAE=;
        b=L4brDH/UI14zeO97MVyLtBj7kldmZ0oydfX4JAFo+8Ipqq7WisWQL3cMk1Vqfyq8Vi
         H/0mUCd9NBRL+OVUYNnjSR1GyTR8XcDeGDqNSsrtzp4uTMA+sIGRG8Y12as/xDtgwN9P
         Tw6WrRagcfE4156b0d0y+oJdgDxIo/koGdMnlfL1ObNu51ZeEfiibxqmu2RUDWYE+Y2a
         alPIJWMRHL4BOxH3O9sqYf2Zh+QvdbBPkJftCbN3F5Xk7cnAOQPqEtbJLBc25MQ4I06N
         PrAne2cpqj/FmmofOD3f4H9jGDnvnZMqUfWG0dHt1Ci1jaV7rFNYSDW9c0R/rZI9B6q6
         PCLg==
X-Gm-Message-State: AOJu0Yw7yXK/CtzQcQ/iOffRKg3ceptedThrLDKZbUda4NFBHMKpvaLe
	z8dRmvcPj4a8PNUyOW5NMjBjKnPdy0zzPXXUSsaHIIYkeHZOH2K81xImaj8bfduCuENQKPs5hFN
	L
X-Google-Smtp-Source: AGHT+IG0vS5J7mZ5pr2I/YYgTU9kTidYtYSjH+RTFqJV5itAF8jRB791bYiFBTBf17p0e7N5IcE1cw==
X-Received: by 2002:adf:f552:0:b0:33a:ed59:c13f with SMTP id j18-20020adff552000000b0033aed59c13fmr1423082wrp.53.1706712624173;
        Wed, 31 Jan 2024 06:50:24 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:22 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 10/28] uprobes.h: move declarations to uprobes_types.h
Date: Wed, 31 Jan 2024 15:49:50 +0100
Message-Id: <20240131145008.1345531-11-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
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
index 6ee90f81e01d..88bbb724080f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -12,7 +12,7 @@
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
index 64fdaf79d113..1f314e6461e5 100644
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
index 8d14ba440929..909a98b3d142 100644
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


