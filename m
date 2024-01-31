Return-Path: <linux-kernel+bounces-47010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0628447E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E9B289BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC7374DE;
	Wed, 31 Jan 2024 19:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnAQ8c7l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6338387
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728680; cv=none; b=p9W+Xf44pGPjBN3jL1bz8o63kvlzJiezz4bLeUIS6pQPxnSpdy5w4B+of9i6mRAB7K7lkksrwEOeT4vbUUTQDvyY2q0zd+aq/KpwrncnCwsofd84Z0r4RjxMV/2VyiEKAZthRFbHrIRqE5DjmmRaYNbFP5MsEGarfOSMnGVrZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728680; c=relaxed/simple;
	bh=2DnmIvdGmjURmShJtRCsEJMDdPmjxWUH1IKPlXRajfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IINaTiFGB3zegt8ok+tNINp+Rgmo6hAvXOOipWmlXeANjG5u62utGjY3uAErXn+ws5qzyTuYKC2hCUimntzJitMJcaP9XRgfODS678NCGUAjztJo98mt5jRViYq7CwGQQ42CjjINyrrNlWp+s3WB16F8tu6M6uRudgv2QPJpROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnAQ8c7l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706728677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGf8V7YbO8S1JxykOgAqwJn9BdraNH1lFGF1LdAyQdg=;
	b=gnAQ8c7l1RRHHn8MqZPNnBJLi/XfhK2fLwmhywPLS7gUhKGbFQLJascpSt90vAOAwF4CM5
	NAujZv9JUZntxswwGFpAHgwq1SjSnhVWCzF4T26fAJU1BhLdZwRz5izHHrpRNy1DmBUJXD
	p3EoNAtqFHclvgVlhkT8rM9db74LJsM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-RcjBULaaPWGpQPubRupjSg-1; Wed,
 31 Jan 2024 14:17:55 -0500
X-MC-Unique: RcjBULaaPWGpQPubRupjSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5870329AC03F;
	Wed, 31 Jan 2024 19:17:54 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.rmtusor.csb (unknown [10.2.16.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C24840CD14B;
	Wed, 31 Jan 2024 19:17:53 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>
Cc: Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
Date: Wed, 31 Jan 2024 11:17:31 -0800
Message-ID: <20240131191732.3247996-2-cleech@redhat.com>
In-Reply-To: <20240131191732.3247996-1-cleech@redhat.com>
References: <20240131191732.3247996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add a UIO memtype specifically for sharing dma_alloc_coherent
memory with userspace, backed by dma_mmap_coherent.

This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
are a few other uio drivers which map dma_alloc_coherent memory and
could be converted to use dma_mmap_coherent as well.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/uio/uio.c          | 40 ++++++++++++++++++++++++++++++++++++++
 include/linux/uio_driver.h |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 2d572f6c8ec83..dde3f49855233 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -24,6 +24,7 @@
 #include <linux/kobject.h>
 #include <linux/cdev.h>
 #include <linux/uio_driver.h>
+#include <linux/dma-mapping.h>
 
 #define UIO_MAX_DEVICES		(1U << MINORBITS)
 
@@ -759,6 +760,42 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
 			       vma->vm_page_prot);
 }
 
+static int uio_mmap_dma_coherent(struct vm_area_struct *vma)
+{
+	struct uio_device *idev = vma->vm_private_data;
+	struct uio_mem *mem;
+	void *addr;
+	int ret = 0;
+	int mi;
+
+	mi = uio_find_mem_index(vma);
+	if (mi < 0)
+		return -EINVAL;
+
+	mem = idev->info->mem + mi;
+
+	if (mem->dma_addr & ~PAGE_MASK)
+		return -ENODEV;
+	if (vma->vm_end - vma->vm_start > mem->size)
+		return -EINVAL;
+
+	/*
+	 * UIO uses offset to index into the maps for a device.
+	 * We need to clear vm_pgoff for dma_mmap_coherent.
+	 */
+	vma->vm_pgoff = 0;
+
+	addr = (void *)mem->addr;
+	ret = dma_mmap_coherent(mem->dma_device,
+				vma,
+				addr,
+				mem->dma_addr,
+				vma->vm_end - vma->vm_start);
+	vma->vm_pgoff = mi;
+
+	return ret;
+}
+
 static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct uio_listener *listener = filep->private_data;
@@ -806,6 +843,9 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	case UIO_MEM_VIRTUAL:
 		ret = uio_mmap_logical(vma);
 		break;
+	case UIO_MEM_DMA_COHERENT:
+		ret = uio_mmap_dma_coherent(vma);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 47c5962b876b0..14d9dd2a07e85 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -37,10 +37,12 @@ struct uio_map;
 struct uio_mem {
 	const char		*name;
 	phys_addr_t		addr;
+	dma_addr_t		dma_addr;
 	unsigned long		offs;
 	resource_size_t		size;
 	int			memtype;
 	void __iomem		*internal_addr;
+	struct device		*dma_device;
 	struct uio_map		*map;
 };
 
@@ -158,6 +160,7 @@ extern int __must_check
 #define UIO_MEM_LOGICAL	2
 #define UIO_MEM_VIRTUAL 3
 #define UIO_MEM_IOVA	4
+#define UIO_MEM_DMA_COHERENT	5
 
 /* defines for uio_port->porttype */
 #define UIO_PORT_NONE	0
-- 
2.43.0


