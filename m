Return-Path: <linux-kernel+bounces-59644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA484F9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922AC1C24D09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516FC1292F9;
	Fri,  9 Feb 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="AuGs8ph3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161286AD8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496875; cv=none; b=fksfQYsDjVbK6axdWwAmqe2cP6Ct/ZMWgq6knoAXn58/DrVl6OQSng7TaLdkZiwNN7gEj1kk5bMysrWvsvCWl0qYKSF9qIru2DGQOqJPHD23iI7FRBO89XoNRLRJFzplgAx6VX3V1suwc3bI6U3mjs0AuM7cwWoQReFQYNxrmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496875; c=relaxed/simple;
	bh=VSrPFDVdzLC5KglvVyGoKnESxlS/kGrz7MitlkFgb3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tz6fcJbzO4ImSsTr+oLFJaaNhXVqTPLIM4lWPHrRZOYWj2Qzz9+iAMY8kcr30Ct9XB2YWlkqdmtWJt0WCuZmZjxDBc0U8g/vgORTjPRM7UaYipdeqU5SOEbm0W9X3FUi3V8LNosoEKfvTJSGU3NrUAVIPjjpDzGzFb9JK5gBXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=AuGs8ph3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3810e975aaso136053566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496870; x=1708101670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=AuGs8ph3dul8t4u60P74gEYMOxZsDQ7FcNn6k9XuxjrUKutVk9V9Ee94SPnk/iLp7/
         nwdT57uvfJaPdfg5qFXlMZuHGL6gM383CsdpdUATyhxqoJ7cZKTCaDOASU7cdI/Cxmi/
         /AghgFMk6WmzPeIxZI9gJ4ITf/plxqQbn9mPf9pyGiZHaLSZeFccNJivQYcW0u3kV+rr
         0cAsmlww9XWw3C6vcpRrfyZweRgczDzSbRwBn+rJdxYIKz5Mj9QI/Cvp66rfPNUwXpfY
         VzDGEQcnetrNBkddxLxx3S0F9M+M6buGA36kLEVa1B6u2+C+cmoAOrI3x2KkWPEDkXNG
         qUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496870; x=1708101670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=NLonM64sRkKgGLnzraCmOFa7UnAmXxipvEnrVg0UQL6txk3l+mOOZ8Wu53ugAiJ/BM
         179vIVm69kCXByyogx1+AskBGihwtUB+dbo6jk5ffkyTe+F32QRdzow3J2x0mRDAjEaV
         ZnnJYuzg95NZ6IrtyhdUfZdqBfomaDi2gebYUVdhf1IzqhlvlN3zPP66ITva7SsrkvlF
         egQQY7f5LBLQXx0tvcshChtUMU8O6xLkthfCd96Gh4MZRxmri0/mz4HaXPgwFucpyVqQ
         y7S9XBL8CxmQg6ccbQNEQ+nV6MYaP+u2ZiIwztDoqTYJbDIeqguhKYSpSJqojTp99g2G
         cMyA==
X-Gm-Message-State: AOJu0YzdTLl/7JCXfUJXhpsgb1aLB1N+RV0B8QJiNgIaK+6e2vHb1q8D
	VwGP+2RQrLcfLFJZLI12pZyYwymdBXKO1Nu28OJU/hwLkieM+fib467uKZiJ5JZa6pS2K8+qWul
	8
X-Google-Smtp-Source: AGHT+IHrOu/C5GHNRQh1wqVwAfQEo/zxR6PUQdF9A8n4J6a/hLkUi3PkYKhzB2ifv58Ku9lHlxFKvw==
X-Received: by 2002:a17:906:550:b0:a37:1c56:8979 with SMTP id k16-20020a170906055000b00a371c568979mr1712130eja.76.1707496869840;
        Fri, 09 Feb 2024 08:41:09 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:08 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 25/35] list_bl.h: move declarations to list_bl_types.h
Date: Fri,  9 Feb 2024 17:40:17 +0100
Message-Id: <20240209164027.2582906-26-max.kellermann@ionos.com>
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


