Return-Path: <linux-kernel+bounces-2306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC6815ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01542B242E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5CB31741;
	Sat, 16 Dec 2023 17:48:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857B32C75;
	Sat, 16 Dec 2023 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG9ttwU019771;
	Sat, 16 Dec 2023 12:48:16 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v19p593bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 12:48:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BGHmEsS034034
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 16 Dec 2023 12:48:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 16 Dec 2023 12:48:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 16 Dec 2023 12:48:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 16 Dec 2023 12:48:13 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BGHluIX015810;
	Sat, 16 Dec 2023 12:47:59 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 06/15] iio: adc: ad7091r: Move chip init data to container struct
Date: Sat, 16 Dec 2023 14:47:54 -0300
Message-ID: <9d1248860193b55e79640b2e64c21c66bd6645f9.1702746240.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: nnz54ql5JCJ2F9GM2fNs65LCBMEiGxGv
X-Proofpoint-ORIG-GUID: nnz54ql5JCJ2F9GM2fNs65LCBMEiGxGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160136

AD7091R designs may differ on their communication protocol and resources
required for proper setup. Extract what is design specific into a
init_info struct so the base driver can use data and callback functions
from that struct rather than checking which specific chip is connected
during device initialization.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 27 ++++++++++-----------
 drivers/iio/adc/ad7091r-base.h | 15 +++++++++---
 drivers/iio/adc/ad7091r5.c     | 43 ++++++++++++++++++++++++----------
 3 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 0d1f544de07a..ad4b4d591e1a 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -207,7 +207,7 @@ static void ad7091r_remove(void *data)
 }
 
 int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
+		const struct ad7091r_init_info *init_info,
 		struct regmap *map, int irq)
 {
 	struct iio_dev *iio_dev;
@@ -220,17 +220,16 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 	st = iio_priv(iio_dev);
 	st->dev = dev;
-	st->chip_info = chip_info;
-	st->map = map;
+	init_info->init_adc_regmap(st, init_info->regmap_config);
+	if (IS_ERR(st->map))
+		return dev_err_probe(st->dev, PTR_ERR(st->map),
+				     "Error initializing regmap\n");
 
-	iio_dev->name = name;
 	iio_dev->info = &ad7091r_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 
-	iio_dev->num_channels = chip_info->num_channels;
-	iio_dev->channels = chip_info->channels;
-
 	if (irq) {
+		st->chip_info = &init_info->irq_info;
 		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
 					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
 		if (ret)
@@ -242,8 +241,14 @@ int ad7091r_probe(struct device *dev, const char *name,
 						IRQF_ONESHOT, name, iio_dev);
 		if (ret)
 			return ret;
+	} else {
+		st->chip_info = &init_info->info_no_irq;
 	}
 
+	iio_dev->name = st->chip_info->name;
+	iio_dev->num_channels = st->chip_info->num_channels;
+	iio_dev->channels = st->chip_info->channels;
+
 	st->vref = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
@@ -291,14 +296,6 @@ bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, IIO_AD7091R);
 
-const struct regmap_config ad7091r_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 16,
-	.writeable_reg = ad7091r_writeable_reg,
-	.volatile_reg = ad7091r_volatile_reg,
-};
-EXPORT_SYMBOL_NS_GPL(ad7091r_regmap_config, IIO_AD7091R);
-
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 1d30eeb46bcc..51649570bb5d 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,6 +8,8 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#include <linux/regmap.h>
+
 #define AD7091R_REG_RESULT  0
 #define AD7091R_REG_CHANNEL 1
 #define AD7091R_REG_CONF    2
@@ -47,17 +49,24 @@ struct ad7091r_state {
 };
 
 struct ad7091r_chip_info {
+	const char *name;
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
 };
 
-extern const struct iio_event_spec ad7091r_events[3];
+struct ad7091r_init_info {
+	struct ad7091r_chip_info irq_info;
+	struct ad7091r_chip_info info_no_irq;
+	const struct regmap_config *regmap_config;
+	void (*init_adc_regmap)(struct ad7091r_state *st,
+				const struct regmap_config *regmap_conf);
+};
 
-extern const struct regmap_config ad7091r_regmap_config;
+extern const struct iio_event_spec ad7091r_events[3];
 
 int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
+		const struct ad7091r_init_info *init_info,
 		struct regmap *map, int irq);
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9d3ccfca94ec..69b436920e2d 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -27,42 +27,61 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
+	.name = "ad7091r-5",
 	.channels = ad7091r5_channels_irq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
 	.vref_mV = 2500,
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
+	.name = "ad7091r-5",
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
 	.vref_mV = 2500,
 };
 
+static const struct regmap_config ad7091r_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.writeable_reg = ad7091r_writeable_reg,
+	.volatile_reg = ad7091r_volatile_reg,
+};
+
+static void ad7091r5_regmap_init(struct ad7091r_state *st,
+				 const struct regmap_config *regmap_conf)
+{
+	struct i2c_client *i2c = container_of(st->dev, struct i2c_client, dev);
+
+	st->map = devm_regmap_init_i2c(i2c, regmap_conf);
+}
+
+static struct ad7091r_init_info ad7091r5_init_info = {
+	.irq_info = ad7091r5_chip_info_irq,
+	.info_no_irq = ad7091r5_chip_info_noirq,
+	.regmap_config = &ad7091r_regmap_config,
+	.init_adc_regmap = &ad7091r5_regmap_init
+};
+
 static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
-	const struct ad7091r_chip_info *chip_info;
-	struct regmap *map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
-
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	const struct ad7091r_init_info *init_info;
 
-	if (i2c->irq)
-		chip_info = &ad7091r5_chip_info_irq;
-	else
-		chip_info = &ad7091r5_chip_info_noirq;
+	init_info = i2c_get_match_data(i2c);
+	if (!init_info)
+		return -EINVAL;
 
-	return ad7091r_probe(&i2c->dev, id->name, chip_info, map, i2c->irq);
+	return ad7091r_probe(&i2c->dev, id->name, init_info, NULL, i2c->irq);
 }
 
 static const struct of_device_id ad7091r5_dt_ids[] = {
-	{ .compatible = "adi,ad7091r5" },
+	{ .compatible = "adi,ad7091r5", .data = &ad7091r5_init_info },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ad7091r5_dt_ids);
 
 static const struct i2c_device_id ad7091r5_i2c_ids[] = {
-	{"ad7091r5", 0},
+	{"ad7091r5", (kernel_ulong_t)&ad7091r5_init_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);
-- 
2.42.0


