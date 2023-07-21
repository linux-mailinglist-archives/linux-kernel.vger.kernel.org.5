Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7F75C6A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGUMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGUMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:11:35 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4751701;
        Fri, 21 Jul 2023 05:11:34 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LBgXRs013807;
        Fri, 21 Jul 2023 08:11:20 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ryp729b3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:11:20 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36LCBJZR016182
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jul 2023 08:11:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Jul 2023 08:11:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Jul 2023 08:11:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Jul 2023 08:11:17 -0400
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.18.29])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36LCB36m010716;
        Fri, 21 Jul 2023 08:11:06 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH] iio: amplifiers: ad8366: add support for HMC792A Attenuator
Date:   Fri, 21 Jul 2023 20:10:38 +0800
Message-ID: <20230721121038.183404-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: t-GP9sCfGX-yVXUKBzpcUnsFsFBAptQy
X-Proofpoint-GUID: t-GP9sCfGX-yVXUKBzpcUnsFsFBAptQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210109
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for the HMC792A Digital Attenuator. The
HMC792A is a broadband 6-bit GaAs MMIC Digital Attenuator operating
from DC to 6.0 GHz with 15.75 dB attenuation control range in 0.25 dB steps.

Datasheet link:
  https://www.analog.com/media/en/technical-documentation/data-sheets/hmc792a.pdf

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |  1 +
 drivers/iio/amplifiers/ad8366.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index f217a2a1e..b54fe0173 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -18,6 +18,7 @@ config AD8366
 	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
 	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
 	    ADL5240 Digitally controlled variable gain amplifier (VGA)
+	    HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
 	    HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 8d8c8ea94..31564afb1 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -5,6 +5,7 @@
  *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
  *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
  *   ADL5240 Digitally controlled variable gain amplifier (VGA)
+ *   HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
  *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
  *
  * Copyright 2012-2019 Analog Devices Inc.
@@ -28,6 +29,7 @@ enum ad8366_type {
 	ID_AD8366,
 	ID_ADA4961,
 	ID_ADL5240,
+	ID_HMC792,
 	ID_HMC1119,
 };
 
@@ -64,6 +66,10 @@ static struct ad8366_info ad8366_infos[] = {
 		.gain_min = -11500,
 		.gain_max = 20000,
 	},
+	[ID_HMC792] = {
+		.gain_min = -15750,
+		.gain_max = 0,
+	},
 	[ID_HMC1119] = {
 		.gain_min = -31750,
 		.gain_max = 0,
@@ -90,6 +96,7 @@ static int ad8366_write(struct iio_dev *indio_dev,
 	case ID_ADL5240:
 		st->data[0] = (ch_a & 0x3F);
 		break;
+	case ID_HMC792:
 	case ID_HMC1119:
 		st->data[0] = ch_a;
 		break;
@@ -127,6 +134,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 		case ID_ADL5240:
 			gain = 20000 - 31500 + code * 500;
 			break;
+		case ID_HMC792:
+			gain = -1 * code * 500;
+			break;
 		case ID_HMC1119:
 			gain = -1 * code * 250;
 			break;
@@ -176,6 +186,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	case ID_ADL5240:
 		code = ((gain - 500 - 20000) / 500) & 0x3F;
 		break;
+	case ID_HMC792:
+		code = (abs(gain) / 500) & 0x3F;
+		break;
 	case ID_HMC1119:
 		code = (abs(gain) / 250) & 0x7F;
 		break;
@@ -261,6 +274,7 @@ static int ad8366_probe(struct spi_device *spi)
 		break;
 	case ID_ADA4961:
 	case ID_ADL5240:
+	case ID_HMC792:
 	case ID_HMC1119:
 		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
 		if (IS_ERR(st->reset_gpio)) {
@@ -314,6 +328,7 @@ static const struct spi_device_id ad8366_id[] = {
 	{"ad8366",  ID_AD8366},
 	{"ada4961", ID_ADA4961},
 	{"adl5240", ID_ADL5240},
+	{"hmc792a", ID_HMC792},
 	{"hmc1119", ID_HMC1119},
 	{}
 };

base-commit: f7e3a1bafdea735050dfde00523cf505dc7fd309
-- 
2.34.1

