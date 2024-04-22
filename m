Return-Path: <linux-kernel+bounces-152915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069B8AC60D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E211F2144C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD3535AF;
	Mon, 22 Apr 2024 07:53:22 +0000 (UTC)
Received: from mail-m105.netease.com (mail-m105.netease.com [154.81.10.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB454D9E7;
	Mon, 22 Apr 2024 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772401; cv=none; b=NJHc1vQ85Vwlw9Ou3feaKngZSOmTjTQCsRwxQnrJBAD9+wRTqnEyGVQ6I2ZYHQF/x/VzfC4i3v0V5FJndLVZYfnWHBJCEb0AepwNd7IvKVejXIKRGyx0ntbYoIrKNGUdIn7vi45YbW0OgDpOAeCOzpUiX/D2iIjCMGd0LvMKp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772401; c=relaxed/simple;
	bh=jviW9tZXwPURAzS+xFNnF3nwJL+bik14NRRnL+OpemI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELJiK1g/HJ6nUQPoyGuu5IVFSlkEk0vuRxfmOgkezD+6MvD0WSuMGHBjkb9SxLZuMrVLAsFo23JqjN6N0ogfHgD/CMX3EwxKkxEobDgmWqukWrC+OUNQh+Mgif63arhGjGpegxVLfTd6YxhgYM6iHmUBWx83lRqHxhtWd//eDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=154.81.10.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 1321286025B;
	Mon, 22 Apr 2024 15:16:13 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: [PATCH 4/7] cbd: introduce cbd_host
Date: Mon, 22 Apr 2024 07:16:03 +0000
Message-Id: <20240422071606.52637-5-dongsheng.yang@easystack.cn>
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
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSBgeVh8aSkodSkpMHUpPQlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f04a9936e023ckunm1321286025b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Igw4LTc6IxwBSDYhCyI0
	AzgKCgFVSlVKTEpITExLSkxITE5PVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBTkNNTjcG

From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

The "cbd_host" represents a host node. Each node needs to be registered
before it can use the "cbd_transport". After registration, the node's
information, such as its hostname, will be recorded in the "hosts" area
of this transport. Through this mechanism, we can know which nodes are
currently using each transport.

Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
---
 drivers/block/cbd/Makefile        |   2 +-
 drivers/block/cbd/cbd_host.c      | 123 ++++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_transport.c |   8 ++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/cbd/cbd_host.c

diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile
index c581ae96732b..2389a738b12b 100644
--- a/drivers/block/cbd/Makefile
+++ b/drivers/block/cbd/Makefile
@@ -1,3 +1,3 @@
-cbd-y := cbd_main.o cbd_transport.o cbd_channel.o
+cbd-y := cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o
 
 obj-$(CONFIG_BLK_DEV_CBD) += cbd.o
diff --git a/drivers/block/cbd/cbd_host.c b/drivers/block/cbd/cbd_host.c
new file mode 100644
index 000000000000..892961f5f1b2
--- /dev/null
+++ b/drivers/block/cbd/cbd_host.c
@@ -0,0 +1,123 @@
+#include "cbd_internal.h"
+
+static ssize_t cbd_host_name_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct cbd_host_device *host;
+	struct cbd_host_info *host_info;
+
+	host = container_of(dev, struct cbd_host_device, dev);
+	host_info = host->host_info;
+
+	cbdt_flush_range(host->cbdt, host_info, sizeof(*host_info));
+
+	if (host_info->state == cbd_host_state_none)
+		return 0;
+
+	if (strlen(host_info->hostname) == 0)
+		return 0;
+
+	return sprintf(buf, "%s\n", host_info->hostname);
+}
+
+static DEVICE_ATTR(hostname, 0400, cbd_host_name_show, NULL);
+
+CBD_OBJ_HEARTBEAT(host);
+
+static struct attribute *cbd_host_attrs[] = {
+	&dev_attr_hostname.attr,
+	&dev_attr_alive.attr,
+	NULL
+};
+
+static struct attribute_group cbd_host_attr_group = {
+	.attrs = cbd_host_attrs,
+};
+
+static const struct attribute_group *cbd_host_attr_groups[] = {
+	&cbd_host_attr_group,
+	NULL
+};
+
+static void cbd_host_release(struct device *dev)
+{
+}
+
+struct device_type cbd_host_type = {
+	.name		= "cbd_host",
+	.groups		= cbd_host_attr_groups,
+	.release	= cbd_host_release,
+};
+
+struct device_type cbd_hosts_type = {
+	.name		= "cbd_hosts",
+	.release	= cbd_host_release,
+};
+
+int cbd_host_register(struct cbd_transport *cbdt, char *hostname)
+{
+	struct cbd_host *host;
+	struct cbd_host_info *host_info;
+	u32 host_id;
+	int ret;
+
+	if (cbdt->host) {
+		return -EEXIST;
+	}
+
+	if (strlen(hostname) == 0) {
+		return -EINVAL;
+	}
+
+	ret = cbdt_get_empty_host_id(cbdt, &host_id);
+	if (ret < 0) {
+		return ret;
+	}
+
+	host = kzalloc(sizeof(struct cbd_host), GFP_KERNEL);
+	if (!host) {
+		return -ENOMEM;
+	}
+
+	host->host_id = host_id;
+	host->cbdt = cbdt;
+	INIT_DELAYED_WORK(&host->hb_work, host_hb_workfn);
+
+	host_info = cbdt_get_host_info(cbdt, host_id);
+	host_info->state = cbd_host_state_running;
+	memcpy(host_info->hostname, hostname, CBD_NAME_LEN);
+
+	cbdt_flush_range(cbdt, host_info, sizeof(*host_info));
+
+	host->host_info = host_info;
+	cbdt->host = host;
+
+	queue_delayed_work(cbd_wq, &host->hb_work, 0);
+
+	return 0;
+}
+
+int cbd_host_unregister(struct cbd_transport *cbdt)
+{
+	struct cbd_host *host = cbdt->host;
+	struct cbd_host_info *host_info;
+
+	if (!host) {
+		cbd_err("This host is not registered.");
+		return 0;
+	}
+
+	cancel_delayed_work_sync(&host->hb_work);
+	host_info = host->host_info;
+	memset(host_info->hostname, 0, CBD_NAME_LEN);
+	host_info->alive_ts = 0;
+	host_info->state = cbd_host_state_none;
+
+	cbdt_flush_range(cbdt, host_info, sizeof(*host_info));
+
+	cbdt->host = NULL;
+	kfree(cbdt->host);
+
+	return 0;
+}
diff --git a/drivers/block/cbd/cbd_transport.c b/drivers/block/cbd/cbd_transport.c
index 3a4887afab08..682d0f45ce9e 100644
--- a/drivers/block/cbd/cbd_transport.c
+++ b/drivers/block/cbd/cbd_transport.c
@@ -571,6 +571,7 @@ int cbdt_unregister(u32 tid)
 	}
 	mutex_unlock(&cbdt->lock);
 
+	cbd_host_unregister(cbdt);
 	device_unregister(&cbdt->device);
 	cbdt_dax_release(cbdt);
 	cbdt_destroy(cbdt);
@@ -624,8 +625,15 @@ int cbdt_register(struct cbdt_register_options *opts)
 		goto dax_release;
 	}
 
+	ret = cbd_host_register(cbdt, opts->hostname);
+	if (ret) {
+		goto dev_unregister;
+	}
+
 	return 0;
 
+devs_exit:
+	cbd_host_unregister(cbdt);
 dev_unregister:
 	device_unregister(&cbdt->device);
 dax_release:
-- 
2.34.1


