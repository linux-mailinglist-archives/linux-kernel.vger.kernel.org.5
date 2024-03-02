Return-Path: <linux-kernel+bounces-89455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2186F098
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF682283D2C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258F817C79;
	Sat,  2 Mar 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="XcOmshdW"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33348179B7;
	Sat,  2 Mar 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388051; cv=none; b=RVu98FeISx5eywYZhifWG/2gOeedBic9J2QY+IhuqEhuQ6OSPFXXmo4T8uIt7cgIdeOt3eCo5pyl1Z0/Nc+fNAB5J1XcxyUhZSeWNnoZ9TeJ0cHBrApyXqdwgDFwtCYIvtNfn8sRWCq7ylwXDunqxcR4O7xsEKxtqryRepyRIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388051; c=relaxed/simple;
	bh=uiQdKioW5Q8/qfRyAEscHhnKqRIHa/efSN+ljmC4lok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6Fe/PBY7drqVOiNO8F37wnZs/AXmgTrsB2ejxcwiGCok1VwkUpiW1/+CClCXTdp16z3UnxRAIdagiwB2sa6wIITNqBqWR93CeRfT7eO6A15hjIE1Xna8a063KBUUbrFmB9t46iuFMdeRbUOqLB4t4QIoQXucFeTOQ1bDT09SNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=XcOmshdW; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1709388045; bh=uiQdKioW5Q8/qfRyAEscHhnKqRIHa/efSN+ljmC4lok=;
	h=From:To:Cc:Subject:Date:From;
	b=XcOmshdWXvExDVy4K+zxIZF+CaaHhfMsi5Ewmy+e3mozM0igrri0ZlA0bSxdUbRga
	 kjqGrvQnU6QfAwjWqHMtsW4HfwsWF1PRAi/Ao03SEhUo7JdrGlJsUBwtY4iIeE2FCs
	 wv8bpWOwevP5sOG9hxs0c+3O4yvxbjl2a53t7/F8=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
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
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 0/4] Add support for jack detection to codec present in A64 SoC
Date: Sat,  2 Mar 2024 15:00:34 +0100
Message-ID: <20240302140042.1990256-1-megi@xff.cz>
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

The patches are a rewritten and debugged version of the original
ones from Arnaud Ferraris and Samuel Holland, improved to better
handle headset button presses and with more robust plug-in/out
event debouncing, and to use set_jack API instead of sniffing
the sound card widget names, to detect the type of jack connector.

Please take a look. :)

v3:
- removed all device-tree related code
  (it's not necessary for core functionality, it only helps make the jack detect
  functionality of the codec be usable from simple-sound-card driver, and I'll
  send it spearately, because it will apparently need several more rounds
  of review)

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

Samuel Holland (2):
  ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
  ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias

 sound/soc/sunxi/sun50i-codec-analog.c |  73 +++++-
 sound/soc/sunxi/sun8i-codec.c         | 346 +++++++++++++++++++++++++-
 2 files changed, 399 insertions(+), 20 deletions(-)

-- 
2.44.0


