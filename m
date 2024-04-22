Return-Path: <linux-kernel+bounces-153238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4878ACB45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C3E1F20F32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B716146010;
	Mon, 22 Apr 2024 10:53:18 +0000 (UTC)
Received: from mail-m92235.xmail.ntesmail.com (mail-m92235.xmail.ntesmail.com [103.126.92.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60006482C1;
	Mon, 22 Apr 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783196; cv=none; b=Dws4e6Isy9OGmGvheXQWRrGEzpm0E0Z8KSZ3VVCg//P9CkVR6hx+V2V639WO6/EnuqVfJqnjt71bcdTW56K0M3aWOpyf3Z/pf0cAu0SbSjykWKMIgVT2xPQecZN/7dglGcbDfIPl3wnvBwUAwBSXvz4wLVqrcPzCKaesB0j88Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783196; c=relaxed/simple;
	bh=XpJ084qXAFLNdWM1twuOWiFGRFvi90via5Qtq79OCw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAl/tGN0e1GZha4tcBT6nwWA9qGyWxHuk+DO+5h5aoTQdlg61ZHTXZDoFBRLtZkHZJMa0EAeH6SkS3bhHkwwMhi9uUl9I0eBWmsNoWpqJj/Rkf4R4GoRkVVs+VuWOJ+nApS7iZlkq/XWgX72SDstA7gp9p1vD+Hyp7ensbqm9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.126.92.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id BCBB486023C;
	Mon, 22 Apr 2024 15:16:09 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: [PATCH 1/7] block: Init for CBD(CXL Block Device)
Date: Mon, 22 Apr 2024 07:16:00 +0000
Message-Id: <20240422071606.52637-2-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRodVhpMH0tMHkseQkxKH1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f04a98687023ckunmbcbb486023c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6Lxw6HDc8Pxw3MTQOCy4C
	HRAKC1FVSlVKTEpITExLSkxKS0pIVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT0pPSEs3Bg++

From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

As shared memory is supported in CXL3.0 spec, we can transfer data
via CXL shared memory. CBD means CXL block device, it use CXL shared memory
to transfer command and data to access block device in different
host, as shown below:

┌───────────────────────────────┐                               ┌────────────────────────────────────┐
│          node-1               │                               │              node-2                │
├───────────────────────────────┤                               ├────────────────────────────────────┤
│                               │                               │                                    │
│                       ┌───────┤                               ├─────────┐                          │
│                       │ cbd0  │                               │ backend0├──────────────────┐       │
│                       ├───────┤                               ├─────────┤                  │       │
│                       │ pmem0 │                               │ pmem0   │                  ▼       │
│               ┌───────┴───────┤                               ├─────────┴────┐     ┌───────────────┤
│               │    cxl driver │                               │ cxl driver   │     │ /dev/sda      │
└───────────────┴────────┬──────┘                               └─────┬────────┴─────┴───────────────┘
                         │                                            │
                         │                                            │
                         │        CXL                         CXL     │
                         └────────────────┐               ┌───────────┘
                                          │               │
                                          │               │
                                          │               │
                                      ┌───┴───────────────┴────---------------─┐
                                      │   shared memory device(cbd transport)  │
                                      └──────────────────────---------------───┘

any read/write to cbd0 on node-1 will be transferred to node-2 /dev/sda. It works similar with
nbd (network block device), but it transfer data via CXL shared memory rather than network.

Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
---
 drivers/block/Kconfig            |   2 +
 drivers/block/Makefile           |   2 +
 drivers/block/cbd/Kconfig        |   4 +
 drivers/block/cbd/Makefile       |   3 +
 drivers/block/cbd/cbd_internal.h | 830 +++++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_main.c     | 216 ++++++++
 6 files changed, 1057 insertions(+)
 create mode 100644 drivers/block/cbd/Kconfig
 create mode 100644 drivers/block/cbd/Makefile
 create mode 100644 drivers/block/cbd/cbd_internal.h
 create mode 100644 drivers/block/cbd/cbd_main.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..1f6376828af9 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -219,6 +219,8 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
+source "drivers/block/cbd/Kconfig"
+
 config BLK_DEV_RAM
 	tristate "RAM block device support"
 	help
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..8be2a39f5a7c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,4 +39,6 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 
+obj-$(CONFIG_BLK_DEV_CBD)	+= cbd/
+
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/cbd/Kconfig b/drivers/block/cbd/Kconfig
new file mode 100644
index 000000000000..98b2cbcdf895
--- /dev/null
+++ b/drivers/block/cbd/Kconfig
@@ -0,0 +1,4 @@
+config BLK_DEV_CBD
+	tristate "CXL Block Device"
+	help
+	  If unsure say 'm'.
diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile
new file mode 100644
index 000000000000..2765325486a2
--- /dev/null
+++ b/drivers/block/cbd/Makefile
@@ -0,0 +1,3 @@
+cbd-y := cbd_main.o
+
+obj-$(CONFIG_BLK_DEV_CBD) += cbd.o
diff --git a/drivers/block/cbd/cbd_internal.h b/drivers/block/cbd/cbd_internal.h
new file mode 100644
index 000000000000..7d9bf5b1c70d
--- /dev/null
+++ b/drivers/block/cbd/cbd_internal.h
@@ -0,0 +1,830 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CBD_INTERNAL_H
+#define _CBD_INTERNAL_H
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/blk-mq.h>
+#include <asm/byteorder.h>
+#include <asm/types.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/dax.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/parser.h>
+#include <linux/idr.h>
+#include <linux/workqueue.h>
+#include <linux/uuid.h>
+#include <linux/bitfield.h>
+
+/*
+ * As shared memory is supported in CXL3.0 spec, we can transfer data via CXL shared memory.
+ * CBD means CXL block device, it use CXL shared memory to transport command and data to
+ * access block device in different host, as shown below:
+ *
+ *    ┌───────────────────────────────┐                               ┌────────────────────────────────────┐
+ *    │          node-1               │                               │              node-2                │
+ *    ├───────────────────────────────┤                               ├────────────────────────────────────┤
+ *    │                               │                               │                                    │
+ *    │                       ┌───────┤                               ├─────────┐                          │
+ *    │                       │ cbd0  │                               │ backend0├──────────────────┐       │
+ *    │                       ├───────┤                               ├─────────┤                  │       │
+ *    │                       │ pmem0 │                               │ pmem0   │                  ▼       │
+ *    │               ┌───────┴───────┤                               ├─────────┴────┐     ┌───────────────┤
+ *    │               │    cxl driver │                               │ cxl driver   │     │  /dev/sda     │
+ *    └───────────────┴────────┬──────┘                               └─────┬────────┴─────┴───────────────┘
+ *                             │                                            │
+ *                             │                                            │
+ *                             │        CXL                         CXL     │
+ *                             └────────────────┐               ┌───────────┘
+ *                                              │               │
+ *                                              │               │
+ *                                              │               │
+ *                                          ┌───┴───────────────┴─────┐
+ *                                          │   shared memory device  │
+ *                                          └─────────────────────────┘
+ *
+ * any read/write to cbd0 on node-1 will be transferred to node-2 /dev/sda. It works similar with
+ * nbd (network block device), but it transfer data via CXL shared memory rather than network.
+ */
+
+/* printk */
+#define cbd_err(fmt, ...)							\
+	pr_err("cbd: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
+#define cbd_info(fmt, ...)							\
+	pr_info("cbd: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
+#define cbd_debug(fmt, ...)							\
+	pr_debug("cbd: %s:%u " fmt, __func__, __LINE__, ##__VA_ARGS__)
+
+#define cbdt_err(transport, fmt, ...)						\
+	cbd_err("cbd_transport%u: " fmt,					\
+		 transport->id, ##__VA_ARGS__)
+#define cbdt_info(transport, fmt, ...)						\
+	cbd_info("cbd_transport%u: " fmt,					\
+		 transport->id, ##__VA_ARGS__)
+#define cbdt_debug(transport, fmt, ...)						\
+	cbd_debug("cbd_transport%u: " fmt,					\
+		 transport->id, ##__VA_ARGS__)
+
+#define cbd_backend_err(backend, fmt, ...)					\
+	cbdt_err(backend->cbdt, "backend%d: " fmt,				\
+		 backend->backend_id, ##__VA_ARGS__)
+#define cbd_backend_info(backend, fmt, ...)					\
+	cbdt_info(backend->cbdt, "backend%d: " fmt,				\
+		 backend->backend_id, ##__VA_ARGS__)
+#define cbd_backend_debug(backend, fmt, ...)					\
+	cbdt_debug(backend->cbdt, "backend%d: " fmt,				\
+		 backend->backend_id, ##__VA_ARGS__)
+
+#define cbd_handler_err(handler, fmt, ...)					\
+	cbd_backend_err(handler->cbdb, "handler%d: " fmt,			\
+		 handler->channel.channel_id, ##__VA_ARGS__)
+#define cbd_handler_info(handler, fmt, ...)					\
+	cbd_backend_info(handler->cbdb, "handler%d: " fmt,			\
+		 handler->channel.channel_id, ##__VA_ARGS__)
+#define cbd_handler_debug(handler, fmt, ...)					\
+	cbd_backend_debug(handler->cbdb, "handler%d: " fmt,			\
+		 handler->channel.channel_id, ##__VA_ARGS__)
+
+#define cbd_blk_err(dev, fmt, ...)						\
+	cbdt_err(dev->cbdt, "cbd%d: " fmt,					\
+		 dev->mapped_id, ##__VA_ARGS__)
+#define cbd_blk_info(dev, fmt, ...)						\
+	cbdt_info(dev->cbdt, "cbd%d: " fmt,					\
+		 dev->mapped_id, ##__VA_ARGS__)
+#define cbd_blk_debug(dev, fmt, ...)						\
+	cbdt_debug(dev->cbdt, "cbd%d: " fmt,					\
+		 dev->mapped_id, ##__VA_ARGS__)
+
+#define cbd_queue_err(queue, fmt, ...)						\
+	cbd_blk_err(queue->cbd_blkdev, "queue-%d: " fmt,			\
+		     queue->index, ##__VA_ARGS__)
+#define cbd_queue_info(queue, fmt, ...)						\
+	cbd_blk_info(queue->cbd_blkdev, "queue-%d: " fmt,			\
+		     queue->index, ##__VA_ARGS__)
+#define cbd_queue_debug(queue, fmt, ...)					\
+	cbd_blk_debug(queue->cbd_blkdev, "queue-%d: " fmt,			\
+		     queue->index, ##__VA_ARGS__)
+
+#define cbd_channel_err(channel, fmt, ...)					\
+	cbdt_err(channel->cbdt, "channel%d: " fmt,				\
+		 channel->channel_id, ##__VA_ARGS__)
+#define cbd_channel_info(channel, fmt, ...)					\
+	cbdt_info(channel->cbdt, "channel%d: " fmt,				\
+		 channel->channel_id, ##__VA_ARGS__)
+#define cbd_channel_debug(channel, fmt, ...)					\
+	cbdt_debug(channel->cbdt, "channel%d: " fmt,				\
+		 channel->channel_id, ##__VA_ARGS__)
+
+#define CBD_PAGE_SHIFT		12
+#define CBD_PAGE_SIZE		(1 << CBD_PAGE_SHIFT)
+#define CBD_PAGE_MASK		(CBD_PAGE_SIZE - 1)
+
+#define CBD_TRANSPORT_MAX	1024
+#define CBD_PATH_LEN	512
+#define CBD_NAME_LEN	32
+
+/* TODO support multi queue */
+#define CBD_QUEUES_MAX		1
+
+#define CBD_PART_SHIFT 4
+#define CBD_DRV_NAME "cbd"
+#define CBD_DEV_NAME_LEN 32
+
+#define CBD_HB_INTERVAL		msecs_to_jiffies(5000) /* 5s */
+#define CBD_HB_TIMEOUT		(30 * 1000) /* 30s */
+
+/*
+ * CBD transport layout:
+ *
+ *      +-------------------------------------------------------------------------------------------------------------------------------+
+ *      |                           cbd transport                                                                                       |
+ *      +--------------------+-----------------------+-----------------------+----------------------+-----------------------------------+
+ *      |                    |       hosts           |      backends         |       blkdevs        |        channels                   |
+ *      | cbd transport info +----+----+----+--------+----+----+----+--------+----+----+----+-------+-------+-------+-------+-----------+
+ *      |                    |    |    |    |  ...   |    |    |    |  ...   |    |    |    |  ...  |       |       |       |   ...     |
+ *      +--------------------+----+----+----+--------+----+----+----+--------+----+----+----+-------+---+---+-------+-------+-----------+
+ *                                                                                                      |
+ *                                                                                                      |
+ *                                                                                                      |
+ *                                                                                                      |
+ *                +-------------------------------------------------------------------------------------+
+ *                |
+ *                |
+ *                v
+ *          +-----------------------------------------------------------+
+ *          |                     channel                               |
+ *          +--------------------+--------------------------------------+
+ *          |    channel meta    |              channel data            |
+ *          +---------+----------+--------------------------------------+
+ *                    |
+ *                    |
+ *                    |
+ *                    v
+ *          +----------------------------------------------------------+
+ *          |                 channel meta                             |
+ *          +-----------+--------------+-------------------------------+
+ *          | meta ctrl |  comp ring   |       cmd ring                |
+ *          +-----------+--------------+-------------------------------+
+ */
+
+/* cbd channel */
+#define CBD_OP_ALIGN_SIZE	sizeof(u64)
+#define CBDC_META_SIZE		(1024 * CBD_PAGE_SIZE)
+#define CBDC_CMDR_RESERVED	CBD_OP_ALIGN_SIZE
+#define CBDC_CMPR_RESERVED	sizeof(struct cbd_ce)
+
+#define CBDC_CTRL_OFF		0
+#define CBDC_CTRL_SIZE		CBD_PAGE_SIZE
+#define CBDC_COMPR_OFF		(CBDC_CTRL_OFF + CBDC_CTRL_SIZE)
+#define CBDC_COMPR_SIZE		(sizeof(struct cbd_ce) * 1024)
+#define CBDC_CMDR_OFF		(CBDC_COMPR_OFF + CBDC_COMPR_SIZE)
+#define CBDC_CMDR_SIZE		(CBDC_META_SIZE - CBDC_CMDR_OFF)
+
+#define CBDC_DATA_OFF		(CBDC_CMDR_OFF + CBDC_CMDR_SIZE)
+#define CBDC_DATA_SIZE		(16 * 1024 * 1024)
+#define CBDC_DATA_MASK		0xFFFFFF
+
+#define CBDC_UPDATE_CMDR_HEAD(head, used, size) (head = ((head % size) + used) % size)
+#define CBDC_UPDATE_CMDR_TAIL(tail, used, size) (tail = ((tail % size) + used) % size)
+
+#define CBDC_UPDATE_COMPR_HEAD(head, used, size) (head = ((head % size) + used) % size)
+#define CBDC_UPDATE_COMPR_TAIL(tail, used, size) (tail = ((tail % size) + used) % size)
+
+/* cbd transport */
+#define CBD_TRANSPORT_MAGIC		0x9a6c676896C596EFULL
+#define CBD_TRANSPORT_VERSION		1
+
+#define CBDT_INFO_OFF			0
+#define CBDT_INFO_SIZE			CBD_PAGE_SIZE
+
+#define CBDT_HOST_AREA_OFF		(CBDT_INFO_OFF + CBDT_INFO_SIZE)
+#define CBDT_HOST_INFO_SIZE		CBD_PAGE_SIZE
+#define CBDT_HOST_NUM			16
+
+#define CBDT_BACKEND_AREA_OFF		(CBDT_HOST_AREA_OFF + (CBDT_HOST_INFO_SIZE * CBDT_HOST_NUM))
+#define CBDT_BACKEND_INFO_SIZE		CBD_PAGE_SIZE
+#define CBDT_BACKEND_NUM		16
+
+#define CBDT_BLKDEV_AREA_OFF		(CBDT_BACKEND_AREA_OFF + (CBDT_BACKEND_INFO_SIZE * CBDT_BACKEND_NUM))
+#define CBDT_BLKDEV_INFO_SIZE		CBD_PAGE_SIZE
+#define CBDT_BLKDEV_NUM			16
+
+#define CBDT_CHANNEL_AREA_OFF		(CBDT_BLKDEV_AREA_OFF + (CBDT_BLKDEV_INFO_SIZE * CBDT_BLKDEV_NUM))
+#define CBDT_CHANNEL_SIZE		(CBDC_META_SIZE + CBDC_DATA_SIZE)
+#define CBDT_CHANNEL_NUM		16
+
+#define CBD_TRASNPORT_SIZE		(CBDT_CHANNEL_AREA_OFF + CBDT_CHANNEL_SIZE * CBDT_CHANNEL_NUM)
+
+/*
+ * CBD structure diagram:
+ *
+ *                                        +--------------+
+ *                                        | cbd_transport|                                               +----------+
+ *                                        +--------------+                                               | cbd_host |
+ *                                        |              |                                               +----------+
+ *                                        |   host       +---------------------------------------------->|          |
+ *                   +--------------------+   backends   |                                               | hostname |
+ *                   |                    |   devices    +------------------------------------------+    |          |
+ *                   |                    |              |                                          |    +----------+
+ *                   |                    +--------------+                                          |
+ *                   |                                                                              |
+ *                   |                                                                              |
+ *                   |                                                                              |
+ *                   |                                                                              |
+ *                   |                                                                              |
+ *                   v                                                                              v
+ *             +------------+     +-----------+     +------+                                  +-----------+      +-----------+     +------+
+ *             | cbd_backend+---->|cbd_backend+---->| NULL |                                  | cbd_blkdev+----->| cbd_blkdev+---->| NULL |
+ *             +------------+     +-----------+     +------+                                  +-----------+      +-----------+     +------+
+ *      +------+  handlers  |     |  handlers |                                        +------+  queues   |      |  queues   |
+ *      |      +------------+     +-----------+                                        |      +-----------+      +-----------+
+ *      |                                                                              |
+ *      |                                                                              |
+ *      |                                                                              |
+ *      |                                                                              |
+ *      |      +-------------+       +-------------+           +------+                |      +-----------+      +-----------+     +------+
+ *      +----->| cbd_handler +------>| cbd_handler +---------->| NULL |                +----->| cbd_queue +----->| cbd_queue +---->| NULL |
+ *             +-------------+       +-------------+           +------+                       +-----------+      +-----------+     +------+
+ *      +------+ channel     |       |   channel   |                                   +------+  channel  |      |  channel  |
+ *      |      +-------------+       +-------------+                                   |      +-----------+      +-----------+
+ *      |                                                                              |
+ *      |                                                                              |
+ *      |                                                                              |
+ *      |                                                                              v
+ *      |                                                        +-----------------------+
+ *      +------------------------------------------------------->|      cbd_channel      |
+ *                                                               +-----------------------+
+ *                                                               | channel_id            |
+ *                                                               | cmdr (cmd ring)       |
+ *                                                               | compr (complete ring) |
+ *                                                               | data (data area)      |
+ *                                                               |                       |
+ *                                                               +-----------------------+
+ */
+
+#define CBD_DEVICE(OBJ)					\
+struct cbd_## OBJ ##_device {				\
+	struct device dev;				\
+	struct cbd_transport *cbdt;			\
+	struct cbd_## OBJ ##_info *OBJ##_info;		\
+};							\
+							\
+struct cbd_## OBJ ##s_device {				\
+	struct device OBJ ##s_dev;			\
+	struct cbd_## OBJ ##_device OBJ ##_devs[];	\
+};
+
+
+/* cbd_worker_cfg*/
+struct cbd_worker_cfg {
+	u32			busy_retry_cur;
+	u32			busy_retry_count;
+	u32			busy_retry_max;
+	u32			busy_retry_min;
+	u64			busy_retry_interval;
+};
+
+static inline void cbdwc_init(struct cbd_worker_cfg *cfg)
+{
+	/* init cbd_worker_cfg with default values */
+	cfg->busy_retry_cur = 0;
+	cfg->busy_retry_count = 100;
+	cfg->busy_retry_max = cfg->busy_retry_count * 2;
+	cfg->busy_retry_min = 0;
+	cfg->busy_retry_interval = 1;			/* 1us */
+}
+
+/* reset retry_cur and increase busy_retry_count */
+static inline void cbdwc_hit(struct cbd_worker_cfg *cfg)
+{
+	u32 delta;
+
+	cfg->busy_retry_cur = 0;
+
+	if (cfg->busy_retry_count == cfg->busy_retry_max)
+		return;
+
+	/* retry_count increase by 1/16 */
+	delta = cfg->busy_retry_count >> 4;
+	if (!delta)
+		delta = (cfg->busy_retry_max + cfg->busy_retry_min) >> 1;
+
+	cfg->busy_retry_count += delta;
+
+	if (cfg->busy_retry_count > cfg->busy_retry_max)
+		cfg->busy_retry_count = cfg->busy_retry_max;
+
+	return;
+}
+
+/* reset retry_cur and decrease busy_retry_count */
+static inline void cbdwc_miss(struct cbd_worker_cfg *cfg)
+{
+	u32 delta;
+
+	cfg->busy_retry_cur = 0;
+
+	if (cfg->busy_retry_count == cfg->busy_retry_min)
+		return;
+
+	/* retry_count decrease by 1/16 */
+	delta = cfg->busy_retry_count >> 4;
+	if (!delta)
+		delta = cfg->busy_retry_count;
+
+	cfg->busy_retry_count -= delta;
+
+	return;
+}
+
+static inline bool cbdwc_need_retry(struct cbd_worker_cfg *cfg)
+{
+	if (++cfg->busy_retry_cur < cfg->busy_retry_count) {
+		cpu_relax();
+		fsleep(cfg->busy_retry_interval);
+		return true;
+	}
+
+	return false;
+}
+
+/* cbd_transport */
+#define CBDT_INFO_F_BIGENDIAN		1 << 0
+
+struct cbd_transport_info {
+	__le64 magic;
+	__le16 version;
+	__le16 flags;
+
+	u64 host_area_off;
+	u32 host_info_size;
+	u32 host_num;
+
+	u64 backend_area_off;
+	u32 backend_info_size;
+	u32 backend_num;
+
+	u64 blkdev_area_off;
+	u32 blkdev_info_size;
+	u32 blkdev_num;
+
+	u64 channel_area_off;
+	u32 channel_size;
+	u32 channel_num;
+};
+
+struct cbd_transport {
+	u16	id;
+	struct device device;
+	struct mutex lock;
+
+	struct cbd_transport_info *transport_info;
+
+	struct cbd_host *host;
+	struct list_head backends;
+	struct list_head devices;
+
+	struct cbd_hosts_device *cbd_hosts_dev;
+	struct cbd_channels_device *cbd_channels_dev;
+	struct cbd_backends_device *cbd_backends_dev;
+	struct cbd_blkdevs_device *cbd_blkdevs_dev;
+
+	struct dax_device *dax_dev;
+	struct bdev_handle   *bdev_handle;
+};
+
+struct cbdt_register_options {
+	char hostname[CBD_NAME_LEN];
+	char path[CBD_PATH_LEN];
+	u16 format:1;
+	u16 force:1;
+	u16 unused:15;
+};
+
+struct cbd_blkdev;
+struct cbd_backend;
+
+int cbdt_register(struct cbdt_register_options *opts);
+int cbdt_unregister(u32 transport_id);
+
+struct cbd_host_info *cbdt_get_host_info(struct cbd_transport *cbdt, u32 id);
+struct cbd_backend_info *cbdt_get_backend_info(struct cbd_transport *cbdt, u32 id);
+struct cbd_blkdev_info *cbdt_get_blkdev_info(struct cbd_transport *cbdt, u32 id);
+struct cbd_channel_info *cbdt_get_channel_info(struct cbd_transport *cbdt, u32 id);
+
+int cbdt_get_empty_host_id(struct cbd_transport *cbdt, u32 *id);
+int cbdt_get_empty_backend_id(struct cbd_transport *cbdt, u32 *id);
+int cbdt_get_empty_blkdev_id(struct cbd_transport *cbdt, u32 *id);
+int cbdt_get_empty_channel_id(struct cbd_transport *cbdt, u32 *id);
+
+void cbdt_add_backend(struct cbd_transport *cbdt, struct cbd_backend *cbdb);
+void cbdt_del_backend(struct cbd_transport *cbdt, struct cbd_backend *cbdb);
+struct cbd_backend *cbdt_get_backend(struct cbd_transport *cbdt, u32 id);
+void cbdt_add_blkdev(struct cbd_transport *cbdt, struct cbd_blkdev *blkdev);
+struct cbd_blkdev *cbdt_fetch_blkdev(struct cbd_transport *cbdt, u32 id);
+
+struct page *cbdt_page(struct cbd_transport *cbdt, u64 transport_off);
+void cbdt_flush_range(struct cbd_transport *cbdt, void *pos, u64 size);
+
+/* cbd_host */
+CBD_DEVICE(host);
+
+enum cbd_host_state {
+	cbd_host_state_none	= 0,
+	cbd_host_state_running
+};
+
+struct cbd_host_info {
+	u8	state;
+	u64	alive_ts;
+	char	hostname[CBD_NAME_LEN];
+};
+
+struct cbd_host {
+	u32			host_id;
+	struct cbd_transport	*cbdt;
+
+	struct cbd_host_device	*dev;
+	struct cbd_host_info	*host_info;
+	struct delayed_work	hb_work; /* heartbeat work */
+};
+
+int cbd_host_register(struct cbd_transport *cbdt, char *hostname);
+int cbd_host_unregister(struct cbd_transport *cbdt);
+
+/* cbd_channel */
+CBD_DEVICE(channel);
+
+enum cbdc_blkdev_state {
+	cbdc_blkdev_state_none		= 0,
+	cbdc_blkdev_state_running,
+	cbdc_blkdev_state_stopped,
+};
+
+enum cbdc_backend_state {
+	cbdc_backend_state_none		= 0,
+	cbdc_backend_state_running,
+	cbdc_backend_state_stopped,
+};
+
+enum cbd_channel_state {
+	cbd_channel_state_none		= 0,
+	cbd_channel_state_running,
+};
+
+struct cbd_channel_info {
+	u8	state;
+
+	u8	blkdev_state;
+	u32	blkdev_id;
+
+	u8	backend_state;
+	u32	backend_id;
+
+	u32	cmdr_off;
+	u32 	cmdr_size;
+	u32 	cmd_head;
+	u32 	cmd_tail;
+
+	u32 	compr_head;
+	u32 	compr_tail;
+	u32 	compr_off;
+	u32 	compr_size;
+};
+
+struct cbd_channel {
+	u32				channel_id;
+	struct cbd_channel_deivce	*dev;
+	struct cbd_channel_info		*channel_info;
+
+	struct cbd_transport		*cbdt;
+
+	struct page			*ctrl_page;
+
+	void				*cmdr;
+	void				*compr;
+	void				*data;
+
+	u32				data_size;
+	u32				data_head;
+	u32				data_tail;
+
+	spinlock_t			cmdr_lock;
+	spinlock_t			compr_lock;
+};
+
+void cbd_channel_init(struct cbd_channel *channel, struct cbd_transport *cbdt, u32 channel_id);
+void cbdc_copy_from_bio(struct cbd_channel *channel,
+		u32 data_off, u32 data_len, struct bio *bio);
+void cbdc_copy_to_bio(struct cbd_channel *channel,
+		u32 data_off, u32 data_len, struct bio *bio);
+void cbdc_flush_ctrl(struct cbd_channel *channel);
+
+/* cbd_handler */
+struct cbd_handler {
+	struct cbd_backend	*cbdb;
+	struct cbd_channel_info *channel_info;
+
+	struct cbd_channel	channel;
+
+	u32			se_to_handle;
+
+	struct delayed_work	handle_work;
+	struct cbd_worker_cfg	handle_worker_cfg;
+
+	struct list_head	handlers_node;
+	struct bio_set		bioset;
+	struct workqueue_struct *handle_wq;
+};
+
+void cbd_handler_destroy(struct cbd_handler *handler);
+int cbd_handler_create(struct cbd_backend *cbdb, u32 channel_id);
+
+/* cbd_backend */
+CBD_DEVICE(backend);
+
+enum cbd_backend_state {
+	cbd_backend_state_none	= 0,
+	cbd_backend_state_running,
+};
+
+#define CBDB_BLKDEV_COUNT_MAX	1
+
+struct cbd_backend_info {
+	u8	state;
+	u32	host_id;
+	u32	blkdev_count;
+	u64	alive_ts;
+	u64	dev_size; /* nr_sectors */
+	char	path[CBD_PATH_LEN];
+};
+
+struct cbd_backend {
+	u32			backend_id;
+	char			path[CBD_PATH_LEN];
+	struct cbd_transport	*cbdt;
+	struct cbd_backend_info *backend_info;
+	struct mutex 		lock;
+
+	struct block_device	*bdev;
+	struct bdev_handle	*bdev_handle;
+
+	struct workqueue_struct	*task_wq;  /* workqueue for request work */
+	struct delayed_work	state_work;
+	struct delayed_work	hb_work; /* heartbeat work */
+
+	struct list_head	node; /* cbd_transport->backends */
+	struct list_head	handlers;
+
+	struct cbd_backend_device *backend_device;
+};
+
+int cbd_backend_start(struct cbd_transport *cbdt, char *path);
+int cbd_backend_stop(struct cbd_transport *cbdt, u32 backend_id);
+void cbdb_add_handler(struct cbd_backend *cbdb, struct cbd_handler *handler);
+void cbdb_del_handler(struct cbd_backend *cbdb, struct cbd_handler *handler);
+
+/* cbd_queue */
+enum cbd_op {
+	CBD_OP_PAD = 0,
+	CBD_OP_WRITE,
+	CBD_OP_READ,
+	CBD_OP_DISCARD,
+	CBD_OP_WRITE_ZEROS,
+	CBD_OP_FLUSH,
+};
+
+struct cbd_se_hdr {
+	u32 len_op;
+	u32 flags;
+
+};
+
+struct cbd_se {
+	struct cbd_se_hdr	header;
+	u64			priv_data;	// pointer to cbd_request
+
+	u64			offset;
+	u32			len;
+
+	u32			data_off;
+	u32			data_len;
+};
+
+
+struct cbd_ce {
+	u64		priv_data;	// copied from submit entry
+	u32		result;
+	u32		flags;
+};
+
+
+struct cbd_request {
+	struct cbd_queue	*cbdq;
+
+	struct cbd_se		*se;
+	struct cbd_ce		*ce;
+	struct request		*req;
+
+	enum cbd_op		op;
+	u64			req_tid;
+	struct list_head	inflight_reqs_node;
+
+	u32			data_off;
+	u32			data_len;
+
+	struct work_struct	work;
+};
+
+#define CBD_OP_MASK 0xff
+#define CBD_OP_SHIFT 8
+
+static inline enum cbd_op cbd_se_hdr_get_op(__le32 len_op)
+{
+       return (enum cbd_op)(len_op & CBD_OP_MASK);
+}
+
+static inline void cbd_se_hdr_set_op(u32 *len_op, enum cbd_op op)
+{
+       *len_op &= ~CBD_OP_MASK;
+       *len_op |= (op & CBD_OP_MASK);
+}
+
+static inline u32 cbd_se_hdr_get_len(u32 len_op)
+{
+	return len_op >> CBD_OP_SHIFT;
+}
+
+static inline void cbd_se_hdr_set_len(u32 *len_op, u32 len)
+{
+	*len_op &= CBD_OP_MASK;
+	*len_op |= (len << CBD_OP_SHIFT);
+}
+
+#define CBD_SE_HDR_DONE	1
+
+static inline bool cbd_se_hdr_flags_test(struct cbd_se *se, u32 bit)
+{
+	return (se->header.flags & bit);
+}
+
+static inline void cbd_se_hdr_flags_set(struct cbd_se *se, u32 bit)
+{
+	se->header.flags |= bit;
+}
+
+enum cbd_queue_state {
+	cbd_queue_state_none	= 0,
+	cbd_queue_state_running
+};
+
+struct cbd_queue {
+	struct cbd_blkdev	*cbd_blkdev;
+
+	bool			inited;
+	int			index;
+
+	struct list_head	inflight_reqs;
+	spinlock_t		inflight_reqs_lock;
+	u64			req_tid;
+
+	u32			*released_extents;
+
+	u32			channel_id;
+	struct cbd_channel_info	*channel_info;
+	struct cbd_channel	channel;
+	struct workqueue_struct	*task_wq;  /* workqueue for request work */
+
+	atomic_t		state;
+
+	struct delayed_work	complete_work;
+	struct cbd_worker_cfg	complete_worker_cfg;
+};
+
+int cbd_queue_start(struct cbd_queue *cbdq);
+void cbd_queue_stop(struct cbd_queue *cbdq);
+extern const struct blk_mq_ops cbd_mq_ops;
+
+/* cbd_blkdev */
+CBD_DEVICE(blkdev);
+
+enum cbd_blkdev_state {
+	cbd_blkdev_state_none	= 0,
+	cbd_blkdev_state_running
+};
+
+struct cbd_blkdev_info {
+	u8	state;
+	u64	alive_ts;
+	u32	backend_id;
+	u32	host_id;
+	u32	mapped_id;
+};
+
+struct cbd_blkdev {
+	u32			blkdev_id; /* index in transport blkdev area */
+	u32			backend_id;
+	int			mapped_id; /* id in block device such as: /dev/cbd0 */
+
+	int			major;		/* blkdev assigned major */
+	int			minor;
+	struct gendisk		*disk;		/* blkdev's gendisk and rq */
+
+	spinlock_t		lock;		/* open_count */
+	struct list_head	node;
+	struct mutex		state_lock;
+	struct delayed_work	hb_work; /* heartbeat work */
+
+	/* Block layer tags. */
+	struct blk_mq_tag_set	tag_set;
+
+	unsigned long		open_count;	/* protected by lock */
+
+	uint32_t		num_queues;
+	struct cbd_queue	*queues;
+
+	u64			dev_size;
+	u64			dev_features;
+	u32			io_timeout;
+
+	u8			state;
+	u32			state_flags;
+	struct kref		kref;
+
+	void			*cmdr;
+	void			*compr;
+	spinlock_t		cmdr_lock;
+	spinlock_t		compr_lock;
+	void			*data;
+
+	struct cbd_blkdev_device *blkdev_dev;
+	struct cbd_blkdev_info *blkdev_info;
+
+	struct cbd_transport *cbdt;
+};
+
+int cbd_blkdev_init(void);
+void cbd_blkdev_exit(void);
+int cbd_blkdev_start(struct cbd_transport *cbdt, u32 backend_id, u32 queues);
+int cbd_blkdev_stop(struct cbd_transport *cbdt, u32 devid);
+
+extern struct workqueue_struct	*cbd_wq;
+
+#define cbd_setup_device(DEV, PARENT, TYPE, fmt, ...)		\
+do {								\
+	device_initialize(DEV);					\
+	device_set_pm_not_required(DEV);			\
+	dev_set_name(DEV, fmt, ##__VA_ARGS__);			\
+	DEV->parent = PARENT;					\
+	DEV->type = TYPE;					\
+								\
+	ret = device_add(DEV);					\
+} while (0)
+
+#define CBD_OBJ_HEARTBEAT(OBJ)								\
+static void OBJ##_hb_workfn(struct work_struct *work)					\
+{											\
+	struct cbd_##OBJ *obj = container_of(work, struct cbd_##OBJ, hb_work.work);	\
+	struct cbd_##OBJ##_info *info = obj->OBJ##_info;				\
+											\
+	info->alive_ts = ktime_get_real();						\
+	cbdt_flush_range(obj->cbdt, info, sizeof(*info));				\
+											\
+	queue_delayed_work(cbd_wq, &obj->hb_work, CBD_HB_INTERVAL);			\
+}											\
+											\
+static bool OBJ##_info_is_alive(struct cbd_##OBJ##_info *info)				\
+{											\
+	ktime_t oldest, ts;								\
+											\
+	ts = info->alive_ts;								\
+	oldest = ktime_sub_ms(ktime_get_real(), CBD_HB_TIMEOUT);			\
+											\
+	if (ktime_after(ts, oldest))							\
+		return true;								\
+											\
+	return false;									\
+}											\
+											\
+static ssize_t cbd_##OBJ##_alive_show(struct device *dev,				\
+			       struct device_attribute *attr,				\
+			       char *buf)						\
+{											\
+	struct cbd_##OBJ##_device *_dev;						\
+											\
+	_dev = container_of(dev, struct cbd_##OBJ##_device, dev);			\
+											\
+	cbdt_flush_range(_dev->cbdt, _dev->OBJ##_info, sizeof(*_dev->OBJ##_info));	\
+	if (OBJ##_info_is_alive(_dev->OBJ##_info))					\
+		return sprintf(buf, "true\n");						\
+											\
+	return sprintf(buf, "false\n");							\
+}											\
+											\
+static DEVICE_ATTR(alive, 0400, cbd_##OBJ##_alive_show, NULL);				\
+
+#endif /* _CBD_INTERNAL_H */
diff --git a/drivers/block/cbd/cbd_main.c b/drivers/block/cbd/cbd_main.c
new file mode 100644
index 000000000000..0a87c95d749d
--- /dev/null
+++ b/drivers/block/cbd/cbd_main.c
@@ -0,0 +1,216 @@
+/*
+ * Copyright(C) 2024, Dongsheng Yang <dongsheng.yang.linux@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/bio.h>
+#include <linux/module.h>
+#include <linux/blk-mq.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <net/genetlink.h>
+
+#include <linux/types.h>
+
+#include "cbd_internal.h"
+
+struct workqueue_struct	*cbd_wq;
+
+enum {
+	CBDT_REG_OPT_ERR		= 0,
+	CBDT_REG_OPT_FORCE,
+	CBDT_REG_OPT_FORMAT,
+	CBDT_REG_OPT_PATH,
+	CBDT_REG_OPT_HOSTNAME,
+};
+
+static const match_table_t register_opt_tokens = {
+	{ CBDT_REG_OPT_FORCE,		"force=%u" },
+	{ CBDT_REG_OPT_FORMAT,		"format=%u" },
+	{ CBDT_REG_OPT_PATH,		"path=%s" },
+	{ CBDT_REG_OPT_HOSTNAME,	"hostname=%s" },
+	{ CBDT_REG_OPT_ERR,		NULL	}
+};
+
+static int parse_register_options(
+		char *buf,
+		struct cbdt_register_options *opts)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *o, *p;
+	int token, ret = 0;
+
+	o = buf;
+
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, register_opt_tokens, args);
+		switch (token) {
+		case CBDT_REG_OPT_PATH:
+			if (match_strlcpy(opts->path, &args[0],
+			        CBD_PATH_LEN) == 0) {
+			        ret = -EINVAL;
+			        break;
+			}
+			break;
+		case CBDT_REG_OPT_FORCE:
+			if (match_uint(args, &token) || token != 1) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->force = 1;
+			break;
+		case CBDT_REG_OPT_FORMAT:
+			if (match_uint(args, &token) || token != 1) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->format = 1;
+			break;
+		case CBDT_REG_OPT_HOSTNAME:
+			if (match_strlcpy(opts->hostname, &args[0],
+			        CBD_NAME_LEN) == 0) {
+			        ret = -EINVAL;
+			        break;
+			}
+			break;
+		default:
+			pr_err("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static ssize_t transport_unregister_store(const struct bus_type *bus, const char *ubuf,
+				      size_t size)
+{
+	int ret;
+	u32 transport_id;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sscanf(ubuf, "transport_id=%u", &transport_id) != 1) {
+		return -EINVAL;
+	}
+
+	return size;
+}
+
+static ssize_t transport_register_store(const struct bus_type *bus, const char *ubuf,
+				      size_t size)
+{
+	int ret;
+	char *buf;
+	struct cbdt_register_options opts = { 0 };
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	buf = kmemdup(ubuf, size + 1, GFP_KERNEL);
+	if (IS_ERR(buf)) {
+		pr_err("failed to dup buf for adm option: %d", (int)PTR_ERR(buf));
+		return PTR_ERR(buf);
+	}
+	buf[size] = '\0';
+
+	ret = parse_register_options(buf, &opts);
+	if (ret < 0) {
+		kfree(buf);
+		return ret;
+	}
+	kfree(buf);
+
+	return size;
+}
+
+static BUS_ATTR_WO(transport_unregister);
+static BUS_ATTR_WO(transport_register);
+
+static struct attribute *cbd_bus_attrs[] = {
+	&bus_attr_transport_unregister.attr,
+	&bus_attr_transport_register.attr,
+	NULL,
+};
+
+static const struct attribute_group cbd_bus_group = {
+	.attrs = cbd_bus_attrs,
+};
+__ATTRIBUTE_GROUPS(cbd_bus);
+
+struct bus_type cbd_bus_type = {
+	.name		= "cbd",
+	.bus_groups	= cbd_bus_groups,
+};
+
+static void cbd_root_dev_release(struct device *dev)
+{
+}
+
+struct device cbd_root_dev = {
+	.init_name =    "cbd",
+	.release =      cbd_root_dev_release,
+};
+
+static int __init cbd_init(void)
+{
+	int ret;
+
+	cbd_wq = alloc_workqueue(CBD_DRV_NAME, WQ_MEM_RECLAIM, 0);
+	if (!cbd_wq) {
+		return -ENOMEM;
+	}
+
+	ret = device_register(&cbd_root_dev);
+	if (ret < 0) {
+		put_device(&cbd_root_dev);
+		goto destroy_wq;
+	}
+
+	ret = bus_register(&cbd_bus_type);
+	if (ret < 0) {
+		goto device_unregister;
+	}
+
+	return 0;
+
+bus_unregister:
+	bus_unregister(&cbd_bus_type);
+device_unregister:
+	device_unregister(&cbd_root_dev);
+destroy_wq:
+	destroy_workqueue(cbd_wq);
+
+	return ret;
+}
+
+static void cbd_exit(void)
+{
+	bus_unregister(&cbd_bus_type);
+	device_unregister(&cbd_root_dev);
+
+	destroy_workqueue(cbd_wq);
+
+	return;
+}
+
+MODULE_AUTHOR("Dongsheng Yang <dongsheng.yang.linux@gmail.com>");
+MODULE_DESCRIPTION("CXL(Compute Express Link) Block Device");
+MODULE_LICENSE("GPL v2");
+module_init(cbd_init);
+module_exit(cbd_exit);
-- 
2.34.1


