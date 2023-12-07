Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC880904B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjLGSlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjLGSlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:41:18 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1574A1718;
        Thu,  7 Dec 2023 10:41:24 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7HfSFo032162;
        Thu, 7 Dec 2023 13:41:04 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uujny87w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:41:04 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3B7If3UM056350
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:41:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 7 Dec 2023
 13:41:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:41:01 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IehAx015360;
        Thu, 7 Dec 2023 13:40:46 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/13] iio: adc: ad7091r: Move chip init data to container struct
Date:   Thu, 7 Dec 2023 15:40:42 -0300
Message-ID: <f45d5dfde5fc2082ac1fcac18a4a3e9b4b941402.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SV4JsX5B3zMYjLPYyVDWtbozdqxNxk-w
X-Proofpoint-ORIG-GUID: SV4JsX5B3zMYjLPYyVDWtbozdqxNxk-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312070156
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AD7091R designs may differ on their communication protocol and resources
required for proper setup. Extract what is design specific into a
init_info struct so the base driver can use data and callback functions
from that struct rather than checking which specific chip is connected
during device initialization.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 27 ++++++++++-----------
 drivers/iio/adc/ad7091r-base.h | 14 ++++++++---
 drivers/iio/adc/ad7091r5.c     | 43 ++++++++++++++++++++++++----------
 3 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 4d0a1eeebb8a..90470b4a98c5 100644
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
+	init_info->ad7091r_regmap_init(st, init_info->regmap_config);
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
@@ -243,8 +242,14 @@ int ad7091r_probe(struct device *dev, const char *name,
 						IRQF_ONESHOT, name, st);
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
@@ -292,14 +297,6 @@ bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
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
index 1d30eeb46bcc..d58e2b08015a 100644
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
@@ -52,12 +54,18 @@ struct ad7091r_chip_info {
 	unsigned int vref_mV;
 };
 
-extern const struct iio_event_spec ad7091r_events[3];
+struct ad7091r_init_info {
+	struct ad7091r_chip_info irq_info;
+	struct ad7091r_chip_info info_no_irq;
+	const struct regmap_config *regmap_config;
+	void (*ad7091r_regmap_init)(struct ad7091r_state *st,
+				    const struct regmap_config *regmap_conf);
+};
 
-extern const struct regmap_config ad7091r_regmap_config;
+extern const struct iio_event_spec ad7091r_events[3];
 
 int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
+		const struct ad7091r_init_info *init_info,
 		struct regmap *map, int irq);
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9d3ccfca94ec..51aad8df7f3a 100644
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
+	.ad7091r_regmap_init = &ad7091r5_regmap_init
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

