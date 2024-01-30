Return-Path: <linux-kernel+bounces-43756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D1A841899
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78066B23F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8976048;
	Tue, 30 Jan 2024 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="r/3KW+de"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61353E3D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578957; cv=none; b=dvq8AD7u4zDdsaN0cX/JoBWOeBorPNv58tHHONjbCiGB/3P67me0mxga4Dd5CMwQOfKh9sLhI5RcsiXVk7206FNMtlndbfZmm4FUCYOXtaXzz17jL92Dbn8BB/CRPPIxIqX824jiemqKlACybpk0NzaCrifKUY4eniQiPXWN4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578957; c=relaxed/simple;
	bh=T6a005OxCxWw2FWJbDa32NRjtAb1L9KNEaMrj9iwn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA01H2P1v1qXwvOx7O7VWyTde83p35wV+ycUGHDmhgIk3PbaOBBqGah/dvrCJFOZogvGh3n88XggdtJwaejRAd2N2UviHu+6ByAh2BkdsTUx1Q1MNUyzLeS9k+Qcz39YSHVVjBFZWM/mSl2Gx11YrFm9X+Fu+W2nZORZZ+L+T7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=r/3KW+de; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6818f3cf00aso30235016d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578954; x=1707183754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1iB6scB+xehMKrtYira4F0YAgxikUXsHI43Fnlp9WY=;
        b=r/3KW+dew/AJTme8z5hUhJMp8IwQbvCNOl5UzmwEUGTWXDk5GGFL6tddXHQYCVE7Uc
         uMa5+YM+yBgGqA6KS+S1aEPb1KGWDV4KfhZSQXWGqGiyM1VWlaBGCfW4b/t299a6u0r3
         RoBIafI7p3CtX26lo7IGcSX0QB6CL5meKyGfxaSCBDFpSFKNTW5hketENFZQ2eTeX5S2
         /rzhmuno1XiOwURQfQRAFlY84Rb/PV/prI7qWQbmLVQmBfb7wuJmHGCnlzdcbUzlHUxM
         BfQ9ZRqSg+uYUQ8EgVkR17WJSc08bZg5UfFDP71O8vYzm95KW7hu8j0J/nWmiJo2HKKg
         YIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578954; x=1707183754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1iB6scB+xehMKrtYira4F0YAgxikUXsHI43Fnlp9WY=;
        b=wRr30V27yOxAOcDCpBvIlRb3UVvIlUHdawJbBecPSSFdzF8xlGnnCBLsWj6bXFwyar
         XONVKV7qhRjPJuHuB2XqTySRWl4wFlDhVIL4p2wNtuU/XbcGhobh7HSccXA3YCFQjSX0
         Q0ThjibtQGaqzOvRujq2EAESVBVzNtZURXBl9Ys51094mHAllhZAJOIRDuFtJ+LxAFsp
         Pnnf6d9159GhYXb/2a8t/yleqP/FUWAlGsJ1oZHfZfizSIrQnmVT8BSJwWkgFmJZDOoc
         opusx/5tS5Q3clmpPLHvsutm6/a5yNeQNbe1jlkAbHTZXT1ICIUWhMN5TQfnNC2IuGw5
         d0RA==
X-Gm-Message-State: AOJu0Yz/cLvkB5/Xta89YPfUw6UvfXQQQD8Ng4Lo1V2OZJltp4wD1t8H
	3gZNfUQNmwxoTSXCC8pZ0GGP1qLC39hH149ANg5ITERIvvD8tscGYFSzCPzBsts=
X-Google-Smtp-Source: AGHT+IGzesXTSc5km00kKTgaDrZtfj8iYTZdT/vrOqGJQTpSYvP8oFDnRJlKxNfj+JGUQtlQVzjEvg==
X-Received: by 2002:a05:6214:628:b0:681:5800:9f23 with SMTP id a8-20020a056214062800b0068158009f23mr8224751qvx.115.1706578954521;
        Mon, 29 Jan 2024 17:42:34 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id mw2-20020a05621433c200b006891e1f098csm3996652qvb.78.2024.01.29.17.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:34 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] mm: zswap: function ordering: compress & decompress functions
Date: Mon, 29 Jan 2024 20:36:53 -0500
Message-ID: <20240130014208.565554-18-hannes@cmpxchg.org>
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

Writeback needs to decompress. Move the (de)compression API above what
will be the consolidated shrinking/writeback code.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 207 +++++++++++++++++++++++++++--------------------------
 1 file changed, 105 insertions(+), 102 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 80adc2f7d1a2..17356b2e35c2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -992,6 +992,111 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
 		zswap_entry_put(entry);
 }
 
+/*********************************
+* compressed storage functions
+**********************************/
+static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
+{
+	struct crypto_acomp_ctx *acomp_ctx;
+	struct scatterlist input, output;
+	unsigned int dlen = PAGE_SIZE;
+	unsigned long handle;
+	struct zpool *zpool;
+	char *buf;
+	gfp_t gfp;
+	int ret;
+	u8 *dst;
+
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+
+	mutex_lock(&acomp_ctx->mutex);
+
+	dst = acomp_ctx->buffer;
+	sg_init_table(&input, 1);
+	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
+
+	/*
+	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
+	 * and hardware-accelerators may won't check the dst buffer size, so
+	 * giving the dst buffer with enough length to avoid buffer overflow.
+	 */
+	sg_init_one(&output, dst, PAGE_SIZE * 2);
+	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
+
+	/*
+	 * it maybe looks a little bit silly that we send an asynchronous request,
+	 * then wait for its completion synchronously. This makes the process look
+	 * synchronous in fact.
+	 * Theoretically, acomp supports users send multiple acomp requests in one
+	 * acomp instance, then get those requests done simultaneously. but in this
+	 * case, zswap actually does store and load page by page, there is no
+	 * existing method to send the second page before the first page is done
+	 * in one thread doing zwap.
+	 * but in different threads running on different cpu, we have different
+	 * acomp instance, so multiple threads can do (de)compression in parallel.
+	 */
+	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	dlen = acomp_ctx->req->dlen;
+	if (ret) {
+		zswap_reject_compress_fail++;
+		goto unlock;
+	}
+
+	zpool = zswap_find_zpool(entry);
+	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
+	if (zpool_malloc_support_movable(zpool))
+		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
+	ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	if (ret == -ENOSPC) {
+		zswap_reject_compress_poor++;
+		goto unlock;
+	}
+	if (ret) {
+		zswap_reject_alloc_fail++;
+		goto unlock;
+	}
+
+	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
+	memcpy(buf, dst, dlen);
+	zpool_unmap_handle(zpool, handle);
+
+	entry->handle = handle;
+	entry->length = dlen;
+
+unlock:
+	mutex_unlock(&acomp_ctx->mutex);
+	return ret == 0;
+}
+
+static void zswap_decompress(struct zswap_entry *entry, struct page *page)
+{
+	struct zpool *zpool = zswap_find_zpool(entry);
+	struct scatterlist input, output;
+	struct crypto_acomp_ctx *acomp_ctx;
+	u8 *src;
+
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(&acomp_ctx->mutex);
+
+	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+	if (!zpool_can_sleep_mapped(zpool)) {
+		memcpy(acomp_ctx->buffer, src, entry->length);
+		src = acomp_ctx->buffer;
+		zpool_unmap_handle(zpool, entry->handle);
+	}
+
+	sg_init_one(&input, src, entry->length);
+	sg_init_table(&output, 1);
+	sg_set_page(&output, page, PAGE_SIZE, 0);
+	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
+	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
+	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	mutex_unlock(&acomp_ctx->mutex);
+
+	if (zpool_can_sleep_mapped(zpool))
+		zpool_unmap_handle(zpool, entry->handle);
+}
+
 /*********************************
 * shrinker functions
 **********************************/
@@ -1317,108 +1422,6 @@ static void shrink_worker(struct work_struct *w)
 	zswap_pool_put(pool);
 }
 
-static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
-{
-	struct crypto_acomp_ctx *acomp_ctx;
-	struct scatterlist input, output;
-	unsigned int dlen = PAGE_SIZE;
-	unsigned long handle;
-	struct zpool *zpool;
-	char *buf;
-	gfp_t gfp;
-	int ret;
-	u8 *dst;
-
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-
-	mutex_lock(&acomp_ctx->mutex);
-
-	dst = acomp_ctx->buffer;
-	sg_init_table(&input, 1);
-	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
-
-	/*
-	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
-	 * and hardware-accelerators may won't check the dst buffer size, so
-	 * giving the dst buffer with enough length to avoid buffer overflow.
-	 */
-	sg_init_one(&output, dst, PAGE_SIZE * 2);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
-
-	/*
-	 * it maybe looks a little bit silly that we send an asynchronous request,
-	 * then wait for its completion synchronously. This makes the process look
-	 * synchronous in fact.
-	 * Theoretically, acomp supports users send multiple acomp requests in one
-	 * acomp instance, then get those requests done simultaneously. but in this
-	 * case, zswap actually does store and load page by page, there is no
-	 * existing method to send the second page before the first page is done
-	 * in one thread doing zwap.
-	 * but in different threads running on different cpu, we have different
-	 * acomp instance, so multiple threads can do (de)compression in parallel.
-	 */
-	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
-	dlen = acomp_ctx->req->dlen;
-	if (ret) {
-		zswap_reject_compress_fail++;
-		goto unlock;
-	}
-
-	zpool = zswap_find_zpool(entry);
-	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	if (zpool_malloc_support_movable(zpool))
-		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto unlock;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
-		goto unlock;
-	}
-
-	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, dst, dlen);
-	zpool_unmap_handle(zpool, handle);
-
-	entry->handle = handle;
-	entry->length = dlen;
-
-unlock:
-	mutex_unlock(&acomp_ctx->mutex);
-	return ret == 0;
-}
-
-static void zswap_decompress(struct zswap_entry *entry, struct page *page)
-{
-	struct zpool *zpool = zswap_find_zpool(entry);
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
-	u8 *src;
-
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(&acomp_ctx->mutex);
-
-	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (!zpool_can_sleep_mapped(zpool)) {
-		memcpy(acomp_ctx->buffer, src, entry->length);
-		src = acomp_ctx->buffer;
-		zpool_unmap_handle(zpool, entry->handle);
-	}
-
-	sg_init_one(&input, src, entry->length);
-	sg_init_table(&output, 1);
-	sg_set_page(&output, page, PAGE_SIZE, 0);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(&acomp_ctx->mutex);
-
-	if (zpool_can_sleep_mapped(zpool))
-		zpool_unmap_handle(zpool, entry->handle);
-}
-
 /*********************************
 * writeback code
 **********************************/
-- 
2.43.0


