Return-Path: <linux-kernel+bounces-43757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089284189A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B90286D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD55157056;
	Tue, 30 Jan 2024 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="LE+YoTTC"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD154F92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578958; cv=none; b=q+7YfqYFPNo0Q4bxUnYXgtslOAarXDd6FiMps4qFg+IfTP8kVx5y4biC9aL+JjeIZWH4XX6blhsPco/gX2ucpbzSNHPIXHFN1m8oPmAoVGJ30+nPffBbkClt3VB85F0PxoyegaNYAVmE8QFjxKAK4V///E0DBdjIH9TY+nAR7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578958; c=relaxed/simple;
	bh=enNppWOMz5X+Bo+gNc3K2O0BwrrF0fPHp/zDjikXOCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw8fWQqYU1vbFglxSXFGn4IoqjjAyIqqvpykCkXcwPl1w/0g0SCSDr4GGxCFVRllaTXdhcwCg8MAw2WM6Cfzq0OYiN5wEF0CxCkX2vHUBxUQOtfk5LCRqXOlHUlGqQgKG7rkUFSd2FWm3yPqvBM+heJ9iSPk4fk91jnZyWQ+if4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=LE+YoTTC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818aa07d81so24778326d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578956; x=1707183756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWfrSpQCJ73gDMIVUCgMZppF172UOPzzTZlrxOiNavU=;
        b=LE+YoTTCqqwfTT9UXfvlrhvq2ELx1LEgn7BWWqkcFObg0fsfHWTgGmclznOV8Kd5Ia
         1qWE3YubkkMFotwRVcOfoBPIHqPt0vylT7LA6ITj7Mxa9Ylun23jE3M2yd5GiBnWVicG
         WvRADvZqSgQmYWmKH7QVl6rIApd0nm7vKi79UjyicD8cjXfbPgwTQ+z7mNyM6PMKpf8w
         9x174L3k5ZCvYLkfPbe69pj9K4LQAIqHiCp3zo+DX5nEMmBPTaUhWPptK8ny4eRdQXpM
         7xPN4KQcIjLzcs1W8W5yL4pzJcj5/RrQ7rp+FxC9+05EHCKpLWDx6tezU0UwX2ESJXoe
         MoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578956; x=1707183756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWfrSpQCJ73gDMIVUCgMZppF172UOPzzTZlrxOiNavU=;
        b=WSu4WmLTzV2zPJ1hjeb/kQgq2MHD78xsDzIV/rw/4XI8H3rlQrR6evv9tHSehiSDVB
         selocOonMoDVWoAxK8zApZOyqXVTCsuyQQ//bCY2nEUZjIgijbIK4pKuEAB2/+tNa/OX
         UxwomwtaMHe3qj0RjhWQFEVcS0ClaOEh2sbob6UwmP1FuwxYH1NH27J8Me/NoAUaPiSy
         jTYIvHNYQQWpbXBQQdOyr7k4gn4U4eDFqZkv1WgVa1C6wQyLipbkTqFAsphsSQfXJFjx
         Yu1fxUP65qTEjfKcvghfFjyiCoC1SSp26t+a7y9yUvFADW04f0k7jO3ZjPEy6EyalCu5
         l0XQ==
X-Gm-Message-State: AOJu0YxQmLeuDmOiuUC0dc7SBl44gCBdZ63CDh9PeVDQk4At96nC2aRd
	SxjwcYrX0PMQ9Xklr782X0gbeaQWtGSgXYkcJ2dUEkq8CO887QTK8qTW87nkpyQ=
X-Google-Smtp-Source: AGHT+IEXs8SJCuuIZtfIF+y9ddQXhUqdNoy7qZLBVXx9Tn8aMjnAw4Zw+Z4ifp80mQOXs7/58wge/w==
X-Received: by 2002:a05:6214:400c:b0:68c:5ae6:de8d with SMTP id kd12-20020a056214400c00b0068c5ae6de8dmr1717725qvb.39.1706578955770;
        Mon, 29 Jan 2024 17:42:35 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id df12-20020a056214080c00b0068c4542eb0fsm2419516qvb.137.2024.01.29.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:35 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] mm: zswap: function ordering: per-cpu compression infra
Date: Mon, 29 Jan 2024 20:36:54 -0500
Message-ID: <20240130014208.565554-19-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-cpu compression init/exit callbacks are awkwardly in the
middle of the shrinker code. Move them up to the compression section.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 135 ++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 69 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 17356b2e35c2..acd7dcd1e0f2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -995,6 +995,72 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
 /*********************************
 * compressed storage functions
 **********************************/
+static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
+{
+	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
+	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+	struct crypto_acomp *acomp;
+	struct acomp_req *req;
+	int ret;
+
+	mutex_init(&acomp_ctx->mutex);
+
+	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->buffer)
+		return -ENOMEM;
+
+	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
+	if (IS_ERR(acomp)) {
+		pr_err("could not alloc crypto acomp %s : %ld\n",
+				pool->tfm_name, PTR_ERR(acomp));
+		ret = PTR_ERR(acomp);
+		goto acomp_fail;
+	}
+	acomp_ctx->acomp = acomp;
+
+	req = acomp_request_alloc(acomp_ctx->acomp);
+	if (!req) {
+		pr_err("could not alloc crypto acomp_request %s\n",
+		       pool->tfm_name);
+		ret = -ENOMEM;
+		goto req_fail;
+	}
+	acomp_ctx->req = req;
+
+	crypto_init_wait(&acomp_ctx->wait);
+	/*
+	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
+	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
+	 * won't be called, crypto_wait_req() will return without blocking.
+	 */
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &acomp_ctx->wait);
+
+	return 0;
+
+req_fail:
+	crypto_free_acomp(acomp_ctx->acomp);
+acomp_fail:
+	kfree(acomp_ctx->buffer);
+	return ret;
+}
+
+static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
+	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
+
+	if (!IS_ERR_OR_NULL(acomp_ctx)) {
+		if (!IS_ERR_OR_NULL(acomp_ctx->req))
+			acomp_request_free(acomp_ctx->req);
+		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
+			crypto_free_acomp(acomp_ctx->acomp);
+		kfree(acomp_ctx->buffer);
+	}
+
+	return 0;
+}
+
 static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
@@ -1201,75 +1267,6 @@ static void zswap_alloc_shrinker(struct zswap_pool *pool)
 	pool->shrinker->seeks = DEFAULT_SEEKS;
 }
 
-/*********************************
-* per-cpu code
-**********************************/
-static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
-{
-	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
-	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-	struct crypto_acomp *acomp;
-	struct acomp_req *req;
-	int ret;
-
-	mutex_init(&acomp_ctx->mutex);
-
-	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer)
-		return -ENOMEM;
-
-	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
-	if (IS_ERR(acomp)) {
-		pr_err("could not alloc crypto acomp %s : %ld\n",
-				pool->tfm_name, PTR_ERR(acomp));
-		ret = PTR_ERR(acomp);
-		goto acomp_fail;
-	}
-	acomp_ctx->acomp = acomp;
-
-	req = acomp_request_alloc(acomp_ctx->acomp);
-	if (!req) {
-		pr_err("could not alloc crypto acomp_request %s\n",
-		       pool->tfm_name);
-		ret = -ENOMEM;
-		goto req_fail;
-	}
-	acomp_ctx->req = req;
-
-	crypto_init_wait(&acomp_ctx->wait);
-	/*
-	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
-	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
-	 * won't be called, crypto_wait_req() will return without blocking.
-	 */
-	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
-				   crypto_req_done, &acomp_ctx->wait);
-
-	return 0;
-
-req_fail:
-	crypto_free_acomp(acomp_ctx->acomp);
-acomp_fail:
-	kfree(acomp_ctx->buffer);
-	return ret;
-}
-
-static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
-{
-	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
-	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-
-	if (!IS_ERR_OR_NULL(acomp_ctx)) {
-		if (!IS_ERR_OR_NULL(acomp_ctx->req))
-			acomp_request_free(acomp_ctx->req);
-		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
-			crypto_free_acomp(acomp_ctx->acomp);
-		kfree(acomp_ctx->buffer);
-	}
-
-	return 0;
-}
-
 static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
 				       spinlock_t *lock, void *arg)
 {
-- 
2.43.0


