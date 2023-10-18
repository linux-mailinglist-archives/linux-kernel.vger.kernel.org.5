Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702277CD645
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjJRIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjJRIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:20:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB2FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D91CC433C8;
        Wed, 18 Oct 2023 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617225;
        bh=3i3+doLFvzlAfHeafN/PxeF54arnKvsliH5HQmE+QCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=un3d2nsjBx7ZW3me7tYYwktCtIGqEr0RKSuvdNmT/eKIamkNJMNwkK8cqBAGJNtyH
         UREoncbnVmu8hZ5cbncWQSe2Lf41HWuNCZqTitbFc2dPATfkjJj6GEGWVX5F0PeiVf
         MyJsc+1pqEDDnVNulSs/XIa44jl8g+BOYDoIWAadqQtQ3KtLr7Iqj85FtHvBNHIQaE
         lFH63q5zUVjEFmICkTZovlAOdlS2PFSH3WY9sSZT2KzZ3vLIRcbCm2N55vD4uq5aE5
         zudQhVSC46UJax8Zso78FNIkaACzsySUzEohH96ifYuJ0mOUnJ+GnrUdYJuxxF1i+E
         rzybnLITLKb4g==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Date:   Wed, 18 Oct 2023 01:19:41 -0700
Message-ID: <20231018081941.475277-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018081941.475277-1-saeed@kernel.org>
References: <20231018081941.475277-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

$ mlx5ctl mlx5_core.ctl.0 coredump --umem_size=$(( 2 ** 20 ))

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

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/misc/mlx5ctl/Makefile |   1 +
 drivers/misc/mlx5ctl/main.c   |  49 +++++
 drivers/misc/mlx5ctl/umem.c   | 325 ++++++++++++++++++++++++++++++++++
 drivers/misc/mlx5ctl/umem.h   |  17 ++
 include/uapi/misc/mlx5ctl.h   |  14 ++
 5 files changed, 406 insertions(+)
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
index 5f4edcc3e112..d4d72689f6e9 100644
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
 
@@ -322,6 +333,36 @@ static int mlx5ctl_cmdrpc_ioctl(struct file *file, void __user *arg, size_t usiz
 	return err;
 }
 
+static ssize_t mlx5ctl_ioctl_umem_reg(struct file *file, unsigned long arg)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_umem_reg umem_reg;
+	int umem_id;
+
+	if (copy_from_user(&umem_reg, (void __user *)arg, sizeof(umem_reg)))
+		return -EFAULT;
+
+	umem_id = mlx5ctl_umem_reg(mfd->umem_db, (unsigned long)umem_reg.addr, umem_reg.len);
+	if (umem_id < 0)
+		return umem_id;
+
+	umem_reg.umem_id = umem_id;
+
+	if (copy_to_user((void __user *)arg, &umem_reg, sizeof(umem_reg))) {
+		mlx5ctl_umem_unreg(mfd->umem_db, umem_id);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static size_t mlx5ctl_ioctl_umem_unreg(struct file *file, unsigned long arg)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+
+	return mlx5ctl_umem_unreg(mfd->umem_db, (u32)arg);
+}
+
 static ssize_t mlx5ctl_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -352,6 +393,14 @@ static ssize_t mlx5ctl_ioctl(struct file *file, unsigned int cmd,
 		err = mlx5ctl_cmdrpc_ioctl(file, argp, size);
 		break;
 
+	case MLX5CTL_IOCTL_UMEM_REG:
+		err = mlx5ctl_ioctl_umem_reg(file, arg);
+		break;
+
+	case MLX5CTL_IOCTL_UMEM_UNREG:
+		err = mlx5ctl_ioctl_umem_unreg(file, arg);
+		break;
+
 	default:
 		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
 		err = -ENOIOCTLCMD;
diff --git a/drivers/misc/mlx5ctl/umem.c b/drivers/misc/mlx5ctl/umem.c
new file mode 100644
index 000000000000..c21b54d24762
--- /dev/null
+++ b/drivers/misc/mlx5ctl/umem.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
+#include <uapi/misc/mlx5ctl.h>
+
+#include "umem.h"
+
+#define umem_dbg(__mdev, fmt, ...) \
+	dev_dbg((__mdev)->device, "mlx5ctl_umem: " fmt, ##__VA_ARGS__)
+
+#define MLX5CTL_UMEM_MAX_MB 64
+
+static size_t umem_num_pages(u64 addr, size_t len)
+{
+	return (size_t)((ALIGN(addr + len, PAGE_SIZE) -
+			 ALIGN_DOWN(addr, PAGE_SIZE))) /
+			 PAGE_SIZE;
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
+	umem_dbg(mdev, "%s: addr %p size %zu npages %zu\n",
+		 __func__, (void *)addr, size, npages);
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
+		umem_dbg(mdev, "pin_user_pages_fast failed %d\n", pinned);
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
+		umem_dbg(mdev, "sg_alloc_table failed: %d\n", err);
+		goto sgt_failed;
+	}
+
+	umem_dbg(mdev, "\tsgt: size %zu npages %zu sgt.nents (%d)\n",
+		 size, npages, umem->sgt.nents);
+
+	err = dma_map_sgtable(mdev->device, &umem->sgt, DMA_BIDIRECTIONAL, 0);
+	if (err) {
+		umem_dbg(mdev, "dma_map_sgtable failed: %d\n", err);
+		goto dma_failed;
+	}
+
+	umem_dbg(mdev, "\tsgt: dma_nents %d\n", umem->sgt.nents);
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
+	umem_dbg(mdev, "%s: addr %p size %zu npages %zu dma_nents %d\n",
+		 __func__, (void *)umem->addr, umem->size, umem->npages,
+		 umem->sgt.nents);
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
+	umem_dbg(mdev,
+		 "UMEM CREATE: log_page_size %d num_of_mtt %lld page_offset %d\n",
+		 MLX5_GET(umem, umemptr, log_page_size),
+		 MLX5_GET64(umem, umemptr, num_of_mtt),
+		 MLX5_GET(umem, umemptr, page_offset));
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
+	umem_dbg(mdev, "\tUMEM CREATED: umem_id %d\n", umem->umem_id);
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
+	umem_dbg(mdev, "UMEM DESTROY: umem_id %d\n", umem->umem_id);
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
index 000000000000..880bf66e600d
--- /dev/null
+++ b/drivers/misc/mlx5ctl/umem.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
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
index 49c26ccc2d21..c0960ad1a8f0 100644
--- a/include/uapi/misc/mlx5ctl.h
+++ b/include/uapi/misc/mlx5ctl.h
@@ -24,6 +24,14 @@ struct mlx5ctl_cmdrpc {
 	__aligned_u64 flags;
 };
 
+struct mlx5ctl_umem_reg {
+	__aligned_u64 addr; /* user address */
+	__aligned_u64 len; /* user buffer length */
+	__aligned_u64 flags;
+	__u32 umem_id; /* returned device's umem ID */
+	__u32 reserved[7];
+};
+
 #define MLX5CTL_MAX_RPC_SIZE 8192
 
 #define MLX5CTL_IOCTL_MAGIC 0x5c
@@ -34,4 +42,10 @@ struct mlx5ctl_cmdrpc {
 #define MLX5CTL_IOCTL_CMDRPC \
 	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x1, struct mlx5ctl_cmdrpc)
 
+#define MLX5CTL_IOCTL_UMEM_REG \
+	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x2, struct mlx5ctl_umem_reg)
+
+#define MLX5CTL_IOCTL_UMEM_UNREG \
+	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x3, unsigned long)
+
 #endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.41.0

