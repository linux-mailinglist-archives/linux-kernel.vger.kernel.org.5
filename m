Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D7A811579
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442071AbjLMPBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442010AbjLMPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:01:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A793;
        Wed, 13 Dec 2023 07:01:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3333131e08dso7505799f8f.2;
        Wed, 13 Dec 2023 07:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702479672; x=1703084472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SO2+BrR+SqnVNVhmwzorIkGMHMJFcnZZ8bwmNp3Xw8=;
        b=av0l4gI6C2cijxN17TZeMF1/6xLLqd9Aztp2L7BucD7ajdvJlpw/GxtyrlP+k3vgxh
         S1RJaFbLmsL+M8bw9zMYA6Msn3PUnu8QMDv4DRSsvHFQ5i/Mu13a/v7BTJmb6m1KGfcW
         9gsmJ9kZjqmGHBcIGNIzwvXAJ5J/srGw4lEaGsEeIt8G6G+xUP9LwRM0LVSUzC0QcN/1
         1MdypzOxOKTrEGakMU8O4CukWrRKdjRGonKqvH5Xo/NY+YtVeYjJAgJMI8bPyFhh30XI
         sVoaBKesMUOUxmhOAgFXOyYrN44dw/CzCFwQb3N2qts1rl4ew0L9szQ4qSvrDH/yJGRL
         dw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479672; x=1703084472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SO2+BrR+SqnVNVhmwzorIkGMHMJFcnZZ8bwmNp3Xw8=;
        b=d7xy5q5j1iMQq2MUtXMbQBlmN3lzAi/8S/zhQSA/shTue0plgvwBdHSJGtmPz2rnCP
         MhB3DYcsOxn0vHfEZ4eHIIykJsjNERvTKbAwBS3kZM+vjz5rumOnMlWMNMKl/U1nEp2P
         2KOsolge2c/MPcQGfss9BF304aGPFmlD2mDOKTn1hJgdYHpMkrfAeqwOCiBX/VDM71+i
         rUDDKjopnFLIsNoIvJix4dFj9KXgioDDOgTb9+ZYvru5rXTUmFdBwNH+hVvICEvp67rk
         K8qY5itTJEcS6DGPyywZrU5V6bqGCb/BgMz0neet6iVEpiIJ0plOheOAFce6hjOEqAOt
         UnXA==
X-Gm-Message-State: AOJu0YwH4cNh8rEhBDOkcWPwRr4cQnxI9dHEIwvh9meTkjdZboLj0n/W
        F4cDTTAsT5Q/6wek6l//Y7Y=
X-Google-Smtp-Source: AGHT+IGtRXvOqAE9IHtr57hg4SfXnfl6lwm74zhO88POqVRONPU+hc31gc+rQubS4zH4EpLr7Up7tQ==
X-Received: by 2002:a05:600c:4449:b0:40c:4b43:d98f with SMTP id v9-20020a05600c444900b0040c4b43d98fmr2151358wmn.28.1702479672305;
        Wed, 13 Dec 2023 07:01:12 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id e6-20020a5d4e86000000b00336365d1dafsm2814378wru.69.2023.12.13.07.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:01:10 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 1/2] leds: trigger: netdev: display only supported link speed attribute
Date:   Wed, 13 Dec 2023 16:00:32 +0100
Message-Id: <20231213150033.17057-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of more link speed mode to the netdev trigger, it was
pointed out that there may be a problem with bloating the attribute list
with modes that won't ever be supported by the trigger as the attached
device name doesn't support them.

To clear and address this problem, change the logic where these
additional trigger modes are listed.

Since the netdev trigger REQUIRE a device name to be set, attach to the
device name change function additional logic to parse the supported link
speed modes using ethtool APIs and show only the supported link speed
modes attribute.

Link speed attribute are refreshed on device_name set and on
NETDEV_CHANGE events.

This only apply to the link speed modes and every other mode is still
provided by default.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Use is_visibile instead of removing/adding attr

 drivers/leds/trigger/ledtrig-netdev.c | 91 +++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index bd68da15c723..6b81836b2ea8 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -18,6 +18,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/linkmode.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -55,12 +56,15 @@ struct led_netdev_data {
 
 	unsigned long mode;
 	int link_speed;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_link_speed);
 	u8 duplex;
 
 	bool carrier_link_up;
 	bool hw_control;
 };
 
+static const struct attribute_group netdev_trig_link_speed_attrs_group;
+
 static void set_baseline_state(struct led_netdev_data *trigger_data)
 {
 	int current_brightness;
@@ -208,13 +212,19 @@ static void get_device_state(struct led_netdev_data *trigger_data)
 	struct ethtool_link_ksettings cmd;
 
 	trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
-	if (!trigger_data->carrier_link_up)
+
+	if (__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd))
 		return;
 
-	if (!__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd)) {
+	if (trigger_data->carrier_link_up) {
 		trigger_data->link_speed = cmd.base.speed;
 		trigger_data->duplex = cmd.base.duplex;
 	}
+
+	/* Have a local copy of the link speed advertised to not rtnl lock every time
+	 * Modes are refreshed on any change event to handle mode changes
+	 */
+	linkmode_copy(trigger_data->supported_link_speed, cmd.link_modes.supported);
 }
 
 static ssize_t device_name_show(struct device *dev,
@@ -257,6 +267,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = SPEED_UNKNOWN;
 	trigger_data->duplex = DUPLEX_UNKNOWN;
+	linkmode_zero(trigger_data->supported_link_speed);
 	if (trigger_data->net_dev != NULL) {
 		rtnl_lock();
 		get_device_state(trigger_data);
@@ -282,6 +293,10 @@ static ssize_t device_name_store(struct device *dev,
 
 	if (ret < 0)
 		return ret;
+
+	/* Refresh link_speed visibility */
+	sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
+
 	return size;
 }
 
@@ -440,15 +455,65 @@ static ssize_t offloaded_show(struct device *dev,
 
 static DEVICE_ATTR_RO(offloaded);
 
-static struct attribute *netdev_trig_attrs[] = {
-	&dev_attr_device_name.attr,
-	&dev_attr_link.attr,
+static umode_t netdev_trig_link_speed_visible(struct kobject *kobj,
+					      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct led_netdev_data *trigger_data;
+	unsigned long *supported_link_speed;
+
+	trigger_data = led_trigger_get_drvdata(dev);
+	supported_link_speed = trigger_data->supported_link_speed;
+
+	/* Display only supported entry */
+	if (attr == &dev_attr_link_10.attr &&
+	    (test_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported_link_speed) ||
+	     test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported_link_speed)))
+		return attr->mode;
+
+	if (attr == &dev_attr_link_100.attr &&
+	    (test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported_link_speed) ||
+	     test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported_link_speed)))
+		return attr->mode;
+
+	if (attr == &dev_attr_link_1000.attr &&
+	    (test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported_link_speed) ||
+	     test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported_link_speed)))
+		return attr->mode;
+
+	if (attr == &dev_attr_link_2500.attr &&
+	    test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported_link_speed))
+		return attr->mode;
+
+	if (attr == &dev_attr_link_5000.attr &&
+	    test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported_link_speed))
+		return attr->mode;
+
+	if (attr == &dev_attr_link_10000.attr &&
+	    test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported_link_speed))
+		return attr->mode;
+
+	return 0;
+}
+
+static struct attribute *netdev_trig_link_speed_attrs[] = {
 	&dev_attr_link_10.attr,
 	&dev_attr_link_100.attr,
 	&dev_attr_link_1000.attr,
 	&dev_attr_link_2500.attr,
 	&dev_attr_link_5000.attr,
 	&dev_attr_link_10000.attr,
+	NULL
+};
+
+static const struct attribute_group netdev_trig_link_speed_attrs_group = {
+	.attrs = netdev_trig_link_speed_attrs,
+	.is_visible = netdev_trig_link_speed_visible,
+};
+
+static struct attribute *netdev_trig_attrs[] = {
+	&dev_attr_device_name.attr,
+	&dev_attr_link.attr,
 	&dev_attr_full_duplex.attr,
 	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
@@ -457,7 +522,16 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_offloaded.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(netdev_trig);
+
+static const struct attribute_group netdev_trig_attrs_group = {
+	.attrs = netdev_trig_attrs,
+};
+
+static const struct attribute_group *netdev_trig_groups[] = {
+	&netdev_trig_attrs_group,
+	&netdev_trig_link_speed_attrs_group,
+	NULL,
+};
 
 static int netdev_trig_notify(struct notifier_block *nb,
 			      unsigned long evt, void *dv)
@@ -466,6 +540,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct led_classdev *led_cdev = trigger_data->led_cdev;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -500,6 +575,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
 		get_device_state(trigger_data);
+		/* Refresh link_speed visibility */
+		if (evt == NETDEV_CHANGE)
+			sysfs_update_group(&led_cdev->dev->kobj,
+					   &netdev_trig_link_speed_attrs_group);
 		break;
 	}
 
-- 
2.40.1

