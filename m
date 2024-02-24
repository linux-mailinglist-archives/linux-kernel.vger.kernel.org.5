Return-Path: <linux-kernel+bounces-79692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2325862578
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF6A1C2142C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F864502A;
	Sat, 24 Feb 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="ghV2nPFV"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FD3F9D8;
	Sat, 24 Feb 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782912; cv=none; b=WULfPpypaG+J1Vp+Eun1iYF+Ybd9H4+iD6kV61Ht4ysHDul/t7G1rhb57OQufz77JsvoAtaaEeVotn9Z2fpvSqkqX9Rj7WIYaW719xcwJs/PSbIs8ewvV2BBqm56zyjsTgOshyP7ajxsMC6/qCipo4k3WYqUHLcxB3z0nomja6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782912; c=relaxed/simple;
	bh=ZdTOrLkg/qf7wFKH1nhH7OcmYSUdowUaRsJjf+n31IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dqvOn/VPi9Hnc2fgT5fy26zG/4k9A3GUF6ERlq91wq8H/43v28rbwaSJAmCgLSnx2tYTazBdf6aPvMp5Pr3QpU//4HDAnAxPKWN1q+8KqYD/irrOUhQVyNRrJQXpFyclsGuT3e+MCo98ZFvfX3xocsgk0VNI7xCtUgyYtkmKD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=ghV2nPFV; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708782907; bh=ZdTOrLkg/qf7wFKH1nhH7OcmYSUdowUaRsJjf+n31IQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ghV2nPFVjKO14UGccN3rXpU5361OkGdsnlFc+EPQiEijflmKOSJvXVVnOWqERaLia
	 v8SBR8AvGUndbw/tLtwCjCu9YOR9GSD0/g/k87i40dulFob/BqRh9sn1Qv7W5KbhpD
	 rJArs/+k/ODf+1XKCMRUT/LMNlw7oWZswM53gSVk=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [RESEND PATCH v2 0/5] Add support for jack detection to codec present in A64 SoC
Date: Sat, 24 Feb 2024 14:54:53 +0100
Message-ID: <20240224135501.3822390-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

This series adds support for jack detection to this codec. I used
and tested this on Pinephone. It works quite nicely. I tested it
against Android headset mic button resistor specification.

The patches are improved and debugged version of the original
ones from Arnaud Ferraris and Samuel Holland, imrpoved to better
handle headset button presses and with more robust plug-in/out
event debouncing.

Please take a look. :)

v2:
- use set_jack/get_jack_type
- get rid of some custom poking inside card internals to figure
  out what kind of jack port we should setup the codec for
- read jack-type from OF as suggested here: 
  https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-component.c#L288
- add DT bindings

Thank you very much,
	Ondřej Jirman

Arnaud Ferraris (2):
  ASoC: sun50i-codec-analog: Enable jack detection on startup
  ASoC: sun8i-codec: Implement jack and accessory detection

Ondrej Jirman (1):
  dt-bindings: sound: Add jack-type property to sun8i-a33-codec

Samuel Holland (2):
  ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
  ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias

 .../sound/allwinner,sun8i-a33-codec.yaml      |   9 +
 sound/soc/sunxi/sun50i-codec-analog.c         |  73 +++-
 sound/soc/sunxi/sun8i-codec.c                 | 359 +++++++++++++++++-
 3 files changed, 421 insertions(+), 20 deletions(-)

-- 
2.43.0


