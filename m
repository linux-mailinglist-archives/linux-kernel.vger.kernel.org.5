Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6792A7C7DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjJMG13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMG11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:27:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF0FBB;
        Thu, 12 Oct 2023 23:27:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D5hPdL032001;
        Fri, 13 Oct 2023 06:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=nZ5lTCInN9V+BiHFhjiwiOZL80UvMAm2wBOPGV3c8hs=;
 b=PIbhud9ZDl14e/CamvI9CVKJeKBZYD2B1OhDt3NACIwA/jLKcq8+52EHtZOjjM+mhzkt
 p9KBXQSOUepHfbjvDl3wkxf3tb/kHcx3ryELFPQgeLvOilSUlFB9gP8VpzssCQAlB3hT
 spyBdYR7cYdAbT2lsn6FZnYyqpGcttnvfPCpMQsqrbMqjkjgElcn1rcukLrkw516QT8A
 LmmYC3JmW4dcFDgU8a7I2ucKvUiQgkvXQ8gSBFsCHUQ2eXJ0j9SC+aG8jGv7c96/PLWD
 2pNmN6VlDuJdQhoYZxAghPxQjNjtb9EnNSCw1f3aTcuUlAz26N+knoUKqUBUcCeYNRdx +A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt11gkeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 06:27:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39D6RN3I027061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 06:27:23 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 12 Oct 2023 23:27:21 -0700
From:   Joey Jiao <quic_jiangenj@quicinc.com>
To:     <linux-modules@vger.kernel.org>
CC:     <quic_jiangenj@quicinc.com>, <quic_likaid@quicinc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Date:   Fri, 13 Oct 2023 11:57:11 +0530
Message-ID: <20231013062711.28852-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q3BD-YPWkCQJsHYXFN2FbszG-u0t-0kW
X-Proofpoint-ORIG-GUID: Q3BD-YPWkCQJsHYXFN2FbszG-u0t-0kW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=852 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130054
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller uses the _RET_IP_ (also known as pc) to decode covered
file/function/line, and it employs pc ^ hash(prev_pc) (referred to as
signal) to indicate covered edge. If the pc for the same file/line
keeps changing across reboots, syzkaller will report incorrect coverage
data. Additionally, even if kaslr can be disabled, we cannot get the
same covered edge for module because both pc and prev_pc have changed,
thus altering pc ^ hash(prev_pc).

To facilitate syzkaller coverage, it is crucial for both the core kernel
and modules to maintain at the same addresses across reboots.

So, the following steps are necessary:
- In userspace:
  1) To maintain an uninterrupted loading sequence, it is recommended to
execute modprobe commands by loading one module at a time, to avoid any
interference from the scheduler.
  2) Avoid unloading any module during fuzzing.
- In kernel:
  1) Disable CONFIG_RANDOMIZE_BASE to load the core kernel at the same
address consistently.
  2) To ensure deterministic module loading at the same address, enabling
CONFIG_MODULE_DISABLE_INIT_FREE prevents the asynchronous freeing of init
sections. Without this option, there is a possibility that the next module
could be loaded into previous freed init pages of a previous loaded module.

It is important to note that this option is intended for fuzzing tests only
and should not be set as the default configuration in production builds.

Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
---
 kernel/module/Kconfig | 13 +++++++++++++
 kernel/module/main.c  |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 33a2e991f608..d0df0b5997b0 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -389,4 +389,17 @@ config MODULES_TREE_LOOKUP
 	def_bool y
 	depends on PERF_EVENTS || TRACING || CFI_CLANG
 
+config MODULE_DISABLE_INIT_FREE
+	bool "Disable freeing of init sections"
+	default n
+	depends on !RANDOMIZE_BASE
+	help
+	  By default, the kernel frees init sections after module is fully
+	  loaded.
+
+	  Enabling MODULE_DISABLE_INIT_FREE allows users to prevent the freeing
+	  of init sections. It is particularly helpful for syzkaller fuzzing,
+	  ensuring that the module consistently loads at the same address
+	  across reboots.
+
 endif # MODULES
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..d226df3a6cf6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2593,7 +2593,8 @@ static noinline int do_init_module(struct module *mod)
 	 * be cleaned up needs to sync with the queued work - ie
 	 * rcu_barrier()
 	 */
-	if (llist_add(&freeinit->node, &init_free_list))
+	if (!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE) &&
+	    llist_add(&freeinit->node, &init_free_list))
 		schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
-- 
2.42.0

