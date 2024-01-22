Return-Path: <linux-kernel+bounces-32456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0B0835BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0062286DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598FC24A1C;
	Mon, 22 Jan 2024 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XimPzqj8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0D21108
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909491; cv=none; b=Moh67EJ4lYF52DkB3nCW8Ja3B9eBG2VcXBAgrk8tER11fu4HyggOyqLrhr1Ivw3Cdt3Mp/f5wHYv1Fz8Gvh8GlGl78jFtFOBjiZ6MAV/e9hTyspV6ckCCiLtFpaSP5BXr4qR4sx6l6TvGWP6wIEYW3Cx0zDEKUE7JXD5mTos/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909491; c=relaxed/simple;
	bh=BJ+FMIw8p1K/Crff1Micy6NmyOR5TM9iue+/mV6svUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0uYmq/7pC++sNv8LnW/Ltyk3bAay/CpgUrplEd/SneqNPZlxijypL5vyMkAogzCIwlLONI9DyIUlOb0gKfTUTw5z5YXW6tLrEccsIQmU6yrip1GQUL3ZfUWTWdeIY9RywtoShvj5r5G2LWYAJlDOnsYd9pOico9CLC7JvVNEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XimPzqj8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909489; x=1737445489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BJ+FMIw8p1K/Crff1Micy6NmyOR5TM9iue+/mV6svUY=;
  b=XimPzqj82jz7M25AudcM3m2xVpeUbxZMs9iDcWBMbCTtzDuyORoJyKqf
   ixinioS2Ce4gOLgD4oDRJ85gX6dsNqw19qp1gdF6GozOYOmjoMrsrpBjR
   4fSyoQM2bDoBB+FKIiD555gvYzkFvQkzwgr96vViqwRAkTbqo/tD8ICBR
   7xwtcP6cssL9wYy8i4w+6k212tC2PdNtSHlBZ2g4Vq+MgabGlLfRK3QTq
   CQggKBBlZQqWCbShI0p3dyDL4BILCendde3SIzoxGa3e3KSlujBkzURzB
   L6Mcp3I/i2o4itu7Tg9jFoOcSRWKeCO3PndLowKwzVeVqEiDjcdFmYd1/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611580"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611580"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778504996"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778504996"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 4/8] iommufd: Add iommufd fault object
Date: Mon, 22 Jan 2024 15:38:59 +0800
Message-Id: <20240122073903.24406-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122073903.24406-1-baolu.lu@linux.intel.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iommufd fault object provides an interface for delivering I/O page
faults to user space. These objects are created and destroyed by user
space, and they can be associated with or dissociated from hardware page
table objects during page table allocation or destruction.

User space interacts with the fault object through a file interface. This
interface offers a straightforward and efficient way for user space to
handle page faults. It allows user space to read fault messages
sequentially and respond to them by writing to the same file. The file
interface supports reading messages in poll mode, so it's recommended that
user space applications use io_uring to enhance read and write efficiency.

A fault object can be associated with any iopf-capable iommufd_hw_pgtable
during the pgtable's allocation. All I/O page faults triggered by devices
when accessing the I/O addresses of an iommufd_hw_pgtable are routed
through the fault object to user space. Similarly, user space's responses
to these page faults are routed back to the iommu device driver through
the same fault object.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                   |   2 +
 drivers/iommu/iommufd/iommufd_private.h |  23 +++
 include/uapi/linux/iommufd.h            |  18 ++
 drivers/iommu/iommufd/device.c          |   1 +
 drivers/iommu/iommufd/fault.c           | 255 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   6 +
 drivers/iommu/iommufd/Makefile          |   1 +
 7 files changed, 306 insertions(+)
 create mode 100644 drivers/iommu/iommufd/fault.c

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 511dc7b4bdb2..4372648ac22e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -145,6 +145,8 @@ struct iopf_group {
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
 	struct iopf_attach_cookie *cookie;
+	/* Used by handler provider to hook the group on its own lists. */
+	struct list_head node;
 };
 
 /**
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..52d83e888bd0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -128,6 +128,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+	IOMMUFD_OBJ_FAULT,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -395,6 +396,8 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	/* outstanding faults awaiting response indexed by fault group id */
+	struct xarray faults;
 };
 
 static inline struct iommufd_device *
@@ -426,6 +429,26 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/*
+ * An iommufd_fault object represents an interface to deliver I/O page faults
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with hardware page table objects during page-table allocation.
+ */
+struct iommufd_fault {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+
+	/* The lists of outstanding faults protected by below mutex. */
+	struct mutex mutex;
+	struct list_head deliver;
+	struct list_head response;
+
+	struct wait_queue_head wait_queue;
+};
+
+int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_fault_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d59e839ae49e..c32d62b02306 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -50,6 +50,7 @@ enum {
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_FAULT_ALLOC,
 };
 
 /**
@@ -759,4 +760,21 @@ struct iommu_hwpt_page_response {
 	__u32 code;
 	__u64 addr;
 };
+
+/**
+ * struct iommu_fault_alloc - ioctl(IOMMU_FAULT_ALLOC)
+ * @size: sizeof(struct iommu_fault_alloc)
+ * @flags: Must be 0
+ * @out_fault_id: The ID of the new FAULT
+ * @out_fault_fd: The fd of the new FAULT
+ *
+ * Explicitly allocate a fault handling object.
+ */
+struct iommu_fault_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 out_fault_id;
+	__u32 out_fault_fd;
+};
+#define IOMMU_FAULT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..d70913ee8fdf 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -215,6 +215,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	xa_init(&idev->faults);
 
 	/*
 	 * If the caller fails after this success it must call
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
new file mode 100644
index 000000000000..9844a85feeb2
--- /dev/null
+++ b/drivers/iommu/iommufd/fault.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation
+ */
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/iommufd.h>
+#include <linux/poll.h>
+#include <linux/anon_inodes.h>
+#include <uapi/linux/iommufd.h>
+
+#include "iommufd_private.h"
+
+static int device_add_fault(struct iopf_group *group)
+{
+	struct iommufd_device *idev = group->cookie->private;
+	void *curr;
+
+	curr = xa_cmpxchg(&idev->faults, group->last_fault.fault.prm.grpid,
+			  NULL, group, GFP_KERNEL);
+
+	return curr ? xa_err(curr) : 0;
+}
+
+static void device_remove_fault(struct iopf_group *group)
+{
+	struct iommufd_device *idev = group->cookie->private;
+
+	xa_store(&idev->faults, group->last_fault.fault.prm.grpid,
+		 NULL, GFP_KERNEL);
+}
+
+static struct iopf_group *device_get_fault(struct iommufd_device *idev,
+					   unsigned long grpid)
+{
+	return xa_load(&idev->faults, grpid);
+}
+
+void iommufd_fault_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iopf_group *group, *next;
+
+	mutex_lock(&fault->mutex);
+	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+		list_del(&group->node);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	list_for_each_entry_safe(group, next, &fault->response, node) {
+		list_del(&group->node);
+		device_remove_fault(group);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	mutex_unlock(&fault->mutex);
+
+	mutex_destroy(&fault->mutex);
+}
+
+static void iommufd_compose_fault_message(struct iommu_fault *fault,
+					  struct iommu_hwpt_pgfault *hwpt_fault,
+					  struct iommufd_device *idev)
+{
+	hwpt_fault->size = sizeof(*hwpt_fault);
+	hwpt_fault->flags = fault->prm.flags;
+	hwpt_fault->dev_id = idev->obj.id;
+	hwpt_fault->pasid = fault->prm.pasid;
+	hwpt_fault->grpid = fault->prm.grpid;
+	hwpt_fault->perm = fault->prm.perm;
+	hwpt_fault->addr = fault->prm.addr;
+}
+
+static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
+	struct iommufd_fault *fault = filep->private_data;
+	struct iommu_hwpt_pgfault data;
+	struct iommufd_device *idev;
+	struct iopf_group *group;
+	struct iopf_fault *iopf;
+	size_t done = 0;
+	int rc;
+
+	if (*ppos || count % fault_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->deliver) && count > done) {
+		group = list_first_entry(&fault->deliver,
+					 struct iopf_group, node);
+
+		if (list_count_nodes(&group->faults) * fault_size > count - done)
+			break;
+
+		idev = (struct iommufd_device *)group->cookie->private;
+		list_for_each_entry(iopf, &group->faults, list) {
+			iommufd_compose_fault_message(&iopf->fault, &data, idev);
+			rc = copy_to_user(buf + done, &data, fault_size);
+			if (rc)
+				goto err_unlock;
+			done += fault_size;
+		}
+
+		rc = device_add_fault(group);
+		if (rc)
+			goto err_unlock;
+
+		list_move_tail(&group->node, &fault->response);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done;
+err_unlock:
+	mutex_unlock(&fault->mutex);
+	return rc;
+}
+
+static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	size_t response_size = sizeof(struct iommu_hwpt_page_response);
+	struct iommufd_fault *fault = filep->private_data;
+	struct iommu_hwpt_page_response response;
+	struct iommufd_device *idev;
+	struct iopf_group *group;
+	size_t done = 0;
+	int rc;
+
+	if (*ppos || count % response_size)
+		return -ESPIPE;
+
+	while (!list_empty(&fault->response) && count > done) {
+		rc = copy_from_user(&response, buf + done, response_size);
+		if (rc)
+			break;
+
+		idev = container_of(iommufd_get_object(fault->ictx,
+						       response.dev_id,
+						       IOMMUFD_OBJ_DEVICE),
+				    struct iommufd_device, obj);
+		if (IS_ERR(idev))
+			break;
+
+		group = device_get_fault(idev, response.grpid);
+		if (!group ||
+		    response.addr != group->last_fault.fault.prm.addr ||
+		    ((group->last_fault.fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
+		      response.pasid != group->last_fault.fault.prm.pasid)) {
+			iommufd_put_object(fault->ictx, &idev->obj);
+			break;
+		}
+
+		iopf_group_response(group, response.code);
+
+		mutex_lock(&fault->mutex);
+		list_del(&group->node);
+		mutex_unlock(&fault->mutex);
+
+		device_remove_fault(group);
+		iopf_free_group(group);
+		done += response_size;
+
+		iommufd_put_object(fault->ictx, &idev->obj);
+	}
+
+	return done;
+}
+
+static __poll_t iommufd_fault_fops_poll(struct file *filep,
+					struct poll_table_struct *wait)
+{
+	struct iommufd_fault *fault = filep->private_data;
+	__poll_t pollflags = 0;
+
+	poll_wait(filep, &fault->wait_queue, wait);
+	mutex_lock(&fault->mutex);
+	if (!list_empty(&fault->deliver))
+		pollflags = EPOLLIN | EPOLLRDNORM;
+	mutex_unlock(&fault->mutex);
+
+	return pollflags;
+}
+
+static const struct file_operations iommufd_fault_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nonseekable_open,
+	.read		= iommufd_fault_fops_read,
+	.write		= iommufd_fault_fops_write,
+	.poll		= iommufd_fault_fops_poll,
+	.llseek		= no_llseek,
+};
+
+static int get_fault_fd(struct iommufd_fault *fault)
+{
+	struct file *filep;
+	int fdno;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		return fdno;
+
+	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
+				   fault, O_RDWR);
+	if (IS_ERR(filep)) {
+		put_unused_fd(fdno);
+		return PTR_ERR(filep);
+	}
+
+	fd_install(fdno, filep);
+
+	return fdno;
+}
+
+int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_fault_alloc *cmd = ucmd->cmd;
+	struct iommufd_fault *fault;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
+	if (IS_ERR(fault))
+		return PTR_ERR(fault);
+
+	fault->ictx = ucmd->ictx;
+	INIT_LIST_HEAD(&fault->deliver);
+	INIT_LIST_HEAD(&fault->response);
+	mutex_init(&fault->mutex);
+	init_waitqueue_head(&fault->wait_queue);
+
+	rc = get_fault_fd(fault);
+	if (rc < 0)
+		goto out_abort;
+
+	cmd->out_fault_id = fault->obj.id;
+	cmd->out_fault_fd = rc;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &fault->obj);
+
+	return 0;
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
+
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 39b32932c61e..792db077d33e 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -332,6 +332,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_fault_alloc fault;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -381,6 +382,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_FAULT_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
+		 out_fault_fd),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -513,6 +516,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
+	[IOMMUFD_OBJ_FAULT] = {
+		.destroy = iommufd_fault_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 34b446146961..b94a74366eed 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -6,6 +6,7 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
+	fault.o \
 	vfio_compat.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
-- 
2.34.1


