Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA37C625B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjJLBl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjJLBlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:41:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF49C6;
        Wed, 11 Oct 2023 18:41:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C1FQ3m017544;
        Thu, 12 Oct 2023 01:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UQIheOsqvn5ZbIDPMFljWaqWRk+AS+WNufhS+BGF2Ls=;
 b=ZDePl1kyw2b7rxTClv1BRkiG2HuNv0wqsxevYZnPqeEdyhCoxRifjWwiI0LhzL1lPXrH
 tNV/7JnYtI+mnSXh+NuDOuYI0Lwco25c7uXg9nwMDmel21LBJ5OxOD966dxVfoqyVUFk
 46HN3R6C6Hmu1erTrPD3nc5Z4RB0NHVrh/eqxkipCO4/2LhIHZevCwc1Xf9uRAv+dIEw
 lHz3FlRMi4uFEcYEcbXqhUP/1zCggfJk/Oxl1MXPQAodCa/HhdT280ZkPL/Io/Tu48NM
 oQJ+Ce+senWzXrOV0RTYHUzQ3JnMtwyJ7Mk0R2PnHTJWvi5h6dAgRTFwYLxeX2E07v5g 7A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnkwnjrd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 01:41:14 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39C1fElE006460
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 01:41:14 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 11 Oct 2023 18:41:12 -0700
From:   Joey Jiao <quic_jiangenj@quicinc.com>
To:     <linux-modules@vger.kernel.org>
CC:     <quic_jiangenj@quicinc.com>, Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Date:   Thu, 12 Oct 2023 07:10:11 +0530
Message-ID: <20231012014012.9030-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zGy8rx1h8tt5MnbW9T97Roc3Y23dtCeu
X-Proofpoint-GUID: zGy8rx1h8tt5MnbW9T97Roc3Y23dtCeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=905
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate syzkaller test, it's essential for the module to retain the same
address across reboots. In userspace, the execution of modprobe commands must
occur sequentially. In the kernel, selecting the CONFIG_MODULE_DISABLE_INIT_FREE
option disables the asynchronous freeing of init sections.

Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
---
 kernel/module/Kconfig | 8 ++++++++
 kernel/module/main.c  | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 33a2e991f608..1cdbee4c51de 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -389,4 +389,12 @@ config MODULES_TREE_LOOKUP
 	def_bool y
 	depends on PERF_EVENTS || TRACING || CFI_CLANG
 
+config MODULE_DISABLE_INIT_FREE
+	bool "Disable freeing of init sections"
+	default n
+	help
+	  Allows users to prevent the freeing of init sections. This option is
+	  particularly helpful for syzkaller fuzzing, ensuring that the module
+	  consistently loads into the same address across reboots.
+
 endif # MODULES
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..a5210b90c078 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2593,8 +2593,9 @@ static noinline int do_init_module(struct module *mod)
 	 * be cleaned up needs to sync with the queued work - ie
 	 * rcu_barrier()
 	 */
-	if (llist_add(&freeinit->node, &init_free_list))
-		schedule_work(&init_free_wq);
+	if (llist_add(&freeinit->node, &init_free_list) &&
+		!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE))
+			schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
 	wake_up_all(&module_wq);
-- 
2.42.0

