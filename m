Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75BB7C4ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjJKGnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbjJKGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BDF90
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vn5HgvZLw9PSHjZMkQbhZJX5Gv2GT+cE9/aT+ZvVDqM=;
        b=hbCFNvVjzuVH9Kdf0UI6wqBQM2xr3U7xY2ymBeAW+UgrmGvwefc3pfm162iHVtNGwyE/TZ
        FzYSVRVlxAH4YH4itKRxNZtPQEEvqyw/f3C/A9gFP5YZ6zIWpI3Q7yDylkjSlAVEgD+1YP
        XW1Al6BgIH7hzOHl8JuYb2Aowjc2cVM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-8nlMUVOiOHqTiyPZ8B1Ueg-1; Wed, 11 Oct 2023 02:42:24 -0400
X-MC-Unique: 8nlMUVOiOHqTiyPZ8B1Ueg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8075B1C2B66B;
        Wed, 11 Oct 2023 06:42:24 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECE3863F55;
        Wed, 11 Oct 2023 06:42:21 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v1 1/4] vduse: Add function to get/free the pages for reconnection
Date:   Wed, 11 Oct 2023 14:42:05 +0800
Message-Id: <20231011064208.2143245-2-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-1-lulu@redhat.com>
References: <20231011064208.2143245-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the function vduse_alloc_reconnnect_info_mem
and vduse_alloc_reconnnect_info_mem
In this 2 function, vduse will get/free (vq_num + 1)*page  
Page 0 will be used to save the reconnection information, The
Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
the reconnection information for vqs.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 78 ++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 26b7e29cb900..565126a9ab01 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -30,6 +30,10 @@
 #include <uapi/linux/virtio_blk.h>
 #include <linux/mod_devicetable.h>
 
+#ifdef CONFIG_X86
+#include <asm/set_memory.h>
+#endif
+
 #include "iova_domain.h"
 
 #define DRV_AUTHOR   "Yongji Xie <xieyongji@bytedance.com>"
@@ -41,6 +45,19 @@
 #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+/* struct vdpa_reconnect_info saved the alloc pages info
+ * these pages will mmaped to userspace for reconnection
+ */
+struct vdpa_reconnect_info {
+	/* Offset (within vm_file) in PAGE_SIZE
+	 */
+	u32 index;
+	/* virtual address for this page*/
+	unsigned long vaddr;
+	/* allocated memory size, */
+	phys_addr_t size;
+};
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -57,6 +74,7 @@ struct vduse_virtqueue {
 	struct vdpa_callback cb;
 	struct work_struct inject;
 	struct work_struct kick;
+	struct vdpa_reconnect_info reconnect_info;
 };
 
 struct vduse_dev;
@@ -106,6 +124,7 @@ struct vduse_dev {
 	u32 vq_align;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
+	struct vdpa_reconnect_info reconnect_status;
 };
 
 struct vduse_dev_msg {
@@ -1030,6 +1049,61 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	return ret;
 }
 
+static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	struct vdpa_reconnect_info *info;
+	struct vduse_virtqueue *vq;
+	void *addr;
+
+	/*page 0 is use to save status,dpdk will use this to save the information
+	 *needed in reconnection,kernel don't need to maintain this
+	 */
+	info = &dev->reconnect_status;
+	addr = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!addr)
+		return -1;
+
+	info->vaddr = (unsigned long)(addr);
+	info->size = PAGE_SIZE;
+	/* index is vm Offset in PAGE_SIZE */
+	info->index = 0;
+
+	/*page 1~ vq_num + 1 save the reconnect info for vqs*/
+	for (int i = 0; i < dev->vq_num + 1; i++) {
+		vq = &dev->vqs[i];
+		info = &vq->reconnect_info;
+		addr = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!addr)
+			return -1;
+
+		info->vaddr = (unsigned long)(addr);
+		info->size = PAGE_SIZE;
+		info->index = i + 1;
+	}
+
+	return 0;
+}
+
+static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	struct vdpa_reconnect_info *info;
+	struct vduse_virtqueue *vq;
+
+	info = &dev->reconnect_status;
+	free_page(info->vaddr);
+	info->size = 0;
+	info->vaddr = 0;
+	for (int i = 0; i < dev->vq_num + 1; i++) {
+		vq = &dev->vqs[i];
+		info = &vq->reconnect_info;
+		free_page(info->vaddr);
+		info->size = 0;
+		info->vaddr = 0;
+	}
+
+	return 0;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1390,6 +1464,8 @@ static int vduse_destroy_dev(char *name)
 		mutex_unlock(&dev->lock);
 		return -EBUSY;
 	}
+	vduse_free_reconnnect_info_mem(dev);
+
 	dev->connected = true;
 	mutex_unlock(&dev->lock);
 
@@ -1542,6 +1618,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 		ret = PTR_ERR(dev->dev);
 		goto err_dev;
 	}
+
+	vduse_alloc_reconnnect_info_mem(dev);
 	__module_get(THIS_MODULE);
 
 	return 0;
-- 
2.34.3

