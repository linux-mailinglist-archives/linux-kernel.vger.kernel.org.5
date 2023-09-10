Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C88799F06
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjIJQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIJQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 12:48:30 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Sep 2023 09:48:26 PDT
Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FDCC5;
        Sun, 10 Sep 2023 09:48:26 -0700 (PDT)
Received: from MTA-08-4.privateemail.com (mta-08.privateemail.com [198.54.118.215])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 3C169604C1;
        Sun, 10 Sep 2023 12:38:50 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 6FF2C1800050;
        Sun, 10 Sep 2023 12:38:46 -0400 (EDT)
Received: from hal-station.. (bras-base-toroon4332w-grc-39-74-12-11-94.dsl.bell.ca [74.12.11.94])
        by mta-08.privateemail.com (Postfix) with ESMTPA;
        Sun, 10 Sep 2023 12:38:31 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-usb@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>,
        Nicolas Dumazet <ndumazet@google.com>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hannu Hartikainen <hannu@hrtk.in>, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: add ignore remote wakeup quirk for one of Logitech's receivers
Date:   Sun, 10 Sep 2023 12:37:48 -0400
Message-ID: <20230910163751.4210-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device causes the system to wake up from suspend, as soon as it
enters it (even if the device attached to the receiver is powered off).
So, ignore remote wakeup events from it.

Cc: stable@vger.kernel.org
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 15e9bd180a1d..d2e2a2873f34 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -264,6 +264,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Logitech Harmony 700-series */
 	{ USB_DEVICE(0x046d, 0xc122), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Logitech lightspeed receiver (0xc547) */
+	{ USB_DEVICE(0x046d, 0xc547), .driver_info =
+			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
+
 	/* Philips PSC805 audio device */
 	{ USB_DEVICE(0x0471, 0x0155), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.42.0

