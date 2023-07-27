Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B387650FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjG0KYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjG0KXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:23:44 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FD1BC1;
        Thu, 27 Jul 2023 03:23:43 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R70hc2027387;
        Thu, 27 Jul 2023 06:23:40 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s36ahwjs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 06:23:39 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36RANc2m030911
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 06:23:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 27 Jul
 2023 06:23:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Jul 2023 06:23:37 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36RANMXM031645;
        Thu, 27 Jul 2023 06:23:28 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] drivers:iio:admv1013: add vcc regulators
Date:   Thu, 27 Jul 2023 13:23:09 +0300
Message-ID: <20230727102309.92479-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727102309.92479-1-antoniu.miclaus@analog.com>
References: <20230727102309.92479-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: a3rnsmJ7IPhCRynzCbWQ7rQqjyOpNvPr
X-Proofpoint-GUID: a3rnsmJ7IPhCRynzCbWQ7rQqjyOpNvPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270092
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iio/frequency/admv1013.c | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 9bf8337806fc..086e2f35b52c 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -73,6 +73,7 @@
 #define ADMV1013_REG_ADDR_READ_MSK		GENMASK(6, 1)
 #define ADMV1013_REG_ADDR_WRITE_MSK		GENMASK(22, 17)
 #define ADMV1013_REG_DATA_MSK			GENMASK(16, 1)
+#define ADMV1013_VCC_NUM_REGULATORS		10
 
 enum {
 	ADMV1013_IQ_MODE,
@@ -96,6 +97,7 @@ struct admv1013_state {
 	/* Protect against concurrent accesses to the device and to data */
 	struct mutex		lock;
 	struct regulator	*reg;
+	struct regulator_bulk_data vcc_regs[ADMV1013_VCC_NUM_REGULATORS];
 	struct notifier_block	nb;
 	unsigned int		input_mode;
 	unsigned int		quad_se_mode;
@@ -379,6 +381,11 @@ static const struct iio_info admv1013_info = {
 	.debugfs_reg_access = &admv1013_reg_access,
 };
 
+static const char * const admv1013_reg_name[] = {
+	 "vcc-drv", "vcc2-drv", "vcc-vva", "vcc-amp1", "vcc-amp2",
+	 "vcc-env", "vcc-bg", "vcc-bg2", "vcc-mixer", "vcc-quad"
+};
+
 static int admv1013_freq_change(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct admv1013_state *st = container_of(nb, struct admv1013_state, nb);
@@ -495,6 +502,11 @@ static void admv1013_reg_disable(void *data)
 	regulator_disable(data);
 }
 
+static void admv1013_vcc_reg_disable(void *data)
+{
+	regulator_bulk_disable(ADMV1013_VCC_NUM_REGULATORS, data);
+}
+
 static void admv1013_powerdown(void *data)
 {
 	unsigned int enable_reg, enable_reg_msk;
@@ -520,6 +532,7 @@ static void admv1013_powerdown(void *data)
 static int admv1013_properties_parse(struct admv1013_state *st)
 {
 	int ret;
+	unsigned int i;
 	const char *str;
 	struct spi_device *spi = st->spi;
 
@@ -554,6 +567,17 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
 				     "failed to get the common-mode voltage\n");
 
+	for (i = 0; i < ADMV1013_VCC_NUM_REGULATORS; ++i)
+		st->vcc_regs[i].supply = admv1013_reg_name[i];
+
+	ret = devm_regulator_bulk_get(&st->spi->dev,
+				      ADMV1013_VCC_NUM_REGULATORS,
+				      st->vcc_regs);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to request VCC regulators");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -591,6 +615,17 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = regulator_bulk_enable(ADMV1013_VCC_NUM_REGULATORS, st->vcc_regs);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable regulators");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, admv1013_vcc_reg_disable,
+				       st->vcc_regs);
+	if (ret)
+		return ret;
+
 	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
-- 
2.41.0

