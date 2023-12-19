Return-Path: <linux-kernel+bounces-5914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6649819171
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C11C2343C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A73B78B;
	Tue, 19 Dec 2023 20:29:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8913B2BF;
	Tue, 19 Dec 2023 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJI4M1j027748;
	Tue, 19 Dec 2023 15:29:04 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4s0eta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:29:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BJKT2Ex064268
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Dec 2023 15:29:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 19 Dec
 2023 15:29:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Dec 2023 15:29:01 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BJKSkIu030072;
	Tue, 19 Dec 2023 15:28:48 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/11] iio: adc: ad7091r: Set device mode through chip_info callback
Date: Tue, 19 Dec 2023 17:28:45 -0300
Message-ID: <5140336980f66c2c45f05895c3b68e2f65fba1c2.1703013352.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: BimmQsQ6XNZF25rjL5D8EVJkNcb_L-5P
X-Proofpoint-ORIG-GUID: BimmQsQ6XNZF25rjL5D8EVJkNcb_L-5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190152

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
 drivers/iio/adc/ad7091r-base.h |  8 +++++++
 drivers/iio/adc/ad7091r5.c     | 30 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 2c65c63db40c..a4ca2e21e023 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -20,14 +20,6 @@
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
@@ -49,34 +41,6 @@ const struct iio_event_spec ad7091r_events[] = {
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
@@ -406,7 +370,7 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
 	}
 
 	/* Use command mode by default to convert only desired channels*/
-	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
+	ret = st->chip_info->set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index a57ec36491f5..7ba5065a63dd 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -18,7 +18,14 @@
 #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
 #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
 
+/* AD7091R_REG_CONF */
 #define AD7091R_REG_CONF_INT_VREF	BIT(0)
+#define AD7091R_REG_CONF_ALERT_EN	BIT(4)
+#define AD7091R_REG_CONF_AUTO		BIT(8)
+#define AD7091R_REG_CONF_CMD		BIT(10)
+
+#define AD7091R_REG_CONF_MODE_MASK  \
+	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
 
 /* AD7091R_REG_CH_LIMIT */
 #define AD7091R_HIGH_LIMIT		0xFFF
@@ -58,6 +65,7 @@ struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
+	int (*set_mode)(struct ad7091r_state *st, enum ad7091r_mode mode);
 };
 
 struct ad7091r_init_info {
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index cb4c7865f0cc..e1163b42609c 100644
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


