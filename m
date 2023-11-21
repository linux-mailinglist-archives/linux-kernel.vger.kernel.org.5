Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC97F2658
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjKUHbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKUHbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798DF5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700551865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tApwkEnppPf1Qrj7Li8zNPuhfxV/BinwmEu4nnIOfk=;
        b=fMudZnVcy5CeCrEl5iInr12m0K9RP667vn0SZEdAvkbQD56XKwXDJuLs/QK/aubWR1K/g9
        VCF7DF/FlP9A3aUnpYH6E6dc7NEMNPW96R4IfC/BKGpJGHcomSkRTOvF8PRl7r0Uf3i9ku
        xLLnSNR34ikJ55opHGSY1qc5giqcejs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-feDxu8XYPN2sBP8rRuve5g-1; Tue, 21 Nov 2023 02:31:00 -0500
X-MC-Unique: feDxu8XYPN2sBP8rRuve5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1CA385AFC0;
        Tue, 21 Nov 2023 07:30:59 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3238920268CF;
        Tue, 21 Nov 2023 07:30:56 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v2 1/5] vduse: Add function to get/free the pages for reconnection
Date:   Tue, 21 Nov 2023 15:30:46 +0800
Message-Id: <20231121073050.287080-2-lulu@redhat.com>
In-Reply-To: <20231121073050.287080-1-lulu@redhat.com>
References: <20231121073050.287080-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the function vduse_alloc_reconnnect_info_mem
and vduse_alloc_reconnnect_info_mem
In this 2 function, vduse will get/free (vq_num + 1)*page  
Page 0 will be used to save the reconnection information, The
Userspace App will maintain this. Page 1 ~ vq_num + 1 will save
the reconnection information for vqs.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 80 ++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 26b7e29cb900..6209e2f00278 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -41,6 +41,16 @@
 #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
 #define VDUSE_MSG_DEFAULT_TIMEOUT 30
 
+/* struct vdpa_reconnect_info saved the alloc pages info
+ * these pages will mmaped to userspace for reconnection
+ */
+struct vdpa_reconnect_info {
+	/* Offset (within vm_file) in PAGE_SIZE */
+	u32 index;
+	/* virtual address for this page*/
+	unsigned long vaddr;
+};
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -57,6 +67,7 @@ struct vduse_virtqueue {
 	struct vdpa_callback cb;
 	struct work_struct inject;
 	struct work_struct kick;
+	struct vdpa_reconnect_info reconnect_info;
 };
 
 struct vduse_dev;
@@ -106,6 +117,7 @@ struct vduse_dev {
 	u32 vq_align;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
+	struct vdpa_reconnect_info reconnect_info;
 };
 
 struct vduse_dev_msg {
@@ -1030,6 +1042,64 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	return ret;
 }
 
+static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	struct vdpa_reconnect_info *info;
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num + 1; i++) {
+		if (i == 0) {
+			/*page 0 is use to save status,Userland APP will use this to
+			 *save the information needed in reconnection,
+			 *kernel don't need to maintain this
+			 */
+			info = &dev->reconnect_info;
+			info->vaddr = get_zeroed_page(GFP_KERNEL);
+			if (info->vaddr == 0)
+				return -ENOMEM;
+			/* index is vm Offset in PAGE_SIZE */
+			info->index = 0;
+		}
+
+		/*page 1~ vq_num + 1 save the reconnect info for vq*/
+		vq = &dev->vqs[i];
+		info = &vq->reconnect_info;
+		info->vaddr = get_zeroed_page(GFP_KERNEL);
+		if (info->vaddr == 0)
+			return -ENOMEM;
+
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
+	for (int i = 0; i < dev->vq_num + 1; i++) {
+		if (i == 0) {
+			info = &dev->reconnect_info;
+			if (info->vaddr)
+				free_page(info->vaddr);
+			info->index = 0;
+			info->vaddr = 0;
+		}
+
+		vq = &dev->vqs[i];
+		info = &vq->reconnect_info;
+
+		if (info->vaddr)
+			free_page(info->vaddr);
+		info->vaddr = 0;
+		info->index = 0;
+	}
+
+	return 0;
+}
+
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -1390,6 +1460,8 @@ static int vduse_destroy_dev(char *name)
 		mutex_unlock(&dev->lock);
 		return -EBUSY;
 	}
+	vduse_free_reconnnect_info_mem(dev);
+
 	dev->connected = true;
 	mutex_unlock(&dev->lock);
 
@@ -1542,9 +1614,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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

