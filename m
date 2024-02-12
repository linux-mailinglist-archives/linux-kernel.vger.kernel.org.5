Return-Path: <linux-kernel+bounces-61486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DCA8512CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCEF1C22102
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0E3D571;
	Mon, 12 Feb 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Gx2ArU47"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1B3B2BD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738943; cv=none; b=KSux2QWAMkZ1wov7d1qLroZPJ5fnSiJDtBczihLe9EooMeRloFCmmfBXYoq3qmCmxe81CV+BGFYis6pLiP87TdcGyDIOyWNCKZok1zV8VuACeAvGFGOsfI1HRIDvDeviAUTUk6E9IPjzHqjqsShy+anevcb8/6MvoTOZ5HlbYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738943; c=relaxed/simple;
	bh=VSrPFDVdzLC5KglvVyGoKnESxlS/kGrz7MitlkFgb3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VE+W0/Sli2XH1hz1xiUGlJ6QfC31ymhRze6cJxVoe+TtSIUTkNhdrN58m7Y70teB7FcR+UyXcDN8oH8eQtD063c1LeJKPGo6s7L8iVCTc7cjZv7ckWNrNZl6pYTi2HcSIjYB6yqGKDO9QhaL6OLQrlDHWSE1VjiMaTruC2VZWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Gx2ArU47; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so395701166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738938; x=1708343738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=Gx2ArU47SgdRjXfG7Bzpfavn8hbW/ALlf0xPv2ZTUgyn7tboRH1oUMkSav583FP268
         XCRzfeaRlFaOTv9QaYuB2uz+iYI0BBaKnscNyuinuPRGjgozhxrml8Vio6kMFPvvaex2
         9kfIl5ZFTkJtncoOj1ZiOWcGgBxKnmcW11Sc+QWvIWcJza5aUwEvxysFD0VYhkRCuZOi
         qHN9ebfGUcTp/cHdE9slz/r2TF7zjMBRwe33vknvz6MCtQVjEZGVTzdPLWuSB7pNQl0A
         xlDs9CYrKsc4cMeP6AMYEGbdBRz8dzB6XtoGkxOuKh3dVWTwFOZa+byT85kzxfk5RI5E
         GCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738938; x=1708343738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=OQ1SF+jZLNTt/sEsRmAUYdr2MOlM6KDlJFQuIz+PrrWf+8FmSbUNVQgC9L3KjKT1Ky
         7w5MUZ3c4KVlVDi4WHNBaL8J11M0A91kM3aroL4GLtwSUhiw9ABQBrMZgL2sLfPfsy01
         MgmoRl47Bxzzl2f2hbj/srfXkSpADSoaQzaTr09FmUcj3+jbqgAwg2nq5GXx31oZopIM
         W3kA31z7cTdQk9qLupqvE/A4xOv1tJyzBY+x4Su1xCWaBxdZPJrSsbMz7TmExb91oMGX
         bmD9oO4bm2pJuh4HF9pzQATniE7xC9J+aSqdqQoe/AnuovcdVhyyG4rwmUSyZqh/hK1M
         FnEw==
X-Gm-Message-State: AOJu0YyvhpR5DLPTYP1ams1dJf5rsNShLwVW24pVujY11s0w4SxB8H5/
	XKSM9+4mpG7HxwqfkCkyNQ40AFR43IdyoJoN91Aqs6DX20NVonfWFeDmnr5WzBMbykhntdYfTLf
	O
X-Google-Smtp-Source: AGHT+IHYZz4CsE5D23nlpAsKj/28tXASidKi7e0nkYW2E5hmc+MwZGvXn4dUk5IdL8NBpSNxA6tM3w==
X-Received: by 2002:a17:906:6893:b0:a3c:1046:93dd with SMTP id n19-20020a170906689300b00a3c104693ddmr4870430ejr.31.1707738938125;
        Mon, 12 Feb 2024 03:55:38 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:36 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 25/35] list_bl.h: move declarations to list_bl_types.h
Date: Mon, 12 Feb 2024 12:54:50 +0100
Message-Id: <20240212115500.2078463-26-max.kellermann@ionos.com>
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


