Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA4077A7F5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjHMPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHMPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A31BD7;
        Sun, 13 Aug 2023 08:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC11A632A7;
        Sun, 13 Aug 2023 15:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E50C433C8;
        Sun, 13 Aug 2023 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941902;
        bh=xoWufMfn1e3dz1UYLsmn8MdPmXGbojAH7O7dCoGmzFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhMXCWpULNLzPEiQnS7B01BvdJsnF9zdpylRoT2kt+lKEFMmC26y7t50dNhHws4hF
         OB3Uewpih7y6f0hTVdIg0njX8ede+ZhDjz/aWWq/jqXANY3d1DSlinH3cKSk19bACA
         S59K5x34gxjG2QCmdnGvy0WH5KVzz1CfbVq0KYcFmFBynDA3dsqQ9BLawzkSLUUQN7
         X1DHLM7Hcs8LGz3yjTAJOhCInRXOpg9Gn0uE1kgBCHov4hahuScvKOA+B+/ZLLh7NJ
         gyrZs6tPKS313365XU+IVIFm8v9O/t1CXv/x6x9g8prMBLqGs3y4Lg7WDMNQbBFdbU
         i9JVJ0rTqVdAw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, jussi@sonarnerd.net,
        john@keeping.me.uk, ltyl@hem-e.com, aichao@kylinos.cn,
        connerknoxpublic@gmail.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 34/54] ALSA: usb-audio: Add quirk for Microsoft Modern Wireless Headset
Date:   Sun, 13 Aug 2023 11:49:13 -0400
Message-Id: <20230813154934.1067569-34-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 3da435063777f8d861ba5a165344e3f75f839357 ]

Microsoft Modern Wireless Headset (appearing on the host as "Microsoft
USB Link") has a playback and a capture mixer volume/switch, but they
are fairly broken.  The descriptor reports wrong dB ranges for
playback, and the capture volume/switch don't influence on the actual
recording at all.  Moreover, there seem instabilities in the
connection, and at best, we should disable the runtime PM.

So this ended up with a quirk entry for:
- Correct the playback dB range;
  I picked up some reasonable values but it's a guess work
- Disable the capture mixer;
  it's completely useless and confuses PA/PW
- Suppress get-sample-rate, apply the delay for message handling,
  and suppress the auto-suspend

The behavior of the wheel control on the headset is somehow flaky,
too, but it's an issue of HID.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1207129
Link: https://lore.kernel.org/r/20230725092057.15115-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_maps.c | 14 ++++++++++++++
 sound/usb/quirks.c     |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index f4bd1e8ae4b6c..23260aa1919d3 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -374,6 +374,15 @@ static const struct usbmix_name_map corsair_virtuoso_map[] = {
 	{ 0 }
 };
 
+/* Microsoft USB Link headset */
+/* a guess work: raw playback volume values are from 2 to 129 */
+static const struct usbmix_dB_map ms_usb_link_dB = { -3225, 0, true };
+static const struct usbmix_name_map ms_usb_link_map[] = {
+	{ 9, NULL, .dB = &ms_usb_link_dB },
+	{ 10, NULL }, /* Headset Capture volume; seems non-working, disabled */
+	{ 0 }   /* terminator */
+};
+
 /* ASUS ROG Zenith II with Realtek ALC1220-VB */
 static const struct usbmix_name_map asus_zenith_ii_map[] = {
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad - broken response, disabled */
@@ -668,6 +677,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x1395, 0x0025),
 		.map = sennheiser_pc8_map,
 	},
+	{
+		/* Microsoft USB Link headset */
+		.id = USB_ID(0x045e, 0x083c),
+		.map = ms_usb_link_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6cf55b7f7a041..d4a7ffef82194 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2011,6 +2011,9 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x041e, 0x4080, /* Creative Live Cam VF0610 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x045e, 0x083c, /* MS USB Link headset */
+		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_CTL_MSG_DELAY |
+		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x046d, 0x084c, /* Logitech ConferenceCam Connect */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x046d, 0x0991, /* Logitech QuickCam Pro */
-- 
2.40.1

