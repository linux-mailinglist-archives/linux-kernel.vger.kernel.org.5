Return-Path: <linux-kernel+bounces-145653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9D8A5903
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDF51F2173F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E584FD2;
	Mon, 15 Apr 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfvGqiVd"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647D84D0D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201560; cv=none; b=nedkt5kOsyCFA3zTXw5K9lQGMW92eYupoq0FjgG0IXD1964FDhTO9MAMMEZXODYnXkAa9FtWLLMNFKxwlIdOGghzKV/KziQaOQmTFpTBUTpSYVcskE0kS33Ngc62QfLoWiBuLbyRwBZOjL8mV4i9Eo+DGXLm3R6m01IjDOdb2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201560; c=relaxed/simple;
	bh=1n8aWgPGqTpkEn1L9GhQ17dKsC5Kuq6hSgWoGawRKkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H44i09csJK74+4kgS+DgJXao3+cD1CFDem5M/KzUoZfh/JTiwQuf7P5a6CqVZe312Kl4Vp4cklnQUwufl4Vz0WmsmcnoRcKNHq29nifCRbMrHengBXermRToBXLMZsb5VI9JwsmZcbXiWF5M9kI39Ym6Zvs8wF3O6kP2iISPW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfvGqiVd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so1932858a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201558; x=1713806358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEjwwoQAn8m3grSTrvNR4sEkOR0nGA3RJ0TZjOfUHm4=;
        b=JfvGqiVdOdWhdDkOgUZR9JXwXkSX0Ud1g4N0Wqh7ehPrmbdjPBE8ovrxPrKBVy7Mvs
         HquYTJcxBS6ymJLexZv+oJHZHrGy4Ne+eghntY1eNVFtp7hJEYHaiMZLvfXAtAf3Wq3H
         Os9PWQdPy4rlFZ/WTvH4s3gCe35B/QVjGEMtbM6Lt8YpHbujKuWPuFNFu+bTQu/V46zx
         mQdK7Ffx51oTagm4m+Mdx1sjWVly0CVYb2E2K9yJhWNUfxlFSNVG/0hzEyY9BqdqN7F+
         BE1vcpWwWvGnBVN7Rm3NoFWqDLtHbFbSOgNsKmv7fto12pwBAZcP1BK5FsaaR1D6CMl5
         wC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201558; x=1713806358;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEjwwoQAn8m3grSTrvNR4sEkOR0nGA3RJ0TZjOfUHm4=;
        b=b1+AoQIvMRyOGaNJACOfvM+AG5CqbMrIQEbtyYL9uN4HsmQfyiitvjPlA27Njs9UGO
         iD4ziCZ4wrtDY0BS+8X1u2ChYf0D0UntS9seYvgTJZsY3/8RnVK3ImJgMZNIU3YAwSMq
         3XL0r/c//vjmKJfNnZb+a8s7lBQftBYDYABrIxId9GA4ziN16JPwH6OjFo+E61dv6UQ9
         5qpK878qHMqAmeaR95EwnpuJWyp08/0GQhGGwc0YOVgEZ1jDoJuXmcke1+JiCp+GSqby
         8pkpc+jUYtkm5lwN6e3QaVa4RJixpa54HsNT9yDwpccwabcou7JzWbb5ysdy1fcrJcP9
         fCeA==
X-Forwarded-Encrypted: i=1; AJvYcCWEE3acCY4J8xVLNoyr/cHJvUG2C6ZnNu8cmbIZ0YAeIhAxPUbYOOCSMCcMdV2Mi7hiDVErpglCzfEvpaLtbl3sd49LWY6JHwAfihlp
X-Gm-Message-State: AOJu0Yw+omAv/9WwHT6sojQ7Kbslz+tPocJmqlQtaFZY2hLDRg0JwOXg
	1e5eI68PzP1kvTTJUR7R0bxsGLR7amO66V9tCezCH2t3I0yralGtE8Phc+Xt
X-Google-Smtp-Source: AGHT+IFva3FT+6Qo1iTE2UIbKwGFak0JgfA5Q5ANtjD68Wt1gDflM7XbEgZEqtWRZbI/FtzxK97aFQ==
X-Received: by 2002:a17:90b:3d3:b0:2a5:ba9d:a06b with SMTP id go19-20020a17090b03d300b002a5ba9da06bmr10332693pjb.5.1713201558299;
        Mon, 15 Apr 2024 10:19:18 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a537abb536sm8751648pjq.57.2024.04.15.10.19.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 10:19:17 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 3/4] lib/xarray: introduce a new helper xas_get_order
Date: Tue, 16 Apr 2024 01:18:55 +0800
Message-ID: <20240415171857.19244-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415171857.19244-1-ryncsn@gmail.com>
References: <20240415171857.19244-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

It can be used after xas_load to check the order of loaded entries.
Compared to xa_get_order, it saves an XA_STATE and avoid a rewalk.

Also add new test for xas_get_order, to make the test work we have to
export xas_get_order with EXPORT_SYMBOL_GPL.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/xarray.h |  6 ++++++
 lib/test_xarray.c      | 34 +++++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++++++++++++++----------------
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..d9d479334c9e 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1548,6 +1548,7 @@ void xas_create_range(struct xa_state *);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
+int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 #else
@@ -1556,6 +1557,11 @@ static inline int xa_get_order(struct xarray *xa, unsigned long index)
 	return 0;
 }
 
+static inline int xas_get_order(struct xa_state *xas)
+{
+	return 0;
+}
+
 static inline void xas_split(struct xa_state *xas, void *entry,
 		unsigned int order)
 {
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index ebe2af2e072d..0efde8f93490 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1984,6 +1984,39 @@ static noinline void check_get_order(struct xarray *xa)
 	}
 }
 
+static noinline void check_xas_get_order(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned int order;
+	unsigned long i, j;
+
+	for (order = 0; order < max_order; order++) {
+		for (i = 0; i < 10; i++) {
+			xas_set_order(&xas, i << order, order);
+			do {
+				xas_lock(&xas);
+				xas_store(&xas, xa_mk_value(i));
+				xas_unlock(&xas);
+			} while (xas_nomem(&xas, GFP_KERNEL));
+
+			for (j = i << order; j < (i + 1) << order; j++) {
+				xas_set_order(&xas, j, 0);
+				rcu_read_lock();
+				xas_load(&xas);
+				XA_BUG_ON(xa, xas_get_order(&xas) != order);
+				rcu_read_unlock();
+			}
+
+			xas_lock(&xas);
+			xas_set_order(&xas, i << order, order);
+			xas_store(&xas, NULL);
+			xas_unlock(&xas);
+		}
+	}
+}
+
 static noinline void check_destroy(struct xarray *xa)
 {
 	unsigned long index;
@@ -2035,6 +2068,7 @@ static int xarray_checks(void)
 	check_multi_store(&array);
 	check_multi_store_advanced(&array);
 	check_get_order(&array);
+	check_xas_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
 	check_find_entry(&array);
diff --git a/lib/xarray.c b/lib/xarray.c
index 39f07bfc4dcc..fbf1d1dd83bc 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1750,39 +1750,52 @@ void *xa_store_range(struct xarray *xa, unsigned long first,
 EXPORT_SYMBOL(xa_store_range);
 
 /**
- * xa_get_order() - Get the order of an entry.
- * @xa: XArray.
- * @index: Index of the entry.
+ * xas_get_order() - Get the order of an loaded entry after xas_load.
+ * @xas: XArray operation state.
+ *
+ * Called after xas_load, the xas should not be in an error state.
  *
  * Return: A number between 0 and 63 indicating the order of the entry.
  */
-int xa_get_order(struct xarray *xa, unsigned long index)
+int xas_get_order(struct xa_state *xas)
 {
-	XA_STATE(xas, xa, index);
-	void *entry;
 	int order = 0;
 
-	rcu_read_lock();
-	entry = xas_load(&xas);
-
-	if (!entry)
-		goto unlock;
-
-	if (!xas.xa_node)
-		goto unlock;
+	if (!xas->xa_node)
+		return 0;
 
 	for (;;) {
-		unsigned int slot = xas.xa_offset + (1 << order);
+		unsigned int slot = xas->xa_offset + (1 << order);
 
 		if (slot >= XA_CHUNK_SIZE)
 			break;
-		if (!xa_is_sibling(xas.xa_node->slots[slot]))
+		if (!xa_is_sibling(xas->xa_node->slots[slot]))
 			break;
 		order++;
 	}
 
-	order += xas.xa_node->shift;
-unlock:
+	order += xas->xa_node->shift;
+	return order;
+}
+EXPORT_SYMBOL_GPL(xas_get_order);
+
+/**
+ * xa_get_order() - Get the order of an entry.
+ * @xa: XArray.
+ * @index: Index of the entry.
+ *
+ * Return: A number between 0 and 63 indicating the order of the entry.
+ */
+int xa_get_order(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	int order = 0;
+	void *entry;
+
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	if (entry)
+		order = xas_get_order(&xas);
 	rcu_read_unlock();
 
 	return order;
-- 
2.44.0


