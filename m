Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553457F0509
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjKSJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjKSJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:44:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E9131
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:43:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93C2C433CB;
        Sun, 19 Nov 2023 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700387036;
        bh=FOLXuXY9ylFw25aSPAVvNy0qC58xy0lNAqAr0ns7EwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwele+8ybLBpLs6xgY95mV5F4cY9VyX+ifRV1ZwIojJhs3u8rHyffwUQJSoWRf1p0
         m/br7zUH6/af5mk5H27RlCLAgy+Z7u8upiU6ECypUL3Sc2XHpyuXWOA7RcHShN0OeX
         jAj+MbkuzZ4qqTk0Tb9k2mGj9z+JgbmCZ1kkUWg7F9qyNUkMMUZtlyk8C7NE7I585V
         H+IsNA46jNkgnWXPgUJGCR+gRvBEf0CuDc7SILrXOCRcewkPte55zTNIPhc7MQMgRY
         zDKXySfhzX2ToSZ2t6BLv0fFwYeJf4fKwwCKRBh7bH8dTLXxHl5IA8ovHBDfq7Zj3l
         BK7/isvGljKeg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH V2 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Date:   Sun, 19 Nov 2023 01:24:50 -0800
Message-ID: <20231119092450.164996-6-saeed@kernel.org>
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

Command rpc outbox buffer is limited in size, which can be very
annoying when trying to pull large traces out of the device.
Many device rpcs offer the ability to scatter output traces, contexts
and logs directly into user space buffers in a single shot.

Allow user to register user memory space, so the device may dump
information directly into user memory space.

The registered memory will be described by a device UMEM object which
has a unique umem_id, this umem_id can be later used in the rpc inbox
to tell the device where to populate the response output,
e.g HW traces and other debug object queries.

To do so this patch introduces two ioctls:

MLX5CTL_IOCTL_UMEM_REG(va_address, size):
 - calculate page fragments from the user provided virtual address
 - pin the pages, and allocate a sg list
 - dma map the sg list
 - create a UMEM device object that points to the dma addresses
 - add a driver umem object to an xarray data base for bookkeeping
 - return UMEM ID to user so it can be used in subsequent rpcs

MLX5CTL_IOCTL_UMEM_UNREG(umem_id):
 - user provides a pre allocated umem ID
 - unwinds the above

Example usecase, ConnectX device coredump can be as large as 2MB.
Using inline rpcs will take thousands of rpcs to get the full
coredump which can take multiple seconds.

With UMEM, it can be done in a single rpc, using 2MB of umem user buffer.

$ ./mlx5ctlu mlx5_core.ctl.0 coredump --umem_size=$(( 2 ** 20 ))

00 00 00 00 01 00 20 00 00 00 00 04 00 00 48 ec
00 00 00 08 00 00 00 00 00 00 00 0c 00 00 00 03
00 00 00 10 00 00 00 00 00 00 00 14 00 00 00 00
....
00 50 0b 3c 00 00 00 00 00 50 0b 40 00 00 00 00
00 50 0b 44 00 00 00 00 00 50 0b 48 00 00 00 00
00 50 0c 00 00 00 00 00

INFO : Core dump done
INFO : Core dump size 831304
INFO : Core dump address 0x0
INFO : Core dump cookie 0x500c04
INFO : More Dump 0

Other usecases are: dynamic HW and FW trace monitoring, high frequency
diagnostic counters sampling and batched objects and resource dumps.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/misc/mlx5ctl/Makefile |   1 +
 drivers/misc/mlx5ctl/main.c   |  81 ++++++++-
 drivers/misc/mlx5ctl/umem.c   | 320 ++++++++++++++++++++++++++++++++++
 drivers/misc/mlx5ctl/umem.h   |  17 ++
 include/uapi/misc/mlx5ctl.h   |  16 ++
 5 files changed, 434 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mlx5ctl/umem.c
 create mode 100644 drivers/misc/mlx5ctl/umem.h

diff --git a/drivers/misc/mlx5ctl/Makefile b/drivers/misc/mlx5ctl/Makefile
index b5c7f99e0ab6..f35234e931a8 100644
--- a/drivers/misc/mlx5ctl/Makefile
+++ b/drivers/misc/mlx5ctl/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_MLX5CTL) += mlx5ctl.o
 mlx5ctl-y := main.o
+mlx5ctl-y += umem.o
diff --git a/drivers/misc/mlx5ctl/main.c b/drivers/misc/mlx5ctl/main.c
index e7776ea4bfca..58900f2be212 100644
--- a/drivers/misc/mlx5ctl/main.c
+++ b/drivers/misc/mlx5ctl/main.c
@@ -12,6 +12,8 @@
 #include <linux/atomic.h>
 #include <linux/refcount.h>
 
+#include "umem.h"
+
 MODULE_DESCRIPTION("mlx5 ConnectX control misc driver");
 MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -30,6 +32,8 @@ struct mlx5ctl_fd {
 	u16 uctx_uid;
 	u32 uctx_cap;
 	u32 ucap; /* user cap */
+
+	struct mlx5ctl_umem_db *umem_db;
 	struct mlx5ctl_dev *mcdev;
 	struct list_head list;
 };
@@ -115,6 +119,12 @@ static int mlx5ctl_open_mfd(struct mlx5ctl_fd *mfd)
 	if (uid < 0)
 		return uid;
 
+	mfd->umem_db = mlx5ctl_umem_db_create(mdev, uid);
+	if (IS_ERR(mfd->umem_db)) {
+		mlx5ctl_release_uid(mcdev, uid);
+		return PTR_ERR(mfd->umem_db);
+	}
+
 	mfd->uctx_uid = uid;
 	mfd->uctx_cap = cap;
 	mfd->ucap = ucap;
@@ -129,6 +139,7 @@ static void mlx5ctl_release_mfd(struct mlx5ctl_fd *mfd)
 {
 	struct mlx5ctl_dev *mcdev = mfd->mcdev;
 
+	mlx5ctl_umem_db_destroy(mfd->umem_db);
 	mlx5ctl_release_uid(mcdev,  mfd->uctx_uid);
 }
 
@@ -323,6 +334,57 @@ static int mlx5ctl_cmdrpc_ioctl(struct file *file,
 	return err;
 }
 
+static int mlx5ctl_ioctl_umem_reg(struct file *file, void __user *arg,
+				  size_t usize)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_umem_reg *umem_reg;
+	int umem_id, err = 0;
+	size_t ksize = 0;
+
+	ksize = max(sizeof(struct mlx5ctl_umem_reg), usize);
+	umem_reg = kzalloc(ksize, GFP_KERNEL_ACCOUNT);
+	if (!umem_reg)
+		return -ENOMEM;
+
+	umem_reg->size = sizeof(struct mlx5ctl_umem_reg);
+
+	if (copy_from_user(umem_reg, arg, usize)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	if (umem_reg->flags || umem_reg->reserved1 || umem_reg->reserved2) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	umem_id = mlx5ctl_umem_reg(mfd->umem_db,
+				   (unsigned long)umem_reg->addr,
+				   umem_reg->len);
+	if (umem_id < 0) {
+		err = umem_id;
+		goto out;
+	}
+
+	umem_reg->umem_id = umem_id;
+
+	if (copy_to_user(arg, umem_reg, usize)) {
+		mlx5ctl_umem_unreg(mfd->umem_db, umem_id);
+		err = -EFAULT;
+	}
+out:
+	kfree(umem_reg);
+	return err;
+}
+
+static int mlx5ctl_ioctl_umem_unreg(struct file *file, unsigned long arg)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+
+	return mlx5ctl_umem_unreg(mfd->umem_db, (u32)arg);
+}
+
 static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct mlx5ctl_fd *mfd = file->private_data;
@@ -352,6 +414,14 @@ static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		err = mlx5ctl_cmdrpc_ioctl(file, argp, size);
 		break;
 
+	case MLX5CTL_IOCTL_UMEM_REG:
+		err = mlx5ctl_ioctl_umem_reg(file, argp, size);
+		break;
+
+	case MLX5CTL_IOCTL_UMEM_UNREG:
+		err = mlx5ctl_ioctl_umem_unreg(file, arg);
+		break;
+
 	default:
 		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
 		err = -ENOIOCTLCMD;
@@ -362,12 +432,21 @@ static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	return err;
 }
 
+static long mlx5ctl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (cmd == MLX5CTL_IOCTL_UMEM_UNREG) /* arg is a scalar */
+		return mlx5ctl_ioctl(file, cmd, arg);
+
+	/* arg is a pointer */
+	return compat_ptr_ioctl(file, cmd, arg);
+}
+
 static const struct file_operations mlx5ctl_fops = {
 	.owner = THIS_MODULE,
 	.open = mlx5ctl_open,
 	.release = mlx5ctl_release,
 	.unlocked_ioctl = mlx5ctl_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
+	.compat_ioctl = mlx5ctl_compat_ioctl,
 };
 
 static int mlx5ctl_probe(struct auxiliary_device *adev,
diff --git a/drivers/misc/mlx5ctl/umem.c b/drivers/misc/mlx5ctl/umem.c
new file mode 100644
index 000000000000..0f13ccffe7e7
--- /dev/null
+++ b/drivers/misc/mlx5ctl/umem.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
+#include <uapi/misc/mlx5ctl.h>
+
+#include "umem.h"
+
+#define MLX5CTL_UMEM_MAX_MB 64
+
+static unsigned long umem_num_pages(u64 addr, size_t len)
+{
+	return DIV_ROUND_UP(addr + len - PAGE_ALIGN_DOWN(addr), PAGE_SIZE);
+}
+
+struct mlx5ctl_umem {
+	struct sg_table sgt;
+	unsigned long addr;
+	size_t size;
+	size_t offset;
+	size_t npages;
+	struct task_struct *source_task;
+	struct mm_struct *source_mm;
+	struct user_struct *source_user;
+	u32 umem_id;
+	struct page **page_list;
+};
+
+struct mlx5ctl_umem_db {
+	struct xarray xarray;
+	struct mlx5_core_dev *mdev;
+	u32 uctx_uid;
+};
+
+static int inc_user_locked_vm(struct mlx5ctl_umem *umem, unsigned long npages)
+{
+	unsigned long lock_limit;
+	unsigned long cur_pages;
+	unsigned long new_pages;
+
+	lock_limit = task_rlimit(umem->source_task, RLIMIT_MEMLOCK) >>
+		     PAGE_SHIFT;
+	do {
+		cur_pages = atomic_long_read(&umem->source_user->locked_vm);
+		new_pages = cur_pages + npages;
+		if (new_pages > lock_limit)
+			return -ENOMEM;
+	} while (atomic_long_cmpxchg(&umem->source_user->locked_vm, cur_pages,
+				     new_pages) != cur_pages);
+	return 0;
+}
+
+static void dec_user_locked_vm(struct mlx5ctl_umem *umem, unsigned long npages)
+{
+	if (WARN_ON(atomic_long_read(&umem->source_user->locked_vm) < npages))
+		return;
+	atomic_long_sub(npages, &umem->source_user->locked_vm);
+}
+
+static struct mlx5ctl_umem *mlx5ctl_umem_pin(struct mlx5ctl_umem_db *umem_db,
+					     unsigned long addr, size_t size)
+{
+	size_t npages = umem_num_pages(addr, size);
+	struct mlx5_core_dev *mdev = umem_db->mdev;
+	unsigned long endaddr = addr + size;
+	struct mlx5ctl_umem *umem;
+	struct page **page_list;
+	int err = -EINVAL;
+	int pinned = 0;
+
+	dev_dbg(mdev->device, "%s: addr %p size %zu npages %zu\n",
+		__func__, (void __user *)addr, size, npages);
+
+	/* Avoid integer overflow */
+	if (endaddr < addr || PAGE_ALIGN(endaddr) < endaddr)
+		return ERR_PTR(-EINVAL);
+
+	if (npages == 0 || pages_to_mb(npages) > MLX5CTL_UMEM_MAX_MB)
+		return ERR_PTR(-EINVAL);
+
+	page_list = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
+	if (!page_list)
+		return ERR_PTR(-ENOMEM);
+
+	umem = kzalloc(sizeof(*umem), GFP_KERNEL_ACCOUNT);
+	if (!umem) {
+		kvfree(page_list);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	umem->addr = addr;
+	umem->size = size;
+	umem->offset = addr & ~PAGE_MASK;
+	umem->npages = npages;
+
+	umem->page_list = page_list;
+	umem->source_mm = current->mm;
+	umem->source_task = current->group_leader;
+	get_task_struct(current->group_leader);
+	umem->source_user = get_uid(current_user());
+
+	/* mm and RLIMIT_MEMLOCK user task accounting similar to what is
+	 * being done in iopt_alloc_pages() and do_update_pinned()
+	 * for IOPT_PAGES_ACCOUNT_USER @drivers/iommu/iommufd/pages.c
+	 */
+	mmgrab(umem->source_mm);
+
+	pinned = pin_user_pages_fast(addr, npages, FOLL_WRITE, page_list);
+	if (pinned != npages) {
+		dev_dbg(mdev->device, "pin_user_pages_fast failed %d\n", pinned);
+		err = pinned < 0 ? pinned : -ENOMEM;
+		goto pin_failed;
+	}
+
+	err = inc_user_locked_vm(umem, npages);
+	if (err)
+		goto pin_failed;
+
+	atomic64_add(npages, &umem->source_mm->pinned_vm);
+
+	err = sg_alloc_table_from_pages(&umem->sgt, page_list, npages, 0,
+					npages << PAGE_SHIFT, GFP_KERNEL_ACCOUNT);
+	if (err) {
+		dev_dbg(mdev->device, "sg_alloc_table failed: %d\n", err);
+		goto sgt_failed;
+	}
+
+	dev_dbg(mdev->device, "\tsgt: size %zu npages %zu sgt.nents (%d)\n",
+		size, npages, umem->sgt.nents);
+
+	err = dma_map_sgtable(mdev->device, &umem->sgt, DMA_BIDIRECTIONAL, 0);
+	if (err) {
+		dev_dbg(mdev->device, "dma_map_sgtable failed: %d\n", err);
+		goto dma_failed;
+	}
+
+	dev_dbg(mdev->device, "\tsgt: dma_nents %d\n", umem->sgt.nents);
+	return umem;
+
+dma_failed:
+sgt_failed:
+	sg_free_table(&umem->sgt);
+	atomic64_sub(npages, &umem->source_mm->pinned_vm);
+	dec_user_locked_vm(umem, npages);
+pin_failed:
+	if (pinned > 0)
+		unpin_user_pages(page_list, pinned);
+	mmdrop(umem->source_mm);
+	free_uid(umem->source_user);
+	put_task_struct(umem->source_task);
+
+	kfree(umem);
+	kvfree(page_list);
+	return ERR_PTR(err);
+}
+
+static void mlx5ctl_umem_unpin(struct mlx5ctl_umem_db *umem_db,
+			       struct mlx5ctl_umem *umem)
+{
+	struct mlx5_core_dev *mdev = umem_db->mdev;
+
+	dev_dbg(mdev->device, "%s: addr %p size %zu npages %zu dma_nents %d\n",
+		__func__, (void *)umem->addr, umem->size, umem->npages,
+		umem->sgt.nents);
+
+	dma_unmap_sgtable(mdev->device, &umem->sgt, DMA_BIDIRECTIONAL, 0);
+	sg_free_table(&umem->sgt);
+
+	atomic64_sub(umem->npages, &umem->source_mm->pinned_vm);
+	dec_user_locked_vm(umem, umem->npages);
+	unpin_user_pages(umem->page_list, umem->npages);
+	mmdrop(umem->source_mm);
+	free_uid(umem->source_user);
+	put_task_struct(umem->source_task);
+
+	kvfree(umem->page_list);
+	kfree(umem);
+}
+
+static int mlx5ctl_umem_create(struct mlx5_core_dev *mdev,
+			       struct mlx5ctl_umem *umem, u32 uid)
+{
+	u32 out[MLX5_ST_SZ_DW(create_umem_out)] = {};
+	int err, inlen, i, n = 0;
+	struct scatterlist *sg;
+	void *in, *umemptr;
+	__be64 *mtt;
+
+	inlen = MLX5_ST_SZ_BYTES(create_umem_in) +
+		umem->npages * MLX5_ST_SZ_BYTES(mtt);
+
+	in = kzalloc(inlen, GFP_KERNEL_ACCOUNT);
+	if (!in)
+		return -ENOMEM;
+
+	MLX5_SET(create_umem_in, in, opcode, MLX5_CMD_OP_CREATE_UMEM);
+	MLX5_SET(create_umem_in, in, uid, uid);
+
+	umemptr = MLX5_ADDR_OF(create_umem_in, in, umem);
+
+	MLX5_SET(umem, umemptr, log_page_size,
+		 PAGE_SHIFT - MLX5_ADAPTER_PAGE_SHIFT);
+	MLX5_SET64(umem, umemptr, num_of_mtt, umem->npages);
+	MLX5_SET(umem, umemptr, page_offset, umem->offset);
+
+	dev_dbg(mdev->device,
+		"UMEM CREATE: log_page_size %d num_of_mtt %lld page_offset %d\n",
+		MLX5_GET(umem, umemptr, log_page_size),
+		MLX5_GET64(umem, umemptr, num_of_mtt),
+		MLX5_GET(umem, umemptr, page_offset));
+
+	mtt = MLX5_ADDR_OF(create_umem_in, in, umem.mtt);
+	for_each_sgtable_dma_sg(&umem->sgt, sg, i) {
+		u64 dma_addr = sg_dma_address(sg);
+		ssize_t len = sg_dma_len(sg);
+
+		for (; n < umem->npages && len > 0; n++, mtt++) {
+			*mtt = cpu_to_be64(dma_addr);
+			MLX5_SET(mtt, mtt, wr_en, 1);
+			MLX5_SET(mtt, mtt, rd_en, 1);
+			dma_addr += PAGE_SIZE;
+			len -= PAGE_SIZE;
+		}
+		WARN_ON_ONCE(n == umem->npages && len > 0);
+	}
+
+	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
+	if (err)
+		goto out;
+
+	umem->umem_id = MLX5_GET(create_umem_out, out, umem_id);
+	dev_dbg(mdev->device, "\tUMEM CREATED: umem_id %d\n", umem->umem_id);
+out:
+	kfree(in);
+	return err;
+}
+
+static void mlx5ctl_umem_destroy(struct mlx5_core_dev *mdev,
+				 struct mlx5ctl_umem *umem)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_umem_in)] = {};
+
+	MLX5_SET(destroy_umem_in, in, opcode, MLX5_CMD_OP_DESTROY_UMEM);
+	MLX5_SET(destroy_umem_in, in, umem_id, umem->umem_id);
+
+	dev_dbg(mdev->device, "UMEM DESTROY: umem_id %d\n", umem->umem_id);
+	mlx5_cmd_exec_in(mdev, destroy_umem, in);
+}
+
+int mlx5ctl_umem_reg(struct mlx5ctl_umem_db *umem_db, unsigned long addr,
+		     size_t size)
+{
+	struct mlx5ctl_umem *umem;
+	void *ret;
+	int err;
+
+	umem = mlx5ctl_umem_pin(umem_db, addr, size);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
+
+	err = mlx5ctl_umem_create(umem_db->mdev, umem, umem_db->uctx_uid);
+	if (err)
+		goto umem_create_err;
+
+	ret = xa_store(&umem_db->xarray, umem->umem_id, umem, GFP_KERNEL_ACCOUNT);
+	if (WARN(xa_is_err(ret), "Failed to store UMEM")) {
+		err = xa_err(ret);
+		goto xa_store_err;
+	}
+
+	return umem->umem_id;
+
+xa_store_err:
+	mlx5ctl_umem_destroy(umem_db->mdev, umem);
+umem_create_err:
+	mlx5ctl_umem_unpin(umem_db, umem);
+	return err;
+}
+
+int mlx5ctl_umem_unreg(struct mlx5ctl_umem_db *umem_db, u32 umem_id)
+{
+	struct mlx5ctl_umem *umem;
+
+	umem = xa_erase(&umem_db->xarray, umem_id);
+	if (!umem)
+		return -ENOENT;
+
+	mlx5ctl_umem_destroy(umem_db->mdev, umem);
+	mlx5ctl_umem_unpin(umem_db, umem);
+	return 0;
+}
+
+struct mlx5ctl_umem_db *mlx5ctl_umem_db_create(struct mlx5_core_dev *mdev,
+					       u32 uctx_uid)
+{
+	struct mlx5ctl_umem_db *umem_db;
+
+	umem_db = kzalloc(sizeof(*umem_db), GFP_KERNEL_ACCOUNT);
+	if (!umem_db)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init(&umem_db->xarray);
+	umem_db->mdev = mdev;
+	umem_db->uctx_uid = uctx_uid;
+
+	return umem_db;
+}
+
+void mlx5ctl_umem_db_destroy(struct mlx5ctl_umem_db *umem_db)
+{
+	struct mlx5ctl_umem *umem;
+	unsigned long index;
+
+	xa_for_each(&umem_db->xarray, index, umem)
+		mlx5ctl_umem_unreg(umem_db, umem->umem_id);
+
+	xa_destroy(&umem_db->xarray);
+	kfree(umem_db);
+}
diff --git a/drivers/misc/mlx5ctl/umem.h b/drivers/misc/mlx5ctl/umem.h
new file mode 100644
index 000000000000..9cf62e5e775e
--- /dev/null
+++ b/drivers/misc/mlx5ctl/umem.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5CTL_UMEM_H__
+#define __MLX5CTL_UMEM_H__
+
+#include <linux/types.h>
+#include <linux/mlx5/driver.h>
+
+struct mlx5ctl_umem_db;
+
+struct mlx5ctl_umem_db *mlx5ctl_umem_db_create(struct mlx5_core_dev *mdev, u32 uctx_uid);
+void mlx5ctl_umem_db_destroy(struct mlx5ctl_umem_db *umem_db);
+int mlx5ctl_umem_reg(struct mlx5ctl_umem_db *umem_db, unsigned long addr, size_t size);
+int mlx5ctl_umem_unreg(struct mlx5ctl_umem_db *umem_db, u32 umem_id);
+
+#endif /* __MLX5CTL_UMEM_H__ */
diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
index 3277eaf78a37..eaf6c954a1ff 100644
--- a/include/uapi/misc/mlx5ctl.h
+++ b/include/uapi/misc/mlx5ctl.h
@@ -24,6 +24,16 @@ struct mlx5ctl_cmdrpc {
 	__aligned_u64 flags;
 };
 
+struct mlx5ctl_umem_reg {
+	__aligned_u64 flags;
+	__u32 size;
+	__u32 reserved1;
+	__aligned_u64 addr; /* user address */
+	__aligned_u64 len; /* user buffer length */
+	__u32 umem_id; /* returned device's umem ID */
+	__u32 reserved2;
+};
+
 #define MLX5CTL_MAX_RPC_SIZE 8192
 
 #define MLX5CTL_IOCTL_MAGIC 0x5c
@@ -34,4 +44,10 @@ struct mlx5ctl_cmdrpc {
 #define MLX5CTL_IOCTL_CMDRPC \
 	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x1, struct mlx5ctl_cmdrpc)
 
+#define MLX5CTL_IOCTL_UMEM_REG \
+	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x2, struct mlx5ctl_umem_reg)
+
+#define MLX5CTL_IOCTL_UMEM_UNREG \
+	_IO(MLX5CTL_IOCTL_MAGIC, 0x3)
+
 #endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.41.0

