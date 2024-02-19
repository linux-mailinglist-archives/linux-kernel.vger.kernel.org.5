Return-Path: <linux-kernel+bounces-71726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C585A989
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40992B22FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF1446A9;
	Mon, 19 Feb 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfjDJyUN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7B44389;
	Mon, 19 Feb 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362227; cv=none; b=WLL4JAr1T4lqBwQwGcK4xAWhDjFtum6VySHzDYUjaw4p98txLHVFNRG0j3A0g74zaSljLCDL8n5+GbzbxyJHtqmrGFI/1yacvBRKtTclXXauvJWhOy3vQc2Xq3xR4i5fteo6hrXo9gKxebwY/Pl7xjS9sltq/jYsVNpTRSjJcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362227; c=relaxed/simple;
	bh=38IkFeeB3s9t528Gme98k0LsxVPPJCADBjB36ZdncEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGYxGMKjKrCZE3YZrfPhfPl4ISTfFTfBWYsdF/nv0++wk9A4nn3laz4srp4XdyIlTU7jDvKqi8ySDgYbqNntoYwSxEJEXwyZznP9EZpqxB2A1H05Q+o1WWPm9auRbVEZQPCmpDipL9xtjijPITMhQCJoaKrxY/z0uQgheta8tn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfjDJyUN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362226; x=1739898226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38IkFeeB3s9t528Gme98k0LsxVPPJCADBjB36ZdncEc=;
  b=PfjDJyUNjywbKHx49UXA75KfMSxu7MVNrydPJMAp5lkfYl0iawkllXkw
   wP25bOkRoATOV7SXm2g0WvmS5rw7u9PIFHK02fyV8UhrRw9PfBCoUdp2R
   eEg5iojQn6gfpqGz332Z9zgrt65kJ0uRkDAW2ywCW76mGLif0XKqL1k8z
   ZVLAvokNyUTxWTYX/vcN5g9KKTP0Hx9qqN/SvNbFEOhR2DCGv3w6cpdmY
   ZP3+FDsjI+WDuLvSe45ssNmEsdyeNsrPVPpIgNa/7HTRryXwb1NyblsHn
   N6rNQHkSbp6r5fOgY3aa3In5neLBKCAsD2v/yecADdjR19oRC96zPlHOT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577393"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315355"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315355"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 585CAAE0; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
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
Subject: [PATCH v3 4/9] auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
Date: Mon, 19 Feb 2024 18:58:03 +0200
Message-ID: <20240219170337.2161754-5-andriy.shevchenko@linux.intel.com>
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

We will need the update functions to be defined before
ht16k33_linedisp_ops. Move the latter down in the code.
No functional change intended.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Robin van der Gracht <robin@protonic.nl>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index c0067a3b2b61..f016130835b1 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -439,18 +439,6 @@ static void ht16k33_keypad_stop(struct input_dev *dev)
 	disable_irq(keypad->client->irq);
 }
 
-static void ht16k33_linedisp_update(struct linedisp *linedisp)
-{
-	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
-						 seg.linedisp);
-
-	schedule_delayed_work(&priv->work, 0);
-}
-
-static const struct linedisp_ops ht16k33_linedisp_ops = {
-	.update = ht16k33_linedisp_update,
-};
-
 static void ht16k33_seg7_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
@@ -488,6 +476,18 @@ static void ht16k33_seg14_update(struct work_struct *work)
 	i2c_smbus_write_i2c_block_data(priv->client, 0, ARRAY_SIZE(buf), buf);
 }
 
+static void ht16k33_linedisp_update(struct linedisp *linedisp)
+{
+	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
+						 seg.linedisp);
+
+	schedule_delayed_work(&priv->work, 0);
+}
+
+static const struct linedisp_ops ht16k33_linedisp_ops = {
+	.update = ht16k33_linedisp_update,
+};
+
 static int ht16k33_led_probe(struct device *dev, struct led_classdev *led,
 			     unsigned int brightness)
 {
-- 
2.43.0.rc1.1.gbec44491f096


