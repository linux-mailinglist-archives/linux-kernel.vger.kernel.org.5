Return-Path: <linux-kernel+bounces-57076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDBB84D3CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7FEB234D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44313247A;
	Wed,  7 Feb 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmA7stuq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A4132C19;
	Wed,  7 Feb 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340924; cv=none; b=TctALwnlom0tUTJUluKqv4BxAoU93KescctmPtFItNJVFm2SNhXMtmikf2DUBM6+KUcGqjPGBIGSyyko6ps1ws6Q7Egdxgs22M1JClVIRDdHYkC0rgpWQWei7zRz0+WB9aTcZoPJISYqIt4iqHFkcdcmZdIz+yNwFr2VR4DVtbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340924; c=relaxed/simple;
	bh=2+1AweIC9SN6y5hYDMACYhjH8VJL7LAw5Gg35fkRRrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOfsm9uAi5qqk6iTTjv5ZppkthFus6JQ2aafjv1GUeVIbKpcRoOrn5CTfODY6EDLWW5+8Szm4TpLD3hxquJXB7Qs3fWzgY5D8fb7TkEqcZ1O2doGStkClpmFeJH3pRK9FB9/Jz2L5PZzSJIgF3unBvJlzeA1MCZz8Xn4vREVVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmA7stuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9352C433C7;
	Wed,  7 Feb 2024 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340924;
	bh=2+1AweIC9SN6y5hYDMACYhjH8VJL7LAw5Gg35fkRRrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmA7stuqPwAhlnjcQq3YGZMfZ77WoWCydnLpQfAFZzzwsl2XJerq0hrpP5PjY0xsy
	 p4l82OsWDtUu2Xt9GUnjESdUMFKEhxpcQcvYtwX5sNUsMAyfu9dYj+ZHc39U5NCJsR
	 K8wInqgV+7gm9m6ij+IQovubME07Yi6+0hplsg+9sQkjrwBzDkRDSKch8bcZcRZsGE
	 ckq7QI3Fl0mce/V2VKtRNL7o1byrdMPwIQgC67ZokbyNGG3L5IdSpr2uavlhVx0fbl
	 wBDmfmyvqvIvECY3Du/KKjXl4B8z/jicV0mUCf2aHZrw4sBb1WWyscpu6I/FVMWl5r
	 lcAW0vrRZ/SWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rui Salvaterra <rsalvaterra@gmail.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	siyanteng@loongson.cn,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 11/44] ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
Date: Wed,  7 Feb 2024 16:20:38 -0500
Message-ID: <20240207212142.1399-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Rui Salvaterra <rsalvaterra@gmail.com>

[ Upstream commit 56beedc88405fd8022edfd1c2e63d1bc6c95efcb ]

Apollo Lake seems to also suffer from IRQ timing issues. After being up for ~4
minutes, a Pentium N4200 system ends up falling back to workqueue-based IRQ
handling:

[  208.019906] snd_hda_intel 0000:00:0e.0: IRQ timing workaround is activated
for card #0. Suggest a bigger bdl_pos_adj.

Unfortunately, the Baytrail and Braswell workaround value of 32 samples isn't
enough to fix the issue here. Default to 64 samples.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240122114512.55808-3-rsalvaterra@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 98b162c8eab6..a058de076e8a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1732,6 +1732,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 		case PCI_DEVICE_ID_INTEL_HDA_BYT:
 		case PCI_DEVICE_ID_INTEL_HDA_BSW:
 			return 32;
+		case PCI_DEVICE_ID_INTEL_HDA_APL:
+			return 64;
 		}
 	}
 
-- 
2.43.0


