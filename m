Return-Path: <linux-kernel+bounces-22623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5B82A090
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDC81F236C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773C44D596;
	Wed, 10 Jan 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILk24ohP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D454D58A;
	Wed, 10 Jan 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tcX1TVBcvHCR/hSiJ/UO3rgtAKlxv9gVs4p6mnL27RM=; b=ILk24ohPtoKG+gbVdT5nsE/Wo8
	GhgwgtFNF1/E+jts2pKwHubQGXp3sDrffo/i72goXPuWxABbK0WKAc5ZXd+Ri/ujdNQxBm9llttBZ
	2Lnae0EnNtPgl9GZUKVKmy/OY8ip8xq8kWSHETmtPtY7c/RWZZQ2FNJi49uxQFNjQbcuOs5YPvhzd
	J6ObgEK0SC5Rd/EQQMqH9tHLkRlcG/4iEH+JBdtjlR8hAvEG4JBKWVcFIZgv5f72GTPVtkiEOJ1DC
	yKoqDLPZD+nnEyYY2YrqYIomYBx5VXig0vllJzJZ7FqTFQb2k2rFqI4GStiehwklKtSKhgR6jslCr
	dov/vfTA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNdkK-00DYXn-0r;
	Wed, 10 Jan 2024 18:56:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrea Merello <andrea.merello@iit.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: bno055: serdev requires REGMAP
Date: Wed, 10 Jan 2024 10:56:11 -0800
Message-ID: <20240110185611.19723-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a ton of build errors when REGMAP is not set, so select
REGMAP to fix all of them.

Examples (not all of them):

./drivers/iio/imu/bno055/bno055_ser_core.c:495:15: error: variable 'bno055_ser_regmap_bus' has initializer but incomplete type
  495 | static struct regmap_bus bno055_ser_regmap_bus = {
./drivers/iio/imu/bno055/bno055_ser_core.c:496:10: error: 'struct regmap_bus' has no member named 'write'
  496 |         .write = bno055_ser_write_reg,
./drivers/iio/imu/bno055/bno055_ser_core.c:497:10: error: 'struct regmap_bus' has no member named 'read'
  497 |         .read = bno055_ser_read_reg,
./drivers/iio/imu/bno055/bno055_ser_core.c: In function 'bno055_ser_probe':
./drivers/iio/imu/bno055/bno055_ser_core.c:532:18: error: implicit declaration of function 'devm_regmap_init'; did you mean 'vmem_map_init'? [-Werror=implicit-function-declaration]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
./drivers/iio/imu/bno055/bno055_ser_core.c:532:16: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  532 |         regmap = devm_regmap_init(&serdev->dev, &bno055_ser_regmap_bus,
./drivers/iio/imu/bno055/bno055_ser_core.c: At top level:
./drivers/iio/imu/bno055/bno055_ser_core.c:495:26: error: storage size of 'bno055_ser_regmap_bus' isn't known
  495 | static struct regmap_bus bno055_ser_regmap_bus = {

Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrea Merello <andrea.merello@iit.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/imu/bno055/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -8,6 +8,7 @@ config BOSCH_BNO055
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
 	depends on SERIAL_DEV_BUS
+	select REGMAP
 	select BOSCH_BNO055
 	help
 	  Enable this to support Bosch BNO055 IMUs attached via UART.

