Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615F57E3C49
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjKGMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjKGMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:13:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75481FD4;
        Tue,  7 Nov 2023 04:10:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF382C433C7;
        Tue,  7 Nov 2023 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359042;
        bh=bcrKVV8egxRQAkPTrxVpTxLY2BjScAAmgOvyRPmnfqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDCPiVnZnVA8G/oEeUFM/YFWZ619Wv3kA/jFoJiK64xYb1XgCRQc7ipH4xU5kFNXC
         0INxJ89hKD/MgqIr4Fe11WlRGKhg3P8lumK41lPEqIeZRYlna6MITlgU0uTwf1MYEY
         4+8gqzbm6yYnXFHw21Jw1O1uUkrF81d0MN4Dsp0O0fHOYs2GNpkxjMcsLgWqdSg5jo
         oyrGEYrXr1s1tvjgo6Xxzo+ek9dp/ESQBowBPI/bSK07T6RU3qh8UhmF0Moatqlhuc
         gVQil/q/jbf3oBy8f8dgjQegJrdUFgc/cj+PP8YXTGpVI7R8tNrNj2ti0fPY4ou90l
         0IIEknrcrYCVQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 27/30] gpiolib: acpi: Add a ignore interrupt quirk for Peaq C1010
Date:   Tue,  7 Nov 2023 07:08:42 -0500
Message-ID: <20231107120922.3757126-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 6cc64f6173751d212c9833bde39e856b4f585a3e ]

On the Peaq C1010 2-in-1 INT33FC:00 pin 3 is connected to
a "dolby" button. At the ACPI level an _AEI event-handler
is connected which sets an ACPI variable to 1 on both
edges. This variable can be polled + cleared to 0 using WMI.

Since the variable is set on both edges the WMI interface is pretty
useless even when polling. So instead of writing a custom WMI
driver for this the x86-android-tablets code instantiates
a gpio-keys platform device for the "dolby" button.

Add an ignore_interrupt quirk for INT33FC:00 pin 3 on the Peaq C1010,
so that it is not seen as busy when the gpio-keys driver requests it.

Note this replaces a hack in x86-android-tablets where it would
call acpi_gpiochip_free_interrupts() on the INT33FC:00 GPIO
controller. acpi_gpiochip_free_interrupts() is considered private
(internal) gpiolib API so x86-android-tablets should stop using it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20230909141816.58358-3-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index a775d2bdac94f..980ec04892173 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1655,6 +1655,26 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "SYNA1202:00@16",
 		},
 	},
+	{
+		/*
+		 * On the Peaq C1010 2-in-1 INT33FC:00 pin 3 is connected to
+		 * a "dolby" button. At the ACPI level an _AEI event-handler
+		 * is connected which sets an ACPI variable to 1 on both
+		 * edges. This variable can be polled + cleared to 0 using
+		 * WMI. But since the variable is set on both edges the WMI
+		 * interface is pretty useless even when polling.
+		 * So instead the x86-android-tablets code instantiates
+		 * a gpio-keys platform device for it.
+		 * Ignore the _AEI handler for the pin, so that it is not busy.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PEAQ"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PEAQ PMM C1010 MD99187"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "INT33FC:00@3",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.42.0

