Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281D7E9027
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjKLNXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjKLNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:23:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795C2702;
        Sun, 12 Nov 2023 05:23:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2D4C433C8;
        Sun, 12 Nov 2023 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795415;
        bh=qn7zZaSapu1gCgzNEb44ZBrBTd6/ucPjNLCZi9JBYYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq3K8FmpOCJu+Ijb1ki0iCXzdJpWblucc0sn/y2AWp2UgbxxCLH0P4Vhnqlehm5mA
         s4Vmdp79hXo5BZ7eubiiBrgJsuRkwP6dXEAN6dT1J75bhl5AoRCU3XdUrdbZmwuA67
         Vvij/L1epNc137u/8jbaMmGePu7aKGL7fsHrtAAmIZ+kJUhsS4i6f7oqM+sWj0rlP7
         0+LyutwqnxgHr4mHPx5OhilgxflFrY4ohomVbRBCjgaSm+H66fwFlWHhIw0GOoVa1q
         Q4e9ZmtI3J3AE1ZCkvsddf8HYQ+ULjxt52gEKJ3mqR60gxGY8cZY1dI8P/oI/dXwA/
         VuobK8Yh1RSDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Lei Yang <leiyang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 6/7] vhost-vdpa: clean iotlb map during reset for older userspace
Date:   Sun, 12 Nov 2023 08:23:15 -0500
Message-ID: <20231112132323.174148-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132323.174148-1-sashal@kernel.org>
References: <20231112132323.174148-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Si-Wei Liu <si-wei.liu@oracle.com>

[ Upstream commit bc91df5c70ac720eca18bd1f4a288f2582713d3e ]

Using .compat_reset op from the previous patch, the buggy .reset
behaviour can be kept as-is on older userspace apps, which don't ack the
IOTLB_PERSIST backend feature. As this compatibility quirk is limited to
those drivers that used to be buggy in the past, it won't affect change
the behaviour or affect ABI on the setups with API compliant driver.

The separation of .compat_reset from the regular .reset allows
vhost-vdpa able to know which driver had broken behaviour before, so it
can apply the corresponding compatibility quirk to the individual driver
whenever needed.  Compared to overloading the existing .reset with
flags, .compat_reset won't cause any extra burden to the implementation
of every compliant driver.

[mst: squashed in two fixup commits]

Message-Id: <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
Message-Id: <1698102863-21122-1-git-send-email-si-wei.liu@oracle.com>
Reported-by: Dragos Tatulea <dtatulea@nvidia.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Message-Id: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c         | 20 ++++++++++++++++----
 drivers/virtio/virtio_vdpa.c |  2 +-
 include/linux/vdpa.h         |  7 +++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 78379ffd23363..183cec8305e3e 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -210,13 +210,24 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static int vhost_vdpa_reset(struct vhost_vdpa *v)
+static int _compat_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
+	u32 flags = 0;
 
-	v->in_batch = 0;
+	if (v->vdev.vqs) {
+		flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
+						    VHOST_BACKEND_F_IOTLB_PERSIST) ?
+			 VDPA_RESET_F_CLEAN_MAP : 0;
+	}
+
+	return vdpa_reset(vdpa, flags);
+}
 
-	return vdpa_reset(vdpa);
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
+{
+	v->in_batch = 0;
+	return _compat_vdpa_reset(v);
 }
 
 static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
@@ -295,7 +306,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 			vhost_vdpa_unsetup_vq_irq(v, i);
 
 	if (status == 0) {
-		ret = vdpa_reset(vdpa);
+		ret = _compat_vdpa_reset(v);
 		if (ret)
 			return ret;
 	} else
@@ -1285,6 +1296,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
 	vhost_vdpa_free_domain(v);
 	vhost_dev_cleanup(&v->vdev);
 	kfree(v->vdev.vqs);
+	v->vdev.vqs = NULL;
 }
 
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 06ce6d8c2e004..8d63e5923d245 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	vdpa_reset(vdpa);
+	vdpa_reset(vdpa, 0);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0e652026b776f..3e1af63803e55 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -485,14 +485,17 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline int vdpa_reset(struct vdpa_device *vdev)
+static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 	int ret;
 
 	down_write(&vdev->cf_lock);
 	vdev->features_valid = false;
-	ret = ops->reset(vdev);
+	if (ops->compat_reset && flags)
+		ret = ops->compat_reset(vdev, flags);
+	else
+		ret = ops->reset(vdev);
 	up_write(&vdev->cf_lock);
 	return ret;
 }
-- 
2.42.0

