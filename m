Return-Path: <linux-kernel+bounces-33959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FD8370E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A7293155
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52947F44;
	Mon, 22 Jan 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+9POOsO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB403DBAB;
	Mon, 22 Jan 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947508; cv=none; b=eymvS3bEDGni/SRDK8wLV/2Ub9xPT9G+XZxYqE+kfkeoCOjanVH9WL83ihOYnERio3AWBJntLozDKbHIT1Wt/FezPlbsC0umdxyiUck31di8L6wobdb2CCZbMlajEKVevyYPkXdm8ZoTbOFi8uxxh/+EkQC64rq5AZLw0PeFAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947508; c=relaxed/simple;
	bh=7miscXNSOMprQJwxQIJJr4/Ytf2DqWNxzA6Kigr9MWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csIR0UzzsXvqmIIAXPdM/4hpUs4NwgcnGpaJkBDBeMT/CJJOqyR+wX6BiIALSq2AVfdK6FLCv9tEK9d8eZrIqEGG0a/2m7NFf4VW2rKsy/wVbJoNBQQs4zodx2MdXBui0NID3qNeaXO2uUX95D1Azr6c8DqRvpz/9tVZoHUjRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+9POOsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CCDC43390;
	Mon, 22 Jan 2024 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947507;
	bh=7miscXNSOMprQJwxQIJJr4/Ytf2DqWNxzA6Kigr9MWg=;
	h=From:To:Cc:Subject:Date:From;
	b=b+9POOsOeQjtUvXuCNigCJf2HSOkXYPLOWg/HE+CRt/c26e2TW5wTHa4FHl3M4tIf
	 e46SSMKSvD4XGNYdTCsa0Qwkoi8jpOAqd+VRud/WfsEGwMS/x3j8+XP/cVVyEVZJ/6
	 GG+ICMsaaw3YL0alwVkUEI8wt/Jt9vOmVZyEoiK3tvE1dZCI4pEFnLWxja/juLRnhS
	 YhZ+IVRQVXhpNt/urMtl5gPV8++M8rx6SBMrsMcWBC7HsVZif7u6Sp7gtCgtDxQPdL
	 z0+yDXOKMbZ6roSrUO6wYmyb421yoIpQataUcPoo1JveBaQ9QFsXVCYAaq5FTthQf/
	 0D33ILfewDsBg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rRysa-0000000013R-12Hg;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v5 0/4] ASoC: qcom: volume fixes and codec cleanups
Date: Mon, 22 Jan 2024 19:18:15 +0100
Message-ID: <20240122181819.4038-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
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


Changes in v5
 - rebase on v6.8-rc1 

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
2.43.0


