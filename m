Return-Path: <linux-kernel+bounces-152914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA98AC60E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E15EB22044
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92D535B5;
	Mon, 22 Apr 2024 07:53:22 +0000 (UTC)
Received: from mail-m17218.xmail.ntesmail.com (mail-m17218.xmail.ntesmail.com [45.195.17.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BE4DA14;
	Mon, 22 Apr 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772401; cv=none; b=YR32zP0ltcLmL780Eq2y3AHnPTALyNbhgaa61H/x4RcEd+OewZwKxuLdMtKduj2R8QuZNneI20/R/1WI+DZTCoRPT1xPMFjAlZZGmMGUYHLOGml4df9kpdVaE3sjaLBx/7ir2mFJ4A7VENBVHUdBZbfiIlzOA7dHMs0LO+shTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772401; c=relaxed/simple;
	bh=mectESsIlJ26RxC8NLPWMGVcVNas5N+4+6uR3ITP7Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPb4dQ6oHVqGQHV6N/XdEdGEfkRMD5sXDc9kKtFO6WFPoSW0DcnxxOUXAIlyzxpoXX27J/w1AAR/l7W2AOd4FQKEelWH4k+pW9NgzYjb9b+LMFtA4633ag5X3TH/alkpjevjxFuyExyKcGX6zq/dChNlu1I3VFgWJtjiV2T6OrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 16E42860157;
	Mon, 22 Apr 2024 15:16:12 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: [PATCH 3/7] cbd: introduce cbd_channel
Date: Mon, 22 Apr 2024 07:16:02 +0000
Message-Id: <20240422071606.52637-4-dongsheng.yang@easystack.cn>
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
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDThlIVktCHR5PGk0ZTUoaT1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f04a98f99023ckunm16e42860157
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46Djo6ITc#CRwtMStKCykC
	CDwaC0xVSlVKTEpITExLSkxJQkJPVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTEpCSDcG

From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

The "cbd_channel" is the component responsible for the interaction
between the blkdev and the backend. It mainly provides the functions
"cbdc_copy_to_bio" and "cbdc_copy_from_bio".

The "cbdc_copy_to_bio" function copies data from the specified area of
the channel to the bio. Before copying, it flushes the dcache to ensure
that the data read from the channel is the latest.

The "cbdc_copy_from_bio" function copies data from the bio to the
specified area of the channel. After copying, it flushes the dcache to
ensure that other parties can see the latest data.

Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
---
 drivers/block/cbd/Makefile      |   2 +-
 drivers/block/cbd/cbd_channel.c | 179 ++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/cbd/cbd_channel.c

diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile
index a22796bfa7db..c581ae96732b 100644
--- a/drivers/block/cbd/Makefile
+++ b/drivers/block/cbd/Makefile
@@ -1,3 +1,3 @@
-cbd-y := cbd_main.o cbd_transport.o
+cbd-y := cbd_main.o cbd_transport.o cbd_channel.o
 
 obj-$(CONFIG_BLK_DEV_CBD) += cbd.o
diff --git a/drivers/block/cbd/cbd_channel.c b/drivers/block/cbd/cbd_channel.c
new file mode 100644
index 000000000000..7253523bea3c
--- /dev/null
+++ b/drivers/block/cbd/cbd_channel.c
@@ -0,0 +1,179 @@
+#include "cbd_internal.h"
+
+static ssize_t cbd_backend_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_channel_device *channel;
+	struct cbd_channel_info *channel_info;
+
+	channel = container_of(dev, struct cbd_channel_device, dev);
+	channel_info = channel->channel_info;
+
+	if (channel_info->backend_state == cbdc_backend_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", channel_info->backend_id);
+}
+
+static ssize_t cbd_blkdev_id_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_channel_device *channel;
+	struct cbd_channel_info *channel_info;
+
+	channel = container_of(dev, struct cbd_channel_device, dev);
+	channel_info = channel->channel_info;
+
+	if (channel_info->blkdev_state == cbdc_blkdev_state_none)
+		return 0;
+
+	return sprintf(buf, "%u\n", channel_info->blkdev_id);
+}
+
+static DEVICE_ATTR(backend_id, 0400, cbd_backend_id_show, NULL);
+static DEVICE_ATTR(blkdev_id, 0400, cbd_blkdev_id_show, NULL);
+
+static struct attribute *cbd_channel_attrs[] = {
+	&dev_attr_backend_id.attr,
+	&dev_attr_blkdev_id.attr,
+	NULL
+};
+
+static struct attribute_group cbd_channel_attr_group = {
+	.attrs = cbd_channel_attrs,
+};
+
+static const struct attribute_group *cbd_channel_attr_groups[] = {
+	&cbd_channel_attr_group,
+	NULL
+};
+
+static void cbd_channel_release(struct device *dev)
+{
+}
+
+struct device_type cbd_channel_type = {
+	.name		= "cbd_channel",
+	.groups		= cbd_channel_attr_groups,
+	.release	= cbd_channel_release,
+};
+
+struct device_type cbd_channels_type = {
+	.name		= "cbd_channels",
+	.release	= cbd_channel_release,
+};
+
+void cbdc_copy_to_bio(struct cbd_channel *channel,
+		u32 data_off, u32 data_len, struct bio *bio)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	void *src, *dst;
+	u32 data_head = data_off;
+	u32 to_copy, page_off = 0;
+
+	cbdt_flush_range(channel->cbdt, channel->data + data_off, data_len);
+next:
+	bio_for_each_segment(bv, bio, iter) {
+		dst = kmap_atomic(bv.bv_page);
+		page_off = bv.bv_offset;
+again:
+		if (data_head >= CBDC_DATA_SIZE) {
+			data_head &= CBDC_DATA_MASK;
+		}
+
+		src = channel->data + data_head;
+		to_copy = min(bv.bv_offset + bv.bv_len - page_off,
+			      CBDC_DATA_SIZE - data_head);
+		memcpy_flushcache(dst + page_off, src, to_copy);
+
+		/* advance */
+		data_head += to_copy;
+		page_off += to_copy;
+
+		/* more data in this bv page */
+		if (page_off < bv.bv_offset + bv.bv_len) {
+			goto again;
+		}
+		kunmap_atomic(dst);
+		flush_dcache_page(bv.bv_page);
+	}
+
+	if (bio->bi_next) {
+		bio = bio->bi_next;
+		goto next;
+	}
+
+	return;
+}
+
+void cbdc_copy_from_bio(struct cbd_channel *channel,
+		u32 data_off, u32 data_len, struct bio *bio)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	void *src, *dst;
+	u32 data_head = data_off;
+	u32 to_copy, page_off = 0;
+
+next:
+	bio_for_each_segment(bv, bio, iter) {
+		flush_dcache_page(bv.bv_page);
+
+		src = kmap_atomic(bv.bv_page);
+		page_off = bv.bv_offset;
+again:
+		if (data_head >= CBDC_DATA_SIZE) {
+			data_head &= CBDC_DATA_MASK;
+		}
+
+		dst = channel->data + data_head;
+		to_copy = min(bv.bv_offset + bv.bv_len - page_off,
+			      CBDC_DATA_SIZE - data_head);
+
+		memcpy_flushcache(dst, src + page_off, to_copy);
+
+		/* advance */
+		data_head += to_copy;
+		page_off += to_copy;
+
+		/* more data in this bv page */
+		if (page_off < bv.bv_offset + bv.bv_len) {
+			goto again;
+		}
+		kunmap_atomic(src);
+	}
+
+	if (bio->bi_next) {
+		bio = bio->bi_next;
+		goto next;
+	}
+
+	cbdt_flush_range(channel->cbdt, channel->data + data_off, data_len);
+
+	return;
+}
+
+void cbdc_flush_ctrl(struct cbd_channel *channel)
+{
+	flush_dcache_page(channel->ctrl_page);
+}
+
+void cbd_channel_init(struct cbd_channel *channel, struct cbd_transport *cbdt, u32 channel_id)
+{
+	struct cbd_channel_info *channel_info = cbdt_get_channel_info(cbdt, channel_id);
+
+	channel->cbdt = cbdt;
+	channel->channel_info = channel_info;
+	channel->channel_id = channel_id;
+	channel->cmdr = (void *)channel_info + CBDC_CMDR_OFF;
+	channel->compr = (void *)channel_info + CBDC_COMPR_OFF;
+	channel->data = (void *)channel_info + CBDC_DATA_OFF;
+	channel->data_size = CBDC_DATA_SIZE;
+	channel->ctrl_page = cbdt_page(cbdt, (void *)channel_info - (void *)cbdt->transport_info);
+
+	spin_lock_init(&channel->cmdr_lock);
+	spin_lock_init(&channel->compr_lock);
+}
-- 
2.34.1


