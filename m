Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B57FD4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjK2LHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjK2LHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:07:10 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3D61990;
        Wed, 29 Nov 2023 03:07:15 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id BC90F603F4;
        Wed, 29 Nov 2023 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701256035;
        bh=QLE5HdiOb5o5sP/1aVwOBc3v1Ohi4Ot5lukAFe+jq0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8r5oWyGRwgjer8PhRkZD8N7tlSmr0Ff2RU/uKGX+/ZDOdPwteg8a+MnG/9moVx7g
         R+U7U1Fw+rdDihH2skLuCIdVZDMN9Epg+rQRh1OgMWgvaVDvobVFvNXuJAjNMYHUbl
         3cJwXEyQzKdL6tlIQK5Jr2CEYtxw70N0awMYm68ygO5ltFh0+mTDMJ1AuFm9c6M7yJ
         lwPOvrxaQXzZNng3kVY3W5YJi91grp1h8RGANNeOMfXJqXnepUPzRagqCliam6Gr9D
         8wFzv6QLZycvxcebXAURdZd/3siEeD7HvKq0L5QdCWGmXv6rEeQCHpemcDRZdrMO4r
         xCgjskoosZOUw==
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v5 2/2] Input: gpio-keys - Add system suspend support for dedicated wakeirqs
Date:   Wed, 29 Nov 2023 13:06:15 +0200
Message-ID: <20231129110618.27551-2-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231129110618.27551-1-tony@atomide.com>
References: <20231129110618.27551-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have a separate dedicated wake-up interrupt controller that can
be used to wake up the system from deeper idle states. We already support
configuring a separate interrupt for a gpio-keys button to be used with a
gpio line. However, we are lacking support system suspend for cases where
a separate interrupt needs to be used in deeper sleep modes.

Because of it's nature, gpio-keys does not know about the runtime PM state
of the button gpios, and may have several gpio buttons configured for each
gpio-keys device instance. Implementing runtime PM support for gpio-keys
does not help, and we cannot use drivers/base/power/wakeirq.c support. We
need to implement custom wakeirq support for gpio-keys.

For handling a dedicated wakeirq for system suspend, we enable and disable
it with gpio_keys_enable_wakeup() and gpio_keys_disable_wakeup() that we
already use based on device_may_wakeup().

Some systems may have a dedicated wakeirq that can also be used as the
main interrupt, this is already working for gpio-keys. Let's add some
wakeirq related comments while at it as the usage with a gpio line and
separate interrupt line may not be obvious.

Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since v5

- Use normal disable_irq() as suggested by Dmitry

No driver changes between v1 and v4

---
 drivers/input/keyboard/gpio_keys.c | 69 ++++++++++++++++++++++++++++--
 include/linux/gpio_keys.h          |  2 +
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -45,7 +45,9 @@ struct gpio_button_data {
 	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
 
 	unsigned int irq;
+	unsigned int wakeirq;
 	unsigned int wakeup_trigger_type;
+
 	spinlock_t lock;
 	bool disabled;
 	bool key_pressed;
@@ -511,6 +513,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	struct gpio_button_data *bdata = &ddata->data[idx];
 	irq_handler_t isr;
 	unsigned long irqflags;
+	const char *wakedesc;
 	int irq;
 	int error;
 
@@ -575,6 +578,14 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 					!gpiod_cansleep(bdata->gpiod);
 		}
 
+		/*
+		 * If an interrupt was specified, use it instead of the gpio
+		 * interrupt and use the gpio for reading the state. A separate
+		 * interrupt may be used as the main button interrupt for
+		 * runtime PM to detect events also in deeper idle states. If a
+		 * dedicated wakeirq is used for system suspend only, see below
+		 * for bdata->wakeirq setup.
+		 */
 		if (button->irq) {
 			bdata->irq = button->irq;
 		} else {
@@ -672,6 +683,36 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		return error;
 	}
 
+	if (!button->wakeirq)
+		return 0;
+
+	/* Use :wakeup suffix like drivers/base/power/wakeirq.c does */
+	wakedesc = devm_kasprintf(dev, GFP_KERNEL, "%s:wakeup", desc);
+	if (!wakedesc)
+		return -ENOMEM;
+
+	bdata->wakeirq = button->wakeirq;
+	irqflags |= IRQF_NO_SUSPEND;
+
+	/*
+	 * Wakeirq shares the handler with the main interrupt, it's only
+	 * active during system suspend. See gpio_keys_button_enable_wakeup()
+	 * and gpio_keys_button_disable_wakeup().
+	 */
+	error = devm_request_any_context_irq(dev, bdata->wakeirq, isr,
+					     irqflags, wakedesc, bdata);
+	if (error < 0) {
+		dev_err(dev, "Unable to claim wakeirq %d; error %d\n",
+			bdata->irq, error);
+		return error;
+	}
+
+	/*
+	 * Disable wakeirq until suspend. IRQF_NO_AUTOEN won't work if
+	 * IRQF_SHARED was set based on !button->can_disable.
+	 */
+	disable_irq(bdata->wakeirq);
+
 	return 0;
 }
 
@@ -728,7 +769,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
 	struct fwnode_handle *child;
-	int nbuttons;
+	int nbuttons, irq;
 
 	nbuttons = device_get_child_node_count(dev);
 	if (nbuttons == 0)
@@ -750,9 +791,19 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	device_property_read_string(dev, "label", &pdata->name);
 
 	device_for_each_child_node(dev, child) {
-		if (is_of_node(child))
-			button->irq =
-				irq_of_parse_and_map(to_of_node(child), 0);
+		if (is_of_node(child)) {
+			irq = of_irq_get_byname(to_of_node(child), "irq");
+			if (irq > 0)
+				button->irq = irq;
+
+			irq = of_irq_get_byname(to_of_node(child), "wakeup");
+			if (irq > 0)
+				button->wakeirq = irq;
+
+			if (!button->irq && !button->wakeirq)
+				button->irq =
+					irq_of_parse_and_map(to_of_node(child), 0);
+		}
 
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button->code)) {
@@ -921,6 +972,11 @@ gpio_keys_button_enable_wakeup(struct gpio_button_data *bdata)
 		}
 	}
 
+	if (bdata->wakeirq) {
+		enable_irq(bdata->wakeirq);
+		disable_irq(bdata->irq);
+	}
+
 	return 0;
 }
 
@@ -929,6 +985,11 @@ gpio_keys_button_disable_wakeup(struct gpio_button_data *bdata)
 {
 	int error;
 
+	if (bdata->wakeirq) {
+		enable_irq(bdata->irq);
+		disable_irq(bdata->wakeirq);
+	}
+
 	/*
 	 * The trigger type is always both edges for gpio-based keys and we do
 	 * not support changing wakeup trigger for interrupt-based keys.
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -21,6 +21,7 @@ struct device;
  *			disable button via sysfs
  * @value:		axis value for %EV_ABS
  * @irq:		Irq number in case of interrupt keys
+ * @wakeirq:		Optional dedicated wake-up interrupt
  */
 struct gpio_keys_button {
 	unsigned int code;
@@ -34,6 +35,7 @@ struct gpio_keys_button {
 	bool can_disable;
 	int value;
 	unsigned int irq;
+	unsigned int wakeirq;
 };
 
 /**
-- 
2.42.1
