Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE380DE31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbjLKWSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:18:22 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3018F;
        Mon, 11 Dec 2023 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HjDLC1z/gNHWR5w81Ioq77XF+4q9WzaYs3i6lQVG3cQ=; b=IWIO0bSUZzgriJGDiKMLmpLc8I
        XDjDR7b2POpTimvirnRiyos7/JR6nogTB3VwVHGr0fgoXQ/WCG4sBAVNsgiMkZyvVmmQnAHvY1FCZ
        qKC4LjGAjyHPvx2YgjKt+c3Tv5JHfq5652EtUZwPcbZByGLkap7hfac+mZrIyV+vAu/7o29taFi1b
        ejLNgzzCzhqbkiz4RnNhA15SIyNhM14B8eJlmhEN+ACyVl0yJVDNiIK2pK91oGz9vKRgTEg4p6Ewc
        Eb0A+MtZFPYSNxtPlGNRM9tApcLJi/Dew0nxyueP5IMG+R1taD8RxOP+Cbl+Edt1aq3bd9ToR0rld
        0uO0uoqg==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1rCobF-007I1S-Ky; Mon, 11 Dec 2023 23:18:05 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1rCobE-002Abo-2J;
        Mon, 11 Dec 2023 23:18:04 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, Jonathan.Cameron@huawei.com,
        tony@atomide.com, robh@kernel.org, andreas@kemnade.info,
        frank.li@vivo.com, u.kleine-koenig@pengutronix.de,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: omap4-keypad: react on keypresses if device is runtime-suspended
Date:   Mon, 11 Dec 2023 23:17:57 +0100
Message-Id: <20231211221757.517427-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v2:
- error check for clk_prepare_enable() although it should never
  be reached without that clock being enabled, but lets be
  careful.
Changes since RFC:
- add R-by:
 drivers/input/keyboard/omap4-keypad.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index d3f8688fdd9c3..040b340995d89 100644
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
@@ -209,6 +211,10 @@ static int omap4_keypad_open(struct input_dev *input)
 	if (error)
 		return error;
 
+	error = clk_prepare_enable(keypad_data->fck);
+	if (error)
+		goto out;
+
 	disable_irq(keypad_data->irq);
 
 	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
@@ -226,10 +232,11 @@ static int omap4_keypad_open(struct input_dev *input)
 
 	enable_irq(keypad_data->irq);
 
+out:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	return 0;
+	return error;
 }
 
 static void omap4_keypad_stop(struct omap4_keypad *keypad_data)
@@ -258,6 +265,7 @@ static void omap4_keypad_close(struct input_dev *input)
 	disable_irq(keypad_data->irq);
 	omap4_keypad_stop(keypad_data);
 	enable_irq(keypad_data->irq);
+	clk_disable_unprepare(keypad_data->fck);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -356,6 +364,11 @@ static int omap4_keypad_probe(struct platform_device *pdev)
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

