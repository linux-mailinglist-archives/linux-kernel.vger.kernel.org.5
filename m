Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5C809042
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443757AbjLGSli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjLGSlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:41:36 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AAA1711;
        Thu,  7 Dec 2023 10:41:43 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B7Ga6LM023834;
        Thu, 7 Dec 2023 13:41:24 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3utd12hkyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:41:23 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3B7IfM2D056382
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Dec 2023 13:41:22 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:41:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Dec 2023 13:41:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Dec 2023 13:41:21 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3B7If4CX015368;
        Thu, 7 Dec 2023 13:41:07 -0500
From:   Marcelo Schmitt <marcelo.schmitt@analog.com>
To:     <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dan.carpenter@linaro.org>, <marcelo.schmitt1@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/13] iio: adc: ad7091r: Set device mode through chip_info callback
Date:   Thu, 7 Dec 2023 15:41:03 -0300
Message-ID: <84826948132ccd66b9a64617bc4eb2cbc9a3f90f.1701971344.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: usHkKPzwJmiL1Dsirtt6eZjDGO-6LRlH
X-Proofpoint-GUID: usHkKPzwJmiL1Dsirtt6eZjDGO-6LRlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
index 90470b4a98c5..f2cb638b8d77 100644
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
@@ -265,7 +229,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 	}
 
 	/* Use command mode by default to convert only desired channels*/
-	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
+	ret = st->chip_info->ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index d58e2b08015a..9546d0bf1da7 100644
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
@@ -52,6 +60,7 @@ struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
 	unsigned int vref_mV;
+	int (*ad7091r_set_mode)(struct ad7091r_state *st, enum ad7091r_mode mode);
 };
 
 struct ad7091r_init_info {
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 51aad8df7f3a..ed5e00cc82e2 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -26,11 +26,40 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
 	AD7091R_CHANNEL(3, 12, NULL, 0),
 };
 
+static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
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
+	.ad7091r_set_mode = &ad7091r_set_mode,
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
@@ -38,6 +67,7 @@ static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
 	.vref_mV = 2500,
+	.ad7091r_set_mode = &ad7091r_set_mode,
 };
 
 static const struct regmap_config ad7091r_regmap_config = {
-- 
2.42.0

