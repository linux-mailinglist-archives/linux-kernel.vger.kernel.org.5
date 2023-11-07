Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C114B7E3BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjKGMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjKGMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:09:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3010C2;
        Tue,  7 Nov 2023 04:08:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D4EC433C7;
        Tue,  7 Nov 2023 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358917;
        bh=wdiInk9T1JqhqxMF/AobLGrru/KAemyiOiVhZCBoZ2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8g6Mk3cdcP2BuKTwYXesCVM05KI/S4ao8k/GEioBLUVdn1iXHd6vLWXbizfuwmS4
         IxWDkcXstsZVxZgoeDwhcq2VQCze07BjxRDLZhzhhgi2BWhVNlt2t2S4wwuwQkd27i
         7kmCQEOh/Tj8IXjJ9uocKzLLflEKMHY/ufoOVcWI+s90lHi/IUpddUynII2DhK/jTf
         y0/p8HXEzd4vxk2JkLGOjFPL+T1i7NEouMmNrBY2WJKPwfm/6s/YYtHFYBjNl5fEaq
         uqIwYQBvF+lG4BUoaCCYTEqCMJ+d3vAT2ExJw5xt7iqeJocGzPruGScbYvXaXMzd6E
         /K4jz9aWK8NQw==
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
Subject: [PATCH AUTOSEL 6.6 28/31] gpiolib: acpi: Add a ignore interrupt quirk for Peaq C1010
Date:   Tue,  7 Nov 2023 07:06:15 -0500
Message-ID: <20231107120704.3756327-28-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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
index 51e41676de0b8..5d04720107ef5 100644
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

