Return-Path: <linux-kernel+bounces-101972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E387AD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F82E28502A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2EB14534F;
	Wed, 13 Mar 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1CCMwt3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D811145336;
	Wed, 13 Mar 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348181; cv=none; b=IU4tAqM+YbQF3HewNA1L/Usu3FZud8XKok9QXPF1XWbQmHBI5cJFovsCucdtmpDmjtAUnTtFrOxE1JC5D1Cl58gOAvCKO3FFbC+T4w5y1Bc46tneg4z+ODk05WhsZZ/0i7KkOKYQO6+m2q8hWFiviX+gyhYV/4km+boJQsYoik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348181; c=relaxed/simple;
	bh=d4bgCm84uOLJ0JEFkn9q+wIIL0g3dWamq5di/Dq6FBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhjmLbpQiAtkeTFZhzp6ag9cXktoYwSYsx/ycR0QaOmWbYb97A/3ddjWLt1PNuV9C3En4LXkV6vdnRZT4Mu0AInUfuXkrXFrorlEXE1YLVAZCYPMkG5zlHHk4K5KnghUiKG9jse8hHc1O6crUAaXwimUJY/dWx4x3pLMSbr4uQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1CCMwt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB5CC43399;
	Wed, 13 Mar 2024 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348181;
	bh=d4bgCm84uOLJ0JEFkn9q+wIIL0g3dWamq5di/Dq6FBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1CCMwt36QteyK1CPz6zP6E6UOKYwl5GLO/0u9YxRr/e3i3fdtUhJSIL8yWzpOX/E
	 YrIW4SlozFRYWezYpdBdRRpYOG//XfCTtCkMYzBdNc0lAnZ53JyaveUWl0bY+qJdbA
	 5AE+CPcdJqDGlhLGgpdupIC3r2v8eDQmGLETFUyLO+BF2BDIYZOTTTMiBotCH/h3eU
	 slFcjN9PW2uLix2HlKtc/qXPKamkqmlv3+Pc6XofK9a0V0ttiALKt1BPtqPlN62Sr6
	 G34AwJ3ctSzxDOFlM+bS38UpJ4JZNA0n8dGxnY/l4TyiLQYLZSVIH5XsSGliZiDjUY
	 iT2IyTP+bDP6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 32/76] ALSA: usb-audio: Apply mutex around snd_usb_endpoint_set_params()
Date: Wed, 13 Mar 2024 12:41:39 -0400
Message-ID: <20240313164223.615640-33-sashal@kernel.org>
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

[ Upstream commit a74f8d0aa902ca494676b79226e0b5a1747b81d4 ]

The protection with chip->mutex was lost after splitting
snd_usb_endpoint_set_params() and snd_usb_endpoint_prepare().
Apply the same mutex again to the former function.

Fixes: 2be79d586454 ("ALSA: usb-audio: Split endpoint setups for hw_params and prepare (take#2)")
Link: https://lore.kernel.org/r/20221009104212.18877-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 7822baa844a8 ("ALSA: usb-audio: add quirk for RODE NT-USB+")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 2d3f814d067b5..486ef6b022552 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1339,10 +1339,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	const struct audioformat *fmt = ep->cur_audiofmt;
 	int err;
 
+	mutex_lock(&chip->mutex);
 	/* release old buffers, if any */
 	err = release_urbs(ep, false);
 	if (err < 0)
-		return err;
+		goto unlock;
 
 	ep->datainterval = fmt->datainterval;
 	ep->maxpacksize = fmt->maxpacksize;
@@ -1380,13 +1381,16 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	usb_audio_dbg(chip, "Set up %d URBS, ret=%d\n", ep->nurbs, err);
 
 	if (err < 0)
-		return err;
+		goto unlock;
 
 	/* some unit conversions in runtime */
 	ep->maxframesize = ep->maxpacksize / ep->cur_frame_bytes;
 	ep->curframesize = ep->curpacksize / ep->cur_frame_bytes;
 
-	return update_clock_ref_rate(chip, ep);
+	err = update_clock_ref_rate(chip, ep);
+ unlock:
+	mutex_unlock(&chip->mutex);
+	return err;
 }
 
 static int init_sample_rate(struct snd_usb_audio *chip,
-- 
2.43.0


