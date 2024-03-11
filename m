Return-Path: <linux-kernel+bounces-99084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06445878343
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B539B284184
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4516026C;
	Mon, 11 Mar 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcEKJyN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FD604D4;
	Mon, 11 Mar 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170014; cv=none; b=H9MKcxGpt1XyMgOAySi5gAnGQe9PVFyK8ZhXhalsB+uLQWwD0Toq+bIYoz5Lfkj/PAMkScPtzFgrff1AAouy3fDZRjcjVnAZZcVc6tCPhDofGaqbjKSyA0UQmPmXL/vNr9kjyQBn7pX5880zw/jhY7o1OWHam9Rk6KkEuQyF6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170014; c=relaxed/simple;
	bh=/LhJIP8T8+p/zwAyQer+F/R9x5sOpEcp3+Z1eGMIylE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUPCc5oRS8LGnmKbmkD6RRttowAz0qW23iAWEfnfYSDQHg5B1x8msKklbtSfjCl1qTGAqZTdrgw2XYD+E/ylhtzBwAB/tO38t2BHLERh5lTr/o9EwWhXjhgPru08dmFC94/pbLYSQZl2utZmRRsWNI7Ng7hEtDzuJa+xeCxe6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcEKJyN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1CBC433F1;
	Mon, 11 Mar 2024 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170013;
	bh=/LhJIP8T8+p/zwAyQer+F/R9x5sOpEcp3+Z1eGMIylE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcEKJyN9mNO3jIx8+oANUl+TQ+5hO/L/Km7lnIle9MhbIdo7LCYUDk5pRmmFLi085
	 8SG1JtzrwYN0cdATBimrDbKBNgJHujHhyATxgyRdOf4ntfj/t7EandT0CK8sFoJOtC
	 PbSWo1OaWYusjLPmwWpGHCPO+g7NmWjF3VcHGl96U9b3jGtPpziNEYH8GHmT5P8D/h
	 BQZGkd5F22NroOaY4PcwLtuC1y/EOud9+ZpjM55l/xQUaowvstDz53/nmRfayvFQ+R
	 Q9QtieHSahOL4IZqEiBNgKLBgThJQuMOPUTcQ6dWT5wFjwxxV152PDTesvtmxRSXBm
	 42cICYVo4s/sQ==
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
Subject: [PATCH AUTOSEL 6.6 10/17] ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port
Date: Mon, 11 Mar 2024 11:13:01 -0400
Message-ID: <20240311151314.317776-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151314.317776-1-sashal@kernel.org>
References: <20240311151314.317776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
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
index 88d006ac9568c..234c8b46d9254 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3683,6 +3683,7 @@ static void alc285_hp_init(struct hda_codec *codec)
 	int i, val;
 	int coef38, coef0d, coef36;
 
+	alc_write_coefex_idx(codec, 0x58, 0x00, 0x1888); /* write default value */
 	alc_update_coef_idx(codec, 0x4a, 1<<15, 1<<15); /* Reset HP JD */
 	coef38 = alc_read_coef_idx(codec, 0x38); /* Amp control */
 	coef0d = alc_read_coef_idx(codec, 0x0d); /* Digital Misc control */
-- 
2.43.0


