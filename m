Return-Path: <linux-kernel+bounces-159743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4688B338A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EF1F22451
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD90E13DDD5;
	Fri, 26 Apr 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSRx2iX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A113D525;
	Fri, 26 Apr 2024 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122319; cv=none; b=ifuEsHAlVA/Rr9Te3TxWxzejvtv7MguBa3K9LyrCC++iqAk3FkjH/OHY3pEKGpvHd1fM4BiZZ0/jZo/tzY8CtMd/DSiWpJG4Qv2UXOvvnhaGwxK0MhNnInYr6I2nZrTx/Pq3zcIIHOckhVszkngePCCvw3iBEN8Di5vP7bn16SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122319; c=relaxed/simple;
	bh=3FmRYO79LY+xNUmE2P8IE0NUNwTY/hvuU6kWmtqG8wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEBF6z+z4/sTDDzZnT2XxsFtH2TpS6ATC1gnl1wiv2MlylpDnr0xsi3cu1HzuvfphxoCd2c2JC+Pp9vgaCWkugYr14uyeTH3tn8zq5BsqEOeok5Xlq33CNxoeQaHW7n2VYn/3xXROOYaxBJ9tofr8WoIAqdjset6D3X9BPD0n9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSRx2iX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231EBC113CD;
	Fri, 26 Apr 2024 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122318;
	bh=3FmRYO79LY+xNUmE2P8IE0NUNwTY/hvuU6kWmtqG8wY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RSRx2iX7UDZAao7e4t2ttR+Y4XGmcflLdnDnK7p92EgQ62pOyEUsZcfgv5InIs9Na
	 Rh0+b2jo/DXnR9qpx9YYuNJ5uyOChACYPYfuQluTz76xZfRjqN0Qa8q5jJd/NRAdgp
	 9L5ysuuAOGqrZX5NkGN2xPFX4fwecyJF/r9a4K7xYC+1F9+1iLin9dbPCOaILSh7A2
	 RrGaVx05BU5bQMMvRu+VEa5qy3W8Qkc/k7n586t4eZW+FaYgfnZopcWgCKljsHMhth
	 cN04QLDtzF0bfOe2Ajz1Stt+00OdtKibqO8thoBZC4fknbZBzDdoFgh1iIIBA1ZBGW
	 R+IpaBto/JrEw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:50 +0200
Subject: [PATCH v2 03/14] ASoC: SOF: pcm: Constify local snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-3-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=krzk@kernel.org;
 h=from:subject:message-id; bh=3FmRYO79LY+xNUmE2P8IE0NUNwTY/hvuU6kWmtqG8wY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24hwck8oGj89p/Piv/3ziUOfz42/slpYmY37
 WRFPnobD+mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituIQAKCRDBN2bmhouD
 19tmD/9ClP7BOTVKiZb3wV6kaqQNwRuSVgy0PFEG5BuZXR4fkipojXK2OV2gab7dvR4udfp72/n
 OIqMZIM6IuqENmtjGiB8vt6fbT6Alq2ZbTR/ynp/bqPf8E3q/CXl56AS08e3O/FH3uKCBvTNJuL
 RI1jBdv5Ogkjb0CcvItMRCndDJ2JH6VCMwU4fzjgLyZNn6Y/zWqAUQizzmXEcxUVbgK2JnhoyNU
 RztNRIUWK2nzcpSs7gDZVTIRbK6ZmqQiSD1lHfgUbudnp67W/IZg8f6LPoope/iKzLoq013m6Ot
 g4y/9aAmhrK4gmU0Xh0P1iO1nXMJoH+3K7Qb8K5bX6icIGDgOC1ZQDlb5oq4FZisM4IVbqeS43A
 +EwN4ylLCNhh6gLL4xuF7UrOILzvwY7yUxYO/fLuRvpY0dKagoLJcLZcrfVh0s+iIm42uMvKStg
 Y7K+Yfz2ZA8WjY+FZJe+rQivTxXTVYEOGYHACJdLVLy0voezBU5RPGXH8ZWokud8mayDvPgvg4X
 yyPo776FyhIe+A5auCJDqWnGozZcVoDuReYRjUMqTVcrLhLBUpfgofV4Kffsq2iTvzuv6/TmmOH
 ASO+wV+u8TOaGzytEdDo5cEKaY2GPtDcbKlnKDX52OkKMokZ0Dhh79PfoR28h0HN2O5Lp0xIt/P
 2oCVADZAEnEo5sw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
functioon does not modify pointed data.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 8fca4b0d63de..cb774e011e31 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -423,7 +423,7 @@ static int sof_pcm_open(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
-	struct snd_sof_dsp_ops *ops = sof_ops(sdev);
+	const struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	struct snd_sof_pcm *spcm;
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;

-- 
2.43.0


