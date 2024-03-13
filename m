Return-Path: <linux-kernel+bounces-101968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582387AD32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D893B1F273D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D241142907;
	Wed, 13 Mar 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTjRUTqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5A143C78;
	Wed, 13 Mar 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348177; cv=none; b=MpeGNIB7ZoMTEXAOBVmfMdxH6sdmmed39XKTUMy04sYLFeqcpFSa5YSu52p/nwbMkbQUrFMIwUReVgAPhq9+wtN8vWeZq7WMRS6KkH91gtl437VqWxxJ0vb5UtmvXHmhe7a8CbB2T2pHmYC8kH6zHouUnNdVK9L1dIcHYkX8frE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348177; c=relaxed/simple;
	bh=K6uUHDmgjsziI7JWX0ockfdu56Tnoh69HOTfEp2fHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lz1nnuQWboqr5MzObVPeTLExibL1e5y8BqURjBb1TZvT74Luqwis/ceRZZHB5axyZttv1PJK0dyKWxBHJzc6Z/c9R4I8s4cWQqJJ2CIPbQOXsEeSV1OgP9gkUI5/sBW6l1njFBoWmJl7hSDPlgSAer5HFHhFww8NJauheitMMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTjRUTqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEABC433C7;
	Wed, 13 Mar 2024 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348177;
	bh=K6uUHDmgjsziI7JWX0ockfdu56Tnoh69HOTfEp2fHaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTjRUTqjVTO9t9vg8+tbMnYTRPfcpfMhaRZtbfGOsFXLI0oI1mow3wY1V7t3rWGO5
	 bUh9WBDIrC9XjaJUNIYTEFKtyZkAkU60P20iugVsixrKPXX6bGwDucFp+RnyuKA7er
	 AXwB24qBNQ5XNqpdE17ccQqbBQpSjCyYfXrUNHQNH0/dfHoCc3ct1OW/w2Ktorw61E
	 CZDFBg1ivih0FmzmJmlIQWLBhV3nWCbgHzk81LcKKb2Ty++BnfTS3g+5IHEx4SyEW2
	 CUeOBs5rQoEr66siftDHSyk8MHeXBL6WD95YZRArwiuFBAcvICeZT3d0s9tjtN2bmd
	 8fAmlrCvyxCWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 28/76] ALSA: usb-audio: Refcount multiple accesses on the single clock
Date: Wed, 13 Mar 2024 12:41:35 -0400
Message-ID: <20240313164223.615640-29-sashal@kernel.org>
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

[ Upstream commit c11117b634f4f832c4420d3cf41c44227f140ce1 ]

When a clock source is connected to multiple nodes / endpoints, the
current USB-audio driver tries to set up at each time one of them is
configured.  Although it reads the current rate and updates only if it
differs, some devices seem unhappy with this behavior and spew the
errors when reading/updating the rate unnecessarily.

This patch tries to reduce the redundant clock setup by introducing a
refcount for each clock source.  When the stream is actually running,
a clock rate is "locked", and it bypasses the clock and/or refuse to
change any longer.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215934
Link: https://lore.kernel.org/r/20220516104807.16482-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.c     |  1 +
 sound/usb/card.h     |  3 +-
 sound/usb/endpoint.c | 90 +++++++++++++++++++++++++++++++++++++++-----
 sound/usb/usbaudio.h |  1 +
 4 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 550c6a72fb5bc..bebd42413fadb 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -643,6 +643,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->ep_list);
 	INIT_LIST_HEAD(&chip->iface_ref_list);
+	INIT_LIST_HEAD(&chip->clock_ref_list);
 	INIT_LIST_HEAD(&chip->midi_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 87f042d06ce08..ca75f2206170f 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -44,6 +44,7 @@ struct audioformat {
 
 struct snd_usb_substream;
 struct snd_usb_iface_ref;
+struct snd_usb_clock_ref;
 struct snd_usb_endpoint;
 struct snd_usb_power_domain;
 
@@ -62,6 +63,7 @@ struct snd_urb_ctx {
 struct snd_usb_endpoint {
 	struct snd_usb_audio *chip;
 	struct snd_usb_iface_ref *iface_ref;
+	struct snd_usb_clock_ref *clock_ref;
 
 	int opened;		/* open refcount; protect with chip->mutex */
 	atomic_t running;	/* running status */
@@ -138,7 +140,6 @@ struct snd_usb_endpoint {
 	unsigned int cur_period_frames;
 	unsigned int cur_period_bytes;
 	unsigned int cur_buffer_periods;
-	unsigned char cur_clock;
 
 	spinlock_t lock;
 	struct list_head list;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 6c7d842d04965..803053d4c9dbc 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -35,6 +35,14 @@ struct snd_usb_iface_ref {
 	struct list_head list;
 };
 
+/* clock refcounting */
+struct snd_usb_clock_ref {
+	unsigned char clock;
+	atomic_t locked;
+	int rate;
+	struct list_head list;
+};
+
 /*
  * snd_usb_endpoint is a model that abstracts everything related to an
  * USB endpoint and its streaming.
@@ -598,6 +606,25 @@ iface_ref_find(struct snd_usb_audio *chip, int iface)
 	return ip;
 }
 
+/* Similarly, a refcount object for clock */
+static struct snd_usb_clock_ref *
+clock_ref_find(struct snd_usb_audio *chip, int clock)
+{
+	struct snd_usb_clock_ref *ref;
+
+	list_for_each_entry(ref, &chip->clock_ref_list, list)
+		if (ref->clock == clock)
+			return ref;
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref)
+		return NULL;
+	ref->clock = clock;
+	atomic_set(&ref->locked, 0);
+	list_add_tail(&ref->list, &chip->clock_ref_list);
+	return ref;
+}
+
 /*
  * Get the existing endpoint object corresponding EP
  * Returns NULL if not present.
@@ -775,6 +802,14 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 			goto unlock;
 		}
 
+		if (fp->protocol != UAC_VERSION_1) {
+			ep->clock_ref = clock_ref_find(chip, fp->clock);
+			if (!ep->clock_ref) {
+				ep = NULL;
+				goto unlock;
+			}
+		}
+
 		ep->cur_audiofmt = fp;
 		ep->cur_channels = fp->channels;
 		ep->cur_rate = params_rate(params);
@@ -784,7 +819,6 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 		ep->cur_period_frames = params_period_size(params);
 		ep->cur_period_bytes = ep->cur_period_frames * ep->cur_frame_bytes;
 		ep->cur_buffer_periods = params_periods(params);
-		ep->cur_clock = fp->clock;
 
 		if (ep->type == SND_USB_ENDPOINT_TYPE_SYNC)
 			endpoint_set_syncinterval(chip, ep);
@@ -902,8 +936,8 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 		ep->altsetting = 0;
 		ep->cur_audiofmt = NULL;
 		ep->cur_rate = 0;
-		ep->cur_clock = 0;
 		ep->iface_ref = NULL;
+		ep->clock_ref = NULL;
 		usb_audio_dbg(chip, "EP 0x%x closed\n", ep->ep_num);
 	}
 	mutex_unlock(&chip->mutex);
@@ -915,6 +949,8 @@ void snd_usb_endpoint_suspend(struct snd_usb_endpoint *ep)
 	ep->need_setup = true;
 	if (ep->iface_ref)
 		ep->iface_ref->need_setup = true;
+	if (ep->clock_ref)
+		ep->clock_ref->rate = 0;
 }
 
 /*
@@ -1321,6 +1357,33 @@ static int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	return 0;
 }
 
+static int init_sample_rate(struct snd_usb_audio *chip,
+			    struct snd_usb_endpoint *ep)
+{
+	struct snd_usb_clock_ref *clock = ep->clock_ref;
+	int err;
+
+	if (clock) {
+		if (atomic_read(&clock->locked))
+			return 0;
+		if (clock->rate == ep->cur_rate)
+			return 0;
+		if (clock->rate && clock->rate != ep->cur_rate) {
+			usb_audio_dbg(chip, "Mismatched sample rate %d vs %d for EP 0x%x\n",
+				      clock->rate, ep->cur_rate, ep->ep_num);
+			return -EINVAL;
+		}
+	}
+
+	err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, ep->cur_rate);
+	if (err < 0)
+		return err;
+
+	if (clock)
+		clock->rate = ep->cur_rate;
+	return 0;
+}
+
 /*
  * snd_usb_endpoint_configure: Configure the endpoint
  *
@@ -1350,8 +1413,7 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 		 * to update at each EP configuration
 		 */
 		if (ep->cur_audiofmt->protocol == UAC_VERSION_1) {
-			err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt,
-						       ep->cur_rate);
+			err = init_sample_rate(chip, ep);
 			if (err < 0)
 				goto unlock;
 		}
@@ -1381,7 +1443,7 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 	if (err < 0)
 		goto unlock;
 
-	err = snd_usb_init_sample_rate(chip, ep->cur_audiofmt, ep->cur_rate);
+	err = init_sample_rate(chip, ep);
 	if (err < 0)
 		goto unlock;
 
@@ -1414,15 +1476,15 @@ int snd_usb_endpoint_configure(struct snd_usb_audio *chip,
 /* get the current rate set to the given clock by any endpoint */
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
 {
-	struct snd_usb_endpoint *ep;
+	struct snd_usb_clock_ref *ref;
 	int rate = 0;
 
 	if (!clock)
 		return 0;
 	mutex_lock(&chip->mutex);
-	list_for_each_entry(ep, &chip->ep_list, list) {
-		if (ep->cur_clock == clock && ep->cur_rate) {
-			rate = ep->cur_rate;
+	list_for_each_entry(ref, &chip->clock_ref_list, list) {
+		if (ref->clock == clock) {
+			rate = ref->rate;
 			break;
 		}
 	}
@@ -1463,6 +1525,9 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 	if (atomic_inc_return(&ep->running) != 1)
 		return 0;
 
+	if (ep->clock_ref)
+		atomic_inc(&ep->clock_ref->locked);
+
 	ep->active_mask = 0;
 	ep->unlink_mask = 0;
 	ep->phase = 0;
@@ -1572,6 +1637,9 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool keep_pending)
 		if (ep->sync_source)
 			WRITE_ONCE(ep->sync_source->sync_sink, NULL);
 		stop_urbs(ep, false, keep_pending);
+		if (ep->clock_ref)
+			if (!atomic_dec_return(&ep->clock_ref->locked))
+				ep->clock_ref->rate = 0;
 	}
 }
 
@@ -1598,12 +1666,16 @@ void snd_usb_endpoint_free_all(struct snd_usb_audio *chip)
 {
 	struct snd_usb_endpoint *ep, *en;
 	struct snd_usb_iface_ref *ip, *in;
+	struct snd_usb_clock_ref *cp, *cn;
 
 	list_for_each_entry_safe(ep, en, &chip->ep_list, list)
 		kfree(ep);
 
 	list_for_each_entry_safe(ip, in, &chip->iface_ref_list, list)
 		kfree(ip);
+
+	list_for_each_entry_safe(cp, cn, &chip->clock_ref_list, list)
+		kfree(ip);
 }
 
 /*
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index ec06f441e890f..e97141ef730ad 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -46,6 +46,7 @@ struct snd_usb_audio {
 	struct list_head pcm_list;	/* list of pcm streams */
 	struct list_head ep_list;	/* list of audio-related endpoints */
 	struct list_head iface_ref_list; /* list of interface refcounts */
+	struct list_head clock_ref_list; /* list of clock refcounts */
 	int pcm_devs;
 
 	struct list_head midi_list;	/* list of midi interfaces */
-- 
2.43.0


