Return-Path: <linux-kernel+bounces-13032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D781FEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1FC282CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553A125CC;
	Fri, 29 Dec 2023 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="mIaJW9MP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD29611707;
	Fri, 29 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 581A028B587;
	Fri, 29 Dec 2023 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841907;
	bh=WDPOUW7eIikkHeG8X4wBbQ+EIdwGrEaQcqnAsLeHEGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mIaJW9MPIiNCMyBoEfJRjdEiuJ4AhJe0o9TNUvAraFysQ+wSv77fr7hU1NTmS6Usj
	 74htdF0yGWbcKsPFMKoGHbG0CFJBfYNxzwlRoR9wPSHYKAJUGpp2CV+M9wrI9UdFQ8
	 7u03koibqsE3BNczxn3udLHD5v1Ajp6dksPUKHwA=
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
Subject: [PATCH v3 05/10] iio: pressure: mprls0025pa improve driver error resilience
Date: Fri, 29 Dec 2023 11:24:33 +0200
Message-ID: <20231229092445.30180-6-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229092445.30180-1-petre.rodan@subdimension.ro>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve driver error resilience by ignoring the measurement if any of
the 3 error flags gets set while interacting with the sensor.
Based on the datasheet, in table 14 on page 14, the status byte
contains:
    bit 5 busy flag - 1 if device is busy
    bit 2 memory integrity/error flag - 1 if integrity test failed
    bit 0 math saturation - 1 if internal math saturation has occurred

Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 no changes

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


