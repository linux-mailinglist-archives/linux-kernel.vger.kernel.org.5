Return-Path: <linux-kernel+bounces-10722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033D81DAE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEDA1F21826
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123586AA4;
	Sun, 24 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="CY3FYb8H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE017D4;
	Sun, 24 Dec 2023 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8884328B50B;
	Sun, 24 Dec 2023 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428509;
	bh=rU5rJIlWYqtR3hpWn2InZL28bds4hYMdaN1vzUK5cI4=;
	h=From:To:Cc:Subject:Date;
	b=CY3FYb8HD1l8++KedRhHcguTPCPYqNWnFxuIAwXoriaBsaiPPOyaf6KmB2hq62EUz
	 wUaAJTfYb0gPB0/96czMT92dqGeU5vyFkX0Fxp34nqsqc68rbTRzK+4cbl/8cWzMOW
	 9OJrjzCjrcg1dSgXphAI+cxEZN3DzevKKkMGp3HU=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/10] changes to mprls0025pa
Date: Sun, 24 Dec 2023 16:34:45 +0200
Message-ID: <20231224143500.10940-1-petre.rodan@subdimension.ro>
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
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
Petre Rodan (10):
  dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml fix
  dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add
    pressure-triplet
  dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml add spi bus
  iio: pressure: mprls0025pa.c fix off-by-one enum
  iio: pressure: mprls0025pa.c fix error flag check
  iio: pressure: mprls0025pa.c remove dangerous defaults
  iio: pressure: mprls0025pa.c whitespace cleanup
  iio: pressure: mprls0025pa.c refactor
  iio: pressure: mprls0025pa.c add triplet property
  iio: pressure: mprls0025pa.c add SPI driver

 .../iio/pressure/honeywell,mprls0025pa.yaml   |  97 ++++--
 MAINTAINERS                                   |   3 +-
 drivers/iio/pressure/Kconfig                  |  14 +-
 drivers/iio/pressure/Makefile                 |   2 +
 drivers/iio/pressure/mprls0025pa.c            | 308 +++++++++---------
 drivers/iio/pressure/mprls0025pa.h            | 100 ++++++
 drivers/iio/pressure/mprls0025pa_i2c.c        |  98 ++++++
 drivers/iio/pressure/mprls0025pa_spi.c        |  91 ++++++
 8 files changed, 539 insertions(+), 174 deletions(-)
 create mode 100644 drivers/iio/pressure/mprls0025pa.h
 create mode 100644 drivers/iio/pressure/mprls0025pa_i2c.c
 create mode 100644 drivers/iio/pressure/mprls0025pa_spi.c

--
2.41.0


