Return-Path: <linux-kernel+bounces-58440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178484E689
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF71C1F2A0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69428127B5C;
	Thu,  8 Feb 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqqSKuKV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517B85C5E;
	Thu,  8 Feb 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412657; cv=none; b=MRCyB4l/UcLTTWN5JWyHc0xIl19r+VwW8fA6niSGCCpYGAyK4vtgeIJ56IS9F6mM/TEZIistOpRzrav8/52Ubm2ePqOZcbSIcQnrroZR6nx3W2cpF/I4HQ+Ofy81IcO1GLlS+0u9RJl8OufpTrfzpmaJK9jDIwG5nzhrguIxaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412657; c=relaxed/simple;
	bh=fRF6aaXYm3WO7lZKrdtFCzyzTyXPONtxX7sbViupAFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7VyuEYR596vEPAftVlTX4hsEoRldgRBhJA0e0Oo1s+GPPSNnszVmHt7+Ym1PaIKu3KaraSmAzFLnzdfhOmyZU6mI50GHtcNlAmMBazHA+jrngWzmJbU5covoUeSfGkOVe+fck/w7iEG8TW1eEjDvMomIcGX30De5vkVPOujcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqqSKuKV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412655; x=1738948655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRF6aaXYm3WO7lZKrdtFCzyzTyXPONtxX7sbViupAFA=;
  b=TqqSKuKVMhemuwLOQqZ5H0RtPLHhJOZ4Yk2eX/EM2+e/CnQwTEAodJo4
   iZGn8soXUTKqK5hwWy1/372F9t9uHhDvSm9Ni756KTH/k96xJoSamGNxe
   m+UefdwB3KGTuLM7msmSDUqP2efiFFxzuYeooijZ+XT8d5axiQUWQCu/z
   hNgv+MtsJyi72lcjtFqErABLK+lMUEFdl7aVCdvO6tmcOv2mS91qsRn1b
   YcmDBf0hfT5XISFxZ/bfa8DgkWtTspGwbQzrX2uoxsLRgv1v4MYPdb922
   VTtsqdoMRHe/pI+s5qeRebkX6Gqm2HMH4tT+U3RSgC984HMYboktplaM0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565685"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195382"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195382"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 608DE1458; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Subject: [PATCH v1 08/15] auxdisplay: linedisp: Provide struct linedisp_ops for future extension
Date: Thu,  8 Feb 2024 18:58:51 +0200
Message-ID: <20240208165937.2221193-9-andriy.shevchenko@linux.intel.com>
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
index 851b2c0f9443..62e8a911bb12 100644
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


