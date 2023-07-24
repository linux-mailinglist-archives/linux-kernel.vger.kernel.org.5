Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7D760258
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGXWb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGXWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:31:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31381BD0;
        Mon, 24 Jul 2023 15:31:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OLRSgb009885;
        Mon, 24 Jul 2023 22:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ImFe609Eic1YBB5kSpNALZ36/D9/d6110fqekqekEdU=;
 b=RM7/TIcjBTros3NwHz5w6TUhD3B1oqS6vIwMCf/5/84gNecd8GwzaGK2aQzJz5so6jp5
 S7us/4lx4b06ow+8N0JYgOgo00i/jyHcPOLoYMNyNUDJvFD2iCtK3Tjstt8DTtcCTIG+
 H72/Ndrdwm9m+pRKiN6QEhYVz7fIaRKXlvjp6RHNkR7ap+tuwurdnCT3Ln3qGhQKIhoK
 7/KmULTjPS86Pwq3zNlZurq+GJza5mYx/QOlMuGRXYajnW2CrX3gDC1pGhJSr3BjIGVd
 qJOjozdYRAbZXDw8DQxoFocUUWucm/T32rKpLeRj60Sqzpneb2sCJY8r7fVWdoRE5Ap6 TQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1y6m0dfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OMVSNX005786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:28 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 15:31:27 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Prasad Sodagudi" <quic_psodagud@quicinc.com>
Subject: [RFC PATCH 2/4] power: reset: reboot-mode: Wire reboot_mode enum to magic
Date:   Mon, 24 Jul 2023 15:30:52 -0700
Message-ID: <20230724223057.1208122-3-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724223057.1208122-1-quic_eberman@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1aDI5-AxIkTpNB5CgK5-o3dkItqfZphT
X-Proofpoint-ORIG-GUID: 1aDI5-AxIkTpNB5CgK5-o3dkItqfZphT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_17,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the reboot mode type to be wired to magic.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index a646aefa041b..4ea97ccbaf51 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -22,12 +22,8 @@ struct mode_info {
 static bool get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd, unsigned int *magic)
 {
-	const char *normal = "normal";
 	struct mode_info *info;
 
-	if (!cmd)
-		cmd = normal;
-
 	list_for_each_entry(info, &reboot->head, list) {
 		if (!strcmp(info->mode, cmd)) {
 			*magic = info->magic;
@@ -45,6 +41,32 @@ static int reboot_mode_notify(struct notifier_block *this,
 	unsigned int magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
+
+	if (!cmd) {
+		switch (mode) {
+		case REBOOT_COLD:
+			cmd = "cold";
+			break;
+		case REBOOT_WARM:
+			cmd = "warm";
+			break;
+		case REBOOT_HARD:
+			cmd = "hard";
+			break;
+		case REBOOT_SOFT:
+			cmd = "soft";
+			break;
+		case REBOOT_GPIO:
+			cmd = "gpio";
+			break;
+		}
+		if (get_reboot_mode_magic(reboot, cmd, &magic)) {
+			reboot->write(reboot, magic);
+			return NOTIFY_DONE;
+		}
+		cmd = "normal";
+	}
+
 	if (get_reboot_mode_magic(reboot, cmd, &magic))
 		reboot->write(reboot, magic);
 
-- 
2.41.0

