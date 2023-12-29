Return-Path: <linux-kernel+bounces-13031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8C81FEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6360B22B32
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15570125CD;
	Fri, 29 Dec 2023 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Q6iGt/rq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D9111B2;
	Fri, 29 Dec 2023 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id AD3EC28B589;
	Fri, 29 Dec 2023 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841907;
	bh=u3xyd+nm/UZuOc3ZGkrOgUgkrAV7H1N45wZ4bM46qHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q6iGt/rqPO/JT9MpC9yAhsdDth9McjbYCHpUsFU9C8BX7RCcKSvlXmz4AbhqdmDiQ
	 6InniD54xqzIL/taHDRqyoPG4bh6WF5yfeX3vJKIR9QxBuB5IREQ8gEJBs7KahBC1V
	 GIDUsQrlynv466geO7D3L8QNRbRIXgQgdU4m8LA0=
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
Subject: [PATCH v3 06/10] iio: pressure: mprls0025pa remove defaults
Date: Fri, 29 Dec 2023 11:24:34 +0200
Message-ID: <20231229092445.30180-7-petre.rodan@subdimension.ro>
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

This driver supports 32*3 combinations of fixed ranges and transfer
functions, plus custom ranges.

So statistically a user has more than 99% chance that the provided
default configuration will generate invalid pressure readings if the
bindings are not initialized and the driver is instantiated via sysfs.

The current patch removes this loophole making sure the driver loads
only if the firmware properties are present.

Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 drop the use of dev_fwnode() entirely

 drivers/iio/pressure/mprls0025pa.c | 48 +++++++++++++-----------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 233cc1dc38ad..e0a2a60c6245 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -353,34 +353,26 @@ static int mpr_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				"can't get and enable vdd supply\n");

-	if (dev_fwnode(dev)) {
-		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
-								&data->pmin);
-		if (ret)
-			return dev_err_probe(dev, ret,
-				"honeywell,pmin-pascal could not be read\n");
-		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
-								&data->pmax);
-		if (ret)
-			return dev_err_probe(dev, ret,
-				"honeywell,pmax-pascal could not be read\n");
-		ret = device_property_read_u32(dev,
-				"honeywell,transfer-function", &func);
-		if (ret)
-			return dev_err_probe(dev, ret,
-				"honeywell,transfer-function could not be read\n");
-		data->function = func - 1;
-		if (data->function > MPR_FUNCTION_C)
-			return dev_err_probe(dev, -EINVAL,
-				"honeywell,transfer-function %d invalid\n",
-								data->function);
-	} else {
-		/* when loaded as i2c device we need to use default values */
-		dev_notice(dev, "firmware node not found; using defaults\n");
-		data->pmin = 0;
-		data->pmax = 172369; /* 25 psi */
-		data->function = MPR_FUNCTION_A;
-	}
+	ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+				       &data->pmin);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				   "honeywell,pmin-pascal could not be read\n");
+	ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+				       &data->pmax);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				   "honeywell,pmax-pascal could not be read\n");
+	ret = device_property_read_u32(dev,
+				       "honeywell,transfer-function", &func);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			     "honeywell,transfer-function could not be read\n");
+	data->function = func - 1;
+	if (data->function > MPR_FUNCTION_C)
+		return dev_err_probe(dev, -EINVAL,
+				     "honeywell,transfer-function %d invalid\n",
+				     data->function);

 	data->outmin = mpr_func_spec[data->function].output_min;
 	data->outmax = mpr_func_spec[data->function].output_max;
--
2.41.0


