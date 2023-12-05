Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE99804C90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbjLEIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjLEIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E3CD44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701765330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vm1nuGxCCo/CoP2TcwoqlCKrZ6P/0ERKcylQR/oOFpM=;
        b=KziZUvKaWrOmDUUEL8hqW382o++zX/KjKNN6pNDNXQwFSjSRrxZEuttkjgEt1YY8jW0Ikk
        d7RSc4yVtpkcfFXZS0Yu4EiGOuvp50ec/cQXfKJAhEqpNnaEBu6pKT232ggcQiDLusA7np
        gYMj8fGHg6fi7QeQGU1Id1pvTR4Kg5g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-vpdp_UpWMfi5ovLxqck8Uw-1; Tue, 05 Dec 2023 03:35:28 -0500
X-MC-Unique: vpdp_UpWMfi5ovLxqck8Uw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C5D1185A780;
        Tue,  5 Dec 2023 08:35:28 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 179543C25;
        Tue,  5 Dec 2023 08:35:25 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v3 4/7] vduse: Add function to get/free the pages for reconnection
Date:   Tue,  5 Dec 2023 16:34:41 +0800
Message-Id: <20231205083444.3029239-5-lulu@redhat.com>
In-Reply-To: <20231205083444.3029239-1-lulu@redhat.com>
References: <20231205083444.3029239-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the function vduse_alloc_reconnnect_info_mem
and vduse_alloc_reconnnect_info_mem
These functions allow vduse to allocate and free memory for reconnection
information. The amount of memory allocated is (vq_num + 1) pages.

Page 0 is reserved for saving the dev reconnection information, which
will be maintained by the Userspace App. Pages 1 to vq_num + 1 will be
used to save the reconnection information for vqs.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index dd074a7b4bc7..52ccde636406 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -41,6 +41,7 @@
 #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -57,6 +58,7 @@ struct vduse_virtqueue {
 	struct vdpa_callback cb;
 	struct work_struct inject;
 	struct work_struct kick;
+	unsigned long vdpa_reconnect_vaddr;
 };
 
 struct vduse_dev;
@@ -106,6 +108,7 @@ struct vduse_dev {
 	u32 vq_align;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
+	unsigned long vdpa_reconnect_vaddr;
 };
 
 struct vduse_dev_msg {
@@ -1030,6 +1033,57 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	return ret;
 }
 
+static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	unsigned long vaddr = 0;
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num + 1; i++) {
+		if (i == 0) {
+			vaddr = __get_free_pages(
+				GFP_KERNEL | __GFP_ZERO,
+				get_order(VDUSE_RECONNCT_MMAP_SIZE));
+			if (vaddr == 0)
+				return -ENOMEM;
+			dev->vdpa_reconnect_vaddr = vaddr;
+		}
+
+		/*page 1~ vq_num + 1 save the reconnect info for vq*/
+		vq = &dev->vqs[i];
+		vaddr = __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					 get_order(VDUSE_RECONNCT_MMAP_SIZE));
+		if (vaddr == 0)
+			return -ENOMEM;
+
+		vq->vdpa_reconnect_vaddr = vaddr;
+	}
+
+	return 0;
+}
+
+static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num + 1; i++) {
+		if (i == 0) {
+			if (dev->vdpa_reconnect_vaddr)
+				free_pages(dev->vdpa_reconnect_vaddr,
+					   get_order(VDUSE_RECONNCT_MMAP_SIZE));
+			dev->vdpa_reconnect_vaddr = 0;
+		}
+
+		vq = &dev->vqs[i];
+
+		if (vq->vdpa_reconnect_vaddr)
+			free_pages(vq->vdpa_reconnect_vaddr,
+				   get_order(VDUSE_RECONNCT_MMAP_SIZE));
+		vq->vdpa_reconnect_vaddr = 0;
+	}
+
+	return 0;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1411,6 +1465,8 @@ static int vduse_destroy_dev(char *name)
 		mutex_unlock(&dev->lock);
 		return -EBUSY;
 	}
+	vduse_free_reconnnect_info_mem(dev);
+
 	dev->connected = true;
 	mutex_unlock(&dev->lock);
 
@@ -1563,9 +1619,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 		ret = PTR_ERR(dev->dev);
 		goto err_dev;
 	}
+
+	ret = vduse_alloc_reconnnect_info_mem(dev);
+	if (ret < 0)
+		goto err_mem;
+
 	__module_get(THIS_MODULE);
 
 	return 0;
+
+err_mem:
+	vduse_free_reconnnect_info_mem(dev);
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-- 
2.34.3

