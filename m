Return-Path: <linux-kernel+bounces-56075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E2D84C5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB422832C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0920321;
	Wed,  7 Feb 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3bolgMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A1200D8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290907; cv=none; b=EHYZTLJIoD8HTxkQD1GMn0JVfDXC6EpdACujMVBOCnogPGJ226Q18rdiRzGks7JjVhzFDcNHdr2fUupsq9VftZRb1ccPgmLSM9wEeWvUBqdvKaUn6uTiOpUX6+hdSpL6d69/1QaIh1QhW1cDsCZbNago1qbZ+SYbv9Sgm+TjL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290907; c=relaxed/simple;
	bh=HJ8IhDMnRtXRcH7QQWNi/3y6XYnFHwSd1H1sIxy1Luo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ4FTg4lFYiDuCvaCAFSW7uNaMBSRUEwT5ZSieFuLz4FBA69l4La8O/gy2nHeWGVNOcKP0O2qiWvTuqzZJTkTYw9XKIMsAp0DnkknJOwfBK9rmxoWIEIhckxeZmtVCUblNNe2PrEQasuqdIiKKyMfIhadQ7lWm38HlDeKS4zcCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3bolgMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BE8C433F1;
	Wed,  7 Feb 2024 07:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707290907;
	bh=HJ8IhDMnRtXRcH7QQWNi/3y6XYnFHwSd1H1sIxy1Luo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3bolgMWjULeKQeo+0Oa9LrdecwhDRU38coASeGAR3jLmh6ZBKfnbaIj1VQebVm0C
	 W0Dw5FE4WeUfIJM28Lx0LFaw7OhhcEFLWfU3pjTA3XWt9jlQ6HRwoPsVoApPDI4eHt
	 MtZWzItScs3bZsCm5PfckL3/XkiyapCnCVMWZnIM7hIyLSStwyXdXbVVWd99yfCcOK
	 mGjicbOdj5bPpDYp5wX0SVPn3MRNC7QaH/PmlBP3naTXwmKDyankEMQ3SI+aYWFYB8
	 tzj5F81DEJ4XS9fSZIoHZjKXhM50eS+olG9L/oAntJygN3YLG3XA7WuSP7rYErR41e
	 G3s0BVw8o31sw==
From: Saeed Mahameed <saeed@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/5] misc: mlx5ctl: Add info ioctl
Date: Tue,  6 Feb 2024 23:24:33 -0800
Message-ID: <20240207072435.14182-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207072435.14182-1-saeed@kernel.org>
References: <20240207072435.14182-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Implement INFO ioctl to return the allocated UID and the capability flags
and some other useful device information.

Example:
$ sudo ./mlx5ctl mlx5_core.ctl.0
UCTX UID: 1
UCTX CAP: 0x3
DEV UCTX CAP: 0x3
USER CAP: 0x1d

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 drivers/misc/mlx5ctl/main.c                   | 68 +++++++++++++++++++
 include/uapi/misc/mlx5ctl.h                   | 20 ++++++
 3 files changed, 89 insertions(+)
 create mode 100644 include/uapi/misc/mlx5ctl.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..17e6ab6d0d9f 100644
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
index 314aeb45bb8e..e4e70359dbe8 100644
--- a/drivers/misc/mlx5ctl/main.c
+++ b/drivers/misc/mlx5ctl/main.c
@@ -8,6 +8,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/driver.h>
+#include <uapi/misc/mlx5ctl.h>
 #include <linux/atomic.h>
 #include <linux/refcount.h>
 
@@ -214,10 +215,77 @@ static int mlx5ctl_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mlx5ctl_info_ioctl(struct file *file,
+			      struct mlx5ctl_info __user *arg,
+			      size_t usize)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	size_t ksize = sizeof(struct mlx5ctl_info);
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	struct mlx5ctl_info *info;
+	int err = 0;
+
+	if (usize < ksize)
+		return -EINVAL;
+
+	info = kzalloc(ksize, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->dev_uctx_cap = MLX5_CAP_GEN(mdev, uctx_cap);
+	info->uctx_cap = mfd->uctx_cap;
+	info->uctx_uid = mfd->uctx_uid;
+	info->ucap = mfd->ucap;
+
+	if (copy_to_user(arg, info, ksize))
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
+		err = -ENOTTY;
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
index 000000000000..9be944128025
--- /dev/null
+++ b/include/uapi/misc/mlx5ctl.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5CTL_IOCTL_H__
+#define __MLX5CTL_IOCTL_H__
+
+struct mlx5ctl_info {
+	__u16 uctx_uid; /* current process allocated UCTX UID */
+	__u16 reserved1; /* explicit padding must be zero */
+	__u32 uctx_cap; /* current process effective UCTX cap */
+	__u32 dev_uctx_cap; /* device's UCTX capabilities */
+	__u32 ucap; /* process user capability */
+};
+
+#define MLX5CTL_IOCTL_MAGIC 0x5c
+
+#define MLX5CTL_IOCTL_INFO \
+	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
+
+#endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.43.0


