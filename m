Return-Path: <linux-kernel+bounces-89221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F9886ECBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA16E284611
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611225EE84;
	Fri,  1 Mar 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="lF/wmaIO"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED85B1EA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334691; cv=none; b=sUuJijygN6bfw+dgDQx2ETwrdfgvakT3Wv7FE5x6jKuIC52XMPbJAqmJ1sa8CQtaS4o2HntDMO5OwOSbIjLXyJfnXUWyA5Q3CiOssaS5hDcIeQPMYTij2/bjtL491zbZBMJosmYP/7nzVwEatX8imUQaUx/KjnGCn11+fVp2Frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334691; c=relaxed/simple;
	bh=vrxr+C6YLcibNVe7Paa0+ZWlZqIca7ibpaNouEXhbhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBBVWj666fk9Kgz6Qqkty4cUAhCilYCzqxRobISqaUyuF7d3Agn+DytBT14Qor/vmjLI7wfJYNhpMJELshWnp7LqmXQpZ0uBFRdTE3u1Uye8mFRnevrbASsTydT8ufsdZSSDtYmjs0V0QtLHGINWI92iVBYDntLyuztwUwTL7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=lF/wmaIO; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1709334685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=whi/b8RMhmo6Ka3O+qfQOyMTE5jfqy1oQ6xDX28pvkw=;
	b=lF/wmaIO8EjZUPxQbWxSpILkaMKhX1X3zBAfz+c8BrvPMyK6Axhn+xosVzFPJ95IWE6+kr
	z0yVQv8p/hL4aJfiqJvm7DmcM6LftR40vb48uygWWpSGhjpQsVMDJPvsEm+hlT/JcuBcAN
	zrQjfesxtrnfZAz8MYhcMlZ/aTK3m3iJo5qanyWh/blt/S07RkkOtroAaS7/BQqvdFFDgv
	RUy2L8tUSEmM8/pXVHFp96ByHmrRnxH+cjuewkXKTTemAMxQeUfefwXyPzax+48uVlgc3w
	4+B75ZJq8EzauHgBayKOz357kA0bsPCOpB89WHP3K/U7OoBBcBwXAKKmLVaLYA==
From: Kenny Levinsen <kl@kl.wtf>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH] ALSA: usb-audio: Name feature ctl using output if input is PCM
Date: Sat,  2 Mar 2024 00:11:07 +0100
Message-ID: <20240301231107.42679-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When building feature controls from a unit without a name, we try to
derive a name first from the feature unit's input, then fall back to the
output terminal.

If a feature unit connects directly to a "USB Streaming" input terminal
rather than a mixer or other virtual type, the control receives the
somewhat meaningless name "PCM", even if the output had a descriptive
type such as "Headset" or "Speaker".

Here is an example of such AudioControl descriptor from a USB headset
which ends up named "PCM Playback" and is therefore not recognized as
headphones by userspace:

      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             4
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          5
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0402 Headset
        bAssocTerminal          4
        bSourceID               6
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                 6
        bSourceID               4
        bControlSize            2
        bmaControls(0)     0x0002
          Volume Control
        bmaControls(1)     0x0000
        bmaControls(2)     0x0000
        iFeature                0

Other headsets and DACs I tried that used their output terminal for
naming only did so due to their input being an unnamed sidetone mixer.

Instead of always starting with the input terminal, check the type of it
first. If it seems uninteresting, invert the order and use the output
terminal first for naming.

This makes userspace recognize headsets with simple controls as
headphones, and leads to more consistent naming of playback devices
based on their outputs irrespective of sidetone mixers.

Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 sound/usb/mixer.c | 49 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 409fc1164694..81256ab56835 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1652,6 +1652,34 @@ static const struct usb_feature_control_info *get_feature_control_info(int contr
 	return NULL;
 }
 
+static int feature_unit_mutevol_ctl_name(struct usb_mixer_interface *mixer,
+					 struct snd_kcontrol *kctl,
+					 struct usb_audio_term *iterm,
+					 struct usb_audio_term *oterm)
+{
+	struct usb_audio_term *aterm, *bterm;
+	bool output_first;
+	int len = 0;
+
+	/*
+	 * If the input terminal is USB Streaming, we try getting the name of
+	 * the output terminal first in hopes of getting something more
+	 * descriptive than "PCM".
+	 */
+	output_first = iterm && !(iterm->type >> 16) && (iterm->type & 0xff00) == 0x0100;
+
+	aterm = output_first ? oterm : iterm;
+	bterm = output_first ? iterm : oterm;
+
+	if (aterm)
+		len = get_term_name(mixer->chip, aterm, kctl->id.name,
+				    sizeof(kctl->id.name), 1);
+	if (!len && bterm)
+		len = get_term_name(mixer->chip, bterm, kctl->id.name,
+				    sizeof(kctl->id.name), 1);
+	return len;
+}
+
 static void __build_feature_ctl(struct usb_mixer_interface *mixer,
 				const struct usbmix_name_map *imap,
 				unsigned int ctl_mask, int control,
@@ -1733,22 +1761,15 @@ static void __build_feature_ctl(struct usb_mixer_interface *mixer,
 	case UAC_FU_MUTE:
 	case UAC_FU_VOLUME:
 		/*
-		 * determine the control name.  the rule is:
-		 * - if a name id is given in descriptor, use it.
-		 * - if the connected input can be determined, then use the name
-		 *   of terminal type.
-		 * - if the connected output can be determined, use it.
-		 * - otherwise, anonymous name.
+		 * Determine the control name:
+		 * - If a name id is given in descriptor, use it.
+		 * - If input and output terminals are present, try to derive
+		 *   the name from either of these.
+		 * - Otherwise, make up a name using the feature unit ID.
 		 */
 		if (!len) {
-			if (iterm)
-				len = get_term_name(mixer->chip, iterm,
-						    kctl->id.name,
-						    sizeof(kctl->id.name), 1);
-			if (!len && oterm)
-				len = get_term_name(mixer->chip, oterm,
-						    kctl->id.name,
-						    sizeof(kctl->id.name), 1);
+			len = feature_unit_mutevol_ctl_name(mixer, kctl, iterm,
+							    oterm);
 			if (!len)
 				snprintf(kctl->id.name, sizeof(kctl->id.name),
 					 "Feature %d", unitid);
-- 
2.44.0


