Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860D7F30B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjKUO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjKUO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:27:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1870D51;
        Tue, 21 Nov 2023 06:26:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C7FE1F8B4;
        Tue, 21 Nov 2023 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700576818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iDJD3nBwjF/DIlBZV59XVtrBbRd1y5o1pq/WEwKhe/g=;
        b=ng/YBky5C7EViuhHN9Fe2UXwFFhgnzjbrzpwu8HkT2xElYbDXBo3OUdX7yl4zusl/SvHuC
        QUl155MbMS944yvVStWWdBfNK+txmXRNXixcuV6e6geDS1F/G3XN8aCoDDzn1E6K+9uVKL
        IfDP6W+U2IbuSM/KNjoa52+Du9Zguo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700576818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iDJD3nBwjF/DIlBZV59XVtrBbRd1y5o1pq/WEwKhe/g=;
        b=BQoJEXDxOAkADh2LDACfR1XW4sJbFa/TIR2PligyOGxAZCwGqSA7E1qFnMqCZLIScvcbVw
        A3PIXpCdzIWgENAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0762F138E3;
        Tue, 21 Nov 2023 14:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zSLbADK+XGVnUgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 21 Nov 2023 14:26:57 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        =?UTF-8?q?Johannes=20Pen=C3=9Fel?= <johannes.penssel@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Revert "leds: class: Store the color index in struct led_classdev"
Date:   Tue, 21 Nov 2023 15:26:29 +0100
Message-Id: <20231121142629.27083-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-3.00)[100.00%];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[traphandler.com,vger.kernel.org,gmail.com,system76.com,redhat.com];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c7d80059b086c4986cd994a1973ec7a5d75f8eea.

The commit caused regressions to a few drivers (such as Logitech
keyboard or System76 ACPI) that already had "color" leds sysfs entry;
now they conflict with the commonly created sysfs of led class.

For addressing the regression, we revert the commit, so that the
conflicting "color" sysfs entry is removed.

Note that the revert also removes the newly introduced
led_classdev.color field, too.  Since there is no user for that field
yet, it should be OK to revert the whole.  If this field is supposed
to be used in future, only the necessary part can be re-applied
later.

Fixes: c7d80059b086 ("leds: class: Store the color index in struct led_classdev")
Reported-by: Johannes Penßel <johannes.penssel@gmail.com>
Closes: https://lore.kernel.org/r/b5646db3-acff-45aa-baef-df3f660486fb@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218045
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218155
Link: https://bugzilla.suse.com/show_bug.cgi?id=1217172
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/ABI/testing/sysfs-class-led |  9 ---------
 drivers/leds/led-class.c                  | 21 ---------------------
 include/linux/leds.h                      |  1 -
 3 files changed, 31 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index b2ff0012c0f2..2e24ac3bd7ef 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -59,15 +59,6 @@ Description:
 		brightness. Reading this file when no hw brightness change
 		event has happened will return an ENODATA error.
 
-What:		/sys/class/leds/<led>/color
-Date:		June 2023
-KernelVersion:	6.5
-Description:
-		Color of the LED.
-
-		This is a read-only file. Reading this file returns the color
-		of the LED as a string (e.g: "red", "green", "multicolor").
-
 What:		/sys/class/leds/<led>/trigger
 Date:		March 2006
 KernelVersion:	2.6.17
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 974b84f6bd6a..4b3f1d49c625 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -75,19 +75,6 @@ static ssize_t max_brightness_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_brightness);
 
-static ssize_t color_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	const char *color_text = "invalid";
-	struct led_classdev *led_cdev = dev_get_drvdata(dev);
-
-	if (led_cdev->color < LED_COLOR_ID_MAX)
-		color_text = led_colors[led_cdev->color];
-
-	return sysfs_emit(buf, "%s\n", color_text);
-}
-static DEVICE_ATTR_RO(color);
-
 #ifdef CONFIG_LEDS_TRIGGERS
 static BIN_ATTR(trigger, 0644, led_trigger_read, led_trigger_write, 0);
 static struct bin_attribute *led_trigger_bin_attrs[] = {
@@ -102,7 +89,6 @@ static const struct attribute_group led_trigger_group = {
 static struct attribute *led_class_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_max_brightness.attr,
-	&dev_attr_color.attr,
 	NULL,
 };
 
@@ -505,10 +491,6 @@ int led_classdev_register_ext(struct device *parent,
 			fwnode_property_read_u32(init_data->fwnode,
 				"max-brightness",
 				&led_cdev->max_brightness);
-
-			if (fwnode_property_present(init_data->fwnode, "color"))
-				fwnode_property_read_u32(init_data->fwnode, "color",
-							 &led_cdev->color);
 		}
 	} else {
 		proposed_name = led_cdev->name;
@@ -518,9 +500,6 @@ int led_classdev_register_ext(struct device *parent,
 	if (ret < 0)
 		return ret;
 
-	if (led_cdev->color >= LED_COLOR_ID_MAX)
-		dev_warn(parent, "LED %s color identifier out of range\n", final_name);
-
 	mutex_init(&led_cdev->led_access);
 	mutex_lock(&led_cdev->led_access);
 	led_cdev->dev = device_create_with_groups(&leds_class, parent, 0,
diff --git a/include/linux/leds.h b/include/linux/leds.h
index aa16dc2a8230..8740b4e47f88 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -100,7 +100,6 @@ struct led_classdev {
 	const char		*name;
 	unsigned int brightness;
 	unsigned int max_brightness;
-	unsigned int color;
 	int			 flags;
 
 	/* Lower 16 bits reflect status */
-- 
2.35.3

