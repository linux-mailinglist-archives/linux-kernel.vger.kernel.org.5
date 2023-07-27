Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BE67656EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjG0PG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjG0PGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:06:23 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF33A99;
        Thu, 27 Jul 2023 08:06:02 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RE2Egv003290;
        Thu, 27 Jul 2023 17:05:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=Pt5jUqqdSOoqnjMTkcAHM3VXQXCIBKFvR/ivoinfamw=;
 b=zymx3FJupVczr0LBeD96k642Kl+8JvVTWEb6uyhk5jRRlfIBW/x+Nh70E3455exT2npq
 4BQnfQptu3kS6UynsE+t30eo8dIY5JwzxZnU04dmu8kzntl8tV4sE8Ivk3fRyk6jrb96
 bxXZr3F6b9R1jWz2r4KdooUDAdMdnWeIMQW9NEuz6g3R8fM2mZN/QKB9TzklCmuq5k/z
 VAwm2vUp6SGttvIwFeCRjiAmuRKg5S8nyk2soBsdjhQpyEsGfkPYpHY8mQS6Oru+lO4f
 lOqdSYWoqiJMkdyNGwJ9PIq95tbyz8MyxPOcsNClxW/JSUZSkheZJ8y0ZJ2qI740mbmu zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3nyg9xc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:05:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F00410002A;
        Thu, 27 Jul 2023 17:05:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67EFE209BA7;
        Thu, 27 Jul 2023 17:05:46 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:05:46 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 08/11] iio: adc: sd modulator: add scale and offset support
Date:   Thu, 27 Jul 2023 17:03:19 +0200
Message-ID: <20230727150324.1157933-9-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the SD modulator as an IIO backend device instead of
a standard IIO device. Expose scale and offset information to
IIO backend consumer.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 106 +++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 327cc2097f6c..e77e7884c403 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -6,44 +6,110 @@
  * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
  */
 
+#include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
-static const struct iio_info iio_sd_mod_iio_info;
+struct iio_sd_mod_priv {
+	struct regulator *vref;
+	int vref_mv;
+};
 
-static const struct iio_chan_spec iio_sd_mod_ch = {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 1,
-		.shift = 0,
-	},
+static int sd_mod_enable(struct iio_backend *backend)
+{
+	struct iio_sd_mod_priv *priv = backend->priv;
+	int ret;
+
+	ret = regulator_enable(priv->vref);
+	if (ret) {
+		dev_err(&backend->dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_get_voltage(priv->vref);
+	priv->vref_mv = ret / 1000;
+
+	return 0;
+};
+
+static int sd_mod_disable(struct iio_backend *backend)
+{
+	struct iio_sd_mod_priv *priv = backend->priv;
+
+	return regulator_disable(priv->vref);
+};
+
+static int sd_mod_read(struct iio_backend *backend, int *val, int *val2, long mask)
+{
+	struct iio_sd_mod_priv *priv = backend->priv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*val = priv->vref_mv;
+		*val2 = 0;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+		*val2 = 0;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+};
+
+static const struct iio_backend_ops sd_mod_ops = {
+	.enable = sd_mod_enable,
+	.disable = sd_mod_disable,
+	.read_raw = sd_mod_read,
 };
 
 static int iio_sd_mod_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct iio_dev *iio;
+	struct regulator *vref;
+	struct iio_backend *backend;
+	struct iio_sd_mod_priv *priv;
+	int ret;
 
-	iio = devm_iio_device_alloc(dev, 0);
-	if (!iio)
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	iio->name = dev_name(dev);
-	iio->info = &iio_sd_mod_iio_info;
-	iio->modes = INDIO_BUFFER_HARDWARE;
+	vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(vref)) {
+		if (PTR_ERR(vref) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
+	} else {
+		priv->vref = vref;
+	}
 
-	iio->num_channels = 1;
-	iio->channels = &iio_sd_mod_ch;
+	backend = iio_backend_alloc(dev);
+	if (!backend) {
+		dev_err(dev, "Failed to allocate sd modulator backend data\n");
+		return -ENOMEM;
+	}
+
+	backend->priv = priv;
+	backend->ops = &sd_mod_ops;
+
+	ret = iio_backend_register(backend);
+	if (ret) {
+		dev_err(dev, "Failed to register backend: %d\n", ret);
+		goto err_free_backend;
+	}
 
-	platform_set_drvdata(pdev, iio);
+	return 0;
 
-	return devm_iio_device_register(&pdev->dev, iio);
-}
+err_free_backend:
+	iio_backend_free(&backend->dev);
+
+	return ret;
+};
 
 static const struct of_device_id sd_adc_of_match[] = {
 	{ .compatible = "sd-modulator" },
-- 
2.25.1

