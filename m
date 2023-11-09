Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67DA7E732E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbjKIVD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjKIVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:03:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BB3C07;
        Thu,  9 Nov 2023 13:03:22 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E340DAF2;
        Thu,  9 Nov 2023 22:02:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563778;
        bh=ZCd7ad5zBI1M6eKH1J7qAH7P5HGDDLrYzAMe4zLwNJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QInSkm1wtqXI3ltHib/WoAQyKBCaNbJPiA/YqH8FNxmlwaOBPzshjm2s8DoyRMUwT
         P7v+ekioPMszZ0s0h1gTT+aNh3eg2wv2WKM0YXW4/0Tjz5HND0nMb7dzAv26h7ZIeV
         eU1O5k8JLqTfsHfZykJf2hWX9sDv8W1sxMtc0Bmk=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 01/15] staging: vc04_services: Add new vc-sm-cma driver
Date:   Thu,  9 Nov 2023 16:02:53 -0500
Message-ID: <20231109210309.638594-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

Add Broadcom VideoCore Shared Memory support.

This new driver allows contiguous memory blocks to be imported
into the VideoCore VPU memory map, and manages the lifetime of
those objects, only releasing the source dmabuf once the VPU has
confirmed it has finished with it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/Kconfig         |   2 +
 drivers/staging/vc04_services/Makefile        |   2 +-
 .../staging/vc04_services/vc-sm-cma/Kconfig   |  10 +
 .../staging/vc04_services/vc-sm-cma/Makefile  |   4 +
 .../staging/vc04_services/vc-sm-cma/vc_sm.c   | 817 ++++++++++++++++++
 .../staging/vc04_services/vc-sm-cma/vc_sm.h   |  54 ++
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  | 507 +++++++++++
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.h  |  63 ++
 .../vc04_services/vc-sm-cma/vc_sm_defs.h      | 187 ++++
 .../vc04_services/vc-sm-cma/vc_sm_knl.h       |  28 +
 10 files changed, 1673 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Kconfig
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/Makefile
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h
 create mode 100644 drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 31e58c9d1a11..6c0e77d64376 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -46,5 +46,7 @@ source "drivers/staging/vc04_services/bcm2835-camera/Kconfig"
 
 source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
 
+source "drivers/staging/vc04_services/vc-sm-cma/Kconfig"
+
 endif
 
diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index e8b897a7b9a6..1f61a263f22d 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -15,4 +15,4 @@ endif
 obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
-
+obj-$(CONFIG_BCM_VC_SM_CMA)		+= vc-sm-cma/
diff --git a/drivers/staging/vc04_services/vc-sm-cma/Kconfig b/drivers/staging/vc04_services/vc-sm-cma/Kconfig
new file mode 100644
index 000000000000..bbd296f5826b
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/Kconfig
@@ -0,0 +1,10 @@
+config BCM_VC_SM_CMA
+	tristate "VideoCore Shared Memory (CMA) driver"
+	depends on BCM2835_VCHIQ
+	select RBTREE
+	select DMA_SHARED_BUFFER
+	help
+	  Say Y here to enable the shared memory interface that
+	  supports sharing dmabufs with VideoCore.
+	  This operates over the VCHIQ interface to a service
+	  running on VideoCore.
diff --git a/drivers/staging/vc04_services/vc-sm-cma/Makefile b/drivers/staging/vc04_services/vc-sm-cma/Makefile
new file mode 100644
index 000000000000..98c8ed6c9a50
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/Makefile
@@ -0,0 +1,4 @@
+vc-sm-cma-$(CONFIG_BCM_VC_SM_CMA) := \
+	vc_sm.o vc_sm_cma_vchi.o
+
+obj-$(CONFIG_BCM_VC_SM_CMA) += vc-sm-cma.o
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
new file mode 100644
index 000000000000..5bbdb3a8468b
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
@@ -0,0 +1,817 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VideoCore Shared Memory driver using CMA.
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ * Dave Stevenson <dave.stevenson@raspberrypi.com>
+ *
+ * Based on vmcs_sm driver from Broadcom Corporation for some API,
+ * and taking some code for buffer allocation and dmabuf handling from
+ * videobuf2.
+ *
+ * This driver handles taking a dmabuf, mapping it into the VPU address space,
+ * and returning a handle that the VPU can use.
+ */
+
+/* ---- Include Files ----------------------------------------------------- */
+#include <linux/debugfs.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/miscdevice.h>
+#include <linux/syscalls.h>
+
+#include "../interface/vchiq_arm/vchiq_bus.h"
+#include "../interface/vchiq_arm/vchiq_connected.h"
+#include "vc_sm_cma_vchi.h"
+
+#include "vc_sm.h"
+#include "vc_sm_knl.h"
+
+MODULE_IMPORT_NS(DMA_BUF);
+
+/* ---- Private Constants and Types --------------------------------------- */
+
+#define VC_SM_RESOURCE_NAME_DEFAULT       "sm-host-resource"
+
+#define VC_SM_DIR_ROOT_NAME	"vcsm-cma"
+#define VC_SM_STATE		"state"
+
+/* Private file data associated with each opened device. */
+struct vc_sm_privdata_t {
+};
+
+typedef int (*VC_SM_SHOW) (struct seq_file *s, void *v);
+struct sm_pde_t {
+	VC_SM_SHOW show;          /* Debug fs function hookup. */
+	struct dentry *dir_entry; /* Debug fs directory entry. */
+	void *priv_data;          /* Private data */
+};
+
+/* Global state information. */
+struct sm_state_t {
+	struct vchiq_device *device;
+
+	struct miscdevice misc_dev;
+
+	struct sm_instance *sm_handle;	/* Handle for videocore service. */
+
+	spinlock_t kernelid_map_lock;	/* Spinlock protecting kernelid_map */
+	struct idr kernelid_map;
+
+	struct mutex map_lock;          /* Global map lock. */
+	struct list_head buffer_list;	/* List of buffer. */
+
+	struct dentry *dir_root;	/* Debug fs entries root. */
+	struct sm_pde_t dir_state;	/* Debug fs entries state sub-tree. */
+
+	bool require_released_callback;	/* VPU will send a released msg when it
+					 * has finished with a resource.
+					 */
+	/* State for transactions */
+	int restart_sys;                /* Tracks restart on interrupt. */
+	enum vc_sm_msg_type int_action; /* Interrupted action. */
+
+	u32 int_trans_id;		/* Interrupted transaction. */
+	struct vchiq_instance *vchiq_instance;
+};
+
+struct vc_sm_dma_buf_attachment {
+	struct device *dev;
+	struct sg_table sg_table;
+	struct list_head list;
+	enum dma_data_direction	dma_dir;
+};
+
+/* ---- Private Variables ----------------------------------------------- */
+
+static struct sm_state_t *sm_state;
+static int sm_inited;
+
+/* ---- Private Function Prototypes -------------------------------------- */
+
+/* ---- Private Functions ------------------------------------------------ */
+
+static int get_kernel_id(struct vc_sm_buffer *buffer)
+{
+	int handle;
+
+	spin_lock(&sm_state->kernelid_map_lock);
+	handle = idr_alloc(&sm_state->kernelid_map, buffer, 0, 0, GFP_KERNEL);
+	spin_unlock(&sm_state->kernelid_map_lock);
+
+	return handle;
+}
+
+static struct vc_sm_buffer *lookup_kernel_id(int handle)
+{
+	return idr_find(&sm_state->kernelid_map, handle);
+}
+
+static void free_kernel_id(int handle)
+{
+	spin_lock(&sm_state->kernelid_map_lock);
+	idr_remove(&sm_state->kernelid_map, handle);
+	spin_unlock(&sm_state->kernelid_map_lock);
+}
+
+static int vc_sm_cma_seq_file_show(struct seq_file *s, void *v)
+{
+	struct sm_pde_t *sm_pde;
+
+	sm_pde = (struct sm_pde_t *)(s->private);
+
+	if (sm_pde && sm_pde->show)
+		sm_pde->show(s, v);
+
+	return 0;
+}
+
+static int vc_sm_cma_single_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, vc_sm_cma_seq_file_show, inode->i_private);
+}
+
+static const struct file_operations vc_sm_cma_debug_fs_fops = {
+	.open = vc_sm_cma_single_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int vc_sm_cma_global_state_show(struct seq_file *s, void *v)
+{
+	struct vc_sm_buffer *resource = NULL;
+	int resource_count = 0;
+
+	if (!sm_state)
+		return 0;
+
+	seq_printf(s, "\nVC-ServiceHandle     %p\n", sm_state->sm_handle);
+
+	/* Log all applicable mapping(s). */
+
+	mutex_lock(&sm_state->map_lock);
+	seq_puts(s, "\nResources\n");
+	if (!list_empty(&sm_state->buffer_list)) {
+		list_for_each_entry(resource, &sm_state->buffer_list,
+				    global_buffer_list) {
+			resource_count++;
+
+			seq_printf(s, "\nResource                %p\n",
+				   resource);
+			seq_printf(s, "           NAME         %s\n",
+				   resource->name);
+			seq_printf(s, "           SIZE         %zu\n",
+				   resource->size);
+			seq_printf(s, "           DMABUF       %p\n",
+				   resource->dma_buf);
+			seq_printf(s, "           IMPORTED_DMABUF %p\n",
+				   resource->imported_dma_buf);
+			seq_printf(s, "           ATTACH       %p\n",
+				   resource->attach);
+			seq_printf(s, "           SGT          %p\n",
+				   resource->sgt);
+			seq_printf(s, "           DMA_ADDR     %pad\n",
+				   &resource->dma_addr);
+			seq_printf(s, "           VC_HANDLE     %08x\n",
+				   resource->vc_handle);
+			seq_printf(s, "           VC_MAPPING    %d\n",
+				   resource->vpu_state);
+		}
+	}
+	seq_printf(s, "\n\nTotal resource count:   %d\n\n", resource_count);
+
+	mutex_unlock(&sm_state->map_lock);
+
+	return 0;
+}
+
+/*
+ * Adds a buffer to the private data list which tracks all the allocated
+ * data.
+ */
+static void vc_sm_add_resource(struct vc_sm_buffer *buffer)
+{
+	mutex_lock(&sm_state->map_lock);
+	list_add(&buffer->global_buffer_list, &sm_state->buffer_list);
+	mutex_unlock(&sm_state->map_lock);
+
+	dev_dbg(&sm_state->device->dev,"[%s]: added buffer %p (name %s, size %zu)\n",
+		 __func__, buffer, buffer->name, buffer->size);
+}
+
+/*
+ * Cleans up imported dmabuf.
+ * Should be called with mutex held.
+ */
+static void vc_sm_clean_up_dmabuf(struct vc_sm_buffer *buffer)
+{
+	/* Handle cleaning up imported dmabufs */
+	if (buffer->sgt) {
+		dma_buf_unmap_attachment_unlocked(buffer->attach, buffer->sgt,
+						  DMA_BIDIRECTIONAL);
+		buffer->sgt = NULL;
+	}
+	if (buffer->attach) {
+		dma_buf_detach(buffer->imported_dma_buf, buffer->attach);
+		buffer->attach = NULL;
+	}
+}
+
+/*
+ * Instructs VPU to decrement the refcount on a buffer.
+ */
+static void vc_sm_vpu_free(struct vc_sm_buffer *buffer)
+{
+	if (buffer->vc_handle && buffer->vpu_state == VPU_MAPPED) {
+		struct vc_sm_free_t free = { buffer->vc_handle, 0 };
+		int status = vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
+					     &sm_state->int_trans_id);
+		if (status != 0 && status != -EINTR) {
+			dev_err(&sm_state->device->dev,
+				"[%s]: failed to free memory on videocore (status: %u, trans_id: %u)\n",
+			       __func__, status, sm_state->int_trans_id);
+		}
+
+		if (sm_state->require_released_callback) {
+			/* Need to wait for the VPU to confirm the free. */
+
+			/* Retain a reference on this until the VPU has
+			 * released it
+			 */
+			buffer->vpu_state = VPU_UNMAPPING;
+		} else {
+			buffer->vpu_state = VPU_NOT_MAPPED;
+			buffer->vc_handle = 0;
+		}
+	}
+}
+
+/*
+ * Release an allocation.
+ * All refcounting is done via the dma buf object.
+ *
+ * Must be called with the mutex held. The function will either release the
+ * mutex (if defering the release) or destroy it. The caller must therefore not
+ * reuse the buffer on return.
+ */
+static void vc_sm_release_resource(struct vc_sm_buffer *buffer)
+{
+	dev_dbg(&sm_state->device->dev, "[%s]: buffer %p (name %s, size %zu)\n",
+		 __func__, buffer, buffer->name, buffer->size);
+
+	if (buffer->vc_handle) {
+		/* We've sent the unmap request but not had the response. */
+		dev_dbg(&sm_state->device->dev, "[%s]: Waiting for VPU unmap response on %p\n",
+			 __func__, buffer);
+		goto defer;
+	}
+	if (buffer->in_use) {
+		/* dmabuf still in use - we await the release */
+		dev_dbg(&sm_state->device->dev, "[%s]: buffer %p is still in use\n",
+			__func__, buffer);
+		goto defer;
+	}
+
+	/* Release the allocation */
+	if (buffer->imported_dma_buf)
+		dma_buf_put(buffer->imported_dma_buf);
+	else
+		dev_err(&sm_state->device->dev, "%s: Imported dmabuf already been put for buf %p\n",
+		       __func__, buffer);
+	buffer->imported_dma_buf = NULL;
+
+	/* Free our buffer. Start by removing it from the list */
+	mutex_lock(&sm_state->map_lock);
+	list_del(&buffer->global_buffer_list);
+	mutex_unlock(&sm_state->map_lock);
+
+	dev_dbg(&sm_state->device->dev, "%s: Release our allocation - done\n", __func__);
+	mutex_unlock(&buffer->lock);
+
+	mutex_destroy(&buffer->lock);
+
+	kfree(buffer);
+	return;
+
+defer:
+	mutex_unlock(&buffer->lock);
+}
+
+/* Dma_buf operations for chaining through to an imported dma_buf */
+
+static void vc_sm_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct vc_sm_buffer *buffer;
+
+	if (!dmabuf)
+		return;
+
+	buffer = (struct vc_sm_buffer *)dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
+
+	dev_dbg(&sm_state->device->dev, "%s dmabuf %p, buffer %p\n", __func__, dmabuf, buffer);
+
+	buffer->in_use = 0;
+
+	/* Unmap on the VPU */
+	vc_sm_vpu_free(buffer);
+	dev_dbg(&sm_state->device->dev, "%s vpu_free done\n", __func__);
+
+	/* Unmap our dma_buf object (the vc_sm_buffer remains until released
+	 * on the VPU).
+	 */
+	vc_sm_clean_up_dmabuf(buffer);
+	dev_dbg(&sm_state->device->dev, "%s clean_up dmabuf done\n", __func__);
+
+	/* buffer->lock will be destroyed by vc_sm_release_resource if finished
+	 * with, otherwise unlocked. Do NOT unlock here.
+	 */
+	vc_sm_release_resource(buffer);
+	dev_dbg(&sm_state->device->dev, "%s done\n", __func__);
+}
+
+static
+int vc_sm_import_dma_buf_attach(struct dma_buf *dmabuf,
+				struct dma_buf_attachment *attachment)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	return buf->imported_dma_buf->ops->attach(buf->imported_dma_buf,
+						attachment);
+}
+
+static
+void vc_sm_import_dma_buf_detatch(struct dma_buf *dmabuf,
+				  struct dma_buf_attachment *attachment)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	buf->imported_dma_buf->ops->detach(buf->imported_dma_buf, attachment);
+}
+
+static
+struct sg_table *vc_sm_import_map_dma_buf(struct dma_buf_attachment *attachment,
+					  enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = attachment->dmabuf->priv;
+
+	return buf->imported_dma_buf->ops->map_dma_buf(attachment,
+						     direction);
+}
+
+static
+void vc_sm_import_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				struct sg_table *table,
+				enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = attachment->dmabuf->priv;
+
+	buf->imported_dma_buf->ops->unmap_dma_buf(attachment, table, direction);
+}
+
+static
+int vc_sm_import_dmabuf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	dev_dbg(&sm_state->device->dev, "%s: mmap dma_buf %p, buf %p, imported db %p\n", __func__,
+		dmabuf, buf, buf->imported_dma_buf);
+
+	return buf->imported_dma_buf->ops->mmap(buf->imported_dma_buf, vma);
+}
+
+static
+int vc_sm_import_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
+					  enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	return buf->imported_dma_buf->ops->begin_cpu_access(buf->imported_dma_buf,
+							  direction);
+}
+
+static
+int vc_sm_import_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
+					enum dma_data_direction direction)
+{
+	struct vc_sm_buffer *buf = dmabuf->priv;
+
+	return buf->imported_dma_buf->ops->end_cpu_access(buf->imported_dma_buf,
+							  direction);
+}
+
+static const struct dma_buf_ops dma_buf_import_ops = {
+	.map_dma_buf = vc_sm_import_map_dma_buf,
+	.unmap_dma_buf = vc_sm_import_unmap_dma_buf,
+	.mmap = vc_sm_import_dmabuf_mmap,
+	.release = vc_sm_dma_buf_release,
+	.attach = vc_sm_import_dma_buf_attach,
+	.detach = vc_sm_import_dma_buf_detatch,
+	.begin_cpu_access = vc_sm_import_dma_buf_begin_cpu_access,
+	.end_cpu_access = vc_sm_import_dma_buf_end_cpu_access,
+};
+
+/* Import a dma_buf to be shared with VC. */
+int
+vc_sm_cma_import_dmabuf_internal(struct sm_state_t *state,
+				 struct dma_buf *dma_buf,
+				 int fd,
+				 struct dma_buf **imported_buf)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct vc_sm_buffer *buffer = NULL;
+	struct vc_sm_import import = { };
+	struct vc_sm_import_result result = { };
+	struct dma_buf_attachment *attach = NULL;
+	struct sg_table *sgt = NULL;
+	dma_addr_t dma_addr;
+	int ret = 0;
+	int status;
+
+	/* Setup our allocation parameters */
+	dev_dbg(&sm_state->device->dev, "%s: importing dma_buf %p/fd %d\n", __func__, dma_buf, fd);
+
+	if (fd < 0)
+		get_dma_buf(dma_buf);
+	else
+		dma_buf = dma_buf_get(fd);
+
+	if (!dma_buf)
+		return -EINVAL;
+
+	attach = dma_buf_attach(dma_buf, &sm_state->device->dev);
+	if (IS_ERR(attach)) {
+		ret = PTR_ERR(attach);
+		goto error;
+	}
+
+	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto error;
+	}
+
+	/* Verify that the address block is contiguous */
+	if (sgt->nents != 1) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Allocate local buffer to track this allocation. */
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	import.type = VC_SM_ALLOC_NON_CACHED;
+	dma_addr = sg_dma_address(sgt->sgl);
+	import.addr = (u32)dma_addr;
+	if ((import.addr & 0xC0000000) != 0xC0000000) {
+		dev_err(&sm_state->device->dev, "%s: Expecting an uncached alias for dma_addr %pad\n",
+		       __func__, &dma_addr);
+		import.addr |= 0xC0000000;
+	}
+	import.size = sg_dma_len(sgt->sgl);
+	import.allocator = current->tgid;
+	import.kernel_id = get_kernel_id(buffer);
+
+	memcpy(import.name, VC_SM_RESOURCE_NAME_DEFAULT,
+	       sizeof(VC_SM_RESOURCE_NAME_DEFAULT));
+
+	dev_dbg(&sm_state->device->dev,
+		"[%s]: attempt to import \"%s\" data - type %u, addr %pad, size %u.\n",
+		__func__, import.name, import.type, &dma_addr, import.size);
+
+	/* Allocate the videocore buffer. */
+	status = vc_sm_cma_vchi_import(sm_state->sm_handle, &import, &result,
+				       &sm_state->int_trans_id);
+	if (status == -EINTR) {
+		dev_dbg(&sm_state->device->dev,
+			"[%s]: requesting import memory action restart (trans_id: %u)\n",
+			 __func__, sm_state->int_trans_id);
+		ret = -ERESTARTSYS;
+		sm_state->restart_sys = -EINTR;
+		sm_state->int_action = VC_SM_MSG_TYPE_IMPORT;
+		goto error;
+	} else if (status || !result.res_handle) {
+		dev_dbg(&sm_state->device->dev,
+			"[%s]: failed to import memory on videocore (status: %u, trans_id: %u)\n",
+			__func__, status, sm_state->int_trans_id);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	mutex_init(&buffer->lock);
+	INIT_LIST_HEAD(&buffer->attachments);
+	memcpy(buffer->name, import.name,
+	       min(sizeof(buffer->name), sizeof(import.name) - 1));
+
+	/* Keep track of the buffer we created. */
+	buffer->vc_handle = result.res_handle;
+	buffer->size = import.size;
+	buffer->vpu_state = VPU_MAPPED;
+
+	buffer->imported_dma_buf = dma_buf;
+
+	buffer->attach = attach;
+	buffer->sgt = sgt;
+	buffer->dma_addr = dma_addr;
+	buffer->in_use = 1;
+	buffer->kernel_id = import.kernel_id;
+
+	/*
+	 * We're done - we need to export a new dmabuf chaining through most
+	 * functions, but enabling us to release our own internal references
+	 * here.
+	 */
+	exp_info.ops = &dma_buf_import_ops;
+	exp_info.size = import.size;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = buffer;
+
+	buffer->dma_buf = dma_buf_export(&exp_info);
+	if (IS_ERR(buffer->dma_buf)) {
+		ret = PTR_ERR(buffer->dma_buf);
+		goto error;
+	}
+
+	vc_sm_add_resource(buffer);
+
+	*imported_buf = buffer->dma_buf;
+
+	return 0;
+
+error:
+	if (result.res_handle) {
+		struct vc_sm_free_t free = { result.res_handle, 0 };
+
+		vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
+				    &sm_state->int_trans_id);
+	}
+	free_kernel_id(import.kernel_id);
+	kfree(buffer);
+	if (sgt)
+		dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
+	if (attach)
+		dma_buf_detach(dma_buf, attach);
+	dma_buf_put(dma_buf);
+	return ret;
+}
+
+static void
+vc_sm_vpu_event(struct sm_instance *instance, struct vc_sm_result_t *reply,
+		int reply_len)
+{
+	switch (reply->trans_id & ~0x80000000) {
+	case VC_SM_MSG_TYPE_CLIENT_VERSION:
+	{
+		/* Acknowledge that the firmware supports the version command */
+		dev_dbg(&sm_state->device->dev,
+			"%s: firmware acked version msg. Require release cb\n", __func__);
+		sm_state->require_released_callback = true;
+	}
+	break;
+	case VC_SM_MSG_TYPE_RELEASED:
+	{
+		struct vc_sm_released *release = (struct vc_sm_released *)reply;
+		struct vc_sm_buffer *buffer =
+					lookup_kernel_id(release->kernel_id);
+		if (!buffer) {
+			dev_err(&sm_state->device->dev,
+				"%s: VC released a buffer that is already released, kernel_id %d\n",
+			       __func__, release->kernel_id);
+			break;
+		}
+		mutex_lock(&buffer->lock);
+
+		dev_dbg(&sm_state->device->dev,
+			"%s: Released addr %08x, size %u, id %08x, mem_handle %08x\n",
+			__func__, release->addr, release->size,
+			release->kernel_id, release->vc_handle);
+
+		buffer->vc_handle = 0;
+		buffer->vpu_state = VPU_NOT_MAPPED;
+		free_kernel_id(release->kernel_id);
+
+		vc_sm_release_resource(buffer);
+	}
+	break;
+	default:
+		dev_err(&sm_state->device->dev, "%s: Unknown vpu cmd %x\n",
+			__func__, reply->trans_id);
+		break;
+	}
+}
+
+/* Driver load/unload functions */
+/* Videocore connected.  */
+static void vc_sm_connected_init(void)
+{
+	int ret;
+	struct vc_sm_version version;
+	struct vc_sm_result_t version_result;
+
+	pr_info("[%s]: start\n", __func__);
+
+	/*
+	 * Initialize and create a VCHI connection for the shared memory service
+	 * running on videocore.
+	 */
+	ret = vchiq_initialise(&sm_state->vchiq_instance);
+	if (ret) {
+		dev_err(&sm_state->device->dev, "[%s]: failed to initialise VCHI instance (ret=%d)\n",
+			__func__, ret);
+
+		return;
+	}
+
+	ret = vchiq_connect(sm_state->vchiq_instance);
+	if (ret) {
+		dev_err(&sm_state->device->dev, "[%s]: failed to connect VCHI instance (ret=%d)\n",
+			__func__, ret);
+
+		return;
+	}
+
+	/* Initialize an instance of the shared memory service. */
+	sm_state->sm_handle = vc_sm_cma_vchi_init(sm_state->vchiq_instance, 1,
+						  vc_sm_vpu_event);
+	if (!sm_state->sm_handle) {
+		dev_err(&sm_state->device->dev,
+			"[%s]: failed to initialize shared memory service\n", __func__);
+
+		return;
+	}
+
+	/* Create a debug fs directory entry (root). */
+	sm_state->dir_root = debugfs_create_dir(VC_SM_DIR_ROOT_NAME, NULL);
+
+	sm_state->dir_state.show = &vc_sm_cma_global_state_show;
+	sm_state->dir_state.dir_entry =
+		debugfs_create_file(VC_SM_STATE, 0444, sm_state->dir_root,
+				    &sm_state->dir_state,
+				    &vc_sm_cma_debug_fs_fops);
+
+	INIT_LIST_HEAD(&sm_state->buffer_list);
+
+	version.version = 2;
+	ret = vc_sm_cma_vchi_client_version(sm_state->sm_handle, &version,
+					    &version_result,
+					    &sm_state->int_trans_id);
+	if (ret) {
+		dev_err(&sm_state->device->dev,
+			"[%s]: Failed to send version request %d\n", __func__, ret);
+	}
+
+	/* Done! */
+	sm_inited = 1;
+	pr_info("[%s]: installed successfully\n", __func__);
+}
+
+/* Driver loading. */
+static int bcm2835_vc_sm_cma_probe(struct vchiq_device *device)
+{
+	struct device *dev = &device->dev;
+	int err;
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(dev, "dma_set_mask_and_coherent failed: %d\n", err);
+		return err;
+	}
+
+	sm_state = devm_kzalloc(dev, sizeof(*sm_state), GFP_KERNEL);
+	if (!sm_state)
+		return -ENOMEM;
+	sm_state->device = device;
+	mutex_init(&sm_state->map_lock);
+
+	spin_lock_init(&sm_state->kernelid_map_lock);
+	idr_init_base(&sm_state->kernelid_map, 1);
+
+	dev->dma_parms = devm_kzalloc(dev, sizeof(dev->dma_parms), GFP_KERNEL);
+
+	/* dma_set_max_seg_size checks if dma_parms is NULL. */
+	dma_set_max_seg_size(dev, 0x3FFFFFFF);
+
+	vchiq_add_connected_callback(vc_sm_connected_init);
+	return 0;
+}
+
+/* Driver unloading. */
+static void bcm2835_vc_sm_cma_remove(struct vchiq_device *device)
+{
+	if (sm_inited) {
+		misc_deregister(&sm_state->misc_dev);
+
+		/* Remove all proc entries. */
+		debugfs_remove_recursive(sm_state->dir_root);
+
+		/* Stop the videocore shared memory service. */
+		vc_sm_cma_vchi_stop(sm_state->vchiq_instance, &sm_state->sm_handle);
+	}
+
+	if (sm_state) {
+		idr_destroy(&sm_state->kernelid_map);
+
+		/* Free the memory for the state structure. */
+		mutex_destroy(&sm_state->map_lock);
+	}
+}
+
+/* Kernel API calls */
+/* Get an internal resource handle mapped from the external one. */
+int vc_sm_cma_int_handle(void *handle)
+{
+	struct dma_buf *dma_buf = (struct dma_buf *)handle;
+	struct vc_sm_buffer *buf;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !handle) {
+		dev_err(&sm_state->device->dev, "[%s]: invalid input\n", __func__);
+		return 0;
+	}
+
+	buf = (struct vc_sm_buffer *)dma_buf->priv;
+	return buf->vc_handle;
+}
+EXPORT_SYMBOL_GPL(vc_sm_cma_int_handle);
+
+/* Free a previously allocated shared memory handle and block. */
+int vc_sm_cma_free(void *handle)
+{
+	struct dma_buf *dma_buf = (struct dma_buf *)handle;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !handle) {
+		dev_err(&sm_state->device->dev, "[%s]: invalid input\n", __func__);
+		return -EPERM;
+	}
+
+	dev_dbg(&sm_state->device->dev, "%s: handle %p/dmabuf %p\n", __func__, handle, dma_buf);
+
+	dma_buf_put(dma_buf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vc_sm_cma_free);
+
+/* Import a dmabuf to be shared with VC. */
+int vc_sm_cma_import_dmabuf(struct dma_buf *src_dmabuf, void **handle)
+{
+	struct dma_buf *new_dma_buf;
+	int ret;
+
+	/* Validate we can work with this device. */
+	if (!sm_state || !src_dmabuf || !handle) {
+		dev_err(&sm_state->device->dev, "[%s]: invalid input\n", __func__);
+		return -EPERM;
+	}
+
+	ret = vc_sm_cma_import_dmabuf_internal(sm_state, src_dmabuf,
+					       -1, &new_dma_buf);
+
+	if (!ret) {
+		dev_dbg(&sm_state->device->dev, "%s: imported to ptr %p\n",
+			__func__, new_dma_buf);
+
+		/* Assign valid handle at this time.*/
+		*handle = new_dma_buf;
+	} else {
+		/*
+		 * succeeded in importing the dma_buf, but then
+		 * failed to look it up again. How?
+		 * Release the fd again.
+		 */
+		dev_err(&sm_state->device->dev, "%s: imported vc_sm_cma_get_buffer failed %d\n",
+			__func__, ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vc_sm_cma_import_dmabuf);
+
+static struct vchiq_device_id device_id_table[] = {
+        { .name = "vcsm-cma" },
+        {}
+};
+MODULE_DEVICE_TABLE(vchiq, device_id_table);
+
+static struct vchiq_driver bcm2835_vcsm_cma_driver = {
+	.probe = bcm2835_vc_sm_cma_probe,
+	.remove = bcm2835_vc_sm_cma_remove,
+	.id_table = device_id_table,
+	.driver = {
+		   .name = "vcsm-cma",
+	},
+};
+
+module_vchiq_driver(bcm2835_vcsm_cma_driver);
+
+MODULE_AUTHOR("Dave Stevenson");
+MODULE_DESCRIPTION("VideoCore CMA Shared Memory Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
new file mode 100644
index 000000000000..61e110ec414d
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory driver using CMA.
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ *
+ */
+
+#ifndef VC_SM_H
+#define VC_SM_H
+
+#define VC_SM_MAX_NAME_LEN 32
+
+enum vc_sm_vpu_mapping_state {
+	VPU_NOT_MAPPED,
+	VPU_MAPPED,
+	VPU_UNMAPPING
+};
+
+struct vc_sm_buffer {
+	struct list_head global_buffer_list;	/* Global list of buffers. */
+
+	/* Index in the kernel_id idr so that we can find the
+	 * mmal_msg_context again when servicing the VCHI reply.
+	 */
+	int kernel_id;
+
+	size_t size;
+
+	/* Lock over all the following state for this buffer */
+	struct mutex lock;
+	struct list_head attachments;
+
+	char name[VC_SM_MAX_NAME_LEN];
+
+	int in_use:1;	/* Kernel is still using this resource */
+
+	enum vc_sm_vpu_mapping_state vpu_state;
+	u32 vc_handle;	/* VideoCore handle for this buffer */
+
+	/* DMABUF related fields */
+	struct dma_buf *dma_buf;
+	dma_addr_t dma_addr;
+	void *cookie;
+
+	struct vc_sm_privdata_t *private;
+
+	struct dma_buf *imported_dma_buf;
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
+};
+
+#endif
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
new file mode 100644
index 000000000000..08f70e955acf
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ * Copyright 2011-2012 Broadcom Corporation.  All rights reserved.
+ *
+ * Based on vmcs_sm driver from Broadcom Corporation.
+ *
+ */
+
+/* ---- Include Files ----------------------------------------------------- */
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/semaphore.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "vc_sm_cma_vchi.h"
+
+#define VC_SM_VER  1
+#define VC_SM_MIN_VER 0
+
+/* ---- Private Constants and Types -------------------------------------- */
+
+/* Command blocks come from a pool */
+#define SM_MAX_NUM_CMD_RSP_BLKS 32
+
+/* The number of supported connections */
+#define SM_MAX_NUM_CONNECTIONS 3
+
+struct sm_cmd_rsp_blk {
+	struct list_head head;	/* To create lists */
+	/* To be signaled when the response is there */
+	struct completion cmplt;
+
+	u32 id;
+	u16 length;
+
+	u8 msg[VC_SM_MAX_MSG_LEN];
+
+	uint32_t wait:1;
+	uint32_t sent:1;
+	uint32_t alloc:1;
+
+};
+
+struct sm_instance {
+	u32 num_connections;
+	unsigned int service_handle[SM_MAX_NUM_CONNECTIONS];
+	struct task_struct *io_thread;
+	struct completion io_cmplt;
+
+	vpu_event_cb vpu_event;
+
+	/* Mutex over the following lists */
+	struct mutex lock;
+	u32 trans_id;
+	struct list_head cmd_list;
+	struct list_head rsp_list;
+	struct list_head dead_list;
+
+	struct sm_cmd_rsp_blk free_blk[SM_MAX_NUM_CMD_RSP_BLKS];
+
+	/* Mutex over the free_list */
+	struct mutex free_lock;
+	struct list_head free_list;
+
+	struct semaphore free_sema;
+	struct vchiq_instance *vchiq_instance;
+};
+
+/* ---- Private Variables ------------------------------------------------ */
+
+/* ---- Private Function Prototypes -------------------------------------- */
+
+/* ---- Private Functions ------------------------------------------------ */
+static int
+bcm2835_vchi_msg_queue(struct vchiq_instance *vchiq_instance, unsigned int handle,
+		       void *data,
+		       unsigned int size)
+{
+	return vchiq_queue_kernel_message(vchiq_instance, handle, data, size);
+}
+
+static struct
+sm_cmd_rsp_blk *vc_vchi_cmd_create(struct sm_instance *instance,
+				   enum vc_sm_msg_type id, void *msg,
+				   u32 size, int wait)
+{
+	struct sm_cmd_rsp_blk *blk;
+	struct vc_sm_msg_hdr_t *hdr;
+
+	if (down_interruptible(&instance->free_sema)) {
+		blk = kmalloc(sizeof(*blk), GFP_KERNEL);
+		if (!blk)
+			return NULL;
+
+		blk->alloc = 1;
+		init_completion(&blk->cmplt);
+	} else {
+		mutex_lock(&instance->free_lock);
+		blk =
+		    list_first_entry(&instance->free_list,
+				     struct sm_cmd_rsp_blk, head);
+		list_del(&blk->head);
+		mutex_unlock(&instance->free_lock);
+	}
+
+	blk->sent = 0;
+	blk->wait = wait;
+	blk->length = sizeof(*hdr) + size;
+
+	hdr = (struct vc_sm_msg_hdr_t *)blk->msg;
+	hdr->type = id;
+	mutex_lock(&instance->lock);
+	instance->trans_id++;
+	/*
+	 * Retain the top bit for identifying asynchronous events, or VPU cmds.
+	 */
+	instance->trans_id &= ~0x80000000;
+	hdr->trans_id = instance->trans_id;
+	blk->id = instance->trans_id;
+	mutex_unlock(&instance->lock);
+
+	if (size)
+		memcpy(hdr->body, msg, size);
+
+	return blk;
+}
+
+static void
+vc_vchi_cmd_delete(struct sm_instance *instance, struct sm_cmd_rsp_blk *blk)
+{
+	if (blk->alloc) {
+		kfree(blk);
+		return;
+	}
+
+	mutex_lock(&instance->free_lock);
+	list_add(&blk->head, &instance->free_list);
+	mutex_unlock(&instance->free_lock);
+	up(&instance->free_sema);
+}
+
+static void vc_sm_cma_vchi_rx_ack(struct sm_instance *instance,
+				  struct sm_cmd_rsp_blk *cmd,
+				  struct vc_sm_result_t *reply,
+				  u32 reply_len)
+{
+	mutex_lock(&instance->lock);
+	list_for_each_entry(cmd,
+			    &instance->rsp_list,
+			    head) {
+		if (cmd->id == reply->trans_id)
+			break;
+	}
+	mutex_unlock(&instance->lock);
+
+	if (&cmd->head == &instance->rsp_list) {
+		//pr_debug("%s: received response %u, throw away...",
+		pr_err("%s: received response %u, throw away...",
+		       __func__,
+		       reply->trans_id);
+	} else if (reply_len > sizeof(cmd->msg)) {
+		pr_err("%s: reply too big (%u) %u, throw away...",
+		       __func__, reply_len,
+		     reply->trans_id);
+	} else {
+		memcpy(cmd->msg, reply,
+		       reply_len);
+		complete(&cmd->cmplt);
+	}
+}
+
+static int vc_sm_cma_vchi_videocore_io(void *arg)
+{
+	struct sm_instance *instance = arg;
+	struct sm_cmd_rsp_blk *cmd = NULL, *cmd_tmp;
+	struct vc_sm_result_t *reply;
+	struct vchiq_header *header;
+	s32 status;
+	int svc_use = 1;
+
+	while (1) {
+		if (svc_use)
+			vchiq_release_service(instance->vchiq_instance,
+					      instance->service_handle[0]);
+		svc_use = 0;
+
+		if (wait_for_completion_interruptible(&instance->io_cmplt))
+			continue;
+		vchiq_use_service(instance->vchiq_instance, instance->service_handle[0]);
+		svc_use = 1;
+
+		do {
+			/*
+			 * Get new command and move it to response list
+			 */
+			mutex_lock(&instance->lock);
+			if (list_empty(&instance->cmd_list)) {
+				/* no more commands to process */
+				mutex_unlock(&instance->lock);
+				break;
+			}
+			cmd = list_first_entry(&instance->cmd_list,
+					       struct sm_cmd_rsp_blk, head);
+			list_move(&cmd->head, &instance->rsp_list);
+			cmd->sent = 1;
+			mutex_unlock(&instance->lock);
+			/* Send the command */
+			status =
+				bcm2835_vchi_msg_queue(instance->vchiq_instance,
+						       instance->service_handle[0],
+						       cmd->msg, cmd->length);
+			if (status) {
+				pr_err("%s: failed to queue message (%d)",
+				       __func__, status);
+			}
+
+			/* If no reply is needed then we're done */
+			if (!cmd->wait) {
+				mutex_lock(&instance->lock);
+				list_del(&cmd->head);
+				mutex_unlock(&instance->lock);
+				vc_vchi_cmd_delete(instance, cmd);
+				continue;
+			}
+
+			if (status) {
+				complete(&cmd->cmplt);
+				continue;
+			}
+
+		} while (1);
+
+		while ((header = vchiq_msg_hold(instance->vchiq_instance,
+						instance->service_handle[0]))) {
+			reply = (struct vc_sm_result_t *)header->data;
+			if (reply->trans_id & 0x80000000) {
+				/* Async event or cmd from the VPU */
+				if (instance->vpu_event)
+					instance->vpu_event(instance, reply,
+							    header->size);
+			} else {
+				vc_sm_cma_vchi_rx_ack(instance, cmd, reply,
+						      header->size);
+			}
+
+			vchiq_release_message(instance->vchiq_instance,
+					      instance->service_handle[0],
+					      header);
+		}
+
+		/* Go through the dead list and free them */
+		mutex_lock(&instance->lock);
+		list_for_each_entry_safe(cmd, cmd_tmp, &instance->dead_list,
+					 head) {
+			list_del(&cmd->head);
+			vc_vchi_cmd_delete(instance, cmd);
+		}
+		mutex_unlock(&instance->lock);
+	}
+
+	return 0;
+}
+
+static int vc_sm_cma_vchi_callback(struct vchiq_instance *vchiq_instance,
+				   enum vchiq_reason reason,
+				   struct vchiq_header *header,
+				   unsigned int handle, void *userdata)
+{
+	struct sm_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
+
+	switch (reason) {
+	case VCHIQ_MESSAGE_AVAILABLE:
+		vchiq_msg_queue_push(vchiq_instance, handle, header);
+		complete(&instance->io_cmplt);
+		break;
+
+	case VCHIQ_SERVICE_CLOSED:
+		pr_info("%s: service CLOSED!!", __func__);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
+					unsigned int num_connections,
+					vpu_event_cb vpu_event)
+{
+	u32 i;
+	struct sm_instance *instance;
+	int status;
+
+	pr_debug("%s: start", __func__);
+
+	if (num_connections > SM_MAX_NUM_CONNECTIONS) {
+		pr_err("%s: unsupported number of connections %u (max=%u)",
+		       __func__, num_connections, SM_MAX_NUM_CONNECTIONS);
+
+		goto err_null;
+	}
+	/* Allocate memory for this instance */
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
+
+	/* Misc initialisations */
+	mutex_init(&instance->lock);
+	init_completion(&instance->io_cmplt);
+	INIT_LIST_HEAD(&instance->cmd_list);
+	INIT_LIST_HEAD(&instance->rsp_list);
+	INIT_LIST_HEAD(&instance->dead_list);
+	INIT_LIST_HEAD(&instance->free_list);
+	sema_init(&instance->free_sema, SM_MAX_NUM_CMD_RSP_BLKS);
+	mutex_init(&instance->free_lock);
+	for (i = 0; i < SM_MAX_NUM_CMD_RSP_BLKS; i++) {
+		init_completion(&instance->free_blk[i].cmplt);
+		list_add(&instance->free_blk[i].head, &instance->free_list);
+	}
+
+	instance->vchiq_instance = vchiq_instance;
+
+	/* Open the VCHI service connections */
+	instance->num_connections = num_connections;
+	for (i = 0; i < num_connections; i++) {
+		struct vchiq_service_params_kernel params = {
+			.version = VC_SM_VER,
+			.version_min = VC_SM_MIN_VER,
+			.fourcc = VCHIQ_MAKE_FOURCC('S', 'M', 'E', 'M'),
+			.callback = vc_sm_cma_vchi_callback,
+			.userdata = instance,
+		};
+
+		status = vchiq_open_service(vchiq_instance, &params,
+					    &instance->service_handle[i]);
+		if (status) {
+			pr_err("%s: failed to open VCHI service (%d)",
+			       __func__, status);
+
+			goto err_close_services;
+		}
+	}
+	/* Create the thread which takes care of all io to/from videoocore. */
+	instance->io_thread = kthread_create(&vc_sm_cma_vchi_videocore_io,
+					     (void *)instance, "SMIO");
+	if (!instance->io_thread) {
+		pr_err("%s: failed to create SMIO thread", __func__);
+
+		goto err_close_services;
+	}
+	instance->vpu_event = vpu_event;
+	set_user_nice(instance->io_thread, -10);
+	wake_up_process(instance->io_thread);
+
+	pr_debug("%s: success - instance %p", __func__, instance);
+	return instance;
+
+err_close_services:
+	for (i = 0; i < instance->num_connections; i++) {
+		if (instance->service_handle[i])
+			vchiq_close_service(vchiq_instance, instance->service_handle[i]);
+	}
+	kfree(instance);
+err_null:
+	pr_debug("%s: FAILED", __func__);
+	return NULL;
+}
+
+int vc_sm_cma_vchi_stop(struct vchiq_instance *vchiq_instance, struct sm_instance **handle)
+{
+	struct sm_instance *instance;
+	u32 i;
+
+	if (!handle) {
+		pr_err("%s: invalid pointer to handle %p", __func__, handle);
+		goto lock;
+	}
+
+	if (!*handle) {
+		pr_err("%s: invalid handle %p", __func__, *handle);
+		goto lock;
+	}
+
+	instance = *handle;
+
+	/* Close all VCHI service connections */
+	for (i = 0; i < instance->num_connections; i++) {
+		vchiq_use_service(vchiq_instance, instance->service_handle[i]);
+		vchiq_close_service(vchiq_instance, instance->service_handle[i]);
+	}
+
+	kfree(instance);
+
+	*handle = NULL;
+	return 0;
+
+lock:
+	return -EINVAL;
+}
+
+static int vc_sm_cma_vchi_send_msg(struct sm_instance *handle,
+				   enum vc_sm_msg_type msg_id, void *msg,
+				   u32 msg_size, void *result, u32 result_size,
+				   u32 *cur_trans_id, u8 wait_reply)
+{
+	int status = 0;
+	struct sm_instance *instance = handle;
+	struct sm_cmd_rsp_blk *cmd_blk;
+
+	if (!handle) {
+		pr_err("%s: invalid handle", __func__);
+		return -EINVAL;
+	}
+	if (!msg) {
+		pr_err("%s: invalid msg pointer", __func__);
+		return -EINVAL;
+	}
+
+	cmd_blk =
+	    vc_vchi_cmd_create(instance, msg_id, msg, msg_size, wait_reply);
+	if (!cmd_blk) {
+		pr_err("[%s]: failed to allocate global tracking resource",
+		       __func__);
+		return -ENOMEM;
+	}
+
+	if (cur_trans_id)
+		*cur_trans_id = cmd_blk->id;
+
+	mutex_lock(&instance->lock);
+	list_add_tail(&cmd_blk->head, &instance->cmd_list);
+	mutex_unlock(&instance->lock);
+	complete(&instance->io_cmplt);
+
+	if (!wait_reply)
+		/* We're done */
+		return 0;
+
+	/* Wait for the response */
+	if (wait_for_completion_interruptible(&cmd_blk->cmplt)) {
+		mutex_lock(&instance->lock);
+		if (!cmd_blk->sent) {
+			list_del(&cmd_blk->head);
+			mutex_unlock(&instance->lock);
+			vc_vchi_cmd_delete(instance, cmd_blk);
+			return -ENXIO;
+		}
+
+		list_move(&cmd_blk->head, &instance->dead_list);
+		mutex_unlock(&instance->lock);
+		complete(&instance->io_cmplt);
+		return -EINTR;	/* We're done */
+	}
+
+	if (result && result_size) {
+		memcpy(result, cmd_blk->msg, result_size);
+	} else {
+		struct vc_sm_result_t *res =
+			(struct vc_sm_result_t *)cmd_blk->msg;
+		status = (res->success == 0) ? 0 : -ENXIO;
+	}
+
+	mutex_lock(&instance->lock);
+	list_del(&cmd_blk->head);
+	mutex_unlock(&instance->lock);
+	vc_vchi_cmd_delete(instance, cmd_blk);
+	return status;
+}
+
+int vc_sm_cma_vchi_free(struct sm_instance *handle, struct vc_sm_free_t *msg,
+			u32 *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_FREE,
+				   msg, sizeof(*msg), 0, 0, cur_trans_id, 0);
+}
+
+int vc_sm_cma_vchi_import(struct sm_instance *handle, struct vc_sm_import *msg,
+			  struct vc_sm_import_result *result, u32 *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_IMPORT,
+				   msg, sizeof(*msg), result, sizeof(*result),
+				   cur_trans_id, 1);
+}
+
+int vc_sm_cma_vchi_client_version(struct sm_instance *handle,
+				  struct vc_sm_version *msg,
+				  struct vc_sm_result_t *result,
+				  u32 *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle, VC_SM_MSG_TYPE_CLIENT_VERSION,
+				   //msg, sizeof(*msg), result, sizeof(*result),
+				   //cur_trans_id, 1);
+				   msg, sizeof(*msg), NULL, 0,
+				   cur_trans_id, 0);
+}
+
+int vc_sm_vchi_client_vc_mem_req_reply(struct sm_instance *handle,
+				       struct vc_sm_vc_mem_request_result *msg,
+				       uint32_t *cur_trans_id)
+{
+	return vc_sm_cma_vchi_send_msg(handle,
+				       VC_SM_MSG_TYPE_VC_MEM_REQUEST_REPLY,
+				       msg, sizeof(*msg), 0, 0, cur_trans_id,
+				       0);
+}
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
new file mode 100644
index 000000000000..5dd23ad408fc
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ * Copyright 2011-2012 Broadcom Corporation.  All rights reserved.
+ *
+ * Based on vmcs_sm driver from Broadcom Corporation.
+ *
+ */
+
+#ifndef __VC_SM_CMA_VCHI_H__INCLUDED__
+#define __VC_SM_CMA_VCHI_H__INCLUDED__
+
+#include "../include/linux/raspberrypi/vchiq.h"
+
+#include "vc_sm_defs.h"
+
+/*
+ * Forward declare.
+ */
+struct sm_instance;
+
+typedef void (*vpu_event_cb)(struct sm_instance *instance,
+			     struct vc_sm_result_t *reply, int reply_len);
+
+/*
+ * Initialize the shared memory service, opens up vchi connection to talk to it.
+ */
+struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchi_instance,
+					unsigned int num_connections,
+					vpu_event_cb vpu_event);
+
+/*
+ * Terminates the shared memory service.
+ */
+int vc_sm_cma_vchi_stop(struct vchiq_instance *vchi_instance, struct sm_instance **handle);
+
+/*
+ * Ask the shared memory service to free up some memory that was previously
+ * allocated by the vc_sm_cma_vchi_alloc function call.
+ */
+int vc_sm_cma_vchi_free(struct sm_instance *handle, struct vc_sm_free_t *msg,
+			u32 *cur_trans_id);
+
+/*
+ * Import a contiguous block of memory and wrap it in a GPU MEM_HANDLE_T.
+ */
+int vc_sm_cma_vchi_import(struct sm_instance *handle, struct vc_sm_import *msg,
+			  struct vc_sm_import_result *result,
+			  u32 *cur_trans_id);
+
+int vc_sm_cma_vchi_client_version(struct sm_instance *handle,
+				  struct vc_sm_version *msg,
+				  struct vc_sm_result_t *result,
+				  u32 *cur_trans_id);
+
+int vc_sm_vchi_client_vc_mem_req_reply(struct sm_instance *handle,
+				       struct vc_sm_vc_mem_request_result *msg,
+				       uint32_t *cur_trans_id);
+
+#endif /* __VC_SM_CMA_VCHI_H__INCLUDED__ */
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h
new file mode 100644
index 000000000000..ad4a3ec194d3
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_defs.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ *
+ * Based on vc_sm_defs.h from the vmcs_sm driver Copyright Broadcom Corporation.
+ * All IPC messages are copied across to this file, even if the vc-sm-cma
+ * driver is not currently using them.
+ *
+ ****************************************************************************
+ */
+
+#ifndef __VC_SM_DEFS_H__INCLUDED__
+#define __VC_SM_DEFS_H__INCLUDED__
+
+/* Maximum message length */
+#define VC_SM_MAX_MSG_LEN (sizeof(union vc_sm_msg_union_t) + \
+	sizeof(struct vc_sm_msg_hdr_t))
+#define VC_SM_MAX_RSP_LEN (sizeof(union vc_sm_msg_union_t))
+
+/* Resource name maximum size */
+#define VC_SM_RESOURCE_NAME 32
+
+/*
+ * Version to be reported to the VPU
+ * VPU assumes 0 (aka 1) which does not require the released callback, nor
+ * expect the client to handle VC_MEM_REQUESTS.
+ * Version 2 requires the released callback, and must support VC_MEM_REQUESTS.
+ */
+#define VC_SM_PROTOCOL_VERSION	2
+
+enum vc_sm_msg_type {
+	/* Message types supported for HOST->VC direction */
+
+	/* Allocate shared memory block */
+	VC_SM_MSG_TYPE_ALLOC,
+	/* Lock allocated shared memory block */
+	VC_SM_MSG_TYPE_LOCK,
+	/* Unlock allocated shared memory block */
+	VC_SM_MSG_TYPE_UNLOCK,
+	/* Unlock allocated shared memory block, do not answer command */
+	VC_SM_MSG_TYPE_UNLOCK_NOANS,
+	/* Free shared memory block */
+	VC_SM_MSG_TYPE_FREE,
+	/* Resize a shared memory block */
+	VC_SM_MSG_TYPE_RESIZE,
+	/* Walk the allocated shared memory block(s) */
+	VC_SM_MSG_TYPE_WALK_ALLOC,
+
+	/* A previously applied action will need to be reverted */
+	VC_SM_MSG_TYPE_ACTION_CLEAN,
+
+	/*
+	 * Import a physical address and wrap into a MEM_HANDLE_T.
+	 * Release with VC_SM_MSG_TYPE_FREE.
+	 */
+	VC_SM_MSG_TYPE_IMPORT,
+	/*
+	 *Tells VC the protocol version supported by this client.
+	 * 2 supports the async/cmd messages from the VPU for final release
+	 * of memory, and for VC allocations.
+	 */
+	VC_SM_MSG_TYPE_CLIENT_VERSION,
+	/* Response to VC request for memory */
+	VC_SM_MSG_TYPE_VC_MEM_REQUEST_REPLY,
+
+	/*
+	 * Asynchronous/cmd messages supported for VC->HOST direction.
+	 * Signalled by setting the top bit in vc_sm_result_t trans_id.
+	 */
+
+	/*
+	 * VC has finished with an imported memory allocation.
+	 * Release any Linux reference counts on the underlying block.
+	 */
+	VC_SM_MSG_TYPE_RELEASED,
+	/* VC request for memory */
+	VC_SM_MSG_TYPE_VC_MEM_REQUEST,
+
+	VC_SM_MSG_TYPE_MAX
+};
+
+/* Type of memory to be allocated */
+enum vc_sm_alloc_type_t {
+	VC_SM_ALLOC_CACHED,
+	VC_SM_ALLOC_NON_CACHED,
+};
+
+/* Message header for all messages in HOST->VC direction */
+struct vc_sm_msg_hdr_t {
+	u32 type;
+	u32 trans_id;
+	u8 body[0];
+
+};
+
+/* Request to free a previously allocated memory (HOST->VC) */
+struct vc_sm_free_t {
+	/* Resource handle (returned from alloc) */
+	u32 res_handle;
+	/* Resource buffer (returned from alloc) */
+	u32 res_mem;
+
+};
+
+/* Generic result for a request (VC->HOST) */
+struct vc_sm_result_t {
+	/* Transaction identifier */
+	u32 trans_id;
+
+	s32 success;
+
+};
+
+/* Request to import memory (HOST->VC) */
+struct vc_sm_import {
+	/* type of memory to allocate */
+	enum vc_sm_alloc_type_t type;
+	/* pointer to the VC (ie physical) address of the allocated memory */
+	u32 addr;
+	/* size of buffer */
+	u32 size;
+	/* opaque handle returned in RELEASED messages */
+	u32 kernel_id;
+	/* Allocator identifier */
+	u32 allocator;
+	/* resource name (for easier tracking on vc side) */
+	char     name[VC_SM_RESOURCE_NAME];
+};
+
+/* Result of a requested memory import (VC->HOST) */
+struct vc_sm_import_result {
+	/* Transaction identifier */
+	u32 trans_id;
+
+	/* Resource handle */
+	u32 res_handle;
+};
+
+/* Notification that VC has finished with an allocation (VC->HOST) */
+struct vc_sm_released {
+	/* cmd type / trans_id */
+	u32 cmd;
+
+	/* pointer to the VC (ie physical) address of the allocated memory */
+	u32 addr;
+	/* size of buffer */
+	u32 size;
+	/* opaque handle returned in RELEASED messages */
+	u32 kernel_id;
+	u32 vc_handle;
+};
+
+/*
+ * Client informing VC as to the protocol version it supports.
+ * >=2 requires the released callback, and supports VC asking for memory.
+ * Failure means that the firmware doesn't support this call, and therefore the
+ * client should either fail, or NOT rely on getting the released callback.
+ */
+struct vc_sm_version {
+	u32 version;
+};
+
+/* Response from the kernel to provide the VPU with some memory */
+struct vc_sm_vc_mem_request_result {
+	/* Transaction identifier for the VPU */
+	u32 trans_id;
+	/* pointer to the physical address of the allocated memory */
+	u32 addr;
+	/* opaque handle returned in RELEASED messages */
+	u32 kernel_id;
+};
+
+/* Union of ALL messages */
+union vc_sm_msg_union_t {
+	struct vc_sm_free_t free;
+	struct vc_sm_result_t result;
+	struct vc_sm_import import;
+	struct vc_sm_import_result import_result;
+	struct vc_sm_version version;
+	struct vc_sm_released released;
+	struct vc_sm_vc_mem_request_result vc_request_result;
+};
+
+#endif /* __VC_SM_DEFS_H__INCLUDED__ */
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h
new file mode 100644
index 000000000000..988fdd967922
--- /dev/null
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_knl.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * VideoCore Shared Memory CMA allocator
+ *
+ * Copyright: 2018, Raspberry Pi (Trading) Ltd
+ *
+ * Based on vc_sm_defs.h from the vmcs_sm driver Copyright Broadcom Corporation.
+ *
+ */
+
+#ifndef __VC_SM_KNL_H__INCLUDED__
+#define __VC_SM_KNL_H__INCLUDED__
+
+#if !defined(__KERNEL__)
+#error "This interface is for kernel use only..."
+#endif
+
+/* Free a previously allocated or imported shared memory handle and block. */
+int vc_sm_cma_free(void *handle);
+
+/* Get an internal resource handle mapped from the external one. */
+int vc_sm_cma_int_handle(void *handle);
+
+/* Import a block of memory into the GPU space. */
+int vc_sm_cma_import_dmabuf(struct dma_buf *dmabuf, void **handle);
+
+#endif /* __VC_SM_KNL_H__INCLUDED__ */
-- 
2.41.0

