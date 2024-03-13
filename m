Return-Path: <linux-kernel+bounces-101969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE887AD34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C001C21E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209EB1448D5;
	Wed, 13 Mar 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozhXXXKV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCD63411;
	Wed, 13 Mar 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348178; cv=none; b=AS85gysB+MeGRV2o4xlDi+BlDdaf8CYWUerVv/roiox/e2/92R1DjoVUlY0aqUqk2gKuOl3gt0TbA8Hsw8l0JCo6WyM1n09uTgR+9T1SoVHh/4jSSahCWiHwu6x7YAUnkNuRa8kroNNvA93R/WrAGzzGC1XH1Hk9T9AD/ZpPrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348178; c=relaxed/simple;
	bh=8IImuHKCDLLJHUSZxoAxes0ahPbeQ6kuN9+Djzi8mbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+mw8t3zld3INY9+2BoGl9iQ7iySk4vI70gi38zPCmzxk/AhQVUY+WQ49NhwyokJlXrPWdQ7i1ZHGsgU+EB2e5AYQTmi0fqT3fyPgmFoHAcyiS9yrVTguxF72kc3JC6z2JMWLVyUrqQ/vvvmK2/IgINVGeyDFJ1xyhrcqh0U2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozhXXXKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679CBC43394;
	Wed, 13 Mar 2024 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348178;
	bh=8IImuHKCDLLJHUSZxoAxes0ahPbeQ6kuN9+Djzi8mbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozhXXXKV1C8BpwXSn0ggOnXbjReceswAeRKPdDvgd+Ciczr1Lz5+pbaw4/BIsN1qL
	 3IAsFm5NN8t7D4ycnF2zSTcYzdei8y4tN50zzVwwtotd/Iy9qK7Bjt5kKv848UJ4Pa
	 BYskbUntHgbLb3Kpn1lo642RWr9ZjRU/Y2hctx3mgz7W7ZtpOb/JffL8n4dIhHqosk
	 /3ApWoYTVceBmSHRzwn/I/O8EKg2nNIqtFA1yChWrKDBeWzKblhXVVyoV+me6bfBFf
	 nX9rjkevpNROZgPAUTvS5ignH1jwWdFk1+n9oJAxRYYjqPOZBT7ePHypHYcBHEdTcV
	 9lNqRZibBNygA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 29/76] ALSA: usb-audio: Clear fixed clock rate at closing EP
Date: Wed, 13 Mar 2024 12:41:36 -0400
Message-ID: <20240313164223.615640-30-sashal@kernel.org>
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

[ Upstream commit 809f44a0cc5ad4b1209467a6287f8ac0eb49d393 ]

The recent commit c11117b634f4 ("ALSA: usb-audio: Refcount multiple
accesses on the single clock") tries to manage the clock rate shared
by several endpoints.  This was intended for avoiding the unmatched
rate by a different endpoint, but unfortunately, it introduced a
regression for PulseAudio and pipewire, too; those applications try to
probe the multiple possible rates (44.1k and 48kHz) and setting up the
normal rate fails but only the last rate is applied.

The cause is that the last sample rate is still left to the clock
reference even after closing the endpoint, and this value is still
used at the next open.  It happens only when applications set up via
PCM prepare but don't start/stop the stream; the rate is reset when
the stream is stopped, but it's not cleared at close.

This patch addresses the issue above, simply by clearing the rate set
in the clock reference at the last close of each endpoint.

Fixes: c11117b634f4 ("ALSA: usb-audio: Refcount multiple accesses on the single clock")
Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/YxXIWv8dYmg1tnXP@zx2c4.com/
Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2620
Link: https://lore.kernel.org/r/20220907100421.6443-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 803053d4c9dbc..13c0264881499 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -932,6 +932,8 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 		endpoint_set_interface(chip, ep, false);
 
 	if (!--ep->opened) {
+		if (ep->clock_ref && !atomic_read(&ep->clock_ref->locked))
+			ep->clock_ref->rate = 0;
 		ep->iface = 0;
 		ep->altsetting = 0;
 		ep->cur_audiofmt = NULL;
-- 
2.43.0


