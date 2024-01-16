Return-Path: <linux-kernel+bounces-26967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B482E8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199B6B22D32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66075F9CD;
	Tue, 16 Jan 2024 04:52:28 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDF11CBB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134630998"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134630998"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C950FD7AC6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B4F6BF3EC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A0DCF200A56C8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 3AE1E1A0160;
	Tue, 16 Jan 2024 12:52:17 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH 13/42] drivers/most: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:22 +0800
Message-Id: <20240116045151.3940401-11-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--10.159000-10.000000
X-TMASE-MatchedRID: /HyfiRbsgEU4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4eBRuAss+FbmEXjPIvKd74BMkOX0UoduudkY+KIbxMxzJmV
	7j1WQqoeX81JAaXNO9i+7Fif4mYHn05A0oQcetoRH+PTjR9EWkn607foZgOWypjlkbDvDJ4chTE
	8HzR5lQOLzNWBegCW2wgn7iDBesS0gBwKKRHe+r0Q8+QbOdksIbglQn8ZoLY0tKcBKih0F7nl2m
	Gg67VgAvGOroNWRyzw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/most/core.c:211:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:222:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:233:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:244:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:254:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:263:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:272:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:282:9-17: WARNING: please use sysfs_emit
> ./drivers/most/core.c:297:10-18: WARNING: please use sysfs_emit
> ./drivers/most/core.c:309:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:318:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:326:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:398:8-16: WARNING: please use sysfs_emit
> ./drivers/most/core.c:409:9-17: WARNING: please use sysfs_emit

No functional change intended

CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/most/core.c | 61 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7d25b0..f9ca6a7d885c 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -208,8 +208,8 @@ static ssize_t number_of_packet_buffers_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].num_buffers_packet);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].num_buffers_packet);
 }
 
 static ssize_t number_of_stream_buffers_show(struct device *dev,
@@ -219,8 +219,8 @@ static ssize_t number_of_stream_buffers_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].num_buffers_streaming);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].num_buffers_streaming);
 }
 
 static ssize_t size_of_packet_buffer_show(struct device *dev,
@@ -230,8 +230,8 @@ static ssize_t size_of_packet_buffer_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].buffer_size_packet);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].buffer_size_packet);
 }
 
 static ssize_t size_of_stream_buffer_show(struct device *dev,
@@ -241,8 +241,8 @@ static ssize_t size_of_stream_buffer_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 	unsigned int i = c->channel_id;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			c->iface->channel_vector[i].buffer_size_streaming);
+	return sysfs_emit(buf, "%d\n",
+			  c->iface->channel_vector[i].buffer_size_streaming);
 }
 
 static ssize_t channel_starving_show(struct device *dev,
@@ -251,7 +251,7 @@ static ssize_t channel_starving_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->is_starving);
+	return sysfs_emit(buf, "%d\n", c->is_starving);
 }
 
 static ssize_t set_number_of_buffers_show(struct device *dev,
@@ -260,7 +260,7 @@ static ssize_t set_number_of_buffers_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.num_buffers);
+	return sysfs_emit(buf, "%d\n", c->cfg.num_buffers);
 }
 
 static ssize_t set_buffer_size_show(struct device *dev,
@@ -269,7 +269,7 @@ static ssize_t set_buffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.buffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.buffer_size);
 }
 
 static ssize_t set_direction_show(struct device *dev,
@@ -279,10 +279,10 @@ static ssize_t set_direction_show(struct device *dev,
 	struct most_channel *c = to_channel(dev);
 
 	if (c->cfg.direction & MOST_CH_TX)
-		return snprintf(buf, PAGE_SIZE, "tx\n");
+		return sysfs_emit(buf, "tx\n");
 	else if (c->cfg.direction & MOST_CH_RX)
-		return snprintf(buf, PAGE_SIZE, "rx\n");
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+		return sysfs_emit(buf, "rx\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }
 
 static ssize_t set_datatype_show(struct device *dev,
@@ -294,10 +294,9 @@ static ssize_t set_datatype_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s",
-					ch_data_type[i].name);
+			return sysfs_emit(buf, "%s", ch_data_type[i].name);
 	}
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }
 
 static ssize_t set_subbuffer_size_show(struct device *dev,
@@ -306,7 +305,7 @@ static ssize_t set_subbuffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.subbuffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.subbuffer_size);
 }
 
 static ssize_t set_packets_per_xact_show(struct device *dev,
@@ -315,7 +314,7 @@ static ssize_t set_packets_per_xact_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.packets_per_xact);
+	return sysfs_emit(buf, "%d\n", c->cfg.packets_per_xact);
 }
 
 static ssize_t set_dbr_size_show(struct device *dev,
@@ -323,7 +322,7 @@ static ssize_t set_dbr_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.dbr_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.dbr_size);
 }
 
 #define to_dev_attr(a) container_of(a, struct device_attribute, attr)
@@ -395,7 +394,7 @@ static ssize_t description_show(struct device *dev,
 {
 	struct most_interface *iface = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", iface->description);
+	return sysfs_emit(buf, "%s\n", iface->description);
 }
 
 static ssize_t interface_show(struct device *dev,
@@ -406,25 +405,25 @@ static ssize_t interface_show(struct device *dev,
 
 	switch (iface->interface) {
 	case ITYPE_LOOPBACK:
-		return snprintf(buf, PAGE_SIZE, "loopback\n");
+		return sysfs_emit(buf, "loopback\n");
 	case ITYPE_I2C:
-		return snprintf(buf, PAGE_SIZE, "i2c\n");
+		return sysfs_emit(buf, "i2c\n");
 	case ITYPE_I2S:
-		return snprintf(buf, PAGE_SIZE, "i2s\n");
+		return sysfs_emit(buf, "i2s\n");
 	case ITYPE_TSI:
-		return snprintf(buf, PAGE_SIZE, "tsi\n");
+		return sysfs_emit(buf, "tsi\n");
 	case ITYPE_HBI:
-		return snprintf(buf, PAGE_SIZE, "hbi\n");
+		return sysfs_emit(buf, "hbi\n");
 	case ITYPE_MEDIALB_DIM:
-		return snprintf(buf, PAGE_SIZE, "mlb_dim\n");
+		return sysfs_emit(buf, "mlb_dim\n");
 	case ITYPE_MEDIALB_DIM2:
-		return snprintf(buf, PAGE_SIZE, "mlb_dim2\n");
+		return sysfs_emit(buf, "mlb_dim2\n");
 	case ITYPE_USB:
-		return snprintf(buf, PAGE_SIZE, "usb\n");
+		return sysfs_emit(buf, "usb\n");
 	case ITYPE_PCIE:
-		return snprintf(buf, PAGE_SIZE, "pcie\n");
+		return sysfs_emit(buf, "pcie\n");
 	}
-	return snprintf(buf, PAGE_SIZE, "unknown\n");
+	return sysfs_emit(buf, "unknown\n");
 }
 
 static DEVICE_ATTR_RO(description);
-- 
2.29.2


