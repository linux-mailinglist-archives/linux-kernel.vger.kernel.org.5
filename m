Return-Path: <linux-kernel+bounces-59642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9884F9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49CB1F254E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6098128834;
	Fri,  9 Feb 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Us6OVA62"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB984FAD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496874; cv=none; b=BwkmwIIFKx5EbmEyPCk93GAZMIAPh5xI6HQd/LDf39vKMwPEUxLmhj32oGTCWzw2BWklDBB1rDt6QG+M4rmLd2jOXbzHyL+nhZcaHTfJezTTzjv1NX+jXzh7bOqPoxG6/7/Un5UFaqP4hrLhBZDZdUmOk4cXoVIySV+S2pJLeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496874; c=relaxed/simple;
	bh=M+TCf4sn0Vj4ZvvDThMshhJMhSj/72BJZc8cZVfWfZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcCxbflKlHvZJj84hUbbsn2eid9qtlgEvwBVvgnj+VyYkGZej5Ipko+KAmeZNZBp+GtsV3BYMnvzZUvgnWONVsqL00gFlhZtJm0j6TAk3J2mE6YsOB8WuIDGR7zb/HI+o9Jdqh7lmVtFfhBo3XPcolqmglnIjM4KsHaTzxton+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Us6OVA62; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3566c0309fso136939266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496868; x=1708101668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33wlCo9DUXvbQxRFpboMlES43uYj+ZzSbFUQMwIDJfY=;
        b=Us6OVA62LnLLkUH4NF8Cti6zodvDKRHKjYGoc52pAMQjb+VxGzrVj53zjwu9GRCtNy
         3dP2uDkXjZ0IqXety4C/fkYg8k6SJWzT/LWu8bisfPTGrEUJh5CzVBQjPDRs094pEh8e
         k3M13zuYX2c1eiWSs4T/y381cEAg+r8I2FSeV8dgmLkLTOFinRz9L5SfPPR5ssDN5iMc
         5AtfmjqMIOSNuoNYKmm8CwRgx/sWhCOAMGGcYw5Gp1FN30kP2EhJhM1DD1liuk8/byZo
         9Ie/in3BL0JwMwIDekpBh5tGEDnXX0MOSJ5oepla5z0rFDv0KDzyaY5FRPbuVzm6bgCK
         lKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496868; x=1708101668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33wlCo9DUXvbQxRFpboMlES43uYj+ZzSbFUQMwIDJfY=;
        b=pptyjnVN685di6Q/aXiW+5LpKeuAbGGXuePKrSKZA6IKWwzlQhVPYYT9P2xbMjKH2/
         h3DYI/Y6fJj7drqmHDDVmD5D64YV+szsBdrmlPOJ2T5EY6mRaOKiMpaoYS777wqlpRDq
         cy26knZnd/IDaLwJ+QRllgtFElvVwc4Vp9ibGmEbICEjvzQ94HH54EpwXP6duGc5c99B
         UtP6N0tkx51sWID0iAaeovHXrM5SHP5R5oqDzP1KfTMp6ovxLmncAkFsJUwcOU2u907E
         d7yGZM+e6Wp7cZCta+ipbjaNlIHEC0SLiNU3H9nZg+KdqUC79GFKIuT6MgasEPQiFR1/
         X0pA==
X-Gm-Message-State: AOJu0Yz9bcLPt7xWmfVMeneN05ueHfizsYgnicWGVizl0VtyUrqo26In
	ejrzQK+KZMKAwwlZpjLPBDXl/dISpztF3v+0t+QduD/oDQyGCieIvu7LIDLon9988Z+Wg5Sx2Aq
	n
X-Google-Smtp-Source: AGHT+IGmVo27S7GapDAOtFGz/JKdPoAJgvAZYv+A5VtWgIYebpgXxxA6Fh+X35oi03/upggsXjCliA==
X-Received: by 2002:a17:906:dfc9:b0:a35:f2a6:3172 with SMTP id jt9-20020a170906dfc900b00a35f2a63172mr1409420ejc.43.1707496868453;
        Fri, 09 Feb 2024 08:41:08 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:07 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 24/35] list_lru.h: move declarations to list_lru_types.h
Date: Fri,  9 Feb 2024 17:40:16 +0100
Message-Id: <20240209164027.2582906-25-max.kellermann@ionos.com>
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


