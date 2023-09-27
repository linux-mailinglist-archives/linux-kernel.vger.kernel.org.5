Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C137B032E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjI0LgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjI0LgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:36:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B598F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:36:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40646537450so1922415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695814563; x=1696419363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u/sPXh8DGIJEKl6VxSqJ4Tdbh2OLQqwRTjgDTG9r3k=;
        b=IakksXGDTmmVyZUnlDU0zX9J+WIkfgSabSJAGPApEtJLUc/3eFtax5BQ+4WGVuYkrH
         pDqOhgSPbLY0CZQOFcVPH7DZuzspPXgYS045V/ebWtfD4i8MUSs7vmU5+8H25go7o5WV
         BUUfwb/IOJbh6o3n0mQwEYXHalq1jXAwob0VJiCN0gLlnGNedfpHDZShup1xihFrFRls
         RU29Zq+ZHa8fdL7E5EvS/V7eBkN9z+N8g/eGoKnx9f8szCx5MRyBKO6Uzky54nZzOiGh
         PD+VRtUC63DLxCN2oOUkVSGz5K0wDgoT0+4n00ppED7lHGRp9Y9VoRbbnt9ziXOTkJdM
         x7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814563; x=1696419363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u/sPXh8DGIJEKl6VxSqJ4Tdbh2OLQqwRTjgDTG9r3k=;
        b=wqz7EbmeBVY+8jI/wFaDlmJ+UYCTNmT8k5qcYEtAONQzMftZMrjA3qTUw91pTyX+sj
         2JN9P2nUrQ+Po2A4NyHiSIFMpdhrHboNgfjZDxvMD3IRrQsLr5NfolKDEYyGP7gtIzNt
         LMEeADJsVXPcuqucwI/61prOd0XPM8/112/MxwbsRQWk9S3w1MNlS5as9jJc/KhxDBxN
         MYB9U7R00Y1bUXjIk++HZrNBQI7Fwbvp3zAtutAFk4pGRqpzL4W9K0AMVUzcpUuTI2cH
         G7alNKQLFDLPCxTLmIKvcYtxDMILD0+wvPKCiWbsrzu84Br+5SlJjJL/Z9r58+q4tc7z
         S/3Q==
X-Gm-Message-State: AOJu0YxySzAREVO0cCZhZiI5sEMAAIrcKmpWAJw+8rJrKT+KJySOvajG
        +Qkn3hhmGtjfeUrsyenAa8I=
X-Google-Smtp-Source: AGHT+IEfvU1GXChFDRog9lEAtxgm1qp3JABNWWobi+ZBqf/8VcRnFCbocOWveeX4gKCfgF3bMJ43JQ==
X-Received: by 2002:a05:600c:4f48:b0:401:c07f:72bd with SMTP id m8-20020a05600c4f4800b00401c07f72bdmr1758417wmq.4.1695814563310;
        Wed, 27 Sep 2023 04:36:03 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b0030ae53550f5sm16792874wrv.51.2023.09.27.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:36:02 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: aloop: Add control element for getting the access mode
Date:   Wed, 27 Sep 2023 12:35:55 +0100
Message-Id: <20230927113555.14877-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
References: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new control element 'PCM Slave Access Mode' which shows the access
mode (interleaved/non-interleaved) for the PCM playing device. Add
corresponding control change notification calls.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/aloop.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index ab116b1fed96..e87dc67f33c6 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -119,11 +119,13 @@ struct loopback_setup {
 	unsigned int rate_shift;
 	snd_pcm_format_t format;
 	unsigned int rate;
+	snd_pcm_access_t access;
 	unsigned int channels;
 	struct snd_ctl_elem_id active_id;
 	struct snd_ctl_elem_id format_id;
 	struct snd_ctl_elem_id rate_id;
 	struct snd_ctl_elem_id channels_id;
+	struct snd_ctl_elem_id access_id;
 };
 
 struct loopback {
@@ -367,6 +369,11 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 							&setup->channels_id);
 			setup->channels = runtime->channels;
 		}
+		if (setup->access != runtime->access) {
+			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
+							&setup->access_id);
+			setup->access = runtime->access;
+		}
 	}
 	return 0;
 }
@@ -1520,6 +1527,30 @@ static int loopback_channels_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int loopback_access_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	const char * const texts[] = {"Interleaved", "Non-interleaved"};
+
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
+}
+
+static int loopback_access_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
+	snd_pcm_access_t access;
+
+	mutex_lock(&loopback->cable_lock);
+	access = loopback->setup[kcontrol->id.subdevice][kcontrol->id.device].access;
+
+	ucontrol->value.enumerated.item[0] = access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
+					     access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED;
+
+	mutex_unlock(&loopback->cable_lock);
+	return 0;
+}
+
 static const struct snd_kcontrol_new loopback_controls[]  = {
 {
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1566,7 +1597,15 @@ static const struct snd_kcontrol_new loopback_controls[]  = {
 	.name =         "PCM Slave Channels",
 	.info =         loopback_channels_info,
 	.get =          loopback_channels_get
-}
+},
+#define ACCESS_IDX 6
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"PCM Slave Access Mode",
+	.info =		loopback_access_info,
+	.get =		loopback_access_get,
+},
 };
 
 static int loopback_mixer_new(struct loopback *loopback, int notify)
@@ -1587,6 +1626,7 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
 			setup->notify = notify;
 			setup->rate_shift = NO_PITCH;
 			setup->format = SNDRV_PCM_FORMAT_S16_LE;
+			setup->access = SNDRV_PCM_ACCESS_RW_INTERLEAVED;
 			setup->rate = 48000;
 			setup->channels = 2;
 			for (idx = 0; idx < ARRAY_SIZE(loopback_controls);
@@ -1618,6 +1658,9 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
 				case CHANNELS_IDX:
 					setup->channels_id = kctl->id;
 					break;
+				case ACCESS_IDX:
+					setup->access_id = kctl->id;
+					break;
 				default:
 					break;
 				}
-- 
2.34.1

