Return-Path: <linux-kernel+bounces-61484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB58512CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A6F2817F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADA83D54C;
	Mon, 12 Feb 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dExvJB3s"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF53B199
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738942; cv=none; b=fET/x06K2pOHKbTv2F2ZZ1enRLoQVxNzyaJb2iR/rCobt3M40YZ2mn+IfSq6FDWtxvcZfWnUN3emD82E5ypZrggDADmyM86hrdNas3fE1jGGpVQss0pjNv36TUhpDhyJ6KCxHbNQzlb/Gi5cSlTE04la6YHUxtwq8GVRP2EHwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738942; c=relaxed/simple;
	bh=OJKAYtPdo/8nXHlGmGudDko9adF6G+JnQxSBAddQARM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dj/W7JVXibxig8O4WGg6eseccbWJp2q9SxKrGsGjOTy43oiNoOQgV9KR8XK+fpbdFFzrZRPsSdB2Vdzgr+d0wSoFgxbBYAMUWr6q2kom+H7FN2ISMsc/udOW1Mk8l3CPH4h7WFOPRNOIQ3AQoN+8DvHQifUt5UDmncghpF1xjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dExvJB3s; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso479803666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738936; x=1708343736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc4bcv+20qFWUWGcPWPRfkIGjfnKTqbCctVU+AnncXs=;
        b=dExvJB3srSNFCQwLY8dfTwjW29xTDzQnHD56tNG8K9Kz2D1vsFLq20XeewA9kA5JV7
         kpqDznVuXINvG8RHB1dGj0LIIah2gR7mgxJgQtkYbecckBtOVqxIpmQd/e0scLIlaNah
         RIZaj+p3HS69+ft6cb5wC4OXKE5dlKiisIqs+y+In9WE4oTrCM4MECyXKTXQgeHzii85
         JM8m5lzwddcIRqCJTd5xwGkW3AgWGzpsrFkoEBFRYforxqN2uvrKYD660jD3r3y3vl9I
         sKds0JYF+0+aubRtWf24q/G8EAzvfLX5NkzzsW7n0w46xGoJe690zGjEHGRJmdWKxjdn
         QACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738936; x=1708343736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc4bcv+20qFWUWGcPWPRfkIGjfnKTqbCctVU+AnncXs=;
        b=wAj5K4FCrJNEZSGsgaDhHEB8jtsiuOPDbHcZYnQuMKPf0bPedHU9rOGe4A3003xl2K
         Wh1/iSRsPUGPQAZ/H3OOvNZ4wRzb/90Fo1/VJ5ENAksw2dyZm1qNkUidYQn7vz2MnGJk
         evPuZdSnVIWl8yyHlzX7Um4Z16CbaMd8hVrqrIBag2p+PUy2FNrb4j4f8G/JpGYIibfN
         uXa/Dp+/TydFYTiaFMQ7pgcW/QME9mOdRPJVKJK3oyLU+Hl3GT9uhUAo3+gkBsMpC5ww
         kxZbwEnWBMicHlO8UQde+LLq/Ni4AM8mj+5rwA6kSMqwbs/rhgAPYH7Dz7nJ30cPPrvi
         mtAQ==
X-Gm-Message-State: AOJu0Yy5bQJfVH3W9LvxSWRISFaPbLcqukTQaHgnoKwDhCJ/tCuqWH0/
	nDHxKL1am2NE8NOsQQyjMHPVY8ge81/KpP5kNVpGirNyZCyTiY50rDk44LHE+1umgGlpQO+3xOU
	Z
X-Google-Smtp-Source: AGHT+IHjvOu6hyRE3ygRFWef/1BalNu0op125LAKJ/beK//izRYTbCdLC1GeDBScDFoz4PIFOxslbA==
X-Received: by 2002:a17:906:f2cd:b0:a3c:c87a:ed3f with SMTP id gz13-20020a170906f2cd00b00a3cc87aed3fmr781257ejb.63.1707738936686;
        Mon, 12 Feb 2024 03:55:36 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:36 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 24/35] list_lru.h: move declarations to list_lru_types.h
Date: Mon, 12 Feb 2024 12:54:49 +0100
Message-Id: <20240212115500.2078463-25-max.kellermann@ionos.com>
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
index c5ea7eb41bca..c2e21611496e 100644
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


