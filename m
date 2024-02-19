Return-Path: <linux-kernel+bounces-71731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9594185A996
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0591C23B73
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717347F65;
	Mon, 19 Feb 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrDmBRPm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC244C93;
	Mon, 19 Feb 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362232; cv=none; b=lMX2NYx+9BEdEtEvi+eS+Ce/2hFzaZ6+XZIfd0sk9nVJC6iUg3bpMx0u4pqQTh/ZPETsWI6pyzzsJckqUfpY4y+K/J/ASkb+Cir+wUHFiZSUPhQJ42toMieyC3lknaDZhyYfyjCfCASfhKiGVFfj4FNKrhvX0ObywudZfXCcas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362232; c=relaxed/simple;
	bh=nTLPN95Vl8V4f80BsBvGNYRqiV1i3kk//8sITOoQ8ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YE/ooqr4Po46CfkKdfl2Tb5FjJeUY2FiKDe37D9HEufATocrsuXlW4L7OSd1VgGsKC8SdMmmvg6i7VCrkwnmWX4rClvSkDHeH/aEcsWN2mnw6opAPgKsZ1BYn3dxJU324h2YvwmJDRgw9S+S5QWlNQoc0Yy1SI073g67WJKofVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrDmBRPm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362231; x=1739898231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTLPN95Vl8V4f80BsBvGNYRqiV1i3kk//8sITOoQ8ck=;
  b=HrDmBRPm5lUDbn4/JL6Ci2TMDGSFhUsDahImeHq/II8Bhtf2yiXiCgL6
   VYPyYIXVNVmnWw5ZMpdk7JN3EyeToPjirfmM8mpMsG6mzr9U2zLylSHKA
   sEQWfAeQRDO9FmSBKqEue1QIMy511x7+iAqUgDZAoxhx0wjOOxOJq+QDv
   wq1NvQ4Q3ZM2ola1RC0LOtsRS/fqlsZDEGWnjWNBv5VJJcPRJWnwMySiV
   UnpYMEDbPgaOSkKWNnBbtJrF+4zUq5gFSmqljsd1oRgYN5xJXkSVnN+oF
   TKKepMoOwWIwfeT8kY3qoCf6ttk5FUCiuuq43eBPBHyfRmT+LVl2hk/o9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577433"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315369"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315369"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5E5863E5; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
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
Subject: [PATCH v3 5/9] auxdisplay: ht16k33: Define a few helper macros
Date: Mon, 19 Feb 2024 18:58:04 +0200
Message-ID: <20240219170337.2161754-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define a few helper macros — wrappers on contaoner_of)() — for easier
maintenance in the future. While at it, include missing container_of.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index f016130835b1..b76c4d83528f 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -15,6 +15,7 @@
 #include <linux/property.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
+#include <linux/container_of.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/leds.h>
@@ -107,6 +108,15 @@ struct ht16k33_priv {
 	uint8_t blink;
 };
 
+#define ht16k33_work_to_priv(p)				\
+	container_of(p, struct ht16k33_priv, work.work)
+
+#define ht16k33_led_to_priv(p)				\
+	container_of(p, struct ht16k33_priv, led)
+
+#define ht16k33_linedisp_to_priv(p)			\
+	container_of(p, struct ht16k33_priv, seg.linedisp)
+
 static const struct fb_fix_screeninfo ht16k33_fb_fix = {
 	.id		= DRIVER_NAME,
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -194,8 +204,7 @@ static int ht16k33_brightness_set(struct ht16k33_priv *priv,
 static int ht16k33_brightness_set_blocking(struct led_classdev *led_cdev,
 					   enum led_brightness brightness)
 {
-	struct ht16k33_priv *priv = container_of(led_cdev, struct ht16k33_priv,
-						 led);
+	struct ht16k33_priv *priv = ht16k33_led_to_priv(led_cdev);
 
 	return ht16k33_brightness_set(priv, brightness);
 }
@@ -203,8 +212,7 @@ static int ht16k33_brightness_set_blocking(struct led_classdev *led_cdev,
 static int ht16k33_blink_set(struct led_classdev *led_cdev,
 			     unsigned long *delay_on, unsigned long *delay_off)
 {
-	struct ht16k33_priv *priv = container_of(led_cdev, struct ht16k33_priv,
-						 led);
+	struct ht16k33_priv *priv = ht16k33_led_to_priv(led_cdev);
 	unsigned int delay;
 	uint8_t blink;
 	int err;
@@ -246,8 +254,7 @@ static void ht16k33_fb_queue(struct ht16k33_priv *priv)
  */
 static void ht16k33_fb_update(struct work_struct *work)
 {
-	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
-						 work.work);
+	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
 	struct ht16k33_fbdev *fbdev = &priv->fbdev;
 
 	uint8_t *p1, *p2;
@@ -441,8 +448,7 @@ static void ht16k33_keypad_stop(struct input_dev *dev)
 
 static void ht16k33_seg7_update(struct work_struct *work)
 {
-	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
-						 work.work);
+	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
 	struct ht16k33_seg *seg = &priv->seg;
 	char *s = seg->linedisp.buf;
 	uint8_t buf[9];
@@ -462,8 +468,7 @@ static void ht16k33_seg7_update(struct work_struct *work)
 
 static void ht16k33_seg14_update(struct work_struct *work)
 {
-	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
-						 work.work);
+	struct ht16k33_priv *priv = ht16k33_work_to_priv(work);
 	struct ht16k33_seg *seg = &priv->seg;
 	char *s = seg->linedisp.buf;
 	uint8_t buf[8];
@@ -478,8 +483,7 @@ static void ht16k33_seg14_update(struct work_struct *work)
 
 static void ht16k33_linedisp_update(struct linedisp *linedisp)
 {
-	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
-						 seg.linedisp);
+	struct ht16k33_priv *priv = ht16k33_linedisp_to_priv(linedisp);
 
 	schedule_delayed_work(&priv->work, 0);
 }
-- 
2.43.0.rc1.1.gbec44491f096


