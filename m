Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB2375952C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGSMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGSMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:32:20 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711F186;
        Wed, 19 Jul 2023 05:32:19 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JA5khe021742;
        Wed, 19 Jul 2023 08:32:17 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rx6sju0ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 08:32:17 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 36JCWFKH014029
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jul 2023 08:32:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jul 2023 08:32:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jul 2023 08:32:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jul 2023 08:32:14 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.149])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36JCW1ae008419;
        Wed, 19 Jul 2023 08:32:08 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v2 2/3] iio: imu: adis16475.c: Add has_burst32 flag to adis16477 devices
Date:   Wed, 19 Jul 2023 15:31:51 +0300
Message-ID: <20230719123152.309624-3-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719123152.309624-1-ramona.bolboaca@analog.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IP_bXBdlJqD4eNu_6k5W5ESyvlxi7Kc_
X-Proofpoint-ORIG-GUID: IP_bXBdlJqD4eNu_6k5W5ESyvlxi7Kc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_08,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190112
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adis16477 devices support burst32 function, thus has_burst32
flag should be set to true.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
 drivers/iio/imu/adis16475.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 243f0a91fdf9..17275a53ca2c 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -726,6 +726,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.has_burst32 = true,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
 	},
 	[ADIS16477_2] = {
@@ -741,6 +742,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.has_burst32 = true,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
 	},
 	[ADIS16477_3] = {
@@ -756,6 +758,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
+		.has_burst32 = true,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
 	},
 	[ADIS16465_1] = {
-- 
2.25.1

