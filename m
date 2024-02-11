Return-Path: <linux-kernel+bounces-61005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1867850C41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D9B22D86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994EC39AE9;
	Sun, 11 Feb 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EDcmDL1a"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AA1EB3D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693361; cv=none; b=TANrajItEhkfbGz7TSV1pdiXZCw++8HFlgOjKN4RnEWcyUOayjHncV1RGyk60CdCWoboPttR/7xY/YgUsuPjpe3JjTfjZDvyZsbSokFwtuUz/2IdlfzvvzhgkoaG5sqvhFUlP+fszFXTHl2+mkRJOgR5dEmrFj9+MkcTt99ezVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693361; c=relaxed/simple;
	bh=M+TCf4sn0Vj4ZvvDThMshhJMhSj/72BJZc8cZVfWfZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F70j4AUtPuitoEqSwFMBmAxa0JYav98M3WmenoajG2T0k4htIh5mhszIe7TKuLRf5Uhl3GS+fULmq8AahZfNJLktxGh9SjzMSz0GDs5Ju3fUMap+nm4pSt3rXzF2piZwmol13lkO40EADDy55pI9c1+X6F+YrshJsTIl+fP+2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EDcmDL1a; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3495200a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693356; x=1708298156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33wlCo9DUXvbQxRFpboMlES43uYj+ZzSbFUQMwIDJfY=;
        b=EDcmDL1aSaJqrTFBU+n+xdjBF+EllnK9iB4lhemKeOsi7O+EXzrnQw5MbdNgwxXwiC
         MNIAQ2EtGs8GO+04DVpiYdV9IhdN2WhpHJ5aykFHfd++fgwI13mt85gWqjgjTvaR9r5p
         Sttcku4kGfTpNNrJpYgqum/4tVJUSWRjKD99sx/khhkHj6O+0/0W4kT7SA7i2WuBjIJ1
         PWqQyozwoLWbqHBJ4qMBmiFIZmEH7N51pgZe+U61ZJOXlYWhvxj88KpPJ/haUEm6jedS
         qcHv6lP/AUkvKXviJHJUEEeMlKNvxSOaP7xarma3QXCOD/bbtp2xHlpViqO0/HLWGazw
         5/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693356; x=1708298156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33wlCo9DUXvbQxRFpboMlES43uYj+ZzSbFUQMwIDJfY=;
        b=jl3JJ55YK4BwXOjGDe8l4lpmglx6UL0kRYNp4HfmC/5rm8qrVKPwq/lXEl61vIMIrr
         PlMKg3QtF3lTkkcwa8fZAPI+k40F1D3S4Y0JuCIYx3wE/iLH5+wIzjaP2ykpGX0yppE4
         XlxQGlLYD05V08l+vqYpRDkRr8dF1sVd2sFJ8mdpU3TT69sYVgmurSSsiB3N23+U9U+v
         zecKEIltJDuMm5MaAlhHnKsHoyzmPIVVKTYQqRE8sAu7c0BMRF2FgTWzmKZahOpexseq
         V3The0ydwHqQJSz0neO9JE98YTOKV8I4gskHndUkLKHpLF2CzcSwzmMlbmjECeuAX6rG
         iJRg==
X-Gm-Message-State: AOJu0YwD2Lco8sHT6tlxpgrX0fXL4MpoGnNXymi946xCWodfPQ6cO6Df
	B+f+aozioEXv8lqPU61uu8xozDKScSDBuZVY0Q5+GSkZ4nEXOkPN5ysKbRSAlBN4fSvIll+tZlr
	n
X-Google-Smtp-Source: AGHT+IHEd5I5jKw7S0yjUuYlQF/IozJ0rTomr5LenfXMNVZkUU7WyOvqaUNRjMJcPGgok8vOql1vtg==
X-Received: by 2002:a05:6402:440b:b0:561:c627:cad8 with SMTP id y11-20020a056402440b00b00561c627cad8mr34934eda.36.1707693356398;
        Sun, 11 Feb 2024 15:15:56 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 24/35] list_lru.h: move declarations to list_lru_types.h
Date: Mon, 12 Feb 2024 00:15:07 +0100
Message-Id: <20240211231518.349442-25-max.kellermann@ionos.com>
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
 fs/super.c                     |  1 +
 include/linux/fs.h             |  2 +-
 include/linux/list_lru.h       | 36 +----------------------------
 include/linux/list_lru_types.h | 42 ++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/list_lru_types.h

diff --git a/fs/super.c b/fs/super.c
index 2ab97cc49374..6a8cc1c49940 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -34,6 +34,7 @@
 #include <linux/rculist_bl.h>
 #include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
+#include <linux/list_lru.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5862fe2c82d5..1cfe76f7544e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -10,7 +10,7 @@
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/list.h>
-#include <linux/list_lru.h>
+#include <linux/list_lru_types.h>
 #include <linux/llist.h>
 #include <linux/xarray.h>
 #include <linux/rbtree.h>
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 5e8cd106dae4..bb348492037f 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -8,14 +8,10 @@
 #ifndef _LRU_LIST_H
 #define _LRU_LIST_H
 
-#include <linux/list.h>
+#include <linux/list_lru_types.h>
 #include <linux/nodemask.h>
 #include <linux/shrinker.h>
 
-#ifdef CONFIG_MEMCG_KMEM
-#include <linux/xarray_types.h>
-#endif
-
 struct mem_cgroup;
 
 /* list_lru_walk_cb has to always return one of those */
@@ -31,36 +27,6 @@ enum lru_status {
 				   internally, but has to return locked. */
 };
 
-struct list_lru_one {
-	struct list_head	list;
-	/* may become negative during memcg reparenting */
-	long			nr_items;
-};
-
-struct list_lru_memcg {
-	struct rcu_head		rcu;
-	/* array of per cgroup per node lists, indexed by node id */
-	struct list_lru_one	node[];
-};
-
-struct list_lru_node {
-	/* protects all lists on the node, including per cgroup */
-	spinlock_t		lock;
-	/* global list, used for the root cgroup in cgroup aware lrus */
-	struct list_lru_one	lru;
-	long			nr_items;
-} ____cacheline_aligned_in_smp;
-
-struct list_lru {
-	struct list_lru_node	*node;
-#ifdef CONFIG_MEMCG_KMEM
-	struct list_head	list;
-	int			shrinker_id;
-	bool			memcg_aware;
-	struct xarray		xa;
-#endif
-};
-
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key, struct shrinker *shrinker);
diff --git a/include/linux/list_lru_types.h b/include/linux/list_lru_types.h
new file mode 100644
index 000000000000..51ccef0d6994
--- /dev/null
+++ b/include/linux/list_lru_types.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LRU_LIST_TYPES_H
+#define _LRU_LIST_TYPES_H
+
+#include <linux/list.h>
+
+#ifdef CONFIG_MEMCG_KMEM
+#include <linux/types.h> // for bool
+#include <linux/xarray_types.h>
+#endif
+
+struct list_lru_one {
+	struct list_head	list;
+	/* may become negative during memcg reparenting */
+	long			nr_items;
+};
+
+struct list_lru_memcg {
+	struct rcu_head		rcu;
+	/* array of per cgroup per node lists, indexed by node id */
+	struct list_lru_one	node[];
+};
+
+struct list_lru_node {
+	/* protects all lists on the node, including per cgroup */
+	spinlock_t		lock;
+	/* global list, used for the root cgroup in cgroup aware lrus */
+	struct list_lru_one	lru;
+	long			nr_items;
+} ____cacheline_aligned_in_smp;
+
+struct list_lru {
+	struct list_lru_node	*node;
+#ifdef CONFIG_MEMCG_KMEM
+	struct list_head	list;
+	int			shrinker_id;
+	bool			memcg_aware;
+	struct xarray		xa;
+#endif
+};
+
+#endif /* _LRU_LIST_TYPES_H */
-- 
2.39.2


