Return-Path: <linux-kernel+bounces-144314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E68A447C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9258C2825D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49432136643;
	Sun, 14 Apr 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="AkPOpLs8"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2F1350CC;
	Sun, 14 Apr 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713117201; cv=none; b=eml2OFtQIE2bXe/0yyV+BOxdVBn1x+2jaA1SHvXv1o7awo6vQ0C++f7sH691HVplQ0wND4BMcdiMBhZ/VNeATnP6uEEqg8takNJHIUtjksbYf4V9rSB1PInxF/e9d9iv1n3fX0mVVq+HfgUetMxik0NP/wT/VWZsfcXAHVRmOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713117201; c=relaxed/simple;
	bh=hNwjyUffC95XRThO4O6yfS+WZTIz/IwY5Q/AfIriQEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vjlt+RyYGCvQNLgUH5Bq1SCQkro//2ZOVEhG+0NJ8OsHTe00ogq3X/yZ9vPw1aA94xl9VrM4L0iEpcopcEf0n/ME+K9S0Nc+5+fs8OaQjoAaaUTsWgPrjvKWUhF7ju/N6ExiIF17zEw6cmAEmnM2IUdp7XwVgf+IEZlykry929g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=AkPOpLs8; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 1627547919;
	Sun, 14 Apr 2024 17:53:17 +0000 (UTC)
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
Subject: [PATCH 0/4] iio: light: stk3310: support powering off during suspend
Date: Sun, 14 Apr 2024 13:53:00 -0400
Message-ID: <20240414175300.956243-1-aren@peacevolution.org>
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
	s=dkim; t=1713117198;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=tZiJxZ2AuICTeWkRxY/t4eLoCK/lqF8coOe31qJB5uc=;
	b=AkPOpLs808ZtiKcJa9pz2HuAjlVpX4g8KlIGfQAB66oclE2qRSEVXEAdPokvp0EFUtEP55
	KJ7NxiYJzBhLrdswsvhwdog0bvpYittKiIaPsJv5Zvd/20+90uHj/tpykLItXKtliDkVHB
	FY4m2+3F3qGJbbymyr3VaXOlpVWO3b0=

In the Pine64 PinePhone, the stk3310 chip is powered by a regulator that is
disabled at system boot and can be shut off during suspend. To ensure that
the chip properly initializes, both after boot and suspend, we need to
manage this regulator.

Additionally if the chip is shut off in suspend, we need to make sure that
it gets reinitialized with the same parameters after resume.

Aren Moynihan (2):
  dt-bindings: iio: light: stk33xx: add regulator for vdd supply
  iio: light: stk3310: log error if reading the chip id fails

Ondrej Jirman (2):
  iio: light: stk3310: Implement vdd supply and power it off during
    suspend
  arm64: dts: allwinner: pinephone: Add power supply to stk3311

 .../bindings/iio/light/stk33xx.yaml           |  1 +
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  1 +
 drivers/iio/light/stk3310.c                   | 60 +++++++++++++++++--
 3 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.44.0


