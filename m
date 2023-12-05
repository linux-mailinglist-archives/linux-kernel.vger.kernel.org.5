Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD4804C94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbjLEIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjLEIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1E2185
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1EF7vfXUKmZ7w1vqKhCPA032G3uF9wOvyUGxj1cxm00=;
        b=KVWExMcplhPWc61Dx92bdtpNXGgOQcTWjHCMZtpOHIwJ+0JC7ffV0AlU70WT0Mf7mGgEQo
        2lZD38dp6kdeDJHFNZhq9TR0ieg9bG8sbs0tdgUBGajtZLDSJPiuJMKghNoJN9yg8RD2S9
        GCuJEeDK7mNlQnxxfSSBG12fmVJ3ajI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-l76KXkNdNkaAjlgEfj5TDw-1; Tue, 05 Dec 2023 03:35:32 -0500
X-MC-Unique: l76KXkNdNkaAjlgEfj5TDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCDB0879843;
        Tue,  5 Dec 2023 08:35:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C87F3C25;
        Tue,  5 Dec 2023 08:35:28 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 5/7] vduse: Add file operation for mmap
Date:   Tue,  5 Dec 2023 16:34:42 +0800
Message-Id: <20231205083444.3029239-6-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-1-lulu@redhat.com>
References: <20231205083444.3029239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the operation for mmap, This function  will be used by the user space
application to map the pages to the user space.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 75 ++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 52ccde636406..f55f415629de 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1381,6 +1381,79 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
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
+	/* index 0  page reserved for vduse status*/
+	if (index == 0) {
+		vaddr = dev->vdpa_reconnect_vaddr;
+	} else {
+		/* index 1+vq_number page reserved for vduse vqs*/
+		vq = &dev->vqs[index - 1];
+		vaddr = vq->vdpa_reconnect_vaddr;
+	}
+	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
+			    PFN_DOWN(virt_to_phys((void *)vaddr)),
+			    VDUSE_RECONNCT_MMAP_SIZE, vma->vm_page_prot))
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
+	/*check if Userspace App map the page number larger than kernel allocated*/
+	if (index > dev->vq_num + 1)
+		return -EINVAL;
+
+	/* index 0  page reserved for vduse status*/
+	if (index == 0) {
+		vaddr = dev->vdpa_reconnect_vaddr;
+	} else {
+		/* index 1+vq_number page reserved for vduse vqs*/
+		vq = &dev->vqs[index - 1];
+		vaddr = vq->vdpa_reconnect_vaddr;
+	}
+	/* Check whether the memory for the mmap was allocated by the kernel.
+	 * If not, this device may not have been created/destroyed correctly.
+	 */
+	if (vaddr == 0)
+		return -EOPNOTSUPP;
+
+	/* check if the address is page aligned, if not,
+	 * this address maybe damaged
+	 */
+	if (virt_to_phys((void *)vaddr) & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	/* Check if the Userspace App has mapped the correct size */
+	if (vma->vm_end - vma->vm_start != VDUSE_RECONNCT_MMAP_SIZE)
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
@@ -1413,6 +1486,8 @@ static const struct file_operations vduse_dev_fops = {
 	.unlocked_ioctl	= vduse_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
+	.mmap		= vduse_dev_mmap,
+
 };
 
 static struct vduse_dev *vduse_dev_create(void)
-- 
2.34.3

