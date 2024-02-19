Return-Path: <linux-kernel+bounces-71735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A085A99C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01711F25FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA6482EC;
	Mon, 19 Feb 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgl0ETeR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4754654B;
	Mon, 19 Feb 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362234; cv=none; b=jHCCpe2a6Km3jdyQVO09evKx1M/ulalgIQTcRYSu/IGRDCEORaNgoEhHKWgSXe6FcgwV1wDkPJj/PrQwYcUCdLVFW215aqwCeGmqhJ6B4ctzPCOg9ZogyfdDi8EShyGIzIUSmZ6i4dD8VwJMEIsLIInr7mqsJ05BH0QrQ4s6des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362234; c=relaxed/simple;
	bh=OAnzBar8n/usXJ0HICa83AoPNDU5iTXFWBQdBXf9eqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXfEnrBD9oorBNIkA0FACxH90wLlC7V85J0eI2rF/aqLMaC1MqLtWKvcPvQQre/5CV7GVwL0c+EJqg86HgI/dPQVM5d8HGnCEWgx3hqrqGHEFoEu8GRqa8rXGMxYjGcOZgeIkSeZncjdIoPUO/WVnrEh7MceVXnew+q+KixRVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgl0ETeR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362233; x=1739898233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OAnzBar8n/usXJ0HICa83AoPNDU5iTXFWBQdBXf9eqE=;
  b=kgl0ETeRz1Ecfh/YR3TUjTmclUgxXiNYGkSl/ul5Cv+VxmZ/+cBhb/GN
   5hYRUY/BvxAjE18DTIajsmYFUPszqEjtN7nxlVjBBeXKol3LtPJjCJ3P9
   /xlzy2TqhJoHzBSU6Z8HcK27UJlvmCSLqtrgLTKxGCEO7/nI3wv5CqjKn
   aCNSm3KuOesUWoy+0kTsz0ZupSxQroFuT1Ep33V8OO7b+xID4deqBcqSd
   NxhryS/7piBoIYOKmXN3JjJMkO4y4ka+6x5UyxwnSYdUvLmQBjcq79Z8t
   kIj7ttjUjPkGsgO/wPKnRlCWT13CFx9fujIE3LYNzX2uVIX9H8xUsnNeP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577447"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315373"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315373"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6F8FFBF5; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v3 6/9] auxdisplay: ht16k33: Switch to use line display character mapping
Date: Mon, 19 Feb 2024 18:58:05 +0200
Message-ID: <20240219170337.2161754-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since line display library supports necessary bits to map the characters
(if required), switch this driver to use that.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Robin van der Gracht <robin@protonic.nl>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 103 ++++++++++-------------------------
 1 file changed, 30 insertions(+), 73 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index b76c4d83528f..41a961342dc3 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -88,11 +88,6 @@ struct ht16k33_fbdev {
 
 struct ht16k33_seg {
 	struct linedisp linedisp;
-	union {
-		struct seg7_conversion_map seg7;
-		struct seg14_conversion_map seg14;
-	} map;
-	unsigned int map_size;
 };
 
 struct ht16k33_priv {
@@ -144,33 +139,6 @@ static const struct fb_var_screeninfo ht16k33_fb_var = {
 	.vmode = FB_VMODE_NONINTERLACED,
 };
 
-static const SEG7_DEFAULT_MAP(initial_map_seg7);
-static const SEG14_DEFAULT_MAP(initial_map_seg14);
-
-static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr,
-			    char *buf)
-{
-	struct ht16k33_priv *priv = dev_get_drvdata(dev);
-
-	memcpy(buf, &priv->seg.map, priv->seg.map_size);
-	return priv->seg.map_size;
-}
-
-static ssize_t map_seg_store(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t cnt)
-{
-	struct ht16k33_priv *priv = dev_get_drvdata(dev);
-
-	if (cnt != priv->seg.map_size)
-		return -EINVAL;
-
-	memcpy(&priv->seg.map, buf, cnt);
-	return cnt;
-}
-
-static DEVICE_ATTR(map_seg7, 0644, map_seg_show, map_seg_store);
-static DEVICE_ATTR(map_seg14, 0644, map_seg_show, map_seg_store);
-
 static int ht16k33_display_on(struct ht16k33_priv *priv)
 {
 	uint8_t data = REG_DISPLAY_SETUP | REG_DISPLAY_SETUP_ON | priv->blink;
@@ -450,18 +418,19 @@ static void ht16k33_seg7_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
 	struct ht16k33_seg *seg = &priv->seg;
+	struct linedisp_map *map = seg->linedisp.map;
 	char *s = seg->linedisp.buf;
 	uint8_t buf[9];
 
-	buf[0] = map_to_seg7(&seg->map.seg7, *s++);
+	buf[0] = map_to_seg7(&map->map.seg7, *s++);
 	buf[1] = 0;
-	buf[2] = map_to_seg7(&seg->map.seg7, *s++);
+	buf[2] = map_to_seg7(&map->map.seg7, *s++);
 	buf[3] = 0;
 	buf[4] = 0;
 	buf[5] = 0;
-	buf[6] = map_to_seg7(&seg->map.seg7, *s++);
+	buf[6] = map_to_seg7(&map->map.seg7, *s++);
 	buf[7] = 0;
-	buf[8] = map_to_seg7(&seg->map.seg7, *s++);
+	buf[8] = map_to_seg7(&map->map.seg7, *s++);
 
 	i2c_smbus_write_i2c_block_data(priv->client, 0, ARRAY_SIZE(buf), buf);
 }
@@ -470,17 +439,36 @@ static void ht16k33_seg14_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
 	struct ht16k33_seg *seg = &priv->seg;
+	struct linedisp_map *map = seg->linedisp.map;
 	char *s = seg->linedisp.buf;
 	uint8_t buf[8];
 
-	put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf);
-	put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf + 2);
-	put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf + 4);
-	put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf + 6);
+	put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 0);
+	put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 2);
+	put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 4);
+	put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 6);
 
 	i2c_smbus_write_i2c_block_data(priv->client, 0, ARRAY_SIZE(buf), buf);
 }
 
+static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
+{
+	struct ht16k33_priv *priv = ht16k33_linedisp_to_priv(linedisp);
+
+	switch (priv->type) {
+	case DISP_QUAD_7SEG:
+		INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
+		return LINEDISP_MAP_SEG7;
+
+	case DISP_QUAD_14SEG:
+		INIT_DELAYED_WORK(&priv->work, ht16k33_seg14_update);
+		return LINEDISP_MAP_SEG14;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static void ht16k33_linedisp_update(struct linedisp *linedisp)
 {
 	struct ht16k33_priv *priv = ht16k33_linedisp_to_priv(linedisp);
@@ -489,6 +477,7 @@ static void ht16k33_linedisp_update(struct linedisp *linedisp)
 }
 
 static const struct linedisp_ops ht16k33_linedisp_ops = {
+	.get_map_type = ht16k33_linedisp_get_map_type,
 	.update = ht16k33_linedisp_update,
 };
 
@@ -680,37 +669,7 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 	if (err)
 		return err;
 
-	switch (priv->type) {
-	case DISP_QUAD_7SEG:
-		INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
-		seg->map.seg7 = initial_map_seg7;
-		seg->map_size = sizeof(seg->map.seg7);
-		err = device_create_file(dev, &dev_attr_map_seg7);
-		break;
-
-	case DISP_QUAD_14SEG:
-		INIT_DELAYED_WORK(&priv->work, ht16k33_seg14_update);
-		seg->map.seg14 = initial_map_seg14;
-		seg->map_size = sizeof(seg->map.seg14);
-		err = device_create_file(dev, &dev_attr_map_seg14);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-	if (err)
-		return err;
-
-	err = linedisp_register(&seg->linedisp, dev, 4, &ht16k33_linedisp_ops);
-	if (err)
-		goto err_remove_map_file;
-
-	return 0;
-
-err_remove_map_file:
-	device_remove_file(dev, &dev_attr_map_seg7);
-	device_remove_file(dev, &dev_attr_map_seg14);
-	return err;
+	return linedisp_register(&seg->linedisp, dev, 4, &ht16k33_linedisp_ops);
 }
 
 static int ht16k33_probe(struct i2c_client *client)
@@ -798,8 +757,6 @@ static void ht16k33_remove(struct i2c_client *client)
 	case DISP_QUAD_7SEG:
 	case DISP_QUAD_14SEG:
 		linedisp_unregister(&priv->seg.linedisp);
-		device_remove_file(&client->dev, &dev_attr_map_seg7);
-		device_remove_file(&client->dev, &dev_attr_map_seg14);
 		break;
 
 	default:
-- 
2.43.0.rc1.1.gbec44491f096


