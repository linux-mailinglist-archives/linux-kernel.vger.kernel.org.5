Return-Path: <linux-kernel+bounces-10726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5A81DAF3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67564B21484
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8CAFBF1;
	Sun, 24 Dec 2023 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="UexyF4zT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE793CA62;
	Sun, 24 Dec 2023 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id F276B28B589;
	Sun, 24 Dec 2023 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703428512;
	bh=HLqQLEVNtiMPyM7hryG6OMvLH1BriN5OL0vabmTcwRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UexyF4zTPQ68Hmc6DOF9oHqK9Bws8Gl1X+lGqKuwYsVkDhIeyNI3yR+CKNEkGtH5i
	 Lk7nkHiZmXeM9Xzu/CYRuYmcZJ7AD5IsJjW09cUhKWMvxWDQrMhR/nDnayXaBm92xh
	 FxRVbWXoglGfuclOf2n6CjiG0hKbeYH/x6rkUeAI=
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
Subject: [PATCH v2 06/10] iio: pressure: mprls0025pa.c remove dangerous defaults
Date: Sun, 24 Dec 2023 16:34:51 +0200
Message-ID: <20231224143500.10940-7-petre.rodan@subdimension.ro>
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

This driver supports 32*3 combinations of fixed ranges and transfer
functions, plus custom ranges.

So statistically a user has more than 99% chance that the provided
default configuration will generate invalid pressure readings if the
bindings are not initialized and the driver is instantiated via sysfs.

The current patch removes this loophole making sure the driver loads
only if the dt has been initialized.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/mprls0025pa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 233cc1dc38ad..63c46592956f 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -375,11 +375,8 @@ static int mpr_probe(struct i2c_client *client)
 				"honeywell,transfer-function %d invalid\n",
 								data->function);
 	} else {
-		/* when loaded as i2c device we need to use default values */
-		dev_notice(dev, "firmware node not found; using defaults\n");
-		data->pmin = 0;
-		data->pmax = 172369; /* 25 psi */
-		data->function = MPR_FUNCTION_A;
+		return dev_err_probe(dev, -EINVAL,
+				  "driver needs to be initialized in the dt\n");
 	}

 	data->outmin = mpr_func_spec[data->function].output_min;
--
2.41.0


