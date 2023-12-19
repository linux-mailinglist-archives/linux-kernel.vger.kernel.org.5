Return-Path: <linux-kernel+bounces-5234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79D818853
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2249B2338A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3F18E2A;
	Tue, 19 Dec 2023 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="dgf6C1Gr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928B18B1A;
	Tue, 19 Dec 2023 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id AACBE28B50B;
	Tue, 19 Dec 2023 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1702990960;
	bh=gJA42YDJdYMWkvXyCpe8XTujDQq2PuvcPW8OK1AOu28=;
	h=From:To:Cc:Subject:Date;
	b=dgf6C1GrIrowzN8hRMuQBbwFp2LWllvqbB2odKV+vZDAXZn1iOtMip0aEYEIXrIzP
	 TJMs9JKicPt/YtpLHdJVTQJuwev3fe+X/8Y5euioBJk1S5+UFYK4A0YrBV6Oq5/THq
	 mpBbdWNo5OgeyPWd6qjwvdcO4uDWt+cxkT61m3fk=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 0/2] iio: pressure: changes to mprls0025pa
Date: Tue, 19 Dec 2023 15:02:19 +0200
Message-ID: <20231219130230.32584-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ChangeLog
 - rewrite flow so that driver can use either i2c or spi as communication bus
 - add spi driver (tested on MPRLS0015PA0000SA)
 - add pressure-triplet property that automatically sets pmin, pmax
 - fix transfer-function enum typo based on previous review [1]
 - fix interrupt example in binding file (FALLING -> RISING edge)
 - indentation changes based on previous code reviews
 - renamed mpr_read_pressure to mpr_read_conversion since the sensor is
   supposed to also provide temperature measuremets
   (but I think mine is broken since the raw temperature value is always
   0x800000 - so temp reading not currently implemented)

patch uses device_property_match_property_string() from the 'togreg' branch

[1]: https://lore.kernel.org/lkml/20231116-grudge-hankering-b7a71d831b93@squawk/T/

Petre Rodan (2):
  dt-bindings: iio: pressure: change honeywell,mprls0025pa
  iio: pressure: change driver for Honeywell MPR series

 .../iio/pressure/honeywell,mprls0025pa.yaml   |  60 ++-
 MAINTAINERS                                   |   3 +-
 drivers/iio/pressure/Kconfig                  |  14 +-
 drivers/iio/pressure/Makefile                 |   2 +
 drivers/iio/pressure/mprls0025pa.c            | 353 +++++++++---------
 drivers/iio/pressure/mprls0025pa.h            | 103 +++++
 drivers/iio/pressure/mprls0025pa_i2c.c        |  76 ++++
 drivers/iio/pressure/mprls0025pa_spi.c        |  67 ++++
 8 files changed, 491 insertions(+), 187 deletions(-)
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c

-- 
2.41.0


