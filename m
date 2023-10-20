Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D387D12D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjJTPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbjJTPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:32:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB611A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:32:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b709048f32so849986b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697815927; x=1698420727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrkAHRzg2TdBg0hOlxFqzRcMXhMbitBosyKYGzECZHs=;
        b=R8vsWJIJ0aXJXIX9jqAlBlBpM9Vf1MRRQQZDw3f2aCESV7ftSNlRIaPOHdnj/EF7yn
         A6PwWnbfqqi6ZOLNvF86OZh1LMBT+/YmZ8av6UZsm3dINIctNk6RspRhI1DJVoCkrsFj
         9+e/OUMC5Jz9UwAOgeyeKtHcEexGetVJo3eIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815927; x=1698420727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrkAHRzg2TdBg0hOlxFqzRcMXhMbitBosyKYGzECZHs=;
        b=uogvtdI3HAMbQkkevOe6+Mrj4KjdKXXDjafqdSJhzYf2wXMpWP06yLNuFXDp3O26yN
         KjpuUFCBcdkJP5D0LnETb9IamjrJ/zxZXp4gutwc4SlbHGr9AHFw9T4BltWTWG281sWY
         idmcRrL1nzYiJWvV4RxZSWbp3qOpGBk/uY5vSJ9f0IIrYGTrjSuhSFu2o2vW+Yfygq5P
         qpGjhwKcf8YjZx+qAEewq58fHkb5n7RyU6pTmTNGKhcl3jXRBxWKPaF/HugYKY6PUVfj
         Km/oBFt8fCeKepowt8Xa90H3UKOpsqlG/B4GblHvFhvPcVAOWYSGXQMxuA3AnxyvRl2g
         szXA==
X-Gm-Message-State: AOJu0YxIiP2GMJP9RjwHZZWghdDegPYQVPadvEgiyV8j1yUxCJQu11eM
        Sxt77ZFG9spAT6C3xo4MuFsaOQ==
X-Google-Smtp-Source: AGHT+IFoLL1b+Un76zh7hfg5+Xw51dVoIxblqmAnOnKb7clZ8mwG4LkDBdyp05qfWwssgsgH7xNBfA==
X-Received: by 2002:a05:6300:8004:b0:171:8e16:ea86 with SMTP id an4-20020a056300800400b001718e16ea86mr2173248pzc.31.1697815927207;
        Fri, 20 Oct 2023 08:32:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a4a0a00b002794fe14cabsm3317531pjh.12.2023.10.20.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:32:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Cc:     Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ray Chi <raychi@google.com>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Rob Herring <robh@kernel.org>, Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: Prevent infinite loops when usb_reset_device() unbinds/binds
Date:   Fri, 20 Oct 2023 08:31:38 -0700
Message-ID: <20231020083125.1.I3e5f7abcbf6f08d392e31a5826b7f234df662276@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we call usb_reset_device() and a driver doesn't implement
pre_reset() and post_reset() methods then the USB core will attempt to
unbind and rebind the driver in order to make reset work. This is a
great general solution, but it has the potential to loop forever.
Specifically, if the USB device is in a state that the USB device
driver issues another usb_reset_device() after each rebind then we'll
just continually unbind and rebind with no end.

It's difficult to address this condition in a USB device driver
because it's hard for the driver to keep state across each
unbind/bind. Various tricks could be done by keeping static globals,
but these are difficult to make reliable if there are multiple USB
devices using the same driver at the same time.

Let's solve this problem in the USB core. If we notice that we're
doing an unbind/bind for usb_reset_device() several times in a short
period of time, we'll eventually give up. For now, we'll allow 3
resets in a short period of time (and continue to allow an unbounded
number if they are spaced out). We'll say that any unbind/rebind reset
happened within 5 seconds of the previous one that it counts.

This patch is written in response to review comments for a patch to
the r8152 driver [1]. The problem it is solving is not actually seen
in practice but it seems plausible that it could happen.

[1] https://lore.kernel.org/r/20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/core/driver.c  | 38 ++++++++++++++++++++++++++++++++------
 drivers/usb/core/hub.c     |  2 +-
 drivers/usb/core/message.c |  2 +-
 drivers/usb/core/usb.h     |  2 +-
 include/linux/usb.h        |  7 +++++++
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index f58a0299fb3b..5849cc21eb3f 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1104,21 +1104,47 @@ void usb_deregister(struct usb_driver *driver)
 }
 EXPORT_SYMBOL_GPL(usb_deregister);
 
+#define CONSECUTIVE_RESET_JIFFIES	(HZ * 5)
+#define MAX_CONSECUTIVE_RESETS		3
+
 /* Forced unbinding of a USB interface driver, either because
  * it doesn't support pre_reset/post_reset/reset_resume or
  * because it doesn't support suspend/resume.
  *
  * The caller must hold @intf's device's lock, but not @intf's lock.
  */
-void usb_forced_unbind_intf(struct usb_interface *intf)
+void usb_forced_unbind_intf(struct usb_interface *intf, bool for_reset)
 {
 	struct usb_driver *driver = to_usb_driver(intf->dev.driver);
 
 	dev_dbg(&intf->dev, "forced unbind\n");
 	usb_driver_release_interface(driver, intf);
 
-	/* Mark the interface for later rebinding */
-	intf->needs_binding = 1;
+	/*
+	 * If we're doing an unbind/rebind for a device that doesn't support
+	 * reset then make an attempt to avoid looking the reset over and over.
+	 *
+	 * NOTE: with jiffies wraparound it is nominally possible that we could
+	 * falsely detect that two resets are consecutive if we get a reset at
+	 * just the right time. Given that 1000 HZ w/ 32-bit jiffies wraps in
+	 * ~50 days, this is highly unlikely. In any case, it should be nearly
+	 * impossible to hit this many times in a row.
+	 */
+	if (for_reset && time_in_range(jiffies, jiffies,
+				       intf->last_reset_rebind_jiffies +
+				       CONSECUTIVE_RESET_JIFFIES))
+		intf->consecutive_reset_rebind_count++;
+	else
+		intf->consecutive_reset_rebind_count = 0;
+
+	if (for_reset)
+		intf->last_reset_rebind_jiffies = jiffies;
+
+	if (intf->consecutive_reset_rebind_count >= MAX_CONSECUTIVE_RESETS)
+		dev_warn(&intf->dev, "Too many resets in a row; giving up\n");
+	else
+		/* Mark the interface for later rebinding */
+		intf->needs_binding = 1;
 }
 
 /*
@@ -1138,7 +1164,7 @@ static void unbind_marked_interfaces(struct usb_device *udev)
 		for (i = 0; i < config->desc.bNumInterfaces; ++i) {
 			intf = config->interface[i];
 			if (intf->dev.driver && intf->needs_binding)
-				usb_forced_unbind_intf(intf);
+				usb_forced_unbind_intf(intf, false);
 		}
 	}
 }
@@ -1157,7 +1183,7 @@ static void usb_rebind_intf(struct usb_interface *intf)
 
 	/* Delayed unbind of an existing driver */
 	if (intf->dev.driver)
-		usb_forced_unbind_intf(intf);
+		usb_forced_unbind_intf(intf, false);
 
 	/* Try to rebind the interface */
 	if (!intf->dev.power.is_prepared) {
@@ -1226,7 +1252,7 @@ static void unbind_no_pm_drivers_interfaces(struct usb_device *udev)
 			if (intf->dev.driver) {
 				drv = to_usb_driver(intf->dev.driver);
 				if (!drv->suspend || !drv->resume)
-					usb_forced_unbind_intf(intf);
+					usb_forced_unbind_intf(intf, false);
 			}
 		}
 	}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0ff47eeffb49..54f60413940f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6229,7 +6229,7 @@ int usb_reset_device(struct usb_device *udev)
 						USB_INTERFACE_BOUND)
 					unbind = 1;
 				if (unbind)
-					usb_forced_unbind_intf(cintf);
+					usb_forced_unbind_intf(cintf, true);
 			}
 		}
 	}
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 077dfe48d01c..8e18912a6a6b 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1793,7 +1793,7 @@ void usb_deauthorize_interface(struct usb_interface *intf)
 		intf->authorized = 0;
 		device_unlock(dev);
 
-		usb_forced_unbind_intf(intf);
+		usb_forced_unbind_intf(intf, false);
 	}
 
 	device_unlock(dev->parent);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 60363153fc3f..105bd6e2b69d 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -76,7 +76,7 @@ extern const struct usb_device_id *usb_device_match_id(struct usb_device *udev,
 				const struct usb_device_id *id);
 extern bool usb_driver_applicable(struct usb_device *udev,
 				  struct usb_device_driver *udrv);
-extern void usb_forced_unbind_intf(struct usb_interface *intf);
+extern void usb_forced_unbind_intf(struct usb_interface *intf, bool for_reset);
 extern void usb_unbind_and_rebind_marked_interfaces(struct usb_device *udev);
 
 extern void usb_hub_release_all_ports(struct usb_device *hdev,
diff --git a/include/linux/usb.h b/include/linux/usb.h
index a21074861f91..f554ef7d62e6 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -212,6 +212,10 @@ enum usb_wireless_status {
  * @reset_ws: Used for scheduling resets from atomic context.
  * @resetting_device: USB core reset the device, so use alt setting 0 as
  *	current; needs bandwidth alloc after reset.
+ * @last_reset_rebind_jiffies: The jiffies count last time we did an
+ *	unbind/rebind as part of reset.
+ * @consecutive_reset_rebind_count: The number of times in a row we've done a
+ *	rebind for reset soon after doing one.
  *
  * USB device drivers attach to interfaces on a physical device.  Each
  * interface encapsulates a single high level function, such as feeding
@@ -268,6 +272,9 @@ struct usb_interface {
 	struct device dev;		/* interface specific device info */
 	struct device *usb_dev;
 	struct work_struct reset_ws;	/* for resets in atomic context */
+
+	unsigned long last_reset_rebind_jiffies;
+	unsigned int consecutive_reset_rebind_count;
 };
 
 #define to_usb_interface(__dev)	container_of_const(__dev, struct usb_interface, dev)
-- 
2.42.0.758.gaed0368e0e-goog

