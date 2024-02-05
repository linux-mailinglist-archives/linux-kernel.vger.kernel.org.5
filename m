Return-Path: <linux-kernel+bounces-53883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08B84A79C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7998283D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF778128821;
	Mon,  5 Feb 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOci+CJg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4612881B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163324; cv=none; b=LEqA+5PwEEcGz/509zCGShnjxP5pOfK8IAprM71u7cB5NM9vNc3f5jyA2BwHzGO2L3vV/pHqyeHBeG9lz3pKP6saXkca5ITDMtKqtaXJGvM7xbSnpWMm9bTnCtPjValtbY7C36pK0LhBD5OGE7eEFFZPsovpoFjsm8g93aKRQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163324; c=relaxed/simple;
	bh=/2F+Sqat3Ko5wi/4JmycWRWYNNOWf+ZQKZsSpCoS6r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTCVGNBB4aB6WfmaDZqzSGgkD83uiAObSsWhCWCnrzND9Y9h6ymlJ/2vwV2pn6UubNql4HI28HrqkmfaN7mp48Iu+5FANkeWlNc+SKKo8R8Et7giMdEIiTcVTY8ft1Nclw9aYKM7CYktZji9DCAUWhRxnBkFDRkwILLOtf9B16c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOci+CJg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707163321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8zENVDSDVSHR2uqkr4zv65dSkFxFna4B1bFIhcbej0=;
	b=XOci+CJgpR7rDCsAYKe7zCWV2OmUxorvkMec68fGH2C1n3kV0H//i97WfYa7AQA6BiIcfx
	gh96UT4cFcZ9BU1OqE1mbB29hsKFuXwyHZugtdvnHECqczZwm9/ISW6E77+LywF3hfYM8t
	WxAqgXNoHpofY+3SQzq/W0WfNUnxZyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-KzCqOMJQPj-9b5m3zOmyKg-1; Mon, 05 Feb 2024 15:01:53 -0500
X-MC-Unique: KzCqOMJQPj-9b5m3zOmyKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9926985A58A;
	Mon,  5 Feb 2024 20:01:52 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.2.16.180])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 476215012;
	Mon,  5 Feb 2024 20:01:51 +0000 (UTC)
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
	GR-QLogic-Storage-Upstream@marvell.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v6 1/4] uio: introduce UIO_MEM_DMA_COHERENT type
Date: Mon,  5 Feb 2024 12:01:37 -0800
Message-ID: <20240205200137.138302-1-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-2-cleech@redhat.com>
References: <20240201233400.3394996-2-cleech@redhat.com>
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
---
v6: added kdoc comments

 drivers/uio/uio.c          | 47 ++++++++++++++++++++++++++++++++++++++
 include/linux/uio_driver.h | 13 +++++++++++
 2 files changed, 60 insertions(+)

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
index 47c5962b876b0..18238dc8bfd35 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -28,19 +28,26 @@ struct uio_map;
  *			logical, virtual, or physical & phys_addr_t
  *			should always be large enough to handle any of
  *			the address types)
+ * @dma_addr:		DMA handle set by dma_alloc_coherent, used with
+ *			UIO_MEM_DMA_COHERENT only (@addr should be the
+ *			void * returned from the same dma_alloc_coherent call)
  * @offs:               offset of device memory within the page
  * @size:		size of IO (multiple of page size)
  * @memtype:		type of memory addr points to
  * @internal_addr:	ioremap-ped version of addr, for driver internal use
+ * @dma_device:		device struct that was passed to dma_alloc_coherent,
+ *			used with UIO_MEM_DMA_COHERENT only
  * @map:		for use by the UIO core only.
  */
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
 
@@ -158,6 +165,12 @@ extern int __must_check
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


