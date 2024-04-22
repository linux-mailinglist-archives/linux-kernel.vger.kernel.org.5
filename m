Return-Path: <linux-kernel+bounces-152869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04618AC570
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B752831A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4484EB31;
	Mon, 22 Apr 2024 07:23:19 +0000 (UTC)
Received: from mail-m3293.qiye.163.com (mail-m3293.qiye.163.com [220.197.32.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57954AED7;
	Mon, 22 Apr 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770598; cv=none; b=WehqKQnFHMJtSx+P8HtJteq8St4veJtLe80KQQ9bDKlezVlqHcDUZKQrauWoeiuYNQX4O0eFPZWtMK7Havm5jj/7qNWN6tKvwquaAdJqZEAxkkguCje6Wh3/OdSySMirO8DitFvyGQaP1eEygVJVdEqbTqLKVoLAxuRT0iLRs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770598; c=relaxed/simple;
	bh=djS/nygYkmJtxtQpLRF9CbU5mFHSWtrgRIwrAi/fqVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5G+U+W47Gv2Rvw4BJnfqUd9G2CYeg0vlCeHFpQL9xcPHaNQigE0ElKwvoPa28+9Kk/HfzOubruqdT8YAu5BbzKQfT7FyYGkmYHgapOkB+r7IclBoLl837CxzRZI6h05BnPJ2xMSoRP9h43YyE93vWE+0EsBn8BMACkw2JASmXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CD5BD860261;
	Mon, 22 Apr 2024 15:16:13 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: [PATCH 5/7] cbd: introuce cbd_backend
Date: Mon, 22 Apr 2024 07:16:04 +0000
Message-Id: <20240422071606.52637-6-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh5MVktDSEIfGUJCSBoaHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f04a99682023ckunmcd5bd860261
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Cio5Cjc#LxwMMSsoCx4Z
	EA8KCilVSlVKTEpITExLSkxPQ0pMVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSkxNTkI3Bg++

From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

The "cbd_backend" is responsible for exposing a local block device (such
as "/dev/sda") through the "cbd_transport" to other hosts.

Any host that registers this transport can map this backend to a local
"cbd device"(such as "/dev/cbd0"). All reads and writes to "cbd0" are transmitted
through the channel inside the transport to the backend. The handler
inside the backend is responsible for processing these read and write
requests, converting them into read and write requests corresponding to "sda".

Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
---
 drivers/block/cbd/Makefile        |   2 +-
 drivers/block/cbd/cbd_backend.c   | 254 +++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_handler.c   | 261 ++++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_transport.c |   6 +
 4 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/cbd/cbd_backend.c
 create mode 100644 drivers/block/cbd/cbd_handler.c

diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile
index 2389a738b12b..b47f1e584946 100644
--- a/drivers/block/cbd/Makefile
+++ b/drivers/block/cbd/Makefile
@@ -1,3 +1,3 @@
-cbd-y := cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o
+cbd-y := cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o cbd_backend.o cbd_handler.o
 
 obj-$(CONFIG_BLK_DEV_CBD) += cbd.o
diff --git a/drivers/block/cbd/cbd_backend.c b/drivers/block/cbd/cbd_backend.c
new file mode 100644
index 000000000000..a06f319e62c4
--- /dev/null
+++ b/drivers/block/cbd/cbd_backend.c
@@ -0,0 +1,254 @@
+#include "cbd_internal.h"
+
+static ssize_t backend_host_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_backend_device *backend;
+	struct cbd_backend_info *backend_info;
+
+	backend = container_of(dev, struct cbd_backend_device, dev);
+	backend_info = backend->backend_info;
+
+	cbdt_flush_range(backend->cbdt, backend_info, sizeof(*backend_info));
+
+	if (backend_info->state == cbd_backend_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", backend_info->host_id);
+}
+
+static DEVICE_ATTR(host_id, 0400, backend_host_id_show, NULL);
+
+static ssize_t backend_path_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_backend_device *backend;
+	struct cbd_backend_info *backend_info;
+
+	backend = container_of(dev, struct cbd_backend_device, dev);
+	backend_info = backend->backend_info;
+
+	cbdt_flush_range(backend->cbdt, backend_info, sizeof(*backend_info));
+
+	if (backend_info->state == cbd_backend_state_none)
+		return 0;
+
+	if (strlen(backend_info->path) == 0)
+		return 0;
+
+	return sprintf(buf, "%s\n", backend_info->path);
+}
+
+static DEVICE_ATTR(path, 0400, backend_path_show, NULL);
+
+CBD_OBJ_HEARTBEAT(backend);
+
+static struct attribute *cbd_backend_attrs[] = {
+	&dev_attr_path.attr,
+	&dev_attr_host_id.attr,
+	&dev_attr_alive.attr,
+	NULL
+};
+
+static struct attribute_group cbd_backend_attr_group = {
+	.attrs = cbd_backend_attrs,
+};
+
+static const struct attribute_group *cbd_backend_attr_groups[] = {
+	&cbd_backend_attr_group,
+	NULL
+};
+
+static void cbd_backend_release(struct device *dev)
+{
+}
+
+struct device_type cbd_backend_type = {
+	.name		= "cbd_backend",
+	.groups		= cbd_backend_attr_groups,
+	.release	= cbd_backend_release,
+};
+
+struct device_type cbd_backends_type = {
+	.name		= "cbd_backends",
+	.release	= cbd_backend_release,
+};
+
+void cbdb_add_handler(struct cbd_backend *cbdb, struct cbd_handler *handler)
+{
+	mutex_lock(&cbdb->lock);
+	list_add(&handler->handlers_node, &cbdb->handlers);
+	mutex_unlock(&cbdb->lock);
+}
+
+void cbdb_del_handler(struct cbd_backend *cbdb, struct cbd_handler *handler)
+{
+	mutex_lock(&cbdb->lock);
+	list_del_init(&handler->handlers_node);
+	mutex_unlock(&cbdb->lock);
+}
+
+static struct cbd_handler *cbdb_get_handler(struct cbd_backend *cbdb, u32 channel_id)
+{
+	struct cbd_handler *handler, *handler_next;
+	bool found = false;
+
+	mutex_lock(&cbdb->lock);
+	list_for_each_entry_safe(handler, handler_next, &cbdb->handlers, handlers_node) {
+		if (handler->channel.channel_id == channel_id) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&cbdb->lock);
+
+	if (!found) {
+		return ERR_PTR(-ENOENT);
+	}
+
+	return handler;
+}
+
+static void state_work_fn(struct work_struct *work)
+{
+	struct cbd_backend *cbdb = container_of(work, struct cbd_backend, state_work.work);
+	struct cbd_transport *cbdt = cbdb->cbdt;
+	struct cbd_channel_info *channel_info;
+	u32 blkdev_state, backend_state, backend_id;
+	int i;
+
+	for (i = 0; i < cbdt->transport_info->channel_num; i++) {
+		channel_info = cbdt_get_channel_info(cbdt, i);
+
+		cbdt_flush_range(cbdt, channel_info, sizeof(*channel_info));
+		blkdev_state = channel_info->blkdev_state;
+		backend_state = channel_info->backend_state;
+		backend_id = channel_info->backend_id;
+
+		if (blkdev_state == cbdc_blkdev_state_running &&
+				backend_state == cbdc_backend_state_none &&
+				backend_id == cbdb->backend_id) {
+
+			cbd_handler_create(cbdb, i);
+		}
+		
+		if (blkdev_state == cbdc_blkdev_state_none &&
+				backend_state == cbdc_backend_state_running &&
+				backend_id == cbdb->backend_id) {
+			struct cbd_handler *handler;
+
+			handler = cbdb_get_handler(cbdb, i);
+			cbd_handler_destroy(handler);
+		}
+	}
+
+	queue_delayed_work(cbd_wq, &cbdb->state_work, 1 * HZ);
+}
+
+static int cbd_backend_init(struct cbd_backend *cbdb)
+{
+	struct cbd_backend_info *b_info;
+	struct cbd_transport *cbdt = cbdb->cbdt;
+
+	b_info = cbdt_get_backend_info(cbdt, cbdb->backend_id);
+	cbdb->backend_info = b_info;
+
+	b_info->host_id = cbdb->cbdt->host->host_id;
+
+	cbdb->bdev_handle = bdev_open_by_path(cbdb->path, BLK_OPEN_READ | BLK_OPEN_WRITE, cbdb, NULL);
+	if (IS_ERR(cbdb->bdev_handle)) {
+		cbdt_err(cbdt, "failed to open bdev: %d", (int)PTR_ERR(cbdb->bdev_handle));
+		return PTR_ERR(cbdb->bdev_handle);
+	}
+	cbdb->bdev = cbdb->bdev_handle->bdev;
+	b_info->dev_size = bdev_nr_sectors(cbdb->bdev);
+
+	INIT_DELAYED_WORK(&cbdb->state_work, state_work_fn);
+	INIT_DELAYED_WORK(&cbdb->hb_work, backend_hb_workfn);
+	INIT_LIST_HEAD(&cbdb->handlers);
+	cbdb->backend_device = &cbdt->cbd_backends_dev->backend_devs[cbdb->backend_id];
+
+	mutex_init(&cbdb->lock);
+
+	queue_delayed_work(cbd_wq, &cbdb->state_work, 0);
+	queue_delayed_work(cbd_wq, &cbdb->hb_work, 0);
+
+	return 0;
+}
+
+int cbd_backend_start(struct cbd_transport *cbdt, char *path)
+{
+	struct cbd_backend *backend;
+	struct cbd_backend_info *backend_info;
+	u32 backend_id;
+	int ret;
+
+	ret = cbdt_get_empty_backend_id(cbdt, &backend_id);
+	if (ret) {
+		return ret;
+	}
+
+	backend_info = cbdt_get_backend_info(cbdt, backend_id);
+
+	backend = kzalloc(sizeof(struct cbd_backend), GFP_KERNEL);
+	if (!backend) {
+		return -ENOMEM;
+	}
+
+	strscpy(backend->path, path, CBD_PATH_LEN);
+	memcpy(backend_info->path, backend->path, CBD_PATH_LEN);
+	INIT_LIST_HEAD(&backend->node);
+	backend->backend_id = backend_id;
+	backend->cbdt = cbdt;
+
+	ret = cbd_backend_init(backend);
+	if (ret) {
+		goto backend_free;
+	}
+
+	backend_info->state = cbd_backend_state_running;
+	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
+
+	cbdt_add_backend(cbdt, backend);
+
+	return 0;
+
+backend_free:
+	kfree(backend);
+
+	return ret;
+}
+
+int cbd_backend_stop(struct cbd_transport *cbdt, u32 backend_id)
+{
+	struct cbd_backend *cbdb;
+	struct cbd_backend_info *backend_info;
+
+	cbdb = cbdt_get_backend(cbdt, backend_id);
+	if (!cbdb) {
+		return -ENOENT;
+	}
+
+	mutex_lock(&cbdb->lock);
+	if (!list_empty(&cbdb->handlers)) {
+		mutex_unlock(&cbdb->lock);
+		return -EBUSY;
+	}
+
+	cbdt_del_backend(cbdt, cbdb);
+
+	cancel_delayed_work_sync(&cbdb->hb_work);
+	cancel_delayed_work_sync(&cbdb->state_work);
+
+	backend_info = cbdt_get_backend_info(cbdt, cbdb->backend_id);
+	backend_info->state = cbd_backend_state_none;
+	cbdt_flush_range(cbdt, backend_info, sizeof(*backend_info));
+	mutex_unlock(&cbdb->lock);
+
+	bdev_release(cbdb->bdev_handle);
+	kfree(cbdb);
+
+	return 0;
+}
diff --git a/drivers/block/cbd/cbd_handler.c b/drivers/block/cbd/cbd_handler.c
new file mode 100644
index 000000000000..0fbfc225ea29
--- /dev/null
+++ b/drivers/block/cbd/cbd_handler.c
@@ -0,0 +1,261 @@
+#include "cbd_internal.h"
+
+static inline struct cbd_se *get_se_head(struct cbd_handler *handler)
+{
+	return (struct cbd_se *)(handler->channel.cmdr + handler->channel_info->cmd_head);
+}
+
+static inline struct cbd_se *get_se_to_handle(struct cbd_handler *handler)
+{
+	return (struct cbd_se *)(handler->channel.cmdr + handler->se_to_handle);
+}
+
+static inline struct cbd_ce *get_compr_head(struct cbd_handler *handler)
+{
+	return (struct cbd_ce *)(handler->channel.compr + handler->channel_info->compr_head);
+}
+
+struct cbd_backend_io {
+	struct cbd_se		*se;
+	u64			off;
+	u32			len;
+	struct bio		*bio;
+	struct cbd_handler	*handler;
+};
+
+static inline void complete_cmd(struct cbd_handler *handler, u64 priv_data, int ret)
+{
+	struct cbd_ce *ce = get_compr_head(handler);
+
+	memset(ce, 0, sizeof(*ce));
+	ce->priv_data = priv_data;
+	ce->result = ret;
+	CBDC_UPDATE_COMPR_HEAD(handler->channel_info->compr_head,
+			       sizeof(struct cbd_ce),
+			       handler->channel_info->compr_size);
+
+	cbdc_flush_ctrl(&handler->channel);
+
+	return;
+}
+
+static void backend_bio_end(struct bio *bio)
+{
+	struct cbd_backend_io *backend_io = bio->bi_private;
+	struct cbd_se *se = backend_io->se;
+	struct cbd_handler *handler = backend_io->handler;
+
+	if (bio->bi_status == 0 &&
+	    cbd_se_hdr_get_op(se->header.len_op) == CBD_OP_READ) {
+		cbdc_copy_from_bio(&handler->channel, se->data_off, se->data_len, bio);
+	}
+
+	complete_cmd(handler, se->priv_data, bio->bi_status);
+
+	bio_free_pages(bio);
+	bio_put(bio);
+	kfree(backend_io);
+}
+
+static int cbd_bio_alloc_pages(struct bio *bio, size_t size, gfp_t gfp_mask)
+{
+	int ret = 0;
+
+        while (size) {
+                struct page *page = alloc_pages(gfp_mask, 0);
+                unsigned len = min_t(size_t, PAGE_SIZE, size);
+
+                if (!page) {
+			pr_err("failed to alloc page");
+			ret = -ENOMEM;
+			break;
+		}
+
+		ret = bio_add_page(bio, page, len, 0);
+                if (unlikely(ret != len)) {
+                        __free_page(page);
+			pr_err("failed to add page");
+                        break;
+                }
+
+                size -= len;
+        }
+
+	if (size)
+		bio_free_pages(bio);
+	else
+		ret = 0;
+
+        return ret;
+}
+
+static struct cbd_backend_io *backend_prepare_io(struct cbd_handler *handler, struct cbd_se *se, blk_opf_t opf)
+{
+	struct cbd_backend_io *backend_io;
+	struct cbd_backend *cbdb = handler->cbdb;
+
+	backend_io = kzalloc(sizeof(struct cbd_backend_io), GFP_KERNEL);
+	backend_io->se = se;
+
+	backend_io->handler = handler;
+	backend_io->bio = bio_alloc_bioset(cbdb->bdev, roundup(se->len, 4096) / 4096, opf, GFP_KERNEL, &handler->bioset);
+
+	backend_io->bio->bi_iter.bi_sector = se->offset >> SECTOR_SHIFT;
+	backend_io->bio->bi_iter.bi_size = 0;
+	backend_io->bio->bi_private = backend_io;
+	backend_io->bio->bi_end_io = backend_bio_end;
+
+	return backend_io;
+}
+
+static int handle_backend_cmd(struct cbd_handler *handler, struct cbd_se *se)
+{
+	struct cbd_backend *cbdb = handler->cbdb;
+	u32 len = se->len;
+	struct cbd_backend_io *backend_io = NULL;
+	int ret;
+
+	if (cbd_se_hdr_flags_test(se, CBD_SE_HDR_DONE)) {
+		return 0 ;
+	}
+
+	switch (cbd_se_hdr_get_op(se->header.len_op)) {
+	case CBD_OP_PAD:
+		cbd_se_hdr_flags_set(se, CBD_SE_HDR_DONE);
+		return 0;
+	case CBD_OP_READ:
+		backend_io = backend_prepare_io(handler, se, REQ_OP_READ);
+		break;
+	case CBD_OP_WRITE:
+		backend_io = backend_prepare_io(handler, se, REQ_OP_WRITE);
+		break;
+	case CBD_OP_DISCARD:
+		ret = blkdev_issue_discard(cbdb->bdev, se->offset >> SECTOR_SHIFT,
+				se->len, GFP_NOIO);
+		goto complete_cmd;
+	case CBD_OP_WRITE_ZEROS:
+		ret = blkdev_issue_zeroout(cbdb->bdev, se->offset >> SECTOR_SHIFT,
+				se->len, GFP_NOIO, 0);
+		goto complete_cmd;
+	case CBD_OP_FLUSH:
+		ret = blkdev_issue_flush(cbdb->bdev);
+		goto complete_cmd;
+	default:
+		pr_err("unrecognized op: %x", cbd_se_hdr_get_op(se->header.len_op));
+		ret = -EIO;
+		goto complete_cmd;
+	}
+
+	if (!backend_io)
+		return -ENOMEM;
+
+	ret = cbd_bio_alloc_pages(backend_io->bio, len, GFP_NOIO);
+	if (ret) {
+		kfree(backend_io);
+		return ret;
+	}
+
+	if (cbd_se_hdr_get_op(se->header.len_op) == CBD_OP_WRITE) {
+		cbdc_copy_to_bio(&handler->channel, se->data_off, se->data_len, backend_io->bio);
+	}
+
+	submit_bio(backend_io->bio);
+
+	return 0;
+
+complete_cmd:
+	complete_cmd(handler, se->priv_data, ret);
+	return 0;
+}
+
+static void handle_work_fn(struct work_struct *work)
+{
+	struct cbd_handler *handler = container_of(work, struct cbd_handler, handle_work.work);
+	struct cbd_se *se;
+	int ret;
+again:
+	/* channel ctrl would be updated by blkdev queue */
+	cbdc_flush_ctrl(&handler->channel);
+	se = get_se_to_handle(handler);
+	if (se == get_se_head(handler)) {
+		if (cbdwc_need_retry(&handler->handle_worker_cfg)) {
+			goto again;
+		}
+
+		cbdwc_miss(&handler->handle_worker_cfg);
+
+		queue_delayed_work(handler->handle_wq, &handler->handle_work, usecs_to_jiffies(0));
+		return;
+	}
+
+	cbdwc_hit(&handler->handle_worker_cfg);
+	cbdt_flush_range(handler->cbdb->cbdt, se, sizeof(*se));
+	ret = handle_backend_cmd(handler, se);
+	if (!ret) {
+		/* this se is handled */
+		handler->se_to_handle = (handler->se_to_handle + cbd_se_hdr_get_len(se->header.len_op)) % handler->channel_info->cmdr_size;
+	}
+
+	goto again;
+}
+
+int cbd_handler_create(struct cbd_backend *cbdb, u32 channel_id)
+{
+	struct cbd_transport *cbdt = cbdb->cbdt;
+	struct cbd_handler *handler;
+	int ret;
+
+	handler = kzalloc(sizeof(struct cbd_handler), GFP_KERNEL);
+	if (!handler) {
+		return -ENOMEM;
+	}
+
+	handler->cbdb = cbdb;
+	cbd_channel_init(&handler->channel, cbdt, channel_id);
+	handler->channel_info = handler->channel.channel_info;
+
+	handler->handle_wq = alloc_workqueue("cbdt%u-handler%u",
+					     WQ_UNBOUND | WQ_MEM_RECLAIM,
+					     0, cbdt->id, channel_id);
+	if (!handler->handle_wq) {
+		ret = -ENOMEM;
+		goto free_handler;
+	}
+
+	handler->se_to_handle = handler->channel_info->cmd_tail;
+
+	INIT_DELAYED_WORK(&handler->handle_work, handle_work_fn);
+	INIT_LIST_HEAD(&handler->handlers_node);
+
+	bioset_init(&handler->bioset, 128, 0, BIOSET_NEED_BVECS);
+	cbdwc_init(&handler->handle_worker_cfg);
+
+	cbdb_add_handler(cbdb, handler);
+	handler->channel_info->backend_state = cbdc_backend_state_running;
+
+	cbdt_flush_range(cbdt, handler->channel_info, sizeof(*handler->channel_info));
+
+	queue_delayed_work(handler->handle_wq, &handler->handle_work, 0);
+
+	return 0;
+
+free_handler:
+	kfree(handler);
+	return ret;
+};
+
+void cbd_handler_destroy(struct cbd_handler *handler)
+{
+	cbdb_del_handler(handler->cbdb, handler);
+
+	cancel_delayed_work_sync(&handler->handle_work);
+	drain_workqueue(handler->handle_wq);
+	destroy_workqueue(handler->handle_wq);
+
+	handler->channel_info->backend_state = cbdc_backend_state_none;
+	handler->channel_info->state = cbd_channel_state_none;
+	cbdt_flush_range(handler->cbdb->cbdt, handler->channel_info, sizeof(*handler->channel_info));
+
+	bioset_exit(&handler->bioset);
+	kfree(handler);
+}
diff --git a/drivers/block/cbd/cbd_transport.c b/drivers/block/cbd/cbd_transport.c
index 682d0f45ce9e..4dd9bf1b5fd5 100644
--- a/drivers/block/cbd/cbd_transport.c
+++ b/drivers/block/cbd/cbd_transport.c
@@ -303,8 +303,14 @@ static ssize_t cbd_adm_store(struct device *dev,
 
 	switch (opts.op) {
 	case CBDT_ADM_OP_B_START:
+		ret = cbd_backend_start(cbdt, opts.backend.path);
+		if (ret < 0)
+			return ret;
 		break;
 	case CBDT_ADM_OP_B_STOP:
+		ret = cbd_backend_stop(cbdt, opts.backend_id);
+		if (ret < 0)
+			return ret;
 		break;
 	case CBDT_ADM_OP_B_CLEAR:
 		break;
-- 
2.34.1


