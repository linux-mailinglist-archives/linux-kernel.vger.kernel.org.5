Return-Path: <linux-kernel+bounces-2304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F9815AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650CA285DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF531A82;
	Sat, 16 Dec 2023 17:48:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38740315A7;
	Sat, 16 Dec 2023 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGFkJTr011007;
	Sat, 16 Dec 2023 12:47:48 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3v1etvg8p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 12:47:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3BGHlkfb033993
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 16 Dec 2023 12:47:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 16 Dec
 2023 12:47:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 16 Dec 2023 12:47:45 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3BGHlRp3015802;
	Sat, 16 Dec 2023 12:47:30 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dan.carpenter@linaro.org>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/15] iio: adc: ad7091r: Move generic AD7091R code to base driver and header file
Date: Sat, 16 Dec 2023 14:47:25 -0300
Message-ID: <6cab8108613aec0707c02587f5f6b9396fbd9831.1702746240.git.marcelo.schmitt1@gmail.com>
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
X-Proofpoint-GUID: xnh2lfqpKob4BNFapLTvb2BEW8jbyRtE
X-Proofpoint-ORIG-GUID: xnh2lfqpKob4BNFapLTvb2BEW8jbyRtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160137

Some code generic to AD7091R devices such as channel definitions and
event spec structs were in the AD7091R-5 driver.
There was also some generic register definitions declared in the base
driver which would make more sense to be in the header file.
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
 drivers/iio/adc/ad7091r-base.c | 46 +++++++++++++++++-----------------
 drivers/iio/adc/ad7091r-base.h | 42 ++++++++++++++++++++++++++++++-
 drivers/iio/adc/ad7091r5.c     | 39 +++-------------------------
 3 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index d3d287d3b953..0d1f544de07a 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -15,14 +15,6 @@
 
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
@@ -35,20 +27,26 @@
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
+const struct iio_event_spec ad7091r_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
+	},
 };
+EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
 
 static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 {
@@ -269,7 +267,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
-static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -279,8 +277,9 @@ static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, IIO_AD7091R);
 
-static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -290,6 +289,7 @@ static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, IIO_AD7091R);
 
 const struct regmap_config ad7091r_regmap_config = {
 	.reg_bits = 8,
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 509748aef9b1..1d30eeb46bcc 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,8 +8,43 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#define AD7091R_REG_RESULT  0
+#define AD7091R_REG_CHANNEL 1
+#define AD7091R_REG_CONF    2
+#define AD7091R_REG_ALERT   3
+
+#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
+#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
+#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
+
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
@@ -17,10 +52,15 @@ struct ad7091r_chip_info {
 	unsigned int vref_mV;
 };
 
+extern const struct iio_event_spec ad7091r_events[3];
+
 extern const struct regmap_config ad7091r_regmap_config;
 
 int ad7091r_probe(struct device *dev, const char *name,
 		const struct ad7091r_chip_info *chip_info,
 		struct regmap *map, int irq);
 
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg);
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg);
+
 #endif /* __DRIVERS_IIO_ADC_AD7091R_BASE_H__ */
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 2f048527b7b7..9d3ccfca94ec 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -12,42 +12,11 @@
 
 #include "ad7091r-base.h"
 
-static const struct iio_event_spec ad7091r5_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
-	},
-};
-
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
-	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
 };
 
 static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
-- 
2.42.0


