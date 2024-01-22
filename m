Return-Path: <linux-kernel+bounces-33511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A7836A81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7354F2835F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4F13F00B;
	Mon, 22 Jan 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUZ2qGCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8055C21;
	Mon, 22 Jan 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936562; cv=none; b=JtfX+HAnnaKXHGzEN/MjWGFxdxbFG2ga9g3fTglOyiYzHt369hN9IcYy5c/PMfGttK3nNfMOZGoxoUFbwvXSWCyq1sby9iYghS2SQqh7fKMG9VsrrS1YTsGACCNslQDxeRbCe+oNFtP+3mbRPr75mSCEBGbMGEVRgGxYmpNLmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936562; c=relaxed/simple;
	bh=WiYXzJd0JDu8rWXm9STY/IpJs9ytTiV80vMi0kcGlMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJP6uPWo7sKtJ7XHF+nA6TXVnHJyrvj10iUISzAsg4s8Sz0d4RoX3j8MX5ZrCo3EUvTVnOLeiAhN+Elf2U89BAM9o9uzTMpV6ZjMsOEz7bIm572WcJaxfwSdk6NLkeDw8wT1T9U9ZO2NYpbTrFi9N6aEsbclndqBOlcGXwWNZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUZ2qGCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C96C433C7;
	Mon, 22 Jan 2024 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936561;
	bh=WiYXzJd0JDu8rWXm9STY/IpJs9ytTiV80vMi0kcGlMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MUZ2qGCCE5owtBWSgANAKSw7oTqakEI4ImSNaxKnz6WvjJVMlUwPblsGIq30hBsa+
	 PxiCVhcUTl9uSAfsctaIXOyHc1Cziv1/lFhkTV2mtZAxV1A8oBB9J8Kr+xxtt9+X9a
	 5BLpgWbjMWqhBf2nUgLN7qBLj+IsjdGK1Jbe6TPvEqG+IGI4zN4mER2uU8Fs3byc6G
	 CYFYS8RxKdsQRiMg3Wv/XTFkNolfioZme5mTzY/GyA2axMtUSa0PXYyg9htQbQkVj7
	 pRaQWlqcva7rYCREaQG6ASBk4icfEy8WNaMkAVGYLCUU2zUppcHvC+KvSM/cG14c8m
	 24dRMoGQDR/Rg==
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
	siyanteng@loongson.cn,
	amadeuszx.slawinski@linux.intel.com,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/28] ALSA: hda: Intel: add HDA_ARL PCI ID support
Date: Mon, 22 Jan 2024 10:14:42 -0500
Message-ID: <20240122151521.996443-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 12c6eb76fca3..a3c6a5eeba3a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2581,6 +2581,8 @@ static const struct pci_device_id azx_ids[] = {
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


