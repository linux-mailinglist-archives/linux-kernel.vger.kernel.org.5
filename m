Return-Path: <linux-kernel+bounces-142732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252978A2F73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0E5281CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D6824B6;
	Fri, 12 Apr 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4LChcae"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822A824A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928690; cv=none; b=NV3V1tqr8zNV/zBGCnE4wlCFQ7OyEe4JYYSJowgPngiJ1t19QKgKJIBoYSfisNv3Wwi6USl4pyOqX2aAU2vANhOX8KoOr78/SjmnmXS7ZcYNhSzzWiHFmF3AFumXnpWPc08SbyC8G9QKK+HsD2pEjna6qC5UK0LU1qBoJiRo3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928690; c=relaxed/simple;
	bh=bKN8UQ9NS8z8CGfSU2og9P/q9mfucOox+qnqy3HOHbs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjqoMaSLl2vz4HxUQ1ZUnxej1EDgq9MKu6V5eK8CSD9TksB+HKWSDQlJwte9boVGqOqRDgW3I9mJ/8+ITg2QWCJP2Kt8ZevaxGCsF1AAa8Nud3Ew8S+/zUJTYG971c6d5vXjmbPnob3UI413tvzLLMLNjH0y5+ZfmGl2BmaigJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4LChcae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35sWc1yIwO6N5kVcpws/O6LKONaL5+Jtm0fcsW8kNnY=;
	b=g4LChcaeHUQmXlrds4ho8WCSxAu99al0QyKmxK1BKW+yE2QTgcEx+BW50GdSo2tr3NMpRU
	55woQAxJMxYjJwQVXiC6U3wGLU1FGXdw6yLruHjiNBTw9X7yMkH2sbaXtxkTzjud0ErqF2
	V3ZhItY4FmeqVI2SAg38OTsnRbsMDTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-r1p6kOVmNpGuT-qX4K-ScA-1; Fri, 12 Apr 2024 09:31:26 -0400
X-MC-Unique: r1p6kOVmNpGuT-qX4K-ScA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0643B80A1B9;
	Fri, 12 Apr 2024 13:31:26 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A25CC10E4B;
	Fri, 12 Apr 2024 13:31:23 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 4/5] vduse: Add file operation for mmap
Date: Fri, 12 Apr 2024 21:28:24 +0800
Message-ID: <20240412133017.483407-5-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-1-lulu@redhat.com>
References: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add the operation for mmap, This function  will be used by the user space
application to map the pages to the user space.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2da659d5f4a8..7abe0c17cf0e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1465,6 +1465,61 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
 	return dev;
 }
 
+static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
+{
+	struct vduse_dev *dev = vmf->vma->vm_file->private_data;
+	struct vm_area_struct *vma = vmf->vma;
+	u16 index = vma->vm_pgoff;
+	struct vduse_virtqueue *vq;
+	unsigned long vaddr;
+
+	/* index 0~vq_number-1 page reserved for virtqueue state*/
+	vq = dev->vqs[index];
+	vaddr = vq->vdpa_reconnect_vaddr;
+	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
+			    PFN_DOWN(virt_to_phys((void *)vaddr)), PAGE_SIZE,
+			    vma->vm_page_prot))
+		return VM_FAULT_SIGBUS;
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct vduse_vm_ops = {
+	.fault = vduse_vm_fault,
+};
+
+static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct vduse_dev *dev = file->private_data;
+	unsigned long vaddr = 0;
+	unsigned long index = vma->vm_pgoff;
+	struct vduse_virtqueue *vq;
+
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+	if (index >= dev->vq_num)
+		return -EINVAL;
+
+	index = array_index_nospec(index, dev->vq_num);
+	vq = dev->vqs[index];
+	vaddr = vq->vdpa_reconnect_vaddr;
+	if (vaddr == 0)
+		return -EOPNOTSUPP;
+
+	if (virt_to_phys((void *)vaddr) & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	/* Check if the Userspace App mapped the correct size */
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EOPNOTSUPP;
+
+	vm_flags_set(vma, VM_DONTEXPAND);
+	vma->vm_ops = &vduse_vm_ops;
+
+	return 0;
+}
+
 static int vduse_dev_open(struct inode *inode, struct file *file)
 {
 	int ret;
@@ -1497,6 +1552,8 @@ static const struct file_operations vduse_dev_fops = {
 	.unlocked_ioctl	= vduse_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
+	.mmap		= vduse_dev_mmap,
+
 };
 
 static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
-- 
2.43.0


