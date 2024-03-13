Return-Path: <linux-kernel+bounces-101970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE487AD36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D911F24278
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED031448CC;
	Wed, 13 Mar 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+fpdhlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE721448DE;
	Wed, 13 Mar 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348179; cv=none; b=dr4UuazSjPAruBjDUpx6WptH/djx+9uBec188o+6tvym16XBxchpXCSrcbCQutDVRvdKIinZiDAicu6h6c4LqdXt3lZG3zN7MwTGU5GrCJb47yBjBFV8qKukSMoE3DMRwC6roRjG/Tbfyblan7/bWfos3HuYzBBgQOwYkKz9/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348179; c=relaxed/simple;
	bh=fb+uyGrzfDSNzqv09/El8PbxSWNbJhSbA+9LnH4t+bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4Ml/p4NYeJCFxQwOMThS/CcrltBcB8dVQ9/aia00XM2i+JPsA0IJFXWUdxJF3Kd6yX+0NNoUuYiDyX9uBUAhZhIapcIGrIW7wMFRciot6X4Zpazqc8beX1lZFg5Kd5NLPAx3lFPhZRBc3AyC6QUHcaO3VGlII+u4gBrZ9cBzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+fpdhlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813D5C43390;
	Wed, 13 Mar 2024 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348179;
	bh=fb+uyGrzfDSNzqv09/El8PbxSWNbJhSbA+9LnH4t+bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+fpdhlJeldHIt1n2i1OmN+YtNapiHrizrkYpxuyoasJL1tbemIinUBs6Rpya0hI2
	 waw9H0v35rGUKPK1aucgVLrZMPIIn3tqYCugAzp5im4kA1OIofT/xXwcLAhCHQzZAE
	 Sm+b89uttoGTNzEKqkkNFckTSYJDGma1zKK6wUu7BhWYdwEeIAgFdC8tpP48GA0eaD
	 wsZRaTUA3H0YSpJeotzz+h6NEr1KiR4Xx3aZS80D28RKdH/Ttx2OT0tN2ku5wfeSrO
	 PLmP/RKKJ4ps7k5uyfthyId0G9LEy9/xNYb0ywEwx0FaNQaRUXdy9EPV7jG+WSXDiq
	 iSvmvBi0BgH4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	chihhao chen <chihhao.chen@mediatek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 30/76] ALSA: usb-audio: Split endpoint setups for hw_params and prepare (take#2)
Date: Wed, 13 Mar 2024 12:41:37 -0400
Message-ID: <20240313164223.615640-31-sashal@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 2be79d58645465351af5320eb14c70a94724c5ef ]

This is a second attempt to fix the bug appearing on Android with the
recent kernel; the first try was ff878b408a03 and reverted at commit
79764ec772bc.

The details taken from the v1 patch:

One of the former changes for the endpoint management was the more
consistent setup of endpoints at hw_params.
snd_usb_endpoint_configure() is a single function that does the full
setup, and it's called from both PCM hw_params and prepare callbacks.
Although the EP setup at the prepare phase is usually skipped (by
checking need_setup flag), it may be still effective in some cases
like suspend/resume that requires the interface setup again.

As it's a full and single setup, the invocation of
snd_usb_endpoint_configure() includes not only the USB interface setup
but also the buffer release and allocation.  OTOH, doing the buffer
release and re-allocation at PCM prepare phase is rather superfluous,
and better to be done only in the hw_params phase.

For those optimizations, this patch splits the endpoint setup to two
phases: snd_usb_endpoint_set_params() and snd_usb_endpoint_prepare(),
to be called from hw_params and from prepare, respectively.

Note that this patch changes the driver operation slightly,
effectively moving the USB interface setup again to PCM prepare stage
instead of hw_params stage, while the buffer allocation and such
initializations are still done at hw_params stage.

And, the change of the USB interface setup timing (moving to prepare)
gave an interesting "fix", too: it was reported that the recent
kernels caused silent output at the beginning on playbacks on some
devices on Android, and this change casually fixed the regression.
It seems that those devices are picky about the sample rate change (or
the interface change?), and don't follow the too immediate rate
changes.

Meanwhile, Android operates the PCM in the following order:
- open, then hw_params with the possibly highest sample rate
- close without prepare
- re-open, hw_params with the normal sample rate
- prepare, and start streaming
This procedure ended up the hw_params twice with different rates, and
because the recent kernel did set up the sample rate twice one and
after, it screwed up the device.  OTOH, the earlier kernels didn't set
up the USB interface at hw_params, hence this problem didn't appear.

Now, with this patch, the USB interface setup is again back to the
prepare phase, and it works around the problem automagically.
Although we should address the sample rate problem in a more solid
way in future, let's keep things working as before for now.

***

What's new in the take#2 patch:
- The regression caused by the v1 patch (bko#216500) was due to the
  missing check of need_setup flag at hw_params.  Now the check is
  added, and the snd_usb_endpoint_set_params() call is skipped when
  the running EP is re-opened.

- There was another bug in v1 where the clock reference rate wasn't
  updated at hw_params phase, which may lead to a lack of the proper
  hw constraints when an application doesn't issue the prepare but
  only the hw_params call.  This patch fixes it as well by tracking
  the clock rate change in the prepare callback with a new flag
  "need_update" for the clock reference object, just like others.

- The configure_endpoints() are simplified and folded back into
  snd_usb_pcm_prepare().

Fixes: bf6313a0ff76 ("ALSA: usb-audio: Refactor endpoint management")
Fixes: ff878b408a03 ("ALSA: usb-audio: Split endpoint setups for hw_params and prepare")
Reported-by: chihhao chen <chihhao.chen@mediatek.com>
Link: https://lore.kernel.org/r/87e6d6ae69d68dc588ac9acc8c0f24d6188375c3.camel@mediatek.com
Link: https://lore.kernel.org/r/20220901124136.4984-1-tiwai@suse.de
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216500
Link: https://lore.kernel.org/r/20220920181106.4894-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 76 +++++++++++++++++++++++++++-----------------
 sound/usb/endpoint.h |  6 ++--
 sound/usb/pcm.c      | 51 ++++++++++++-----------------
 3 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 13c0264881499..32a9e016665c8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -40,6 +40,7 @@ struct snd_usb_clock_ref {
 	unsigned char clock;
 	atomic_t locked;
 	int rate;
+	bool need_setup;
 	struct list_head list;
 };
 
@@ -765,7 +766,8 @@ bool snd_usb_endpoint_compatible(struct snd_usb_audio *chip,
  * The endpoint needs to be closed via snd_usb_endpoint_close() later.
  *
  * Note that this function doesn't configure the endpoint.  The substream
- * needs to set it up later via snd_usb_endpoint_configure().
+ * needs to set it up later via snd_usb_endpoint_set_params() and
+ * snd_usb_endpoint_prepare().
  */
 struct snd_usb_endpoint *
 snd_usb_endpoint_open(struct snd_usb_audio *chip,
@@ -1296,15 +1298,39 @@ static int sync_ep_set_params(struct snd_usb_endpoint *ep)
 	return -ENOMEM;
 }
 
+/* update the rate of the referred clock; return the actual rate */
+static int update_clock_ref_rate(struct snd_usb_audio *chip,
+				 struct snd_usb_endpoint *ep)
+{
+	struct snd_usb_clock_ref *clock = ep->clock_ref;
+	int rate = ep->cur_rate;
+
+	if (!clock || clock->rate == rate)
+		return rate;
+	if (clock->rate) {
+		if (atomic_read(&clock->locked))
+			return clock->rate;
+		if (clock->rate != rate) {
+			usb_audio_err(chip, "Mismatched sample rate %d vs %d for EP 0x%x\n",
+				      clock->rate, rate, ep->ep_num);
+			return clock->rate;
+		}
+	}
+	clock->rate = rate;
+	clock->need_setup = true;
+	return rate;
+}
+
 /*
  * snd_usb_endpoint_set_params: configure an snd_usb_endpoint
  *
+ * It's called either from hw_params callback.
  * Determine the number of URBs to be used on this endpoint.
  * An endpoint must be configured before it can be started.
  * An endpoint that is already running can not be reconfigured.
  */
-static int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
-				       struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
+				struct snd_usb_endpoint *ep)
 {
 	const struct audioformat *fmt = ep->cur_audiofmt;
 	int err;
@@ -1356,49 +1382,46 @@ static int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->maxframesize = ep->maxpacksize / ep->cur_frame_bytes;
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
-	return 0;
+	return update_clock_ref_rate(chip, ep);
 }
 
 static int init_sample_rate(struct snd_usb_audio *chip,
 			    struct snd_usb_endpoint *ep)
 {
 	struct snd_usb_clock_ref *clock = ep->clock_ref;
-	int err;
+	int rate, err;
 
-	if (clock) {
-		if (atomic_read(&clock->locked))
-			return 0;
-		if (clock->rate == ep->cur_rate)
-			return 0;
-		if (clock->rate && clock->rate != ep->cur_rate) {
-			usb_audio_dbg(chip, "Mismatched sample rate %d vs %d for EP 0x%x\n",
-				      clock->rate, ep->cur_rate, ep->ep_num);
-			return -EINVAL;
-		}
-	}
+	rate = update_clock_ref_rate(chip, ep);
+	if (rate < 0)
+		return rate;
+	if (clock && !clock->need_setup)
+		return 0;
 
-	err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, ep->cur_rate);
-	if (err < 0)
+	err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, rate);
+	if (err < 0) {
+		if (clock)
+			clock->rate = 0; /* reset rate */
 		return err;
+	}
 
 	if (clock)
-		clock->rate = ep->cur_rate;
+		clock->need_setup = false;
 	return 0;
 }
 
 /*
- * snd_usb_endpoint_configure: Configure the endpoint
+ * snd_usb_endpoint_prepare: Prepare the endpoint
  *
  * This function sets up the EP to be fully usable state.
- * It's called either from hw_params or prepare callback.
+ * It's called either from prepare callback.
  * The function checks need_setup flag, and performs nothing unless needed,
  * so it's safe to call this multiple times.
  *
  * This returns zero if unchanged, 1 if the configuration has changed,
  * or a negative error code.
  */
-int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
-			       struct snd_usb_endpoint *ep)
+int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
+			     struct snd_usb_endpoint *ep)
 {
 	bool iface_first;
 	int err = 0;
@@ -1419,9 +1442,6 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 			if (err < 0)
 				goto unlock;
 		}
-		err = snd_usb_endpoint_set_params(chip, ep);
-		if (err < 0)
-			goto unlock;
 		goto done;
 	}
 
@@ -1449,10 +1469,6 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 	if (err < 0)
 		goto unlock;
 
-	err = snd_usb_endpoint_set_params(chip, ep);
-	if (err < 0)
-		goto unlock;
-
 	err = snd_usb_select_mode_quirk(chip, ep->cur_audiofmt);
 	if (err < 0)
 		goto unlock;
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index daa7ba063d858..b972f7899d57e 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -17,8 +17,10 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		      bool is_sync_ep);
 void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 			    struct snd_usb_endpoint *ep);
-int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
-			       struct snd_usb_endpoint *ep);
+int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
+				struct snd_usb_endpoint *ep);
+int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
+			     struct snd_usb_endpoint *ep);
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock);
 
 bool snd_usb_endpoint_compatible(struct snd_usb_audio *chip,
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index de0964dbf7a91..7f09191c83d0e 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -433,35 +433,6 @@ static void close_endpoints(struct snd_usb_audio *chip,
 	}
 }
 
-static int configure_endpoints(struct snd_usb_audio *chip,
-			       struct snd_usb_substream *subs)
-{
-	int err;
-
-	if (subs->data_endpoint->need_setup) {
-		/* stop any running stream beforehand */
-		if (stop_endpoints(subs, false))
-			sync_pending_stops(subs);
-		if (subs->sync_endpoint) {
-			err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
-			if (err < 0)
-				return err;
-		}
-		err = snd_usb_endpoint_configure(chip, subs->data_endpoint);
-		if (err < 0)
-			return err;
-		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
-	} else {
-		if (subs->sync_endpoint) {
-			err = snd_usb_endpoint_configure(chip, subs->sync_endpoint);
-			if (err < 0)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * hw_params callback
  *
@@ -553,7 +524,16 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	subs->cur_audiofmt = fmt;
 	mutex_unlock(&chip->mutex);
 
-	ret = configure_endpoints(chip, subs);
+	if (!subs->data_endpoint->need_setup)
+		goto unlock;
+
+	if (subs->sync_endpoint) {
+		ret = snd_usb_endpoint_set_params(chip, subs->sync_endpoint);
+		if (ret < 0)
+			goto unlock;
+	}
+
+	ret = snd_usb_endpoint_set_params(chip, subs->data_endpoint);
 
  unlock:
 	if (ret < 0)
@@ -636,9 +616,18 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
-	ret = configure_endpoints(chip, subs);
+	if (subs->sync_endpoint) {
+		ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
+		if (ret < 0)
+			goto unlock;
+	}
+
+	ret = snd_usb_endpoint_prepare(chip, subs->data_endpoint);
 	if (ret < 0)
 		goto unlock;
+	else if (ret > 0)
+		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
+	ret = 0;
 
 	/* reset the pointer */
 	subs->buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
-- 
2.43.0


