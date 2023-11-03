Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350BE7E074A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376508AbjKCRSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjKCRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC29D4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuqvr5RWRiWU1vecaSpLFCcLTpJ+4Yg7zkI2ypzhUqw=;
        b=LgDInuxjPlVIe8Dcj2bevueBD8tDWgdcM04qFir7d3zsXAl8Bow+IafEqWOLNLtw+NdjQI
        ODFXOKYsk78viujuiKOTX0UQqr+/ersBDtLpSpOmYvPyvKvLdygrY6cHZRE/FTy9Z/JLHN
        ZpgtsrDSqwKjVPrMlpwlJ62sYIYtVn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-9U5j9LuUPY-QMBSo0Y4PAQ-1; Fri, 03 Nov 2023 13:17:25 -0400
X-MC-Unique: 9U5j9LuUPY-QMBSo0Y4PAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7CE285D536;
        Fri,  3 Nov 2023 17:17:24 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C264EC1290F;
        Fri,  3 Nov 2023 17:17:21 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 4/8] vdpa: Add new vdpa_config_ops to support iommufd
Date:   Sat,  4 Nov 2023 01:16:37 +0800
Message-Id: <20231103171641.1703146-5-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 4 new vdpa_config_ops function to support iommufd

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/linux/vdpa.h | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0e652026b776..233d80f9d910 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/iommufd.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/virtio_net.h>
 #include <linux/if_ether.h>
@@ -97,6 +98,12 @@ struct vdpa_device {
 	struct vdpa_mgmt_dev *mdev;
 	unsigned int ngroups;
 	unsigned int nas;
+	struct iommufd_access *iommufd_access;
+	struct iommufd_device *iommufd_device;
+	struct iommufd_ctx *iommufd_ictx;
+	unsigned long *vq_bitmap;
+	atomic_t iommufd_users;
+	bool iommufd_attached;
 };
 
 /**
@@ -332,6 +339,17 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
+ * @bind_iommufd:              use vdpa_iommufd_physical_bind for an IOMMU
+ *                             backed device.
+ *                             otherwise use vdpa_iommufd_emulated_bind
+ * @unbind_iommufd:            use vdpa_iommufd_physical_unbind for an IOMMU
+ *                             backed device.
+ *                             otherwise, use vdpa_iommufd_emulated_unbind
+ * @attach_ioas:               use vdpa_iommufd_physical_attach_ioas for an
+ *                             IOMMU backed device.
+ * @detach_ioas:               Opposite of attach_ioas
+ * @free:			Free resources that belongs to vDPA (optional)
+ *				@vdev: vdpa device
  */
 struct vdpa_config_ops {
 	/* Virtqueue ops */
@@ -402,6 +420,13 @@ struct vdpa_config_ops {
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
+	/* IOMMUFD ops */
+	int (*bind_iommufd)(struct vdpa_device *vdev, struct iommufd_ctx *ictx,
+			    u32 *out_device_id);
+	void (*unbind_iommufd)(struct vdpa_device *vdev);
+	int (*attach_ioas)(struct vdpa_device *vdev, u32 *pt_id);
+	int (*detach_ioas)(struct vdpa_device *vdev);
+
 };
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
@@ -570,4 +595,15 @@ struct vdpa_mgmt_dev {
 int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
 void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
 
-#endif /* _LINUX_VDPA_H */
+int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id);
+void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa);
+int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
+int vdpa_iommufd_physical_detach_ioas(struct vdpa_device *vdpa);
+int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id);
+void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa);
+int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
+int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa);
+
+#endif
-- 
2.34.3

