Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2217AC3D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjIWRG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjIWRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C2196
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695488763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hdq7599fHShALDoHh3mBOkTQ5ptt25at1kAS6tkS55Q=;
        b=JvbogTR4vOOEmsuv7ThHmhsRT3C0D7K4yUJ7AZZCvb4DA0uHCDer57qbnWbLkGjghxklzy
        JrMkaVAxS9dLsmIO0PFGQZV1zE/8sinVloey2iPgRO6ZQlyI+amULIO6SiIRKSVDfR7T5i
        4rNAaJI5exfbH/G/WX8qvhQuGCsgPEo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-vtlIZNBLPJ6ZbV8PT1oUxw-1; Sat, 23 Sep 2023 13:05:58 -0400
X-MC-Unique: vtlIZNBLPJ6ZbV8PT1oUxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AD1F1C05133;
        Sat, 23 Sep 2023 17:05:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 045652026D4B;
        Sat, 23 Sep 2023 17:05:54 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        yi.l.liu@intel.com, jgg@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [RFC 3/7] vhost: Add 3 new uapi to support iommufd
Date:   Sun, 24 Sep 2023 01:05:36 +0800
Message-Id: <20230923170540.1447301-4-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 drivers/vhost/vdpa.c       | 191 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h |  71 ++++++++++++++
 2 files changed, 262 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ec32f785dfde..91da012084e9 100644
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
@@ -497,6 +509,173 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
 
 	return ops->suspend(vdpa);
 }
+static long vhost_vdpa_tmp_set_iommufd(struct vhost_vdpa *v, void __user *argp)
+{
+	struct device *dma_dev = vdpa_get_dma_dev(v->vdpa);
+	struct vhost_vdpa_set_iommufd set_iommufd;
+	struct vdpa_device *vdpa = v->vdpa;
+	struct iommufd_ctx *ictx;
+	unsigned long minsz;
+	u32 pt_id, dev_id;
+	struct fd f;
+	long r = 0;
+	int idx;
+
+	minsz = offsetofend(struct vhost_vdpa_set_iommufd, ioas_id);
+	if (copy_from_user(&set_iommufd, argp, minsz))
+		return -EFAULT;
+
+	if (set_iommufd.group_id >= v->nvqs)
+		return -ENOBUFS;
+
+	idx = array_index_nospec(set_iommufd.group_id, v->nvqs);
+
+	/* Unset IOMMUFD */
+	if (set_iommufd.iommufd < 0) {
+		if (!test_bit(idx, vdpa->vq_bitmap))
+			return -EINVAL;
+
+		if (!vdpa->iommufd_ictx || !vdpa->iommufd_device)
+			return -EINVAL;
+		if (atomic_read(&vdpa->iommufd_users)) {
+			atomic_dec(&vdpa->iommufd_users);
+			return 0;
+		}
+		vdpa_iommufd_unbind(v->vdpa);
+		vdpa->iommufd_device = NULL;
+		vdpa->iommufd_ictx = NULL;
+		clear_bit(idx, vdpa->vq_bitmap);
+		return iommu_attach_device(v->domain, dma_dev);
+	}
+	/* First opened virtqueue of this vdpa device */
+
+	if (!vdpa->vq_bitmap) {
+		vdpa->vq_bitmap = bitmap_alloc(v->nvqs, GFP_KERNEL);
+	}
+	///if (test_bit(idx, vdpa->vq_bitmap))
+	//return -EBUSY;
+
+	/* For same device but different groups, ++refcount only */
+	if (vdpa->iommufd_device)
+		goto out_inc;
+
+	r = -EBADF;
+	f = fdget(set_iommufd.iommufd);
+	if (!f.file)
+		goto out_bitmap_free;
+
+	r = -EINVAL;
+	ictx = iommufd_ctx_from_file(f.file);
+	if (IS_ERR(ictx))
+		goto out_fdput;
+
+	if (v->domain)
+		iommu_detach_device(v->domain, dma_dev);
+
+#if 0
+	iommu_group_add_device(iommu_group_alloc(), &vdpa->dev);
+#endif
+	pt_id = set_iommufd.ioas_id;
+	r = vdpa_iommufd_bind(vdpa, ictx, &pt_id, &dev_id);
+	if (r)
+		goto out_reattach;
+
+	set_iommufd.out_dev_id = dev_id;
+	set_iommufd.out_hwpt_id = pt_id;
+	r = copy_to_user(argp + minsz, &set_iommufd.out_dev_id,
+			 sizeof(set_iommufd.out_dev_id) +
+				 sizeof(set_iommufd.out_hwpt_id)) ?
+		    -EFAULT :
+		    0;
+	if (r)
+		goto out_device_unbind;
+	printk(KERN_ERR "[%s] %d called %p\n", __func__, __LINE__,
+	       vdpa->iommufd_ictx);
+
+	vdpa->iommufd_ictx = ictx;
+
+out_inc:
+	atomic_inc(&vdpa->iommufd_users);
+	set_bit(idx, vdpa->vq_bitmap);
+
+	goto out_fdput;
+
+out_device_unbind:
+
+	vdpa_iommufd_unbind(vdpa);
+out_reattach:
+
+	iommu_attach_device(v->domain, dma_dev);
+	iommufd_ctx_put(ictx);
+out_fdput:
+	fdput(f);
+out_bitmap_free:
+	bitmap_free(vdpa->vq_bitmap);
+	return r;
+}
+int vdpa_ioctl_device_attach(struct vhost_vdpa *v, void __user *arg)
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
+	if (attach.argsz < minsz || attach.flags ||
+	    attach.ioas_id == IOMMUFD_INVALID_ID)
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
+int vdpa_ioctl_device_detach(struct vhost_vdpa *v, void __user *arg)
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
 
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
@@ -655,6 +834,18 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_SET_LOG_FD:
 		r = -ENOIOCTLCMD;
 		break;
+	case VHOST_VDPA_SET_IOMMU_FD:
+
+		r = vhost_vdpa_tmp_set_iommufd(v, argp);
+		break;
+	case VDPA_DEVICE_ATTACH_IOMMUFD_AS:
+		r = vdpa_ioctl_device_attach(v, (void __user *)arg);
+		break;
+
+	case VDPA_DEVICE_DETACH_IOMMUFD_AS:
+		r = vdpa_ioctl_device_detach(v, (void __user *)arg);
+		break;
+
 	case VHOST_VDPA_SET_CONFIG_CALL:
 		r = vhost_vdpa_set_config_call(v, argp);
 		break;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index f9f115a7c75b..cdda0c1860d8 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -45,6 +45,7 @@
 #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
 /* Specify an eventfd file descriptor to signal on log write. */
 #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
+/* Specify an iommufd file descriptor for IO address translation */
 
 /* Ring setup. */
 /* Set number of descriptors in ring. This parameter can not
@@ -180,4 +181,74 @@
  */
 #define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
 
+/* vhost vdpa set iommufd
+ * Input parameters:
+ * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
+ * @group_id: identifier of the group that a virtqueue belongs to
+ * @ioas_id: IOAS identifier returned from ioctl(IOMMU_IOAS_ALLOC)
+ * Output parameters:
+ * @out_dev_id: device identifier
+ * @out_hwpt_id: hardware IO pagetable identifier
+ */
+struct vhost_vdpa_set_iommufd {
+	__s32 iommufd;
+	__u32 group_id;
+	__u32 ioas_id;
+	__u32 out_dev_id;
+	__u32 out_hwpt_id;
+};
+
+#define VHOST_VDPA_SET_IOMMU_FD \
+	_IOW(VHOST_VIRTIO, 0x7e, struct vhost_vdpa_set_iommufd)
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
+	_IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
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

