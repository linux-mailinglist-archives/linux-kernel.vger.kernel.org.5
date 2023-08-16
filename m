Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF577E004
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbjHPLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbjHPLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:09:58 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0D1985;
        Wed, 16 Aug 2023 04:09:57 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G9pGOG019132;
        Wed, 16 Aug 2023 07:09:33 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3se8g8y9w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 07:09:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 37GB9Wmb010995
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 07:09:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 16 Aug
 2023 07:09:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 16 Aug 2023 07:09:30 -0400
Received: from ubuntu.ad.analog.com ([10.48.65.222])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 37GB9Dxh027589;
        Wed, 16 Aug 2023 07:09:16 -0400
From:   Ana-Maria Cusco <ana-maria.cusco@analog.com>
To:     <ana-maria.cusco@analog.com>
CC:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iio: amplifiers: hmc425a: Add Support HMC540S 4-bit Attenuator
Date:   Wed, 16 Aug 2023 14:09:05 +0300
Message-ID: <20230816110906.144540-1-ana-maria.cusco@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Iaj7JFOyWX4afQhPhh1-fdB_-3eV22XO
X-Proofpoint-GUID: Iaj7JFOyWX4afQhPhh1-fdB_-3eV22XO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_09,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308160099
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This adds support for the Analog Devices HMC540s 1 dB LSB
Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
---
 drivers/iio/amplifiers/hmc425a.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 108f0f1685ef..e87d35d50a95 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -21,6 +21,7 @@
 
 enum hmc425a_type {
 	ID_HMC425A,
+	ID_HMC540S,
 };
 
 struct hmc425a_chip_info {
@@ -70,6 +71,9 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
 		case ID_HMC425A:
 			gain = ~code * -500;
 			break;
+		case ID_HMC540S:
+			gain = ~code * -1000;
+			break;
 		}
 
 		*val = gain / 1000;
@@ -106,6 +110,9 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
 	case ID_HMC425A:
 		code = ~((abs(gain) / 500) & 0x3F);
 		break;
+	case ID_HMC540S:
+		code = ~((abs(gain) / 1000) & 0xF);
+		break;
 	}
 
 	mutex_lock(&st->lock);
@@ -157,6 +164,7 @@ static const struct iio_chan_spec hmc425a_channels[] = {
 /* Match table for of_platform binding */
 static const struct of_device_id hmc425a_of_match[] = {
 	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
+	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
@@ -171,6 +179,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 		.gain_max = 0,
 		.default_gain = -0x40, /* set default gain -31.5db*/
 	},
+	[ID_HMC540S] = {
+		.name = "hmc540s",
+		.channels = hmc425a_channels,
+		.num_channels = ARRAY_SIZE(hmc425a_channels),
+		.num_gpios = 4,
+		.gain_min = -15000,
+		.gain_max = 0,
+		.default_gain = -0x10, /* set default gain -15.0db*/
+	},
 };
 
 static int hmc425a_probe(struct platform_device *pdev)
-- 
2.34.1

