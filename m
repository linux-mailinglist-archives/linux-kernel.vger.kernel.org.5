Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE96800DE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379301AbjLAPDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379305AbjLAPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:03:04 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1210F9;
        Fri,  1 Dec 2023 07:03:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9c149848fso28109371fa.2;
        Fri, 01 Dec 2023 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442988; x=1702047788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=le5pIDN50e7Uxd1PpflXRC3s8qppBVl/m5JvMH//aA0=;
        b=I0aD1I/9e09dt/fkapt0wVQ0FpEp4ZvVe4wCuqT9xsMtiu0gTGFWRYrnJ4RfhggVJV
         NBQQcHQCyojH2wW0kCGzel5fA3mwYsFhbd5BclyuSFjRZHs+wciWA7BqRKnBDe5ZIMRc
         g+r8wYoREolt8p3Gh2576q7rTCa2IJdM0M0AYtRUzsL4K1UlnHhuKWQwHtkfJ+3kW6X6
         d3UU2NcYZAI7GyozAgRRemAdebBGrm/bcNHXjJDhn7th3YCY5ACFIJl8V+5/mofJSv3L
         O6nQWe1ZkXO+qMUsUf+ulPsx9jwE250MgonrGB1pKgciGBnytzdtu2lrdnJjQgWjA0RZ
         3NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442988; x=1702047788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=le5pIDN50e7Uxd1PpflXRC3s8qppBVl/m5JvMH//aA0=;
        b=xUFLFBo6Z7f34VTbFD7od1Oay5fj/o8e36q3CXmB+vrE761pOZsmxjSQyAFx8ekQfI
         b6LUq9YSNF55EMDfiYF+yx+DQ5IZA5ISloX0JUMvYDQtL7t0V3UJOWzE87a5ga9aMug1
         UXpuw3N/+jmfZAx8HmjbB9l0NPEGIUxvEfBnp/wU8QMCDzgkTkCG+2yBcTz8E48q2C7h
         04MkshAhnni8jcK6lckT7sF9SOxiDDEYvz0g/KU5Jd+P0hDRNd8iITN+QiHptadW6gxS
         3MnCTSw4fGLRgyr35dde+y0vL7ZnKCglmjXmvx0wa7UavhNxAN/XsQUYqDyCFLLjmMGk
         UsPw==
X-Gm-Message-State: AOJu0YxS5IPwQcb0JdX/DG2aZOVY5IH+w8HsX41zNTNMtWBj+Go48Wmz
        +CKEGF+X3Y6MlxEOmjyX50s=
X-Google-Smtp-Source: AGHT+IGucjqs1oD/NYz1sbmFEUsc5TMNKMkV0jCuNN9eS1nVQF8/jsZfL6t4CADvqllykluk60bhjg==
X-Received: by 2002:a2e:9b96:0:b0:2c9:d873:5c30 with SMTP id z22-20020a2e9b96000000b002c9d8735c30mr851259lji.66.1701442987489;
        Fri, 01 Dec 2023 07:03:07 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id nc6-20020a1709071c0600b0099bd7b26639sm309154ejc.6.2023.12.01.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:03:07 -0800 (PST)
From:   Eric Woudstra <ericwouds@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC] leds: trigger: netdev: add 2500 link speed mode
Date:   Fri,  1 Dec 2023 16:02:44 +0100
Message-ID: <20231201150247.4556-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
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

This will be useful for PHY leds where the PHY supports 2500Mbps.

 Changes to be committed:
	modified:   drivers/leds/trigger/ledtrig-netdev.c
	modified:   include/linux/leds.h

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 12 +++++++++++-
 include/linux/leds.h                  |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index e358e77e4b38..66dfd327ee5b 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -99,6 +99,10 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		    trigger_data->link_speed == SPEED_1000)
 			blink_on = true;
 
+		if (test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_2500)
+			blink_on = true;
+
 		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) &&
 		    trigger_data->duplex == DUPLEX_HALF)
 			blink_on = true;
@@ -286,6 +290,7 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_LINK_2500:
 	case TRIGGER_NETDEV_HALF_DUPLEX:
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
@@ -316,6 +321,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_LINK_2500:
 	case TRIGGER_NETDEV_HALF_DUPLEX:
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
@@ -334,7 +340,8 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
 	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_100, &mode) ||
-	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode)))
+	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_2500, &mode)))
 		return -EINVAL;
 
 	cancel_delayed_work_sync(&trigger_data->work);
@@ -364,6 +371,7 @@ DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
 DEFINE_NETDEV_TRIGGER(link_10, TRIGGER_NETDEV_LINK_10);
 DEFINE_NETDEV_TRIGGER(link_100, TRIGGER_NETDEV_LINK_100);
 DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
+DEFINE_NETDEV_TRIGGER(link_2500, TRIGGER_NETDEV_LINK_2500);
 DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
 DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
@@ -422,6 +430,7 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_link_10.attr,
 	&dev_attr_link_100.attr,
 	&dev_attr_link_1000.attr,
+	&dev_attr_link_2500.attr,
 	&dev_attr_full_duplex.attr,
 	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
@@ -519,6 +528,7 @@ static void netdev_trig_work(struct work_struct *work)
 			 test_bit(TRIGGER_NETDEV_LINK_10, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_100, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_2500, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &trigger_data->mode);
 		interval = jiffies_to_msecs(
diff --git a/include/linux/leds.h b/include/linux/leds.h
index aa16dc2a8230..c2ae68df50e2 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -588,6 +588,7 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_LINK_10,
 	TRIGGER_NETDEV_LINK_100,
 	TRIGGER_NETDEV_LINK_1000,
+	TRIGGER_NETDEV_LINK_2500,
 	TRIGGER_NETDEV_HALF_DUPLEX,
 	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
-- 
2.42.1

