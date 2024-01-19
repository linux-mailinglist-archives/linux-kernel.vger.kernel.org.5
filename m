Return-Path: <linux-kernel+bounces-31248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D15832B20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D946C1C247CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8754665;
	Fri, 19 Jan 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nihKf29Q"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A6553E1E;
	Fri, 19 Jan 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673663; cv=none; b=TFDcpWM0uAOkuXI3OYcCuNAS5kcpRsGY0ehvwEqu0tqB/VjY05xz25hOunhkFbs9EFxVGKKMHIhS5r6AEcr9uMhTUvlQkmrSillre9uik9LO0ki0Fn0NH7DInM5deVnFnK2LSq/RqQgjXjIfNJ/loLq9ZBJ9QlEtV+yihRCwTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673663; c=relaxed/simple;
	bh=P3boRy4GijUdd5qAAmLJvetYFLnC/Yi9tbpDH7/AzQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6WvFQlafE6+qa1wVE9ac/3CQB7yjQJtWOvMHc05Kqs1AiQaZQ/XGZWdx9FqxJzZ8pLDqypf15jvaiNv7vqRJf7RdgKPtGaQ1fkRlxmVSWaYxrQuw27ZzEWvQKGXv81tlnsDgGyAE4+woQT0tYrgPIrGom+pVv2Z4kt2Ll4uqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=nihKf29Q; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705673651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqYgKFlSXeXJ+ek05cChLqHNIcn71hJPj0SKGxZRr1E=;
	b=nihKf29QM3PAzCv1lf02nN0Lm7J1hFfqxSiJIykkJWXBNUWAts3p9naI7FhbAo3qS1vUZ+
	AQnGMwjj3hS2I+vprXp5cMewxBvtbj1QizrYkrsEZ5nETFXsE//UAy/FMDfPFQvI/KRz1x
	ZpJEeAwef/CDAgBRqgMIUAVTEo2wVuY=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 1/6] dma-buf: Add dma_buf_{begin,end}_access()
Date: Fri, 19 Jan 2024 15:13:57 +0100
Message-ID: <20240119141402.44262-2-paul@crapouillou.net>
In-Reply-To: <20240119141402.44262-1-paul@crapouillou.net>
References: <20240119141402.44262-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

These functions should be used by device drivers when they start and
stop accessing the data of DMABUF. It allows DMABUF importers to cache
the dma_buf_attachment while ensuring that the data they want to access
is available for their device when the DMA transfers take place.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v5: New patch
---
 drivers/dma-buf/dma-buf.c | 66 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 37 ++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8fe5aa67b167..a8bab6c18fcd 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -830,6 +830,8 @@ static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
  *     - dma_buf_mmap()
  *     - dma_buf_begin_cpu_access()
  *     - dma_buf_end_cpu_access()
+ *     - dma_buf_begin_access()
+ *     - dma_buf_end_access()
  *     - dma_buf_map_attachment_unlocked()
  *     - dma_buf_unmap_attachment_unlocked()
  *     - dma_buf_vmap_unlocked()
@@ -1602,6 +1604,70 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
 
+/**
+ * @dma_buf_begin_access - Call before any hardware access from/to the DMABUF
+ * @attach:	[in]	attachment used for hardware access
+ * @sg_table:	[in]	scatterlist used for the DMA transfer
+ * @direction:  [in]    direction of DMA transfer
+ */
+int dma_buf_begin_access(struct dma_buf_attachment *attach,
+			 struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct dma_buf *dmabuf;
+	bool cookie;
+	int ret;
+
+	if (WARN_ON(!attach))
+		return -EINVAL;
+
+	dmabuf = attach->dmabuf;
+
+	if (!dmabuf->ops->begin_access)
+		return 0;
+
+	cookie = dma_fence_begin_signalling();
+	ret = dmabuf->ops->begin_access(attach, sgt, dir);
+	dma_fence_end_signalling(cookie);
+
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_begin_access, DMA_BUF);
+
+/**
+ * @dma_buf_end_access - Call after any hardware access from/to the DMABUF
+ * @attach:	[in]	attachment used for hardware access
+ * @sg_table:	[in]	scatterlist used for the DMA transfer
+ * @direction:  [in]    direction of DMA transfer
+ */
+int dma_buf_end_access(struct dma_buf_attachment *attach,
+		       struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct dma_buf *dmabuf;
+	bool cookie;
+	int ret;
+
+	if (WARN_ON(!attach))
+		return -EINVAL;
+
+	dmabuf = attach->dmabuf;
+
+	if (!dmabuf->ops->end_access)
+		return 0;
+
+	cookie = dma_fence_begin_signalling();
+	ret = dmabuf->ops->end_access(attach, sgt, dir);
+	dma_fence_end_signalling(cookie);
+
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_end_access, DMA_BUF);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 8ff4add71f88..8ba612c7cc16 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -246,6 +246,38 @@ struct dma_buf_ops {
 	 */
 	int (*end_cpu_access)(struct dma_buf *, enum dma_data_direction);
 
+	/**
+	 * @begin_access:
+	 *
+	 * This is called from dma_buf_begin_access() when a device driver
+	 * wants to access the data of the DMABUF. The exporter can use this
+	 * to flush/sync the caches if needed.
+	 *
+	 * This callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success or a negative error code on failure.
+	 */
+	int (*begin_access)(struct dma_buf_attachment *, struct sg_table *,
+			    enum dma_data_direction);
+
+	/**
+	 * @end_access:
+	 *
+	 * This is called from dma_buf_end_access() when a device driver is
+	 * done accessing the data of the DMABUF. The exporter can use this
+	 * to flush/sync the caches if needed.
+	 *
+	 * This callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success or a negative error code on failure.
+	 */
+	int (*end_access)(struct dma_buf_attachment *, struct sg_table *,
+			  enum dma_data_direction);
+
 	/**
 	 * @mmap:
 	 *
@@ -606,6 +638,11 @@ void dma_buf_detach(struct dma_buf *dmabuf,
 int dma_buf_pin(struct dma_buf_attachment *attach);
 void dma_buf_unpin(struct dma_buf_attachment *attach);
 
+int dma_buf_begin_access(struct dma_buf_attachment *attach,
+			 struct sg_table *sgt, enum dma_data_direction dir);
+int dma_buf_end_access(struct dma_buf_attachment *attach,
+		       struct sg_table *sgt, enum dma_data_direction dir);
+
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info);
 
 int dma_buf_fd(struct dma_buf *dmabuf, int flags);
-- 
2.43.0


