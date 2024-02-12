Return-Path: <linux-kernel+bounces-62046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5942C851AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF51C21390
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE94642A;
	Mon, 12 Feb 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRm/5VjL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D793FE36;
	Mon, 12 Feb 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757492; cv=none; b=bXjA7I2DEop05XLOgMZkGKPsOgoYk6ZwPVrXvK0fO918Xj2VDr0VI85WTbe0isLPIyo4jC9l3gQW06C3/faRr1qEbPlqx8A7uBJhbr7jx9KMpPJ6eK4hStcMS85pJtdzGNIh2TRimpAkYlnjnuiQi/fWNEsuUhCGORah6aqXQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757492; c=relaxed/simple;
	bh=uyaajfAMF51QUWBVV1UZLAXvVVvvLfZdmD+gVT959t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5m+cOnuGwQ1yQ9RTEIkf8Mo7POsrxWrs/moZYtcIjZDY1YDz/Sx4ddhq+SIo9hw8nt76D9si+86BgdmDYjJiJXBLDMTjzj6jCaXNqD/WXXOBpshYLKgMq5TSM8Psh3W/XNbzeHhtCrM2GE8wdLZD7s7J9EBJkuN0bOWM1EOmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRm/5VjL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757491; x=1739293491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uyaajfAMF51QUWBVV1UZLAXvVVvvLfZdmD+gVT959t8=;
  b=aRm/5VjLcCtVzx2QCZg7973t9CAySRaGwu8WBX3VgY7cNUbdh/MGjtSH
   U44i7ABXFiDUKhIUwYPmRlA5Xt46ry0fuCFUnpC9dWPN9yZ8akT6H73bf
   P1r7LQYFuUnKkBuE/KBRKgD+cY19cuRGDQG9MvYsseRBNYsLinHl+VigK
   AMv57aBF1dxcUt07EBe+KthOG573OuRZAyYJ2PrVhK5ax8pJ/8+KpNxWG
   E5kGGVObX8yKpPNv+AX74ONkvbS15VM0KkNydh1xqFobzlnFXUH3K4dif
   T9upXlgjDrLrf5YI93VdgW+/olfEDxSnEkgXI56QDIfAJpitb64nvTZap
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153194"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153194"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116823"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116823"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E585D31D; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
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
Subject: [PATCH v2 08/15] auxdisplay: linedisp: Provide struct linedisp_ops for future extension
Date: Mon, 12 Feb 2024 19:01:41 +0200
Message-ID: <20240212170423.2860895-9-andriy.shevchenko@linux.intel.com>
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

Currently the line display library doesn't scale in case we want to
provide more operations. Prepare the library to take a newly created
struct linedisp_ops that scales.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c       |  7 +++++--
 drivers/auxdisplay/img-ascii-lcd.c | 19 ++++++++++++-------
 drivers/auxdisplay/line-display.c  | 11 +++++------
 drivers/auxdisplay/line-display.h  | 17 +++++++++++++----
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index c6a42c5c128f..0cdf3fbdf81e 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -448,6 +448,10 @@ static void ht16k33_linedisp_update(struct linedisp *linedisp)
 	schedule_delayed_work(&priv->work, 0);
 }
 
+static const struct linedisp_ops ht16k33_linedisp_ops = {
+	.update = ht16k33_linedisp_update,
+};
+
 static void ht16k33_seg7_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
@@ -696,8 +700,7 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 	if (err)
 		return err;
 
-	err = linedisp_register(&seg->linedisp, dev, 4, seg->curr,
-				ht16k33_linedisp_update);
+	err = linedisp_register(&seg->linedisp, dev, 4, seg->curr, &ht16k33_linedisp_ops);
 	if (err)
 		goto err_remove_map_file;
 
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index c571e54d9eb5..c0ec7d9a1c62 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -22,12 +22,12 @@ struct img_ascii_lcd_ctx;
  * struct img_ascii_lcd_config - Configuration information about an LCD model
  * @num_chars: the number of characters the LCD can display
  * @external_regmap: true if registers are in a system controller, else false
- * @update: function called to update the LCD
+ * @ops: character line display operations
  */
 struct img_ascii_lcd_config {
 	unsigned int num_chars;
 	bool external_regmap;
-	void (*update)(struct linedisp *linedisp);
+	const struct linedisp_ops ops;
 };
 
 /**
@@ -75,7 +75,9 @@ static void boston_update(struct linedisp *linedisp)
 
 static struct img_ascii_lcd_config boston_config = {
 	.num_chars = 8,
-	.update = boston_update,
+	.ops = {
+		.update = boston_update,
+	},
 };
 
 /*
@@ -103,7 +105,9 @@ static void malta_update(struct linedisp *linedisp)
 static struct img_ascii_lcd_config malta_config = {
 	.num_chars = 8,
 	.external_regmap = true,
-	.update = malta_update,
+	.ops = {
+		.update = malta_update,
+	},
 };
 
 /*
@@ -203,7 +207,9 @@ static void sead3_update(struct linedisp *linedisp)
 static struct img_ascii_lcd_config sead3_config = {
 	.num_chars = 16,
 	.external_regmap = true,
-	.update = sead3_update,
+	.ops = {
+		.update = sead3_update,
+	},
 };
 
 static const struct of_device_id img_ascii_lcd_matches[] = {
@@ -247,8 +253,7 @@ static int img_ascii_lcd_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->base);
 	}
 
-	err = linedisp_register(&ctx->linedisp, dev, cfg->num_chars, ctx->curr,
-				cfg->update);
+	err = linedisp_register(&ctx->linedisp, dev, cfg->num_chars, ctx->curr, &cfg->ops);
 	if (err)
 		return err;
 
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 8d0ebdf0f10d..6453a62f653f 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -50,7 +50,7 @@ static void linedisp_scroll(struct timer_list *t)
 	}
 
 	/* update the display */
-	linedisp->update(linedisp);
+	linedisp->ops->update(linedisp);
 
 	/* move on to the next character */
 	linedisp->scroll_pos++;
@@ -94,7 +94,7 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 		linedisp->message = NULL;
 		linedisp->message_len = 0;
 		memset(linedisp->buf, ' ', linedisp->num_chars);
-		linedisp->update(linedisp);
+		linedisp->ops->update(linedisp);
 		return 0;
 	}
 
@@ -216,20 +216,19 @@ static const struct device_type linedisp_type = {
  * @parent: parent device
  * @num_chars: the number of characters that can be displayed
  * @buf: pointer to a buffer that can hold @num_chars characters
- * @update: Function called to update the display.  This must not sleep!
+ * @ops: character line display operations
  *
  * Return: zero on success, else a negative error code.
  */
 int linedisp_register(struct linedisp *linedisp, struct device *parent,
-		      unsigned int num_chars, char *buf,
-		      void (*update)(struct linedisp *linedisp))
+		      unsigned int num_chars, char *buf, const struct linedisp_ops *ops)
 {
 	int err;
 
 	memset(linedisp, 0, sizeof(*linedisp));
 	linedisp->dev.parent = parent;
 	linedisp->dev.type = &linedisp_type;
-	linedisp->update = update;
+	linedisp->ops = ops;
 	linedisp->buf = buf;
 	linedisp->num_chars = num_chars;
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index d72c1899dc50..a4f0d1bf5848 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -14,12 +14,22 @@
 #include <linux/device.h>
 #include <linux/timer_types.h>
 
+struct linedisp;
+
+/**
+ * struct linedisp_ops - character line display operations
+ * @update: Function called to update the display. This must not sleep!
+ */
+struct linedisp_ops {
+	void (*update)(struct linedisp *linedisp);
+};
+
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
  * @id: instance id of this display
  * @timer: timer used to implement scrolling
- * @update: function called to update the display
+ * @ops: character line display operations
  * @buf: pointer to the buffer for the string currently displayed
  * @message: the full message to display or scroll on the display
  * @num_chars: the number of characters that can be displayed
@@ -31,7 +41,7 @@ struct linedisp {
 	struct device dev;
 	unsigned int id;
 	struct timer_list timer;
-	void (*update)(struct linedisp *linedisp);
+	const struct linedisp_ops *ops;
 	char *buf;
 	char *message;
 	unsigned int num_chars;
@@ -41,8 +51,7 @@ struct linedisp {
 };
 
 int linedisp_register(struct linedisp *linedisp, struct device *parent,
-		      unsigned int num_chars, char *buf,
-		      void (*update)(struct linedisp *linedisp));
+		      unsigned int num_chars, char *buf, const struct linedisp_ops *ops);
 void linedisp_unregister(struct linedisp *linedisp);
 
 #endif /* LINEDISP_H */
-- 
2.43.0.rc1.1.gbec44491f096


