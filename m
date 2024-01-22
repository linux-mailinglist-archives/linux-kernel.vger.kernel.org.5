Return-Path: <linux-kernel+bounces-33960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC68370E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839211F2D77C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8B47F58;
	Mon, 22 Jan 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+dcfJF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FF3E48B;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947508; cv=none; b=KV/b8cfUno9vyksl+ICAdx+rcEKfC+mZbdSS+EuKBcwmSVsCRjT13HNdVbhzvjdVq2bFiKDL8oOqK1Mlea3Rw4cYY5eN7piXISgxqggz1WHnUov36c4sGRjnAt3NFFjINC1HbhUI7gvQ9gNXGNT9GPOW6w5E26WctG1e2PvDyNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947508; c=relaxed/simple;
	bh=iEHE7zcoasy6D541jeKFupXFX5j6AhyLZMvQAbjE414=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDYO7ma/+hS5i2w0y8noZ2UvLt0BFNrVsehrr/7z2XK1B7WjyJQ/i97YfGYTudDWPZHoKvyFMq+xFelSBTC3iEtXRhY9giMNGl5/qNO7veKSHvrElWslmcUuTX6lPXd/QHfWobzI4lPqlkZBoTKld4SsXzBZHuCoXow9dTasgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+dcfJF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1602C433C7;
	Mon, 22 Jan 2024 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947507;
	bh=iEHE7zcoasy6D541jeKFupXFX5j6AhyLZMvQAbjE414=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+dcfJF6E044EyavOfv1l9nHnpKuMYutU0LqH7U8RTGknusM+yybwHryBMXCCV6E/
	 6xdXL1sM1jWLDi8dwSM2TkJ/23cgWDee+65weSpeDef+3Lw3QGywZuckX7l5pMnBuM
	 e4i8+BZsjataShXzmTwIslxZ30KLNZ2HdE0P5T7EvFYjNK90ueMjsI6Z2QChXLcLG6
	 YpcRJY8b4iadTa0s43m5mQGMfPzIHXiyRJyd313Mzf6V+Kki3hl3wojw5E7ovJhXMI
	 dBYHM6O7chalTSbVnwzzt/1QCH1Cbb4UUyf2pTu7MtM1X9nvIOot94yej8+sk/BUvp
	 q7CAXSS9+tI6A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rRysa-0000000013V-1wQ8;
	Mon, 22 Jan 2024 19:18:40 +0100
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
Subject: [PATCH v5 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Date: Mon, 22 Jan 2024 19:18:17 +0100
Message-ID: <20240122181819.4038-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122181819.4038-1-johan+linaro@kernel.org>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
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
2.43.0


