Return-Path: <linux-kernel+bounces-28685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B98301D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77CA1F24CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1114276;
	Wed, 17 Jan 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrhpPRAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B413FFF;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482224; cv=none; b=auiSn3WmbR3x2k3Wdpn2gKb5SrWSM+OFCCsDFoNn9Xn3xfIUIgmvXohHQEJFHedqUJIiRgEVHJBd1IhuPtMP+MRG9NTIX9w5CISFJZQ306dIcoe/MKe018rKbNfITd4k9hG6+0nWDxFh/OsQD0IntNa/6grCQvIp/Jb0XNBRksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482224; c=relaxed/simple;
	bh=i17ld0NFQa97QFBuw7o/jqfRb7C6LLoCeBGe1hJFLPM=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=B4AfLHK/N19MFm5qdtF3IBXeOVY7H+L1Pxru3JtgZQUpQaGyXvYB6zxMAOwt4tXa9PNv7+y1cpQ0nmD0/CM4AfR7U6iSieg8Jp5McmYCN0/HnaTzl6LDGkEGRb+j6JNRiTcLagaM2uAjvFhvCaNS1DTZJA3seTFD7kiZ8ENufT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrhpPRAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9E2C433C7;
	Wed, 17 Jan 2024 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705482224;
	bh=i17ld0NFQa97QFBuw7o/jqfRb7C6LLoCeBGe1hJFLPM=;
	h=From:To:Cc:Subject:Date:From;
	b=QrhpPRAYqKWIICjhvW+fdF36XLDjkM4tFHkyUpHf8lWZXG54jx90HhGsHVzbXbYwF
	 G+LEa/vv4cI9poRBs8Lj4IpZfOSW6etkZA7ZHuqOFY7DOuX7T9OcxiLeEA3v6fC76B
	 JhBsjOCR8ruvuUREs3USjx4j9DqymyXj+QW5iwzQDQ2wI4GLAt9fmzWYGAaMu8zJoq
	 YjQDNL33u2o0usRIxt/T+E31cE0wJkOH8XeHJJH39pXdzlFn44dikF8g5VQRBKjjVB
	 rQg0L2esBMDKlgP6P9Aguzn89nnxHqpwiJJsEHFsE/Z8rRw1yemyil11YmYc1gZPNT
	 6z41o7oyF9N6w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rQ1ps-00086S-2s;
	Wed, 17 Jan 2024 10:03:48 +0100
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
Subject: [PATCH v2 0/3] ASoC: qcom: volume fixes and codec cleanups
Date: Wed, 17 Jan 2024 10:03:28 +0100
Message-ID: <20240117090331.31111-1-johan+linaro@kernel.org>
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


Changes in v2
 - keep the volume register write on power-on in lpass-wsa-macro
 - drop the other patches removing volume register writes on DAPM events
 - only drop the constant-zero gain offsets in wcd9335
   

Johan Hovold (3):
  ASoC: qcom: sc8280xp: limit speaker volumes
  ASoC: codecs: lpass-wsa-macro: fix compander volume hack
  ASoC: codecs: wcd9335: drop unused gain hack remnant

 sound/soc/codecs/lpass-wsa-macro.c | 7 -------
 sound/soc/codecs/wcd9335.c         | 4 ----
 sound/soc/qcom/sc8280xp.c          | 8 +++++---
 3 files changed, 5 insertions(+), 14 deletions(-)

-- 
2.41.0


