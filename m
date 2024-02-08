Return-Path: <linux-kernel+bounces-58582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 529BE84E884
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB8E1F2E5A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746754CE08;
	Thu,  8 Feb 2024 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juptwNZH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220B364A5;
	Thu,  8 Feb 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418179; cv=none; b=VQACZ2k3/xuXYl4SclvmKNJ0EKL98Hhq23ZOcNyowt81lQgnxsg1q34scxjv+n/eiuRXnRcxHWSIOnRST4oRKf6o9Kl5qkA+5WVGcuUKk2bi0zi5vNe9VHCschTDBqC3Q2bVFpaB2gm7AeFZZuoii67QLXrq2asfuLCEwetQXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418179; c=relaxed/simple;
	bh=xY52GBdbWlUZAfmSG2absg3scItgooHoNN72W48Llrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7JXTSTs7mKWx/G2XiEvpFz5K+t1e2/dOwASCoXONnyXypwQUJw7D2v3azUpIFCHZRaukCKhDY04bMMDBZjPNJ84zPdxIqiygpOM0gQI4Pdja0qpRFkRHK+gZOJN7y41DV5+A19qCJbm7vAHVRVGEu0GH4k5PoKrDbCCbEO1rUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juptwNZH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418174; x=1738954174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xY52GBdbWlUZAfmSG2absg3scItgooHoNN72W48Llrw=;
  b=juptwNZH2fQxy9z/+VkHzyhPXxQ0fqx9xxjARYgTLx82ymngkVIB+7n7
   IDznOe1l9HMoqb89DTAXL0yyntY0S0mzLRkaXvmxgc67srbTL7WPx5URh
   EF1x1bc+lkgbUEI5y7h7j3tMj/NyjLZEFA+TL5QqsfeY//MQk+f68bKRW
   nO3yl8+nXROR1WeQKKS+eYHPib+XsyM9LoBrAqmaaDgxwf9wA+GY9R6Wd
   uZdVaaYUCCv4O4eiu6w3bO2FT9Wl8TsqntWNrPLn1wlzrFP79pCTV0gmN
   13dosrdYdozj+yOpOnNcBJEn/e1ePzUcV29BQB8qc5PJ6uMcb8sUDL2Vj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186145"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215539"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215539"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A22571027; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Subject: [PATCH v1 12/15] auxdisplay: ht16k33: Switch to use line display character mapping
Date: Thu,  8 Feb 2024 20:48:10 +0200
Message-ID: <20240208184919.2224986-13-andriy.shevchenko@linux.intel.com>
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

Since line display library supports necessary bits to map the characters
(if required), switch this driver to use that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 109 +++++++++++------------------------
 1 file changed, 34 insertions(+), 75 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 75c4a8d31642..b104f08252dd 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -87,11 +87,6 @@ struct ht16k33_fbdev {
 
 struct ht16k33_seg {
 	struct linedisp linedisp;
-	union {
-		struct seg7_conversion_map seg7;
-		struct seg14_conversion_map seg14;
-	} map;
-	unsigned int map_size;
 	char curr[4];
 };
 
@@ -135,33 +130,6 @@ static const struct fb_var_screeninfo ht16k33_fb_var = {
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
@@ -445,18 +413,20 @@ static void ht16k33_seg7_update(struct work_struct *work)
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
 						 work.work);
 	struct ht16k33_seg *seg = &priv->seg;
+	struct linedisp *linedisp = &seg->linedisp;
+	struct linedisp_map *map = linedisp->map;
 	char *s = seg->curr;
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
@@ -466,17 +436,39 @@ static void ht16k33_seg14_update(struct work_struct *work)
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
 						 work.work);
 	struct ht16k33_seg *seg = &priv->seg;
+	struct linedisp *linedisp = &seg->linedisp;
+	struct linedisp_map *map = linedisp->map;
 	char *s = seg->curr;
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
+	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
+						 seg.linedisp);
+
+	switch (priv->type) {
+	case DISP_MATRIX:
+		/* not handled here */
+		return -EINVAL;
+
+	case DISP_QUAD_7SEG:
+		INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
+		return LINEDISP_MAP_SEG7;
+
+	case DISP_QUAD_14SEG:
+		INIT_DELAYED_WORK(&priv->work, ht16k33_seg14_update);
+		return LINEDISP_MAP_SEG14;
+	}
+}
+
 static void ht16k33_linedisp_update(struct linedisp *linedisp)
 {
 	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
@@ -486,6 +478,7 @@ static void ht16k33_linedisp_update(struct linedisp *linedisp)
 }
 
 static const struct linedisp_ops ht16k33_linedisp_ops = {
+	.get_map_type = ht16k33_linedisp_get_map_type,
 	.update = ht16k33_linedisp_update,
 };
 
@@ -677,39 +670,7 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 	if (err)
 		return err;
 
-	switch (priv->type) {
-	case DISP_MATRIX:
-		/* not handled here */
-		err = -EINVAL;
-		break;
-
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
-	}
-	if (err)
-		return err;
-
-	err = linedisp_register(&seg->linedisp, dev, 4, seg->curr, &ht16k33_linedisp_ops);
-	if (err)
-		goto err_remove_map_file;
-
-	return 0;
-
-err_remove_map_file:
-	device_remove_file(dev, &dev_attr_map_seg7);
-	device_remove_file(dev, &dev_attr_map_seg14);
-	return err;
+	return linedisp_register(&seg->linedisp, dev, 4, seg->curr, &ht16k33_linedisp_ops);
 }
 
 static int ht16k33_probe(struct i2c_client *client)
@@ -794,8 +755,6 @@ static void ht16k33_remove(struct i2c_client *client)
 	case DISP_QUAD_7SEG:
 	case DISP_QUAD_14SEG:
 		linedisp_unregister(&priv->seg.linedisp);
-		device_remove_file(&client->dev, &dev_attr_map_seg7);
-		device_remove_file(&client->dev, &dev_attr_map_seg14);
 		break;
 	}
 }
-- 
2.43.0.rc1.1.gbec44491f096


