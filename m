Return-Path: <linux-kernel+bounces-33536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24422836AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FFB2815E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E814A082;
	Mon, 22 Jan 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Pxjmnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561814901C;
	Mon, 22 Jan 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936650; cv=none; b=ZSo6wEe1yvC9HG9N/VF2UktncoyXWoNUaZhgPgrexbM8hsT9TFZbRGieGbWyODn5c+IzEwW8eFr5K9b6yq5I3KSr6q/joyIREjRTCydsS8RZOiY6tMoM5rZM3d93087Z0ETgmJ7gff3xH2/woi3CLvEyWTQx0VD8o8n9Ki7w+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936650; c=relaxed/simple;
	bh=SDhzb/QUr8R5tgrZEvlrjOq9Hm1fSVVzZ+B9W9gZ41E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hl7hgmr0loI5zGlvKrYqLQK0q60UFIZ3rPIe5FBxhLf9EI1sCum/NP8Nd+jTfjeN032Up4STy8vDmbQ4NIdTk9LzMINL771BeTsYSUB7TXykpCNdYUewstFWxBt+OhC5Xp5Doe1KM2UHuZU/3YDPUaMITskYHZwk7eSAzuDRUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Pxjmnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142E9C433F1;
	Mon, 22 Jan 2024 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936650;
	bh=SDhzb/QUr8R5tgrZEvlrjOq9Hm1fSVVzZ+B9W9gZ41E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3Pxjmnb1McesR77ea1XKhBQjEhF5S58M3r7AGEKCCyjlkyxXTwsYhqQgl4qPeh8P
	 iojZGycVa0ZaP+SfUI6PKu7NDOFpXSqvV8avcrnjH/BwMkIOxbX5TOfSc4a+WoXhqS
	 IjZHiwImSC89Oe7aaidOrvXw+s2lVBw/E7vIUK8axrdxIwslLl2mZeXP3NWMR8HGlR
	 ApBocbgysydUdhLf22K968E8qvE0gSpY3vsAVvA3HTX1+dxGevUwl1vH1chvXTp0mP
	 69BVSzSBJtYMgYVmHPRgHWhpdrC8jm0mUdpa/mRv6gZuk6ELXlxAFdqmx+SFZPyGAd
	 vSp1VPh8GLPMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	maarten.lankhorst@linux.intel.com,
	chenhuacai@kernel.org,
	siyanteng@loongson.cn,
	amadeuszx.slawinski@linux.intel.com,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/24] ALSA: hda: Intel: add HDA_ARL PCI ID support
Date: Mon, 22 Jan 2024 10:16:27 -0500
Message-ID: <20240122151659.997085-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit a31014ebad617868c246d3985ff80d891f03711e ]

Yet another PCI ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231204212710.185976-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0bf2e2656721..cc9b8b6595c8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2527,6 +2527,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	{ PCI_DEVICE(0x8086, 0x4b58),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Arrow Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-- 
2.43.0


