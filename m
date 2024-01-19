Return-Path: <linux-kernel+bounces-31093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AACF8328BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C513F1F235B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4154D11C;
	Fri, 19 Jan 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3nxEPkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCB4CDE3;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663615; cv=none; b=TCv8J6qaiLCuvDyuD5rKbdYP5aAkzH5CY1SmFuES2fX/3Akw7NtEsXNAlGFCV/EpyDWbmC38xn8gx7AyOaD0ZWwyy2JS8Re8yhXL4wE8xxPZK56DFgQkWnUG4uSWWL7eBnoUTsT+4MBDjFof9KemzNpoAV60sEPBDuaiC2RMErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663615; c=relaxed/simple;
	bh=HuYa0Hs5Af/qVxD25qBo9TBTPaafJMPziE92BqysBBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChN4GSNM8P3eSqfFE9l7+zA8Nj0pIAahZol2XJkfR/VFazJKttYaTJ9lf+C+tdRvIX1QJshbhlKS+SrzrKIXRVlmXjy11ySRd9kX7ZCdbKb6+dChe9k1QJnCGZlKubK4J5eUMAXBU3KUHItjLTfzHaN8V8HlZB28HkxkUojNYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3nxEPkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28949C433B2;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705663615;
	bh=HuYa0Hs5Af/qVxD25qBo9TBTPaafJMPziE92BqysBBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3nxEPkA96L2O/NWjrzucPoxwhvHKV8dJJ77SyUattgWnQJGmC0BZiknQDuLdin16
	 KzErDIsOJoMpmCI3lijwVL7Z5dHTJ0VfyjQjAtw43CX99KQYMvPUbEnSZQGJRiqMph
	 Jvi0C3orFIfEwnwF8lpyUVk6acPb5cgoqfA1vigp6dL8eyXLorQ07wpci4/DJqCG7w
	 vOZHcaKJqymR/pCEVqA5i6iancpP6k7+id8e+i4CkvbHFRgn/ltm9c3nIo8yuPZ3Rp
	 xfus0YgQjQfSKZ1KO5JP4S3hcUH7fAH4BtnfKjXc/jr8HrmJH17fAbRqjL7AQqUVg3
	 xxXOCKdrk3U7g==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQn1b-0001xL-2w;
	Fri, 19 Jan 2024 12:27:03 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Date: Fri, 19 Jan 2024 12:24:18 +0100
Message-ID: <20240119112420.7446-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119112420.7446-1-johan+linaro@kernel.org>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UCM configuration for the Lenovo ThinkPad X13s has up until now
been setting the speaker PA volume to the minimum -3 dB when enabling
the speakers, but this does not prevent the user from increasing the
volume further.

Limit the digital gain and PA volumes to a combined -3 dB in the machine
driver to reduce the risk of speaker damage until we have active speaker
protection in place (or higher safe levels have been established).

Note that the PA volume limit cannot be set lower than 0 dB or
PulseAudio gets confused when the first 16 levels all map to -3 dB.

Also note that this will probably need to be generalised using
machine-specific limits, but a common limit should do for now.

Cc: stable@vger.kernel.org	# 6.5
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/sc8280xp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index ed4bb551bfbb..b7fd503a1666 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-		 * set limit of 0dB on Digital Volume for Speakers,
-		 * this can prevent damage of speakers to some extent without
-		 * active speaker protection
+		 * Set limit of -3 dB on Digital Volume and 0 dB on PA Volume
+		 * to reduce the risk of speaker damage until we have active
+		 * speaker protection in place.
 		 */
-		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
-		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 81);
+		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 81);
+		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 17);
+		snd_soc_limit_volume(card, "SpkrRight PA Volume", 17);
 		break;
 	default:
 		break;
-- 
2.41.0


