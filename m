Return-Path: <linux-kernel+bounces-71728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B630E85A98D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA13286A95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44944C8A;
	Mon, 19 Feb 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je1kNWNv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83B446A6;
	Mon, 19 Feb 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362229; cv=none; b=lZ4nx9mXriOjtflHWY5/UfcWVa3Y7BGxHJlu6pfMRrwR3jw87uc7JDZb3rUYQXWQjsva7mP4kHS7uzNwohIjaL9VmJdoKQtKSHtpT4/JmE+25kK6ybpkCk6wDFkV94JjsNK9KNq9eSND1v+OSwfBvtQ2dX0iv0nI28g+l/3XUGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362229; c=relaxed/simple;
	bh=I61aQrfxe8pltYJ1/AfqQL0Uek1s8wSiEP8xqVGCwiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjZuzlcvqH93rgNKHGTKQpaY2Ww3aKfjhRbvq1GBsKvyX2TYFV76ZQZjL5U7qUfDxEgYrd+FyTsXrG+7+c7v7bPjs1liCDfnB0nXfdvCAmdgPGGXFjahN5alJd7tT3MtlIo+e5UIkKHm+b8NZ1QshQ/jyVNWf60zIWaf9jktMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je1kNWNv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362228; x=1739898228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I61aQrfxe8pltYJ1/AfqQL0Uek1s8wSiEP8xqVGCwiU=;
  b=je1kNWNvx5iwzn3/oevvCiwzXpA8S91tunkbfBdO/4e5JU9PrygS6zTL
   FGm9wJTm+gnYq5/r6YNR+A76xOWIaYivvELcUNRs01mwUZdJqeo8SwszD
   VGTSYWbtSA+uUqt9lFMNHKqzdeNgK7vMp7kibr2sbd0TbilMQuz0rWA0T
   Xrb+xuo2AIcdAmtyKjv3kYOMI7tlcjETJdIBVXuscag2BuJHtdY5oCVU4
   bkUJ2ET/3DEA3G+HRdO8qMBhmG8qp8sGiZlUOAiynGYHFjAP6hki17a9Y
   AsDRa8LXwpIFSRwjyb5mds/qKv63uw31tFMygsdWosgayECZRGidQfzvG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577405"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315353"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315353"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 392CC49C; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
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
Subject: [PATCH v3 2/9] auxdisplay: linedisp: Allocate buffer for the string
Date: Mon, 19 Feb 2024 18:58:01 +0200
Message-ID: <20240219170337.2161754-3-andriy.shevchenko@linux.intel.com>
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

Always allocate a buffer for the currently displayed characters.
It makes the line display API simpler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c       |  8 +++-----
 drivers/auxdisplay/img-ascii-lcd.c | 17 +++++++----------
 drivers/auxdisplay/line-display.c  | 11 +++++++----
 drivers/auxdisplay/line-display.h  |  3 +--
 4 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 32d3afd29177..19805f39a257 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -92,7 +92,6 @@ struct ht16k33_seg {
 		struct seg14_conversion_map seg14;
 	} map;
 	unsigned int map_size;
-	char curr[4];
 };
 
 struct ht16k33_priv {
@@ -457,7 +456,7 @@ static void ht16k33_seg7_update(struct work_struct *work)
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
 						 work.work);
 	struct ht16k33_seg *seg = &priv->seg;
-	char *s = seg->curr;
+	char *s = seg->linedisp.buf;
 	uint8_t buf[9];
 
 	buf[0] = map_to_seg7(&seg->map.seg7, *s++);
@@ -478,7 +477,7 @@ static void ht16k33_seg14_update(struct work_struct *work)
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
 						 work.work);
 	struct ht16k33_seg *seg = &priv->seg;
-	char *s = seg->curr;
+	char *s = seg->linedisp.buf;
 	uint8_t buf[8];
 
 	put_unaligned_le16(map_to_seg14(&seg->map.seg14, *s++), buf);
@@ -700,8 +699,7 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 	if (err)
 		return err;
 
-	err = linedisp_register(&seg->linedisp, dev, 4, seg->curr,
-				&ht16k33_linedisp_ops);
+	err = linedisp_register(&seg->linedisp, dev, 4, &ht16k33_linedisp_ops);
 	if (err)
 		goto err_remove_map_file;
 
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index ecfb1c05bf55..925c4cd101e9 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -37,7 +37,6 @@ struct img_ascii_lcd_config {
  * @regmap: the regmap through which LCD registers are accessed
  * @offset: the offset within regmap to the start of the LCD registers
  * @cfg: pointer to the LCD model configuration
- * @curr: the string currently displayed on the LCD
  */
 struct img_ascii_lcd_ctx {
 	struct linedisp linedisp;
@@ -47,7 +46,6 @@ struct img_ascii_lcd_ctx {
 	};
 	u32 offset;
 	const struct img_ascii_lcd_config *cfg;
-	char curr[] __aligned(8);
 };
 
 /*
@@ -61,12 +59,12 @@ static void boston_update(struct linedisp *linedisp)
 	ulong val;
 
 #if BITS_PER_LONG == 64
-	val = *((u64 *)&ctx->curr[0]);
+	val = *((u64 *)&linedisp->buf[0]);
 	__raw_writeq(val, ctx->base);
 #elif BITS_PER_LONG == 32
-	val = *((u32 *)&ctx->curr[0]);
+	val = *((u32 *)&linedisp->buf[0]);
 	__raw_writel(val, ctx->base);
-	val = *((u32 *)&ctx->curr[4]);
+	val = *((u32 *)&linedisp->buf[4]);
 	__raw_writel(val, ctx->base + 4);
 #else
 # error Not 32 or 64 bit
@@ -93,7 +91,7 @@ static void malta_update(struct linedisp *linedisp)
 
 	for (i = 0; i < linedisp->num_chars; i++) {
 		err = regmap_write(ctx->regmap,
-				   ctx->offset + (i * 8), ctx->curr[i]);
+				   ctx->offset + (i * 8), linedisp->buf[i]);
 		if (err)
 			break;
 	}
@@ -195,7 +193,7 @@ static void sead3_update(struct linedisp *linedisp)
 
 		err = regmap_write(ctx->regmap,
 				   ctx->offset + SEAD3_REG_LCD_DATA,
-				   ctx->curr[i]);
+				   linedisp->buf[i]);
 		if (err)
 			break;
 	}
@@ -236,7 +234,7 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
 	struct img_ascii_lcd_ctx *ctx;
 	int err;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx) + cfg->num_chars, GFP_KERNEL);
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -253,8 +251,7 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->base);
 	}
 
-	err = linedisp_register(&ctx->linedisp, dev, cfg->num_chars, ctx->curr,
-				&cfg->ops);
+	err = linedisp_register(&ctx->linedisp, dev, cfg->num_chars, &cfg->ops);
 	if (err)
 		return err;
 
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 13be7c2f6bc3..e2b546210f8d 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -265,6 +265,7 @@ static void linedisp_release(struct device *dev)
 
 	kfree(linedisp->map);
 	kfree(linedisp->message);
+	kfree(linedisp->buf);
 	ida_free(&linedisp_id, linedisp->id);
 }
 
@@ -316,14 +317,12 @@ static int linedisp_init_map(struct linedisp *linedisp)
  * @linedisp: pointer to character line display structure
  * @parent: parent device
  * @num_chars: the number of characters that can be displayed
- * @buf: pointer to a buffer that can hold @num_chars characters
  * @ops: character line display operations
  *
  * Return: zero on success, else a negative error code.
  */
 int linedisp_register(struct linedisp *linedisp, struct device *parent,
-		      unsigned int num_chars, char *buf,
-		      const struct linedisp_ops *ops)
+		      unsigned int num_chars, const struct linedisp_ops *ops)
 {
 	int err;
 
@@ -331,7 +330,6 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	linedisp->dev.parent = parent;
 	linedisp->dev.type = &linedisp_type;
 	linedisp->ops = ops;
-	linedisp->buf = buf;
 	linedisp->num_chars = num_chars;
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
 
@@ -343,6 +341,11 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	device_initialize(&linedisp->dev);
 	dev_set_name(&linedisp->dev, "linedisp.%u", linedisp->id);
 
+	err = -ENOMEM;
+	linedisp->buf = kzalloc(linedisp->num_chars, GFP_KERNEL);
+	if (!linedisp->buf)
+		goto out_put_device;
+
 	/* initialise a character mapping, if required */
 	err = linedisp_init_map(linedisp);
 	if (err)
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 4e310b0e611e..4348d7a2f69a 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -82,8 +82,7 @@ struct linedisp {
 };
 
 int linedisp_register(struct linedisp *linedisp, struct device *parent,
-		      unsigned int num_chars, char *buf,
-		      const struct linedisp_ops *ops);
+		      unsigned int num_chars, const struct linedisp_ops *ops);
 void linedisp_unregister(struct linedisp *linedisp);
 
 #endif /* LINEDISP_H */
-- 
2.43.0.rc1.1.gbec44491f096


