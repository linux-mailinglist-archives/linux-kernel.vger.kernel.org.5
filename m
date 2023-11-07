Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374387E441A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344092AbjKGPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344035AbjKGPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:47:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331ECDF;
        Tue,  7 Nov 2023 07:47:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA0AC433C9;
        Tue,  7 Nov 2023 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372032;
        bh=4MmKKuNVnj+NVnyu774P4r8Sl2NY59lB31bp2akadoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1QBKvuFDDRrXrcNH2UJ1LnJrwW5MDw7pEXEIixd9np3+b7ZkFBOOnFbj05CAoQyI
         9CPUFQ5A+e3+bvzZDQfrmmQFtupDx3rA8peCaHOPZpvX8PcLdzwIwXn/dyB1Lk4Ew+
         evnWWx1/fsyVFk9ibxjuYDVSanJd0w8d1zIFP8rB81a1zritOsxCkPz7HaYonGj0FB
         fzL1KWOqAgVfA8Y/0Icx8Xa6/R0wW6aQDPPN2ZmWVp7SrRHvKCShBSY5SVVHOkCg+L
         jUlzOmp+SNiK7xgEK/nVu+71IQBVMBRfQhO0mpPntdtVeGs29m8bl+ydfFXAnbt5w9
         4lMIjWihJ1DJA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Geoffrey D. Bennett" <g@b4.vu>,
        Philippe Perrot <philippe@perrot-net.fr>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/36] ALSA: scarlett2: Move USB IDs out from device_info struct
Date:   Tue,  7 Nov 2023 10:45:49 -0500
Message-ID: <20231107154654.3765336-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit d98cc489029dba4d99714c2e8ec4f5ba249f6851 ]

By moving the USB IDs from the device_info struct into
scarlett2_devices[], that will allow for devices with different
USB IDs to share the same device_info.

Tested-by: Philippe Perrot <philippe@perrot-net.fr>
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Link: https://lore.kernel.org/r/8263368e8d49e6fcebc709817bd82ab79b404468.1694705811.git.g@b4.vu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_scarlett_gen2.c | 63 ++++++++++++---------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index d260be8cb6bc0..606dc6b5cedf9 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -317,8 +317,6 @@ struct scarlett2_mux_entry {
 };
 
 struct scarlett2_device_info {
-	u32 usb_id; /* USB device identifier */
-
 	/* Gen 3 devices have an internal MSD mode switch that needs
 	 * to be disabled in order to access the full functionality of
 	 * the device.
@@ -440,8 +438,6 @@ struct scarlett2_data {
 /*** Model-specific data ***/
 
 static const struct scarlett2_device_info s6i6_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8203),
-
 	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
 	.level_input_count = 2,
 	.pad_input_count = 2,
@@ -486,8 +482,6 @@ static const struct scarlett2_device_info s6i6_gen2_info = {
 };
 
 static const struct scarlett2_device_info s18i8_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8204),
-
 	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
 	.level_input_count = 2,
 	.pad_input_count = 4,
@@ -535,8 +529,6 @@ static const struct scarlett2_device_info s18i8_gen2_info = {
 };
 
 static const struct scarlett2_device_info s18i20_gen2_info = {
-	.usb_id = USB_ID(0x1235, 0x8201),
-
 	.config_set = SCARLETT2_CONFIG_SET_GEN_2,
 	.line_out_hw_vol = 1,
 
@@ -589,8 +581,6 @@ static const struct scarlett2_device_info s18i20_gen2_info = {
 };
 
 static const struct scarlett2_device_info solo_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8211),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
 	.level_input_count = 1,
@@ -602,8 +592,6 @@ static const struct scarlett2_device_info solo_gen3_info = {
 };
 
 static const struct scarlett2_device_info s2i2_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8210),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_NO_MIXER,
 	.level_input_count = 2,
@@ -614,8 +602,6 @@ static const struct scarlett2_device_info s2i2_gen3_info = {
 };
 
 static const struct scarlett2_device_info s4i4_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8212),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.level_input_count = 2,
@@ -660,8 +646,6 @@ static const struct scarlett2_device_info s4i4_gen3_info = {
 };
 
 static const struct scarlett2_device_info s8i6_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8213),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.level_input_count = 2,
@@ -713,8 +697,6 @@ static const struct scarlett2_device_info s8i6_gen3_info = {
 };
 
 static const struct scarlett2_device_info s18i8_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8214),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.line_out_hw_vol = 1,
@@ -783,8 +765,6 @@ static const struct scarlett2_device_info s18i8_gen3_info = {
 };
 
 static const struct scarlett2_device_info s18i20_gen3_info = {
-	.usb_id = USB_ID(0x1235, 0x8215),
-
 	.has_msd_mode = 1,
 	.config_set = SCARLETT2_CONFIG_SET_GEN_3,
 	.line_out_hw_vol = 1,
@@ -848,8 +828,6 @@ static const struct scarlett2_device_info s18i20_gen3_info = {
 };
 
 static const struct scarlett2_device_info clarett_8pre_info = {
-	.usb_id = USB_ID(0x1235, 0x820c),
-
 	.config_set = SCARLETT2_CONFIG_SET_CLARETT,
 	.line_out_hw_vol = 1,
 	.level_input_count = 2,
@@ -902,25 +880,30 @@ static const struct scarlett2_device_info clarett_8pre_info = {
 	} },
 };
 
-static const struct scarlett2_device_info *scarlett2_devices[] = {
+struct scarlett2_device_entry {
+	const u32 usb_id; /* USB device identifier */
+	const struct scarlett2_device_info *info;
+};
+
+static const struct scarlett2_device_entry scarlett2_devices[] = {
 	/* Supported Gen 2 devices */
-	&s6i6_gen2_info,
-	&s18i8_gen2_info,
-	&s18i20_gen2_info,
+	{ USB_ID(0x1235, 0x8203), &s6i6_gen2_info },
+	{ USB_ID(0x1235, 0x8204), &s18i8_gen2_info },
+	{ USB_ID(0x1235, 0x8201), &s18i20_gen2_info },
 
 	/* Supported Gen 3 devices */
-	&solo_gen3_info,
-	&s2i2_gen3_info,
-	&s4i4_gen3_info,
-	&s8i6_gen3_info,
-	&s18i8_gen3_info,
-	&s18i20_gen3_info,
+	{ USB_ID(0x1235, 0x8211), &solo_gen3_info },
+	{ USB_ID(0x1235, 0x8210), &s2i2_gen3_info },
+	{ USB_ID(0x1235, 0x8212), &s4i4_gen3_info },
+	{ USB_ID(0x1235, 0x8213), &s8i6_gen3_info },
+	{ USB_ID(0x1235, 0x8214), &s18i8_gen3_info },
+	{ USB_ID(0x1235, 0x8215), &s18i20_gen3_info },
 
 	/* Supported Clarett+ devices */
-	&clarett_8pre_info,
+	{ USB_ID(0x1235, 0x820c), &clarett_8pre_info },
 
 	/* End of list */
-	NULL
+	{ 0, NULL },
 };
 
 /* get the starting port index number for a given port type/direction */
@@ -4072,17 +4055,17 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 
 static int snd_scarlett_gen2_controls_create(struct usb_mixer_interface *mixer)
 {
-	const struct scarlett2_device_info **info = scarlett2_devices;
+	const struct scarlett2_device_entry *entry = scarlett2_devices;
 	int err;
 
-	/* Find device in scarlett2_devices */
-	while (*info && (*info)->usb_id != mixer->chip->usb_id)
-		info++;
-	if (!*info)
+	/* Find entry in scarlett2_devices */
+	while (entry->usb_id && entry->usb_id != mixer->chip->usb_id)
+		entry++;
+	if (!entry->usb_id)
 		return -EINVAL;
 
 	/* Initialise private data */
-	err = scarlett2_init_private(mixer, *info);
+	err = scarlett2_init_private(mixer, entry->info);
 	if (err < 0)
 		return err;
 
-- 
2.42.0

