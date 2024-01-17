Return-Path: <linux-kernel+bounces-28688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE3C8301DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE634B25059
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00491427A;
	Wed, 17 Jan 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul+i8Cpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394714003;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482224; cv=none; b=I1x+Cf662Me76NKKCOJGfzH3Z27wmvRifBdb5Xq/oopDx6MG+Uf8RQH818V0MAIuzdsJYUwOV3e5td5ZG09+LdVHp4C4CEZ67Mm16bV4fBjqhbgpHG16Ol1P2wXEVcu8bXlkidrZwWlAKKy3Kl85CMWQ+wSxmQmFsSUB+6ZfyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482224; c=relaxed/simple;
	bh=ubf+Lb9lWCl+Bw/cYPU6tgtajk7KlSOrM82ga/TBaGE=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=RyMcKKTzrRAqR/m2B1K/w+H87CrTe5YOsg/16TEcQe4Z4SZWDfEtb8wZJwsr+2mshCBe8Vo3LOFMP5g7ZOB9kU31wVowpkbnWnqHcUKHvNPG4KIQAsQrvS0sPNBN8dADueM4DscklZjydUPxbmT8YQIOp2JmOKE22hiUHZ6YsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul+i8Cpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CFBC433F1;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705482224;
	bh=ubf+Lb9lWCl+Bw/cYPU6tgtajk7KlSOrM82ga/TBaGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ul+i8CpzEGX31XDcKOWiMUk/Mx/cPUlWS3k1ZWXNcmO+13+g+43kk7k7zsDou3Jqx
	 2HCVy13ILqrFrpytfP7xQS4Q+s8uzGzVqomaFETJqYRFKTjMvHusVASImqm9CWLX1N
	 HehEQcPMuOqpl8a/ZtW8lbbHdsU/PTb7d1fzDWjHi1fcOqHQlAJLy7IY1eHnJEGtKc
	 uoQ9nmJxOhlhDfMz1RZZ6inqcS/ExtArgXGmWGG5CEgzHiKxkVos9PSHsNPOYpFjOR
	 CzOuBnP7tlysEahDt+IyNQsbzoAVuEK1jjTUo31B9chHBTTutQzmXUQdXj7Gf0Tigb
	 MMXYGK3cBqq+g==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQ1pt-00086U-03;
	Wed, 17 Jan 2024 10:03:49 +0100
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
Subject: [PATCH v2 1/3] ASoC: qcom: sc8280xp: limit speaker volumes
Date: Wed, 17 Jan 2024 10:03:29 +0100
Message-ID: <20240117090331.31111-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117090331.31111-1-johan+linaro@kernel.org>
References: <20240117090331.31111-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current UCM configuration sets the speaker PA volume to 15 dB when
enabling the speakers but this does not prevent the user from increasing
the volume further.

Limit the PA volume to 15 dB in the machine driver to reduce the risk of
speaker damage until we have active speaker protection in place.

Note that this will probably need to be generalised using
machine-specific limits, but a common limit should do for now.

Cc: stable@vger.kernel.org	# 6.5
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/sc8280xp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index ed4bb551bfbb..aa43903421f5 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-		 * set limit of 0dB on Digital Volume for Speakers,
-		 * this can prevent damage of speakers to some extent without
-		 * active speaker protection
+		 * Set limit of 0 dB on Digital Volume and 15 dB on PA Volume
+		 * to reduce the risk of speaker damage until we have active
+		 * speaker protection in place.
 		 */
 		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
 		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 12);
+		snd_soc_limit_volume(card, "SpkrRight PA Volume", 12);
 		break;
 	default:
 		break;
-- 
2.41.0


