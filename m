Return-Path: <linux-kernel+bounces-33347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B983689A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF171F220E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3364CEB;
	Mon, 22 Jan 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+QNzX0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01364CE4;
	Mon, 22 Jan 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935946; cv=none; b=XqD1QTy8P0E88NO/Odfa40f6Rry1klEUkOavY0HsFoIYIDKpa0sJOFM/PrZ2M1boLRZ+Ne03/QViAmOR2nF78J3XcyW8T//AKjrWSGpTXEhKSoeE1WIXTNtcx+XXT/0VMNteRryNaljf2CPvH+Sb8H4Qa1+ero9lg0JI0m3KAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935946; c=relaxed/simple;
	bh=lYQ0v9BNAg7b1crERIXnaGONdNgAR+yxdq9wdPYxpoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liWs7JVJ/OnJqe3T7zE0gtmCxpW3PK/q7oghq/EuC6vDYySf65fw+lzEmAi8Jjq9JsC7c0PNN680qJ93mmCsKpwR252qzZqJyWKU12L1yju19j6EDsethLepqL4PECW4zd6WN8GiltaO17lrdbMZ6w2qWuS5abpLRdpyG0Hgtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+QNzX0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB74C43394;
	Mon, 22 Jan 2024 15:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935945;
	bh=lYQ0v9BNAg7b1crERIXnaGONdNgAR+yxdq9wdPYxpoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+QNzX0mu9u9Qgj5ie4mhmlIILRFfSq69cDZQxchcaDm5ep1LnMUZxpXFhtgOqets
	 Le6NQZE0BL5KLdx0tF7DaCYnWjhIwc1vluMY94n7EQI7wxFONiEcD9aqKoRQ1KJQd6
	 WvsQiqKTxr9us52sriQhydWx/3WoRizFNMNNp8yGAauyAveUTbnddBpk3Y5QaorVhV
	 PvP58AaR1IkfRX1BidZQrk8y+n04fdp7ObJZWZsoWytE/rbAgaM+++Q8r2rLhLTzkz
	 h7PICZ4BJpMB0Hu8xq0z7wgO0+k/1lheZSK9D+mYHYEkZG4HbAidhlMutSkpk+CceG
	 Pzfl2vksG0I0Q==
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
	ranjani.sridharan@linux.intel.com,
	amadeuszx.slawinski@linux.intel.com,
	bradynorander@gmail.com,
	markhas@chromium.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/73] ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL
Date: Mon, 22 Jan 2024 10:01:39 -0500
Message-ID: <20240122150432.992458-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 756fa0aa69bb..6a384b922e4f 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -521,6 +521,16 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_MTL,
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


