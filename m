Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF17690D7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGaIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGaIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:52:47 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D699B1;
        Mon, 31 Jul 2023 01:50:52 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V7uMcG020034;
        Mon, 31 Jul 2023 04:50:50 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s66qmsemh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:50:45 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36V8oa9h003465
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 04:50:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 31 Jul 2023 04:50:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 31 Jul 2023 04:50:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 31 Jul 2023 04:50:35 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36V8oRSk021400;
        Mon, 31 Jul 2023 04:50:29 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/2] drivers: iio: filter: admv8818: add bypass mode
Date:   Mon, 31 Jul 2023 11:49:26 +0300
Message-ID: <20230731084928.8302-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _n5wMm9NFkG1JKCnt6RR194WZdKzk8kq
X-Proofpoint-ORIG-GUID: _n5wMm9NFkG1JKCnt6RR194WZdKzk8kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_02,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307310079
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add filter bypass mode, which bypasses the low pass filter, high pass
filter and disables/unregister the clock rate notifier.

Currently a feature like bypassing the filter is not achievable
straightforward and not very deductive. The user has to look through the
code and call the set_lpf_3db_frequency and set_hpf_3db_frequency iio
attributes from the user interface using the corner cases (freq >
largest lpf supported by the part, respectively freq < smallest hpf
supported by the part). Moreover, in such case of bypassing the filter,
the input clock rate change might mess up things so we want to make sure
that it is disabled. Also, the feature will help emphasizing the filter
behavior, therefore adding it in the userspace will ease the
charcaterization of the filter's effects when active/disabled.

It was requested by users of the driver to ease the interaction with
different configuration modes of the device.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - improve code readability when setting the filter modes
 - add more explanations regarding the necessity of this feature in the commit
   body.
 drivers/iio/filter/admv8818.c | 65 ++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index fe8d46cb7f1d..848baa6e3bbf 100644
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
@@ -411,14 +443,22 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 
 	if (!st->clkin) {
 		if (mode == ADMV8818_MANUAL_MODE)
-			return 0;
+			goto set_mode;
+
+		if (mode == ADMV8818_BYPASS_MODE) {
+			ret = admv8818_filter_bypass(st);
+			if (ret)
+				return ret;
+
+			goto set_mode;
+		}
 
 		return -EINVAL;
 	}
 
 	switch (mode) {
 	case ADMV8818_AUTO_MODE:
-		if (!st->filter_mode)
+		if (st->filter_mode == ADMV8818_AUTO_MODE)
 			return 0;
 
 		ret = clk_prepare_enable(st->clkin);
@@ -434,20 +474,27 @@ static int admv8818_set_mode(struct iio_dev *indio_dev,
 
 		break;
 	case ADMV8818_MANUAL_MODE:
-		if (st->filter_mode)
-			return 0;
+	case ADMV8818_BYPASS_MODE:
+		if (st->filter_mode == ADMV8818_AUTO_MODE) {
+			clk_disable_unprepare(st->clkin);
 
-		clk_disable_unprepare(st->clkin);
+			ret = clk_notifier_unregister(st->clkin, &st->nb);
+			if (ret)
+				return ret;
+		}
 
-		ret = clk_notifier_unregister(st->clkin, &st->nb);
-		if (ret)
-			return ret;
+		if (mode == ADMV8818_BYPASS_MODE) {
+			ret = admv8818_filter_bypass(st);
+			if (ret)
+				return ret;
+		}
 
 		break;
 	default:
 		return -EINVAL;
 	}
 
+set_mode:
 	st->filter_mode = mode;
 
 	return ret;
-- 
2.41.0

