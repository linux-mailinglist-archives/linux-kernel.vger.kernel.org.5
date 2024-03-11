Return-Path: <linux-kernel+bounces-99106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55ED878380
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134E41C213AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620314AEC5;
	Mon, 11 Mar 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpv5Uv2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD665BA8;
	Mon, 11 Mar 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170071; cv=none; b=YDT1GOYm2hJkfAEZhasj7Z+cmu1plvZCx4jSTpUdUogP0v2BV/0+b8f9Jxu38DjGrAHDyzSemiuM2N+4FM6KFN+Z1LRFLnfhCBO3PjwfBMe8BFIUImPxdD5KnJ/kyko+ED3wLoFNkTncg59x8NkqmwkZTKf/7LxkUHzV+nMKOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170071; c=relaxed/simple;
	bh=aRBHFszry3HcGlRYpmekn9zCgq6YZWmzqSZ5oA0DKuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYriW8G7HvmdAAe/2EdlyPzd/EJ2RFGqk37Ik81/dPIVUrrn9bwOwWISnBjA+AvsiDu3eeFi/Kq9b85R3LT/L75sPlM5DG8S9MYJNYzk4FPM7DTkl6JN//iNNieCTfNbfcACN0gGZcDio7r3Na5vr1624VbpCG23vHoqPAaJoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpv5Uv2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED9AC43142;
	Mon, 11 Mar 2024 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170070;
	bh=aRBHFszry3HcGlRYpmekn9zCgq6YZWmzqSZ5oA0DKuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpv5Uv2pRIw2l5N6fMbz6dq8GBKeiEF0/vJmKClD+KEFPFRaKAXMNZrJ4IJLRsz9n
	 CpRkG3JfM3FoHiZnOXPxxlGEugZZNsaDRAJiJnQ2MAJMv1n8aRWG7FVTPTCh+JweEJ
	 T+nUsHYNBvrz1XKPaKt2PTmhh7uD9kTJ5zXjs2w6rAubQa5U9tEyhHC9OrZfsE8pix
	 a6FqrYj+d4sMmxmurJZZk8UDPu9YqdXWxs20X0JRMbJAxHzcQCKkZLFmnNnWakAXuM
	 sUYF2c1F5Q4BUnATetohS7sHzIV8Osu4hyp7//I+Q3aw6K5qiSao58wD1ADS9x4pq1
	 5T1MmLmqS+y7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/5] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Mon, 11 Mar 2024 11:14:18 -0400
Message-ID: <20240311151424.318621-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151424.318621-1-sashal@kernel.org>
References: <20240311151424.318621-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
Content-Transfer-Encoding: 8bit

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit b34bf65838f7c6e785f62681605a538b73c2808c ]

It had pop noise from Headphone port when system reboot state.
If NID 58h Index 0x0 to fill default value, it will reduce pop noise.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/7493e207919a4fb3a0599324fd010e3e@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a6e6ed1355abf..3a86f0fd78278 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3675,6 +3675,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


