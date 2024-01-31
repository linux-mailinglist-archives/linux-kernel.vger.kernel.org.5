Return-Path: <linux-kernel+bounces-46655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F795844259
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E54B2F32B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF212FF60;
	Wed, 31 Jan 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gsncrpgs"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5412F590
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712643; cv=none; b=jsiYus6KrZtvcq8mfY7i+O/tb6kpwxdhpf6VSNeY8WsI4U09eNFaHyhSCBiu+gMQxpEQpPq9/FQLiPj1gQzdDJkXaoxcMbtWFjYm4aZEeS5pyShxYoXJ8aq1i9ldCiEiNtNsNha3gb7u6JDt2y9rh7wHSY0xi+85MEWXwyeuPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712643; c=relaxed/simple;
	bh=C4ShLS9IawLE283Yr17KGnCMG09qMSOAu59IfLlImGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jn/LjehRPjm0xzPmfdt5jzfaObF1CMpvETUyjCnSIsIP+cTkHEK/gbcdtFWA2+Sv6k+apgnd5hKK3wAnWnPBKT22RxToWvvxUBuwjP3F7JDY6vJNqosbScylDFuuFNceXZ7t42MFZf7G0lpVA32fSYQahmQgq8wY+VuqpeuMigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gsncrpgs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eac352733so56902185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712635; x=1707317435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pg8H6hpxJZL/AFSFNbysWj/QIbqYWxi5V6pxyQrCWNA=;
        b=gsncrpgsiQAYQ7gq1lcb2JYbugWwdZXRaeDeratEtoizObp8LWYy0fpofVYxdolq9g
         ZiaV87z9WqL6O4hQ8Fl/HgUjCtSE4Zz2rVdYaUrlT8cGOuNnWc2Tz8gP4cHB3YFYgHlG
         IzwgyInRgqzDC48TAJMj8QXSr2lEbnH1HTeSxD1/iW8lNT5gmS3tKUFprSvVtTQqjBCt
         DqIfF9gmYGuu+9kksxZqW2zl4B5/VOE+XNVFXW8AKKA2SiJOkp5nuW7jrl/yPknF92sw
         GJVjI7+6KOAf98c8H23pvoVAWlhxzqZWpjxkDCSa19ACnaiJCZXAPOdh/nttaJ3K/TbG
         9Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712635; x=1707317435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pg8H6hpxJZL/AFSFNbysWj/QIbqYWxi5V6pxyQrCWNA=;
        b=ub4qIlLMyJbPRXtubjRgCFnhcPhiAHh42/+jofYGJPwCKAJxVEcqM11c9JuubPjv2I
         iUzgWkXMhyj2/dP85Yf/8mAxUZmqL8Nhma62EH3met6mIkdICRyIIA/1GsTXG7yS+4iN
         O561u4QooF56ioPyKvbXJwkNBmiySzkfmkLThkY+bo5nHXAOD9zzUWNUd1vE1BWUu1qP
         VValTidyEpcaoZ+qpDm07Jjj8gtvcsSNArEbfIcWbZrrzl/ip9tg2vZBZ2/cTcEoU409
         wsZF2XARdcgM+toiMjRJHIMQDPtSbkJ2m1dBpsYZvMcBDPc/0DUqzTLH666zzfi/ydrR
         dxfg==
X-Gm-Message-State: AOJu0Yx+tNT2nuhafLNqxeS4nGzQnLzIOcDeQMoKAwJpIU+XrgTLFIsb
	2Nzox473VaYUJoyVph5KWNbnjY2vcO17cM1xsyVStnhBruEJOj8AXVdJtI93TkB4wVb4mSADz8V
	a
X-Google-Smtp-Source: AGHT+IEO0N3eLnAsAmIRF4tU74e3D9vDj0m8ZGXFcgIpbz7MIYRFQbMtDQ2xLKHNL4roYgnJ3G94fg==
X-Received: by 2002:adf:dd8f:0:b0:33a:f583:7090 with SMTP id x15-20020adfdd8f000000b0033af5837090mr1387660wrl.30.1706712635404;
        Wed, 31 Jan 2024 06:50:35 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 24/28] list_lru.h: move declarations to list_lru_types.h
Date: Wed, 31 Jan 2024 15:50:04 +0100
Message-Id: <20240131145008.1345531-25-max.kellermann@ionos.com>
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
 fs/super.c                     |  1 +
 include/linux/fs.h             |  2 +-
 include/linux/list_lru.h       | 36 +----------------------------
 include/linux/list_lru_types.h | 42 ++++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/list_lru_types.h

diff --git a/fs/super.c b/fs/super.c
index d35e85295489..a1d4d9dfa79a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -33,6 +33,7 @@
 #include <linux/rculist_bl.h>
 #include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
+#include <linux/list_lru.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7b37a22c9513..06eda3a4fb52 100644
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
index bf0b71faa059..3a72e8cde939 100644
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
@@ -29,36 +25,6 @@ enum lru_status {
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


