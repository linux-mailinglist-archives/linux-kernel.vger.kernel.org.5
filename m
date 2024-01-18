Return-Path: <linux-kernel+bounces-30381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E5831E04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB44CB265EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50C2D02F;
	Thu, 18 Jan 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPgJBKI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B02C6AC;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597106; cv=none; b=flB/G2foO/peOq4Sy9gcAWwoLKl3qk4gbGcwKm68KwlfJVImUkOJ09g1JCyoM83HCNLxWtyowvyAe0KdMs/M+/2EslZwahZ61f2amxKusNWRVJJzoqRfL281kta4fXQi5b3ClzPy7/uIC4D+QhdgOHaENYKTKvsB7xGH5/loCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597106; c=relaxed/simple;
	bh=pMxi0aeP/TUeEOvaFIlff/maw++Dj2oPNVtTO/j244Y=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=EDsOk5sWnd4WZkWotTDgOugJ0DqHAvylpuTt0b7KRYcpfVZ1yXKC57hGCuSc4d3RObRg4KSuSGPLKlJrP5zDbXTrf7weW57vjZQGQod2jrqhMWRiEgiKUdmXs5KVbHX/VY4hqCVPId8Y3dL9OzNZ5BWKvH7lrsMfksdV7Zd51j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPgJBKI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0278C43394;
	Thu, 18 Jan 2024 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597105;
	bh=pMxi0aeP/TUeEOvaFIlff/maw++Dj2oPNVtTO/j244Y=;
	h=From:To:Cc:Subject:Date:From;
	b=vPgJBKI0B1DZ+4T4gk8K+UprLod1TfKqRIQahsZL6hQAN3q7qOdUeD/4nvXroDbYI
	 foqlTL6LGtQ6zIFmkpO8To+1pGZX5kRE5pa7Z56mVicVSTdz8tBztqSff4P10cWoo1
	 zk2y9qIoqbsuMioby2HmqKkcbULewuj+gcHWz+sz7IWunZiHqeY02KZtKw7NYG1sF2
	 5g/QM02Q3hVWssiEs8Kpk9s2cWEYCLtE2N0tJb7Uo3LuGKChXSTu/28HeNzOvJXFHS
	 6AVUl27x6gbXfURGorrG+cc4LZNBmweWq5IeD6vXDTakDm7bPwK9mpgam0jZsEEIbg
	 MnJmi4gp3hAUA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQViq-0003Yw-2Q;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/5] ASoC: qcom: volume fixes and codec cleanups
Date: Thu, 18 Jan 2024 17:58:06 +0100
Message-ID: <20240118165811.13672-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce the risk of speaker damage the PA gain needs to be limited on
machines like the Lenovo Thinkpad X13s until we have active speaker
protection in place.

Limit the gain to the current default setting provided by the UCM
configuration which most user have so far been using (due to a bug in
the configuration files which prevented hardware volume control [1]).

The wsa883x PA volume control also turned out to be broken, which meant
that the default setting used by UCM configuration is actually the
lowest level (-3 dB). With the codec driver fixed, hardware volume
control also works as expected once we lift the PA volume limit.

Note that the new wsa884x driver most likely suffers from a similar bug,
I'll send a fix for that once I've got that confirmed.

Included is also a related fix for the LPASS WSA macro driver, which
was changing the digital gain setting behind the back of user space and
which can result in excessive (or too low) digital gain.

There are further Qualcomm codec drivers that similarly appear to
manipulate various gain settings, but on closer inspection it turns out
that they only write back the current settings. Tests reveal that these
writes are indeed needed for any prior updates to take effect (at least
for the WSA and RX macros).

Johan

[1] https://github.com/alsa-project/alsa-ucm-conf/pull/382


Changes in v3
 - fix the wsa883x PA volume control and update the machine limits
   accordingly

Changes in v2
 - keep the volume register write on power-on in lpass-wsa-macro
 - drop the other patches removing volume register writes on DAPM events
 - only drop the constant-zero gain offsets in wcd9335


Johan Hovold (5):
  ASoC: codecs: wsa883x: fix PA volume control
  ASoC: codecs: wsa883x: lower default PA gain
  ASoC: qcom: sc8280xp: limit speaker volumes
  ASoC: codecs: lpass-wsa-macro: fix compander volume hack
  ASoC: codecs: wcd9335: drop unused gain hack remnant

 sound/soc/codecs/lpass-wsa-macro.c | 7 -------
 sound/soc/codecs/wcd9335.c         | 4 ----
 sound/soc/codecs/wsa883x.c         | 6 +++---
 sound/soc/qcom/sc8280xp.c          | 8 +++++---
 4 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.41.0


