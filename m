Return-Path: <linux-kernel+bounces-33473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509B836A19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87501C24B58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2FC5101E;
	Mon, 22 Jan 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXomTyzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACBB13342B;
	Mon, 22 Jan 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936424; cv=none; b=Y6Q/6Ie+4DMc36p3l7nwRWS1Sh3pb8fg/5F+8J9qMMdH4B6tbkNfs7TX8Msa5YEbj+Ct1mPO/kOkeibxHAYKscIMSOWcSe3goI7Q/xnU8/nHbcQCQ3HkzV6K4TXQfK5//9qkOPg5iKZ744HPVNHoQNItXNAMyHZeEBCHAuRQDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936424; c=relaxed/simple;
	bh=VDDbYEnevTJ9mrkrezzSLTFohH5zvb51+wwLp+mTcQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLowK4D5D/sn30NBqnViXhKdZFVQuT5Y+JWStB+mRR+ZY8nCmNcxf3Op/uqCblBVTBBhUxKzrfrn+lE2guLnYdRmhUhmnrKgNLwnSjQqBXHCRTC69wO13g3Vrp8IGwP4XJXhrBybmlMEBQHQwwUZ8Q1jEc1r07vSply5XPjSn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXomTyzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DED9C433C7;
	Mon, 22 Jan 2024 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936424;
	bh=VDDbYEnevTJ9mrkrezzSLTFohH5zvb51+wwLp+mTcQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXomTyzZrBb/uwgcO/NebW15Ria3eI6qcaF/ZyaClNSfSfPIn1ny4DeT90FKs+Vs8
	 vLOMjXR02fAKfyEc8i63vTtCMESaLjMihN0DNx5t+53IIPbFvFyRRievUv/5p/Nr+5
	 nrb80Tr63Hlrcefu0zco9IQz4wsqW2CJO8Kqb1vkD9BTQyQjJsc6hPPW2s+vp2Faz0
	 RHbJkePkC2YvwI83jWbkmJNb5u3KRozLhB+uSUYfHCLew0qeyCawMq2x4CYVKGXxJq
	 kFJW4ws6TIOv2Yp4Kwr8sqHdSLjDrxr7MXYcE5jRdVP19+WQ3TDeaibEfCibqLH+Zx
	 m5TcRw3FUqY7w==
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
	cezary.rojewski@intel.com,
	siyanteng@loongson.cn,
	amadeuszx.slawinski@linux.intel.com,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/35] ALSA: hda: Intel: add HDA_ARL PCI ID support
Date: Mon, 22 Jan 2024 10:12:13 -0500
Message-ID: <20240122151302.995456-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 65f7e3dc4602..dd4d802c9e71 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2516,6 +2516,8 @@ static const struct pci_device_id azx_ids[] = {
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


