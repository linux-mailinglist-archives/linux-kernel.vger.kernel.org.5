Return-Path: <linux-kernel+bounces-13030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F381FEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585AC1F2119B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335D1173B;
	Fri, 29 Dec 2023 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="fYzLmYvI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48810A01;
	Fri, 29 Dec 2023 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 5F8E828B50B;
	Fri, 29 Dec 2023 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841905;
	bh=Xii80BZilbcTZ+e6K1vQw1brFErvXXiWZ9Qzq2HxA+w=;
	h=From:To:Cc:Subject:Date;
	b=fYzLmYvIS4P8M71zP2/H6/5wEEy1ph5gOS2L0bmSsXeZ+Yw1fXfnCDNquRbncXpAf
	 21p4D1eiIWEmQpdoeY7G7N22+WWqnj3COhbncmybPl1Ab5EtVHmrFLrrurpu6IxNRc
	 HbJrBRfOIQuPSiDmJNcjnuLwIs0Wgu3EKQiXqQg4=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH v3 00/10] changes to mprls0025pa
Date: Fri, 29 Dec 2023 11:24:28 +0200
Message-ID: <20231229092445.30180-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of fixes to the mprls0025pa driver:
 - an off-by-one initially caused by a typo in the bindings file
 - two error fields are never checked during sensor interaction
 - unsafe initialization if the driver is instantiated via sysfs
   and the bindings are missing

Quality of life changes:
 - a refactor that adds a pressure-triplet property which initializes
pmin-pascal and pmax-pascal just like in the hsc030pa driver.
The user only needs to extract a short string from the chip name
instead of looking up the chip in the datasheet, understand the
nomenclature, extract the measurement range and then convert all units
to pascals.

New feature:
 - SPI compatibility for Honeywell MPR sensors that require it.

Both binding and driver are backwards compatible.
Tested in I2C and SPI modes with two different sensors.
The refactor requires property function present in the togreg branch.

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Petre Rodan (10):
  dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml improvements
  dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add
    pressure-triplet
  dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
  iio: pressure: mprls0025pa fix off-by-one enum
  iio: pressure: mprls0025pa improve driver error resilience
  iio: pressure: mprls0025pa remove defaults
  iio: pressure: mprls0025pa whitespace cleanup
  iio: pressure: mprls0025pa refactor
  iio: pressure: mprls0025pa add triplet property
  iio: pressure: mprls0025pa add SPI driver

 .../iio/pressure/honeywell,mprls0025pa.yaml   |  98 ++++--
 MAINTAINERS                                   |   3 +-
 drivers/iio/pressure/Kconfig                  |  14 +-
 drivers/iio/pressure/Makefile                 |   2 +
 drivers/iio/pressure/mprls0025pa.c            | 313 +++++++++---------
 drivers/iio/pressure/mprls0025pa.h            | 102 ++++++
 drivers/iio/pressure/mprls0025pa_i2c.c        |  98 ++++++
 drivers/iio/pressure/mprls0025pa_spi.c        |  89 +++++
 8 files changed, 542 insertions(+), 177 deletions(-)
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c

--
2.41.0


