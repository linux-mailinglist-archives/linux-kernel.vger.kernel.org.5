Return-Path: <linux-kernel+bounces-10731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8381DAFA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3672D1F2130A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5210A16;
	Sun, 24 Dec 2023 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="DFtXG4Gv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE769C8FF;
	Sun, 24 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 908FE28B587;
	Sun, 24 Dec 2023 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428511;
	bh=TorcAZcZKDG1z0F/unbmrv9wp4dcwJcvTKt25PvrhyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DFtXG4GvUwQ2ns94vrVKLH0jDz6XEmK/tdCJCMoG/Nmm2tHtMZDwKFP3O9vfgLJ4K
	 plV4eWge9vXJxKGFZcI2xrM9AjVBtPQW2V7gHSg0WOCCmnZAbPFj33cjs4cQ0zr7Uu
	 8qgbNpyfkPHqEqs6QZQp4o7KVkg9D4KVpK3djA+8=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v2 05/10] iio: pressure: mprls0025pa.c fix error flag check
Date: Sun, 24 Dec 2023 16:34:50 +0200
Message-ID: <20231224143500.10940-6-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231224143500.10940-1-petre.rodan@subdimension.ro>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take into account all 3 error flags while interacting with the sensor.
Based on the datasheet, in table 14 on page 14, the status byte
contains:
    bit 5 busy flag - 1 if device is busy
    bit 2 memory integrity/error flag - 1 if integrity test failed
    bit 0 math saturation - 1 if internal math saturation has occurred

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/mprls0025pa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index e3f0de020a40..233cc1dc38ad 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -39,6 +39,8 @@
 #define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
 #define MPR_I2C_MATH	BIT(0)	/* internal math saturation */

+#define MPR_I2C_ERR_FLAG  (MPR_I2C_BUSY | MPR_I2C_MEMORY | MPR_I2C_MATH)
+
 /*
  * support _RAW sysfs interface:
  *
@@ -213,7 +215,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 					status);
 				return status;
 			}
-			if (!(status & MPR_I2C_BUSY))
+			if (!(status & MPR_I2C_ERR_FLAG))
 				break;
 		}
 		if (i == nloops) {
@@ -233,7 +235,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 		return -EIO;
 	}

-	if (buf[0] & MPR_I2C_BUSY) {
+	if (buf[0] & MPR_I2C_ERR_FLAG) {
 		/*
 		 * it should never be the case that status still indicates
 		 * business
--
2.41.0


