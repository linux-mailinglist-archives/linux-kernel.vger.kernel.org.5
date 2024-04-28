Return-Path: <linux-kernel+bounces-161204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29538B48F9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237701F21B0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 00:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1F5EC3;
	Sun, 28 Apr 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKQJU6WI"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC64A5F;
	Sun, 28 Apr 2024 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714265880; cv=none; b=Y0IcKCE/rrg6eRLJTIs2UViPfu/VTOf4EKipfAY0gJPoXKEHl2ccJJ2BQJBZZAcMGishLXreCFf+Ri0NwrYDNCzkg1XE7ZlO7rUK48Q6JBAYcPUfYxY2yLBSNtP/2lwLwYoYFE95D0Ug9SUlApLhrlsHPK1BRHgzOFaE7syGMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714265880; c=relaxed/simple;
	bh=aeZV4VkHFBd56GPAQ6Hk0pRkNPw80Fcm4EJgz9bw0pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGAmiotMidnBUWS2OGALhtzYwGat4YMu2BVZEEOh6MhkPaFV9Mokgf5gpb0hD6plFRHQLltJKkiRY7dhUIsMJRyB7B1LGAE2sXsupqZHLgtj+SwzP05BStNifR0Vib/XO/f7wkIfk7UXWt+x4lYxmo5+Yqmh1VEKT9jO5naEFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKQJU6WI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso3218353b3a.1;
        Sat, 27 Apr 2024 17:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714265878; x=1714870678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8O+z1hsIAadgTFETxDS1vCHvfH0Dq8uKuo3sDo2uaLg=;
        b=KKQJU6WIKIjpAbisXlwMmzITE+VrtzHDSvo3B503UHAGE7PNX6N0c/9zfAZyd6ZOJG
         NEgDbBcJdGFX5tDp9b12uqHxJVtDhzAgwi2jtt2j0mrIN6rsjeEdEemcopPqU7FvGbq8
         fzJXK3U5/bUasnpOvPn8yEhG4H+aE2/gmBwn3ehW+C/EYbrbsBEp/WbD96aAJ93aKPZo
         LDXlk+ZaYzRtsZ32RObhbdjCWBomaBQqc6ji+BQwSThaOSuJaQOl8Tbr/uHFDs8FZ8Mu
         FGatAvErqHtsnTbGOJ5otW/5g5T1fXZeF0CIz2UdZG932Qffhu2l0VV1g92EIIO90CX9
         iZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714265878; x=1714870678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8O+z1hsIAadgTFETxDS1vCHvfH0Dq8uKuo3sDo2uaLg=;
        b=wcjQjB2mGNybL9o8DQ66Pi7ZRHCINKQ6VugfjwTp6nznLFb18rJlgVzZKUICRF+qcA
         2Ts/XeesRD62D0cYcCnoohbqOT5adHLdbCw6Io4mYDfUsTstrh6I3nxjoQK8XUpDHqOb
         pL+Z1eSAqfa6I16rjBmomNgr09odjRsUvcHnFs6Oghb/k6QvqJk7yBqeqP+0WIa/W2fd
         ncWKyKuoUMiWejYJzLpXSGRBOXSdrAFzic74FMblVRlLA/cxxxJj68K14LYKK+/EQaop
         c99SiIxiMti9Q0H1e6mZ7e3QY4YLuyqs6oi6ec0b1Xd+caiGJ359Ospp3+fuTLcJUcBh
         MRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvKsbCKK3U7eqFmVFcKrjeYLVIfm8izdn3qzicCj+e4N3EVFWVQBovKZ2anNbIjeFQron7snDGFPc4Qcmjp0SXqSkmbNTPI+KszK7lsxocT3jCG6DSmtRRR5aM4kRwDwm3KwOSkscKwVg=
X-Gm-Message-State: AOJu0Yy24aT51wEY28eIie4juQ+1wOYQvZeXUjDJRvdic7VCPm83YceP
	olQH5NieMDHo6G6VohC47nlb+MJC067+ldd4fNliPvrMf9D4qEzR
X-Google-Smtp-Source: AGHT+IHcYlDQ+Qw3kc756nQlZxyezBVWXDm1Y9z3jz9sDj5e5RdNu96Hkrz6pHf7nxTVbsgEAfqJ3Q==
X-Received: by 2002:a05:6a20:da9e:b0:1ac:4fca:23c2 with SMTP id iy30-20020a056a20da9e00b001ac4fca23c2mr8444563pzb.8.1714265877639;
        Sat, 27 Apr 2024 17:57:57 -0700 (PDT)
Received: from thought.. ([186.139.89.143])
        by smtp.gmail.com with ESMTPSA id g11-20020aa7818b000000b006ecfd0bf326sm15771013pfi.99.2024.04.27.17.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 17:57:57 -0700 (PDT)
From: ManuLinares <mbarriolinares@gmail.com>
To: alsa-devel@alsa-project.org
Cc: ManuLinares <mbarriolinares@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	dengxiang <dengxiang@nfschina.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Max McCarthy <mmccarthy@mcintoshlabs.com>,
	WhaleChang <whalechang@google.com>,
	Lukasz Tyl <ltyl@hem-e.com>,
	Jeremie Knuesel <knuesel@gmail.com>,
	Alexander Tsoy <alexander@tsoy.me>,
	Jussi Laako <jussi@sonarnerd.net>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add sampling rates support for Mbox3
Date: Sat, 27 Apr 2024 21:57:29 -0300
Message-ID: <20240428005733.202978-1-mbarriolinares@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for all sample rates supported by the hardware,
Digidesign Mbox 3 supports: {44100, 48000, 88200, 96000}

Fixes syncing clock issues that presented as pops. To test this, without
this patch playing 440hz tone produces pops.

Clock is now synced between playback and capture interfaces so no more
latency drift issue when using pipewire pro-profile.
(https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3900)

Signed-off-by: ManuLinares <mbarriolinares@gmail.com>
---
 sound/usb/quirks-table.h | 37 +++++++++++-------
 sound/usb/quirks.c       | 84 +++++++++++++++++++++++++++++++---------
 2 files changed, 88 insertions(+), 33 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 5d72dc8441cb..5228afbc00e3 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3013,21 +3013,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 4,
 					.iface = 2,
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = 0x00,
-					.endpoint = 0x01,
+					.endpoint = USB_RECIP_INTERFACE | USB_DIR_OUT,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC |
 						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_48000,
-					.rate_min = 48000,
-					.rate_max = 48000,
-					.nr_rates = 1,
+					.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+							SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
 					.rate_table = (unsigned int[]) {
-						48000
-					}
+						44100, 48000, 88200, 96000
+					},
+					.sync_ep = USB_RECIP_INTERFACE | USB_DIR_IN,
+					.sync_iface = 3,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 1,
+					.implicit_fb = 1,
 				}
 			},
 			{
@@ -3035,22 +3042,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 4,
 					.iface = 3,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.endpoint = 0x81,
 					.attributes = 0x00,
+					.endpoint = USB_RECIP_INTERFACE | USB_DIR_IN,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC |
 						USB_ENDPOINT_SYNC_ASYNC,
 					.maxpacksize = 0x009c,
-					.rates = SNDRV_PCM_RATE_48000,
-					.rate_min = 48000,
-					.rate_max = 48000,
-					.nr_rates = 1,
+					.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+							SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
 					.rate_table = (unsigned int[]) {
-						48000
-					}
+						44100, 48000, 88200, 96000
+					},
 				}
 			},
 			{
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 09712e61c606..279b80874f6a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -984,21 +984,13 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 	return 0;
 }
 
-static void mbox3_setup_48_24_magic(struct usb_device *dev)
+static void mbox3_setup_defaults(struct usb_device *dev)
 {
 	/* The Mbox 3 is "little endian" */
 	/* max volume is: 0x0000. */
 	/* min volume is: 0x0080 (shown in little endian form) */
 
-
-	/* Load 48000Hz rate into buffer */
-	u8 com_buff[4] = {0x80, 0xbb, 0x00, 0x00};
-
-	/* Set 48000Hz sample rate */
-	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			0x01, 0x21, 0x0100, 0x0001, &com_buff, 4);  //Is this really needed?
-	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			0x01, 0x21, 0x0100, 0x8101, &com_buff, 4);
+	u8 com_buff[2];
 
 	/* Deactivate Tuner */
 	/* on  = 0x01*/
@@ -1008,6 +1000,8 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 		0x01, 0x21, 0x0003, 0x2001, &com_buff, 1);
 
 	/* Set clock source to Internal (as opposed to S/PDIF) */
+	/* Internal  = 0x01*/
+	/* S/PDIF    = 0x02*/
 	com_buff[0] = 0x01;
 	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			1, 0x21, 0x0100, 0x8001, &com_buff, 1);
@@ -1113,9 +1107,11 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 			1, 0x21, 0x0107, 0x4201, &com_buff, 2);
 
 	/* Toggle allowing host control */
+	/* Not needed
 	com_buff[0] = 0x02;
 	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			3, 0x21, 0x0000, 0x2001, &com_buff, 1);
+	 */
 
 	/* Do not dim fx returns */
 	com_buff[0] = 0x00;
@@ -1259,26 +1255,27 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 	descriptor_size = le16_to_cpu(get_cfg_desc(config)->wTotalLength);
 
 	if (descriptor_size != MBOX3_DESCRIPTOR_SIZE) {
-		dev_err(&dev->dev, "Invalid descriptor size=%d.\n", descriptor_size);
+		dev_err(&dev->dev, "MBOX3: Invalid descriptor size=%d.\n", descriptor_size);
 		return -ENODEV;
 	}
 
-	dev_dbg(&dev->dev, "device initialised!\n");
+	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
 
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
 		&dev->descriptor, sizeof(dev->descriptor));
 	config = dev->actconfig;
-	if (err < 0)
-		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+	if (err < 0) 
+		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
 
 	err = usb_reset_configuration(dev);
-	if (err < 0)
-		dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
-	dev_dbg(&dev->dev, "mbox3_boot: new boot length = %d\n",
+	if (err < 0) 
+		dev_dbg(&dev->dev, "MBOX3: error usb_reset_configuration: %d\n", err);
+
+	dev_dbg(&dev->dev, "MBOX3: new boot length = %d\n",
 		le16_to_cpu(get_cfg_desc(config)->wTotalLength));
 
-	mbox3_setup_48_24_magic(dev);
-	dev_info(&dev->dev, "Digidesign Mbox 3: 24bit 48kHz");
+	mbox3_setup_defaults(dev);
+	dev_info(&dev->dev, "MBOX3: Initialized.");
 
 	return 0; /* Successful boot */
 }
@@ -1734,6 +1731,52 @@ static int pioneer_djm_set_format_quirk(struct snd_usb_substream *subs,
 	return 0;
 }
 
+static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
+									const struct audioformat *fmt)
+{
+	// Set rate only for one interface
+	//u8 iface = subs->data_endpoint->iface;
+	//if (iface != 2) return;
+
+	u8 buffer[4] = {0};
+	u32 new_rate = subs->data_endpoint->cur_rate;
+
+	// Get current rate from card and check if changing it is needed
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buffer, 4);
+	//u32 current_rate = le32_to_cpu(*(u32 *)buffer);
+	dev_dbg(&subs->dev->dev,
+			 "MBOX3: Current configured sample rate: %d", le32_to_cpu(*(u32 *)buffer));
+	if (le32_to_cpu(*(u32 *)buffer) == new_rate) {
+		dev_dbg(&subs->dev->dev,
+			"MBOX3: No change needed, current rate:%d == new rate:%d",
+			le32_to_cpu(*(u32 *)buffer), new_rate);
+		return;
+	}
+
+	// Set new rate
+	dev_info(&subs->dev->dev,
+			 "MBOX3: Changing sample rate to: %d", new_rate);
+	__le32 set_rate = cpu_to_le32(new_rate);
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21, 0x0100, 0x8101, &set_rate, 4);
+
+	// Set clock source to Internal
+	buffer[0] = 0x01;
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21, 0x0100, 0x8001, &buffer[0], 1);
+
+	// Check whether the change was successful
+	buffer[0] = 0; buffer[1] = 0; buffer[2] = 0; buffer[3] = 0;
+	snd_usb_ctl_msg(subs->dev,
+					usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buffer, 4);
+	//set_rate = *(int *)buffer;
+	set_rate = le32_to_cpu(*(u32 *)buffer);
+	if (new_rate != set_rate)
+		dev_warn(&subs->dev->dev, "MBOX3: Couldn't set the sample rate");
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1755,6 +1798,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x08e4, 0x0163): /* Pioneer DJM-850 */
 		pioneer_djm_set_format_quirk(subs, 0x0086);
 		break;
+	case USB_ID(0x0dba, 0x5000):
+		mbox3_set_format_quirk(subs, fmt); /* Digidesign Mbox 3 */
+		break;
 	}
 }
 
-- 
2.44.0


