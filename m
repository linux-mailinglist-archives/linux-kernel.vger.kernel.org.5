Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4837B3849
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjI2RBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjI2RBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90CB1B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696006845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+oquGKuGwxfFoQE+GbMX8EY8O13dfuQB8zXuBNfC+6k=;
        b=Kt/iuFqC1I8L9ODVa/7foS9JAYvY+cHYphCQo/xEqdi/wXUDYnBT/FV2YI9ZU2pbopy35g
        JjpqJi7hqaU0Cgi420SLuTeGkCdZJK8ZnF2v9E1wzzfCx0u8OS20qBGpEKrUIr1m8Hihc4
        Uff3c6NVL69F90rDqB0cfeRPpWwcDLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-drVkHA9PODavbdJcMzCG8Q-1; Fri, 29 Sep 2023 13:00:43 -0400
X-MC-Unique: drVkHA9PODavbdJcMzCG8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DE8F8007A4;
        Fri, 29 Sep 2023 17:00:43 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.2.16.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BAF2C15BB8;
        Fri, 29 Sep 2023 17:00:41 +0000 (UTC)
From:   Chris Leech <cleech@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] uio: introduce UIO_DMA_COHERENT type
Date:   Fri, 29 Sep 2023 10:00:21 -0700
Message-ID: <20230929170023.1020032-2-cleech@redhat.com>
In-Reply-To: <20230929170023.1020032-1-cleech@redhat.com>
References: <20230929170023.1020032-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a UIO memtype specificially for sharing dma_alloc_coherent
memory with userspace, backed by dma_mmap_coherent.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/uio/uio.c          | 34 ++++++++++++++++++++++++++++++++++
 include/linux/uio_driver.h | 12 ++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 62082d64ece0..f8f1f7ba6378 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -24,6 +24,7 @@
 #include <linux/kobject.h>
 #include <linux/cdev.h>
 #include <linux/uio_driver.h>
+#include <linux/dma-mapping.h>
 
 #define UIO_MAX_DEVICES		(1U << MINORBITS)
 
@@ -759,6 +760,36 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
 			       vma->vm_page_prot);
 }
 
+static int uio_mmap_dma_coherent(struct vm_area_struct *vma)
+{
+	struct uio_device *idev = vma->vm_private_data;
+	int mi = uio_find_mem_index(vma);
+	struct uio_mem *mem;
+	int rc;
+
+	if (mi < 0)
+		return -EINVAL;
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
+	rc = dma_mmap_coherent(mem->dma_device,
+				vma,
+				mem->virtual_addr,
+				mem->dma_addr,
+				vma->vm_end - vma->vm_start);
+	vma->vm_pgoff = mi;
+	return rc;
+}
+
 static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct uio_listener *listener = filep->private_data;
@@ -806,6 +837,9 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
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
index 47c5962b876b..ede58e984658 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -36,11 +36,18 @@ struct uio_map;
  */
 struct uio_mem {
 	const char		*name;
-	phys_addr_t		addr;
+	union {
+		phys_addr_t	addr;
+		dma_addr_t	dma_addr;
+	};
 	unsigned long		offs;
 	resource_size_t		size;
 	int			memtype;
-	void __iomem		*internal_addr;
+	union {
+		void __iomem	*internal_addr;
+		void 		*virtual_addr;
+	};
+	struct device		*dma_device;
 	struct uio_map		*map;
 };
 
@@ -158,6 +165,7 @@ extern int __must_check
 #define UIO_MEM_LOGICAL	2
 #define UIO_MEM_VIRTUAL 3
 #define UIO_MEM_IOVA	4
+#define UIO_MEM_DMA_COHERENT	5
 
 /* defines for uio_port->porttype */
 #define UIO_PORT_NONE	0
-- 
2.41.0

