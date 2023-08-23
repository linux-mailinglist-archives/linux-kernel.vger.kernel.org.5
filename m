Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53D785594
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjHWKlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjHWKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:41:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C2CCEC;
        Wed, 23 Aug 2023 03:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692787254; x=1724323254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fn4jvFFf5pGpqGuwPneXM1r+B97qh+vEXECAbUd86q4=;
  b=uBz0jRGKBRz0OVWVKPgox0IKfBIlhHrWHDD8W2WRGzWKvDpXTAKw57Il
   +P8I48B9yC7bXgnkkuFlu2fRCoF3anBR4vQHzO1QhUOHqYzBtTzdC8mLB
   2mRTMRyFcBzgxDrObNpjpIoe68Y9ZTQjMZff8NgD2/yIx22YOapl+GRjX
   ycJysUBev6s1nMzBbGCJW79YQ1LjKjf7mULhCljbqtYjjbDZpQXC+1Oct
   BSzWdeWUw09eqKnz3VAQV0sdezTLioCoBZnMN/2VmP97+4PKO51plp3De
   Ie+Mru140yANULXpCb+mwcVIBGqtob/M3QEqgu5qEnJb+Nur6ZnYxOief
   A==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="231284416"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2023 03:40:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 23 Aug 2023 03:40:51 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 23 Aug 2023 03:40:46 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity quirk to gpiolib
Date:   Wed, 23 Aug 2023 16:10:10 +0530
Message-ID: <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The polarity of the card detection gpio is handled by the "cd-inverted"
property in the device tree. Move this inversion logic to gpiolib to avoid
reading the gpio raw value.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 drivers/gpio/gpiolib-of.c    |  7 +++++++
 drivers/mmc/host/atmel-mci.c | 33 +++++++++++++++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 1436cdb5fa26..87d652c62339 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -257,6 +257,13 @@ static void of_gpio_set_polarity_by_property(const struct device_node *np,
 	unsigned int i;
 	bool active_high;
 
+#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
+	if (of_device_is_compatible(np->parent, "atmel,hsmci") &&
+	    !strcmp(propname, "cd-gpios")) {
+		active_high = of_property_read_bool(np, "cd-inverted");
+		of_gpio_quirk_polarity(np, active_high, flags);
+	}
+#endif
 	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
 		if (of_device_is_compatible(np, gpios[i].compatible) &&
 		    !strcmp(propname, gpios[i].gpio_propname)) {
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 6f815818dd22..535783c43105 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -206,7 +206,6 @@ enum atmci_pdc_buf {
  * @bus_width: Number of data lines wired up the slot
  * @detect_pin: GPIO pin wired to the card detect switch
  * @wp_pin: GPIO pin wired to the write protect sensor
- * @detect_is_active_high: The state of the detect pin when it is active
  * @non_removable: The slot is not removable, only detect once
  *
  * If a given slot is not present on the board, @bus_width should be
@@ -222,7 +221,6 @@ struct mci_slot_pdata {
 	unsigned int		bus_width;
 	struct gpio_desc        *detect_pin;
 	struct gpio_desc	*wp_pin;
-	bool			detect_is_active_high;
 	bool			non_removable;
 };
 
@@ -405,7 +403,6 @@ struct atmel_mci {
  *	available.
  * @wp_pin: GPIO pin used for card write protect sending, or negative
  *	if not available.
- * @detect_is_active_high: The state of the detect pin when it is active.
  * @detect_timer: Timer used for debouncing @detect_pin interrupts.
  */
 struct atmel_mci_slot {
@@ -426,7 +423,6 @@ struct atmel_mci_slot {
 
 	struct gpio_desc        *detect_pin;
 	struct gpio_desc	*wp_pin;
-	bool			detect_is_active_high;
 
 	struct timer_list	detect_timer;
 };
@@ -644,6 +640,7 @@ atmci_of_init(struct platform_device *pdev)
 	struct device_node *cnp;
 	struct mci_platform_data *pdata;
 	u32 slot_id;
+	int err;
 
 	if (!np) {
 		dev_err(&pdev->dev, "device node not found\n");
@@ -675,11 +672,12 @@ atmci_of_init(struct platform_device *pdev)
 		pdata->slot[slot_id].detect_pin =
 			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
 					      "cd", GPIOD_IN, "cd-gpios");
-		if (IS_ERR(pdata->slot[slot_id].detect_pin))
+		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
+		if (err) {
+			if (err != -ENOENT)
+				return ERR_PTR(err);
 			pdata->slot[slot_id].detect_pin = NULL;
-
-		pdata->slot[slot_id].detect_is_active_high =
-			of_property_read_bool(cnp, "cd-inverted");
+		}
 
 		pdata->slot[slot_id].non_removable =
 			of_property_read_bool(cnp, "non-removable");
@@ -687,8 +685,12 @@ atmci_of_init(struct platform_device *pdev)
 		pdata->slot[slot_id].wp_pin =
 			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
 					      "wp", GPIOD_IN, "wp-gpios");
-		if (IS_ERR(pdata->slot[slot_id].wp_pin))
+		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
+		if (err) {
+			if (err != -ENOENT)
+				return ERR_PTR(err);
 			pdata->slot[slot_id].wp_pin = NULL;
+		}
 	}
 
 	return pdata;
@@ -1566,8 +1568,7 @@ static int atmci_get_cd(struct mmc_host *mmc)
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 
 	if (slot->detect_pin) {
-		present = !(gpiod_get_raw_value(slot->detect_pin) ^
-			    slot->detect_is_active_high);
+		present = gpiod_get_value_cansleep(slot->detect_pin);
 		dev_dbg(&mmc->class_dev, "card is %spresent\n",
 				present ? "" : "not ");
 	}
@@ -1680,8 +1681,7 @@ static void atmci_detect_change(struct timer_list *t)
 		return;
 
 	enable_irq(gpiod_to_irq(slot->detect_pin));
-	present = !(gpiod_get_raw_value(slot->detect_pin) ^
-		    slot->detect_is_active_high);
+	present = gpiod_get_value_cansleep(slot->detect_pin);
 	present_old = test_bit(ATMCI_CARD_PRESENT, &slot->flags);
 
 	dev_vdbg(&slot->mmc->class_dev, "detect change: %d (was %d)\n",
@@ -2272,7 +2272,6 @@ static int atmci_init_slot(struct atmel_mci *host,
 	slot->host = host;
 	slot->detect_pin = slot_data->detect_pin;
 	slot->wp_pin = slot_data->wp_pin;
-	slot->detect_is_active_high = slot_data->detect_is_active_high;
 	slot->sdc_reg = sdc_reg;
 	slot->sdio_irq = sdio_irq;
 
@@ -2280,7 +2279,7 @@ static int atmci_init_slot(struct atmel_mci *host,
 	        "slot[%u]: bus_width=%u, detect_pin=%d, "
 		"detect_is_active_high=%s, wp_pin=%d\n",
 		id, slot_data->bus_width, desc_to_gpio(slot_data->detect_pin),
-		slot_data->detect_is_active_high ? "true" : "false",
+		!gpiod_is_active_low(slot_data->detect_pin) ? "true" : "false",
 		desc_to_gpio(slot_data->wp_pin));
 
 	mmc->ops = &atmci_ops;
@@ -2318,10 +2317,8 @@ static int atmci_init_slot(struct atmel_mci *host,
 	/* Assume card is present initially */
 	set_bit(ATMCI_CARD_PRESENT, &slot->flags);
 	if (slot->detect_pin) {
-		if (gpiod_get_raw_value(slot->detect_pin) ^
-		    slot->detect_is_active_high) {
+		if (!gpiod_get_value_cansleep(slot->detect_pin))
 			clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
-		}
 	} else {
 		dev_dbg(&mmc->class_dev, "no detect pin available\n");
 	}
-- 
2.25.1

