Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D97E9F66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKMO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjKMO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:59:35 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB910E5;
        Mon, 13 Nov 2023 06:59:30 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 2CEA1207C0;
        Mon, 13 Nov 2023 15:59:27 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] usb: misc: onboard-hub: add support for Microchip USB5744
Date:   Mon, 13 Nov 2023 15:59:21 +0100
Message-Id: <20231113145921.30104-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113145921.30104-1-francesco@dolcini.it>
References: <20231113145921.30104-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.

The Microchip USB5744 supports two power supplies, one for 1V2 and one
for 3V3. According to the datasheet there is no need for a delay between
power on and reset, so this value is set to 0.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 2 ++
 drivers/usb/misc/onboard_usb_hub.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index a341b2fbb7b4..2b45404e9732 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -432,6 +432,8 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2744) }, /* USB5744 USB 2.0 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x5744) }, /* USB5744 USB 3.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index c4e24a7b9290..292110e64a1d 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -16,6 +16,11 @@ static const struct onboard_hub_pdata microchip_usb424_data = {
 	.num_supplies = 1,
 };
 
+static const struct onboard_hub_pdata microchip_usb5744_data = {
+	.reset_us = 0,
+	.num_supplies = 2,
+};
+
 static const struct onboard_hub_pdata realtek_rts5411_data = {
 	.reset_us = 0,
 	.num_supplies = 1,
@@ -50,6 +55,8 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
+	{ .compatible = "usb424,2744", .data = &microchip_usb5744_data, },
+	{ .compatible = "usb424,5744", .data = &microchip_usb5744_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb4b4,6504", .data = &cypress_hx3_data, },
-- 
2.25.1

