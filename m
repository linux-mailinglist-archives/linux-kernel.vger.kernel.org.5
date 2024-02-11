Return-Path: <linux-kernel+bounces-60752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59136850923
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F778281942
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA485FEEE;
	Sun, 11 Feb 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UUrRu1eJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE65F46B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654643; cv=none; b=nfjCRzlly6na55vw+FAddoUdPgfsKKOjqNWVfxLiXUhQpEHkVSP48FjqAQuEzh4jPnHrDdDDxgArfyxtGRt+5DEsFl+WIO/GvfEliYdG5K3S06ZnlT6TxfDQZjx14qK+flivoK3P0OC9I5bLC3OecMs0Nb55eP7OV6mU36lq03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654643; c=relaxed/simple;
	bh=M+TCf4sn0Vj4ZvvDThMshhJMhSj/72BJZc8cZVfWfZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PeczU1LP+WanoZSEcJ+v/x4KNcqr/d2OqqqhJ05Koau15/ykOEd7nBTSOVzHIYWIgBvegsMzg49Sg88r3yelgRHE8Mj+j9go6+Tn/gTPj7o6gOzy5UDEeYPUmpI3bH+2YhUp1jWarOyKlIZMkuhCMGUGFUMJr17ZO0YIP4L4xP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UUrRu1eJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so3090104a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654638; x=1708259438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33wlCo9DUXvbQxRFpboMlES43uYj+ZzSbFUQMwIDJfY=;
        b=UUrRu1eJcrf6c60uR2/5LPXvE7QQTN0E7utX5olfoM9ZvNOIxusRa6yCufNX2XTvOT
         cJ7VJD9080wo8fIuec/x5qxQuYmVX/De9KFstCg09+XEA3GNDOftd3FNUNljRaeI/GVf
         Yez3g6L28a3oGcwhrfhFSdX2bd1nfZf96hc8TVQ9HUlOZZ81CBXb/FcP5RjnHorVW0FD
         mdFnJoUWGPLoXbUxI2fKHMhkoA8u8++hXbGrPz93IKq/orfa625hHZc92OZQS80XmA32
         /eorzccEJEslXA1sdEHIJgfkU/bKStkG47Mezqd+mElwlR5qIkwalWv1vSZjnLDTzTLT
         v0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654638; x=1708259438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33wlCo9DUXvbQxRFpboMlES43uYj+ZzSbFUQMwIDJfY=;
        b=AxN/FvrUltN7yKeP9SkE7PhIfihh1lguh/2bZIro4XMLE5zUOzHJ0YUUmVZCcol86n
         C7cuqo9lSRezP0iZtdqxvkNW0+PZtQUHBt+cDrC1uZaQo7iQZjYjABGFYpg1eXlO+4iW
         g4TVyaAC7Ibwzalqq/M/UPRJXPvc3zNn1IL6OdY9e6dtVEHYhqrJbv3EvKMX4HyVcvS6
         kPoXIyIHgi2vUBoK/D+qkhSJ4W5zwO2dk0nUIseSYecmuAVwRGEh5Y+stgGwSPP/mj1H
         8hPbRBi5U1BBapp9z+rND26GEwtdBUxSlYw6f5xUliUpAgH70VK5RIgxWbQUjHpOo9jd
         Y8OQ==
X-Gm-Message-State: AOJu0YzJmQAMJAlOX6gECDtzr+4I95H93DF2IvskakNR4OHEFx5vBYhl
	LtTe3+2t+Lp8IQk2SGSCbddrZCcXXVNvnPNhR+2cRnOCAgXqTzWE7AZeZXg6lTiZq06cxLgCZYZ
	g
X-Google-Smtp-Source: AGHT+IHFiXS59oWoO2QrM4VVY0M3eBYN7I22GPtIiCYHHzGdmhpShROaCr2XBpheKtm0a3KYKIYxxA==
X-Received: by 2002:a05:6402:30b1:b0:561:9968:a1ec with SMTP id df17-20020a05640230b100b005619968a1ecmr841785edb.9.1707654638397;
        Sun, 11 Feb 2024 04:30:38 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:37 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 24/35] list_lru.h: move declarations to list_lru_types.h
Date: Sun, 11 Feb 2024 13:29:49 +0100
Message-Id: <20240211123000.3359365-25-max.kellermann@ionos.com>
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


