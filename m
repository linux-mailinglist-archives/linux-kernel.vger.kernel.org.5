Return-Path: <linux-kernel+bounces-33474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BA836A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1306E283B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D513398B;
	Mon, 22 Jan 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhIAaUFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E451028;
	Mon, 22 Jan 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936429; cv=none; b=fviqYPvBbZxRJM3bjwFZNjc+11UL09YpJQvSKIlfVwVmS46QOPZugtXst4AY5gth5ztfxNv8GAyd6uj6EEbRJdUEbJqPm7ONx1+OFH6R/30wkpcLaOJMonpntyY5cYN4ZHCJzmmWOK1bIkSM743tAfgkt7MIxfMq22r26E+036A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936429; c=relaxed/simple;
	bh=GcrS4tsz1IsDHsCn036hfbKXhVVJlNZ2fXMIUMQlP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I52+3N74doE/FNnexTpGnUOcvnShYdgHeL0IhQX4m6jFC0e9Cd8rZHtqXyKNLezOsUUn4FE0i2IQ8c6mZLYdVMwOd2wbf4A2bsT1NrxgD4HLftRU2yQ9MRWtdnRO0PZnsAVISBL7kGRQqA2gdAUKT4azOKSDnVWOeTqzcx5O1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhIAaUFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCEEC433F1;
	Mon, 22 Jan 2024 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936428;
	bh=GcrS4tsz1IsDHsCn036hfbKXhVVJlNZ2fXMIUMQlP3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhIAaUFEsZyUqGJvAvmeE6637w/9ab0YLfTzgMf2vC6TY4u7sWgapM5+TI8xip+yB
	 gAqIRw2dzElnZH+ivpR6Dp+2EGL/pstO/Ghl5L4EbuwrO/olbf+71wJGwECEK2PAZe
	 E5w754+3zJ66aBu+MYNWIANen3yFsmzfqhseyGl5YYH7SELjsqmqNl5j3sqrKFMxgz
	 iB+TJf+XqhsxJ55uE5C+fEmK/FnmGY4NNtLRgxW3Erb+7ZSv0bT4j7fNXRhD+O339n
	 ga0tAyoATsETrHP5R6CBkPTxF4C6dKexlbZ5Poms1u81UdDjgDhxn2q4Ptbz03aHiK
	 scJwldo/ofKUA==
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
	yung-chuan.liao@linux.intel.com,
	cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	bradynorander@gmail.com,
	markhas@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/35] ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
Date: Mon, 22 Jan 2024 10:12:14 -0500
Message-ID: <20240122151302.995456-17-sashal@kernel.org>
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

[ Upstream commit 7a9d6bbe8a663c817080be55d9fecf19a4a8fd8f ]

Same usual filters, SOF is required for DMIC and/or SoundWire support.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231204212710.185976-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 774d80f4b101..e4cd6f0c686f 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -389,6 +389,16 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x7e28,
 	},
+	/* ArrowLake-S */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL_S,
+	},
+	/* ArrowLake */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL,
+	},
 #endif
 
 /* Lunar Lake */
-- 
2.43.0


