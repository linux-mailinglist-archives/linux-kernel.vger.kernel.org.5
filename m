Return-Path: <linux-kernel+bounces-60756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74977850928
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D721C24199
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEE604B8;
	Sun, 11 Feb 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BKp5WNaN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6505F853
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654647; cv=none; b=bxD1Whr8ZXTjCn9beCk/ld+UMTDN4nFBBouCTZKHRPIbvvubf24AZM91J/rpVSakPBXVPX60wtKlCIaBvb0soGJw6yYfI4bHlOxKdH51FvxpiGoOhOC3zoheguy0KB2I15OAuc86v0I0sQpvOdPNMpFtKbNsbbRDXOKcnlH0Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654647; c=relaxed/simple;
	bh=Jk9++ZI9K5g/l3vneedAtiFBwT5nQ9V1AG9tXtn14Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itNrBEKlujZOHQLtKy+1eo5PRmwuhId94fYAjvrxAlP/je6B/7JOyPlcH/miZixOuuwzZKdHKs5fBgjGR3nP/x5+tPZW8u0RvyynlqgOl5dzDf/m8QSnrYsuz3NzNJqdG7XgqQu7riu9WYlmLdtQISQwceicVLf0TKYLB8z9rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BKp5WNaN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so3064109a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654641; x=1708259441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULoKxp+mUpIb8o5pOMUhCUk1LDRRY2hj78IQ7Yi6k2Q=;
        b=BKp5WNaNshi2wgGaIuGy/psurML52hLy8s8uxcMTuY1wcbTMoBbLJsGm16zA9jesRc
         0ts/P6pkE9JxH5OKvqaggaeUZtkzvFx3nHNj6GnicJhtbioMrH00mg02G6zAlMvfcNlk
         655+oLysrrHGv+hk8pI39ea8rwaW925gRQsFm93jm1+ccmjukUWoTeW1xFwWiaBCWFWo
         MOqBeHYWbaBApvPz5/TFb9wZVetNxNpzGfLdJFg0wgB4czB4WovO1wqqQ+kypR/OJz9i
         0ZvIpsH89dh0EzQAImCXVAt6JDQZA+TGtzoDohMiaI/CCuCcEWECixffkJecgONmy7WL
         znTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654641; x=1708259441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULoKxp+mUpIb8o5pOMUhCUk1LDRRY2hj78IQ7Yi6k2Q=;
        b=vDzhuqcEW8V93623MpJYkv0njJjWWY+JKUdPaB2jUKGw8EmnTBiwXYQ5ifs2bZJ4gc
         oTPcK+ge21UWzB21udoxB42N413ChQ+F1ucqR4z9SvIAOOgUvMHXmDgeeGG9KdaJLIOb
         AlOiL8laLd034bJfEY1a0OXUyFbFDOA2vEAFZaM3nWgxrf28hLkxUUns6wCmZYcLj8OY
         Ugyrly2EjqGk/boG30otGmZx2dUG5d+vI14wqTYbS2AIm118ITEAp5WjuLl9/AvsuCva
         bb2U40ruTpIkVtv3L1zFvR52w5P/0QQZAMjNh3ypcTPND5EG8cTkdRKpsbIHeasCk47I
         6AuA==
X-Gm-Message-State: AOJu0YxSc/eZ1Mb862H8Wl7qE8vDJI3qy6PH8hCiOQZmR1yyarFGwdza
	uJZ9p9tXRFqD74n9vch5DXmX8hm0W6r2wX4riWvumTLhjVAT5RglxWytXKNmTEvftSqYrL0xXxE
	8
X-Google-Smtp-Source: AGHT+IGWzgJzQFp/1CS9wuPthzT/kUHgZDZdTSJ4VW8xPTgVnkvKOLTXzFLzkkv1p2wxiW+4XLRaKA==
X-Received: by 2002:a05:6402:2025:b0:561:2734:b835 with SMTP id ay5-20020a056402202500b005612734b835mr2484198edb.16.1707654641475;
        Sun, 11 Feb 2024 04:30:41 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 27/35] quota.h: move declarations to quota_types.h
Date: Sun, 11 Feb 2024 13:29:52 +0100
Message-Id: <20240211123000.3359365-28-max.kellermann@ionos.com>
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
 fs/gfs2/incore.h            |  1 +
 fs/xfs/xfs_qm.h             |  1 +
 fs/xfs/xfs_qm_syscalls.c    |  2 ++
 fs/xfs/xfs_quotaops.c       |  1 +
 fs/xfs/xfs_super.c          |  1 +
 fs/xfs/xfs_trans_dquot.c    |  2 ++
 include/linux/fs.h          |  2 +-
 include/linux/quota.h       | 33 +-----------------
 include/linux/quota_types.h | 68 +++++++++++++++++++++++++++++++++++++
 9 files changed, 78 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/quota_types.h

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 95a334d64da2..94f945dc4bdb 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -18,6 +18,7 @@
 #include <linux/rbtree.h>
 #include <linux/ktime.h>
 #include <linux/percpu.h>
+#include <linux/quota.h>
 #include <linux/lockref.h>
 #include <linux/rhashtable.h>
 #include <linux/mutex.h>
diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
index d5c9fc4ba591..bb111cbc3567 100644
--- a/fs/xfs/xfs_qm.h
+++ b/fs/xfs/xfs_qm.h
@@ -9,6 +9,7 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 
+struct qc_dqblk;
 struct xfs_inode;
 
 extern struct kmem_cache	*xfs_dqtrx_cache;
diff --git a/fs/xfs/xfs_qm_syscalls.c b/fs/xfs/xfs_qm_syscalls.c
index 392cb39cc10c..1de4443bed40 100644
--- a/fs/xfs/xfs_qm_syscalls.c
+++ b/fs/xfs/xfs_qm_syscalls.c
@@ -19,6 +19,8 @@
 #include "xfs_qm.h"
 #include "xfs_icache.h"
 
+#include <linux/quota.h>
+
 int
 xfs_qm_scall_quotaoff(
 	xfs_mount_t		*mp,
diff --git a/fs/xfs/xfs_quotaops.c b/fs/xfs/xfs_quotaops.c
index 9c162e69976b..eda56d032734 100644
--- a/fs/xfs/xfs_quotaops.c
+++ b/fs/xfs/xfs_quotaops.c
@@ -15,6 +15,7 @@
 #include "xfs_icache.h"
 #include "xfs_qm.h"
 
+#include <linux/quota.h>
 
 static void
 xfs_qm_fill_state(
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5013d71143c2..615ba5b1bd1c 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -49,6 +49,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/quota.h>
 
 static const struct super_operations xfs_super_operations;
 
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index aa00cf67ad72..94214f0baa2b 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -18,6 +18,8 @@
 #include "xfs_trace.h"
 #include "xfs_error.h"
 
+#include <linux/quota.h>
+
 STATIC void	xfs_trans_alloc_dqinfo(xfs_trans_t *);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cfe76f7544e..a7e65358ebc0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -260,7 +260,7 @@ struct iattr {
 /*
  * Includes for diskquotas.
  */
-#include <linux/quota.h>
+#include <linux/quota_types.h>
 
 /*
  * Maximum number of layers of fs stack.  Needs to be limited to
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 956281c84850..2a3040e61072 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -32,9 +32,8 @@
 #ifndef _LINUX_QUOTA_
 #define _LINUX_QUOTA_
 
-#include <linux/list.h>
+#include <linux/quota_types.h>
 #include <linux/mutex_types.h>
-#include <linux/rwsem_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/percpu_counter.h>
 
@@ -45,7 +44,6 @@
 #include <linux/atomic.h>
 #include <linux/uidgid_types.h>
 #include <linux/projid.h>
-#include <uapi/linux/quota.h>
 
 #undef USRQUOTA
 #undef GRPQUOTA
@@ -61,9 +59,6 @@ enum quota_type {
 #define QTYPE_MASK_GRP (1 << GRPQUOTA)
 #define QTYPE_MASK_PRJ (1 << PRJQUOTA)
 
-typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
-typedef long long qsize_t;	/* Type in which we store sizes */
-
 struct kqid {			/* Type in which we store the quota identifier */
 	union {
 		kuid_t uid;
@@ -213,24 +208,6 @@ struct mem_dqblk {
 	time64_t dqb_itime;	/* time limit for excessive inode use */
 };
 
-/*
- * Data for one quotafile kept in memory
- */
-struct quota_format_type;
-
-struct mem_dqinfo {
-	struct quota_format_type *dqi_format;
-	int dqi_fmt_id;		/* Id of the dqi_format - used when turning
-				 * quotas on after remount RW */
-	struct list_head dqi_dirty_list;	/* List of dirty dquots [dq_list_lock] */
-	unsigned long dqi_flags;	/* DFQ_ flags [dq_data_lock] */
-	unsigned int dqi_bgrace;	/* Space grace time [dq_data_lock] */
-	unsigned int dqi_igrace;	/* Inode grace time [dq_data_lock] */
-	qsize_t dqi_max_spc_limit;	/* Maximum space limit [static] */
-	qsize_t dqi_max_ino_limit;	/* Maximum inode limit [static] */
-	void *dqi_priv;
-};
-
 struct super_block;
 
 /* Mask for flags passed to userspace */
@@ -517,14 +494,6 @@ static inline void quota_send_warning(struct kqid qid, dev_t dev,
 }
 #endif /* CONFIG_QUOTA_NETLINK_INTERFACE */
 
-struct quota_info {
-	unsigned int flags;			/* Flags for diskquotas on this device */
-	struct rw_semaphore dqio_sem;		/* Lock quota file while I/O in progress */
-	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
-	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
-	const struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
-};
-
 int register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
 
diff --git a/include/linux/quota_types.h b/include/linux/quota_types.h
new file mode 100644
index 000000000000..7f52ee2604bb
--- /dev/null
+++ b/include/linux/quota_types.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (c) 1982, 1986 Regents of the University of California.
+ * All rights reserved.
+ *
+ * This code is derived from software contributed to Berkeley by
+ * Robert Elz at The University of Melbourne.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+#ifndef _LINUX_QUOTA_TYPES_
+#define _LINUX_QUOTA_TYPES_
+
+#include <linux/list.h>
+#include <linux/rwsem_types.h>
+#include <uapi/linux/quota.h>
+
+typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
+typedef long long qsize_t;	/* Type in which we store sizes */
+
+/*
+ * Data for one quotafile kept in memory
+ */
+struct quota_format_type;
+
+struct mem_dqinfo {
+	struct quota_format_type *dqi_format;
+	int dqi_fmt_id;		/* Id of the dqi_format - used when turning
+				 * quotas on after remount RW */
+	struct list_head dqi_dirty_list;	/* List of dirty dquots [dq_list_lock] */
+	unsigned long dqi_flags;	/* DFQ_ flags [dq_data_lock] */
+	unsigned int dqi_bgrace;	/* Space grace time [dq_data_lock] */
+	unsigned int dqi_igrace;	/* Inode grace time [dq_data_lock] */
+	qsize_t dqi_max_spc_limit;	/* Maximum space limit [static] */
+	qsize_t dqi_max_ino_limit;	/* Maximum inode limit [static] */
+	void *dqi_priv;
+};
+
+struct quota_info {
+	unsigned int flags;			/* Flags for diskquotas on this device */
+	struct rw_semaphore dqio_sem;		/* Lock quota file while I/O in progress */
+	struct inode *files[MAXQUOTAS];		/* inodes of quotafiles */
+	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
+	const struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
+};
+
+#endif /* _LINUX_QUOTA_TYPES_ */
-- 
2.39.2


