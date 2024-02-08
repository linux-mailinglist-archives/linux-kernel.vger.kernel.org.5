Return-Path: <linux-kernel+bounces-58550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA08784E7EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B091F2CE62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D7F2421D;
	Thu,  8 Feb 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfR2G88u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC9208BC;
	Thu,  8 Feb 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417954; cv=none; b=LQqWbAA3IdaTkCSDHMy6Sp/EBKWogtpUj2sGscK1af2qm0AM/3S6QIbKfRnN6ArsAJE8jnauTaf3VOYXrXHVuPfakCeBUzP4adwBMbqUd1o6weVyvyj/duum3K63ZFNPlCB36KD2BkaPcJ33dAd0FvtTDhK5sJd8M9/nxBGQt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417954; c=relaxed/simple;
	bh=xY52GBdbWlUZAfmSG2absg3scItgooHoNN72W48Llrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW8M91K6rxplNSPnrijauR1Xs6DDdgTaUbONEf0kBZRjI51MRnEZzzKzgiwZ7e/qZM8wrWJlxSHxMw0wj/E5r0TAJoHJ7RQd3crN4iHG/Gnzz2hdei3R8KEIWj/bx2WTgKIi/C1h7z2DEAOe1Pa143CPgqQmvSg3JiOjQYEBa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfR2G88u; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417953; x=1738953953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xY52GBdbWlUZAfmSG2absg3scItgooHoNN72W48Llrw=;
  b=mfR2G88us051XD8UhJnDdctSAup13yIQ4RrvrOMBM3rJCu+wnkxPMZ6/
   e4I85sdnZLCdNoNJNzJpEgfWHzUGCNK2bDm0Y286caroiY/cyYx6luSUX
   SPKw2m5UIggChvA42vI5fb7opys45t3dfehdDtJw3795y+erItCLhz706
   95WodP7EulmmRkiSuW+n7xqhmmXI4XsW/JLaPf09M/oiT4W7PKFKgTb82
   zogTPBMvhXdQw9zT1cTIavXWr57qwX0YX4dl+abjhUcLHdonzVaPq0qpy
   JLERqoYZuhD1KCn4BDzoWMnLHFjbXMFcaRAYo4A21wPzMowlSZIcUiZKh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1185236"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1185236"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934214461"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934214461"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:45:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 87EBF1555; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Date: Thu,  8 Feb 2024 18:58:55 +0200
Message-ID: <20240208165937.2221193-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
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


