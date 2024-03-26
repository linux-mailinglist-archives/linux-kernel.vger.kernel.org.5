Return-Path: <linux-kernel+bounces-119637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588AE88CB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C95E1F822F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0BF763E6;
	Tue, 26 Mar 2024 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwvNeogV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6B208B4;
	Tue, 26 Mar 2024 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475923; cv=none; b=JDaLV6XhK8PcKaIoXDaRiRdv+urO56KpeNPvopFY8q5xWpPB89axRfqwfQ63gXBf739sESlHEokN+TGwnr/FN5a1nRnGa7HDmzXgLY1Wv4KrDZDmk75IFJB4xY2C5lSZXKeob874lQy+qjtSh9BN5mDFLoclcZ3i0d+TukSZykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475923; c=relaxed/simple;
	bh=2h5jo8wEAkXTw9G7gniyt7zf6JOSZSqfam+jr8qgV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0uw1Qur0T+PBPubaBOWrRNAhxZAmhai5OH+RI0AA958zoMRTKEV4q0vkLs26MgfCA8SNyRueuKgsvwdgIPrq6twVGHivZ4p3x9ous9LdMP3OVlI/Sy09hoLHWg2dyAKe3Tc+si1b84woVTlomafdkUif3PKDJKGZu2tJ4MWEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwvNeogV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475922; x=1743011922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2h5jo8wEAkXTw9G7gniyt7zf6JOSZSqfam+jr8qgV0c=;
  b=OwvNeogVB0x3NMXIPLhR20qK+JIV7U3DSBISuX1nAOY2SkxOQak9osv6
   tF20X7a1s9l5vEnLR32zuVX9yWS+ZKiJNQhzlkwKGvTRxMuIhrKqZlUNy
   4xkTn67QMoQjG1PzdyHOWMv5ir7pSQE5szA2uxdzmEOXnACdQIjc6U9pz
   FsLOuMvlfq2XWbTbsADFC8vo1lJLN8GEQKyd1TIFPJ5dtFETluJBFQ/NK
   P3lTQBEXuPEOVGKSzx2vK1egZhc0ij6YCv2awwPxGEcdhCxHTjZUgPV4A
   ogWVr1W6wgnabu6ZBxS45+YwhRxAwlC23oB2uJ86HYMP39mAMX89ZUHoI
   g==;
X-CSE-ConnectionGUID: HTAGv1LnTXiUr5VMs6W5/g==
X-CSE-MsgGUID: WMf49pmpTrOj8amF27Zjtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6400957"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6400957"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072927"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072927"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 10:58:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E742E284; Tue, 26 Mar 2024 19:58:38 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next][resend v1 1/1] nfc: st95hf: Switch to using gpiod API
Date: Tue, 26 Mar 2024 19:58:36 +0200
Message-ID: <20240326175836.1418718-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the driver to gpiod API, and removes yet another use of
of_get_named_gpio().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/st95hf/core.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index ed704bb77226..067e0ec31d2d 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -7,14 +7,13 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/nfc.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
@@ -196,7 +195,7 @@ struct st95_digital_cmd_complete_arg {
  *	for spi communication between st95hf and host.
  * @ddev: nfc digital device object.
  * @nfcdev: nfc device object.
- * @enable_gpio: gpio used to enable st95hf transceiver.
+ * @enable_gpiod: gpio used to enable st95hf transceiver.
  * @complete_cb_arg: structure to store various context information
  *	that is passed from nfc requesting thread to the threaded ISR.
  * @st95hf_supply: regulator "consumer" for NFC device.
@@ -219,7 +218,7 @@ struct st95hf_context {
 	struct st95hf_spi_context spicontext;
 	struct nfc_digital_dev *ddev;
 	struct nfc_dev *nfcdev;
-	unsigned int enable_gpio;
+	struct gpio_desc *enable_gpiod;
 	struct st95_digital_cmd_complete_arg complete_cb_arg;
 	struct regulator *st95hf_supply;
 	unsigned char sendrcv_trflag;
@@ -451,19 +450,19 @@ static int st95hf_select_protocol(struct st95hf_context *stcontext, int type)
 static void st95hf_send_st95enable_negativepulse(struct st95hf_context *st95con)
 {
 	/* First make irq_in pin high */
-	gpio_set_value(st95con->enable_gpio, HIGH);
+	gpiod_set_value(st95con->enable_gpiod, HIGH);
 
 	/* wait for 1 milisecond */
 	usleep_range(1000, 2000);
 
 	/* Make irq_in pin low */
-	gpio_set_value(st95con->enable_gpio, LOW);
+	gpiod_set_value(st95con->enable_gpiod, LOW);
 
 	/* wait for minimum interrupt pulse to make st95 active */
 	usleep_range(1000, 2000);
 
 	/* At end make it high */
-	gpio_set_value(st95con->enable_gpio, HIGH);
+	gpiod_set_value(st95con->enable_gpiod, HIGH);
 }
 
 /*
@@ -1063,6 +1062,7 @@ MODULE_DEVICE_TABLE(of, st95hf_spi_of_match);
 
 static int st95hf_probe(struct spi_device *nfc_spi_dev)
 {
+	struct device *dev = &nfc_spi_dev->dev;
 	int ret;
 
 	struct st95hf_context *st95context;
@@ -1108,19 +1108,14 @@ static int st95hf_probe(struct spi_device *nfc_spi_dev)
 	 */
 	dev_set_drvdata(&nfc_spi_dev->dev, spicontext);
 
-	st95context->enable_gpio =
-		of_get_named_gpio(nfc_spi_dev->dev.of_node,
-				  "enable-gpio",
-				  0);
-	if (!gpio_is_valid(st95context->enable_gpio)) {
+	st95context->enable_gpiod = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(st95context->enable_gpiod)) {
+		ret = PTR_ERR(st95context->enable_gpiod);
 		dev_err(&nfc_spi_dev->dev, "No valid enable gpio\n");
-		ret = st95context->enable_gpio;
 		goto err_disable_regulator;
 	}
 
-	ret = devm_gpio_request_one(&nfc_spi_dev->dev, st95context->enable_gpio,
-				    GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
-				    "enable_gpio");
+	ret = gpiod_set_consumer_name(st95context->enable_gpiod, "enable_gpio");
 	if (ret)
 		goto err_disable_regulator;
 
-- 
2.43.0.rc1.1.gbec44491f096


