Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451175952D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGSMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGSMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:32:21 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA313E;
        Wed, 19 Jul 2023 05:32:19 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JAJBML020557;
        Wed, 19 Jul 2023 08:32:16 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rx7bu2vj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 08:32:16 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36JCWFtU060461
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jul 2023 08:32:15 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jul 2023 08:32:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jul 2023 08:32:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jul 2023 08:32:14 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.149])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36JCW1af008419;
        Wed, 19 Jul 2023 08:32:10 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v2 3/3] iio: imu: adis16475.c: Add delta angle and delta velocity channels
Date:   Wed, 19 Jul 2023 15:31:52 +0300
Message-ID: <20230719123152.309624-4-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719123152.309624-1-ramona.bolboaca@analog.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TxrWFI2A_Wk85-6E7eDDdWAyQfeZGtnI
X-Proofpoint-GUID: TxrWFI2A_Wk85-6E7eDDdWAyQfeZGtnI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190112
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
 drivers/iio/imu/adis16475.c | 210 +++++++++++++++++++++++++++++++-----
 1 file changed, 184 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 17275a53ca2c..e92b42974ee6 100644
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
@@ -65,6 +73,8 @@
 #define ADIS16475_BURST_MAX_SPEED	1000000
 #define ADIS16475_LSB_DEC_MASK		BIT(0)
 #define ADIS16475_LSB_FIR_MASK		BIT(1)
+#define ADIS16500_BURST_DATA_SEL_0_CHN_MASK	(GENMASK(6, 0) | BIT(13))
+#define ADIS16500_BURST_DATA_SEL_1_CHN_MASK	GENMASK(13, 6)
 
 enum {
 	ADIS16475_SYNC_DIRECT = 1,
@@ -90,6 +100,8 @@ struct adis16475_chip_info {
 	u32 accel_max_val;
 	u32 accel_max_scale;
 	u32 temp_scale;
+	u32 deltang_max_val;
+	u32 deltvel_max_val;
 	u32 int_clk;
 	u16 max_dec;
 	u8 num_sync;
@@ -115,6 +127,12 @@ enum {
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
@@ -451,6 +469,14 @@ static int adis16475_read_raw(struct iio_dev *indio_dev,
 		case IIO_TEMP:
 			*val = st->info->temp_scale;
 			return IIO_VAL_INT;
+		case IIO_ROT:
+			*val = st->info->deltang_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_VELOCITY:
+			*val = st->info->deltvel_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
@@ -551,6 +577,40 @@ static int adis16475_write_raw(struct iio_dev *indio_dev,
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
+	ADIS16475_MOD_CHAN_DELTA(IIO_ROT, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTANG_L, ADIS16475_SCAN_DELTANG_ ## _mod, 32, 32)
+
+#define ADIS16475_DELTVEL_CHAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTVEL_L, ADIS16475_SCAN_DELTVEL_ ## _mod, 32, 32)
+
+#define ADIS16475_DELTANG_CHAN_NO_SCAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_ROT, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTANG_L, -1, 32, 32)
+
+#define ADIS16475_DELTVEL_CHAN_NO_SCAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTVEL_L, -1, 32, 32)
+
 static const struct iio_chan_spec adis16475_channels[] = {
 	ADIS16475_GYRO_CHANNEL(X),
 	ADIS16475_GYRO_CHANNEL(Y),
@@ -559,7 +619,30 @@ static const struct iio_chan_spec adis16475_channels[] = {
 	ADIS16475_ACCEL_CHANNEL(Y),
 	ADIS16475_ACCEL_CHANNEL(Z),
 	ADIS16475_TEMP_CHANNEL(),
-	IIO_CHAN_SOFT_TIMESTAMP(7)
+	IIO_CHAN_SOFT_TIMESTAMP(7),
+	ADIS16475_DELTANG_CHAN_NO_SCAN(X),
+	ADIS16475_DELTANG_CHAN_NO_SCAN(Y),
+	ADIS16475_DELTANG_CHAN_NO_SCAN(Z),
+	ADIS16475_DELTVEL_CHAN_NO_SCAN(X),
+	ADIS16475_DELTVEL_CHAN_NO_SCAN(Y),
+	ADIS16475_DELTVEL_CHAN_NO_SCAN(Z)
+};
+
+static const struct iio_chan_spec adis16500_channels[] = {
+	ADIS16475_GYRO_CHANNEL(X),
+	ADIS16475_GYRO_CHANNEL(Y),
+	ADIS16475_GYRO_CHANNEL(Z),
+	ADIS16475_ACCEL_CHANNEL(X),
+	ADIS16475_ACCEL_CHANNEL(Y),
+	ADIS16475_ACCEL_CHANNEL(Z),
+	ADIS16475_TEMP_CHANNEL(),
+	ADIS16475_DELTANG_CHAN(X),
+	ADIS16475_DELTANG_CHAN(Y),
+	ADIS16475_DELTANG_CHAN(Z),
+	ADIS16475_DELTVEL_CHAN(X),
+	ADIS16475_DELTVEL_CHAN(Y),
+	ADIS16475_DELTVEL_CHAN(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(13)
 };
 
 enum adis16475_variant {
@@ -662,6 +745,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -677,6 +762,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -692,6 +779,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -707,6 +796,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -715,13 +806,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16477_1] = {
 		.name = "adis16477-1",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -731,13 +824,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16477_2] = {
 		.name = "adis16477-2",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -747,13 +842,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16477_3] = {
 		.name = "adis16477-3",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -770,6 +867,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -785,6 +884,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -800,6 +901,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -815,6 +918,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -830,6 +935,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -845,6 +952,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -853,13 +962,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16500] = {
 		.name = "adis16500",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -870,13 +981,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -887,13 +1000,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16505_2] = {
 		.name = "adis16505-2",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -904,13 +1019,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16505_3] = {
 		.name = "adis16505-3",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -921,13 +1038,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16507_1] = {
 		.name = "adis16507-1",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -938,13 +1057,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16507_2] = {
 		.name = "adis16507-2",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -955,13 +1076,15 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16507_3] = {
 		.name = "adis16507-3",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16500_channels),
+		.channels = adis16500_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -972,10 +1095,40 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 };
 
+static const unsigned long adis16475_avail_scan_masks[] = {
+	ADIS16500_BURST_DATA_SEL_0_CHN_MASK,
+	ADIS16500_BURST_DATA_SEL_1_CHN_MASK,
+	0
+};
+
+static int adis16475_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	u16 en;
+	int ret;
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	if (st->info->has_burst32) {
+		if (*scan_mask & ADIS16500_BURST_DATA_SEL_0_CHN_MASK)
+			en = ADIS16500_BURST_DATA_SEL(0);
+		else if (*scan_mask & ADIS16500_BURST_DATA_SEL_1_CHN_MASK)
+			en = ADIS16500_BURST_DATA_SEL(1);
+		else
+			return -EINVAL;
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
 
@@ -1044,7 +1197,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
-	int ret, bit, i = 0;
+	int ret, bit, buff_offset = 0, i = 0;
 	__be16 *buffer;
 	u16 crc;
 	bool valid;
@@ -1074,6 +1227,9 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 		case ADIS16475_SCAN_TEMP:
 			st->data[i++] = buffer[offset];
 			break;
+		case ADIS16475_SCAN_DELTANG_X ... ADIS16475_SCAN_DELTVEL_Z:
+			buff_offset = ADIS16475_SCAN_DELTANG_X;
+			fallthrough;
 		case ADIS16475_SCAN_GYRO_X ... ADIS16475_SCAN_ACCEL_Z:
 			/*
 			 * The first 2 bytes on the received data are the
@@ -1081,11 +1237,11 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
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
@@ -1314,6 +1470,8 @@ static int adis16475_probe(struct spi_device *spi)
 	indio_dev->num_channels = st->info->num_channels;
 	indio_dev->info = &adis16475_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (st->info->has_burst32)
+		indio_dev->available_scan_masks = adis16475_avail_scan_masks;
 
 	ret = __adis_initial_startup(&st->adis);
 	if (ret)
-- 
2.25.1

