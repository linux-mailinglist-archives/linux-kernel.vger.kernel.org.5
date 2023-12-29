Return-Path: <linux-kernel+bounces-13028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F282E81FE9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AA41F22E15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B6111A8;
	Fri, 29 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="m68GZYKJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C510A0A;
	Fri, 29 Dec 2023 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0286628B586;
	Fri, 29 Dec 2023 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841907;
	bh=tlhYys3P3yLGPXxjY35bhZAwm+PVbm6Qq70uWBAQSm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m68GZYKJYu9MVhSNNAhugzNP9Hjh9U5xoPyi8ZIdCy19klvpOuB3MGfceyHvae5HW
	 YoQcUZMH9ESCm93nkGIh9jPTzbonbnlw8HtYFYLBrrSncnm8T/FsYacqwY8hyu99vJ
	 gXjOwsgFOChM9ADJp8t5RVqynNHf45lVMJolEtSg=
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
Subject: [PATCH v3 04/10] iio: pressure: mprls0025pa fix off-by-one enum
Date: Fri, 29 Dec 2023 11:24:32 +0200
Message-ID: <20231229092445.30180-5-petre.rodan@subdimension.ro>
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

Fix off-by-one error in transfer-function property.
The honeywell,transfer-function property takes values between 1-3 so
make sure the proper enum gets used.

Fixes: <713337d9143ed> ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 no changes

 drivers/iio/pressure/mprls0025pa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 30fb2de36821..e3f0de020a40 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -323,6 +323,7 @@ static int mpr_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct device *dev = &client->dev;
 	s64 scale, offset;
+	u32 func;

 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
 		return dev_err_probe(dev, -EOPNOTSUPP,
@@ -362,10 +363,11 @@ static int mpr_probe(struct i2c_client *client)
 			return dev_err_probe(dev, ret,
 				"honeywell,pmax-pascal could not be read\n");
 		ret = device_property_read_u32(dev,
-				"honeywell,transfer-function", &data->function);
+				"honeywell,transfer-function", &func);
 		if (ret)
 			return dev_err_probe(dev, ret,
 				"honeywell,transfer-function could not be read\n");
+		data->function = func - 1;
 		if (data->function > MPR_FUNCTION_C)
 			return dev_err_probe(dev, -EINVAL,
 				"honeywell,transfer-function %d invalid\n",
--
2.41.0


