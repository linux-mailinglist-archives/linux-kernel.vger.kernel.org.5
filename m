Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CFF7F3867
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbjKUVgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjKUVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:36:15 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B50B9;
        Tue, 21 Nov 2023 13:36:10 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALGheNL024638;
        Tue, 21 Nov 2023 16:35:58 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ueu275f33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:35:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLZujq057065
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Nov 2023 16:35:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 21 Nov
 2023 16:35:55 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:35:55 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLZidd020005;
        Tue, 21 Nov 2023 16:35:46 -0500
From:   <marcelo.schmitt@analog.com>
To:     <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <marcelo.schmitt1@gmail.com>
CC:     Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] iio: adc: ad7091r: Alloc IIO device before generic probe
Date:   Tue, 21 Nov 2023 18:35:44 -0300
Message-ID: <fb5f1ce19290f82094fa64bfe133d97ff9c54700.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vW2cHRDoqkw-T9MK5f6KrsNPqsD5q1pK
X-Proofpoint-GUID: vW2cHRDoqkw-T9MK5f6KrsNPqsD5q1pK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210168
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Rework ad7091r probe functions so the IIO device is allocated before
the generic device probe function is called.
This change is needed for a follow up patch that passes a pointer to the
IIO device to a couple of regmap callback functions.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 35 +++++++---------------------------
 drivers/iio/adc/ad7091r-base.h | 22 +++++++++++++++++----
 drivers/iio/adc/ad7091r5.c     | 14 ++++++++++++--
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index ebf1c8cca25c..69cb5ccdbc49 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -27,21 +27,6 @@
 #define AD7091R_REG_CONF_MODE_MASK  \
 	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
 
-enum ad7091r_mode {
-	AD7091R_MODE_SAMPLE,
-	AD7091R_MODE_COMMAND,
-	AD7091R_MODE_AUTOCYCLE,
-};
-
-struct ad7091r_state {
-	struct device *dev;
-	struct regmap *map;
-	struct regulator *vref;
-	const struct ad7091r_chip_info *chip_info;
-	enum ad7091r_mode mode;
-	struct mutex lock; /*lock to prevent concurent reads */
-};
-
 static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 {
 	int ret, conf;
@@ -200,20 +185,14 @@ static void ad7091r_remove(void *data)
 	regulator_disable(st->vref);
 }
 
-int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
-		struct regmap *map, int irq)
+int ad7091r_probe(struct iio_dev *iio_dev, const char *name,
+		  const struct ad7091r_chip_info *chip_info,
+		  struct regmap *map, int irq)
 {
-	struct iio_dev *iio_dev;
 	struct ad7091r_state *st;
 	int ret;
 
-	iio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (!iio_dev)
-		return -ENOMEM;
-
 	st = iio_priv(iio_dev);
-	st->dev = dev;
 	st->chip_info = chip_info;
 	st->map = map;
 
@@ -231,7 +210,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 
 		dev_set_drvdata(st->dev, iio_dev);
-		ret = devm_request_threaded_irq(dev, irq, NULL,
+		ret = devm_request_threaded_irq(st->dev, irq, NULL,
 						ad7091r_event_handler,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT, name, st);
@@ -239,7 +218,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 	}
 
-	st->vref = devm_regulator_get_optional(dev, "vref");
+	st->vref = devm_regulator_get_optional(st->dev, "vref");
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
@@ -248,7 +227,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 		ret = regulator_enable(st->vref);
 		if (ret)
 			return ret;
-		ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
+		ret = devm_add_action_or_reset(st->dev, ad7091r_remove, st);
 		if (ret)
 			return ret;
 	}
@@ -258,7 +237,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, iio_dev);
+	return devm_iio_device_register(st->dev, iio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 2efed8ddc59a..405939f4eee0 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -30,7 +30,21 @@
 }
 
 struct device;
-struct ad7091r_state;
+
+enum ad7091r_mode {
+	AD7091R_MODE_SAMPLE,
+	AD7091R_MODE_COMMAND,
+	AD7091R_MODE_AUTOCYCLE,
+};
+
+struct ad7091r_state {
+	struct device *dev;
+	struct regmap *map;
+	struct regulator *vref;
+	const struct ad7091r_chip_info *chip_info;
+	enum ad7091r_mode mode;
+	struct mutex lock; /*lock to prevent concurent reads */
+};
 
 struct ad7091r_chip_info {
 	unsigned int num_channels;
@@ -60,9 +74,9 @@ static const struct iio_event_spec ad7091r_events[] = {
 
 extern const struct regmap_config ad7091r_regmap_config;
 
-int ad7091r_probe(struct device *dev, const char *name,
-		const struct ad7091r_chip_info *chip_info,
-		struct regmap *map, int irq);
+int ad7091r_probe(struct iio_dev *iio_dev, const char *name,
+		  const struct ad7091r_chip_info *chip_info,
+		  struct regmap *map, int irq);
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
 
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9d3ccfca94ec..1a27841d1bbc 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -42,8 +42,18 @@ static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	const struct ad7091r_chip_info *chip_info;
-	struct regmap *map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
+	struct ad7091r_state *st;
+	struct iio_dev *iio_dev;
+	struct regmap *map;
 
+	iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*st));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(iio_dev);
+	st->dev = &i2c->dev;
+
+	map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
@@ -52,7 +62,7 @@ static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 	else
 		chip_info = &ad7091r5_chip_info_noirq;
 
-	return ad7091r_probe(&i2c->dev, id->name, chip_info, map, i2c->irq);
+	return ad7091r_probe(iio_dev, id->name, chip_info, map, i2c->irq);
 }
 
 static const struct of_device_id ad7091r5_dt_ids[] = {
-- 
2.42.0

