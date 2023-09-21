Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC967A9B57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjIUS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIUS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:57:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A5BF111;
        Thu, 21 Sep 2023 11:51:43 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38LE1Lp5004679;
        Thu, 21 Sep 2023 10:20:59 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t8dv9u6rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 10:20:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38LEKwed016548
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 10:20:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 21 Sep 2023 10:20:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 21 Sep 2023 10:20:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 21 Sep 2023 10:20:57 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38LEKdFW020713;
        Thu, 21 Sep 2023 10:20:48 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] drivers: hwmon: max31827: handle vdd regulator
Date:   Thu, 21 Sep 2023 17:20:04 +0300
Message-ID: <20230921142005.102263-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230921142005.102263-1-antoniu.miclaus@analog.com>
References: <20230921142005.102263-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: sfXD8LUFLHlsKfR9WXR6hCoil21wjcZd
X-Proofpoint-GUID: sfXD8LUFLHlsKfR9WXR6hCoil21wjcZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=704 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309210123
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing implementation for the max31827 supply regulator.
This is a hardware required property that is not handled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/hwmon/max31827.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 602f4e4f81ff..43709f47f518 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -427,6 +427,11 @@ static int max31827_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to allocate regmap.\n");
 
+	err = devm_regulator_get_enable(dev, "vdd");
+	if (err)
+		return dev_err_probe(dev, err,
+				     "failed to enable vdd regulator\n");
+
 	err = max31827_init_client(st);
 	if (err)
 		return err;
-- 
2.42.0

