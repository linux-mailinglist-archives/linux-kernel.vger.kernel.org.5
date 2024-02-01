Return-Path: <linux-kernel+bounces-48998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84E84647D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE2F28A85A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE3481AD;
	Thu,  1 Feb 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db8nUKg+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1F47F57
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830464; cv=none; b=JHmar9SCbZLVzqldqwWaoBKobCVtwfIZ3f9rewOK4xJkugGS0UvoKLIAjuLwbOK2a+fFe7Wpi1DQluMSNPkJBpi/wtvPtDj3NtsJ3rssbsrVw7rEYVyBSE4RUPhLwb7UnP8R4pdnMMvGiE03jcA44IW4lH3CafSk6oFJi9s/Zwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830464; c=relaxed/simple;
	bh=AVG0aFP8okb+tYmPodyeA6t8ACKIOa5mpXDxU39XVjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5rXUYyLdcQ/NSzKvTkGHrpuUgZYh+BUHdQmtn9Jd9gYjvhaqN98VvPrTCUam5ghEsiYvhxdJ8vAnotozeYmvThCbh9ZGeywrLPR2f6+GTcLY/UBPyQscVHOpnn5MmxNxoKCYutfFX3acLgZzFp5HTJpBuZj3M1kjPh8cxFdFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=db8nUKg+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706830461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSHqITouUlq7CCUtWN8V4a0IRIlAJ0GlTBNdFKzO/Ok=;
	b=db8nUKg+EHFZ25VAzBj0RxHSX6cQb0g6FKVy4PKW/v+EjlwZEYQslICqoPMWqv/51ER0Ku
	86+cZm/H67+VuDaMwuzFQ85x/qB6Ud7WDjs0tkKYHk32Pkq34jq5tkRABKGnv4rPn9Hv2E
	NFB4hDSESPY3KycTKJATgl6WY90zjwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-gY9EdXkqNSGdobHRO1yUfg-1; Thu, 01 Feb 2024 18:34:18 -0500
X-MC-Unique: gY9EdXkqNSGdobHRO1yUfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2A1837227;
	Thu,  1 Feb 2024 23:34:18 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.rmtusor.csb (unknown [10.2.16.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1296A1BDB1;
	Thu,  1 Feb 2024 23:34:16 +0000 (UTC)
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
Subject: [PATCH v5 1/4] uio: introduce UIO_MEM_DMA_COHERENT type
Date: Thu,  1 Feb 2024 15:33:57 -0800
Message-ID: <20240201233400.3394996-2-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-1-cleech@redhat.com>
References: <20240201233400.3394996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add a UIO memtype specifically for sharing dma_alloc_coherent
memory with userspace, backed by dma_mmap_coherent.

This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
are a few other uio drivers which map dma_alloc_coherent memory and will
be converted to use dma_mmap_coherent as well.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/uio/uio.c          | 47 ++++++++++++++++++++++++++++++++++++++
 include/linux/uio_driver.h |  8 +++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 2d572f6c8ec83..bb77de6fa067e 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -24,6 +24,7 @@
 #include <linux/kobject.h>
 #include <linux/cdev.h>
 #include <linux/uio_driver.h>
+#include <linux/dma-mapping.h>
 
 #define UIO_MAX_DEVICES		(1U << MINORBITS)
 
@@ -759,6 +760,49 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
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
+	if (mem->addr & ~PAGE_MASK)
+		return -ENODEV;
+	if (mem->dma_addr & ~PAGE_MASK)
+		return -ENODEV;
+	if (!mem->dma_device)
+		return -ENODEV;
+	if (vma->vm_end - vma->vm_start > mem->size)
+		return -EINVAL;
+
+	dev_warn(mem->dma_device,
+		 "use of UIO_MEM_DMA_COHERENT is highly discouraged");
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
@@ -806,6 +850,9 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
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
index 47c5962b876b0..a7756f909dd01 100644
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
 
@@ -158,6 +160,12 @@ extern int __must_check
 #define UIO_MEM_LOGICAL	2
 #define UIO_MEM_VIRTUAL 3
 #define UIO_MEM_IOVA	4
+/*
+ * UIO_MEM_DMA_COHERENT exists for legacy drivers that had been getting by with
+ * improperly mapping DMA coherent allocations through the other modes.
+ * Do not use in new drivers.
+ */
+#define UIO_MEM_DMA_COHERENT	5
 
 /* defines for uio_port->porttype */
 #define UIO_PORT_NONE	0
-- 
2.43.0


