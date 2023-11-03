Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761127E0747
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjKCRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjKCRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163CD47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699031823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjCcpTQrJmsF+m1LiuhY/lfZrSnOFnb7RQ3HwNEy8v8=;
        b=ENK+mJ1ndLrunPqVcDm5SAIrDtynqIliDPt/gFL8pYltHCnMvtXi06MJMnLa97lWXS+JZo
        8hllChZtpqayo3Fjy1FIEWXbaIjaasYohWC9fb19mG3CUEwcNTFmzWi0b1CzHPysqjfATe
        B0m4zOWOMDDG4hEJptS0NAEuBK18s+U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-Lrm-ZPJtNbC55VC5JqJ0OA-1; Fri,
 03 Nov 2023 13:17:00 -0400
X-MC-Unique: Lrm-ZPJtNbC55VC5JqJ0OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99F131C29AE0;
        Fri,  3 Nov 2023 17:16:59 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7919440C6EBF;
        Fri,  3 Nov 2023 17:16:56 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
Date:   Sat,  4 Nov 2023 01:16:36 +0800
Message-Id: <20231103171641.1703146-4-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device

VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
address space specified by IOAS id.

VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
from the iommufd address space

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c       | 171 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h |  66 ++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 78379ffd2336..dfaddd833364 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/uuid.h>
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
@@ -25,6 +26,8 @@
 
 #include "vhost.h"
 
+MODULE_IMPORT_NS(IOMMUFD);
+
 enum {
 	VHOST_VDPA_BACKEND_FEATURES =
 	(1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
@@ -69,6 +72,15 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
 				   struct vhost_iotlb *iotlb, u64 start,
 				   u64 last, u32 asid);
 
+void vhost_vdpa_lockdep_assert_held(struct vdpa_device *vdpa)
+{
+	struct vhost_vdpa *v = vdpa_get_drvdata(vdpa);
+
+	if (WARN_ON(!v))
+		return;
+	lockdep_assert_held(&v->vdev.mutex);
+}
+
 static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
 {
 	struct vhost_vdpa_as *as = container_of(iotlb, struct
@@ -551,6 +563,149 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 
 	return ops->suspend(vdpa);
 }
+static long vhost_vdpa_iommufd_set_device(struct vhost_vdpa *v,
+					  void __user *argp)
+{
+	struct device *dma_dev = vdpa_get_dma_dev(v->vdpa);
+	struct vhost_vdpa_set_iommufd set_iommufd;
+	struct vdpa_device *vdpa = v->vdpa;
+	struct iommufd_ctx *ictx;
+	unsigned long minsz;
+	u32 ioas_id, dev_id;
+	struct fd f;
+	long r = 0;
+
+	minsz = offsetofend(struct vhost_vdpa_set_iommufd, iommufd_ioasid);
+	if (copy_from_user(&set_iommufd, argp, minsz))
+		return -EFAULT;
+
+	/* Unset IOMMUFD */
+	if (set_iommufd.iommufd < 0) {
+		if (!vdpa->iommufd_ictx || !vdpa->iommufd_device)
+			return -EINVAL;
+		if (atomic_read(&vdpa->iommufd_users)) {
+			atomic_dec(&vdpa->iommufd_users);
+			return 0;
+		}
+		vdpa_iommufd_unbind(v->vdpa);
+		vdpa->iommufd_device = NULL;
+		vdpa->iommufd_ictx = NULL;
+		return iommu_attach_device(v->domain, dma_dev);
+	}
+
+	/* For same device but different groups, ++refcount only */
+	if (vdpa->iommufd_device)
+		goto out_inc;
+
+	r = -EBADF;
+	f = fdget(set_iommufd.iommufd);
+	if (!f.file)
+		goto out;
+
+	r = -EINVAL;
+	ictx = iommufd_ctx_from_file(f.file);
+	if (IS_ERR(ictx))
+		goto out_fdput;
+
+	if (v->domain) {
+		iommu_device_unuse_default_domain(dma_dev);
+		iommu_detach_device(v->domain, dma_dev);
+	}
+
+	ioas_id = set_iommufd.iommufd_ioasid;
+	r = vdpa_iommufd_bind(vdpa, ictx, &ioas_id, &dev_id);
+	if (r)
+		goto out_reattach;
+
+	set_iommufd.out_dev_id = dev_id;
+	r = copy_to_user(argp + minsz, &set_iommufd.out_dev_id,
+			 sizeof(set_iommufd.out_dev_id)) ?
+		    -EFAULT :
+		    0;
+	if (r)
+		goto out_device_unbind;
+
+	vdpa->iommufd_ictx = ictx;
+
+out_inc:
+	atomic_inc(&vdpa->iommufd_users);
+
+	goto out_fdput;
+
+out_device_unbind:
+
+	vdpa_iommufd_unbind(vdpa);
+out_reattach:
+	iommu_device_use_default_domain(dma_dev);
+	iommu_attach_device(v->domain, dma_dev);
+	iommufd_ctx_put(ictx);
+out_fdput:
+	fdput(f);
+out:
+	return r;
+}
+int vhost_vdpa_iommufd_ioas_attach(struct vhost_vdpa *v, void __user *arg)
+{
+	struct vdpa_device_attach_iommufd_as attach;
+	unsigned long minsz;
+	int ret;
+
+	minsz = offsetofend(struct vdpa_device_attach_iommufd_as, ioas_id);
+
+	if (copy_from_user(&attach, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (attach.argsz < minsz || attach.flags)
+		return -EINVAL;
+
+	if (!v->vdpa->config->bind_iommufd)
+		return -ENODEV;
+
+	if (!v->vdpa->iommufd_ictx) {
+		ret = -EINVAL;
+		return ret;
+	}
+
+	ret = v->vdpa->config->attach_ioas(v->vdpa, &attach.ioas_id);
+
+	if (ret)
+		return ret;
+
+	ret = copy_to_user(
+		      (void __user *)arg +
+			      offsetofend(struct vdpa_device_attach_iommufd_as,
+					  flags),
+		      &attach.ioas_id, sizeof(attach.ioas_id)) ?
+		      -EFAULT :
+		      0;
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int vhost_vdpa_iommufd_ioas_detach(struct vhost_vdpa *v, void __user *arg)
+{
+	struct vdpa_device_detach_iommufd_as detach;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct vdpa_device_detach_iommufd_as, flags);
+
+	if (copy_from_user(&detach, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (detach.argsz < minsz || detach.flags)
+		return -EINVAL;
+
+	if (!v->vdpa->config->bind_iommufd)
+		return -ENODEV;
+
+	if (v->vdpa->iommufd_ictx) {
+		return -EINVAL;
+	}
+	return v->vdpa->config->detach_ioas(v->vdpa);
+}
 
 /* After a successful return of this ioctl the device resumes processing
  * virtqueue descriptors. The device becomes fully operational the same way it
@@ -744,6 +899,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_SET_LOG_FD:
 		r = -ENOIOCTLCMD;
 		break;
+	case VHOST_VDPA_SET_IOMMU_FD:
+
+		r = vhost_vdpa_iommufd_set_device(v, argp);
+		break;
+	case VDPA_DEVICE_ATTACH_IOMMUFD_AS:
+		r = vhost_vdpa_iommufd_ioas_attach(v, (void __user *)arg);
+		break;
+
+	case VDPA_DEVICE_DETACH_IOMMUFD_AS:
+		r = vhost_vdpa_iommufd_ioas_detach(v, (void __user *)arg);
+		break;
+
 	case VHOST_VDPA_SET_CONFIG_CALL:
 		r = vhost_vdpa_set_config_call(v, argp);
 		break;
@@ -896,6 +1063,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, asid, iotlb);
+	} else if (!vdpa->iommufd_ictx) {
+		/* Legacy iommu domain pathway without IOMMUFD */
+		r = iommu_map(v->domain, iova, pa, size,
+			      perm_to_iommu_flags(perm), GFP_KERNEL);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm), GFP_KERNEL);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index f5c48b61ab62..07e1b2c443ca 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -219,4 +219,70 @@
  */
 #define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
 
+/* vhost_vdpa_set_iommufd
+ * Input parameters:
+ * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
+ * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_ALLOC)
+ * Output parameters:
+ * @out_dev_id: device identifier
+ */
+struct vhost_vdpa_set_iommufd {
+	__s32 iommufd;
+	__u32 iommufd_ioasid;
+	__u32 out_dev_id;
+};
+
+#define VHOST_VDPA_SET_IOMMU_FD \
+	_IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
+
+/*
+ * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
+ * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
+ *
+ * Attach a vdpa device to an iommufd address space specified by IOAS
+ * id.
+ *
+ * Available only after a device has been bound to iommufd via
+ * VHOST_VDPA_SET_IOMMU_FD
+ *
+ * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
+ *
+ * @argsz:	user filled size of this data.
+ * @flags:	must be 0.
+ * @ioas_id:	Input the target id which can represent an ioas
+ *		allocated via iommufd subsystem.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vdpa_device_attach_iommufd_as {
+	__u32 argsz;
+	__u32 flags;
+	__u32 ioas_id;
+};
+
+#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
+	_IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as)
+
+/*
+ * VDPA_DEVICE_DETACH_IOMMUFD_AS
+ *
+ * Detach a vdpa device from the iommufd address space it has been
+ * attached to. After it, device should be in a blocking DMA state.
+ *
+ * Available only after a device has been bound to iommufd via
+ * VHOST_VDPA_SET_IOMMU_FD
+ *
+ * @argsz:	user filled size of this data.
+ * @flags:	must be 0.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vdpa_device_detach_iommufd_as {
+	__u32 argsz;
+	__u32 flags;
+};
+
+#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
+	_IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as)
+
 #endif
-- 
2.34.3

