Return-Path: <linux-kernel+bounces-55984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFF84C47C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF288B27D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603211F953;
	Wed,  7 Feb 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAVrWgRy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE41F946
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284866; cv=none; b=qR+tGSuzlQ57Ri4pnicTRT3VYL480D1iGHlSt4nj4TkNY6ez1o10iYExUBXflWJKE2BhpCdMwdxRyM6mPfwQym22qGyPO69K5kBpBmRCq2gji7RQeIxjbwrOn6FUtk8/209m1ezaIzr1FUJ2X9XaoDCCE7Ewik2OSlFqTkrB0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284866; c=relaxed/simple;
	bh=WXKHRU/uEj6cYAvi50bYRlcQ0ruywm7WIxvBv/gN2jw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZeWhJw8XReDTeEbaP8+N2HpvbCXoO3wGD6XVtUQW5kbw2lWdntRZiDcgzRinMUFk+d3DaFOgT1O0uXmvi6u6tAT49elpmHzYCEyQIFM3P+7s7gSTqP/owxAqOx1nsYvkCABI8NFCo77h5mwbJTRnzj0DHgczjKeXjYeSan6tvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAVrWgRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707284864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dx4vuXIklQBxh8l06pvXMAeW4Cc8GkKcbpmXFc8So2o=;
	b=KAVrWgRyXEykUOLAu0jhOuMlhtYEoyN72bjR+qtPzV78S/o5F2ME3nlQLsELdK1X3hGnh1
	0CARfeXjyCNflfs7JIwSDSFZtCgG6YKCa98T+LBZrb71UD6CNTAaO4qTsrcuy7xxL6sTde
	SIAKAZzXp2reaydwshFQ7GWtGfZNySQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-5UgG03rVNwC6AlVylbb-5A-1; Wed,
 07 Feb 2024 00:47:42 -0500
X-MC-Unique: 5UgG03rVNwC6AlVylbb-5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 586DA3C0F247;
	Wed,  7 Feb 2024 05:47:42 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBF64492BC6;
	Wed,  7 Feb 2024 05:47:39 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	xieyongji@bytedance.com,
	linux-kernel@vger.kernel.org,
	maxime.coquelin@redhat.com
Subject: [PATCH v4 4/5] vduse: Add file operation for mmap
Date: Wed,  7 Feb 2024 13:43:31 +0800
Message-ID: <20240207054701.616094-5-lulu@redhat.com>
In-Reply-To: <20240207054701.616094-1-lulu@redhat.com>
References: <20240207054701.616094-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Add the operation for mmap, This function  will be used by the user space
application to map the pages to the user space.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2da659d5f4a8..083fe0047677 100644
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
+	/* index 1+vq_number page reserved for virtqueue state*/
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
+
+	if (index > dev->vq_num)
+		return -EINVAL;
+
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


