Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357F760254
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGXWbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjGXWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:31:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76371735;
        Mon, 24 Jul 2023 15:31:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OMMYf8017581;
        Mon, 24 Jul 2023 22:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=nN0DJtoEROST43YwVQQar5B/uJDpBZz6QURRfq3efdA=;
 b=FuvxLIZ0/vlLyXC6DzO2ISgcd8RaUzhxm+hMWEKruPKEeVdxbEA1QijLvuqgIRVIRLTW
 /SckP/wSk7pNlFYP6u5KZOk1TYLZgeE//nRNfkiMC1gYzwMUns9d0RjTNc9f+8r//Es5
 kfV/EAAI1JCP+R8ZyAwervbi2jD5wyzDpCYbtnEA+TNqzCtLG8/4ivxHWLysMLeZ3iar
 nuOe2fJoQS/lYM58gzg4IKCQgJRT3J4kgFzW/PkGFVtmI0wdHt8Xgrf7Et4KIhcoV4ZN
 AwJFCN1hmstd68601ZE/1KHTQ8CFs9QU41bjCsunZ5j5FA4I+VHOnCrGsQ8gFqZkrhux +g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qcysk2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:28 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OMVRDh003758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:27 GMT
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
Subject: [RFC PATCH 1/4] power: reset: reboot-mode: Allow magic to be 0
Date:   Mon, 24 Jul 2023 15:30:51 -0700
Message-ID: <20230724223057.1208122-2-quic_eberman@quicinc.com>
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
X-Proofpoint-ORIG-GUID: AO2zXQZKTTZ9AQV95k8OBBjoBe9P4s9R
X-Proofpoint-GUID: AO2zXQZKTTZ9AQV95k8OBBjoBe9P4s9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_16,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Allow magic from the reboot-mode driver to be defined, but 0. This is
useful when the register/command to trigger reboot needs 0 to be
written. This is the case when the "default" reboot mode is to enter a
crash dump collection mode (e.g. when triggered by a watchdog) and Linux
doing a normal reboot requires the setting to be explicitly reset to
zero.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/power/reset/reboot-mode.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index b4076b10b893..a646aefa041b 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -19,11 +19,10 @@ struct mode_info {
 	struct list_head list;
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static bool get_reboot_mode_magic(struct reboot_mode_driver *reboot,
+					  const char *cmd, unsigned int *magic)
 {
 	const char *normal = "normal";
-	int magic = 0;
 	struct mode_info *info;
 
 	if (!cmd)
@@ -31,12 +30,12 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 
 	list_for_each_entry(info, &reboot->head, list) {
 		if (!strcmp(info->mode, cmd)) {
-			magic = info->magic;
-			break;
+			*magic = info->magic;
+			return true;
 		}
 	}
 
-	return magic;
+	return false;
 }
 
 static int reboot_mode_notify(struct notifier_block *this,
@@ -46,8 +45,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 	unsigned int magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
-	magic = get_reboot_mode_magic(reboot, cmd);
-	if (magic)
+	if (get_reboot_mode_magic(reboot, cmd, &magic))
 		reboot->write(reboot, magic);
 
 	return NOTIFY_DONE;
-- 
2.41.0

