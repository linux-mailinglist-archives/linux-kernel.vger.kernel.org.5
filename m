Return-Path: <linux-kernel+bounces-60754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96B850925
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5972810B4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923DE60252;
	Sun, 11 Feb 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dBvMTNVW"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEC5DF21
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654645; cv=none; b=RMZEoGpLAZNCWnyqTn87cjoGzelsnipNTzocTlctyA507DTC+IlcioPNKKNDOerriZ8vs54F5ICn66HiRy0nY7g5a67ovHUhOrSxGwCAKwbjWZ+EFrdM/9fjQkUb/wAiNB/GFCxqPA20AXfnK5MF4lu4O72VldjVetQWeR297Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654645; c=relaxed/simple;
	bh=VSrPFDVdzLC5KglvVyGoKnESxlS/kGrz7MitlkFgb3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATOtMuga7lUGlfeNZDD9/HH9w4hACQJ4Dsbpi9ttA5TzvEreEmbbF4xdLHDaO3rhCXptfj9sGlexT9FzCuHQsYemrvwF+hy9m9gZ3zszWMnAnRLnhN+5RxmsVFYM7ROU6reV4JuLhUkJbwln0tFevBe3kj1Zr18czscRElZOpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dBvMTNVW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so34356751fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654640; x=1708259440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=dBvMTNVWMJaGqJ9qHGOhh7fj8C6MczyXIdoJ5nxNQiDRzGobL2eLvE0X7fssN9i0uY
         BVFAThvreu3BxTbTwN24EyC3R9/tGD2h+UF5oZhbFXsVH8oAsK3Gp/F8naypv2/Gb3VI
         y5tDPGm1m2DbVfCmRmLc7DGMhAQy9JwZ5vTEPHwHjMsnIwE+0jskNjdd6nRxgZYHNi1w
         3JyLZEZVksa8OK4Tpf1eN1ZatbTLAGYU49azzj0pUn04oK5bcaQFPLiI08/cj/zPMxds
         OeQcDgI2xBKu/80Qjz9NM/JwKEwc7vqmIrvDjUlYklwsw3Z5VBHJ/tscPbhmtmkVVaA9
         TFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654640; x=1708259440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=jvBn+fleJQ/dMA94wVFYVu9GXpnV8g31OAMFh9wXClsRLO2vNvJ0LhwmmT3N6eB9qz
         U3VJuHNfEuWyVnAEthZ9Et7/Qs3IeHVJICTSq9AwXUDntkQZwQPhnlkWWxC8ANKdCpfq
         TFkpfZqDnb150+JmWnNA4wEVevuM6F0ItW7YHtKItV/kUpZUaOp2jd2iWcDwRuu6hh6Z
         OtINd+Xrvd9IkmBRrxadfINZnxm/ItPZ+cjCIbvvZ0pssx2ztG2fd1V4Ml9WQrel3/Z9
         57EzZTZqZePgxT1EQYkzhX+GYZS00P8NeMwXuRuoQDgNPd+S8meDXFBmRfX1VX0/nOeN
         cl2Q==
X-Gm-Message-State: AOJu0YyWx3naTnJcCFw/EsxdaaJG9UsloVlcbxeXJr5fZeEKGpuIqEEX
	1DbRNTJwgyAD0YmlNwwhPLlB7I4VlhAmKWtF1NxnRMxgxHcArmp7xi0Hk+yqHyYMWCp8/qDhMES
	m
X-Google-Smtp-Source: AGHT+IH9JilEdKICNx4URz+uNEuVVWu9KbAN9maCjWGwVMvK5F/knrbAlLTRS9QWzd8nC69KQEToaQ==
X-Received: by 2002:a2e:9d87:0:b0:2d0:c7a3:e97b with SMTP id c7-20020a2e9d87000000b002d0c7a3e97bmr2536627ljj.0.1707654639734;
        Sun, 11 Feb 2024 04:30:39 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 25/35] list_bl.h: move declarations to list_bl_types.h
Date: Sun, 11 Feb 2024 13:29:50 +0100
Message-Id: <20240211123000.3359365-26-max.kellermann@ionos.com>
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
 include/linux/list_bl.h       | 19 +-----------------
 include/linux/list_bl_types.h | 36 +++++++++++++++++++++++++++++++++++
 include/linux/mbcache.h       |  2 +-
 3 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/list_bl_types.h

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..39c14b6bad71 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_LIST_BL_H
 #define _LINUX_LIST_BL_H
 
-#include <linux/list.h>
+#include <linux/list_bl_types.h>
 #include <linux/bit_spinlock.h>
 
 /*
@@ -30,23 +30,6 @@
 #define LIST_BL_BUG_ON(x)
 #endif
 
-
-struct hlist_bl_head {
-	struct hlist_bl_node *first;
-};
-
-struct hlist_bl_node {
-	struct hlist_bl_node *next, **pprev;
-};
-#define INIT_HLIST_BL_HEAD(ptr) \
-	((ptr)->first = NULL)
-
-static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
-{
-	h->next = NULL;
-	h->pprev = NULL;
-}
-
 #define hlist_bl_entry(ptr, type, member) container_of(ptr,type,member)
 
 static inline bool  hlist_bl_unhashed(const struct hlist_bl_node *h)
diff --git a/include/linux/list_bl_types.h b/include/linux/list_bl_types.h
new file mode 100644
index 000000000000..84229bb7bd02
--- /dev/null
+++ b/include/linux/list_bl_types.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIST_BL_TYPES_H
+#define _LINUX_LIST_BL_TYPES_H
+
+#include <linux/list.h>
+
+/*
+ * Special version of lists, where head of the list has a lock in the lowest
+ * bit. This is useful for scalable hash tables without increasing memory
+ * footprint overhead.
+ *
+ * For modification operations, the 0 bit of hlist_bl_head->first
+ * pointer must be set.
+ *
+ * With some small modifications, this can easily be adapted to store several
+ * arbitrary bits (not just a single lock bit), if the need arises to store
+ * some fast and compact auxiliary data.
+ */
+
+struct hlist_bl_head {
+	struct hlist_bl_node *first;
+};
+
+struct hlist_bl_node {
+	struct hlist_bl_node *next, **pprev;
+};
+#define INIT_HLIST_BL_HEAD(ptr) \
+	((ptr)->first = NULL)
+
+static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
+{
+	h->next = NULL;
+	h->pprev = NULL;
+}
+
+#endif
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 97e64184767d..32ebbb428053 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -3,7 +3,7 @@
 #define _LINUX_MBCACHE_H
 
 #include <linux/hash.h>
-#include <linux/list_bl.h>
+#include <linux/list_bl_types.h>
 #include <linux/list.h>
 #include <linux/atomic.h>
 #include <linux/fs.h>
-- 
2.39.2


