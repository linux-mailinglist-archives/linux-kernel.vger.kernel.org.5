Return-Path: <linux-kernel+bounces-102010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CAC87AD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE77282E62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD514E2C3;
	Wed, 13 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPt16zyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5A14D444;
	Wed, 13 Mar 2024 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348224; cv=none; b=i1bwl8rQ+xL/NyawDqB7BmRfUVGfP/MeYclsYtsA8jA94hMLZeD6tim21EoyUafPWMCTWhBMj4sXM71E+IlIEgKZUNVjCcCcYkNzDHJSsQPgYm3BXcnQ/he25XPXE/f5ekDBQCuOyPv91/GLGGkytfI7qO2htN5Q5lE+tcZPJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348224; c=relaxed/simple;
	bh=s8SnMuojUTopw8S4/MfbR5xT0i36Z9rfYwSR7D7R1wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJVCcQX7vF58WPczAyWLPnSaczW2WGmobHO8BSp0SRqO4r+3aQ+b9+lshMW0LeREN8fnMwGxSyF7XO9D8GbMLNP2dUbmzIIIRh/RAD2FcV/sRKKhPpCYTh3Y1rXcdqC14Cnzb6sh1efRxE9ZMbQawJ3Pb9pGBoSt9ik228B3mtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPt16zyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B2FC43390;
	Wed, 13 Mar 2024 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348223;
	bh=s8SnMuojUTopw8S4/MfbR5xT0i36Z9rfYwSR7D7R1wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPt16zyY9P3F5r+J/f5LStTkzPfGqXmqxcl/XtMlqdyza3F/waI+D3vm02Yu1WUwR
	 21KZHb/TQx39szIm64bYBK9u8wIDzY2USsUyInm9nXmFVSBDsTRoMiA7dCL7ajJHPo
	 dfHMCg+qMHI/yDlL6uvDuIsl7mxqpdzrOvc4pfjm9pQ6fBm6LNPNcA72JVp6D/B5Kw
	 PI1GHisl53cWpc5nYdLHaWeRi2Pvcb9CFTG1m0KTT7BfaRp+BtMwvR9svhFAS4+Wla
	 bTX4Zl9aSk07ERwAXSBy54F2uK/7UP80yaRWvzJhQXWsG2MSKSClltpVPb7T7Y+dBL
	 TR4Ut6ZYbT6+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Dan Carpenter <error27@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 69/76] ALSA: usb-audio: Always initialize fixed_rate in snd_usb_find_implicit_fb_sync_format()
Date: Wed, 13 Mar 2024 12:42:16 -0400
Message-ID: <20240313164223.615640-70-sashal@kernel.org>
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

[ Upstream commit 291e9da91403e0e628d7692b5ed505100e7b7706 ]

Handle the fallback code path, too.

Fixes: fd28941cff1c ("ALSA: usb-audio: Add new quirk FIXED_RATE for JBL Quantum810 Wireless")
BugLink: https://lore.kernel.org/alsa-devel/Y7frf3N%2FxzvESEsN@kili/
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20230109141133.335543-1-perex@perex.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/implicit.c | 3 ++-
 sound/usb/pcm.c      | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 41ac7185b42b6..4727043fd7458 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -471,7 +471,7 @@ snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 	subs = find_matching_substream(chip, stream, target->sync_ep,
 				       target->fmt_type);
 	if (!subs)
-		return sync_fmt;
+		goto end;
 
 	high_score = 0;
 	list_for_each_entry(fp, &subs->fmt_list, list) {
@@ -485,6 +485,7 @@ snd_usb_find_implicit_fb_sync_format(struct snd_usb_audio *chip,
 		}
 	}
 
+ end:
 	if (fixed_rate)
 		*fixed_rate = snd_usb_pcm_has_fixed_rate(subs);
 	return sync_fmt;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 962a6e1bc70c8..580e2649641e4 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -163,6 +163,8 @@ bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
 	struct snd_usb_audio *chip = subs->stream->chip;
 	int rate = -1;
 
+	if (!subs)
+		return false;
 	if (!(chip->quirk_flags & QUIRK_FLAG_FIXED_RATE))
 		return false;
 	list_for_each_entry(fp, &subs->fmt_list, list) {
-- 
2.43.0


