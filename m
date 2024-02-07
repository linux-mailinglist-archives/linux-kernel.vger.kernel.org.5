Return-Path: <linux-kernel+bounces-56048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2720C84C54B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D240F28CDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2B200D9;
	Wed,  7 Feb 2024 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HcYw0PGK"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7261D559
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289086; cv=none; b=UWKZzZjRF6CAlr2t5BjKGp06Me9ffY6x1APG/8LolSgmPcyrchM339ybMJhtrRkSNkTQDnCjvlX6cX2xxtqjmBHveGfLXlBbk0qZIJn6sumjQjBiqZNENbZ/ZDczcydqoCqx4YA5rnb6sX5hFqrV2hgiP+P5DBPs//EWzuXzb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289086; c=relaxed/simple;
	bh=V7uFFpe8w3EF9zEsXHJZNarBHBrm8Ar/llgSi0z+4Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGZ/xl9f8DKGRu+qjfO2QzXqnWmBP1EUwEPi27t3hj/JhEfQNq4BgEyeAAWcSWGXhqH7wKnP7mvFwxQRumRhh5NY+3y8+LPzCINw1H2JSCjYE27brouNFyukSlOLQ55j8OqP7ht/DITI4E3UURRkroEaigM0hzQE2rXNukvUILg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HcYw0PGK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso246059b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707289083; x=1707893883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aecUI82Iy+XbHEXIEO1CZlXO6PZH5PAtjcYNmz1mNEQ=;
        b=HcYw0PGKQ8pnFpijdZeCpDJMuTfQALfqKcCd4oR3+NKI+8KYyZC6r69Sjkw2O5AT6b
         QJZTEHSvKf4sVTPcFlXmwXKq7NBxtmYn6tea4msSqxA41z5nGneVpSubS/m9v/qDORtO
         hLVaCeMykfZjUkSXiZOFe1PDCW2Fc7zVeELyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289083; x=1707893883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aecUI82Iy+XbHEXIEO1CZlXO6PZH5PAtjcYNmz1mNEQ=;
        b=ZRkGW/8Q7lyX+9mA3Y6lDxOPmFFmxZiE5K7XnUxd5P8xr+V8AdwPZjO3Lqfi01BW3q
         6YNhVWJRH0iA8FqsR/R+zUmkIIXwNmsLaIQX/0ws+pRubh0LjHTWp3NvrmOxRoA7JppA
         3lFzcji2lkvrPsPWzc95p3soaDRKwODNSnclUKwfhQEsgDODtHnJzv9uQsuco2plvp7Q
         CjwMYPxC1JSTWAI9Vhh237jdlbxrtBYmrdWRYFkxe1PG4B+Mwr3cPFiE+OqNvxWT62Aj
         SxtsJB/sDGM9dPikak+QzU4NFC/PCMH1pTSx4BaMqFvMPSuP2X/5tLKZAjwDPeuaDMOg
         Vj5w==
X-Forwarded-Encrypted: i=1; AJvYcCUyB+dVV3PrUJ0GvQwAYdKBieTRqBQ558FkqAiGukTXhLEYBJctyDb73HG7KmHRu6KXiwnjqzWrkh91rDFG19IgYqITrKQKyam6f48+
X-Gm-Message-State: AOJu0YwPq5ods9o0+23HTU5OW0Xj1iCsYKmyiqEBmYD2PAnuU5NQ16Gi
	2JrUZrWLbONN4NMDropggqBJ1JSiY9CHQevEVwBzQaVjlQi36Q4E7+u+dzZ1Rw==
X-Google-Smtp-Source: AGHT+IFELJwXkmY3OunMAIgQO/2tw+BOike8Ofqjzzk59xcmSBvDqnBhvRvwNn0Eu2+00jvLhins+Q==
X-Received: by 2002:a05:6a00:4f96:b0:6da:c9e8:486f with SMTP id ld22-20020a056a004f9600b006dac9e8486fmr2959491pfb.3.1707289083519;
        Tue, 06 Feb 2024 22:58:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1FLAWtv16oNS8EQOb71JFwYbqgXmxQrqvEc+LjnWZCmoy75DdllOOmj+Vv1vpivueRCKXUfvQF4qa2HEbP97C0forU4DFKVCF0DkzHdFyxGh7GaE8oJD3iJSLDEsOso2iHI0LOLRmxbeIPp6/n8AD1QddxYikULAb8v35JH/+wbs=
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id jw15-20020a056a00928f00b006e03ac84d53sm672576pfb.193.2024.02.06.22.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:58:03 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 2/2] zram: move comp buffer to a dedicate per-CPU area
Date: Wed,  7 Feb 2024 15:57:12 +0900
Message-ID: <20240207065751.1908939-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207065751.1908939-1-senozhatsky@chromium.org>
References: <20240207065751.1908939-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently keep compression work buffer (2 physical pages)
in each per-CPU zcomp_stream structure. In some cases this
results in increased memory usage (or even wastage), e.g.
when we have multiple compression streams enabled.

In fact, all we need is one compression work buffer per-CPU
per-device, because we never have several compression backends
being active on any given CPU. Compression backends use that
buffer exclusively so one per-CPU buffer is enough.

Ideally, we don't even need to allocate those buffers per-CPU
and per-device. Just per-CPU should suffice, because zram
compression/decompression runs with preemption and cpu-hotplug
disabled.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 115 +++++++++++++++++++++++++++++-----
 drivers/block/zram/zcomp.h    |  24 +++++--
 drivers/block/zram/zram_drv.c |  32 ++++++++--
 drivers/block/zram/zram_drv.h |   1 +
 include/linux/cpuhotplug.h    |   1 +
 5 files changed, 148 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index d88954e8c7bf..fa6019fb0969 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -34,13 +34,41 @@ static const char * const backends[] = {
 #endif
 };
 
+static void zcomp_buf_free(struct zcomp_buf *buf)
+{
+	vfree(buf->ptr);
+	buf->ptr = NULL;
+}
+
+static int zcomp_buf_init(struct zcomp_buf *buf)
+{
+	/*
+	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
+	 * case when compressed size is larger than the original one
+	 */
+	buf->ptr = vzalloc(2 * PAGE_SIZE);
+	if (!buf->ptr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void *zcomp_mem_buffer(struct zcomp_mem *mem)
+{
+	struct zcomp_buf *buf = this_cpu_ptr(mem->buf);
+
+	/*
+	 * Note that this should be called after zstrm_get(), which
+	 * should disable CPU-hotplug and preemption.
+	 */
+	return buf->ptr;
+}
+
 static void zcomp_strm_free(struct zcomp_strm *zstrm)
 {
 	if (!IS_ERR_OR_NULL(zstrm->tfm))
 		crypto_free_comp(zstrm->tfm);
-	vfree(zstrm->buffer);
 	zstrm->tfm = NULL;
-	zstrm->buffer = NULL;
 }
 
 /*
@@ -53,15 +81,6 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
 	if (IS_ERR_OR_NULL(zstrm->tfm))
 		return -EINVAL;
 
-	/*
-	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
-	 * case when compressed size is larger than the original one
-	 */
-	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (!zstrm->buffer) {
-		zcomp_strm_free(zstrm);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -118,8 +137,8 @@ void zcomp_stream_put(struct zcomp *comp)
 	local_unlock(&comp->stream->lock);
 }
 
-int zcomp_compress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int *dst_len)
+int zcomp_compress(struct zcomp_strm *zstrm, struct zcomp_mem *mem,
+		   const void *src, unsigned int *dst_len)
 {
 	/*
 	 * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
@@ -137,9 +156,8 @@ int zcomp_compress(struct zcomp_strm *zstrm,
 	 */
 	*dst_len = PAGE_SIZE * 2;
 
-	return crypto_comp_compress(zstrm->tfm,
-			src, PAGE_SIZE,
-			zstrm->buffer, dst_len);
+	return crypto_comp_compress(zstrm->tfm, src, PAGE_SIZE,
+				    zcomp_mem_buffer(mem), dst_len);
 }
 
 int zcomp_decompress(struct zcomp_strm *zstrm,
@@ -235,3 +253,68 @@ struct zcomp *zcomp_create(const char *alg)
 	}
 	return comp;
 }
+
+int zcomp_mem_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
+{
+	struct zcomp_mem *mem = hlist_entry(node, struct zcomp_mem, node);
+	struct zcomp_buf *buf;
+	int ret;
+
+	buf = per_cpu_ptr(mem->buf, cpu);
+	ret = zcomp_buf_init(buf);
+	if (ret)
+		pr_err("Can't allocate compression buffer\n");
+	return ret;
+}
+
+int zcomp_mem_cpu_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct zcomp_mem *mem = hlist_entry(node, struct zcomp_mem, node);
+	struct zcomp_buf *buf;
+
+	buf = per_cpu_ptr(mem->buf, cpu);
+	zcomp_buf_free(buf);
+	return 0;
+}
+
+static int zcomp_mem_init(struct zcomp_mem *mem)
+{
+	int ret;
+
+	mem->buf = alloc_percpu(struct zcomp_buf);
+	if (!mem->buf)
+		return -ENOMEM;
+
+	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_MEM_PREPARE, &mem->node);
+	if (ret < 0)
+		goto cleanup;
+	return 0;
+
+cleanup:
+	free_percpu(mem->buf);
+	return ret;
+}
+
+void zcomp_mem_destroy(struct zcomp_mem *mem)
+{
+	cpuhp_state_remove_instance(CPUHP_ZCOMP_MEM_PREPARE, &mem->node);
+	free_percpu(mem->buf);
+	kfree(mem);
+}
+
+struct zcomp_mem *zcomp_mem_create(void)
+{
+	struct zcomp_mem *mem;
+	int ret;
+
+	mem = kzalloc(sizeof(struct zcomp_mem), GFP_KERNEL);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	ret = zcomp_mem_init(mem);
+	if (ret) {
+		kfree(mem);
+		return ERR_PTR(ret);
+	}
+	return mem;
+}
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index cdefdef93da8..93645cdabb89 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -8,10 +8,7 @@
 #include <linux/local_lock.h>
 
 struct zcomp_strm {
-	/* The members ->buffer and ->tfm are protected by ->lock. */
 	local_lock_t lock;
-	/* compression/decompression buffer */
-	void *buffer;
 	struct crypto_comp *tfm;
 };
 
@@ -22,6 +19,25 @@ struct zcomp {
 	struct hlist_node node;
 };
 
+/*
+ * zcomp_buf should be accessed only after zcomp_stream_get() and should
+ * not be accessed after zcomp_stream_get()
+ */
+struct zcomp_buf {
+	void *ptr;
+};
+
+struct zcomp_mem {
+	struct zcomp_buf __percpu *buf;
+	struct hlist_node node;
+};
+
+void *zcomp_mem_buffer(struct zcomp_mem *mem);
+int zcomp_mem_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
+int zcomp_mem_cpu_dead(unsigned int cpu, struct hlist_node *node);
+void zcomp_mem_destroy(struct zcomp_mem *mem);
+struct zcomp_mem *zcomp_mem_create(void);
+
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
@@ -33,7 +49,7 @@ void zcomp_destroy(struct zcomp *comp);
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
 void zcomp_stream_put(struct zcomp *comp);
 
-int zcomp_compress(struct zcomp_strm *zstrm,
+int zcomp_compress(struct zcomp_strm *zstrm, struct zcomp_mem *mem,
 		const void *src, unsigned int *dst_len);
 
 int zcomp_decompress(struct zcomp_strm *zstrm,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6772e0c654fa..5e7b86660166 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1429,7 +1429,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	src = kmap_local_page(page);
-	ret = zcomp_compress(zstrm, src, &comp_len);
+	ret = zcomp_compress(zstrm, zram->comp_mem, src, &comp_len);
 	kunmap_local(src);
 
 	if (unlikely(ret)) {
@@ -1492,7 +1492,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
-	src = zstrm->buffer;
+	src = zcomp_mem_buffer(zram->comp_mem);
 	if (comp_len == PAGE_SIZE)
 		src = kmap_local_page(page);
 	memcpy(dst, src, comp_len);
@@ -1615,7 +1615,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
-		ret = zcomp_compress(zstrm, src, &comp_len_new);
+		ret = zcomp_compress(zstrm, zram->comp_mem, src, &comp_len_new);
 		kunmap_local(src);
 
 		if (ret) {
@@ -1683,7 +1683,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	}
 
 	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
-	memcpy(dst, zstrm->buffer, comp_len_new);
+	memcpy(dst, zcomp_mem_buffer(zram->comp_mem), comp_len_new);
 	zcomp_stream_put(zram->comps[prio]);
 
 	zs_unmap_object(zram->mem_pool, handle_new);
@@ -1979,6 +1979,8 @@ static void zram_destroy_comps(struct zram *zram)
 		zcomp_destroy(comp);
 		zram->num_active_comps--;
 	}
+
+	zcomp_mem_destroy(zram->comp_mem);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2047,6 +2049,13 @@ static ssize_t disksize_store(struct device *dev,
 		zram->comps[prio] = comp;
 		zram->num_active_comps++;
 	}
+
+	zram->comp_mem = zcomp_mem_create();
+	if (!zram->comp_mem) {
+		err = PTR_ERR(zram->comp_mem);
+		goto out_free_comps;
+	}
+
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
@@ -2390,6 +2399,7 @@ static void destroy_devices(void)
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+	cpuhp_remove_multi_state(CPUHP_ZCOMP_MEM_PREPARE);
 }
 
 static int __init zram_init(void)
@@ -2398,15 +2408,26 @@ static int __init zram_init(void)
 
 	BUILD_BUG_ON(__NR_ZRAM_PAGEFLAGS > BITS_PER_LONG);
 
-	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE, "block/zram:prepare",
+	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_PREPARE,
+				      "block/zram:zcomp_prepare",
 				      zcomp_cpu_up_prepare, zcomp_cpu_dead);
 	if (ret < 0)
 		return ret;
 
+	ret = cpuhp_setup_state_multi(CPUHP_ZCOMP_MEM_PREPARE,
+				      "block/zram:zcomp_mem_prepare",
+				      zcomp_mem_cpu_up_prepare,
+				      zcomp_mem_cpu_dead);
+	if (ret < 0) {
+		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+		return ret;
+	}
+
 	ret = class_register(&zram_control_class);
 	if (ret) {
 		pr_err("Unable to register zram-control class\n");
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+		cpuhp_remove_multi_state(CPUHP_ZCOMP_MEM_PREPARE);
 		return ret;
 	}
 
@@ -2416,6 +2437,7 @@ static int __init zram_init(void)
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+		cpuhp_remove_multi_state(CPUHP_ZCOMP_MEM_PREPARE);
 		return -EBUSY;
 	}
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 3b94d12f41b4..bdb3d5e07ec0 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -107,6 +107,7 @@ struct zram {
 	struct zram_table_entry *table;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
+	struct zcomp_mem *comp_mem;
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
 	struct rw_semaphore init_lock;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 172d0a743e5d..0fc72eb6fc02 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -121,6 +121,7 @@ enum cpuhp_state {
 	CPUHP_MM_ZSWP_POOL_PREPARE,
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
+	CPUHP_ZCOMP_MEM_PREPARE,
 	CPUHP_TIMERS_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
-- 
2.43.0.594.gd9cf4e227d-goog


