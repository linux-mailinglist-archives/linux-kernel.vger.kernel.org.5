Return-Path: <linux-kernel+bounces-96762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B620876115
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2121F22FE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69403535BA;
	Fri,  8 Mar 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pof4sQ+/"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B652F89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890926; cv=none; b=GCyFE+4cOTqJX/NRSyLHtJMqbZ1KE4jz/PiZNlAgwErFzc7Hcv/4Hdzv0U1VKeKLZ//uCgw2BSWJStpiax41Trn9+4EVgJMU1L6qJxQjn0q+BKpjeUh69CJva4yF8SOHKv1JFPKMXCwGDXHhWzTgbiXyvYi3DiWbiLe9ufo/KSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890926; c=relaxed/simple;
	bh=T2Cy2kJ4vhRsmBGJkr/PE960AJYhrucMr4EG4hHIgvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KI8XdaSNpM8znin42rj+JheVf+oHu5ZEVCTWn/pQmkgdBh6kE3wELdXEy6ZbTt0MNZcKVLLS/poec4GIddC/MVaM4gS2ndROxcCe0jedBpuHC7kdYqsObuhw6PTNYyQdhQz8vVfyDM1ZObXKAv8VZHkPfxfCtrRGsfueMXbwqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pof4sQ+/; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709890920; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eT+Nim6d9kWMCbIuKAlX8JuFkGDVnrD/Gqgz5Y7Tp+s=;
	b=Pof4sQ+/RE5jGwkUwzpB7TiGnyLGYedk6FvyZdQnTDFhFTjwV7i0YQ+Yt4yItEn9LPnK9u6oTn4JbwQ/KKGGLhzwVdJ7DfzwBGgbEowSEx3pWV4IpoaDIeiCFu/A6aC15gnSyNGxgz9Fe6A54mTFquijKbYyUhs34TVzXfZKLlU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W22J-6C_1709890919;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W22J-6C_1709890919)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 17:42:00 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] erofs: make iov_iter describe target buffers over fscache
Date: Fri,  8 Mar 2024 17:41:58 +0800
Message-Id: <20240308094159.40547-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far the fscache mode supports uncompressed data only, and the data
read from fscache is put directly into the target page cache.  As the
support for compressed data in fscache mode is going to be introduced,
rework the fscache internals so that the following compressed part
could make the raw data read from fscache be directed to the target
buffer it wants, decompress the raw data, and finally fill the page
cache with the decompressed data.

As the first step, a new structure, i.e. erofs_fscache_io (io), is
introduced to describe a generic read request from the fscache, while
the caller can specify the target buffer it wants in the iov_iter
structure (io->iter).  Besides, the caller can also specify its
completion callback and private data through erofs_fscache_io, which
will be called to make further handling, e.g. unlocking the page cache
for uncompressed data or decompressing the read raw data, when the read
request from the fscache completes.  Now erofs_fscache_read_io_async()
serves as a generic interface for reading raw data from fscache for both
compressed and uncompressed data.

The erofs_fscache_rq structure is kept to describe a request to fill the
page cache in the specified range.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 235 ++++++++++++++++++++++++---------------------
 1 file changed, 123 insertions(+), 112 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 122a4753ecea..b9fb4c4da39c 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -25,9 +25,15 @@ static struct file_system_type erofs_anon_fs_type = {
 	.kill_sb        = kill_anon_super,
 };
 
-struct erofs_fscache_request {
-	struct erofs_fscache_request *primary;
-	struct netfs_cache_resources cache_resources;
+struct erofs_fscache_io {
+	struct netfs_cache_resources cres;
+	struct iov_iter		iter;
+	netfs_io_terminated_t	end_io;
+	void			*private;
+	refcount_t		ref;
+};
+
+struct erofs_fscache_rq {
 	struct address_space	*mapping;	/* The mapping being accessed */
 	loff_t			start;		/* Start position */
 	size_t			len;		/* Length of the request */
@@ -36,44 +42,17 @@ struct erofs_fscache_request {
 	refcount_t		ref;
 };
 
-static struct erofs_fscache_request *erofs_fscache_req_alloc(struct address_space *mapping,
-					     loff_t start, size_t len)
-{
-	struct erofs_fscache_request *req;
-
-	req = kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
-	if (!req)
-		return ERR_PTR(-ENOMEM);
-
-	req->mapping = mapping;
-	req->start   = start;
-	req->len     = len;
-	refcount_set(&req->ref, 1);
-
-	return req;
-}
-
-static struct erofs_fscache_request *erofs_fscache_req_chain(struct erofs_fscache_request *primary,
-					     size_t len)
+static bool erofs_fscache_io_put(struct erofs_fscache_io *io)
 {
-	struct erofs_fscache_request *req;
-
-	/* use primary request for the first submission */
-	if (!primary->submitted) {
-		refcount_inc(&primary->ref);
-		return primary;
-	}
-
-	req = erofs_fscache_req_alloc(primary->mapping,
-			primary->start + primary->submitted, len);
-	if (!IS_ERR(req)) {
-		req->primary = primary;
-		refcount_inc(&primary->ref);
-	}
-	return req;
+	if (!refcount_dec_and_test(&io->ref))
+		return false;
+	if (io->cres.ops)
+		io->cres.ops->end_operation(&io->cres);
+	kfree(io);
+	return true;
 }
 
-static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
+static void erofs_fscache_req_complete(struct erofs_fscache_rq *req)
 {
 	struct folio *folio;
 	bool failed = req->error;
@@ -93,120 +72,149 @@ static void erofs_fscache_req_complete(struct erofs_fscache_request *req)
 	rcu_read_unlock();
 }
 
-static void erofs_fscache_req_put(struct erofs_fscache_request *req)
+static void erofs_fscache_req_put(struct erofs_fscache_rq *req)
 {
-	if (refcount_dec_and_test(&req->ref)) {
-		if (req->cache_resources.ops)
-			req->cache_resources.ops->end_operation(&req->cache_resources);
-		if (!req->primary)
-			erofs_fscache_req_complete(req);
-		else
-			erofs_fscache_req_put(req->primary);
-		kfree(req);
-	}
+	if (!refcount_dec_and_test(&req->ref))
+		return;
+	erofs_fscache_req_complete(req);
+	kfree(req);
+}
+
+static struct erofs_fscache_rq *erofs_fscache_req_alloc(struct address_space *mapping,
+						loff_t start, size_t len)
+{
+	struct erofs_fscache_rq *req = kzalloc(sizeof(*req), GFP_KERNEL);
+
+	if (!req)
+		return NULL;
+	req->mapping = mapping;
+	req->start = start;
+	req->len = len;
+	refcount_set(&req->ref, 1);
+	return req;
 }
 
-static void erofs_fscache_subreq_complete(void *priv,
+static void erofs_fscache_req_io_put(struct erofs_fscache_io *io)
+{
+	struct erofs_fscache_rq *req = io->private;
+
+	if (erofs_fscache_io_put(io))
+		erofs_fscache_req_put(req);
+}
+
+static void erofs_fscache_req_end_io(void *priv,
 		ssize_t transferred_or_error, bool was_async)
 {
-	struct erofs_fscache_request *req = priv;
+	struct erofs_fscache_io *io = priv;
+	struct erofs_fscache_rq *req = io->private;
 
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		if (req->primary)
-			req->primary->error = transferred_or_error;
-		else
-			req->error = transferred_or_error;
-	}
-	erofs_fscache_req_put(req);
+	if (IS_ERR_VALUE(transferred_or_error))
+		req->error = transferred_or_error;
+	erofs_fscache_req_io_put(io);
+}
+
+static struct erofs_fscache_io *erofs_fscache_req_io_alloc(struct erofs_fscache_rq *req)
+{
+	struct erofs_fscache_io *io = kzalloc(sizeof(*io), GFP_KERNEL);
+
+	if (!io)
+		return NULL;
+	io->end_io = erofs_fscache_req_end_io;
+	io->private = req;
+	refcount_inc(&req->ref);
+	refcount_set(&io->ref, 1);
+	return io;
 }
 
 /*
- * Read data from fscache (cookie, pstart, len), and fill the read data into
- * page cache described by (req->mapping, lstart, len). @pstart describeis the
- * start physical address in the cache file.
+ * Read data from fscache described by cookie at pstart physical address
+ * offset, and fill the read data into buffer described by io->iter.
  */
-static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
-		struct erofs_fscache_request *req, loff_t pstart, size_t len)
+static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
+		loff_t pstart, struct erofs_fscache_io *io)
 {
 	enum netfs_io_source source;
-	struct super_block *sb = req->mapping->host->i_sb;
-	struct netfs_cache_resources *cres = &req->cache_resources;
-	struct iov_iter iter;
-	loff_t lstart = req->start + req->submitted;
-	size_t done = 0;
+	struct netfs_cache_resources *cres = &io->cres;
+	struct iov_iter *iter = &io->iter;
 	int ret;
 
-	DBG_BUGON(len > req->len - req->submitted);
-
 	ret = fscache_begin_read_operation(cres, cookie);
 	if (ret)
 		return ret;
 
-	while (done < len) {
-		loff_t sstart = pstart + done;
-		size_t slen = len - done;
+	while (iov_iter_count(iter)) {
+		size_t orig_count = iov_iter_count(iter), len = orig_count;
 		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
 
 		source = cres->ops->prepare_ondemand_read(cres,
-				sstart, &slen, LLONG_MAX, &flags, 0);
-		if (WARN_ON(slen == 0))
+				pstart, &len, LLONG_MAX, &flags, 0);
+		if (WARN_ON(len == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
+			erofs_err(NULL, "prepare_read failed (source %d)", source);
 			return -EIO;
 		}
 
-		refcount_inc(&req->ref);
-		iov_iter_xarray(&iter, ITER_DEST, &req->mapping->i_pages,
-				lstart + done, slen);
-
-		ret = fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
-				   erofs_fscache_subreq_complete, req);
+		iov_iter_truncate(iter, len);
+		refcount_inc(&io->ref);
+		ret = fscache_read(cres, pstart, iter, NETFS_READ_HOLE_FAIL,
+				   io->end_io, io);
 		if (ret == -EIOCBQUEUED)
 			ret = 0;
 		if (ret) {
-			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
+			erofs_err(NULL, "fscache_read failed (ret %d)", ret);
 			return ret;
 		}
+		if (WARN_ON(iov_iter_count(iter)))
+			return -EIO;
 
-		done += slen;
+		iov_iter_reexpand(iter, orig_count - len);
+		pstart += len;
 	}
-	DBG_BUGON(done != len);
 	return 0;
 }
 
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
-	int ret;
 	struct erofs_fscache *ctx = folio->mapping->host->i_private;
-	struct erofs_fscache_request *req;
+	int ret = -ENOMEM;
+	struct erofs_fscache_rq *req;
+	struct erofs_fscache_io *io;
 
 	req = erofs_fscache_req_alloc(folio->mapping,
 				folio_pos(folio), folio_size(folio));
-	if (IS_ERR(req)) {
+	if (!req) {
 		folio_unlock(folio);
-		return PTR_ERR(req);
+		return ret;
 	}
 
-	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
-				folio_pos(folio), folio_size(folio));
+	io = erofs_fscache_req_io_alloc(req);
+	if (!io) {
+		req->error = ret;
+		goto out;
+	}
+	iov_iter_xarray(&io->iter, ITER_DEST, &folio->mapping->i_pages,
+			folio_pos(folio), folio_size(folio));
+
+	ret = erofs_fscache_read_io_async(ctx->cookie, folio_pos(folio), io);
 	if (ret)
 		req->error = ret;
 
+	erofs_fscache_req_io_put(io);
+out:
 	erofs_fscache_req_put(req);
 	return ret;
 }
 
-static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
+static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 {
-	struct address_space *mapping = primary->mapping;
+	struct address_space *mapping = req->mapping;
 	struct inode *inode = mapping->host;
 	struct super_block *sb = inode->i_sb;
-	struct erofs_fscache_request *req;
+	struct erofs_fscache_io *io;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
-	struct iov_iter iter;
-	loff_t pos = primary->start + primary->submitted;
+	loff_t pos = req->start + req->submitted;
 	size_t count;
 	int ret;
 
@@ -217,6 +225,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+		struct iov_iter iter;
 		erofs_blk_t blknr;
 		size_t offset, size;
 		void *src;
@@ -237,15 +246,17 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 		}
 		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		primary->submitted += PAGE_SIZE;
+		req->submitted += PAGE_SIZE;
 		return 0;
 	}
 
-	count = primary->len - primary->submitted;
+	count = req->len - req->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		struct iov_iter iter;
+
 		iov_iter_xarray(&iter, ITER_DEST, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
-		primary->submitted += count;
+		req->submitted += count;
 		return 0;
 	}
 
@@ -260,18 +271,19 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	if (ret)
 		return ret;
 
-	req = erofs_fscache_req_chain(primary, count);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	io = erofs_fscache_req_io_alloc(req);
+	if (!io)
+		return -ENOMEM;
+	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
+	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
+			mdev.m_pa + (pos - map.m_la), io);
+	erofs_fscache_req_io_put(io);
 
-	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-			req, mdev.m_pa + (pos - map.m_la), count);
-	erofs_fscache_req_put(req);
-	primary->submitted += count;
+	req->submitted += count;
 	return ret;
 }
 
-static int erofs_fscache_data_read(struct erofs_fscache_request *req)
+static int erofs_fscache_data_read(struct erofs_fscache_rq *req)
 {
 	int ret;
 
@@ -280,20 +292,19 @@ static int erofs_fscache_data_read(struct erofs_fscache_request *req)
 		if (ret)
 			req->error = ret;
 	} while (!ret && req->submitted < req->len);
-
 	return ret;
 }
 
 static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 {
-	struct erofs_fscache_request *req;
+	struct erofs_fscache_rq *req;
 	int ret;
 
 	req = erofs_fscache_req_alloc(folio->mapping,
 			folio_pos(folio), folio_size(folio));
-	if (IS_ERR(req)) {
+	if (!req) {
 		folio_unlock(folio);
-		return PTR_ERR(req);
+		return -ENOMEM;
 	}
 
 	ret = erofs_fscache_data_read(req);
@@ -303,14 +314,14 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 
 static void erofs_fscache_readahead(struct readahead_control *rac)
 {
-	struct erofs_fscache_request *req;
+	struct erofs_fscache_rq *req;
 
 	if (!readahead_count(rac))
 		return;
 
 	req = erofs_fscache_req_alloc(rac->mapping,
 			readahead_pos(rac), readahead_length(rac));
-	if (IS_ERR(req))
+	if (!req)
 		return;
 
 	/* The request completion will drop refs on the folios. */
-- 
2.19.1.6.gb485710b


