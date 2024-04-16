Return-Path: <linux-kernel+bounces-146408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1BC8A64E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FB1283C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911BC15A4B1;
	Tue, 16 Apr 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMRSYHw7"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5415A482
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251874; cv=none; b=cFt7B/rXqfLx7deXOmBSPbIbxpZY39i6kI9zq0+T86kFRd6cW8ztuearTqJ5ciaV8lq8mn1gRNaBln7rb6Huj/S42FwF7eAPTAsb4uq/tD3Rtk5mCLbPb2sjvslmVJkhzLTdOq7DHmbbJl8uw0JkHggpofDUca2EL6h9mtxDuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251874; c=relaxed/simple;
	bh=55gbjDjFA8TyGhJfeRJbHTOAEYaKy6v7j3ItuuPVYIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxINrwdQ5DwsuYaDq9xscIJvvFZPMS2zhwQGqopZDtBxMLC+nyAS+4dVQubNzn+2OGwJOqBzZrzpz+ZNBBi9ZiVAj93uLMHr0Cbdh5z43FQmXP9B33THZN3ODvmFtuwWUFbsWTg7s+v0MiTvfBb3HLzqQ+j3jPJmtxSUr7WQZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMRSYHw7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ee12766586so2674318b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713251872; x=1713856672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MHV2+XE+cugEfsKZfQ4KNnLWAEqkFV7dIjX6To9XLTs=;
        b=AMRSYHw7IAAzIzWaFhOvbdPbF77WNy6uOW4Y4rSnOKBCqt7KohKjhvcOtcrkg0v1M2
         BQS+E32cxaUy25h0+p3YfhldDCZXIskywT6G8iOsCXbN/sV1VmHzgGQrLjVPj3yCSmpK
         l5Ap1qzD6fqS1fDO5g4vcCedL4x2Z21GWEVlt9+YuLE4KvqdMY3ecc98zrNjZx6GLnrw
         Mx+iU7+GiqfQsf2YXZYljO8xQDC7HBjcyvgB2dK8m7NztiYquKaie7b9ZNnUWBYtwJWz
         BC8JgfwtX6iSsTdv0OwcSY7ThZT7k4dLLf0EFf4gA699oIlAso4c2CJtThzp10EXvazz
         M3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713251872; x=1713856672;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHV2+XE+cugEfsKZfQ4KNnLWAEqkFV7dIjX6To9XLTs=;
        b=ir3oenqenIT8nQmnvfKiRv1OXyqOPU97cVrIhL09LaBc6F1VBRRdJbdnppiJZPQev4
         +mmIyqfARh5zmtur+FMNHX1EqlRersNZU7XZvfBzqHLCnxOkHPvIMeaTmYrHHt54BWEY
         zfqlbKTuh71mt7U3mpttb5ndsxoK57u6Kjg/oW9xk42Q81qdYxSfd0m4FHdIElzAaN1S
         lbt8Akvp5OL1Fp2QoWsrV8s8ZE32AtA1kAIhGkncZ5cPSn7egF3+d/F/HtO5F/1vm9Zp
         Lth6pnSTVkKrEL79Wl3gBGjD82Vx71TMvNwmYIblqSqCIOJRIZLBIQK10ZU2Z03C5zr5
         j7MA==
X-Forwarded-Encrypted: i=1; AJvYcCUKuoC5gXj9tOrPo0K2hanp7R/SQu3BXmdmCsM++XVosh6gJFhSi7QNcv95lP8VkIbQK+mFiYcMidXf2XfmPCfVAjpxyizVIvEm8tS4
X-Gm-Message-State: AOJu0YwDwn/wKwdPi2e7mvYCm9TsG04Xnw2mNZOl6EzTK+NnPRwK9hzZ
	Ewj3mBMplNNjingkpQaCHaRvg2HBab/KzaOOabfTu2CXyURt1Xl8
X-Google-Smtp-Source: AGHT+IESJwVhtcMf3m99N3mRkzrlYgFLHCki4Z3/LDKtQDjTD4+lFVo8Wfkqwv+ogYZO1JOFNTHWzw==
X-Received: by 2002:a05:6a00:39a6:b0:6ea:9b37:c288 with SMTP id fi38-20020a056a0039a600b006ea9b37c288mr1644456pfb.15.1713251872585;
        Tue, 16 Apr 2024 00:17:52 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id lr48-20020a056a0073b000b006e724ccdc3esm8340029pfb.55.2024.04.16.00.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Apr 2024 00:17:52 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 3/4] lib/xarray: introduce a new helper xas_get_order
Date: Tue, 16 Apr 2024 15:17:21 +0800
Message-ID: <20240416071722.45997-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071722.45997-1-ryncsn@gmail.com>
References: <20240416071722.45997-1-ryncsn@gmail.com>
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

Added new test for xas_get_order, to make the test work, we have to
export xas_get_order with EXPORT_SYMBOL_GPL.

Also fix a sparse warning by checking the slot value with xa_entry
instead of accessing it directly, as suggested by Matthew Wilcox.

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
index 39f07bfc4dcc..da79128ad754 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1750,39 +1750,52 @@ void *xa_store_range(struct xarray *xa, unsigned long first,
 EXPORT_SYMBOL(xa_store_range);
 
 /**
- * xa_get_order() - Get the order of an entry.
- * @xa: XArray.
- * @index: Index of the entry.
+ * xas_get_order() - Get the order of an entry.
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
+		if (!xa_is_sibling(xa_entry(xas->xa, xas->xa_node, slot)))
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


