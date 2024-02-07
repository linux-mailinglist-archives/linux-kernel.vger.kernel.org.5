Return-Path: <linux-kernel+bounces-56074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD484C5A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07801F254B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52EA2030B;
	Wed,  7 Feb 2024 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9K1oqiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220B200A5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290906; cv=none; b=X5IVCNy0TaIjgZP2yQj+KkMGl2mI7tEeMe+0JNOZXaek06EYBQL9fmFvD1OaETrwHo0u0vL81AhAnd2kYrWU5Od+9BPCUVoTbH2blYhfS0badZLTjUuZV6M0Pis7FGkdnQqse8TeTWILOaTkhf/e9ewgI6ZzgZXFXjEZ7KSIx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290906; c=relaxed/simple;
	bh=kuF2c9QD0mQvG5AXOSXT36rGaI17zhRjFvDMYHsbT3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNTkV6QN5BUFsB7RTZr1CqEEA0mYW58Dha9exCIlZx13ynQjuibWgIWIrSYX+vgUowzWgWjSlbCVyj6xsg53fHpmNX1Y3WNgr9pY/WqF1pFMJPD8ZU287cRc3gWFH8/KdrJT5DWgkTURmjNPua6JOZU+qERVoKtYxgxmNHGwp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9K1oqiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1B1C433C7;
	Wed,  7 Feb 2024 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707290906;
	bh=kuF2c9QD0mQvG5AXOSXT36rGaI17zhRjFvDMYHsbT3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9K1oqiPQ1e6W/62VCX81MwrdFQ+xfSo6rA8BQ3mJCqbyg8E4Yrh93Ti+ZOfI39SH
	 Hc/DMcRRbzc5SrHUJqOs5NW8WwSHtlKhFHYirHgbsFhgeXLHVXCTqSp16P7+y+Z2Fz
	 GEjWlF/ODLwhrmsSZkcHIf6iMmVY0fyHJKIOUV1Nteh6l6IJynTWXzELCdw+r18b59
	 zRjS19IzOOYKpcbpJBE0AVsIITiWee31U8QkmqYCkX+NGTblUzpnnxu0X0spCdHC4h
	 IVdTdvKu0olOpbn7Phc8Xx2s2tD2kQxKjPJpL6rKpv/LV3C0X/zyI6P+K35v5U8nJd
	 GoLw247/ZvZeA==
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
Subject: [PATCH V4 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Date: Tue,  6 Feb 2024 23:24:32 -0800
Message-ID: <20240207072435.14182-3-saeed@kernel.org>
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

The ConnectX HW family supported by the mlx5 drivers uses an architecture
where a FW component executes "mailbox RPCs" issued by the driver to make
changes to the device. This results in a complex debugging environment
where the FW component has information and low level configuration that
needs to be accessed to userspace for debugging purposes.

Historically a userspace program was used that accessed the PCI register
and config space directly through /sys/bus/pci/.../XXX and could operate
these debugging interfaces in parallel with the running driver.
This approach is incompatible with secure boot and kernel lockdown so this
driver provides a secure and restricted interface to that same data.

On open the driver would allocate a special FW UID (user context ID)
restrected to debug RPCs only, later in this series all user RPCs will
be stamped with this UID.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 MAINTAINERS                   |   8 +
 drivers/misc/Kconfig          |   1 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/mlx5ctl/Kconfig  |  14 ++
 drivers/misc/mlx5ctl/Makefile |   4 +
 drivers/misc/mlx5ctl/main.c   | 332 ++++++++++++++++++++++++++++++++++
 6 files changed, 360 insertions(+)
 create mode 100644 drivers/misc/mlx5ctl/Kconfig
 create mode 100644 drivers/misc/mlx5ctl/Makefile
 create mode 100644 drivers/misc/mlx5ctl/main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..a41dc2056ae1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14011,6 +14011,14 @@ L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	drivers/vdpa/mlx5/
 
+MELLANOX MLX5 ConnectX Diag DRIVER
+M:	Saeed Mahameed <saeedm@nvidia.com>
+R:	Itay Avraham <itayavr@nvidia.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/misc/mlx5ctl/
+F:	include/uapi/misc/mlx5ctl.h
+
 MELLANOX MLXCPLD I2C AND MUX DRIVER
 M:	Vadim Pasternak <vadimp@nvidia.com>
 M:	Michael Shych <michaelsh@nvidia.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..4ab825acfd54 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -591,4 +591,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
+source "drivers/misc/mlx5ctl/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..c491c2b8ac88 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-$(CONFIG_MLX5CTL)		+= mlx5ctl/
diff --git a/drivers/misc/mlx5ctl/Kconfig b/drivers/misc/mlx5ctl/Kconfig
new file mode 100644
index 000000000000..faaa1dba2cc2
--- /dev/null
+++ b/drivers/misc/mlx5ctl/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+
+config MLX5CTL
+	tristate "mlx5 ConnectX control misc driver"
+	depends on MLX5_CORE
+	help
+	  MLX5CTL provides interface for the user process to access the debug and
+          configuration registers of the ConnectX hardware family
+          (NICs, PCI switches and SmartNIC SoCs).
+          This will allow configuration and debug tools to work out of the box on
+          mainstream kernel.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/misc/mlx5ctl/Makefile b/drivers/misc/mlx5ctl/Makefile
new file mode 100644
index 000000000000..b5c7f99e0ab6
--- /dev/null
+++ b/drivers/misc/mlx5ctl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_MLX5CTL) += mlx5ctl.o
+mlx5ctl-y := main.o
diff --git a/drivers/misc/mlx5ctl/main.c b/drivers/misc/mlx5ctl/main.c
new file mode 100644
index 000000000000..314aeb45bb8e
--- /dev/null
+++ b/drivers/misc/mlx5ctl/main.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
+#include <linux/atomic.h>
+#include <linux/refcount.h>
+
+MODULE_DESCRIPTION("mlx5 ConnectX control misc driver");
+MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
+
+/* mlx5ctl_dev lifecycle locking scheme:
+ *
+ * 1. mcdev->rw_lock: protects mdev from removal on mlx5ctl_remove()
+ *
+ *	- Write lock is taken by auxiliary_driver.remove
+ *		- Set mdev to NULL
+ *	- Read lock is taken by open/release and ioctls
+ *		- To prevent mdev from being removed
+ *		- Check mdev is not NULL, abort otherwise
+ *
+ * 2. mcdev->refcount: protects mcdev from removal after miscdevice is unregistered
+ *	- miscdevice does not have a refcount, so we use kref
+ *	- miscdevice is unregistered on mlx5ctl_remove()
+ *	- already open fds will still have a reference to mcdev
+ *		- mcdev is freed when refcount reaches 0 on last fd release
+ */
+struct mlx5ctl_dev {
+	struct mlx5_core_dev *mdev;
+	struct miscdevice miscdev;
+	struct auxiliary_device *adev;
+	struct list_head fd_list;
+	spinlock_t fd_list_lock; /* protect list add/del */
+	struct rw_semaphore rw_lock; /* protect mdev from device removal */
+	struct kref refcount;
+};
+
+struct mlx5ctl_fd {
+	u16 uctx_uid;
+	u32 uctx_cap;
+	u32 ucap; /* user cap */
+	struct mlx5ctl_dev *mcdev;
+	struct list_head list;
+};
+
+#define mlx5ctl_err(mcdev, format, ...) \
+	dev_err(mcdev->miscdev.parent, format, ##__VA_ARGS__)
+
+#define mlx5ctl_dbg(mcdev, format, ...) \
+	dev_dbg(mcdev->miscdev.parent, "PID %d: " format, \
+		current->pid, ##__VA_ARGS__)
+
+enum {
+	MLX5_UCTX_OBJECT_CAP_RAW_TX                     = 0x1,
+	MLX5_UCTX_OBJECT_CAP_INTERNAL_DEVICE_RESOURCES  = 0x2,
+	MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES            = 0x4,
+};
+
+static int mlx5ctl_alloc_uid(struct mlx5ctl_dev *mcdev, u32 cap)
+{
+	u32 out[MLX5_ST_SZ_DW(create_uctx_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {};
+	void *uctx;
+	int err;
+	u16 uid;
+
+	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
+
+	mlx5ctl_dbg(mcdev, "MLX5_CMD_OP_CREATE_UCTX: caps 0x%x\n", cap);
+	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
+	MLX5_SET(uctx, uctx, cap, cap);
+
+	err = mlx5_cmd_exec(mcdev->mdev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	uid = MLX5_GET(create_uctx_out, out, uid);
+	mlx5ctl_dbg(mcdev, "allocated uid %d with caps 0x%x\n", uid, cap);
+	return uid;
+}
+
+static void mlx5ctl_release_uid(struct mlx5ctl_dev *mcdev, u16 uid)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	int err;
+
+	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
+	MLX5_SET(destroy_uctx_in, in, uid, uid);
+
+	err = mlx5_cmd_exec_in(mdev, destroy_uctx, in);
+	mlx5ctl_dbg(mcdev, "released uid %d err(%d)\n", uid, err);
+}
+
+static void mcdev_get(struct mlx5ctl_dev *mcdev);
+static void mcdev_put(struct mlx5ctl_dev *mcdev);
+
+static int mlx5ctl_open_mfd(struct mlx5ctl_fd *mfd)
+{
+	struct mlx5_core_dev *mdev = mfd->mcdev->mdev;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	u32 ucap = 0, cap = 0;
+	int uid;
+
+#define MLX5_UCTX_CAP(mdev, cap) \
+	(MLX5_CAP_GEN(mdev, uctx_cap) & MLX5_UCTX_OBJECT_CAP_##cap)
+
+	if (capable(CAP_NET_RAW) && MLX5_UCTX_CAP(mdev, RAW_TX)) {
+		ucap |= CAP_NET_RAW;
+		cap |= MLX5_UCTX_OBJECT_CAP_RAW_TX;
+	}
+
+	if (capable(CAP_SYS_RAWIO) && MLX5_UCTX_CAP(mdev, INTERNAL_DEVICE_RESOURCES)) {
+		ucap |= CAP_SYS_RAWIO;
+		cap |= MLX5_UCTX_OBJECT_CAP_INTERNAL_DEVICE_RESOURCES;
+	}
+
+	if (capable(CAP_SYS_ADMIN) && MLX5_UCTX_CAP(mdev, TOOLS_RESOURCES)) {
+		ucap |= CAP_SYS_ADMIN;
+		cap |= MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES;
+	}
+
+	uid = mlx5ctl_alloc_uid(mcdev, cap);
+	if (uid < 0)
+		return uid;
+
+	mfd->uctx_uid = uid;
+	mfd->uctx_cap = cap;
+	mfd->ucap = ucap;
+	mfd->mcdev = mcdev;
+
+	mlx5ctl_dbg(mcdev, "allocated uid %d with uctx caps 0x%x, user cap 0x%x\n",
+		    uid, cap, ucap);
+	return 0;
+}
+
+static void mlx5ctl_release_mfd(struct mlx5ctl_fd *mfd)
+{
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+
+	mlx5ctl_release_uid(mcdev,  mfd->uctx_uid);
+}
+
+static int mlx5ctl_open(struct inode *inode, struct file *file)
+{
+	struct mlx5_core_dev *mdev;
+	struct mlx5ctl_dev *mcdev;
+	struct mlx5ctl_fd *mfd;
+	int err = 0;
+
+	mcdev = container_of(file->private_data, struct mlx5ctl_dev, miscdev);
+	mcdev_get(mcdev);
+	down_read(&mcdev->rw_lock);
+	mdev = mcdev->mdev;
+	if (!mdev) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	mfd = kzalloc(sizeof(*mfd), GFP_KERNEL_ACCOUNT);
+	if (!mfd)
+		return -ENOMEM;
+
+	mfd->mcdev = mcdev;
+	err = mlx5ctl_open_mfd(mfd);
+	if (err)
+		goto unlock;
+
+	spin_lock(&mcdev->fd_list_lock);
+	list_add_tail(&mfd->list, &mcdev->fd_list);
+	spin_unlock(&mcdev->fd_list_lock);
+
+	file->private_data = mfd;
+
+unlock:
+	up_read(&mcdev->rw_lock);
+	if (err) {
+		mcdev_put(mcdev);
+		kfree(mfd);
+	}
+	return err;
+}
+
+static int mlx5ctl_release(struct inode *inode, struct file *file)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+
+	down_read(&mcdev->rw_lock);
+	if (!mcdev->mdev) {
+		pr_debug("[%d] UID %d mlx5ctl: mdev is already released\n",
+			 current->pid, mfd->uctx_uid);
+		/* All mfds are already released, skip ... */
+		goto unlock;
+	}
+
+	spin_lock(&mcdev->fd_list_lock);
+	list_del(&mfd->list);
+	spin_unlock(&mcdev->fd_list_lock);
+
+	mlx5ctl_release_mfd(mfd);
+
+unlock:
+	kfree(mfd);
+	up_read(&mcdev->rw_lock);
+	mcdev_put(mcdev);
+	file->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations mlx5ctl_fops = {
+	.owner = THIS_MODULE,
+	.open = mlx5ctl_open,
+	.release = mlx5ctl_release,
+};
+
+static int mlx5ctl_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+
+{
+	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = madev->mdev;
+	struct mlx5ctl_dev *mcdev;
+	char *devname = NULL;
+	int err;
+
+	mcdev = kzalloc(sizeof(*mcdev), GFP_KERNEL_ACCOUNT);
+	if (!mcdev)
+		return -ENOMEM;
+
+	kref_init(&mcdev->refcount);
+	INIT_LIST_HEAD(&mcdev->fd_list);
+	spin_lock_init(&mcdev->fd_list_lock);
+	init_rwsem(&mcdev->rw_lock);
+	mcdev->mdev = mdev;
+	mcdev->adev = adev;
+	devname = kasprintf(GFP_KERNEL_ACCOUNT, "mlx5ctl-%s",
+			    dev_name(&adev->dev));
+	if (!devname) {
+		err = -ENOMEM;
+		goto abort;
+	}
+
+	mcdev->miscdev = (struct miscdevice) {
+		.minor = MISC_DYNAMIC_MINOR,
+		.name = devname,
+		.fops = &mlx5ctl_fops,
+		.parent = &adev->dev,
+	};
+
+	err = misc_register(&mcdev->miscdev);
+	if (err) {
+		mlx5ctl_err(mcdev, "mlx5ctl: failed to register misc device err %d\n", err);
+		goto abort;
+	}
+
+	mlx5ctl_dbg(mcdev, "probe mdev@%s %s\n",
+		    dev_driver_string(mdev->device),
+		    dev_name(mdev->device));
+
+	auxiliary_set_drvdata(adev, mcdev);
+
+	return 0;
+
+abort:
+	kfree(devname);
+	kfree(mcdev);
+	return err;
+}
+
+static void mlx5ctl_remove(struct auxiliary_device *adev)
+{
+	struct mlx5ctl_dev *mcdev = auxiliary_get_drvdata(adev);
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	struct mlx5ctl_fd *mfd, *n;
+
+	misc_deregister(&mcdev->miscdev);
+	down_write(&mcdev->rw_lock);
+
+	list_for_each_entry_safe(mfd, n, &mcdev->fd_list, list) {
+		mlx5ctl_dbg(mcdev, "UID %d still has open FDs\n", mfd->uctx_uid);
+		list_del(&mfd->list);
+		mlx5ctl_release_mfd(mfd);
+	}
+
+	mlx5ctl_dbg(mcdev, "removed mdev %s %s\n",
+		    dev_driver_string(mdev->device), dev_name(mdev->device));
+
+	mcdev->mdev = NULL; /* prevent already open fds from accessing the device */
+	up_write(&mcdev->rw_lock);
+	mcdev_put(mcdev);
+}
+
+static void mcdev_free(struct kref *ref)
+{
+	struct mlx5ctl_dev *mcdev = container_of(ref, struct mlx5ctl_dev, refcount);
+
+	kfree(mcdev->miscdev.name);
+	kfree(mcdev);
+}
+
+static void mcdev_get(struct mlx5ctl_dev *mcdev)
+{
+	kref_get(&mcdev->refcount);
+}
+
+static void mcdev_put(struct mlx5ctl_dev *mcdev)
+{
+	kref_put(&mcdev->refcount, mcdev_free);
+}
+
+static const struct auxiliary_device_id mlx5ctl_id_table[] = {
+	{ .name = MLX5_ADEV_NAME ".ctl", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, mlx5ctl_id_table);
+
+static struct auxiliary_driver mlx5ctl_driver = {
+	.name = "ctl",
+	.probe = mlx5ctl_probe,
+	.remove = mlx5ctl_remove,
+	.id_table = mlx5ctl_id_table,
+};
+
+module_auxiliary_driver(mlx5ctl_driver);
-- 
2.43.0


