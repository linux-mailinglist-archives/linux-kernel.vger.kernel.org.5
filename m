Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87B7F385F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjKUVfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:35:18 -0500
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27858F4;
        Tue, 21 Nov 2023 13:35:15 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALIokTR013720;
        Tue, 21 Nov 2023 16:35:02 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3uh26h0htd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:35:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLYvi8056941
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Nov 2023 16:34:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 21 Nov
 2023 16:34:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:34:56 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLYjH1019804;
        Tue, 21 Nov 2023 16:34:47 -0500
From:   <marcelo.schmitt@analog.com>
To:     <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <marcelo.schmitt1@gmail.com>
CC:     Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] iio: adc: ad7091r-base: Set alert config and drvdata
Date:   Tue, 21 Nov 2023 18:34:45 -0300
Message-ID: <b485b1ccafad79f9ac3bb1a6b5e6d68b24ad4ad5.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1gOjFPJyWy5OsUdd5U-hk2rLpsH2Lh7y
X-Proofpoint-GUID: 1gOjFPJyWy5OsUdd5U-hk2rLpsH2Lh7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210169
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Write 1 to bit 4 in the configuration register to set ALERT/BUSY/GPO pin
to be used as ALERT.
Set device driver data so it can be retrieved when handling alert
events, avoiding null pointer dereference.

Fixes: <ca69300173b6> (iio: adc: Add support for AD7091R5 ADC)
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 8e252cde735b..3ecac3164446 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -28,6 +28,7 @@
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
 /* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
 #define AD7091R_REG_CONF_AUTO   BIT(8)
 #define AD7091R_REG_CONF_CMD    BIT(10)
 
@@ -232,9 +233,16 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->channels = chip_info->channels;
 
 	if (irq) {
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
+		if (ret)
+			return ret;
+
+		dev_set_drvdata(st->dev, iio_dev);
 		ret = devm_request_threaded_irq(dev, irq, NULL,
-				ad7091r_event_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
+						ad7091r_event_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT, name, st);
 		if (ret)
 			return ret;
 	}
-- 
2.42.0

