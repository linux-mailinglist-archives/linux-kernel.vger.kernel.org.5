Return-Path: <linux-kernel+bounces-102011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AD87AD90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8740E282E89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489314D441;
	Wed, 13 Mar 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQXZDyKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0914D452;
	Wed, 13 Mar 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348224; cv=none; b=OLk0Zgs2P+VcYOj0q1vXDNakfDaIBAV456IuXn9XjS99fdB+qyGANBntrVitcvnFynKPerD+Lj+xLxXbmLjD1XXTR/v+dDchKKMqXH/h/IvezTqxF5jN32MbiH1G6oaAl4AMAc/sE7Y4DQhkqbSHF47ck7hNL12DNtjH/q11N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348224; c=relaxed/simple;
	bh=9HIXSwzU4M5cUYpKlNYWQPtrx4F5qK1+uj3SlIT4wDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIoYCP9vDYoJhAldGlLuHJK0uGEd+IcXZzSMqf7/w1h40gKhZ65fuFusjOWzP0Z3irUbWgiZQMdXRCJKqhLtz+pKOKveTVBMCWddqu2c/Woj589ataPfTTlnLnqPKmwxFlVjdFAdzd7W/L6SuLHXH/DxLJKfF7nrDKYubjU/0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQXZDyKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20E6C43394;
	Wed, 13 Mar 2024 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348224;
	bh=9HIXSwzU4M5cUYpKlNYWQPtrx4F5qK1+uj3SlIT4wDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQXZDyKXJ+mGNYDJpLfi8enj0gO0Z7cbOjwiSeLJRtKsXl8VHUc9YqF/N4GzQuGt1
	 038qLWwD++tcdvX54L5cb77/+9v84bFEwMRgF1R4T3J0ThusclxyZfKoe18/OzbICf
	 wp6MwYiVW0TaaDUv4oe4DwHKJX3Dy1xmnB3P/l22MUfoKe+M06U7+V8O49pLDb7GKa
	 YHYzOg4qANVBUs65iOX8Sh6y5lQ0EHypdmaNqblQt6F6xWZkzl1OLCNCtXf5MOghD9
	 xa1bQUWmFpCr01WxtivyYMp0l7XSjdzWfKnTm63eEMzffjFxR27i5X425TfbkGbdly
	 /qGIh8Zwn6s3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 70/76] ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum610 Wireless
Date: Wed, 13 Mar 2024 12:42:17 -0400
Message-ID: <20240313164223.615640-71-sashal@kernel.org>
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

[ Upstream commit dfd5fe19db7dc7006642f8109ee8965e5d031897 ]

JBL Quantum610 Wireless (0ecb:205c) requires the same workaround that
was used for JBL Quantum810 for limiting the sample rate.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216798
Link: https://lore.kernel.org/r/20230118165947.22317-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 668abe6dc7b6 ("ALSA: usb-audio: Sort quirk table entries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6cd7f77779159..3073570beb3e2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1896,6 +1896,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
 		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
+	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
-- 
2.43.0


