Return-Path: <linux-kernel+bounces-106636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4053C87F149
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E43A1C21920
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B385288B6;
	Mon, 18 Mar 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOeTv3G7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339E58AB6;
	Mon, 18 Mar 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794368; cv=none; b=J6+7YUmOP2bVIfY1Yf/WSyCS2dnciiW47JM/EJUxGFbAu926AmEOH3LQHxcn1MsYs9AEp3ZV1k3HX/p+N+lJUba1vZW9DtG0EqBjFjAzNlpXgHjQV+wEEu79jrZeqSgteKmb4RYwrN2zUP6Ph7ouRPjjXNeEYGuNrzDn2awCyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794368; c=relaxed/simple;
	bh=2h5jo8wEAkXTw9G7gniyt7zf6JOSZSqfam+jr8qgV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qs2G2rRuZAqTmcnBCKLw9S5a2rmqrkFVFG2dpvv2SVZKxe12mzQbfSLr/oB2mQiDN6MXN3Hw7DJW/6P3k7XUTD6DSICEiAXejqYhdrKev2J1UC8jSeTVFduNU9rm+bfUVngwb4VmUvpR2B4S0oVgVkkGDR+k4VLhX545gAOKo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOeTv3G7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710794367; x=1742330367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2h5jo8wEAkXTw9G7gniyt7zf6JOSZSqfam+jr8qgV0c=;
  b=gOeTv3G7SZwueLHzeNdOioPGWYG9jh4g76hZlsrBiC9ZofVMkDzlBvC5
   D9vWq8jIFkMRi7d7PqpWtvuXmdZikEW0EKzQWJbGJblDoFaZBBefsx+CS
   riNMruYeBSnh44IhllDCfljqafhu+rHKkkFd1z0CLnmDTr45onApq8LrY
   bdyb4Oh97LZYzMOV+R5g1pnWGCtWt/RxTpugz28+hSrm0LyjNUuZUSjgV
   3fzDMha415LloXhemuMm+MLD3KfaYl57t3t98gCTxLuwJRAVDrQl71Prx
   R0SnfQBPhAB68Y+vjqPBDzmdICrfi8AH01KlDVUbOkmDosY9+lKanHF0b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5482171"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5482171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="937060676"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="937060676"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2024 13:39:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2767C241; Mon, 18 Mar 2024 22:39:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v1 1/1] nfc: st95hf: Switch to using gpiod API
Date: Mon, 18 Mar 2024 22:39:23 +0200
Message-ID: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>
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


