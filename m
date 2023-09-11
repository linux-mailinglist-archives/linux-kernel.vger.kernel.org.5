Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F109779BC91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjIKUrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239959AbjIKOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:32:29 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1D5F2;
        Mon, 11 Sep 2023 07:32:25 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38BBAH3W032101;
        Mon, 11 Sep 2023 10:32:22 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t15ueg2w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:32:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 38BEWLvp051203
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 10:32:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Sep
 2023 10:32:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Sep 2023 10:32:20 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38BEWAgU027658;
        Mon, 11 Sep 2023 10:32:12 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: addac: ad74413r: update channel function set
Date:   Mon, 11 Sep 2023 17:29:50 +0300
Message-ID: <20230911142950.216687-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CCtJ4chLEFmyMIZGFW382ULxlLLy80iW
X-Proofpoint-GUID: CCtJ4chLEFmyMIZGFW382ULxlLLy80iW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309110132
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet switching to a new channel function implies
multiple steps.

All functions must be selected for a minimum of 130 μs before changing
to another function.
The DAC_CODEx registers are not reset by changing channel functions.
Prior to changing channel functions, it is recommended to set the DAC
code to 0x0000 via the DAC_CODEx registers. Set the channel function
to high impedance via the CH_FUNC_SETUPx registers before transitioning
to the new channel function. After the new channel function is configured,
it is recommended to wait 150 μs before updating the DAC code.

Even though the channel switch is done at only at probe, where a device
reset is performed, that does not guarantee that the steps prior
changing to new channel function should be neglected.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/addac/ad74413r.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 6b0e8218f150..7b9ebb481815 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -441,12 +441,30 @@ static int ad74413r_set_channel_function(struct ad74413r_state *st,
 {
 	int ret;
 
+	ret = regmap_update_bits(st->regmap,
+				 AD74413R_REG_CH_FUNC_SETUP_X(channel),
+				 AD74413R_CH_FUNC_SETUP_MASK,
+				 CH_FUNC_HIGH_IMPEDANCE);
+	if (ret)
+		return ret;
+
+	/* Set DAC code to 0 prior to changing channel function */
+	ret = ad74413r_set_channel_dac_code(st, channel, 0);
+	if (ret)
+		return ret;
+
+	/* Delay required before transition to new desired mode */
+	usleep_range(130, 150);
+
 	ret = regmap_update_bits(st->regmap,
 				  AD74413R_REG_CH_FUNC_SETUP_X(channel),
 				  AD74413R_CH_FUNC_SETUP_MASK, func);
 	if (ret)
 		return ret;
 
+	/* Delay required before updating the new DAC code */
+	usleep_range(150, 170);
+
 	if (func == CH_FUNC_CURRENT_INPUT_LOOP_POWER)
 		ret = regmap_set_bits(st->regmap,
 				      AD74413R_REG_ADC_CONFIG_X(channel),
-- 
2.42.0

