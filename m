Return-Path: <linux-kernel+bounces-71733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA685A997
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E840A28479E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A847F7F;
	Mon, 19 Feb 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geU7p5P0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561445949;
	Mon, 19 Feb 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362233; cv=none; b=ciJ7F9FGB2zt0V+x91LTm2q/Kxrcb2t3pgcQ8uO8f1bxnIRMPEYwHWtVfMTi7G6bx31wgzyDSP4U0PmkKprD3KkhErxGiDGimzXJYTqXvNIHqazWNOocox+KEfpC86Imc2YyAuj2+iauK7hVwySNyXbLFsdMNkTLoLDcY7OzbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362233; c=relaxed/simple;
	bh=WXC5x/5xpsIn2kxjIiHl+pWHnAC7qY7YPJf9uH9AyEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/xM/UXhmLltQRNZ8ndmRdjlkXkUNieU8fJxoLot7PEeuxeygfZ0Rt2VsM0OwX79qnwWr9afN9Q7qlpWyyzSCNXYgxoMElG9L1/h6K1Ah3jd78sM++VVcxgN7M53KePiT2dqp1B8VSoRwmdVcVW5js6VQh0h1/mIKjzwyRzX64Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geU7p5P0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362232; x=1739898232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXC5x/5xpsIn2kxjIiHl+pWHnAC7qY7YPJf9uH9AyEE=;
  b=geU7p5P0zG7fRQOH5nxDPNckY5X5Sz0mU/ot44VerWOgR5rzxKzTCqYP
   LhlEU2/B1RKvFkYIhOCCgDfIchPuGjWOCcpm8d19Vr/WQxMZXu2o8jJwu
   ac6MSm4PaUoR8r1YYcGArZedj6j0f8aGdFtBkWwutVlzKwrpp+Tef4vFZ
   LmYPL/zEgoWVanGUyytQQiF1tPn//1br67I98NT2ID1BaH+dlGT4qvf3o
   TKhZWl9+uDKmebvNLfoAqpUe+qNHnxzA9hU1SWdVW/kSM+QwnFfgtTTB9
   UCzRXcZyFJVaaBR5GSI/8mwggk+wnQdqNw7sW+f+2mUi59lart6dfrdDN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577442"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577442"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315370"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315370"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7EB47FF3; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
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
Subject: [PATCH v3 7/9] auxdisplay: ht16k33: Drop struct ht16k33_seg
Date: Mon, 19 Feb 2024 18:58:06 +0200
Message-ID: <20240219170337.2161754-8-andriy.shevchenko@linux.intel.com>
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

The struct ht16k33_seg is repeating struct linedisp. Use the latter
directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 41a961342dc3..96acfb2b58cd 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -86,10 +86,6 @@ struct ht16k33_fbdev {
 	uint8_t *cache;
 };
 
-struct ht16k33_seg {
-	struct linedisp linedisp;
-};
-
 struct ht16k33_priv {
 	struct i2c_client *client;
 	struct delayed_work work;
@@ -97,7 +93,7 @@ struct ht16k33_priv {
 	struct ht16k33_keypad keypad;
 	union {
 		struct ht16k33_fbdev fbdev;
-		struct ht16k33_seg seg;
+		struct linedisp linedisp;
 	};
 	enum display_type type;
 	uint8_t blink;
@@ -110,7 +106,7 @@ struct ht16k33_priv {
 	container_of(p, struct ht16k33_priv, led)
 
 #define ht16k33_linedisp_to_priv(p)			\
-	container_of(p, struct ht16k33_priv, seg.linedisp)
+	container_of(p, struct ht16k33_priv, linedisp)
 
 static const struct fb_fix_screeninfo ht16k33_fb_fix = {
 	.id		= DRIVER_NAME,
@@ -417,9 +413,8 @@ static void ht16k33_keypad_stop(struct input_dev *dev)
 static void ht16k33_seg7_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
-	struct ht16k33_seg *seg = &priv->seg;
-	struct linedisp_map *map = seg->linedisp.map;
-	char *s = seg->linedisp.buf;
+	struct linedisp_map *map = priv->linedisp.map;
+	char *s = priv->linedisp.buf;
 	uint8_t buf[9];
 
 	buf[0] = map_to_seg7(&map->map.seg7, *s++);
@@ -438,9 +433,8 @@ static void ht16k33_seg7_update(struct work_struct *work)
 static void ht16k33_seg14_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
-	struct ht16k33_seg *seg = &priv->seg;
-	struct linedisp_map *map = seg->linedisp.map;
-	char *s = seg->linedisp.buf;
+	struct linedisp_map *map = priv->linedisp.map;
+	char *s = priv->linedisp.buf;
 	uint8_t buf[8];
 
 	put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 0);
@@ -662,14 +656,14 @@ static int ht16k33_fbdev_probe(struct device *dev, struct ht16k33_priv *priv,
 static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 			     uint32_t brightness)
 {
-	struct ht16k33_seg *seg = &priv->seg;
+	struct linedisp *linedisp = &priv->linedisp;
 	int err;
 
 	err = ht16k33_brightness_set(priv, brightness);
 	if (err)
 		return err;
 
-	return linedisp_register(&seg->linedisp, dev, 4, &ht16k33_linedisp_ops);
+	return linedisp_register(linedisp, dev, 4, &ht16k33_linedisp_ops);
 }
 
 static int ht16k33_probe(struct i2c_client *client)
@@ -756,7 +750,7 @@ static void ht16k33_remove(struct i2c_client *client)
 
 	case DISP_QUAD_7SEG:
 	case DISP_QUAD_14SEG:
-		linedisp_unregister(&priv->seg.linedisp);
+		linedisp_unregister(&priv->linedisp);
 		break;
 
 	default:
-- 
2.43.0.rc1.1.gbec44491f096


