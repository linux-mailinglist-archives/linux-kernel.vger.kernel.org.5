Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486F47AC3D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjIWRGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjIWRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774EC100
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695488752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZXSGgSLa3AyMB+//ooPSLru9tn8EO08jVq0CDYH8UM=;
        b=CCgtTiKsbOHUy5U5h3h+KRCUB1LtA91Eh7j6CjOMRDfZHGdKRoWjymPMYNCHO+hd6zQ7Gp
        F8IUaOZ5pbB1XdAs6AkOc4PMdjPNqbA49PA4DEShkXsNzv43O0UCFVzzeqE/K9xH1PBWLr
        aCpMjCONFGdHpHnAFIxd2WHBoOU+S4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-K5M1yv96PjmVB0IHcgvaqA-1; Sat, 23 Sep 2023 13:05:51 -0400
X-MC-Unique: K5M1yv96PjmVB0IHcgvaqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BBCF800045;
        Sat, 23 Sep 2023 17:05:50 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 754B32026D4B;
        Sat, 23 Sep 2023 17:05:47 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 1/7] vhost/iommufd: Add the functions support iommufd
Date:   Sun, 24 Sep 2023 01:05:34 +0800
Message-Id: <20230923170540.1447301-2-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new file vhost/iommufd.c to support the function of
iommufd, This file contains iommufd function of emulated device and
the physical device. 

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/iommufd.c | 151 ++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h   |  21 ++++++
 2 files changed, 172 insertions(+)
 create mode 100644 drivers/vhost/iommufd.c

diff --git a/drivers/vhost/iommufd.c b/drivers/vhost/iommufd.c
new file mode 100644
index 000000000000..080858f76fd5
--- /dev/null
+++ b/drivers/vhost/iommufd.c
@@ -0,0 +1,151 @@
+#include <linux/vdpa.h>
+#include <linux/iommufd.h>
+
+#include "vhost.h"
+
+MODULE_IMPORT_NS(IOMMUFD);
+
+int vdpa_iommufd_bind(struct vdpa_device *vdpa, struct iommufd_ctx *ictx,
+		      u32 *ioas_id, u32 *device_id)
+{
+	int ret;
+
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	/*
+        * If the driver doesn't provide this op then it means the device does
+        * not do DMA at all. So nothing to do.
+        */
+	if (!vdpa->config->bind_iommufd)
+		return 0;
+
+	ret = vdpa->config->bind_iommufd(vdpa, ictx, device_id);
+	if (ret)
+		return ret;
+
+	ret = vdpa->config->attach_ioas(vdpa, ioas_id);
+	if (ret)
+		goto err_unbind;
+	vdpa->iommufd_attached = true;
+
+	return 0;
+
+err_unbind:
+	if (vdpa->config->unbind_iommufd)
+		vdpa->config->unbind_iommufd(vdpa);
+	return ret;
+}
+
+void vdpa_iommufd_unbind(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->config->unbind_iommufd)
+		vdpa->config->unbind_iommufd(vdpa);
+}
+
+int vdpa_iommufd_physical_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id)
+{
+	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
+	struct iommufd_device *idev;
+
+	idev = iommufd_device_bind(ictx, dma_dev, out_device_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	vdpa->iommufd_device = idev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_bind);
+
+void vdpa_iommufd_physical_unbind(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->iommufd_attached) {
+		iommufd_device_detach(vdpa->iommufd_device);
+		vdpa->iommufd_attached = false;
+	}
+	iommufd_device_unbind(vdpa->iommufd_device);
+	vdpa->iommufd_device = NULL;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_unbind);
+
+int vdpa_iommufd_physical_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id)
+{
+	unsigned int flags = 0;
+
+	return iommufd_device_attach(vdpa->iommufd_device, pt_id);
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_physical_attach_ioas);
+
+static void vdpa_emulated_unmap(void *data, unsigned long iova,
+				unsigned long length)
+{
+	struct vdpa_device *vdpa = data;
+
+	vdpa->config->dma_unmap(vdpa, 0, iova, length);
+}
+
+static const struct iommufd_access_ops vdpa_user_ops = {
+	.needs_pin_pages = 1,
+	.unmap = vdpa_emulated_unmap,
+};
+
+int vdpa_iommufd_emulated_bind(struct vdpa_device *vdpa,
+			       struct iommufd_ctx *ictx, u32 *out_device_id)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	vdpa->iommufd_ictx = ictx;
+	iommufd_ctx_get(ictx);
+	struct iommufd_device *idev;
+
+	idev = iommufd_device_bind(ictx, vdpa->dma_dev, out_device_id);
+
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	vdpa->iommufd_device = idev;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_bind);
+
+void vdpa_iommufd_emulated_unbind(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (vdpa->iommufd_access) {
+		iommufd_access_destroy(vdpa->iommufd_access);
+		vdpa->iommufd_access = NULL;
+	}
+	iommufd_ctx_put(vdpa->iommufd_ictx);
+	vdpa->iommufd_ictx = NULL;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_unbind);
+
+int vdpa_iommufd_emulated_attach_ioas(struct vdpa_device *vdpa, u32 *pt_id)
+{
+	struct iommufd_access *user;
+
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	user = iommufd_access_create(vdpa->iommufd_ictx, *pt_id, &vdpa_user_ops,
+				     vdpa);
+	if (IS_ERR(user))
+		return PTR_ERR(user);
+	vdpa->iommufd_access = user;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_attach_ioas);
+int vdpa_iommufd_emulated_detach_ioas(struct vdpa_device *vdpa)
+{
+	vhost_vdpa_lockdep_assert_held(vdpa);
+
+	if (!vdpa->iommufd_ictx || !vdpa->iommufd_access)
+		return -1;
+
+	iommufd_access_destroy(vdpa->iommufd_access);
+	vdpa->iommufd_access = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vdpa_iommufd_emulated_detach_ioas);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 790b296271f1..c470a5596d9c 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -291,6 +291,27 @@ static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
 }
 #endif
 
+struct iommufd_ctx;
+struct vdpa_device;
+void vhost_vdpa_lockdep_assert_held(struct vdpa_device *vdpa);
+
+#if IS_ENABLED(CONFIG_IOMMUFD)
+int vdpa_iommufd_bind(struct vdpa_device *vdpa, struct iommufd_ctx *ictx,
+		      u32 *ioas_id, u32 *device_id);
+void vdpa_iommufd_unbind(struct vdpa_device *vdpa);
+#else
+static inline int vdpa_iommufd_bind(struct vdpa_device *vdpa,
+				    struct iommufd_ctx *ictx, u32 *ioas_id,
+				    u32 *device_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void vdpa_iommufd_unbind(struct vdpa_device *vdpa)
+{
+}
+#endif
+
 /* Memory accessors */
 static inline u16 vhost16_to_cpu(struct vhost_virtqueue *vq, __virtio16 val)
 {
-- 
2.34.3

