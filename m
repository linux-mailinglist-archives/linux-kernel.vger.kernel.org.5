Return-Path: <linux-kernel+bounces-2311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D11815AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29A9B24534
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2F31A6F;
	Sat, 16 Dec 2023 17:49:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D4F31A6E;
	Sat, 16 Dec 2023 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGFk1Tc010398;
	Sat, 16 Dec 2023 12:49:12 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v1etvg8rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 12:49:12 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BGHnBGq034106
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 16 Dec 2023 12:49:11 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 16 Dec 2023 12:49:10 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sat, 16 Dec 2023 12:49:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 16 Dec 2023 12:49:09 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BGHmoW0015838;
	Sat, 16 Dec 2023 12:48:53 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/15] iio: adc: ad7091r: Set device mode through chip_info callback
Date: Sat, 16 Dec 2023 14:48:48 -0300
Message-ID: <15b84bc156f329d74be2d83d547ad7e75fead4c2.1702746240.git.marcelo.schmitt1@gmail.com>
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
X-Proofpoint-GUID: hqRJBAX59vQ9vnvV-BV4yVv5Z7qHN_OA
X-Proofpoint-ORIG-GUID: hqRJBAX59vQ9vnvV-BV4yVv5Z7qHN_OA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160137

AD7091R-5 devices have a few modes of operation (sample, command,
autocycle) which are set by writing to configuration register fields.
Follow up patches will add support for AD7091R-2/-4/-8 which don't have
those operation modes nor the register fields for setting them.
Make ad7091r_set_mode() a callback function of AD7091R chip_info struct
so the base driver can appropriately handle each design without having
to check which actual chip is connected.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 38 +---------------------------------
 drivers/iio/adc/ad7091r-base.h |  9 ++++++++
 drivers/iio/adc/ad7091r5.c     | 30 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index ed98729baf43..aead72ef55b6 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -19,14 +19,6 @@
 #define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
-/* AD7091R_REG_CONF */
-#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
-#define AD7091R_REG_CONF_AUTO   BIT(8)
-#define AD7091R_REG_CONF_CMD    BIT(10)
-
-#define AD7091R_REG_CONF_MODE_MASK  \
-	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
-
 const struct iio_event_spec ad7091r_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -48,34 +40,6 @@ const struct iio_event_spec ad7091r_events[] = {
 };
 EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
 
-static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
-{
-	int ret, conf;
-
-	switch (mode) {
-	case AD7091R_MODE_SAMPLE:
-		conf = 0;
-		break;
-	case AD7091R_MODE_COMMAND:
-		conf = AD7091R_REG_CONF_CMD;
-		break;
-	case AD7091R_MODE_AUTOCYCLE:
-		conf = AD7091R_REG_CONF_AUTO;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
-				 AD7091R_REG_CONF_MODE_MASK, conf);
-	if (ret)
-		return ret;
-
-	st->mode = mode;
-
-	return 0;
-}
-
 static int ad7091r_set_channel(struct ad7091r_state *st, unsigned int channel)
 {
 	unsigned int dummy;
@@ -264,7 +228,7 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
 	}
 
 	/* Use command mode by default to convert only desired channels*/
-	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
+	ret = st->chip_info->set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 3b3c81904ac2..81b8a4bbb929 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -19,6 +19,14 @@
 #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
 #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
 
+/* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_ALERT_EN	BIT(4)
+#define AD7091R_REG_CONF_AUTO		BIT(8)
+#define AD7091R_REG_CONF_CMD		BIT(10)
+
+#define AD7091R_REG_CONF_MODE_MASK  \
+	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
+
 #define AD7091R_CHANNEL(idx, bits, ev, num_ev) {			\
 	.type = IIO_VOLTAGE,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
@@ -53,6 +61,7 @@ struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
+	int (*set_mode)(struct ad7091r_state *st, enum ad7091r_mode mode);
 };
 
 struct ad7091r_init_info {
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 2872b6a0bae7..08f4b9717329 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -26,11 +26,40 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
 	AD7091R_CHANNEL(3, 12, NULL, 0),
 };
 
+static int ad7091r5_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
+{
+	int ret, conf;
+
+	switch (mode) {
+	case AD7091R_MODE_SAMPLE:
+		conf = 0;
+		break;
+	case AD7091R_MODE_COMMAND:
+		conf = AD7091R_REG_CONF_CMD;
+		break;
+	case AD7091R_MODE_AUTOCYCLE:
+		conf = AD7091R_REG_CONF_AUTO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+				 AD7091R_REG_CONF_MODE_MASK, conf);
+	if (ret)
+		return ret;
+
+	st->mode = mode;
+
+	return 0;
+}
+
 static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
 	.name = "ad7091r-5",
 	.channels = ad7091r5_channels_irq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
 	.vref_mV = 2500,
+	.set_mode = &ad7091r5_set_mode,
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
@@ -38,6 +67,7 @@ static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
 	.vref_mV = 2500,
+	.set_mode = &ad7091r5_set_mode,
 };
 
 static const struct regmap_config ad7091r_regmap_config = {
-- 
2.42.0


