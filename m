Return-Path: <linux-kernel+bounces-71737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A963385A9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D3D1F24DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2B446DA;
	Mon, 19 Feb 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FD7s3Hff"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E444391
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362391; cv=none; b=QXRZOZGXutVBBMk64K7JqY/kXZATcYF7QlUmgenthu7hJh4kUscWnpbmWWal7+fYAnaDesIHtMrbjc55x9nJ4/SLPTZnO9+D7H10E9+RWnktgGR73i1xzS8bA+hgfXdP50Wl8qve7tVbjxgAwK3vkLFIH9czFTaOM733t7jrwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362391; c=relaxed/simple;
	bh=fZ2d/O8CXx/zfhB3r9fEfF8ZYXaxYaSpaL7xiQcTgE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rKVMJqRzpHA6+JC62JfSlSuL2+cHAaY4FkJq0WuvaFrULuBSgUmU1IXRcmdVGz2DjmmSjDd/RLo2Iu2w0Sf9vRv6BxIEggMkfTuavTNzL607vpgVy5H4MhFV1jEab/+8B1f/RPH7eV1U2vwI4h5T+64o9SvHy5DwBAVyNnSt2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FD7s3Hff; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708362388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S21g+iuM5V51KZv+tPhGk9U1eIXrbnWFmHjIoHqqoA8=;
	b=FD7s3HffRumjvu46w2EKiIuPegsZdnhPngYg5ryhcUBG4j56MGCFYE5yZYighUi6Hl0l30
	TsTuLbF3hGpilqxRN5Qs2OHrQR1NWdJ3qTVmpVS2KqzFkWC/2WDUDWNHgLpj3wybmzNbWk
	sFt7YZjYy/ldCAwyTCDiuxmMJBjF2l8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-_nrqxU57M7KIOQonqX4PUQ-1; Mon,
 19 Feb 2024 12:06:17 -0500
X-MC-Unique: _nrqxU57M7KIOQonqX4PUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D59C01C0BA43;
	Mon, 19 Feb 2024 17:06:16 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE7031C060B3;
	Mon, 19 Feb 2024 17:06:13 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	brauner@kernel.org,
	lstoakes@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	david.marchand@redhat.com,
	Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: implement DMA sync callbacks
Date: Mon, 19 Feb 2024 18:06:06 +0100
Message-ID: <20240219170606.587290-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Since commit 295525e29a5b ("virtio_net: merge dma
operations when filling mergeable buffers"), VDUSE device
require support for DMA's .sync_single_for_cpu() operation
as the memory is non-coherent between the device and CPU
because of the use of a bounce buffer.

This patch implements both .sync_single_for_cpu() and
sync_single_for_device() callbacks, and also skip bounce
buffer copies during DMA map and unmap operations if the
DMA_ATTR_SKIP_CPU_SYNC attribute is set to avoid extra
copies of the same buffer.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 27 ++++++++++++++++++++++++---
 drivers/vdpa/vdpa_user/iova_domain.h |  8 ++++++++
 drivers/vdpa/vdpa_user/vduse_dev.c   | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 5e4a77b9bae6..791d38d6284c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -373,6 +373,26 @@ static void vduse_domain_free_iova(struct iova_domain *iovad,
 	free_iova_fast(iovad, iova >> shift, iova_len);
 }
 
+void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir)
+{
+	read_lock(&domain->bounce_lock);
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		vduse_domain_bounce(domain, dma_addr, size, DMA_TO_DEVICE);
+	read_unlock(&domain->bounce_lock);
+}
+
+void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir)
+{
+	read_lock(&domain->bounce_lock);
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
+	read_unlock(&domain->bounce_lock);
+}
+
 dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 				 struct page *page, unsigned long offset,
 				 size_t size, enum dma_data_direction dir,
@@ -393,7 +413,8 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 	if (vduse_domain_map_bounce_page(domain, (u64)iova, (u64)size, pa))
 		goto err_unlock;
 
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		vduse_domain_bounce(domain, iova, size, DMA_TO_DEVICE);
 
 	read_unlock(&domain->bounce_lock);
@@ -411,9 +432,9 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 			     enum dma_data_direction dir, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->stream_iovad;
-
 	read_lock(&domain->bounce_lock);
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
 		vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
 
 	vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 173e979b84a9..f92f22a7267d 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -44,6 +44,14 @@ int vduse_domain_set_map(struct vduse_iova_domain *domain,
 void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 			    struct vhost_iotlb *iotlb);
 
+void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir);
+
+void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
+				      dma_addr_t dma_addr, size_t size,
+				      enum dma_data_direction dir);
+
 dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
 				 struct page *page, unsigned long offset,
 				 size_t size, enum dma_data_direction dir,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1d24da79c399..75354ce186a1 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -798,6 +798,26 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.free			= vduse_vdpa_free,
 };
 
+static void vduse_dev_sync_single_for_device(struct device *dev,
+					     dma_addr_t dma_addr, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_iova_domain *domain = vdev->domain;
+
+	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
+}
+
+static void vduse_dev_sync_single_for_cpu(struct device *dev,
+					     dma_addr_t dma_addr, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_iova_domain *domain = vdev->domain;
+
+	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
+}
+
 static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
@@ -858,6 +878,8 @@ static size_t vduse_dev_max_mapping_size(struct device *dev)
 }
 
 static const struct dma_map_ops vduse_dev_dma_ops = {
+	.sync_single_for_device = vduse_dev_sync_single_for_device,
+	.sync_single_for_cpu = vduse_dev_sync_single_for_cpu,
 	.map_page = vduse_dev_map_page,
 	.unmap_page = vduse_dev_unmap_page,
 	.alloc = vduse_dev_alloc_coherent,
-- 
2.43.0


