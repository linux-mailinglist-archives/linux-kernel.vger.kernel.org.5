Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260047C6267
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjJLBrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjJLBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:47:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE1C9;
        Wed, 11 Oct 2023 18:47:39 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C1UARb013082;
        Thu, 12 Oct 2023 01:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=niFFbP3jkBocCEpB48HyTZeog/L/1NdzvkHsVOEBE3Q=;
 b=njh/SVwTdcEebmjBpo/HXTTpzYsuW3PCXq7Y9xpWKcFVWlmYXBiJf+tLmSK15ZRGpYPR
 nw7+JXGka6pwtoB+/3wspejQaMp0osBHE1y31FcFabNwEpDSpUAdWYp2NenXd6s5O2Fg
 rToSXuh9oM/oRTLe3UI3CeycTmo0FBZoFeFPNe9LXuUHHj21K1OoezF9QxeehKza3HBZ
 PKfuJa0xrnqMqAoCBtawKB+JytU7kTVrNl78y4aDOanVRXGJRxwVfyemuqqVL466F9CW
 8W9KNb04vo7rzZCjS3NA0kbd+HO+rFkOrGy+c60dGBbZgL462KbLeSenZuorAE0WwGSh Zw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnmdsaqqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 01:47:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39C1lXoU006865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 01:47:33 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 11 Oct 2023 18:47:32 -0700
From:   Joey Jiao <quic_jiangenj@quicinc.com>
To:     <linux-modules@vger.kernel.org>
CC:     <quic_jiangenj@quicinc.com>, Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Date:   Thu, 12 Oct 2023 07:17:19 +0530
Message-ID: <20231012014720.19748-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EjLvWMSfftV7a94CGc-vf1e4evPCmbtd
X-Proofpoint-GUID: EjLvWMSfftV7a94CGc-vf1e4evPCmbtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 mlxlogscore=951
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate syzkaller test, it's essential for the module to retain the
same address across reboots. In userspace, the execution of modprobe
commands must occur sequentially. In the kernel, selecting the
CONFIG_MODULE_DISABLE_INIT_FREE option disables the asynchronous freeing
of init sections.

Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
---
 kernel/module/Kconfig | 12 ++++++++++++
 kernel/module/main.c  |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 33a2e991f608..88206bc4c7d4 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -389,4 +389,16 @@ config MODULES_TREE_LOOKUP
 	def_bool y
 	depends on PERF_EVENTS || TRACING || CFI_CLANG
 
+config MODULE_DISABLE_INIT_FREE
+	bool "Disable freeing of init sections"
+	default n
+	help
+	  By default, kernel will free init sections after module being fully
+	  loaded.
+
+	  MODULE_DISABLE_INIT_FREE allows users to prevent the freeing of init
+	  sections. This option is particularly helpful for syzkaller fuzzing,
+	  ensuring that the module consistently loads into the same address
+	  across reboots.
+
 endif # MODULES
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..0f242b7b29fe 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2593,7 +2593,8 @@ static noinline int do_init_module(struct module *mod)
 	 * be cleaned up needs to sync with the queued work - ie
 	 * rcu_barrier()
 	 */
-	if (llist_add(&freeinit->node, &init_free_list))
+	if (llist_add(&freeinit->node, &init_free_list) &&
+		!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE))
 		schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
-- 
2.42.0

