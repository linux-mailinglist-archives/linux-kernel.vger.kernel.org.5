Return-Path: <linux-kernel+bounces-101974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BC87AD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B541F25CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1C145676;
	Wed, 13 Mar 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZPR2Cyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497C145654;
	Wed, 13 Mar 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348183; cv=none; b=u0iOWOoc4mPydkSSx9sUyPfxB/VhFpGrO28VDeCCUuZZPvMb9FiKE/klRiCbEspu+Dg7cmg7ZUtstVjrbjL9wRiGlC9BkhpxHfwR6Ug67SC4/1Q66nB4B91lEmrZ1vFk/GrvwGiqC51w8obzD91oiXlOM7unvLpv9ksMyBYt+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348183; c=relaxed/simple;
	bh=VZ5yNX8+WYqIibWi5E1WJBgVxjEbmgdMKVjOC7DiaS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS31BJkK0Px9TktXJiMr6//Va1MWBZg5Kzfn0qa9mlRE6n+L9ifaEqqCkXLkVSVjX8T/LBkWfXDETd2k5csILWq1Zq4VVMxPJOX5nrTwIvBdQcagWB971EihyS4wOJYPhCuwlVvhEdhWyChig8/lCyyVLFN2jCrQAChpFjo1I+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZPR2Cyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77416C43394;
	Wed, 13 Mar 2024 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348183;
	bh=VZ5yNX8+WYqIibWi5E1WJBgVxjEbmgdMKVjOC7DiaS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZPR2CywYdEbo5yYNV7lGR4K7I/L5jgiHUTc/DYz7KM3ENYcRCxDQEzOuz/UoIVxF
	 5l1Ywe1Byk1asq5I1uKqsf7knG83AJzCD/jBHDHGm/mk4a600GWeCSqroyNJh3ZDNP
	 NPM+FfNd+B2Ff6D6osPK+bqi7eUOLZ+ihh89PGwo4zZetSWKK0BSeBDn/WeIAibHaV
	 UQaerb9rfmliF1jQRLOCTY8406n7oQLYx8/a49X463odmeUPoxah8wLVt4V42/P+31
	 UMl340HOva9PrTMQkS3g0h9qOiWz/FGUG7lDpKi1rq8go/YIkqNXFQ0+YHvetS98Qt
	 rD1YbzZpYsYNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 34/76] ALSA: usb-audio: Avoid superfluous endpoint setup
Date: Wed, 13 Mar 2024 12:41:41 -0400
Message-ID: <20240313164223.615640-35-sashal@kernel.org>
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

[ Upstream commit 1045f5f1ff0751423aeb65648e5e1abd7a7a8672 ]

After splitting to snd_usb_endpoint_set_params() and *_prepare(), the
skip of each function should be checked with different flags, while we
still use ep->need_setup as the single one.  Introduce
ep->need_prepare for indicating the need of prepare, and also add the
missing check of ep->need_setup at the set_params.

Fixes: 2be79d586454 ("ALSA: usb-audio: Split endpoint setups for hw_params and prepare (take#2)")
Link: https://lore.kernel.org/r/20221009104212.18877-5-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/card.h     |  3 ++-
 sound/usb/endpoint.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index ca75f2206170f..40061550105ac 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -129,7 +129,8 @@ struct snd_usb_endpoint {
 					   in a stream */
 	bool implicit_fb_sync;		/* syncs with implicit feedback */
 	bool lowlatency_playback;	/* low-latency playback mode */
-	bool need_setup;		/* (re-)need for configure? */
+	bool need_setup;		/* (re-)need for hw_params? */
+	bool need_prepare;		/* (re-)need for prepare? */
 
 	/* for hw constraints */
 	const struct audioformat *cur_audiofmt;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 80ead3db4d1c7..cf48d7ccc496e 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -829,6 +829,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 
 		ep->implicit_fb_sync = fp->implicit_fb;
 		ep->need_setup = true;
+		ep->need_prepare = true;
 
 		usb_audio_dbg(chip, "  channels=%d, rate=%d, format=%s, period_bytes=%d, periods=%d, implicit_fb=%d\n",
 			      ep->cur_channels, ep->cur_rate,
@@ -954,7 +955,7 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 /* Prepare for suspening EP, called from the main suspend handler */
 void snd_usb_endpoint_suspend(struct snd_usb_endpoint *ep)
 {
-	ep->need_setup = true;
+	ep->need_prepare = true;
 	if (ep->iface_ref)
 		ep->iface_ref->need_setup = true;
 	if (ep->clock_ref)
@@ -1337,9 +1338,12 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 				struct snd_usb_endpoint *ep)
 {
 	const struct audioformat *fmt = ep->cur_audiofmt;
-	int err;
+	int err = 0;
 
 	mutex_lock(&chip->mutex);
+	if (!ep->need_setup)
+		goto unlock;
+
 	/* release old buffers, if any */
 	err = release_urbs(ep, false);
 	if (err < 0)
@@ -1388,8 +1392,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
 	err = update_clock_ref_rate(chip, ep);
-	if (err >= 0)
+	if (err >= 0) {
+		ep->need_setup = false;
 		err = 0;
+	}
+
  unlock:
 	mutex_unlock(&chip->mutex);
 	return err;
@@ -1439,7 +1446,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
 	mutex_lock(&chip->mutex);
 	if (WARN_ON(!ep->iface_ref))
 		goto unlock;
-	if (!ep->need_setup)
+	if (!ep->need_prepare)
 		goto unlock;
 
 	/* If the interface has been already set up, just set EP parameters */
@@ -1493,7 +1500,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
 	ep->iface_ref->need_setup = false;
 
  done:
-	ep->need_setup = false;
+	ep->need_prepare = false;
 	err = 1;
 
 unlock:
-- 
2.43.0


