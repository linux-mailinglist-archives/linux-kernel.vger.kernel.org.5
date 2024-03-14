Return-Path: <linux-kernel+bounces-103035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A6587BA31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB539284BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17B6BFDD;
	Thu, 14 Mar 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QiTBZ37F"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4BC46A2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407822; cv=none; b=p05GW3qt9PuXlVMzBXLND6dgxB350umE7cLbvgUMM/twd7xgn3e8ymhAfdG+U2uacoh3aEEIGo2995i3wkhdl68At5D1yLF4OXmlcz41/sYK0mR7z2crYvSz0JwpImV+Iv+Y+mYETy2O2Kvd5qMaAhN7/E+IhRdlF9kOX2Cnyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407822; c=relaxed/simple;
	bh=lr9+v2IB+JR7DusEwaoblEkG88VOyqqsZSAEdqwtAB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R4zhm8FqdEmxgxUN35o7y66QI3uyda0CN+L5Vi/9TkPbI/kMAmyOcIROwGrbm/E53sPZCUckqyZq5NFBIfCQKRVimqZJ8u5xTahIQjy57Oxq2pgwjybZ3kAtgviaEf8smVvkYHSyeXXygDA0Z3Vz68Ou+S1nhwK+HsF+o8TD/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QiTBZ37F; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710407820; x=1741943820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lr9+v2IB+JR7DusEwaoblEkG88VOyqqsZSAEdqwtAB0=;
  b=QiTBZ37FSecCk3QFu5ypMgNZd0O5VE4lXW6MkkYPAnedswDg0XLvMcyh
   mqtaiQ4hYuFODjQhEu63X4vyrrT8gcHEZuAxuY6rA17BR9AHKhhI63WvU
   9Kod3ovG94DP+PRup0r/K3UZpbFEbxTo9XajJl90yHmD2N7iud3DZdnyF
   RokATXFwmWd6tnRk48cg29P7XFcOoH1WCdsV5ohghDXO9d2IZhtf9NN+G
   mPiZw1A4LHj0kbRr/sBIyMbDSFS3QRwOQs2oXHN8Tc517NJhW2Fkwa1K6
   HiY2y/TqQKlcyLNwi6bnNI1Z+Gl/AN95SQNFixWmY577WX54lLVf5yzpT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="139868665"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="139868665"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:15:47 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BAD3CE960F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:15:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id F1BE142617
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:15:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 82D8A6B4C5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:15:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 06AA41A006B;
	Thu, 14 Mar 2024 17:15:43 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH v2] most: core: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:15:40 +0800
Message-Id: <20240314091540.1323705-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--10.408400-10.000000
X-TMASE-MatchedRID: Wjit8FvAQ5E4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS/sUSFaCjTLxN8rmPQRlvK7oFQ8GRC1Prs1w
	waYBQLgs9/vFVBxxqgB0XJlVTsEsboYY7KoErjW8ReM8i8p3vgEyQ5fRSh265PHMAbjuhwd/Ivl
	CZY6Ax8Fufq15/CWkZ9G2EY/cG6Pkh3Xy1KnQIRHV7tdtvoibaF430d3dMHkYXYiB2XAP72hhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vo3rSSRyb+22+WfivYUdqrtScSy9eU9HwdukD
	ivnE4CQlMVXlrC29fg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/most/core.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7d25b0..412cb34ce768 100644
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
@@ -294,10 +294,10 @@ static ssize_t set_datatype_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s",
-					ch_data_type[i].name);
+			return sysfs_emit(buf, "%s",
+					  ch_data_type[i].name);
 	}
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+	return sysfs_emit(buf, "unconfigured\n");
 }
 
 static ssize_t set_subbuffer_size_show(struct device *dev,
@@ -306,7 +306,7 @@ static ssize_t set_subbuffer_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.subbuffer_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.subbuffer_size);
 }
 
 static ssize_t set_packets_per_xact_show(struct device *dev,
@@ -315,7 +315,7 @@ static ssize_t set_packets_per_xact_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.packets_per_xact);
+	return sysfs_emit(buf, "%d\n", c->cfg.packets_per_xact);
 }
 
 static ssize_t set_dbr_size_show(struct device *dev,
@@ -323,7 +323,7 @@ static ssize_t set_dbr_size_show(struct device *dev,
 {
 	struct most_channel *c = to_channel(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", c->cfg.dbr_size);
+	return sysfs_emit(buf, "%d\n", c->cfg.dbr_size);
 }
 
 #define to_dev_attr(a) container_of(a, struct device_attribute, attr)
@@ -395,7 +395,7 @@ static ssize_t description_show(struct device *dev,
 {
 	struct most_interface *iface = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", iface->description);
+	return sysfs_emit(buf, "%s\n", iface->description);
 }
 
 static ssize_t interface_show(struct device *dev,
@@ -406,25 +406,25 @@ static ssize_t interface_show(struct device *dev,
 
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


