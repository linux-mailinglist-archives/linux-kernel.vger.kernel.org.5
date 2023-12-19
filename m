Return-Path: <linux-kernel+bounces-5907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D462681915A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0268A1C24149
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F639AF4;
	Tue, 19 Dec 2023 20:27:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69F39AD0;
	Tue, 19 Dec 2023 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJI4aLw001699;
	Tue, 19 Dec 2023 15:27:26 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v3g4ugep7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 15:27:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3BJKRO7H034930
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Dec 2023 15:27:24 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Dec 2023 15:27:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Dec 2023 15:27:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Dec 2023 15:27:23 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BJKR4rH030024;
	Tue, 19 Dec 2023 15:27:07 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 03/11] iio: adc: ad7091r: Move generic AD7091R code to base driver and header file
Date: Tue, 19 Dec 2023 17:27:04 -0300
Message-ID: <6376fc523ee503d47ec499e2cd2ef13bfb5fd8ba.1703013352.git.marcelo.schmitt1@gmail.com>
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
X-Proofpoint-ORIG-GUID: b0LN6lQUDGQx5MjS3QI8J3CZDMFfKosV
X-Proofpoint-GUID: b0LN6lQUDGQx5MjS3QI8J3CZDMFfKosV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190152

Some code generic to AD7091R devices such as channel definitions were in
the AD7091R-5 driver. There was also some generic register definitions
declared in the base driver which would make more sense to be in the
header file.
The device state struct will be needed for the ad7091r8 driver in a
follow up patch so that ought to be moved to the header file as well.
Lastly, a couple of regmap callback functions are also capable of
abstracting characteristics of different AD7091R devices and those are
now being exported to IIO_AD7091R name space.

Move AD7091R generic code either to the base driver or to the header
file so both the ad7091r5 and the ad7091r8 driver can use those
declaration in follow up patches.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 29 ++++---------------------
 drivers/iio/adc/ad7091r-base.h | 39 +++++++++++++++++++++++++++++++++-
 drivers/iio/adc/ad7091r5.c     | 11 ----------
 3 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 7ccc9b44dcd8..3f05e94c756f 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -16,14 +16,6 @@
 
 #include "ad7091r-base.h"
 
-#define AD7091R_REG_RESULT  0
-#define AD7091R_REG_CHANNEL 1
-#define AD7091R_REG_CONF    2
-#define AD7091R_REG_ALERT   3
-#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
-#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
-#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
-
 /* AD7091R_REG_RESULT */
 #define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
@@ -36,21 +28,6 @@
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
 const struct iio_event_spec ad7091r_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -432,7 +409,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
-static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -442,8 +419,9 @@ static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, IIO_AD7091R);
 
-static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -453,6 +431,7 @@ static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, IIO_AD7091R);
 
 const struct regmap_config ad7091r_regmap_config = {
 	.reg_bits = 8,
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index b9e1c8bf3440..b63c658a9d23 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,14 +8,48 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#define AD7091R_REG_RESULT  0
+#define AD7091R_REG_CHANNEL 1
+#define AD7091R_REG_CONF    2
+#define AD7091R_REG_ALERT   3
+#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
+#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
+#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
+
 #define AD7091R_REG_CONF_INT_VREF	BIT(0)
 
 /* AD7091R_REG_CH_LIMIT */
 #define AD7091R_HIGH_LIMIT		0xFFF
 #define AD7091R_LOW_LIMIT		0x0
 
+#define AD7091R_CHANNEL(idx, bits, ev, num_ev) {			\
+	.type = IIO_VOLTAGE,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.indexed = 1,							\
+	.channel = idx,							\
+	.event_spec = ev,						\
+	.num_event_specs = num_ev,					\
+	.scan_type.storagebits = 16,					\
+	.scan_type.realbits = bits,					\
+}
+
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
@@ -31,4 +65,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 		const struct ad7091r_chip_info *chip_info,
 		struct regmap *map, int irq);
 
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg);
+
 #endif /* __DRIVERS_IIO_ADC_AD7091R_BASE_H__ */
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index dae98c95ebb8..9d3ccfca94ec 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -12,17 +12,6 @@
 
 #include "ad7091r-base.h"
 
-#define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
-	.type = IIO_VOLTAGE, \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.indexed = 1, \
-	.channel = idx, \
-	.event_spec = ev, \
-	.num_event_specs = num_ev, \
-	.scan_type.storagebits = 16, \
-	.scan_type.realbits = bits, \
-}
 static const struct iio_chan_spec ad7091r5_channels_irq[] = {
 	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
 	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
-- 
2.42.0


