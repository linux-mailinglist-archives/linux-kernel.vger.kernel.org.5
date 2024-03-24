Return-Path: <linux-kernel+bounces-113431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCF888446
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D682B25F31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25081AA916;
	Sun, 24 Mar 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swo+4aYD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BD1A9F62;
	Sun, 24 Mar 2024 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320234; cv=none; b=sES4ItzxDYboM08f3EEjxz3v3QyqHQ05Ck+6oULSFNtXui/t+Mb0hOFfvRnJQ1E5rkbwLCFTT6YEWdFpRFGsoZjCI3ibvHhcv0URRBGc+8i3HEUVFuMk0GCcTh1x8+gtOPymBzrmhDcGqJnlCAPaboGqmJ6xyKtRzZanZ7TtcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320234; c=relaxed/simple;
	bh=gx3Zgui+X5nZudRDwhDa37NzmbxqEjukZjEG0baygKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZZAt5ec/32lufNtyrFKABjyoIew0pfJsuWIcAnaegEv0Kx8DHFzFYfz6Jm7shO8xNyBkbX8GBywCTpaL45iSiGWTYSvLrie0Htc2PrTWjtPhKUeps4Ecs0nj2m9h/bjpFR6ZY7Ls5fDnXsodo7Ms2qhzLvk0GEql/fjWquFR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swo+4aYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356AEC43390;
	Sun, 24 Mar 2024 22:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320233;
	bh=gx3Zgui+X5nZudRDwhDa37NzmbxqEjukZjEG0baygKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swo+4aYDj0iJnsl4evXwfz2mX3DudRejmBpa9pN9kfJ2RtpaW3QEmbsWOkswBHewv
	 GBsFYHW3zoMw+C5GEvw71lHsWzsHkc7ZKqJYz0wtrjzLgCxZYaC3lfC+WdxE/Muihz
	 XLKLxqjB8P76KiIpRSMbZ8gsRaonOT1vKg49DllB/LDepd0TzRWYKAODeAuE+Eb/LG
	 Z9dcSTaNisouGcxq7MuYqLbLdkq6vDmju3Zg0Iqy4e3B62X9PRwSL1VY1dj+CmGxco
	 0fFk0xc9w1UC1PCVuKIopdnnigJEtmJ0fvkALvSkeQWjwEbq85RR2dRKunbM49oVKc
	 qQWYLpHyxFa8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 540/715] ALSA: hda/tas2781: add lock to system_suspend
Date: Sun, 24 Mar 2024 18:31:59 -0400
Message-ID: <20240324223455.1342824-541-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit c58e6ed55a1bb9811d6d936d001b068bb0419467 ]

Add the missing lock around tasdevice_tuning_switch().

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <c666da13d4bc48cd1ab1357479e0c6096541372c.1709918447.git.soyer@irl.hu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index ee3e0afc9b313..750e49fbb91e5 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -885,9 +885,13 @@ static int tas2781_system_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	mutex_lock(&tas_hda->priv->codec_lock);
+
 	/* Shutdown chip before system suspend */
 	tasdevice_tuning_switch(tas_hda->priv, 1);
 
+	mutex_unlock(&tas_hda->priv->codec_lock);
+
 	/*
 	 * Reset GPIO may be shared, so cannot reset here.
 	 * However beyond this point, amps may be powered down.
-- 
2.43.0


