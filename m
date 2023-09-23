Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA47AC3D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIWRHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjIWRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4CE193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695488791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=il3w5haBSfScQXt3dDLf9SU0J5h0ZGGXQF2FXm4L+Ew=;
        b=UWATkHGNEfaSVWuqcO0HwW54Eld9Fk+mtFvSK5wPKycpTXb8FFa/USZEsvysYgyMDT+b5d
        bzrPgdIE76k8nLDs7Wf1aX0THm0hV68eECVFUEWHolq2Z6/BupM5OHiIh43ZaWnm48CAAu
        BJCWfhUJukP51SH5tWTT8tioceYNiho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-QsE5kBCmMOiSPEgvLSFUMA-1; Sat, 23 Sep 2023 13:06:27 -0400
X-MC-Unique: QsE5kBCmMOiSPEgvLSFUMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47D56811E7B;
        Sat, 23 Sep 2023 17:06:27 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 222252156701;
        Sat, 23 Sep 2023 17:06:23 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 5/7] vdpa: Add new vdpa_config_ops
Date:   Sun, 24 Sep 2023 01:05:38 +0800
Message-Id: <20230923170540.1447301-6-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new vdpa_config_ops to support iommufd

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/linux/vdpa.h | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..4ada5bd6f90e 100644
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
@@ -91,6 +92,12 @@ struct vdpa_device {
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
@@ -282,6 +289,15 @@ struct vdpa_map_file {
  *				@iova: iova to be unmapped
  *				@size: size of the area
  *				Returns integer: success (0) or error (< 0)
+ * @bind_iommufd:              use vdpa_iommufd_physical_bind for an IOMMU
+ *                             backed device.
+ *                             otherwise use vdpa_iommufd_emulated_bind
+ * @unbind_iommufd:            use vdpa_iommufd_physical_unbind for an IOMMU
+ *                             backed device.
+ *                             otherwise, use vdpa_iommufd_emulated_unbind
+ * @attach_ioas:               use vdpa_iommufd_physical_attach_ioas for an
+ *                             IOMMU backed device.
+ * @detach_ioas:               Opposite of attach_ioas
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -341,6 +357,12 @@ struct vdpa_config_ops {
 			 u64 iova, u64 size);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
+	/* IOMMUFD ops */
+	int (*bind_iommufd)(struct vdpa_device *vdev, struct iommufd_ctx *ictx,
+			    u32 *out_device_id);
+	void (*unbind_iommufd)(struct vdpa_device *vdev);
+	int (*attach_ioas)(struct vdpa_device *vdev, u32 *pt_id);
+	int (*detach_ioas)(struct vdpa_device *vdev);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
@@ -510,4 +532,14 @@ struct vdpa_mgmt_dev {
 int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
 void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
 
-#endif /* _LINUX_VDPA_H */
+int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id);
+void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa);
+int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
+int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id);
+void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa);
+int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id);
+int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa);
+
+#endif
-- 
2.34.3

