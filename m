Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3976FA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjHDGqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjHDGqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:46:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB348E77;
        Thu,  3 Aug 2023 23:46:28 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3745WwcG011410;
        Fri, 4 Aug 2023 02:46:19 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s8gfs3sr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 02:46:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3746kINb025368
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 02:46:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Aug 2023
 02:46:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Aug 2023 02:46:17 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.173])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3746k49l009664;
        Fri, 4 Aug 2023 02:46:12 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v3 3/3] iio: imu: adis16475.c: Add delta angle and delta velocity channels
Date:   Fri, 4 Aug 2023 09:45:59 +0300
Message-ID: <20230804064559.47192-4-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064559.47192-1-ramona.bolboaca@analog.com>
References: <20230804064559.47192-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: r3pZp_K6nYG5xzF5iDtAdQTrMIKKbayb
X-Proofpoint-GUID: r3pZp_K6nYG5xzF5iDtAdQTrMIKKbayb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308040059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for delta angle and delta velocity raw and buffer
readings to adis16475 driver.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
 drivers/iio/imu/adis16475.c | 165 +++++++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 17275a53ca2c..dbbeb80c4d23 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -31,6 +31,12 @@
 #define ADIS16475_REG_Y_ACCEL_L		0x14
 #define ADIS16475_REG_Z_ACCEL_L		0x18
 #define ADIS16475_REG_TEMP_OUT		0x1c
+#define ADIS16475_REG_X_DELTANG_L	0x24
+#define ADIS16475_REG_Y_DELTANG_L	0x28
+#define ADIS16475_REG_Z_DELTANG_L	0x2C
+#define ADIS16475_REG_X_DELTVEL_L	0x30
+#define ADIS16475_REG_Y_DELTVEL_L	0x34
+#define ADIS16475_REG_Z_DELTVEL_L	0x38
 #define ADIS16475_REG_X_GYRO_BIAS_L	0x40
 #define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
 #define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
@@ -55,6 +61,8 @@
 #define ADIS16475_REG_PROD_ID		0x72
 #define ADIS16475_REG_SERIAL_NUM	0x74
 #define ADIS16475_REG_FLASH_CNT		0x7c
+#define ADIS16500_BURST_DATA_SEL_MASK	BIT(8)
+#define ADIS16500_BURST_DATA_SEL(x)	FIELD_PREP(ADIS16500_BURST_DATA_SEL_MASK, x)
 #define ADIS16500_BURST32_MASK		BIT(9)
 #define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
 /* number of data elements in burst mode */
@@ -65,6 +73,10 @@
 #define ADIS16475_BURST_MAX_SPEED	1000000
 #define ADIS16475_LSB_DEC_MASK		BIT(0)
 #define ADIS16475_LSB_FIR_MASK		BIT(1)
+#define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	GENMASK(5, 0)
+#define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(12, 7)
+#define ADIS16475_HAS_BURST32		BIT(0)
+#define ADIS16475_HAS_BURST_DELTA_DATA	BIT(1)
 
 enum {
 	ADIS16475_SYNC_DIRECT = 1,
@@ -84,16 +96,18 @@ struct adis16475_chip_info {
 	const struct adis16475_sync *sync;
 	const struct adis_data adis_data;
 	const char *name;
+	const long flags;
 	u32 num_channels;
 	u32 gyro_max_val;
 	u32 gyro_max_scale;
 	u32 accel_max_val;
 	u32 accel_max_scale;
 	u32 temp_scale;
+	u32 deltang_max_val;
+	u32 deltvel_max_val;
 	u32 int_clk;
 	u16 max_dec;
 	u8 num_sync;
-	bool has_burst32;
 };
 
 struct adis16475 {
@@ -115,6 +129,12 @@ enum {
 	ADIS16475_SCAN_ACCEL_Y,
 	ADIS16475_SCAN_ACCEL_Z,
 	ADIS16475_SCAN_TEMP,
+	ADIS16475_SCAN_DELTANG_X,
+	ADIS16475_SCAN_DELTANG_Y,
+	ADIS16475_SCAN_DELTANG_Z,
+	ADIS16475_SCAN_DELTVEL_X,
+	ADIS16475_SCAN_DELTVEL_Y,
+	ADIS16475_SCAN_DELTVEL_Z,
 };
 
 static bool low_rate_allow;
@@ -451,6 +471,14 @@ static int adis16475_read_raw(struct iio_dev *indio_dev,
 		case IIO_TEMP:
 			*val = st->info->temp_scale;
 			return IIO_VAL_INT;
+		case IIO_DELTA_ANGL:
+			*val = st->info->deltang_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_DELTA_VELOCITY:
+			*val = st->info->deltvel_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
@@ -551,6 +579,32 @@ static int adis16475_write_raw(struct iio_dev *indio_dev,
 		}, \
 	}
 
+#define ADIS16475_MOD_CHAN_DELTA(_type, _mod, _address, _si, _r_bits, _s_bits) { \
+		.type = (_type), \
+		.modified = 1, \
+		.channel2 = (_mod), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+		.address = (_address), \
+		.scan_index = _si, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = (_r_bits), \
+			.storagebits = (_s_bits), \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16475_DELTANG_CHAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTANG_L, ADIS16475_SCAN_DELTANG_ ## _mod, 32, 32)
+
+#define ADIS16475_DELTVEL_CHAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTVEL_L, ADIS16475_SCAN_DELTVEL_ ## _mod, 32, 32)
+
 static const struct iio_chan_spec adis16475_channels[] = {
 	ADIS16475_GYRO_CHANNEL(X),
 	ADIS16475_GYRO_CHANNEL(Y),
@@ -559,7 +613,13 @@ static const struct iio_chan_spec adis16475_channels[] = {
 	ADIS16475_ACCEL_CHANNEL(Y),
 	ADIS16475_ACCEL_CHANNEL(Z),
 	ADIS16475_TEMP_CHANNEL(),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
+	ADIS16475_DELTANG_CHAN(X),
+	ADIS16475_DELTANG_CHAN(Y),
+	ADIS16475_DELTANG_CHAN(Z),
+	ADIS16475_DELTVEL_CHAN(X),
+	ADIS16475_DELTVEL_CHAN(Y),
+	ADIS16475_DELTVEL_CHAN(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(13)
 };
 
 enum adis16475_variant {
@@ -662,6 +722,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -677,6 +739,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -692,6 +756,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -707,6 +773,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -722,11 +790,13 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
 	},
 	[ADIS16477_2] = {
@@ -738,11 +808,13 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
 	},
 	[ADIS16477_3] = {
@@ -754,11 +826,13 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
 	},
 	[ADIS16465_1] = {
@@ -770,6 +844,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -785,6 +861,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -800,6 +878,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -815,6 +895,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -830,6 +912,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -845,6 +929,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -860,12 +946,14 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
 	},
 	[ADIS16505_1] = {
@@ -877,12 +965,14 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
 	},
 	[ADIS16505_2] = {
@@ -894,12 +984,14 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
 	},
 	[ADIS16505_3] = {
@@ -911,12 +1003,14 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
 	},
 	[ADIS16507_1] = {
@@ -928,12 +1022,14 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
 	},
 	[ADIS16507_2] = {
@@ -945,12 +1041,14 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
 	},
 	[ADIS16507_3] = {
@@ -962,20 +1060,46 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
-		.has_burst32 = true,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
 	},
 };
 
+static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	u16 en;
+	int ret;
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	if (st->info->flags & ADIS16475_HAS_BURST_DELTA_DATA) {
+		if ((*scan_mask & ADIS16500_BURST_DATA_SEL_0_CHN_MASK) && (*scan_mask & ADIS16500_BURST_DATA_SEL_1_CHN_MASK))
+			return -EINVAL;
+		if (*scan_mask & ADIS16500_BURST_DATA_SEL_0_CHN_MASK)
+			en = ADIS16500_BURST_DATA_SEL(0);
+		else
+			en = ADIS16500_BURST_DATA_SEL(1);
+
+		ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
+					 ADIS16500_BURST_DATA_SEL_MASK, en);
+		if (ret)
+			return ret;
+	}
+
+	return adis_update_scan_mode(indio_dev, scan_mask);
+}
+
 static const struct iio_info adis16475_info = {
 	.read_raw = &adis16475_read_raw,
 	.write_raw = &adis16475_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
+	.update_scan_mode = adis16475_update_scan_mode,
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
@@ -998,7 +1122,7 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	int ret;
 	struct adis *adis = &st->adis;
 
-	if (!st->info->has_burst32)
+	if (!(st->info->flags & ADIS16475_HAS_BURST32))
 		return;
 
 	if (st->lsb_flag && !st->burst32) {
@@ -1044,7 +1168,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
-	int ret, bit, i = 0;
+	int ret, bit, buff_offset = 0, i = 0;
 	__be16 *buffer;
 	u16 crc;
 	bool valid;
@@ -1074,6 +1198,9 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 		case ADIS16475_SCAN_TEMP:
 			st->data[i++] = buffer[offset];
 			break;
+		case ADIS16475_SCAN_DELTANG_X ... ADIS16475_SCAN_DELTVEL_Z:
+			buff_offset = ADIS16475_SCAN_DELTANG_X;
+			fallthrough;
 		case ADIS16475_SCAN_GYRO_X ... ADIS16475_SCAN_ACCEL_Z:
 			/*
 			 * The first 2 bytes on the received data are the
@@ -1081,18 +1208,18 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 			 */
 			if (st->burst32) {
 				/* upper 16 */
-				st->data[i++] = buffer[bit * 2 + 2];
+				st->data[i++] = buffer[(bit - buff_offset) * 2 + 2];
 				/* lower 16 */
-				st->data[i++] = buffer[bit * 2 + 1];
+				st->data[i++] = buffer[(bit - buff_offset) * 2 + 1];
 			} else {
-				st->data[i++] = buffer[bit + 1];
+				st->data[i++] = buffer[(bit - buff_offset) + 1];
 				/*
 				 * Don't bother in doing the manual read if the
 				 * device supports burst32. burst32 will be
 				 * enabled in the next call to
 				 * adis16475_burst32_check()...
 				 */
-				if (st->lsb_flag && !st->info->has_burst32) {
+				if (st->lsb_flag && !(st->info->flags & ADIS16475_HAS_BURST32)) {
 					u16 val = 0;
 					const u32 reg = ADIS16475_REG_X_GYRO_L +
 						bit * 4;
-- 
2.25.1

