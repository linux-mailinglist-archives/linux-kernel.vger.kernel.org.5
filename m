Return-Path: <linux-kernel+bounces-155962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1628AFC00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CECA1C22522
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63781F947;
	Tue, 23 Apr 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="UbPW8/Oo"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED11E898;
	Tue, 23 Apr 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912079; cv=none; b=klBn0/JGfFLGGKBeLUfprQJMWBAstaxGpGfLE3lR4xqQI2gtJi03ofVqyEkHuDxcbmi2of4vZVKCMA9bi5HMLm7Qvfq1dGIQ5iSikNBrYk7gZtSDaJpYYXDCSXqhEpn4lit/S4+fl67LznMWnRUOcbkx/LIuBllO3cMYVUYTq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912079; c=relaxed/simple;
	bh=VgV+qCaKdW6B3jmUvzPURLXsRQqGq9RRxeY0w6UalFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsGt1YDqPBH5scMb+JItP2nyrkevQ4RIFuFdEEZ5FMpKu/+XFANzcgSEWp8POXee9aqui2q3M00ZGZxUJaF2fCKKtQ4fQXi1BFgi5bAY4DZTIatxk0fgPSrgOzZGec3Vd5DG/HmV9Z7H2uIkFWv0kIv+UHgIsYqrTdWPSp7Dymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=UbPW8/Oo; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 5E54147A02;
	Tue, 23 Apr 2024 22:41:08 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Willow Barraco <contact@willowbarraco.fr>
Subject: [PATCH v2 0/6] iio: light: stk3310: support powering off during suspend
Date: Tue, 23 Apr 2024 18:33:03 -0400
Message-ID: <20240423223309.1468198-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713912069;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=a7PU4WDv6YB/7pbWHelv2hIhCcSRKNyFO0apkn1vY0U=;
	b=UbPW8/OogtAEjAnzCYyz7x4fhb0ccUmtFHS+FaUiEgQl2dvZqlxDNioLZAlOQdMLH11n0O
	3mmaOoPG+U68t1SVf2nsljrqSyC4FkdDksSU+a9Dfg7I1+WT6swV830ha0br1xEmKE2hDX
	EwF8D+s1kB33T4XVo6C3ICNK0XqKsEs=

In the Pine64 PinePhone, the stk3310 chip is powered by a regulator that is
disabled at system boot and can be shut off during suspend. To ensure that
the chip properly initializes, both after boot and suspend, we need to
manage this regulator.

Additionally if the chip is shut off in suspend, we need to make sure that
it gets reinitialized with the same parameters after resume.

Major changes in v2:
 - Add handling of the IR LED. I was hesitant to include this as it is the
   same as pull-up regulator for the i2c bus on the hardware I have, so I
   can't test it well. I think leaving it out is more likely to cause
   issues than including it.
 - Convert stk3310 to use dev_err_probe for errors.
 - Always enable / disable regulators and rely on dummy devices if they're
   not specified.
 - more listed in individual patches

Aren Moynihan (4):
  dt-bindings: iio: light: stk33xx: add vdd and leda regulators
  iio: light: stk3310: Manage LED power supply
  iio: light: stk3310: use dev_err_probe where possible
  iio: light: stk3310: log error if reading the chip id fails

Ondrej Jirman (2):
  iio: light: stk3310: Implement vdd supply and power it off during
    suspend
  arm64: dts: allwinner: pinephone: Add power supplies to stk3311

 .../bindings/iio/light/stk33xx.yaml           |   4 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |   2 +
 drivers/iio/light/stk3310.c                   | 116 +++++++++++++-----
 3 files changed, 94 insertions(+), 28 deletions(-)

-- 
2.44.0


