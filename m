Return-Path: <linux-kernel+bounces-30385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D866831E03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029811F21301
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153D2D036;
	Thu, 18 Jan 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaopBlRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E42C6AE;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597106; cv=none; b=fpp4M4kYYpEhDCLY5GvPRs3Cgkdd9XM+xfxFcrnBDoSyXoQOGGW2FLQKgHfkGoInfduTemC5NAw86aLo1VaqZj3aQ7pJjTNkVKP9VHH1yhZ2t945V492AIwQOR8bS07CPJMuzCpI9pvJhVEfOxWy0bmIYgixlaZpF7a5owse67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597106; c=relaxed/simple;
	bh=VB3r36g1TRzb+ZnbcM0huvM7RrOa7bcVG6ouX9BQqJA=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=O+xWeItNq8pJozdSMZarpv78olXlHUk9qwDrLEGFqgk69cnbK/xFDza/C+zxncdKgov/mFs1Q9PbDCYI/++WuP9DevKfWxANhpD2lybRcpZ7F1kA0hgiBMwO5o6i00HaGGE8Sjjnbfsi5mIPd+aDxnqJCRGbk3ESCMVT0QEytvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaopBlRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FDEC43390;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597105;
	bh=VB3r36g1TRzb+ZnbcM0huvM7RrOa7bcVG6ouX9BQqJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaopBlRHiCrC8zCeZp67HFQyNRiRgFzPECgJWdw8s18TdyRTNbsl2RO/26CPvhC8Q
	 1f+ALwq2Z5yJg79gFKKhAF4BBYC1Ef9RLD7NKPWKHpYJTXo4p3EhwKyV2xgWjS4a/S
	 5sscBlUUHPo/9iPuR2X0ehW7E10ESQuI9EbakUQ0ip2bY0GJeDcPbzfz2QS5K064HB
	 rM8O6/SiwgTwLXvzMXt/hYsb09g+mBcvYw1n1txszMEx2I+0Gq0uuxmvmqgx9n1pdm
	 BZm6SJ80h27wmzK6OHXn43VIZkQLcUXAKn14gFpUSTwBIAbShIe/skwOxSBufY8r7u
	 NtSEMTQS7lapQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQVir-0003Z2-2R;
	Thu, 18 Jan 2024 17:58:33 +0100
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
Subject: [PATCH v3 3/5] ASoC: qcom: sc8280xp: limit speaker volumes
Date: Thu, 18 Jan 2024 17:58:09 +0100
Message-ID: <20240118165811.13672-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118165811.13672-1-johan+linaro@kernel.org>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UCM configuration for the Lenovo ThinkPad X13s has up until now
been setting the speaker PA volume to -3 dB when enabling the speakers,
but this does not prevent the user from increasing the volume further.

Limit the PA volume to -3 dB in the machine driver to reduce the risk of
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
index ed4bb551bfbb..a19bfa354af8 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-		 * set limit of 0dB on Digital Volume for Speakers,
-		 * this can prevent damage of speakers to some extent without
-		 * active speaker protection
+		 * Set limit of 0 dB on Digital Volume and -3 dB on PA Volume
+		 * to reduce the risk of speaker damage until we have active
+		 * speaker protection in place.
 		 */
 		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
 		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
+		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 1);
+		snd_soc_limit_volume(card, "SpkrRight PA Volume", 1);
 		break;
 	default:
 		break;
-- 
2.41.0


