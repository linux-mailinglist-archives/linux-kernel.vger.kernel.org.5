Return-Path: <linux-kernel+bounces-61487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1328512CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF91C1C21F99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0239D3D56F;
	Mon, 12 Feb 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IZJmx41s"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62863B796
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738943; cv=none; b=Y8s6Xz8QS1mz2B5A9oSybxP8msJ6VLjQBQVslGVbgfg7AUpIQF7ve4RMr/Wiy/HMC0Diyksc71MySAuAwhzqIxJIKHCBjOuaOGkSXpHo+RgvzRhWJMjw4ppOScwpVLfC+xVnBX/h7e+ulz1hh3Zayi1+pmd1BkjxCm/FVnnj6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738943; c=relaxed/simple;
	bh=k0CWYvaaB/gYg4+a4TXJ9LeyRASwAqQNiIxSmINjJE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhjeUd1znelsfbQduBXl4iBwubZp2QZNKgbe1/jc8T+xXlfLHHgpEExbmSk6rWuYjaHCXDMyZEM+VGzMPjvLXWAMM6y7hFO7XOUZp3AoH5kM3AlpV2aZtTOmpIZ8AxJd5WeZ9Du/iUwcn+c/dgGq1bEe9ns2XAdqfdccdh9t6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IZJmx41s; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26fa294e56so418849166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738939; x=1708343739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=IZJmx41sQB5e85MUhmyaPgaaKJ3MKSfH3br843ZYr4Bnvbuoar6+gGCwEMo1Y4WOq7
         9wF7raaxCnybVi5aIiSbPm1C8sNtAu++rLq0CZQ2c9QeH+SrIIwaT+Rvqb25xpgJJKfE
         B+KIllN3nqvSpRsR5S071nSXq8a3WA01m3KG4H4f9p0Bt6D7tmHgnpkkhAVLCUFh8ZWx
         lQwATZYUBuPCx6GEfYwIZy+vALaXjmArT46Z9MW0O1InTGZJgwKlNx3PQ30TdyIqEA+B
         IILGXGOX8YgcwJNHlbLkG94IxOH4swpZOOA1qLvl+TgH/hALB6nAu5sBxwqb158YLFi5
         PN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738939; x=1708343739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=qS/i0b+tnrbjpFzSv2nhC6/4SM1l7xEPlYJdqhNVsJHCJBp9L8RQlPi7oLdCBinnZX
         86DW+o7NcAZHd8jR/Le0NeWu+EOHURMaTuZE9jQRpCUrKeWkvWMZPbkFDqbv38EWXXLU
         JSAO4tqX/1uDLOlUhCxSvdBKJh5TV1uUDdZ4mhB2WNO0wFmMX6OiER4rvRmb0pWGH18Z
         L3zH3ipUm/A4DxSEcXFZhb2IzhtiRWUsnMEw6WJJa7S5ZvgffTHpSJDx369meuVc9IV7
         mqrnGc0PQBT2Sat6mxPotG9FcafDE9ERyVhIY3EoRRJZ3PlmgsoGOPBLvmoTVvzHwInm
         rBow==
X-Gm-Message-State: AOJu0YzO+LDXhFUIX6jfcWpUYGPKPdRpbNAP+Oqi6rG5SA05I13xD/84
	HFRB2UBw80x39RW24YOeHlzBrh0ZUmOVWpX8p9VK6EGcV+hGj16ZucPEB/w8vCVFTJKG/GO1dit
	n
X-Google-Smtp-Source: AGHT+IE/cmeOg4qqK1XGaJ1cGFtVPd+5/k4X7BvEjTQLzRZyhH0uuzO6WVQH31+MHFBGO8P3PUZelQ==
X-Received: by 2002:a17:906:d10e:b0:a3c:caf8:9f8f with SMTP id b14-20020a170906d10e00b00a3ccaf89f8fmr813966ejz.61.1707738938950;
        Mon, 12 Feb 2024 03:55:38 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 26/35] percpu-rwsem.h: move declarations to percpu-rwsem_types.h
Date: Mon, 12 Feb 2024 12:54:51 +0100
Message-Id: <20240212115500.2078463-27-max.kellermann@ionos.com>
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


