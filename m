Return-Path: <linux-kernel+bounces-46661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FC844257
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE32283F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624D13343D;
	Wed, 31 Jan 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dW8MgYvP"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888212F5BB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712655; cv=none; b=JSwAP9cCoRHS7KTfP6iFyqSERHGUrnAevm+trwRMPt7t+mSA+jv8WFvjbKCnKpeI+oDAtkdhEXk4MmFH+P2v+5IdRcU0exHmch47L3dGa8YSDnAGraEbuaRVCpCjE7sRF0RB+6YSzdgBnYqjbCPk/iovImjkdlPpjk5xWjPhLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712655; c=relaxed/simple;
	bh=hSsM26x/M68xyIOqeMb/kkc3q30JYF5blcQULY3DUt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgTE57+TpwxqHT0DqoSLC/dxUd2vOB+/juwcHqHc73oS54DjNPLDUvTx1h9+Cn8iF9fcsrafj8bjCnHniXEnr9ZIuiPXctjfTNPp3ukEir/P5vzjIjU/DuJg1esbmFSFSBqmiyaUZgyCFWHbFN6qJz5zcq9NcDSPTd3shAaCeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dW8MgYvP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fafae5532so13539775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712638; x=1707317438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWHYXiDL1OrdEycxkXg7bf3FpkdrqXb6tQSgGherWsY=;
        b=dW8MgYvPr2mgbOgjXycaWwjHWtuF273znyUFcd+W6/0d4mSfqaG/JuRAEuzFM8jdxv
         XXmS3p6fCSesQar51vqw1JVbBAOBhV+3kxh6jejVIrgXb84knG4WhETE4c1VLvKPMGpQ
         91A9x76dPQCxLwu/aXx145+tlGkkNw+hnw0jhUqrLqH4IwAkIGM3E/MY3Blybq1/bQGc
         RWUvnIBH4SUEh41rbBEteUiu1DSMTsk4tbVVdpzMxsnpvjk9VenRVCmSO5Mb+7jR1D/I
         4TLT96i5/tB/ko5zaHT9QAYkXK1LtQgQ7J/QxRwnc9h88TIdvIpf4apu+jZiPz5h3SZR
         Bw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712638; x=1707317438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWHYXiDL1OrdEycxkXg7bf3FpkdrqXb6tQSgGherWsY=;
        b=PWUMIA4Sh7P36yA+u3TmS5Ii3b3xCsW4fLdGnojAiFc0X9b1JBpocqGiOsi1BFLPu6
         1pbAcVWLoVOnpSB8P/Rm6M8EJiyxmI+AY495UN/OD3wpc2uV4/DsZpw0fbimKvPBTAvv
         BFc9gB/pRjAjEm36c8jLMd3n7vQpRnksCJyd1QtdiRL+6vHux9diBURlrMJNAgPB7g3M
         L7fStVAdAppcO92Kwih+6SlxVsk2dtadge7LP1WPsUQdpqJf+qZuaol5VrFagCUs9U+k
         esftOQUeS/hNlhkJs3gS3s6QVzh7fqYfqRkOBOLTMNF9FUG+GnUiQQoAsmUDslTmdYag
         Y1gw==
X-Gm-Message-State: AOJu0Yxh1jIOnKrYh1yqswGZRw55Q+KT9vE7citBKqbAEXVoz2l1JMSv
	A8je1gHcE0C7ryESxDntE2hA9O887FIEC2SUN8WAwXhAPZ4irCSioF9WRfbIKl31OJrVsbfFm1K
	j
X-Google-Smtp-Source: AGHT+IGWsfks2ReZlxwNm2oWkW1i6NDxQWIPKjVQE2zCaxYGGvw186aZPnveFBpkJ0ms3uUXrma2EQ==
X-Received: by 2002:a5d:630b:0:b0:33a:e715:34df with SMTP id i11-20020a5d630b000000b0033ae71534dfmr1375527wru.45.1706712637752;
        Wed, 31 Jan 2024 06:50:37 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:37 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 27/28] quota.h: move declarations to quota_types.h
Date: Wed, 31 Jan 2024 15:50:07 +0100
Message-Id: <20240131145008.1345531-28-max.kellermann@ionos.com>
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
index e1343fd0a5b1..3cf177dd201c 100644
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
index 5a2512d20bd0..1f893c99b956 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -48,6 +48,7 @@
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
index 06eda3a4fb52..abe97d31849b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -261,7 +261,7 @@ struct iattr {
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


