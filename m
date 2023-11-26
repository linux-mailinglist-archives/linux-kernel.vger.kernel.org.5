Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6D7F9542
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjKZURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 15:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjKZURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 15:17:17 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD124E5;
        Sun, 26 Nov 2023 12:17:22 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r7LYw-0001n7-1a;
        Sun, 26 Nov 2023 20:17:07 +0000
Date:   Sun, 26 Nov 2023 20:17:03 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <3655d56c08b60f0ce562ceab3a627fef046a7617.1701029732.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 29 ++++++++++++++++++++++++++-
 include/linux/leds.h                  |  3 +++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index e358e77e4b38f..612f214cd4f3c 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -99,6 +99,18 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		    trigger_data->link_speed == SPEED_1000)
 			blink_on = true;
 
+		if (test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_2500)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_5000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_5000)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_10000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_10000)
+			blink_on = true;
+
 		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) &&
 		    trigger_data->duplex == DUPLEX_HALF)
 			blink_on = true;
@@ -286,6 +298,9 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_LINK_2500:
+	case TRIGGER_NETDEV_LINK_5000:
+	case TRIGGER_NETDEV_LINK_10000:
 	case TRIGGER_NETDEV_HALF_DUPLEX:
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
@@ -316,6 +331,9 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_LINK_2500:
+	case TRIGGER_NETDEV_LINK_5000:
+	case TRIGGER_NETDEV_LINK_10000:
 	case TRIGGER_NETDEV_HALF_DUPLEX:
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
@@ -334,7 +352,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
 	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_100, &mode) ||
-	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode)))
+	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_2500, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_5000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_10000, &mode)))
 		return -EINVAL;
 
 	cancel_delayed_work_sync(&trigger_data->work);
@@ -364,6 +385,9 @@ DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
 DEFINE_NETDEV_TRIGGER(link_10, TRIGGER_NETDEV_LINK_10);
 DEFINE_NETDEV_TRIGGER(link_100, TRIGGER_NETDEV_LINK_100);
 DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
+DEFINE_NETDEV_TRIGGER(link_2500, TRIGGER_NETDEV_LINK_2500);
+DEFINE_NETDEV_TRIGGER(link_5000, TRIGGER_NETDEV_LINK_5000);
+DEFINE_NETDEV_TRIGGER(link_10000, TRIGGER_NETDEV_LINK_10000);
 DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
 DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
@@ -519,6 +543,9 @@ static void netdev_trig_work(struct work_struct *work)
 			 test_bit(TRIGGER_NETDEV_LINK_10, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_100, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_5000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_10000, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &trigger_data->mode);
 		interval = jiffies_to_msecs(
diff --git a/include/linux/leds.h b/include/linux/leds.h
index aa16dc2a8230f..1bdf7f5a0d7c0 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -588,6 +588,9 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_LINK_10,
 	TRIGGER_NETDEV_LINK_100,
 	TRIGGER_NETDEV_LINK_1000,
+	TRIGGER_NETDEV_LINK_2500,
+	TRIGGER_NETDEV_LINK_5000,
+	TRIGGER_NETDEV_LINK_10000,
 	TRIGGER_NETDEV_HALF_DUPLEX,
 	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
-- 
2.43.0
