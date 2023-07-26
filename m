Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB376394F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjGZOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjGZOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:36:16 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29707E7E;
        Wed, 26 Jul 2023 07:36:12 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QDQaOW025947;
        Wed, 26 Jul 2023 10:36:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s34cj8eje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 10:36:09 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36QEa7vY040781
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 10:36:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 26 Jul
 2023 10:36:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Jul 2023 10:36:06 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36QEZwi8029912;
        Wed, 26 Jul 2023 10:36:00 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] drivers: iio: filter: admv8818: add bypass mode
Date:   Wed, 26 Jul 2023 17:33:30 +0300
Message-ID: <20230726143331.66456-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JWWiTUniWTiPK0zaYZK1EZmIuJd5EFUw
X-Proofpoint-GUID: JWWiTUniWTiPK0zaYZK1EZmIuJd5EFUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 bulkscore=0 clxscore=1011 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260129
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add filter bypass mode, which bypasses the low pass filter, high pass
filter and disables/unregister the clock rate notifier.

The patch contains minimal changes in order to add the functionality.

It was requested by users of the driver to ease the interaction with
different configuration modes of the device.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/filter/admv8818.c | 51 ++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index fe8d46cb7f1d..f0d6bb606507 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -78,6 +78,7 @@ enum {
 enum {
 	ADMV8818_AUTO_MODE,
 	ADMV8818_MANUAL_MODE,
+	ADMV8818_BYPASS_MODE,
 };
 
 struct admv8818_state {
@@ -114,7 +115,8 @@ static const struct regmap_config admv8818_regmap_config = {
 
 static const char * const admv8818_modes[] = {
 	[0] = "auto",
-	[1] = "manual"
+	[1] = "manual",
+	[2] = "bypass"
 };
 
 static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
@@ -394,6 +396,36 @@ static int admv8818_reg_access(struct iio_dev *indio_dev,
 		return regmap_write(st->regmap, reg, write_val);
 }
 
+static int admv8818_filter_bypass(struct admv8818_state *st)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
+				 ADMV8818_SW_IN_SET_WR0_MSK |
+				 ADMV8818_SW_IN_WR0_MSK |
+				 ADMV8818_SW_OUT_SET_WR0_MSK |
+				 ADMV8818_SW_OUT_WR0_MSK,
+				 FIELD_PREP(ADMV8818_SW_IN_SET_WR0_MSK, 1) |
+				 FIELD_PREP(ADMV8818_SW_IN_WR0_MSK, 0) |
+				 FIELD_PREP(ADMV8818_SW_OUT_SET_WR0_MSK, 1) |
+				 FIELD_PREP(ADMV8818_SW_OUT_WR0_MSK, 0));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
+				 ADMV8818_HPF_WR0_MSK |
+				 ADMV8818_LPF_WR0_MSK,
+				 FIELD_PREP(ADMV8818_HPF_WR0_MSK, 0) |
+				 FIELD_PREP(ADMV8818_LPF_WR0_MSK, 0));
+
+exit:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static int admv8818_get_mode(struct iio_dev *indio_dev,
 			     const struct iio_chan_spec *chan)
 {
@@ -411,7 +443,10 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 
 	if (!st->clkin) {
 		if (mode == ADMV8818_MANUAL_MODE)
-			return 0;
+			goto set_mode;
+
+		if (mode == ADMV8818_BYPASS_MODE)
+			goto bypass_filter;
 
 		return -EINVAL;
 	}
@@ -434,8 +469,9 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 
 		break;
 	case ADMV8818_MANUAL_MODE:
+	case ADMV8818_BYPASS_MODE:
 		if (st->filter_mode)
-			return 0;
+			break;
 
 		clk_disable_unprepare(st->clkin);
 
@@ -448,6 +484,15 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
+bypass_filter:
+	if (st->filter_mode != ADMV8818_BYPASS_MODE &&
+	    mode == ADMV8818_BYPASS_MODE) {
+		ret = admv8818_filter_bypass(st);
+		if (ret)
+			return ret;
+	}
+
+set_mode:
 	st->filter_mode = mode;
 
 	return ret;
-- 
2.41.0

