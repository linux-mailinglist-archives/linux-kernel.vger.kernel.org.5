Return-Path: <linux-kernel+bounces-58584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C192484E88C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07941C29222
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70C4F1E7;
	Thu,  8 Feb 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6Dh9ahQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF7383B8;
	Thu,  8 Feb 2024 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418181; cv=none; b=NHmZMaeCGqo+6NRxYsyvYiBgVVKb8Y3W4BW2UhUBsFoSIEqf1UUTIX9EHQckgioxRX47mtahgUxWRT/Q8Qe4Ku9W0RKvTIRjwSJ95zbjSZJmRhv9MgmtuWi5AoOZ3T+crN1RIzC41/5kKHvO2L7gUtW+tnoScJmAsb2wKslcI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418181; c=relaxed/simple;
	bh=FH8g0LViq9a54GUNHUMfITSFf708fBC8temf69sHlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6SjRyrNyNpZ0Xus86ygZizkbbHHqp/eUUAvomUBT9OavnXCe3PBkU05f+rxN2+WgnKp2PfoeyH+FD3eyKRasTX24En2crQZK88CgjcsViZ++tNMGr79OAAutpzGeSSaxCBjWaP6IkXCYZRKuPen71b1ts0n2/H9RQND1E1XaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6Dh9ahQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418179; x=1738954179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FH8g0LViq9a54GUNHUMfITSFf708fBC8temf69sHlcE=;
  b=h6Dh9ahQP+rCEf+4jUtz0ewl+O6oqSwcustfIP0OfKv409rJSY2/WEMV
   wSwl1ktHrg2UCt7yLoBYqhdIKCkMcz4a9ZsKx6F7qtR1fpob8AtIslzt5
   EYJDVdzhlhMIrpkKXp7NVDNZAR1fQvUhFZu2cm68cpi4nr3+wpzbRDPeh
   Z3db5VfAHGBBwVV9Ut1wCJpj5VBUk7G6pSr/EZuTC/jiHrjTJci2RU7Sw
   rIWY52bLD7WxuIDHrCE5yBUDdqvQKkfNkledkqFdqIFxN6kraB8R47SOa
   xrhVECBYRWifZW4TJ4bMZ3zXOy47ahlmGLYKzbPEWnxFz2tN9gL6+T9vR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186152"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186152"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215541"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215541"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AC41CF4D; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Subject: [PATCH v1 13/15] auxdisplay: ht16k33: Use buffer from struct linedisp
Date: Thu,  8 Feb 2024 20:48:11 +0200
Message-ID: <20240208184919.2224986-14-andriy.shevchenko@linux.intel.com>
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


