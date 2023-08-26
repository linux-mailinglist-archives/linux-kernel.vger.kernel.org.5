Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F85178930D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHZBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjHZBYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:24:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16C71FC3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 18:24:13 -0700 (PDT)
Received: from kwepemm600016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RXfCh34hkzJrmt;
        Sat, 26 Aug 2023 09:21:04 +0800 (CST)
Received: from linux-hNCriV.Euler.HZ (10.175.124.27) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 09:24:11 +0800
From:   Jiang Dongxu <jiangdongxu1@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     jiangdongxu <jiangdongxu1@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <longpeng2@huawei.com>,
        <eric.fangyi@huawei.com>
Subject: [PATCH 2/2] vhost-vdpa: add uAPI for logging
Date:   Sat, 26 Aug 2023 09:23:32 +0800
Message-ID: <0495a6ca0a025ff3b1e29d24d4a4b30a3e468bde.1693012755.git.jiangdongxu1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1693012755.git.jiangdongxu1@huawei.com>
References: <cover.1693012755.git.jiangdongxu1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jiangdongxu <jiangdongxu1@huawei.com>

These new ioctl add support for setting bitmaps config,
like base address and buffer size from userspace.

When setup migration, VMM will call VHOST_SET_LOG_BASE and
VHOST_SET_LOG_SIZE to set address and size of buffer used
for storing bitmaps.

Then VMM start live migration, VMM will enable logging
vhost device by set feature VHOST_F_LOG_ALL.

And during live migration iterate, VMM get dirty page info
from vhost device by calling VHOST_LOG_SYNC.

Signed-off-by: jiangdongxu <jiangdongxu1@huawei.com>
---
 drivers/vhost/vdpa.c       | 49 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h |  4 ++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b43e8680eee8..75e17d9b136b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -556,6 +556,47 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
 	return ops->resume(vdpa);
 }
 
+static long vhost_vdpa_set_log_base(struct vhost_vdpa *v, u64 __user *argp)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	u64 log;
+
+	if (!ops->set_log_base)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&log, argp, sizeof(uint64_t)))
+		return -EFAULT;
+
+	return ops->set_log_base(vdpa, log);
+}
+
+static long vhost_vdpa_set_log_size(struct vhost_vdpa *v, u64 __user *sizep)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	u64 log_size;
+
+	if (!ops->set_log_size)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&log_size, sizep, sizeof(log_size)))
+		return -EFAULT;
+
+	return ops->set_log_size(vdpa, log_size);
+}
+
+static long vhost_vdpa_log_sync(struct vhost_vdpa *v)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (!ops->log_sync)
+		return -EOPNOTSUPP;
+
+	return ops->log_sync(vdpa);
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -729,6 +770,14 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			r = -EFAULT;
 		break;
 	case VHOST_SET_LOG_BASE:
+		r = vhost_vdpa_set_log_base(v, argp);
+		break;
+	case VHOST_SET_LOG_SIZE:
+		r = vhost_vdpa_set_log_size(v, argp);
+		break;
+	case VHOST_LOG_SYNC:
+		r = vhost_vdpa_log_sync(v);
+		break;
 	case VHOST_SET_LOG_FD:
 		r = -ENOIOCTLCMD;
 		break;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index f5c48b61ab62..ce9d187432d1 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -43,6 +43,10 @@
  * The bit is set using an atomic 32 bit operation. */
 /* Set base address for logging. */
 #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
+/* Set buffer size for logging */
+#define VHOST_SET_LOG_SIZE _IOW(VHOST_VIRTIO, 0x05, __u64)
+/* Synchronize logging buffer from kernel space to user space */
+#define VHOST_LOG_SYNC _IO(VHOST_VIRTIO, 0x06)
 /* Specify an eventfd file descriptor to signal on log write. */
 #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
 /* By default, a device gets one vhost_worker that its virtqueues share. This
-- 
2.27.0

