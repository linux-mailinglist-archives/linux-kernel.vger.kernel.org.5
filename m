Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50C7C4ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbjJKGnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjJKGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E998
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29YtgXv8n6Z+jTzRGYkc/Q2mHLXGKB5JoSFvVPqVJn0=;
        b=U54Za9U1wzF4vjM+nEsCKN5vMuAeDYCPrFB3nQ0XetQvix9KmC9S7eZPspABzRd/ZYVBK6
        rYl5W6uwm4GFBVtC4EqaEe7svz4uTQug+eJ5qAeEtOpjO0yVV8HDbJkPkick1ikLXI1/dX
        ODWLoS7xh+diKkU4ZgSV7lJiUhXIaZg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-gybUZXM6MsiCPClNZE-oFA-1; Wed, 11 Oct 2023 02:42:28 -0400
X-MC-Unique: gybUZXM6MsiCPClNZE-oFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9DFE382134A;
        Wed, 11 Oct 2023 06:42:27 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 226CC51E3;
        Wed, 11 Oct 2023 06:42:24 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v1 2/4] vduse: Add file operation for mmap
Date:   Wed, 11 Oct 2023 14:42:06 +0800
Message-Id: <20231011064208.2143245-3-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-1-lulu@redhat.com>
References: <20231011064208.2143245-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the operation for mmap, The user space APP will
use this function to map the pages to userspace

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 66 ++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 565126a9ab01..05e72d752fb6 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1380,6 +1380,70 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
 	return dev;
 }
 
+static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
+{
+	struct vduse_dev *dev = vmf->vma->vm_file->private_data;
+	struct vm_area_struct *vma = vmf->vma;
+	u16 index = vma->vm_pgoff;
+	struct vduse_virtqueue *vq;
+	struct vdpa_reconnect_info *info;
+
+	/* index 0  page reserved for vduse status*/
+	if (index == 0) {
+		info = &dev->reconnect_status;
+	} else {
+		/* index 1+vq_number page reserved for vduse vqs*/
+		vq = &dev->vqs[index - 1];
+		info = &vq->reconnect_info;
+	}
+	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
+			    PFN_DOWN(virt_to_phys((void *)info->vaddr)),
+			    PAGE_SIZE, vma->vm_page_prot))
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
+	struct vdpa_reconnect_info *info;
+	unsigned long index = vma->vm_pgoff;
+	struct vduse_virtqueue *vq;
+
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+
+	if (index > dev->vq_num + 1)
+		return -EINVAL;
+
+	/* index 0  page reserved for vduse status*/
+	if (index == 0) {
+		info = &dev->reconnect_status;
+	} else {
+		/* index 1+vq_number page reserved for vduse vqs*/
+		vq = &dev->vqs[index - 1];
+		info = &vq->reconnect_info;
+	}
+	if (info->vaddr == 0)
+		return -ENOTSUPP;
+
+	if (virt_to_phys((void *)info->vaddr) & (PAGE_SIZE - 1))
+		return -EINVAL;
+	if (vma->vm_end - vma->vm_start != info->size)
+		return -EOPNOTSUPP;
+
+	vm_flags_set(vma, VM_IO | VM_DONTDUMP);
+	vma->vm_ops = &vduse_vm_ops;
+
+	return 0;
+}
+
 static int vduse_dev_open(struct inode *inode, struct file *file)
 {
 	int ret;
@@ -1412,6 +1476,8 @@ static const struct file_operations vduse_dev_fops = {
 	.unlocked_ioctl	= vduse_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
+	.mmap		= vduse_dev_mmap,
+
 };
 
 static struct vduse_dev *vduse_dev_create(void)
-- 
2.34.3

