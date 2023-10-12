Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0555C7C6E06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378675AbjJLMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378591AbjJLMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:25:19 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1BC0;
        Thu, 12 Oct 2023 05:25:17 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39CBpnU7007892;
        Thu, 12 Oct 2023 08:25:15 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tpd4t19px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 08:25:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39CCPExi017576
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Oct 2023 08:25:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 12 Oct
 2023 08:25:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Oct 2023 08:25:13 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.174])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39CCP3l1015110;
        Thu, 12 Oct 2023 08:25:09 -0400
From:   Ramona Gradinariu <ramona.gradinariu@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH 1/1] drivers: imu: adis16475.c: Remove scan index from delta channels
Date:   Thu, 12 Oct 2023 15:24:56 +0300
Message-ID: <20231012122456.765709-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012122456.765709-1-ramona.gradinariu@analog.com>
References: <20231012122456.765709-1-ramona.gradinariu@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: GB95BsAuSEPEpgDTaJLyBjp4fZAqn8Ee
X-Proofpoint-ORIG-GUID: GB95BsAuSEPEpgDTaJLyBjp4fZAqn8Ee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310120101
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices do not support delta angle and delta velocity
burst readings, which means there should be no buffer support
for these types of channels.
A new list of channels is created which contains the delta
channels structures with the scan index equal to -1 to allow
for raw register readings, without buffer support.
This list of channels is assigned to the devices which
do not support delta angle and delta velocity burst
readings.

Fixes: 8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delta velocity channels")
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
 drivers/iio/imu/adis16475.c | 67 +++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 9af07fec0d89..b7cbe1565aee 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -604,7 +604,15 @@ static int adis16475_write_raw(struct iio_dev *indio_dev,
 	ADIS16475_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
 			   ADIS16475_REG_ ## _mod ## _DELTVEL_L, ADIS16475_SCAN_DELTVEL_ ## _mod, 32, 32)
 
-static const struct iio_chan_spec adis16475_channels[] = {
+#define ADIS16475_DELTANG_CHAN_NO_SCAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_DELTA_ANGL, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTANG_L, -1, 32, 32)
+
+#define ADIS16475_DELTVEL_CHAN_NO_SCAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTVEL_L, -1, 32, 32)
+
+static const struct iio_chan_spec adis16477_channels[] = {
 	ADIS16475_GYRO_CHANNEL(X),
 	ADIS16475_GYRO_CHANNEL(Y),
 	ADIS16475_GYRO_CHANNEL(Z),
@@ -621,6 +629,23 @@ static const struct iio_chan_spec adis16475_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(13)
 };
 
+static const struct iio_chan_spec adis16475_channels[] = {
+	ADIS16475_GYRO_CHANNEL(X),
+	ADIS16475_GYRO_CHANNEL(Y),
+	ADIS16475_GYRO_CHANNEL(Z),
+	ADIS16475_ACCEL_CHANNEL(X),
+	ADIS16475_ACCEL_CHANNEL(Y),
+	ADIS16475_ACCEL_CHANNEL(Z),
+	ADIS16475_TEMP_CHANNEL(),
+	ADIS16475_DELTANG_CHAN_NO_SCAN(X),
+	ADIS16475_DELTANG_CHAN_NO_SCAN(Y),
+	ADIS16475_DELTANG_CHAN_NO_SCAN(Z),
+	ADIS16475_DELTVEL_CHAN_NO_SCAN(X),
+	ADIS16475_DELTVEL_CHAN_NO_SCAN(Y),
+	ADIS16475_DELTVEL_CHAN_NO_SCAN(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(7)
+};
+
 enum adis16475_variant {
 	ADIS16470,
 	ADIS16475_1,
@@ -782,8 +807,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16477_1] = {
 		.name = "adis16477-1",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
 		.accel_max_val = 1,
@@ -800,8 +825,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16477_2] = {
 		.name = "adis16477-2",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
 		.accel_max_val = 1,
@@ -818,8 +843,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16477_3] = {
 		.name = "adis16477-3",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 1,
@@ -938,8 +963,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16500] = {
 		.name = "adis16500",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 392,
@@ -957,8 +982,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
 		.accel_max_val = 78,
@@ -976,8 +1001,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16505_2] = {
 		.name = "adis16505-2",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
 		.accel_max_val = 78,
@@ -995,8 +1020,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16505_3] = {
 		.name = "adis16505-3",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 78,
@@ -1014,8 +1039,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16507_1] = {
 		.name = "adis16507-1",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(160 << 16),
 		.accel_max_val = 392,
@@ -1033,8 +1058,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16507_2] = {
 		.name = "adis16507-2",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
 		.accel_max_val = 392,
@@ -1052,8 +1077,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 	},
 	[ADIS16507_3] = {
 		.name = "adis16507-3",
-		.num_channels = ARRAY_SIZE(adis16475_channels),
-		.channels = adis16475_channels,
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
 		.gyro_max_val = 1,
 		.gyro_max_scale = IIO_RAD_TO_DEGREE(10 << 16),
 		.accel_max_val = 392,
-- 
2.34.1

