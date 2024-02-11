Return-Path: <linux-kernel+bounces-61009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680C850C46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEB7B22DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152339FE0;
	Sun, 11 Feb 2024 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NiRTcq+I"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAE2B9A6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693363; cv=none; b=MT14WpdblMHojW+JX7bU9wMcmyFrBLOSA8DsKyPTVMAjTw5LaJwOUcMTcMBwGJWxgN4WQQyB+uFKwFnl+9WZwvwAe0pz1STdVreerWxZ/JW1M2AFJnEsF3N4+u+XOsAxsUeNCAvzFL+nn3hg/4lHfMBi+D1ejzNCwwnkdhQZSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693363; c=relaxed/simple;
	bh=k0CWYvaaB/gYg4+a4TXJ9LeyRASwAqQNiIxSmINjJE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnhKf4CxOpd/Wkpth1YqfltFg0TNU1wiBM1cfxL6RR8UWNX+Q3GSV/lpwL2UPkHXPA+IdAW2t2OnHEGFHis1419oQgYvRs9A6G+9HC9fZFLBZD/urx/EWJhYR/Vyf3uSErklrfBzCt6b17iJFXu6I5hsRXPBt8UK5A93WB32mJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NiRTcq+I; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d090c83d45so36389591fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693358; x=1708298158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=NiRTcq+IQX0Ma/0Wo/A5yxG4/1JOo0IG+zY2bnTzAWVxNMjMPOEQLUJ/oIqYaN9U9g
         sbYf6XLlrunwWfvMuy+40IhhrTPJGcGEG5ABaLYuYgJO7RvHgRhSUIo5K7ejQtyKUNAv
         30dSO873aNjNbE1NW0J1wbzTUQ9+hGVGL09zhczb+DOq1upMCgz3WpYtV8kKYMy3KQj9
         b917fNkpTuyHzyeFRCEIROo6UUWWW1sxTcOFPEYE5p9SAJgzTpwKfqS+LvWwQofogd/1
         fp8LSmgvA5/Q0rUPYGccsmRGSs2eFQQodrL2EMRBhuMzGZSEt2PK6GTGdkAk1uCK9C0x
         PGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693358; x=1708298158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=KdFH5LlbEQCkNnHpyAh4mHNa+8cQCiHgWRIhvCwfvv6m6cWB8tE9A5yBUT8cFvUvGr
         QYb5mlnBIOCnbI3U6eARpAZrra3WBG6dvo9pfNaJsOWNac710pAdezIckaWN2k2UJeMa
         K44CmlVIrN7ZX4DaExWvtTWkTf4sqP2DTyfxQwgq3qBefltwq/Ox2/XupVnFuTg0lA4N
         iYQkshyE5V0Ld6qRiNLpZ17ZaQKGUD/7re6LiuKx8yJiXxHqT57hmB4GRQFESzelr7s8
         HQM6kryIOPchWT5XLOBSplC0WI2eM0FJKvGsHl3R91AnAHZmVj3AY0PDuINAJHS14iAp
         +Sow==
X-Gm-Message-State: AOJu0YxLnnxcRt4qGuGXTzIUo/gKYL1V1jRBjTsJX7lzlTtlMZ0ghKxC
	b2L0Xs4X/ENX45EuTQ2rRp6JvvuaFWzbXCoIavVADzs04cn91l8LfJmP4D5nhSJinR3+K27zs0k
	m
X-Google-Smtp-Source: AGHT+IFi0DAPB//fwZ0P2S7SIfn0jLfZTPkvG0tEHXXcshW6yDDHSS11mFNNFw3wa/rAZXoPn0XYRQ==
X-Received: by 2002:a2e:9a86:0:b0:2d0:9902:16 with SMTP id p6-20020a2e9a86000000b002d099020016mr2914856lji.17.1707693358461;
        Sun, 11 Feb 2024 15:15:58 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:57 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 26/35] percpu-rwsem.h: move declarations to percpu-rwsem_types.h
Date: Mon, 12 Feb 2024 00:15:09 +0100
Message-Id: <20240211231518.349442-27-max.kellermann@ionos.com>
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


