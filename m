Return-Path: <linux-kernel+bounces-59645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92F84F9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6908288B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC1C129A60;
	Fri,  9 Feb 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="a5oW3mpC"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9D1272B9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496876; cv=none; b=Y5aVLAPTSWt5v8pm3azfkWLM9SDiOVGtQQ+jQOt1wBjadaCwmyhHJfPWSVXwEtKMwaRWTOiNubNVgxYUwhcF6WZmHZOH/OidhUmzan+Z0Mdh93VA9iAHr2xH30ATuJDBE94NkWCTUHdPRwjIpsf8aceiGsnerVfg/MHmW4pzryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496876; c=relaxed/simple;
	bh=k0CWYvaaB/gYg4+a4TXJ9LeyRASwAqQNiIxSmINjJE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOcjr/SRTPe7m0AJuo0kxgeEssuVIkORD59Ub+VD3cOWMtBVzlh13HPERtU3E6WWEiM0l8wNFbXgUoHF4B4bZGz90sPCYf1ChA9cpsNTuN+0IJr5sDELw/4GC3UnWqjjzacxudJzkHl4SskOq53VZyfZ1Y+MRUtEHiHGraLjN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=a5oW3mpC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a389a3b9601so157284166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496870; x=1708101670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=a5oW3mpCkM7ItOQw+WfzUoAMLD6XUFDf/dSW8+yi2nRq5y3r+GOOXVtjlIvt9getoO
         /zfySyTG+JNiswEU5/f0d6/92QSE0GP5LuuomaAXm8QSwtzWJYLfEl9uPiSn05pDKWi5
         0K90MZMPySe27eey4hnaAJ1cmrTBgnBN5N1fRStcfNDt3Mlra01g/oTl2ALBNnP/nu4V
         uzwL03INSxZrn1kYRUXOZ+PtoSrOB+HjIEDzZDFIJLNF9aZKASYL+YLk2eo8DINtNIip
         j4rG7nVJmH8R1H5xnUwVnBhHR7XB4+2qS6Y82MdzgKUIimDnUYJsm0wdGIrskLZ9u3JC
         cyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496870; x=1708101670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=mJSeUcb9m4AnJftA3/NtgTZvoitiZbYpdvgxSbLZLdHE//wOeHdB+pZKz11jVn/IfV
         sdGF8TPfmNmMO4++OesZr16mz1redGTty88Ges3MU0VePR9G+ZUxwfBCd+l8QVJA4PYt
         NcqwVyHlryiKKWmhGR+/B4COtzkrR+aXpjACJmVCrWt400qDXNUfVh/9Gdo4KlSTZtIl
         xSqBH4+0CzyakBNO08y67iZCIlZDU88uglvrZLknh+Al1B8SzUFe0elGzBdIYjt6v2w6
         gsGwwGQTv959So3pqzTnS5DPpmUXYgokNK54k5tCyey/I1HtP3NH+A59As/GH1tPpwjP
         klRA==
X-Gm-Message-State: AOJu0YxUI7CzRN1SJxWuPbFsCGLgEFCLsGgToCokV2zVTRqHuPu9jJ17
	b8zkqjHNqEBdgK2qRaUzyitDQEA1MqrUcex0C+Ow8ZNl5CPUQj1RNaLf912Y9a3J5lgxCBdW1Nl
	5
X-Google-Smtp-Source: AGHT+IGC0AOwGQemsPJb3WddpKzwcKEstx1pXvuNfKJs3rbVlPPiGmUHiqDWRd50c5nxpZV6EsKqaw==
X-Received: by 2002:a17:907:f84:b0:a3b:c959:24e8 with SMTP id kb4-20020a1709070f8400b00a3bc95924e8mr1650347ejc.5.1707496870708;
        Fri, 09 Feb 2024 08:41:10 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:10 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 26/35] percpu-rwsem.h: move declarations to percpu-rwsem_types.h
Date: Fri,  9 Feb 2024 17:40:18 +0100
Message-Id: <20240209164027.2582906-27-max.kellermann@ionos.com>
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
 include/linux/cgroup-defs.h        |  2 +-
 include/linux/percpu-rwsem.h       | 15 +--------------
 include/linux/percpu-rwsem_types.h | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/percpu-rwsem_types.h

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 878deefba0e1..691c50aeafae 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -16,7 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/refcount_types.h>
 #include <linux/percpu-refcount_types.h>
-#include <linux/percpu-rwsem.h>
+#include <linux/percpu-rwsem_types.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup-defs.h>
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 36b942b67b7d..0f427bd5217a 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -2,24 +2,11 @@
 #ifndef _LINUX_PERCPU_RWSEM_H
 #define _LINUX_PERCPU_RWSEM_H
 
+#include <linux/percpu-rwsem_types.h>
 #include <linux/atomic.h>
 #include <linux/percpu.h>
-#include <linux/rcuwait.h>
-#include <linux/wait.h>
-#include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
-struct percpu_rw_semaphore {
-	struct rcu_sync		rss;
-	unsigned int __percpu	*read_count;
-	struct rcuwait		writer;
-	wait_queue_head_t	waiters;
-	atomic_t		block;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
 #else
diff --git a/include/linux/percpu-rwsem_types.h b/include/linux/percpu-rwsem_types.h
new file mode 100644
index 000000000000..0716d08b758b
--- /dev/null
+++ b/include/linux/percpu-rwsem_types.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PERCPU_RWSEM_TYPES_H
+#define _LINUX_PERCPU_RWSEM_TYPES_H
+
+#include <linux/rcu_sync.h>
+#include <linux/rcuwait.h>
+#include <linux/types.h>
+#include <linux/wait_types.h>
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#include <linux/lockdep_types.h>
+#endif
+
+struct percpu_rw_semaphore {
+	struct rcu_sync		rss;
+	unsigned int __percpu	*read_count;
+	struct rcuwait		writer;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#endif
-- 
2.39.2


