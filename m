Return-Path: <linux-kernel+bounces-30383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BEA831E02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E002A1C229B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA92D033;
	Thu, 18 Jan 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSLp7lP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D62C1BD;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597106; cv=none; b=XlRCm4wBRQFaeTJgmploynDAHCaIKnlkJSNTdVFo61G9/mrwMmOVugItxpJ7JvznGJVL63nlqeb/3bIN82VZOc62vOtTSq1SmUOqqsacWssT4JzJYtP88Z9O2r5YdaCXP7kMPh4OO0CDv3wwBw1tJPPWPjahk6+EnUrtlcWQrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597106; c=relaxed/simple;
	bh=j++VE3yyl/3Aq6hN2lI/I5Lv3fNUZ9f2+8EY9q5HghQ=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=oWnl9dzwyTJwXs371qVreHQvu/pkTEkzHljrms5/af7rDGG6zNR8TRCSF0e87zPFl1++TtwBXtRHyTbza9JjrLSwACTfra/D1VatCQXg8vC3PGh71HIa1OngWW2GGhDiRiuzwSVuyyQRnwm4Rjq+hZjHidrTt+gTpOBrDvwhroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSLp7lP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEFFC433C7;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597105;
	bh=j++VE3yyl/3Aq6hN2lI/I5Lv3fNUZ9f2+8EY9q5HghQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSLp7lP+yt2+TNDtjYwQo3EhajRF3UyEJl8Qt1EyujY64k5U+PZVx5JcOKgBs+35j
	 6n3xNowULaMqLpw5e66YN3REKKMbwnPoceprkwxWR18V4gXCc8z3+DYZClyIIHNX/9
	 CejlplkAfn1oKeq2i3MofOS4s4MMM2K9dhViBL7eiziFiW+DbnxgIN/W4SnItWKGzU
	 1D00ayoUHdNqDpTBxrzzT7o34mt6DRlKEvYW5kzNfpCuVdvss2jiLNZGZcNPlj7Hgj
	 NcuDaBV7sw7h52cu8Zg+kq1ou4oStn41Bh8sbtJqOj1cMENM3ZQwzLAp4aEyaBiPvU
	 9COmIaQoyDZfw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQVir-0003Yy-1q;
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
Subject: [PATCH v3 1/5] ASoC: codecs: wsa883x: fix PA volume control
Date: Thu, 18 Jan 2024 17:58:07 +0100
Message-ID: <20240118165811.13672-2-johan+linaro@kernel.org>
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

The PA gain can be set in steps of 1.5 dB from -3 dB to 18 dB, that is,
in fifteen levels.

Fix the range of the PA volume control to avoid having the first
sixteen levels all map to -3 dB.

Note that level 0 (-3 dB) does not mute the PA so the mute flag should
also not be set.

Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets and map")
Cc: stable@vger.kernel.org      # 6.0
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wsa883x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index cb83c569e18d..32983ca9afba 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1098,7 +1098,7 @@ static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, -300);
+static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, 0);
 
 static int wsa883x_get_swr_port(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
@@ -1239,7 +1239,7 @@ static const struct snd_soc_dapm_widget wsa883x_dapm_widgets[] = {
 
 static const struct snd_kcontrol_new wsa883x_snd_controls[] = {
 	SOC_SINGLE_RANGE_TLV("PA Volume", WSA883X_DRE_CTL_1, 1,
-			     0x0, 0x1f, 1, pa_gain),
+			     0x1, 0xf, 1, pa_gain),
 	SOC_ENUM_EXT("WSA MODE", wsa_dev_mode_enum,
 		     wsa_dev_mode_get, wsa_dev_mode_put),
 	SOC_SINGLE_EXT("COMP Offset", SND_SOC_NOPM, 0, 4, 0,
-- 
2.41.0


