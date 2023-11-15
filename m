Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFB7EC06B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjKOK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjKOK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:28:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0DFF5;
        Wed, 15 Nov 2023 02:28:46 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF8UIfw008664;
        Wed, 15 Nov 2023 10:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=biTKcBkduKS9Btt6KyQBvzx3Ku8HKlge9gVh55vfer4=;
 b=JqRPPSn30NHko9OKGKZgd0Gh8/sgz6G+oOVZA/I+IRixByVjApdnN/4BLGNIuYu6Bqz5
 wEHARsJt2GvQvA/uCdMwauqcfdgqFHmPO3A/GfMwnGbMaecMhGRNmcgnc4aRKpIor3UD
 x6U337iWVeU+//lrgjCdEboxpwfyLCIxDmQL4nEUJOyCj2Ap5La7IH4rSA84OxPsgS4B
 fYExxZIuHNFGBBjyK+HIewcodvDQtx20syAgpRXFVVJjaSbzFHYHI3DgRl2xdoYBfsfq
 gbBJbIpoKhfdjpVN4QY85Svqbjuzze8uZAOQ4ahdpwslrNApSAgujEsbbTdTP2neuHMe Cg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uchkyh9un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 10:28:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFAShGo004241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 10:28:43 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 02:28:38 -0800
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] pinctrl: avoid reload of p state in list iteration
Date:   Wed, 15 Nov 2023 18:28:24 +0800
Message-ID: <20231115102824.23727-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4bLluzVZbz0odrejcKR7HjVzZvuiGWuP
X-Proofpoint-ORIG-GUID: 4bLluzVZbz0odrejcKR7HjVzZvuiGWuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_08,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=960
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150079
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in the list_for_each_entry iteration, reload of p->state->settings
with a local setting from old_state will makes the list iteration in a
infinite loop.
The typical issue happened, it will frequently have printk message like:
  "not freeing pin xx (xxx) as part of deactivating group xxx - it is
already used for some other setting".
This is a compiler-dependent problem, one instance was got using Clang
version 10.0 plus arm64 architecture with linux version 4.19.

Fixes: 6e5e959dde0d ("pinctrl: API changes to support multiple states per device")
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
Cc: stable@vger.kernel.org
---
 drivers/pinctrl/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 1fa89be29b8f..f2977eb65522 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1262,17 +1262,17 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
+	struct pinctrl_state *old_state = READ_ONCE(p->state);
 	int ret;
 
-	if (p->state) {
+	if (old_state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
 		 * of mux owner for that pingroup. Any pingroups which are
 		 * still owned by the new state will be re-acquired by the call
 		 * to pinmux_enable_setting() in the loop below.
 		 */
-		list_for_each_entry(setting, &p->state->settings, node) {
+		list_for_each_entry(setting, &old_state->settings, node) {
 			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
 				continue;
 			pinmux_disable_setting(setting);

base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
-- 
2.17.1

