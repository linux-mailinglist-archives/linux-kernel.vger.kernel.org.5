Return-Path: <linux-kernel+bounces-60651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB6885080E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF891F22A66
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35E64642A;
	Sun, 11 Feb 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="DpyzAk8s"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482D405CF;
	Sun, 11 Feb 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707638219; cv=none; b=Oj7M/T4adLvB8DKm60tdjvR0imR6nTAoaFxcsLj9PFGi1+qZj61aEDkrRIm1qSZtESxxOMOAypAqYwL768NyBOzQQ61k0M0vayKUoabMDGkId7NsxnGFyWcgffJgVI+QQyEw3FJTBskisKp3HmHN40ojdYPDbckS5ovVubD5adE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707638219; c=relaxed/simple;
	bh=d98B/1OhdbB3vkSkyG9Of1gi32FohGfyx7FMeoVF/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chB0R/5C95pqRk49SgwtfeiBneaZXzFYe78FU/azJUBL9OUSEiTAYCpx/yh6hKYs36L3iNvmLjDoW8+yxRKj4DmNY3rsDOhwL0qPBwU4OZEIo+6bji5AanMcC1LzIFadiwfr9KiwQVrxgdb9M3Cs1hpnQSdLZpAsIy95IuS2bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=DpyzAk8s; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.101.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6E8D2331874;
	Sun, 11 Feb 2024 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1707638208;
	bh=d98B/1OhdbB3vkSkyG9Of1gi32FohGfyx7FMeoVF/ss=;
	h=From:To:Cc:Subject:Date;
	b=DpyzAk8s/R3Y+QnsZm8Ks/ugedGi2ZxlhmyPA300szirop4vojN66QVE7VxnGongV
	 497AOmeQUUVApAPkprISbMRbU3K04LqJ8j8wQ9OyPifjYXPYqXukXC/W0XFXNo5b5U
	 eqSeBRPPJXPTKwXrZ8a7Wz4myzCyiw1cOctereFw=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 0/6] iio: pressure: hsc030pa: cleanup and triggered buffer
Date: Sun, 11 Feb 2024 09:56:31 +0200
Message-ID: <20240211075645.28777-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches covers the following:

 - small cleanup
 - mandatory 2ms delay between readings
 - support for triggered buffer readings

The support for devices that have "sleep mode" factory option that was
present in v1 of this patchset was removed, for a few reasons:

 - a Honeywell employee told me that this chip variant is extremely
    unlikely to be found in the wild, which also makes testing the
    driver functionality impossible
 - I found no reliable way of generating i2c/spi bus traffic with no
    payload (toggle CS for SPI case, send i2c packet containing only
    the address byte) that are required for the wakeup sequence.

Petre Rodan (6):
  dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
  iio: pressure: hsc030pa: use signed type to hold div_64() result
  iio: pressure: hsc030pa: include cleanup
  iio: pressure: hsc030pa: update datasheet URLs
  iio: pressure: hsc030pa add mandatory delay
  iio: pressure: hsc030pa add triggered buffer

 .../iio/pressure/honeywell,hsc030pa.yaml      |  3 ++
 drivers/iio/pressure/Kconfig                  |  2 +
 drivers/iio/pressure/hsc030pa.c               | 49 ++++++++++++++++++-
 drivers/iio/pressure/hsc030pa.h               |  7 +++
 drivers/iio/pressure/hsc030pa_i2c.c           |  9 +++-
 drivers/iio/pressure/hsc030pa_spi.c           |  7 ++-
 6 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.43.0


