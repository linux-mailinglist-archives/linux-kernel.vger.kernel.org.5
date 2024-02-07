Return-Path: <linux-kernel+bounces-56141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B784C68C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBA01F27156
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E5208B4;
	Wed,  7 Feb 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AYXhLDaQ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76591208A5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295647; cv=none; b=m/pJey2ffkt56QI9MSmseEaa/7pMgCRN+SxwzGYB6R1tjw2sFkyhgHQVIEkARYxEeDiAF702JtnZD3GYeR9L+TdMtHssVFOabUlhoqCqJicTs2CKb6tA+cqRwWir/lnNcfNDlMN53YWDm1a8bO0Wixq3y0MViu8fVVeQHWYESXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295647; c=relaxed/simple;
	bh=LUq6UZjV+qxJlQvEVE5IaJy9KFEWaygMxp7KklLcuB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDvny99yVP+9Xj3azJ6RGix/bHBhIXT/d7mu+bH+oB4uatw3BpFJRqsJcXC58qLnScDwNZrsac82IzR3yQ2JWdCiuiGaPoJ22hZe1udH3NwRPPFtxz+ePnUBc4pWMkyZLkCzpFO6gFRkeSuknRGNHBbQGgOK+qgh/pvHc4AjY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AYXhLDaQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29041136f73so271721a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707295645; x=1707900445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viRRAchx0HuAfO3HBQRnoeBimEE2IwU5hWhSvcw7nXY=;
        b=AYXhLDaQz9zLmTORuM/DQPnVO8e9jpWpjOXwx6lYx5qTkkbWWc+VdNc58GSaZh1Tvv
         evd+7Tluj5905R14BJiVZZQs9j+QCkyfggaZIF2E6MJ3DqPK9gy6Ga95PnO7ojOxQMZi
         iFgHoOk81kklGXNIceVdlDizzFoWqCR4m9i0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295645; x=1707900445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viRRAchx0HuAfO3HBQRnoeBimEE2IwU5hWhSvcw7nXY=;
        b=gSvHWttPJaNjO1OdhWMFm1E5LnH3UvhJ8e4hlswPgaQS/EiEzCR/rU0yRt7NB6fXA5
         i2m/YrceyDKNzcdzD9LK2NYga56sMG7jluJ+lcQfEm7LnpvnCCGN5ur5vNETB2oQKNyG
         L7or5zhoWop8HW/+YuD1DVWwQQZBuRx8y1kuRvdalIg1+yMeKnMfjllD2wEAH3S6PrHi
         r1/FGXx2krH3mK5OVZIKSA8AkvcvaNExqqrclSeKBq9CvumMrk2vZK0+9f4kgGO10Qf9
         7EJFwAfcUhtzey8GWtwx8S77cmPJIilxoVuw+6hRqUNzzuX1f/cQB7Fwi16ZfxKI7hvj
         DxOg==
X-Gm-Message-State: AOJu0YzArlOmFlMnqq73Q0PiRouow1Fe/Zc/9jT+2EKy+cZ498XKIIIW
	I2VRz9UvVdl3qBndvZt+BuGh28wPhIiqMfZM0vO8jNEM8Qm7wokZwOyCqWDJgg==
X-Google-Smtp-Source: AGHT+IEpfiNTumXMEC9/+DIt100ow1od9sHULl/gcZY6mcIHEyMrnR0NuMxC6dvgHCfY70SnB4t9rQ==
X-Received: by 2002:a17:90a:d443:b0:296:a13c:8f84 with SMTP id cz3-20020a17090ad44300b00296a13c8f84mr2000398pjb.33.1707295644695;
        Wed, 07 Feb 2024 00:47:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWr1n0bkp7gHFdkq31mBeHJIS9iv6dufPTxDj/iduUR2ifG7DMCmSk2rtG9ZJomKU8RqpyuumLZbNLhPdrcTkdTask1AWUskaU9q7NDgvaflN0BsxquRq0PJhqcwoXzdsPPz6gecil7nUVo5758Qh8jAK8hhRxKPh0kpznEY/WXyk=
Received: from google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id px1-20020a17090b270100b00296e90e873csm513152pjb.25.2024.02.07.00.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:47:24 -0800 (PST)
Date: Wed, 7 Feb 2024 17:47:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC][PATCH 0/2] zram: decouple comp stream and comp buffer
Message-ID: <20240207084720.GD489524@google.com>
References: <20240207065751.1908939-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207065751.1908939-1-senozhatsky@chromium.org>

On (24/02/07 15:57), Sergey Senozhatsky wrote:
> 	RFC
> 
> 	We keep compression work memory buffer per-comp stream (which
> is per-CPU), but we don't need that many buffers, because on each
> CPU only one compression backend can access work memory at any given
> time. Hence the patch series moves compression work memory to a
> dedicated per-CPU area, reducing the amount of memory we allocate
> for those buffers.
> 
> For instance, assume a 12 CPUs system, 2 compression streams
> per-CPU (a default and one for deferred recompression). Before
> we'd allocate 12 * 2 * 2 pages, after we'll allocate 12 * 2 pages.
> 
> NOTE:
> The series stops short of moving comp buffers to a global per-CPU
> area, which all zram devices can share. Compression backends use
> CPUs exclusively (disable migration and CPU hotplug), so in theory
> comp work memory can be in global per-CPU data. This can reduce
> memory usage on systems that init numerous zram devices.
> E.g. instead of num-zram-devices * num-cpus buffers we'll allocate
> only num-cpus buffers.

And this is the patch that moves comp buffers to global per-CPU
area, so that *all* zram devices and *all* comp backends share
them. It also moves local_lock (which disables migration/preemption
and CPU-hotplug once taken) to global comp mem per-CPU buffer.

==================================================================

We currently keep compression work buffer (2 physical pages)
in each per-CPU zcomp_stream structure. In some cases this
results in increased memory usage (or even wastage), e.g.
when we have multiple compression streams enabled.

In fact, all we need is one compression work buffer per-CPU
per-device, because we never have several compression backends
being active on any given CPU. Compression backends use that
buffer exclusively so one per-CPU buffer is enough.

Even more, we don't really need to allocate those buffers
per-CPU and per-device. Just per-CPU should suffice, because
zram compression/decompression runs with preemption/migration
and CPU-hotplug disabled.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 139 +++++++++++++++++++++++++++++-----
 drivers/block/zram/zcomp.h    |  14 ++--
 drivers/block/zram/zram_drv.c |  53 +++++++++----
 drivers/block/zram/zram_drv.h |   1 +
 include/linux/cpuhotplug.h    |   1 +
 5 files changed, 169 insertions(+), 39 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index d88954e8c7bf..dd3d4a64312b 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -34,13 +34,57 @@ static const char * const backends[] = {
 #endif
 };
 
+struct zcomp_buf {
+	local_lock_t lock;
+	void *ptr;
+};
+
+struct zcomp_mem {
+	struct zcomp_buf __percpu *buf;
+	struct hlist_node node;
+};
+
+static struct zcomp_mem *comp_mem;
+
+static void zcomp_buf_free(struct zcomp_buf *buf)
+{
+	vfree(buf->ptr);
+	buf->ptr = NULL;
+}
+
+static int zcomp_buf_init(struct zcomp_buf *buf)
+{
+	local_lock_init(&buf->lock);
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
+void *zcomp_mem_buffer_get(void)
+{
+	struct zcomp_buf *buf;
+
+	local_lock(&comp_mem->buf->lock);
+	buf = this_cpu_ptr(comp_mem->buf);
+	return buf->ptr;
+}
+
+void zcomp_mem_buffer_put(void)
+{
+	local_unlock(&comp_mem->buf->lock);
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
@@ -53,15 +97,6 @@ static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
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
 
@@ -109,17 +144,17 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	local_lock(&comp->stream->lock);
+	lockdep_assert_held(this_cpu_ptr(&comp_mem->buf->lock));
 	return this_cpu_ptr(comp->stream);
 }
 
 void zcomp_stream_put(struct zcomp *comp)
 {
-	local_unlock(&comp->stream->lock);
+	lockdep_assert_held(this_cpu_ptr(&comp_mem->buf->lock));
 }
 
-int zcomp_compress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int *dst_len)
+int zcomp_compress(struct zcomp_strm *zstrm, void *buf,
+		   const void *src, unsigned int *dst_len)
 {
 	/*
 	 * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
@@ -137,9 +172,8 @@ int zcomp_compress(struct zcomp_strm *zstrm,
 	 */
 	*dst_len = PAGE_SIZE * 2;
 
-	return crypto_comp_compress(zstrm->tfm,
-			src, PAGE_SIZE,
-			zstrm->buffer, dst_len);
+	return crypto_comp_compress(zstrm->tfm, src, PAGE_SIZE,
+				    buf, dst_len);
 }
 
 int zcomp_decompress(struct zcomp_strm *zstrm,
@@ -159,8 +193,6 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 	int ret;
 
 	zstrm = per_cpu_ptr(comp->stream, cpu);
-	local_lock_init(&zstrm->lock);
-
 	ret = zcomp_strm_init(zstrm, comp);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
@@ -235,3 +267,70 @@ struct zcomp *zcomp_create(const char *alg)
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
+static int zcomp_mem_init(void)
+{
+	int ret;
+
+	comp_mem->buf = alloc_percpu(struct zcomp_buf);
+	if (!comp_mem->buf)
+		return -ENOMEM;
+
+	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_MEM_PREPARE,
+				       &comp_mem->node);
+	if (ret < 0)
+		goto cleanup;
+	return 0;
+
+cleanup:
+	free_percpu(comp_mem->buf);
+	return ret;
+}
+
+void zcomp_mem_destroy(void)
+{
+	cpuhp_state_remove_instance(CPUHP_ZCOMP_MEM_PREPARE, &comp_mem->node);
+	free_percpu(comp_mem->buf);
+	kfree(comp_mem);
+	comp_mem = NULL;
+}
+
+int zcomp_mem_create(void)
+{
+	int ret;
+
+	comp_mem = kzalloc(sizeof(struct zcomp_mem), GFP_KERNEL);
+	if (!comp_mem)
+		return -ENOMEM;
+
+	ret = zcomp_mem_init();
+	if (ret) {
+		kfree(comp_mem);
+		comp_mem = NULL;
+		return ret;
+	}
+	return 0;
+}
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index cdefdef93da8..23e67194c593 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -8,10 +8,6 @@
 #include <linux/local_lock.h>
 
 struct zcomp_strm {
-	/* The members ->buffer and ->tfm are protected by ->lock. */
-	local_lock_t lock;
-	/* compression/decompression buffer */
-	void *buffer;
 	struct crypto_comp *tfm;
 };
 
@@ -22,6 +18,14 @@ struct zcomp {
 	struct hlist_node node;
 };
 
+int zcomp_mem_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
+int zcomp_mem_cpu_dead(unsigned int cpu, struct hlist_node *node);
+
+void *zcomp_mem_buffer_get(void);
+void zcomp_mem_buffer_put(void);
+void zcomp_mem_destroy(void);
+int zcomp_mem_create(void);
+
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node);
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
@@ -33,7 +37,7 @@ void zcomp_destroy(struct zcomp *comp);
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
 void zcomp_stream_put(struct zcomp *comp);
 
-int zcomp_compress(struct zcomp_strm *zstrm,
+int zcomp_compress(struct zcomp_strm *zstrm, void *buf,
 		const void *src, unsigned int *dst_len);
 
 int zcomp_decompress(struct zcomp_strm *zstrm,
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6772e0c654fa..1f4c749947ac 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1331,6 +1331,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	if (size != PAGE_SIZE) {
 		prio = zram_get_priority(zram, index);
+		zcomp_mem_buffer_get();
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 	}
 
@@ -1345,6 +1346,7 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_local(dst);
 		zcomp_stream_put(zram->comps[prio]);
+		zcomp_mem_buffer_put();
 	}
 	zs_unmap_object(zram->mem_pool, handle);
 	return ret;
@@ -1411,7 +1413,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	unsigned long alloced_pages;
 	unsigned long handle = -ENOMEM;
 	unsigned int comp_len = 0;
-	void *src, *dst, *mem;
+	void *src, *dst, *mem, *comp_mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
@@ -1427,13 +1429,15 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	kunmap_local(mem);
 
 compress_again:
+	comp_mem = zcomp_mem_buffer_get();
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	src = kmap_local_page(page);
-	ret = zcomp_compress(zstrm, src, &comp_len);
+	ret = zcomp_compress(zstrm, comp_mem, src, &comp_len);
 	kunmap_local(src);
 
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_mem_buffer_put();
 		pr_err("Compression failed! err=%d\n", ret);
 		zs_free(zram->mem_pool, handle);
 		return ret;
@@ -1462,6 +1466,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 				__GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_mem_buffer_put();
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
@@ -1471,13 +1476,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 		if (comp_len != PAGE_SIZE)
 			goto compress_again;
-		/*
-		 * If the page is not compressible, you need to acquire the
-		 * lock and execute the code below. The zcomp_stream_get()
-		 * call is needed to disable the cpu hotplug and grab the
-		 * zstrm buffer back. It is necessary that the dereferencing
-		 * of the zstrm variable below occurs correctly.
-		 */
+		comp_mem = zcomp_mem_buffer_get();
 		zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	}
 
@@ -1486,13 +1485,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 
 	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_mem_buffer_put();
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
 
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
-	src = zstrm->buffer;
+	src = comp_mem;
 	if (comp_len == PAGE_SIZE)
 		src = kmap_local_page(page);
 	memcpy(dst, src, comp_len);
@@ -1500,6 +1500,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		kunmap_local(src);
 
 	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+	zcomp_mem_buffer_put();
 	zs_unmap_object(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 out:
@@ -1578,7 +1579,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned int class_index_old;
 	unsigned int class_index_new;
 	u32 num_recomps = 0;
-	void *src, *dst;
+	void *src, *dst, *comp_mem;
 	int ret;
 
 	handle_old = zram_get_handle(zram, index);
@@ -1613,13 +1614,15 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			continue;
 
 		num_recomps++;
+		comp_mem = zcomp_mem_buffer_get();
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
-		ret = zcomp_compress(zstrm, src, &comp_len_new);
+		ret = zcomp_compress(zstrm, comp_mem, src, &comp_len_new);
 		kunmap_local(src);
 
 		if (ret) {
 			zcomp_stream_put(zram->comps[prio]);
+			zcomp_mem_buffer_put();
 			return ret;
 		}
 
@@ -1630,6 +1633,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
 			zcomp_stream_put(zram->comps[prio]);
+			zcomp_mem_buffer_put();
 			continue;
 		}
 
@@ -1679,12 +1683,14 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 			       __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle_new)) {
 		zcomp_stream_put(zram->comps[prio]);
+		zcomp_mem_buffer_put();
 		return PTR_ERR((void *)handle_new);
 	}
 
 	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
-	memcpy(dst, zstrm->buffer, comp_len_new);
+	memcpy(dst, comp_mem, comp_len_new);
 	zcomp_stream_put(zram->comps[prio]);
+	zcomp_mem_buffer_put();
 
 	zs_unmap_object(zram->mem_pool, handle_new);
 
@@ -2047,6 +2053,7 @@ static ssize_t disksize_store(struct device *dev,
 		zram->comps[prio] = comp;
 		zram->num_active_comps++;
 	}
+
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
 	up_write(&zram->init_lock);
@@ -2384,12 +2391,14 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 
 static void destroy_devices(void)
 {
+	zcomp_mem_destroy();
 	class_unregister(&zram_control_class);
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
 	zram_debugfs_destroy();
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+	cpuhp_remove_multi_state(CPUHP_ZCOMP_MEM_PREPARE);
 }
 
 static int __init zram_init(void)
@@ -2398,15 +2407,26 @@ static int __init zram_init(void)
 
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
 
@@ -2416,6 +2436,7 @@ static int __init zram_init(void)
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
+		cpuhp_remove_multi_state(CPUHP_ZCOMP_MEM_PREPARE);
 		return -EBUSY;
 	}
 
@@ -2428,6 +2449,10 @@ static int __init zram_init(void)
 		num_devices--;
 	}
 
+	ret = zcomp_mem_create();
+	if (ret)
+		goto out_error;
+
 	return 0;
 
 out_error:
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


