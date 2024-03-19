Return-Path: <linux-kernel+bounces-107317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424CD87FAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8DB21913
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C007D095;
	Tue, 19 Mar 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klM9Doxj"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493A7E108
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841308; cv=none; b=T/55pWJz9TB8CBoSEKW9S9MQ60yFzlxFYmgySj/bgz0SCoIgwu9ET9GN/UGH/wq10bKmaQkxzfgfTyr+qZE0Rm6RELmX7DApuDRxkHMNeYo7nkZlo4TLJ2WKkzL68NwFz7dAYqfvd5dbnG6Svf6tHsurEkYF5ZXtIFirxj59C9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841308; c=relaxed/simple;
	bh=mVMJQpmryZm4Ru99nD32KvjTOYfibZ/pE4Lu/SnCZ2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKZydMT0E1XkOIjBifwKIN1rI1V5xFfoLdGYEyQcUOLR9no5qckqY86KGCtHF+waGRq0UIzJLQROwZ/BmaIsHsOI/CgCCtxdiA+tdUvosRYNHrRPBbyLB9UCyvuTTC1Wnvwl2f+DS9mj5l8sOF+e2yNwHj1wLo9hSy+dMMQ0qss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klM9Doxj; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c38f4e18eeso768850b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841306; x=1711446106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XqzN+wWZGV0/ntTi34b/frY6opMs0aB0oKSPnzSGTOk=;
        b=klM9DoxjF2Ehc7z0FLxAU/zfbaQjuRtkTMcp55NoMe/z/GPD0ocTygxKmwM7wLQhxT
         rtyN87Mrpo7HVA3DKBbMYFvImpeBt92+RKo+T+3509S3OzsruVZgMfQmHCj5qJXq1igK
         tvFLQFr1XnvaDgOs19AMsfaJqs4t/3bom58CuDsDsWWnZWTxf2+AdZeqMYMsGlTVF+cM
         5xspbkap/EGedOiGWsdsVqs9al5NXVsGfNQolgLkohanRsVdN59ylHRH9C+25T2RLOYX
         +GgbEw16cYJJRwKMFQQZMAh3rEk+3Bhjg4O5vxc1OcSoGg6zjmv9yqgx5Z3a6mcZb+gm
         HjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841306; x=1711446106;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqzN+wWZGV0/ntTi34b/frY6opMs0aB0oKSPnzSGTOk=;
        b=Z1Ofm+62QLdL8VRfTHCPKSLvjW/KuBlDRU55kGrRCDwVx2FEQaxRvJ6kwP//PpxZYu
         r4VFkE/MJEM/yjNRix+8eu/ju0FJA2bW4RPDyUSjGq4muRcDh5YErCOBCakKeH6nJhS+
         Pe7U4IFioh2G7uEwRUzBhhhV0bOBQvCSo+3FIovwK7/dhD2sGgb7C1pyu1cZfVJbqpGw
         2xw7FOb+vVGxHw1KA836QCktIMKXKwVkeb0omc3LaeA80Vg+r3RCLs3NEjuAEitRYM2Z
         X3TzVEzoU9xg5aQxPl/LxDJcZwbtgGAx8xG2XRpldy8XgIevz7/sqAEmYFSuI5WwLPVV
         x9ug==
X-Forwarded-Encrypted: i=1; AJvYcCW3XhJAk3WqqmazW28y/hcXfXTipOq+BlwXK5+tJGyX3rNaJsTMpIxJ0RcExdQ0GYaj1QoIkx6t5QO7LHr2Pwz548+AlFPLdbcHU9Mx
X-Gm-Message-State: AOJu0Yyc7BgR3NRPROVpcnGc55j6j4HUSV86EXRo6TABrxu9XHF7qa+0
	cukYSYLAZHcldKq1MQwo5+n279sHPx5DnH/4c1l8GXjjDbVd12P1
X-Google-Smtp-Source: AGHT+IFpWzLUcgwPhIA7GrafY8so+K48aVsYG/cukRTuKwm2t4oZkaJoNlfObveyt98ye1pVmlIUsQ==
X-Received: by 2002:a05:6808:180b:b0:3c3:82c3:ddcc with SMTP id bh11-20020a056808180b00b003c382c3ddccmr2678100oib.31.1710841306463;
        Tue, 19 Mar 2024 02:41:46 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006e583a649b4sm9708761pfg.210.2024.03.19.02.41.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Mar 2024 02:41:46 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 3/4] lib/xarray: introduce a new helper xas_get_order
Date: Tue, 19 Mar 2024 17:27:32 +0800
Message-ID: <20240319092733.4501-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319092733.4501-1-ryncsn@gmail.com>
References: <20240319092733.4501-1-ryncsn@gmail.com>
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

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/xarray.h |  6 ++++++
 lib/xarray.c           | 49 ++++++++++++++++++++++++++----------------
 2 files changed, 37 insertions(+), 18 deletions(-)

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
diff --git a/lib/xarray.c b/lib/xarray.c
index 39f07bfc4dcc..88fbea481e1b 100644
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
+EXPORT_SYMBOL(xas_get_order);
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
2.43.0


