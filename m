Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65B7F2659
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjKUHbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjKUHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A4F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700551865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVxsZpHEP/sfaMQQhdclVFIY4BoolokQBaiLl5ZMHTY=;
        b=J0JNd9s3dkuzwcsgucZm3mF+bmX+1nvXczrA8yREFZdnUqlZmZSHNm51yGn4A2V9+9lShL
        WRuy7/fKngCi4+kk4mKi05+FVJTd5DLxZHO+sHaUTzB4Gv4fejyWSONa2x1Ssofhi+Jk6R
        1WqepIeeGuCJ1lWZTvYa1BocMEQHKfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-6p5Rl5WSMAOaFohM4XU9kQ-1; Tue, 21 Nov 2023 02:31:03 -0500
X-MC-Unique: 6p5Rl5WSMAOaFohM4XU9kQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AC788007B3;
        Tue, 21 Nov 2023 07:31:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6AA20268CF;
        Tue, 21 Nov 2023 07:31:00 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v2 2/5] vduse: Add file operation for mmap
Date:   Tue, 21 Nov 2023 15:30:47 +0800
Message-Id: <20231121073050.287080-3-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-1-lulu@redhat.com>
References: <20231121073050.287080-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the operation for mmap, The user space APP will
use this function to map the pages to userspace

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6209e2f00278..ccb30e98bab5 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1376,6 +1376,83 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
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
+		info = &dev->reconnect_info;
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
+	/*check if Userspace App map the page number larger than kernel allocated*/
+	if (index > dev->vq_num + 1)
+		return -EINVAL;
+
+	/* index 0  page reserved for vduse status*/
+	if (index == 0) {
+		info = &dev->reconnect_info;
+	} else {
+		/* index 1+vq_number page reserved for vduse vqs*/
+		vq = &dev->vqs[index - 1];
+		info = &vq->reconnect_info;
+	}
+	/*check if map pages was allocated and inited by kernel */
+	if (info->vaddr == 0)
+		return -EOPNOTSUPP;
+
+	/* check if the address is page aligned, if not,
+	 * this address maybe damaged
+	 */
+	if (virt_to_phys((void *)info->vaddr) & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	/* check if Userspace App mapped the correct size
+	 * the userspace App should map one page each time
+	 */
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EOPNOTSUPP;
+	/* VM_IO: set as a memory-mapped I/O region,This will for vq information
+	 * VM_PFNMAP: only need  the pure PFN
+	 * VM_DONTEXPAND: do not need to use mremap() in this function
+	 * VM_DONTDUMP:Do not include in the core dump
+	 */
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_ops = &vduse_vm_ops;
+
+	return 0;
+}
+
 static int vduse_dev_open(struct inode *inode, struct file *file)
 {
 	int ret;
@@ -1408,6 +1485,8 @@ static const struct file_operations vduse_dev_fops = {
 	.unlocked_ioctl	= vduse_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
+	.mmap		= vduse_dev_mmap,
+
 };
 
 static struct vduse_dev *vduse_dev_create(void)
-- 
2.34.3

