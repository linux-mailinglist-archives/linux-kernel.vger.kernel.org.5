Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5DD7F0506
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjKSJoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjKSJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:43:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14922CE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:43:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3692C433C8;
        Sun, 19 Nov 2023 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700387034;
        bh=9jMI2vx8nOKTbPAAjqs6b+jb8bpd0TYFkj49pFrwOis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPw2tySRvcB0+wJaFTh/0ds1Z/OljL6doPJHQcqbWGIHQrQ1dmJB1o5LWCsA0z9Ug
         HxBtK6Sf2MlzpYo19Udh70RtFOfRS69dim2P2pK1ZlcwhDZDq7Oc6oG0Ism3AXx6VW
         R2b78SmkgC3iv2NPh+udAqFKM/JAecZ7+9ESMoi/k5bdnmzm6f5d1888cK4vX/LyGw
         UKMpnyqUV/UBW+HEFv7Zj31XRgjIDsLxq7x7ZfUpv4TPAgJt4mMyjQ08YlSwa9dZVI
         MKecpHKa4mP6QnPjmW/qdNn93Fyf1ZMu4HIQ2mcQ/sJIoUa6winwOs+l4jVkh1yJj3
         72DUZISATJa0w==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH V2 3/5] misc: mlx5ctl: Add info ioctl
Date:   Sun, 19 Nov 2023 01:24:48 -0800
Message-ID: <20231119092450.164996-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119092450.164996-1-saeed@kernel.org>
References: <20231119092450.164996-1-saeed@kernel.org>
MIME-Version: 1.0
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

From: Saeed Mahameed <saeedm@nvidia.com>

Implement INFO ioctl to return the allocated UID and the capability flags
and some other useful device information such as the underlying ConnectX
device.

Example:
$ sudo ./mlx5ctlu mlx5_core.ctl.0
mlx5dev: 0000:00:04.0
UCTX UID: 1
UCTX CAP: 0x3
DEV UCTX CAP: 0x3
USER CAP: 0x1d

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 drivers/misc/mlx5ctl/main.c                   | 71 +++++++++++++++++++
 include/uapi/misc/mlx5ctl.h                   | 24 +++++++
 3 files changed, 96 insertions(+)
 create mode 100644 include/uapi/misc/mlx5ctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 4ea5b837399a..9faf91ffefff 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -89,6 +89,7 @@ Code  Seq#    Include File                                           Comments
 0x20  all    drivers/cdrom/cm206.h
 0x22  all    scsi/sg.h
 0x3E  00-0F  linux/counter.h                                         <mailto:linux-iio@vger.kernel.org>
+0x5c  all    uapi/misc/mlx5ctl.h                                     Nvidia ConnectX control
 '!'   00-1F  uapi/linux/seccomp.h
 '#'   00-3F                                                          IEEE 1394 Subsystem
                                                                      Block for the entire subsystem
diff --git a/drivers/misc/mlx5ctl/main.c b/drivers/misc/mlx5ctl/main.c
index 8eb150461b80..6a98b40e4300 100644
--- a/drivers/misc/mlx5ctl/main.c
+++ b/drivers/misc/mlx5ctl/main.c
@@ -8,6 +8,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/driver.h>
+#include <uapi/misc/mlx5ctl.h>
 #include <linux/atomic.h>
 #include <linux/refcount.h>
 
@@ -198,10 +199,80 @@ static int mlx5ctl_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mlx5ctl_info_ioctl(struct file *file,
+			      struct mlx5ctl_info __user *arg,
+			      size_t usize)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	struct mlx5ctl_info *info;
+	size_t ksize = 0;
+	int err = 0;
+
+	ksize = max(sizeof(struct mlx5ctl_info), usize);
+	info = kzalloc(ksize, GFP_KERNEL_ACCOUNT);
+	if (!info)
+		return -ENOMEM;
+
+	info->size = sizeof(struct mlx5ctl_info);
+
+	info->dev_uctx_cap = MLX5_CAP_GEN(mdev, uctx_cap);
+	info->uctx_cap = mfd->uctx_cap;
+	info->uctx_uid = mfd->uctx_uid;
+	info->ucap = mfd->ucap;
+
+	strscpy(info->devname, dev_name(&mdev->pdev->dev),
+		sizeof(info->devname));
+
+	if (copy_to_user(arg, info, usize))
+		err = -EFAULT;
+
+	kfree(info);
+	return err;
+}
+
+static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	void __user *argp = (void __user *)arg;
+	size_t size = _IOC_SIZE(cmd);
+	int err = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	mlx5ctl_dbg(mcdev, "ioctl 0x%x type/nr: %d/%d size: %d DIR:%d\n", cmd,
+		    _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd), _IOC_DIR(cmd));
+
+	down_read(&mcdev->rw_lock);
+	if (!mcdev->mdev) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	switch (cmd) {
+	case MLX5CTL_IOCTL_INFO:
+		err = mlx5ctl_info_ioctl(file, argp, size);
+		break;
+
+	default:
+		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
+		err = -ENOIOCTLCMD;
+		break;
+	}
+unlock:
+	up_read(&mcdev->rw_lock);
+	return err;
+}
+
 static const struct file_operations mlx5ctl_fops = {
 	.owner = THIS_MODULE,
 	.open = mlx5ctl_open,
 	.release = mlx5ctl_release,
+	.unlocked_ioctl = mlx5ctl_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 static int mlx5ctl_probe(struct auxiliary_device *adev,
diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
new file mode 100644
index 000000000000..37153cc0fc6e
--- /dev/null
+++ b/include/uapi/misc/mlx5ctl.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5CTL_IOCTL_H__
+#define __MLX5CTL_IOCTL_H__
+
+struct mlx5ctl_info {
+	__aligned_u64 flags;
+	__u32 size;
+	__u8 devname[64]; /* underlaying ConnectX device */
+	__u16 uctx_uid; /* current process allocated UCTX UID */
+	__u16 reserved1;
+	__u32 uctx_cap; /* current process effective UCTX cap */
+	__u32 dev_uctx_cap; /* device's UCTX capabilities */
+	__u32 ucap; /* process user capability */
+	__u32 reserved2;
+};
+
+#define MLX5CTL_IOCTL_MAGIC 0x5c
+
+#define MLX5CTL_IOCTL_INFO \
+	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
+
+#endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.41.0

