Return-Path: <linux-kernel+bounces-43746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25C84188D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425C9B233A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E026381BA;
	Tue, 30 Jan 2024 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ZT9hiui7"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C6376EE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578945; cv=none; b=e5crN1qSU+ER227sZkNFG+VbzW8rPPsfWDq9CHOODnzWcUerrxobibRGbenG4xJpyR4/vCc+AdNqJXX4RFlMhh9ANjaodYoyIGIE23JjJUJrnbLN7387J3RudGD99BVlb5RWQtxn3C6fdmxjY1vPdZm8rjKX5+Lj/53ubwmSG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578945; c=relaxed/simple;
	bh=tQ+eAqiC1Z1SgLLxIS6/zBi2cNhu06izlT87O1n52ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFelBvNTPoE3hTHTWxSgdnv4K5ZcX33kds4wzIemjQCa2nRYrwgE8zxAjVEH/0TNHZerMplsuQttun0VLEv7lSa1Hq+k1stBOm2fMI//WeXzFLljUl/4SRoXCE2MK6Ibvur7EW2GyMsL5GGElVV2yczkwqU02Eo/FKL8tJmLT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ZT9hiui7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783f0994eeeso136071485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578942; x=1707183742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpwOGEgV3dvwZoaILLJtRsR55d6E5hoMpUKMvxq3d70=;
        b=ZT9hiui7CId8rNigQrVflUA6iIVZXtMVAKxeg4jvdbucWZ/gxzr1EIL39p3zeEI0zO
         bTs+5Hfckt+BuuQRP2qx3G5qyWjhWXEOYGorzYRWegBeyuwyXW1G2tZN/7JubdJaulVu
         skFNA5HN165VSQEourAlusdNB9EdW6uR8LTUxLj90UCGubo4MH+4aHBVuYADszh08cfX
         MsLcJj1l+QsxLYOBJRsmjxMUVzHNdGSBVRIbXlcSFQ998/kjopInqHITlVM629drvTuD
         HGEEW/D/nsUA/ocMevGzNDX6RyLkvvlK3wCyPE+yupQjd+Vgb1JD7cYP3eYBUHjh0g9h
         dLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578942; x=1707183742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpwOGEgV3dvwZoaILLJtRsR55d6E5hoMpUKMvxq3d70=;
        b=M/2xihAc9NS1hfyUNoJgZk2qeGv31Rxcx7WGdoIAJztmXJbbxU97tMV9H1wCyXkrk8
         ahcF+CxIViIgwnNmkz7ipMgLxw4N7ZZAclaxjT3DcJRVk0kWsmeElBLbIs48oLfMQGQB
         UM8GRgd5Oq245QcPUYmJZ8xNheiAfuxR/tcCRy40taHdRBe0zVognnr9ONssR+lW3uOb
         2lyWiva78cIrkUJkAzBbOcH6z9bLocHwHe0vFjp1WBr+n/kH0nlCarQpkzexl4fDyld3
         sn8VrSVfQ7NM+qzE2FBvxyQxivAM59OZa0MWUoDmHw3R+XRZPrVaghdc9r3B2m+X3UrH
         bpbA==
X-Gm-Message-State: AOJu0Yy/H3awU0Bse+pLNkipq3L1C6MO5f5MlbYeed69FKwjsqc+9tX5
	ael/o9vSoaH4wxJSgibD6jc6n5AGE17ToObPYWYhpxpnunLJLTDZ/rphOVCNHtA=
X-Google-Smtp-Source: AGHT+IGAaMHNgHtWkFaPNS95tGZ/hwePQLFIY+O4EOkM3Bj1xV6augPRQXjZ/4cnW0lftD5scOiZPw==
X-Received: by 2002:a05:620a:b11:b0:783:d096:d761 with SMTP id t17-20020a05620a0b1100b00783d096d761mr5637186qkg.31.1706578942391;
        Mon, 29 Jan 2024 17:42:22 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id po30-20020a05620a385e00b00783e3b030e7sm2669196qkn.33.2024.01.29.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:21 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] mm: zswap: break out zwap_compress()
Date: Mon, 29 Jan 2024 20:36:43 -0500
Message-ID: <20240130014208.565554-8-hannes@cmpxchg.org>
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

zswap_store() is long and mixes work at the zswap layer with work at
the backend and compression layer. Move compression & backend work to
zswap_compress(), mirroring zswap_decompress().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 145 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 68 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index bdc9f82fe4b9..f9b9494156ba 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1316,6 +1316,79 @@ static int zswap_enabled_param_set(const char *val,
 	return ret;
 }
 
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
 static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 {
 	struct zpool *zpool = zswap_find_zpool(entry);
@@ -1472,18 +1545,11 @@ bool zswap_store(struct folio *folio)
 	struct page *page = &folio->page;
 	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry, *dupentry;
-	struct scatterlist input, output;
-	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
-	struct zpool *zpool;
-	unsigned int dlen = PAGE_SIZE;
-	unsigned long handle, value;
-	char *buf;
-	u8 *src, *dst;
-	gfp_t gfp;
-	int ret;
+	unsigned long value;
+	u8 *src;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1568,65 +1634,10 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	/* compress */
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-
-	mutex_lock(&acomp_ctx->mutex);
-
-	dst = acomp_ctx->buffer;
-	sg_init_table(&input, 1);
-	sg_set_page(&input, &folio->page, PAGE_SIZE, 0);
+	if (!zswap_compress(folio, entry))
+		goto put_pool;
 
-	/*
-	 * We need PAGE_SIZE * 2 here since there maybe over-compression case,
-	 * and hardware-accelerators may won't check the dst buffer size, so
-	 * giving the dst buffer with enough length to avoid buffer overflow.
-	 */
-	sg_init_one(&output, dst, PAGE_SIZE * 2);
-	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
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
-
-	if (ret) {
-		zswap_reject_compress_fail++;
-		goto put_dstmem;
-	}
-
-	/* store */
-	zpool = zswap_find_zpool(entry);
-	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	if (zpool_malloc_support_movable(zpool))
-		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto put_dstmem;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
-		goto put_dstmem;
-	}
-	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, dst, dlen);
-	zpool_unmap_handle(zpool, handle);
-	mutex_unlock(&acomp_ctx->mutex);
-
-	/* populate entry */
 	entry->swpentry = swp;
-	entry->handle = handle;
-	entry->length = dlen;
 
 insert_entry:
 	entry->objcg = objcg;
@@ -1663,8 +1674,6 @@ bool zswap_store(struct folio *folio)
 
 	return true;
 
-put_dstmem:
-	mutex_unlock(&acomp_ctx->mutex);
 put_pool:
 	zswap_pool_put(entry->pool);
 freepage:
-- 
2.43.0


