Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1087F951E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjKZTng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZTne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:43:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA97102
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:43:41 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7L2K-006kkS-KP; Sun, 26 Nov 2023 20:43:24 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r7L2K-000T0f-09;
        Sun, 26 Nov 2023 20:43:24 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, tony@atomide.com,
        u.kleine-koenig@pengutronix.de, robh@kernel.org,
        Jonathan.Cameron@huawei.com, andreas@kemnade.info,
        frank.li@vivo.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: omap4-keypad: react on keypresses if device is runtime-suspended
Date:   Sun, 26 Nov 2023 20:43:19 +0100
Message-Id: <20231126194319.111504-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to SWPU235AB, table 26-6, fclk is required to generate events
at least on OMAP4460, so keep fclk enabled all the time the device
is opened.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
Changes since RFC:
- add R-by:

 drivers/input/keyboard/omap4-keypad.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index d3f8688fdd9c3..7d83aff95617f 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -83,6 +84,7 @@ struct omap4_keypad {
 	bool no_autorepeat;
 	u64 keys;
 	unsigned short *keymap;
+	struct clk *fck;
 };
 
 static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
@@ -211,6 +213,8 @@ static int omap4_keypad_open(struct input_dev *input)
 
 	disable_irq(keypad_data->irq);
 
+	clk_prepare_enable(keypad_data->fck);
+
 	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
 			OMAP4_DEF_CTRL_NOSOFTMODE |
 			(OMAP4_KEYPAD_PTV_DIV_128 << OMAP4_DEF_CTRL_PTV_SHIFT));
@@ -258,6 +262,7 @@ static void omap4_keypad_close(struct input_dev *input)
 	disable_irq(keypad_data->irq);
 	omap4_keypad_stop(keypad_data);
 	enable_irq(keypad_data->irq);
+	clk_disable_unprepare(keypad_data->fck);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -356,6 +361,11 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad_data->irq = irq;
+	keypad_data->fck = devm_clk_get(&pdev->dev, "fck");
+	if (IS_ERR(keypad_data->fck))
+		return dev_err_probe(&pdev->dev, PTR_ERR(keypad_data->fck),
+				     "unable to get fck");
+
 	mutex_init(&keypad_data->lock);
 	platform_set_drvdata(pdev, keypad_data);
 
-- 
2.39.2

