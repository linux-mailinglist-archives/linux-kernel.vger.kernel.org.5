Return-Path: <linux-kernel+bounces-101976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD45487AD43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F410B22725
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE914566F;
	Wed, 13 Mar 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWK/7cGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A41634EE;
	Wed, 13 Mar 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348185; cv=none; b=jRZPZB5uzBU47ZsnOsZMkNxOXlr6m9QTQRn6oLsJxIcpMSUK+51uBkUuMyadUMRSSM1N307prPEf+LFf67Aax8K+hEglx88hhpMSG4PQ8TozzzfgpOWzY3nD4wKMtLRAGi+Zn0L5Fhuh1PhKIXPOQONRa5Gie1BaeZPPtYbLNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348185; c=relaxed/simple;
	bh=j3deBCIo610qH8lBsnvCzgBaJulvYL6MRE5DGkNll0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm8F9yRx86bWrb+oqbsVSM8mfWnfBvh1dfVGrfY4bABwWq2F9KR23mm5olF6WNrGm3/OIDU6BKk+T5Bhpp4YOguApwtRVAqN6RaJdroFyJ8ebxQ9YRJqx1EU4mkg6zhDNdLdtXS7+Ab+n8MhcNh9+tChaJHucfyrMmEm4Z44ctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWK/7cGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFBEC43399;
	Wed, 13 Mar 2024 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348185;
	bh=j3deBCIo610qH8lBsnvCzgBaJulvYL6MRE5DGkNll0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWK/7cGhpcfI8vExGLWp5/n2taKnxAIOUpasHSblAJlereVCQufwNmHxN2T1UDfVu
	 EvH2jozZ9cdUkqkNZkwr+J0k73iVLG/9OIx1dTxtwZ8qi4CwmELw+jYzzHfTi/haK7
	 S9QOTrg0WliBwnOux7jQWvCrJ615aXUuAj3mA560yquSvSf8xivqviAY5QqGTp8+Uj
	 081y07YAyt207KVsX+013uFk26779vFF5KNS9O+/uKjOiJjpruaPrJUGZuuEI5hlWa
	 Ps3WOEu2I5iXwa7RaRvEAZNI6EOJP/Z1Yil3GsA9Avf4pifvyGObM7MLOIBZpMCf4A
	 B1s3B49+6mirA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 36/76] ALSA: usb-audio: Add new quirk FIXED_RATE for JBL Quantum810 Wireless
Date: Wed, 13 Mar 2024 12:41:43 -0400
Message-ID: <20240313164223.615640-37-sashal@kernel.org>
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

From: Jaroslav Kysela <perex@perex.cz>

[ Upstream commit fd28941cff1cd9d8ffa59fe11eb64148e09b6ed6 ]

It seems that the firmware is broken and does not accept
the UAC_EP_CS_ATTR_SAMPLE_RATE URB. There is only one rate (48000Hz)
available in the descriptors for the output endpoint.

Create a new quirk QUIRK_FLAG_FIXED_RATE to skip the rate setup
when only one rate is available (fixed).

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216798
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20221215153037.1163786-1-perex@perex.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.h     |  1 +
 sound/usb/endpoint.c | 16 ++++++++++------
 sound/usb/endpoint.h |  3 ++-
 sound/usb/implicit.c |  6 +++++-
 sound/usb/implicit.h |  2 +-
 sound/usb/pcm.c      | 36 +++++++++++++++++++++++++++++++++---
 sound/usb/pcm.h      |  2 ++
 sound/usb/quirks.c   |  2 ++
 sound/usb/usbaudio.h |  4 ++++
 9 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 40061550105ac..6ec95b2edf863 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -131,6 +131,7 @@ struct snd_usb_endpoint {
 	bool lowlatency_playback;	/* low-latency playback mode */
 	bool need_setup;		/* (re-)need for hw_params? */
 	bool need_prepare;		/* (re-)need for prepare? */
+	bool fixed_rate;		/* skip rate setup */
 
 	/* for hw constraints */
 	const struct audioformat *cur_audiofmt;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index aca9ebfec22c8..26af199f3836e 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -774,7 +774,8 @@ struct snd_usb_endpoint *
 snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		      const struct audioformat *fp,
 		      const struct snd_pcm_hw_params *params,
-		      bool is_sync_ep)
+		      bool is_sync_ep,
+		      bool fixed_rate)
 {
 	struct snd_usb_endpoint *ep;
 	int ep_num = is_sync_ep ? fp->sync_ep : fp->endpoint;
@@ -830,6 +831,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		ep->implicit_fb_sync = fp->implicit_fb;
 		ep->need_setup = true;
 		ep->need_prepare = true;
+		ep->fixed_rate = fixed_rate;
 
 		usb_audio_dbg(chip, "  channels=%d, rate=%d, format=%s, period_bytes=%d, periods=%d, implicit_fb=%d\n",
 			      ep->cur_channels, ep->cur_rate,
@@ -1414,11 +1416,13 @@ static int init_sample_rate(struct snd_usb_audio *chip,
 	if (clock && !clock->need_setup)
 		return 0;
 
-	err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, rate);
-	if (err < 0) {
-		if (clock)
-			clock->rate = 0; /* reset rate */
-		return err;
+	if (!ep->fixed_rate) {
+		err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, rate);
+		if (err < 0) {
+			if (clock)
+				clock->rate = 0; /* reset rate */
+			return err;
+		}
 	}
 
 	if (clock)
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index b972f7899d57e..c09f68ce08b18 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -14,7 +14,8 @@ struct snd_usb_endpoint *
 snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		      const struct audioformat *fp,
 		      const struct snd_pcm_hw_params *params,
-		      bool is_sync_ep);
+		      bool is_sync_ep,
+		      bool fixed_rate);
 void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 			    struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index f3e8484b3d9cb..41ac7185b42b6 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -15,6 +15,7 @@
 #include "usbaudio.h"
 #include "card.h"
 #include "helper.h"
+#include "pcm.h"
 #include "implicit.h"
 
 enum {
@@ -455,7 +456,8 @@ const struct audioformat *
 snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 				     const struct audioformat *target,
 				     const struct snd_pcm_hw_params *params,
-				     int stream)
+				     int stream,
+				     bool *fixed_rate)
 {
 	struct snd_usb_substream *subs;
 	const struct audioformat *fp, *sync_fmt = NULL;
@@ -483,6 +485,8 @@ snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 		}
 	}
 
+	if (fixed_rate)
+		*fixed_rate = snd_usb_pcm_has_fixed_rate(subs);
 	return sync_fmt;
 }
 
diff --git a/sound/usb/implicit.h b/sound/usb/implicit.h
index ccb415a0ea860..7f1577b6c4d38 100644
--- a/sound/usb/implicit.h
+++ b/sound/usb/implicit.h
@@ -9,6 +9,6 @@ const struct audioformat *
 snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 				     const struct audioformat *target,
 				     const struct snd_pcm_hw_params *params,
-				     int stream);
+				     int stream, bool *fixed_rate);
 
 #endif /* __USBAUDIO_IMPLICIT_H */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 7f09191c83d0e..962a6e1bc70c8 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -157,6 +157,31 @@ find_substream_format(struct snd_usb_substream *subs,
 			   true, subs);
 }
 
+bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
+{
+	const struct audioformat *fp;
+	struct snd_usb_audio *chip = subs->stream->chip;
+	int rate = -1;
+
+	if (!(chip->quirk_flags & QUIRK_FLAG_FIXED_RATE))
+		return false;
+	list_for_each_entry(fp, &subs->fmt_list, list) {
+		if (fp->rates & SNDRV_PCM_RATE_CONTINUOUS)
+			return false;
+		if (fp->nr_rates < 1)
+			continue;
+		if (fp->nr_rates > 1)
+			return false;
+		if (rate < 0) {
+			rate = fp->rate_table[0];
+			continue;
+		}
+		if (rate != fp->rate_table[0])
+			return false;
+	}
+	return true;
+}
+
 static int init_pitch_v1(struct snd_usb_audio *chip, int ep)
 {
 	struct usb_device *dev = chip->dev;
@@ -450,12 +475,14 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	struct snd_usb_audio *chip = subs->stream->chip;
 	const struct audioformat *fmt;
 	const struct audioformat *sync_fmt;
+	bool fixed_rate, sync_fixed_rate;
 	int ret;
 
 	ret = snd_media_start_pipeline(subs);
 	if (ret)
 		return ret;
 
+	fixed_rate = snd_usb_pcm_has_fixed_rate(subs);
 	fmt = find_substream_format(subs, hw_params);
 	if (!fmt) {
 		usb_audio_dbg(chip,
@@ -469,7 +496,8 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (fmt->implicit_fb) {
 		sync_fmt = snd_usb_find_implicit_fb_sync_format(chip, fmt,
 								hw_params,
-								!substream->stream);
+								!substream->stream,
+								&sync_fixed_rate);
 		if (!sync_fmt) {
 			usb_audio_dbg(chip,
 				      "cannot find sync format: ep=0x%x, iface=%d:%d, format=%s, rate=%d, channels=%d\n",
@@ -482,6 +510,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		}
 	} else {
 		sync_fmt = fmt;
+		sync_fixed_rate = fixed_rate;
 	}
 
 	ret = snd_usb_lock_shutdown(chip);
@@ -501,7 +530,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 		close_endpoints(chip, subs);
 	}
 
-	subs->data_endpoint = snd_usb_endpoint_open(chip, fmt, hw_params, false);
+	subs->data_endpoint = snd_usb_endpoint_open(chip, fmt, hw_params, false, fixed_rate);
 	if (!subs->data_endpoint) {
 		ret = -EINVAL;
 		goto unlock;
@@ -510,7 +539,8 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (fmt->sync_ep) {
 		subs->sync_endpoint = snd_usb_endpoint_open(chip, sync_fmt,
 							    hw_params,
-							    fmt == sync_fmt);
+							    fmt == sync_fmt,
+							    sync_fixed_rate);
 		if (!subs->sync_endpoint) {
 			ret = -EINVAL;
 			goto unlock;
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 493a4e34d78dc..388fe2ba346d6 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -6,6 +6,8 @@ void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
 int snd_usb_pcm_suspend(struct snd_usb_stream *as);
 int snd_usb_pcm_resume(struct snd_usb_stream *as);
 
+bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *as);
+
 int snd_usb_init_pitch(struct snd_usb_audio *chip,
 		       const struct audioformat *fmt);
 void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b9c0affb79b10..a765da40eb27d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1896,6 +1896,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
 		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
+	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 2aba508a48312..f5a8dca66457f 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -175,6 +175,9 @@ extern bool snd_usb_skip_validation;
  * QUIRK_FLAG_FORCE_IFACE_RESET
  *  Force an interface reset whenever stopping & restarting a stream
  *  (e.g. after xrun)
+ * QUIRK_FLAG_FIXED_RATE
+ *  Do not set PCM rate (frequency) when only one rate is available
+ *  for the given endpoint.
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -198,5 +201,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_SKIP_IMPLICIT_FB	(1U << 18)
 #define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
 #define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
+#define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 
 #endif /* __USBAUDIO_H */
-- 
2.43.0


