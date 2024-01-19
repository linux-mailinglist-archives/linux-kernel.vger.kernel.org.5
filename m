Return-Path: <linux-kernel+bounces-31090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A484E8328BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5441F23B45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B14D10D;
	Fri, 19 Jan 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGfAHRBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91D4CB45;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663615; cv=none; b=FZXWoIIEz8+u1mLoQcdOMa18HQNYzN5geheifyFRmFViNnzrimSjfEPO9adMEXityl7XarBMILf+d5OuAf/KFWgNODYKEXkIDnj2HIq1A1LIFMtbzxATEw3gMkuf/GkPMaa/hHEVEnmpRSQYj2sh+2BS2rkWkYQuRCxzS7OVAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663615; c=relaxed/simple;
	bh=y9EPfighvp9gn9o7ZscqDXm0oHny+oVmp15fgxEog1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dfy9NTTV4L20o+O2GWeiMXxlfAc5630jE9V/3zf5neDk5rqUzZCEHD+EXCJWFfBluFvXOdIHU+alJBavCfRh9cEyYFYUpxVq1UW/ZjV8RFzXm5U3kkDLygh4bjAmAKeAlAqjkh3Bn7M5M3rX3pOaIj6N3IhBrxE21AXR0UmXrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGfAHRBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206BCC43399;
	Fri, 19 Jan 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705663615;
	bh=y9EPfighvp9gn9o7ZscqDXm0oHny+oVmp15fgxEog1o=;
	h=From:To:Cc:Subject:Date:From;
	b=gGfAHRBx8Lb62/FK3+Fx3zmG65nnbsJABDrtacTayzigkckOAOcxVq1QvX5Hekq3d
	 4v0DqHZtGqUfeKnO5JBP19sPunVQsO8jA6Q5arFCQoyfofZzuBdShLTU7ATW7eJSVk
	 UzLP4o5WAVioJ5arXvwGiGs/B2e42g7mb4fnkDFGC/8XDoeyFZkZWresnJ51PXY90R
	 Fk+XJgJxvLZYXhtvlyosF/zVbaAG3kB8O0+hSyKAkhGbdYUQ7DGvb3lq2+liGcmPP4
	 RISQV/JDq2EsVlIFLPX20S8pXuxC1eA8gJ7Tlq6G7hrEFMxHv0isBdD9TmPRmvZ4hV
	 VB098w5sX7qXA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQn1b-0001xH-08;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Date: Fri, 19 Jan 2024 12:24:16 +0100
Message-ID: <20240119112420.7446-1-johan+linaro@kernel.org>
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
control also works as expected.

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


Changes in v4
 - keep the full PA volume control range and only fix the exported dB
   values
 - use a combined -3 dB machine limit as limiting just the PA volume
   confuses PulseAudio
 - drop the PA gain initialisation which is no longer needed

Changes in v3
 - fix the wsa883x PA volume control and update the machine limits
   accordingly

Changes in v2
 - keep the volume register write on power-on in lpass-wsa-macro
 - drop the other patches removing volume register writes on DAPM events
 - only drop the constant-zero gain offsets in wcd9335


Johan Hovold (4):
  ASoC: codecs: wsa883x: fix PA volume control
  ASoC: qcom: sc8280xp: limit speaker volumes
  ASoC: codecs: lpass-wsa-macro: fix compander volume hack
  ASoC: codecs: wcd9335: drop unused gain hack remnant

 sound/soc/codecs/lpass-wsa-macro.c |  7 -------
 sound/soc/codecs/wcd9335.c         |  4 ----
 sound/soc/codecs/wsa883x.c         |  6 +++++-
 sound/soc/qcom/sc8280xp.c          | 12 +++++++-----
 4 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.41.0


