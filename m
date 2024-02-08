Return-Path: <linux-kernel+bounces-58551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A458984E7EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E101C26161
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED87250ED;
	Thu,  8 Feb 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhuRbQhV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A8208C6;
	Thu,  8 Feb 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417954; cv=none; b=ltluBwFqI4ozoR0I0SOP64EcVRJ46En31qmL1T9rnGpPq9yCA/6+fuaM3mYfypn3JlR3Zl0k8Jd5R3r1darTEmC1ml7MRmhozDZV2qPjRHElGACEOD2e71sKtPQbuLFI8HqQBNADg4OodpPSZ1CbUQq9CzlRuVViOVLIEIBhnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417954; c=relaxed/simple;
	bh=FH8g0LViq9a54GUNHUMfITSFf708fBC8temf69sHlcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKjuhCbg7mHz+hgS+wT7T9AHonoelFh9SVRRrmL7AAZUiJLaqrt63V1TjzeKzyimVTrG63X8ChHZW/7DPu5IIzN5tkcJRoXKDRQqrHCbpCquqRIVCC3RkVCLT5GJonhe+eQ0p8+BFPvR08GhtsGBpsy1rnLnigY8WfaVvJXL4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhuRbQhV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417953; x=1738953953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FH8g0LViq9a54GUNHUMfITSFf708fBC8temf69sHlcE=;
  b=fhuRbQhVD6PU8cQoVZ5Omd7ZI/53Xf5Jy2txHZFvz5Z1m/MrNl0Uqjix
   5vCot3LNWUq0pGCCV8R+jhS6XGPubm3UnhtPauK9m4OfWtg7Cu4BTl5Uf
   /5kpN1SLUfZjqfiQuLyznaBGMI8M1LJwvxyA9iBmUt4Ac5cNBoP2tY6Hd
   s/AeRX9GU+K46w+6GarH5zOuWnaVVJnE19z1zztJb0ZUEtgYhthlqRv6/
   Ub9JtuhSeoXkGmEdCHh+6YWDYhNWv7NiZJJX70+01rN7fxkvfMtHL8sUw
   fe7kMnoVZ9LsEPCaZo9K/4CpBTeSJMh8t9nmGvmfvRxLSVkJrLjm+JEhw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="4271444"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="4271444"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824919038"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="824919038"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2024 10:45:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 980CF15E0; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Date: Thu,  8 Feb 2024 18:58:56 +0200
Message-ID: <20240208165937.2221193-14-andriy.shevchenko@linux.intel.com>
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


