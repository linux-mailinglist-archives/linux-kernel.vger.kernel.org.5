Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B12769507
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGaLgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGaLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:36:40 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD46E57;
        Mon, 31 Jul 2023 04:36:37 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V812o2020043;
        Mon, 31 Jul 2023 05:45:25 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s66qmsr6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:45:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36V9jDfg006532
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 05:45:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 31 Jul
 2023 05:45:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 31 Jul 2023 05:45:12 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36V9iwH7024100;
        Mon, 31 Jul 2023 05:45:04 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/2] drivers: iio: admv1013: add vcc regulators
Date:   Mon, 31 Jul 2023 12:44:55 +0300
Message-ID: <20230731094455.26742-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731094455.26742-1-antoniu.miclaus@analog.com>
References: <20230731094455.26742-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: dUpWPT6YWkYVA-iYC99N3i8Sjb23EmvM
X-Proofpoint-ORIG-GUID: dUpWPT6YWkYVA-iYC99N3i8Sjb23EmvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_03,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307310088
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators for the VCC supplies of the admv1013.

The patch aims to align the implementation with the current admv1014
driver where all the VCC supplies are handled as regulators.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - add missing spaces in the commit subject.
 - use dev_err_probe for error handling.
 -  - use `devm_regulator_bulk_get_enable`
 drivers/iio/frequency/admv1013.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9bf8337806fc..cc01fac2dfee 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -379,6 +379,11 @@ static const struct iio_info admv1013_info = {
 	.debugfs_reg_access = &admv1013_reg_access,
 };
 
+static const char * const admv1013_vcc_regs[] = {
+	 "vcc-drv", "vcc2-drv", "vcc-vva", "vcc-amp1", "vcc-amp2",
+	 "vcc-env", "vcc-bg", "vcc-bg2", "vcc-mixer", "vcc-quad"
+};
+
 static int admv1013_freq_change(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct admv1013_state *st = container_of(nb, struct admv1013_state, nb);
@@ -554,6 +559,15 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
 				     "failed to get the common-mode voltage\n");
 
+	ret = devm_regulator_bulk_get_enable(&st->spi->dev,
+					     ARRAY_SIZE(admv1013_vcc_regs),
+					     admv1013_vcc_regs);
+	if (ret) {
+		dev_err_probe(&spi->dev, ret,
+			      "Failed to request VCC regulators\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.41.0

