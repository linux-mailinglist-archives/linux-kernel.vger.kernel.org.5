Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D916C7A5E26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjISJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjISJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:36:02 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF3FB;
        Tue, 19 Sep 2023 02:35:55 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38J7UX37031310;
        Tue, 19 Sep 2023 05:35:36 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t6gc20e2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 05:35:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 38J9ZY4Q007720
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Sep 2023 05:35:34 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Sep 2023 05:35:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Sep 2023 05:35:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Sep 2023 05:35:33 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.230])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38J9Z1dB030605;
        Tue, 19 Sep 2023 05:35:25 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 6/7] hwmon: max31827: Update bits with shutdown_write()
Date:   Tue, 19 Sep 2023 12:34:54 +0300
Message-ID: <20230919093456.10592-6-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919093456.10592-1-daniel.matyas@analog.com>
References: <20230919093456.10592-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: M1j5ySn8LoWOo3QV9A5Esyx_6TUjdOk1
X-Proofpoint-ORIG-GUID: M1j5ySn8LoWOo3QV9A5Esyx_6TUjdOk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309190078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added 'mask' parameter to the shutdown_write() function. Now it can
either write or update bits, depending on the value of mask. This is
needed, because for alarms a write is necessary, but for resolution only
the resolution bits should be updated.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---

v4: Added patch.

 drivers/hwmon/max31827.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index d4127440ee32..957d898978fb 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -94,7 +94,7 @@ static const struct regmap_config max31827_regmap = {
 };
 
 static int shutdown_write(struct max31827_state *st, unsigned int reg,
-			  unsigned int val)
+			  unsigned int mask, unsigned int val)
 {
 	unsigned int cfg;
 	unsigned int cnv_rate;
@@ -111,7 +111,10 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
 	mutex_lock(&st->lock);
 
 	if (!st->enable) {
-		ret = regmap_write(st->regmap, reg, val);
+		if (!mask)
+			ret = regmap_write(st->regmap, reg, val);
+		else
+			ret = regmap_update_bits(st->regmap, reg, mask, val);
 		goto unlock;
 	}
 
@@ -126,7 +129,11 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
 	if (ret)
 		goto unlock;
 
-	ret = regmap_write(st->regmap, reg, val);
+	if (!mask)
+		ret = regmap_write(st->regmap, reg, val);
+	else
+		ret = regmap_update_bits(st->regmap, reg, mask, val);
+
 	if (ret)
 		goto unlock;
 
@@ -144,7 +151,7 @@ static int write_alarm_val(struct max31827_state *st, unsigned int reg,
 {
 	val = MAX31827_M_DGR_TO_16_BIT(val);
 
-	return shutdown_write(st, reg, val);
+	return shutdown_write(st, reg, 0, val);
 }
 
 static umode_t max31827_is_visible(const void *state,
-- 
2.34.1

