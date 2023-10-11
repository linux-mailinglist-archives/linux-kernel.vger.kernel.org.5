Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9537C4C34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbjJKHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbjJKHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:45:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB998;
        Wed, 11 Oct 2023 00:45:03 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B5xVe2010958;
        Wed, 11 Oct 2023 07:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=AsDUI7Bosj7IHICzk8UtqRuKfn35TPs/rLOqBIEadLE=;
 b=mGp6HGF0mlTLA1uH5p75BVsByXq0w0t619Wn/VSI9cxx7Hrgh92K4Kd/v2g9VeY7nKmY
 fu7yj5BP3wAzpXl3uulYF44LBGeWpziqwcipcNZ4bbMXh42Xs9NX3u6Zv0h/GhgH3Jcv
 DXfviNz+co4Qr5lyMA4Ba3TpPREjOTrTF5oxEeu+JwyJk/ThR19tPBqjV67CzVsdOqcV
 v70oMcOcKOORksIMN+bkQXYcyOFMERq1OEbqJtw6BBjPqJ+u6ZCtsi6sfZoeHny8Gu/U
 Nbxb9T+d9tqTlb27Bp8TWBKAbZ51tzJWUSa6IeC76MX0hIZtSbdFiXatXcUwd/JgSw+l kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tnfu90tbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 07:45:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B7j0iw025907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 07:45:00 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 11 Oct 2023 00:44:59 -0700
From:   Joey Jiao <quic_jiangenj@quicinc.com>
To:     <linux-modules@vger.kernel.org>
CC:     <quic_jiangenj@quicinc.com>, Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Date:   Wed, 11 Oct 2023 13:14:38 +0530
Message-ID: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wy42EghxkYSCKgtjdRu2IDtUh1vQyoA5
X-Proofpoint-GUID: Wy42EghxkYSCKgtjdRu2IDtUh1vQyoA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_04,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When modprobe cmds are executed one by one, the final loaded modules
are not in fixed sequence as expected.

Add the option to make sure modules are in fixed sequence across reboot.

Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
---
 kernel/module/Kconfig | 11 +++++++++++
 kernel/module/main.c  |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 33a2e991f608..b45a45f31d6d 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -389,4 +389,15 @@ config MODULES_TREE_LOOKUP
 	def_bool y
 	depends on PERF_EVENTS || TRACING || CFI_CLANG
 
+config MODULE_LOAD_IN_SEQUENCE
+	bool "Load module in sequence"
+	default n
+	help
+	  By default, modules are loaded in random sequence depending on when modprobe
+	  is executed.
+
+	  This option allows modules to be loaded in sequence if modprobe cmds are
+	  executed one by one in sequence. This option is helpful during syzkaller fuzzing
+	  to make sure module is loaded into fixed address across device reboot.
+
 endif # MODULES
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..e238a31d09eb 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2594,7 +2594,8 @@ static noinline int do_init_module(struct module *mod)
 	 * rcu_barrier()
 	 */
 	if (llist_add(&freeinit->node, &init_free_list))
-		schedule_work(&init_free_wq);
+		if (!IS_ENABLED(CONFIG_MODULE_LOAD_IN_SEQUENCE)) {
+			schedule_work(&init_free_wq);
 
 	mutex_unlock(&module_mutex);
 	wake_up_all(&module_wq);
-- 
2.42.0

