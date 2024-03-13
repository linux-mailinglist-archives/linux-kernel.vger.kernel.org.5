Return-Path: <linux-kernel+bounces-101971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8C87AD38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 875D3B21C19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD714532D;
	Wed, 13 Mar 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlV4aIGk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2771448F3;
	Wed, 13 Mar 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348180; cv=none; b=fxsoKvGB0WC4SCYo68Uu/3CrUc+yu5PCxWPsT6EnukKVjd2lzIQ6QQNHaHd7HVnCaNHFsHdgUE0BO7shwuDRjyJMN5KJD8UHOL2eeUr5gjCv/6yygRfzmXK72D8o7RW1PKztDc38ljddg0Q3aFVAqAGhF49Tjnh6YH3GueNO82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348180; c=relaxed/simple;
	bh=VYkQF9qbqyMDJR8JFKnAreUT2dI30RanQeT2HZkhdO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT6DXD7Q+wsLmeP9Uh8e1R81vCVqaZAxSedZd5sWlpxbog5LFPluyJdyA2Ps7zb1vGJfC3BXYG7YN6J/45lXCDfYQ/RVEeh9PEGmraFLrXjFxTaq3uBvrRQuYdtUrsu1yKqx5+Vsc3RAgpwfxoL+Vbv6bZ2lh6V3jlpwEBNvpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlV4aIGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE40C43394;
	Wed, 13 Mar 2024 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348180;
	bh=VYkQF9qbqyMDJR8JFKnAreUT2dI30RanQeT2HZkhdO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlV4aIGkUo2pMOveXaiJud9l057e1bwCHwXOzTRkZdTQOiohP6AAsqOPdUJwUpuST
	 IAzQM0ibvTg85rkFDxQpLjrYv5GxL0X5eYfRwpKRQ/pvrN3hj32Wa2ZqEibYMw3C11
	 UbNRimmRKKiDiu4fsj7S8Vm91wRa5e2C0jQvGLTaXi5X2dPHzAB7zm0RGio8Fwtgs6
	 wrjlURTcx4uhFynKbgvBC634lmvGLUmP+C+uozk1ETht7r6riPnB0K0x3IoWfLkfIV
	 lOrAZk4TDLVlX7gFoTS4uKBLznEJ0lSPeJumBqou/ISHbqpGxIds5/NrzuHxgDtuSV
	 SRPwKwoqH9uDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 31/76] ALSA: usb-audio: Properly refcounting clock rate
Date: Wed, 13 Mar 2024 12:41:38 -0400
Message-ID: <20240313164223.615640-32-sashal@kernel.org>
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

[ Upstream commit 9a737e7f8b371e97eb649904276407cee2c9cf30 ]

We fixed the bug introduced by the patch for managing the shared
clocks at the commit 809f44a0cc5a ("ALSA: usb-audio: Clear fixed clock
rate at closing EP"), but it was merely a workaround.  By this change,
the clock reference rate is cleared at each EP close, hence the still
remaining EP may need a re-setup of rate unnecessarily.

This patch introduces the proper refcounting for the clock reference
object so that the clock setup is done only when needed.

Fixes: 809f44a0cc5a ("ALSA: usb-audio: Clear fixed clock rate at closing EP")
Fixes: c11117b634f4 ("ALSA: usb-audio: Refcount multiple accesses on the single clock")
Link: https://lore.kernel.org/r/20220920181126.4912-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 32a9e016665c8..2d3f814d067b5 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -39,6 +39,7 @@ struct snd_usb_iface_ref {
 struct snd_usb_clock_ref {
 	unsigned char clock;
 	atomic_t locked;
+	int opened;
 	int rate;
 	bool need_setup;
 	struct list_head list;
@@ -810,6 +811,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 				ep = NULL;
 				goto unlock;
 			}
+			ep->clock_ref->opened++;
 		}
 
 		ep->cur_audiofmt = fp;
@@ -934,8 +936,10 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 		endpoint_set_interface(chip, ep, false);
 
 	if (!--ep->opened) {
-		if (ep->clock_ref && !atomic_read(&ep->clock_ref->locked))
-			ep->clock_ref->rate = 0;
+		if (ep->clock_ref) {
+			if (!--ep->clock_ref->opened)
+				ep->clock_ref->rate = 0;
+		}
 		ep->iface = 0;
 		ep->altsetting = 0;
 		ep->cur_audiofmt = NULL;
@@ -1656,8 +1660,7 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool keep_pending)
 			WRITE_ONCE(ep->sync_source->sync_sink, NULL);
 		stop_urbs(ep, false, keep_pending);
 		if (ep->clock_ref)
-			if (!atomic_dec_return(&ep->clock_ref->locked))
-				ep->clock_ref->rate = 0;
+			atomic_dec(&ep->clock_ref->locked);
 	}
 }
 
-- 
2.43.0


