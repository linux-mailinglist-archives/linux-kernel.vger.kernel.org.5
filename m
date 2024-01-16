Return-Path: <linux-kernel+bounces-27193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FF82EBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C99A2813FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA721B803;
	Tue, 16 Jan 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H17B+xkE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC9134A3;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992B4C433B2;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=TlySBWSiIs011eAGAHEWyYI6qGjt/pk2rn1iN0irWl4=;
	h=From:To:Cc:Subject:Date:From;
	b=H17B+xkEGVHEtGKliDYxogZ/iFp93RpvoeyRCC7L/U1116iXZwx/DRwOxAASDVsoC
	 8ikYJKhnMiaL8PzdFETwseq332b3/6CeIz25F9M7VXGVvQelUz7gH11CLshfUzwn5q
	 r7+3bdX9o5WKNZNajjt1eBDxVAFFxXVvffcwzYKvcCZ5bzrhWwzeiA+ynr7nwod5an
	 /lcqcTdH5ms0d658RIBUt0Sa71CDWlk45YZYzkeS0OeinrrwHwR0nq5g2OOHDxVy9S
	 /CU6JdkdYqIXmxJunhEBr03ztRv7UsO2gmYjNgBrMCp2S2Y6kOnpsAUOgnYTj9hFx+
	 aOjuqKhW0uJZA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv5-00053P-1G;
	Tue, 16 Jan 2024 10:39:44 +0100
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
Subject: [PATCH 0/7] ASoC: qcom: volume fixes and codec cleanups
Date: Tue, 16 Jan 2024 10:38:56 +0100
Message-ID: <20240116093903.19403-1-johan+linaro@kernel.org>
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
configuration which most user have so far been been using (due to a bug
in the configuration files which prevented hardware volume control [1]).

Included is also a related fix for the LPASS WSA macro driver, which
was changing the digital gain setting behind the back of user space and
which can result in excessive (or too low) digital gain.

There are further Qualcomm codec driver that appear to manipulate
various gain settings, but on closer inspection this turned out to be
effectively dead code which can be removed.

Johan

[1] https://github.com/alsa-project/alsa-ucm-conf/pull/382


Johan Hovold (7):
  ASoC: qcom: sc8280xp: limit speaker volumes
  ASoC: codecs: lpass-wsa-macro: fix compander volume hack
  ASoC: codecs: lpass-wsa-macro: drop dead mixer-path gain hack
  ASoC: codecs: lpass-rx-macro: drop dead mixer-path gain hack
  ASoC: codecs: wcd9335: drop dead gain hacks
  ASoC: codecs: wcd934x: drop dead gain hacks
  ASoC: codecs: msm8916-wcd-digital: drop dead gain hacks

 sound/soc/codecs/lpass-rx-macro.c      |  16 +---
 sound/soc/codecs/lpass-wsa-macro.c     |  19 +---
 sound/soc/codecs/msm8916-wcd-digital.c |  26 +-----
 sound/soc/codecs/wcd9335.c             | 115 ++++---------------------
 sound/soc/codecs/wcd934x.c             | 102 +++++-----------------
 sound/soc/qcom/sc8280xp.c              |   8 +-
 6 files changed, 53 insertions(+), 233 deletions(-)

-- 
2.41.0


