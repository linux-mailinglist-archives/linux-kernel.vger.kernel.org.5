Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036317F9E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjK0LYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjK0LYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:24:32 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D651D1FC8;
        Mon, 27 Nov 2023 03:24:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6F82C0159;
        Mon, 27 Nov 2023 12:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1701084244; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=n4MWxKLJ2mEngVhhcucO0tz7IR393NcgZWJ1yY5pvlM=;
        b=ViqeLKiVxM44tFzNHhpFOKGDdOwjEuYgCpRUR6BBRf6vb7UrwZDIOnfJJ7/tOSTYAQQk+L
        aiAIPCE1vpycaeAXizSS2ecd1y0lZfX9r9YNrfT2MiH5uPo5Y/PIKtYZW9GPAKKXoxiYaf
        tRGkxPb8hPiusbdtM55l6JMpD8BJlBCPZ/0SU8itJzpneKtCaZr/9qtr6A67xZvvpKdRJ/
        rjcNNxXtInDMlVqQkq7a7tPJmiQrECB1LnXiXZM+V3DLBOt+hgtU3ZjqokduWqCjgrbvLA
        Erd+6sEUADQmPGofYUcYt3Pi2GlrqzppsqakbSnRqUdneiNap+Hy9Ef4xkRmgQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [RESEND PATCH v2 3/3] usb: misc: onboard_usb_hub: Add support for Cypress CY7C6563x
Date:   Mon, 27 Nov 2023 12:22:26 +0100
Message-ID: <20231127112234.109073-3-frieder@fris.de>
In-Reply-To: <20231127112234.109073-1-frieder@fris.de>
References: <20231127112234.109073-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Cypress CY7C6563x is a 2/4-port USB 2.0 hub. Add support for
this hub in the driver in order to bring up reset, supply or clock
dependencies.

There is no reset pulse width given in the datasheet so we expect
a minimal value of 1us to be enough. This hasn't been tested though
due to lack of hardware which has the reset connected to a GPIO.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
* none
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 0d84b16deab50..0c0b698f008b9 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -441,6 +441,7 @@ static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
 static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 */
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index c4e24a7b92904..67b2cc1e15e67 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -31,6 +31,11 @@ static const struct onboard_hub_pdata cypress_hx3_data = {
 	.num_supplies = 2,
 };
 
+static const struct onboard_hub_pdata cypress_hx2vl_data = {
+	.reset_us = 1,
+	.num_supplies = 1,
+};
+
 static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 	.num_supplies = 1,
@@ -54,6 +59,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb4b4,6504", .data = &cypress_hx3_data, },
 	{ .compatible = "usb4b4,6506", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,6570", .data = &cypress_hx2vl_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },
 	{ .compatible = "usb5e3,620", .data = &genesys_gl852g_data, },
-- 
2.42.1

