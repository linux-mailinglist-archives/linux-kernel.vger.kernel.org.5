Return-Path: <linux-kernel+bounces-58577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8584E87F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F9F1C29C51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7664CB22;
	Thu,  8 Feb 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe+uwKCP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A5364AC;
	Thu,  8 Feb 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418178; cv=none; b=eAZXDONKZMkDYXKGescd/qNd30enCPzmZndRFn9ZSPhtejnflBU5svTvStXhg8sGIMB7hKTrJlWGzi5a06Eshe+KMn08XTGjWUoVtfaDtYTpBHUkT6PQqE9oRia7MzKI+4Eu67VEnFTd1g0Mzoxp0TRK7z5KV89bTl5XNB5FgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418178; c=relaxed/simple;
	bh=D9KNXApzrQn/zL4buEhPq3QKCgL53LOywh6Etg3+aBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHeXwGDXNw8tEwRUHpKVmsNPWldncZYsrcllgwnYFW9U1my+fRPk0uWTyViUqpJP3QG0fM/w+A55QNlHiVd/qXVliyLFXsA76oKD42GCTRlSBEWI8Zq9TfLp6INSBToulHcnbWi4cKgnvHlXaqvNBtqciXvNBLvjyJGb1Ad5cEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe+uwKCP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418174; x=1738954174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9KNXApzrQn/zL4buEhPq3QKCgL53LOywh6Etg3+aBQ=;
  b=Pe+uwKCP5wWcTI3OVyueNad9nlAVHlmgivd/tDuk8jnFOll/ptbxBN7R
   d1/qq97MKt4jvAW+w/i8jUPP9zErlewuXze3Y4rRHRetWYuUkX4eo3Ye0
   AuF05TOKA+pMfkDFYgHRwC5yfH8ZRFRwozczCcfQmXrULu2/mk+UP4tV+
   99d3neBQy59Jcgkord1B99lgqXgEhtI7rJzObBjr+aP+GrGHYCA4FURmS
   izxbbhucV/+2MAqTjNn0+pardZQ6chf6bF2LVaiwY27WFr1i9ZdvkSgU0
   SawjYMX3L+jePM/IQAEWK7bZREDm8Dd8sS5dLcxPU/0znN8XWxW214Sj9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186135"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215535"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215535"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8401AF23; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 09/15] auxdisplay: linedisp: Add support for overriding character mapping
Date: Thu,  8 Feb 2024 20:48:07 +0200
Message-ID: <20240208184919.2224986-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already the driver using character mapping table for
7 or 14 segment display. It is possible to override it. Make
the similar in the line display library to allow other drivers
to utilise the same functionality.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 111 +++++++++++++++++++++++++++++-
 drivers/auxdisplay/line-display.h |  31 +++++++++
 2 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 62e8a911bb12..da47fc59f6cb 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -22,6 +22,9 @@
 #include <linux/sysfs.h>
 #include <linux/timer.h>
 
+#include <linux/map_to_7segment.h>
+#include <linux/map_to_14segment.h>
+
 #include "line-display.h"
 
 #define DEFAULT_SCROLL_RATE	(HZ / 2)
@@ -188,12 +191,71 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 
 static DEVICE_ATTR_RW(scroll_step_ms);
 
+static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp_map *map = linedisp->map;
+
+	memcpy(buf, &map->map, map->size);
+	return map->size;
+}
+
+static ssize_t map_seg_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp_map *map = linedisp->map;
+
+	if (count != map->size)
+		return -EINVAL;
+
+	memcpy(&map->map, buf, count);
+	return count;
+}
+
+static const SEG7_DEFAULT_MAP(initial_map_seg7);
+static DEVICE_ATTR(map_seg7, 0644, map_seg_show, map_seg_store);
+
+static const SEG14_DEFAULT_MAP(initial_map_seg14);
+static DEVICE_ATTR(map_seg14, 0644, map_seg_show, map_seg_store);
+
 static struct attribute *linedisp_attrs[] = {
 	&dev_attr_message.attr,
 	&dev_attr_scroll_step_ms.attr,
-	NULL,
+	&dev_attr_map_seg7.attr,
+	&dev_attr_map_seg14.attr,
+	NULL
 };
-ATTRIBUTE_GROUPS(linedisp);
+
+static umode_t linedisp_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp_map *map = linedisp->map;
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_map_seg7.attr) {
+		if (!map)
+			return 0;
+		if (map->type != LINEDISP_MAP_SEG7)
+			return 0;
+	}
+
+	if (attr == &dev_attr_map_seg14.attr) {
+		if (!map)
+			return 0;
+		if (map->type != LINEDISP_MAP_SEG14)
+			return 0;
+	}
+
+	return mode;
+};
+
+static const struct attribute_group linedisp_group = {
+	.is_visible	= linedisp_attr_is_visible,
+	.attrs		= linedisp_attrs,
+};
+__ATTRIBUTE_GROUPS(linedisp);
 
 static DEFINE_IDA(linedisp_id);
 
@@ -201,6 +263,7 @@ static void linedisp_release(struct device *dev)
 {
 	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
 
+	kfree(linedisp->map);
 	kfree(linedisp->message);
 	ida_free(&linedisp_id, linedisp->id);
 }
@@ -210,6 +273,44 @@ static const struct device_type linedisp_type = {
 	.release = linedisp_release,
 };
 
+static int linedisp_init_map(struct linedisp *linedisp)
+{
+	struct linedisp_map *map;
+	int err;
+
+	if (!linedisp->ops->get_map_type)
+		return 0;
+
+	err = linedisp->ops->get_map_type(linedisp);
+	if (err < 0)
+		return err;
+
+	map = kmalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	map->type = err;
+
+	/* assign initial mapping */
+	switch (map->type) {
+	case LINEDISP_MAP_SEG7:
+		map->map.seg7 = initial_map_seg7;
+		map->size = sizeof(map->map.seg7);
+		break;
+	case LINEDISP_MAP_SEG14:
+		map->map.seg14 = initial_map_seg14;
+		map->size = sizeof(map->map.seg14);
+		break;
+	default:
+		kfree(map);
+		return -EINVAL;
+	}
+
+	linedisp->map = map;
+
+	return 0;
+}
+
 /**
  * linedisp_register - register a character line display
  * @linedisp: pointer to character line display structure
@@ -241,6 +342,11 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	device_initialize(&linedisp->dev);
 	dev_set_name(&linedisp->dev, "linedisp.%u", linedisp->id);
 
+	/* initialise a character mapping, if required */
+	err = linedisp_init_map(linedisp);
+	if (err)
+		goto out_put_device;
+
 	/* initialise a timer for scrolling the message */
 	timer_setup(&linedisp->timer, linedisp_scroll, 0);
 
@@ -259,6 +365,7 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	device_del(&linedisp->dev);
 out_del_timer:
 	del_timer_sync(&linedisp->timer);
+out_put_device:
 	put_device(&linedisp->dev);
 	return err;
 }
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index a4f0d1bf5848..65d782111f53 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -14,13 +14,43 @@
 #include <linux/device.h>
 #include <linux/timer_types.h>
 
+#include <linux/map_to_7segment.h>
+#include <linux/map_to_14segment.h>
+
 struct linedisp;
 
+/**
+ * enum linedisp_map_type - type of the character mapping
+ * @LINEDISP_MAP_SEG7: Map characters to 7 segment display
+ * @LINEDISP_MAP_SEG14: Map characters to 14 segment display
+ */
+enum linedisp_map_type {
+	LINEDISP_MAP_SEG7,
+	LINEDISP_MAP_SEG14,
+};
+
+/**
+ * struct linedisp_map - character mapping
+ * @type: type of the character mapping
+ * @map: conversion character mapping
+ * @size: size of the @map
+ */
+struct linedisp_map {
+	enum linedisp_map_type type;
+	union {
+		struct seg7_conversion_map seg7;
+		struct seg14_conversion_map seg14;
+	} map;
+	unsigned int size;
+};
+
 /**
  * struct linedisp_ops - character line display operations
+ * @get_map_type: Function called to get the character mapping, if required
  * @update: Function called to update the display. This must not sleep!
  */
 struct linedisp_ops {
+	int (*get_map_type)(struct linedisp *linedisp);
 	void (*update)(struct linedisp *linedisp);
 };
 
@@ -42,6 +72,7 @@ struct linedisp {
 	unsigned int id;
 	struct timer_list timer;
 	const struct linedisp_ops *ops;
+	struct linedisp_map *map;
 	char *buf;
 	char *message;
 	unsigned int num_chars;
-- 
2.43.0.rc1.1.gbec44491f096


