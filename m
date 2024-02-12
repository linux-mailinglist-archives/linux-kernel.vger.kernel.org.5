Return-Path: <linux-kernel+bounces-62053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099C851AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D261C214A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C54D5A5;
	Mon, 12 Feb 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiefn8T+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C94652F;
	Mon, 12 Feb 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757497; cv=none; b=NM9LT4YNTRxvuWAu4OEzUA/vf2yW6ccpSvEh5SKtuzn3Y6zGpLaYFxrxBhY2D9w/f2RflxYNIIIvxd2tfd7i25hglALZb4+KMBdNh4nKoyI6Gi6WALP8WFWhiJz05Ct8uh0VeVIZBUqUwyIi+rNFvIpyHlI1TA9kHOIldgr4b/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757497; c=relaxed/simple;
	bh=FH8g0LViq9a54GUNHUMfITSFf708fBC8temf69sHlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2pfmXLGIoC7faABCKtVhSAdu967XRpciEJIVTjai+/noiNNcyB/lWnkeuen9Di+V8IxMCyY0rMMo5ByxkPrNBoj5o5CDRFweuMN5BehyddRWdLSWoF4+MY+dx8NcExi+2NUnY5bHUcUZhcLwbG4GSH+T+VjbYATF5XGhD25nEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiefn8T+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757496; x=1739293496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FH8g0LViq9a54GUNHUMfITSFf708fBC8temf69sHlcE=;
  b=eiefn8T+QGEnMSt+huirfFCg/ctPTp4hxasmG6N0LbQYFI9zNUCtzc0F
   yIYr8GWoArzdux6GbPZvRmWv7DCh1fjeeaofg6/h7mBrZ5kfYkYVKgBFC
   TnL5Bi+pSEv9qpt/27t1QYk8kCdGccELUHmOiPjODj/cKeTvgmYDkeWlB
   t/Ttfn+F+k6NiN44DRq3irsJuAbznV9onN8JRS7989RLaeRcgw7Xg/AWJ
   OgunsjGHV/fFQL08UWWdyRjSXSpAEKK+lnC5z2Nto7hDSwS+sRkMzCxq/
   +//MlkA3ww6rEFKsAdab1tEu+Rjz/X8xhtMjNkVLmYbCBoh/butwMfrkb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153236"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153236"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116829"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116829"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3100243E; Mon, 12 Feb 2024 19:04:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 13/15] auxdisplay: ht16k33: Use buffer from struct linedisp
Date: Mon, 12 Feb 2024 19:01:46 +0200
Message-ID: <20240212170423.2860895-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct linedips embedds a small buffer for the string that we may reuse.
Update the driver accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index b104f08252dd..08cc05b9d216 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -85,11 +85,6 @@ struct ht16k33_fbdev {
 	uint8_t *cache;
 };
 
-struct ht16k33_seg {
-	struct linedisp linedisp;
-	char curr[4];
-};
-
 struct ht16k33_priv {
 	struct i2c_client *client;
 	struct delayed_work work;
@@ -97,7 +92,7 @@ struct ht16k33_priv {
 	struct ht16k33_keypad keypad;
 	union {
 		struct ht16k33_fbdev fbdev;
-		struct ht16k33_seg seg;
+		struct linedisp linedisp;
 	};
 	enum display_type type;
 	uint8_t blink;
@@ -412,10 +407,9 @@ static void ht16k33_seg7_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
 						 work.work);
-	struct ht16k33_seg *seg = &priv->seg;
-	struct linedisp *linedisp = &seg->linedisp;
+	struct linedisp *linedisp = &priv->linedisp;
 	struct linedisp_map *map = linedisp->map;
-	char *s = seg->curr;
+	char *s = linedisp->curr;
 	uint8_t buf[9];
 
 	buf[0] = map_to_seg7(&map->map.seg7, *s++);
@@ -435,10 +429,9 @@ static void ht16k33_seg14_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
 						 work.work);
-	struct ht16k33_seg *seg = &priv->seg;
-	struct linedisp *linedisp = &seg->linedisp;
+	struct linedisp *linedisp = &priv->linedisp;
 	struct linedisp_map *map = linedisp->map;
-	char *s = seg->curr;
+	char *s = linedisp->curr;
 	uint8_t buf[8];
 
 	put_unaligned_le16(map_to_seg14(&map->map.seg14, *s++), buf + 0);
@@ -451,8 +444,7 @@ static void ht16k33_seg14_update(struct work_struct *work)
 
 static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
 {
-	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
-						 seg.linedisp);
+	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv, linedisp);
 
 	switch (priv->type) {
 	case DISP_MATRIX:
@@ -471,8 +463,7 @@ static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
 
 static void ht16k33_linedisp_update(struct linedisp *linedisp)
 {
-	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
-						 seg.linedisp);
+	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv, linedisp);
 
 	schedule_delayed_work(&priv->work, 0);
 }
@@ -663,14 +654,13 @@ static int ht16k33_fbdev_probe(struct device *dev, struct ht16k33_priv *priv,
 static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 			     uint32_t brightness)
 {
-	struct ht16k33_seg *seg = &priv->seg;
 	int err;
 
 	err = ht16k33_brightness_set(priv, brightness);
 	if (err)
 		return err;
 
-	return linedisp_register(&seg->linedisp, dev, 4, seg->curr, &ht16k33_linedisp_ops);
+	return linedisp_register(&priv->linedisp, dev, 4, NULL, &ht16k33_linedisp_ops);
 }
 
 static int ht16k33_probe(struct i2c_client *client)
@@ -754,7 +744,7 @@ static void ht16k33_remove(struct i2c_client *client)
 
 	case DISP_QUAD_7SEG:
 	case DISP_QUAD_14SEG:
-		linedisp_unregister(&priv->seg.linedisp);
+		linedisp_unregister(&priv->linedisp);
 		break;
 	}
 }
-- 
2.43.0.rc1.1.gbec44491f096


