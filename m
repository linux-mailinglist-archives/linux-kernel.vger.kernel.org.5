Return-Path: <linux-kernel+bounces-101975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1287AD41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BA7281B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17144145B18;
	Wed, 13 Mar 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmk7df2I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669714567B;
	Wed, 13 Mar 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348184; cv=none; b=CrtFK9Ycy6uunB9n1OlIF7JVz0PDsevxwdn5qRkDGBOLJsI44eGUUrhWN9X8td1HBRtwhIiwUfevfqawLyXCsZg5VdzqiYL4UOrQHEvWFkF7owTKtVpxYKb9c/mpjjCNnpfAVMSBo09LYdZchsW4Ca76Z3YxhpQsSpkBXoR1biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348184; c=relaxed/simple;
	bh=uCdl5rV13o5rx56uT1QCdFQKttQgRBXCDQxEL5xpVck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALWzXxMLn1W60STm6MV1Ov/1nHzHZXofarRPmlQY/bRHvJn492zqEDrSvP5pSz3ngKG9Qo4eJI1qnfPF2nwFdf4lcKmSWzIVmAlv5aGWr5W2JIBR84liuphWml54j1hC5+xitx6E0IyF1vLICF5S4okhqiONfZD7+yJj8Hhn6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmk7df2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C88C43390;
	Wed, 13 Mar 2024 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348184;
	bh=uCdl5rV13o5rx56uT1QCdFQKttQgRBXCDQxEL5xpVck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmk7df2I6nXxlfm31PUir39w2ZADCG8uFcXs8rRgkHRq3jPA+9LfR5s5Xrny3dtdg
	 QPwsX5HHCAH8cN/QCMTn9nq8kw4g8JfTbg0iHhrVpyPmodV3ZfKMPRNQr96Zf6KZDw
	 gb5KFoOGuLqbt9vF/FCt63FS+RH8nIl9bJ1rd+qZ60mKu6k6hpnSjqDzEN1kp59oDP
	 Mavq3cmhswGQjlKPB02gIuU5jrdLYR8LjWkT25Zbj62OOlUsOFR6PAsMUf6RIeY7zh
	 kP7LOOlWNgtbTN14XOkz18y5aN/4psDerm2nQVtnzsbsmg0+IIY+xCveIV9AqxfWDP
	 S4w5l3VURh4Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Keeping <john@metanate.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 35/76] ALSA: usb-audio: Add quirk for Tascam Model 12
Date: Wed, 13 Mar 2024 12:41:42 -0400
Message-ID: <20240313164223.615640-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Keeping <john@metanate.com>

[ Upstream commit 67df411db3f0209e4bb5227d4dd9d41b21368b9d ]

Tascam's Model 12 is a mixer which can also operate as a USB audio
interface.  The audio interface uses explicit feedback but it seems that
it does not correctly handle missing isochronous frames.

When injecting an xrun (or doing anything else that pauses the playback
stream) the feedback rate climbs (for example, at 44,100Hz nominal, I
see a stable rate around 44,099 but xrun injection sees this peak at
around 44,135 in most cases) and glitches are heard in the audio stream
for several seconds - this is significantly worse than the single glitch
expected for an underrun.

While the stream does normally recover and the feedback rate returns to
a stable value, I have seen some occurrences where this does not happen
and the rate continues to increase while no audio is heard from the
output.  I have not found a solid reproduction for this.

This misbehaviour can be avoided by totally resetting the stream state
by switching the interface to alt 0 and back before restarting the
playback stream.

Add a new quirk flag which forces the endpoint and interface to be
reconfigured whenever the stream is stopped, and use this for the Tascam
Model 12.

Separate interfaces are used for the playback and capture endpoints, so
resetting the playback interface here will not affect the capture stream
if it is running.  While there are two endpoints on the interface,
these are the OUT data endpoint and the IN explicit feedback endpoint
corresponding to it and these are always stopped and started together.

Signed-off-by: John Keeping <john@metanate.com>
Link: https://lore.kernel.org/r/20221129130100.1257904-1-john@metanate.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 7 +++++++
 sound/usb/quirks.c   | 2 ++
 sound/usb/usbaudio.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index cf48d7ccc496e..aca9ebfec22c8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1674,6 +1674,13 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool keep_pending)
 		stop_urbs(ep, false, keep_pending);
 		if (ep->clock_ref)
 			atomic_dec(&ep->clock_ref->locked);
+
+		if (ep->chip->quirk_flags & QUIRK_FLAG_FORCE_IFACE_RESET &&
+		    usb_pipeout(ep->pipe)) {
+			ep->need_prepare = true;
+			if (ep->iface_ref)
+				ep->iface_ref->need_setup = true;
+		}
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 03b6a07a2ea05..b9c0affb79b10 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1786,6 +1786,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0644, 0x804a, /* TEAC UD-301 */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_IFACE_DELAY),
+	DEVICE_FLG(0x0644, 0x805f, /* TEAC Model 12 */
+		   QUIRK_FLAG_FORCE_IFACE_RESET),
 	DEVICE_FLG(0x06f8, 0xb000, /* Hercules DJ Console (Windows Edition) */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x06f8, 0xd002, /* Hercules DJ Console (Macintosh Edition) */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index e97141ef730ad..2aba508a48312 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -172,6 +172,9 @@ extern bool snd_usb_skip_validation;
  *  Don't apply implicit feedback sync mode
  * QUIRK_FLAG_IFACE_SKIP_CLOSE
  *  Don't closed interface during setting sample rate
+ * QUIRK_FLAG_FORCE_IFACE_RESET
+ *  Force an interface reset whenever stopping & restarting a stream
+ *  (e.g. after xrun)
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -194,5 +197,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_GENERIC_IMPLICIT_FB	(1U << 17)
 #define QUIRK_FLAG_SKIP_IMPLICIT_FB	(1U << 18)
 #define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
+#define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
 
 #endif /* __USBAUDIO_H */
-- 
2.43.0


