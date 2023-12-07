Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F29809046
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443690AbjLGSkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjLGSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:40:50 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DF51711;
        Thu,  7 Dec 2023 10:40:56 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7FJ9J0008046;
        Thu, 7 Dec 2023 13:40:36 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3utd13sp86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:40:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3B7IeZb3056335
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:40:35 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:40:34 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:40:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:40:33 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7IeCqO015352;
        Thu, 7 Dec 2023 13:40:18 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/13] iio: adc: ad7091r: Move generic AD7091R code to base driver and header file
Date:   Thu, 7 Dec 2023 15:40:11 -0300
Message-ID: <29ddf20b5f23bb5d27cf977977e070f723f7feda.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 2guS8w3DoSHjfzxoDdN7jnh77uDLgzI6
X-Proofpoint-GUID: 2guS8w3DoSHjfzxoDdN7jnh77uDLgzI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312070155
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 3ecac3164446..4d0a1eeebb8a 100644
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
@@ -270,7 +268,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
-static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
+bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -280,8 +278,9 @@ static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 		return true;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, IIO_AD7091R);
 
-static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
+bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case AD7091R_REG_RESULT:
@@ -291,6 +290,7 @@ static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
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

