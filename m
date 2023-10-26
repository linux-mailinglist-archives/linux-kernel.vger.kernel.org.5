Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D347D84B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbjJZO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbjJZO2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:28:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E24128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:28:36 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QEMLvd010943;
        Thu, 26 Oct 2023 14:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=NbSn4I51/sJvzzcsxZog5wjo03pj4gwtmoxo4SFPzEs=;
 b=JRoFVxwJM47zfZ8ioBD79T0/DW658TZC0l4qkhTQjWc+bySfgFNxm1MCziBT6GAtIELX
 1Jg6vvuJCGmZxNtSLP7CnCVL57p2zkRwMXtxrSww8N6DtyJFXeayO6+x5+1F6pR8Rjyz
 NOv/qjclNmuVG0WilRqkleAnWl0O4h7ySnKAqSjkQLzw1bSxtmCF1N+cBEusrGyGXm6s
 DHnGtqKIip8cnbm9nRJGh8blGu81zv6rqslmwbdGeOdpLtiIJY1ULaYP0xGWdmN213Hf
 7M2eJrHba8+yOxQHUyIZQ1G/HOkPFIiVH/FNJqDiTfgX7ZTYl2OeJ0RdjJchQDyxG7/M jw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyq5b0caj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:28:26 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39QESPFR030256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:28:25 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 07:28:23 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v4 1/2] firmware_loader: Refactor kill_pending_fw_fallback_reqs()
Date:   Thu, 26 Oct 2023 19:57:38 +0530
Message-ID: <1698330459-31776-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mTxgqVb_tTMoODB-Pi7bXzWxS4DvY8mM
X-Proofpoint-GUID: mTxgqVb_tTMoODB-Pi7bXzWxS4DvY8mM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_12,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'only_kill_custom' and refactor logic related to it
to be more meaningful.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v4:
 - New patch, no past revision.

 drivers/base/firmware_loader/fallback.c | 4 ++--
 drivers/base/firmware_loader/fallback.h | 4 ++--
 drivers/base/firmware_loader/main.c     | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index bf68e3947814..b3ce07160281 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -46,7 +46,7 @@ static inline int fw_sysfs_wait_timeout(struct fw_priv *fw_priv,  long timeout)
 
 static LIST_HEAD(pending_fw_head);
 
-void kill_pending_fw_fallback_reqs(bool only_kill_custom)
+void kill_pending_fw_fallback_reqs(bool kill_all)
 {
 	struct fw_priv *fw_priv;
 	struct fw_priv *next;
@@ -54,7 +54,7 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)
 	mutex_lock(&fw_lock);
 	list_for_each_entry_safe(fw_priv, next, &pending_fw_head,
 				 pending_list) {
-		if (!fw_priv->need_uevent || !only_kill_custom)
+		if (kill_all || !fw_priv->need_uevent)
 			 __fw_load_abort(fw_priv);
 	}
 	mutex_unlock(&fw_lock);
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 144148595660..ccf912bef6ca 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -13,7 +13,7 @@ int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 			    struct device *device,
 			    u32 opt_flags,
 			    int ret);
-void kill_pending_fw_fallback_reqs(bool only_kill_custom);
+void kill_pending_fw_fallback_reqs(bool kill_all);
 
 void fw_fallback_set_cache_timeout(void);
 void fw_fallback_set_default_timeout(void);
@@ -28,7 +28,7 @@ static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
 	return ret;
 }
 
-static inline void kill_pending_fw_fallback_reqs(bool only_kill_custom) { }
+static inline void kill_pending_fw_fallback_reqs(bool kill_all) { }
 static inline void fw_fallback_set_cache_timeout(void) { }
 static inline void fw_fallback_set_default_timeout(void) { }
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b58c42f1b1ce..522ccee781b4 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1524,10 +1524,10 @@ static int fw_pm_notify(struct notifier_block *notify_block,
 	case PM_SUSPEND_PREPARE:
 	case PM_RESTORE_PREPARE:
 		/*
-		 * kill pending fallback requests with a custom fallback
-		 * to avoid stalling suspend.
+		 * Here, kill pending fallback requests will only kill
+		 * non-uevent firmware request to avoid stalling suspend.
 		 */
-		kill_pending_fw_fallback_reqs(true);
+		kill_pending_fw_fallback_reqs(false);
 		device_cache_fw_images();
 		break;
 
@@ -1612,7 +1612,7 @@ static int fw_shutdown_notify(struct notifier_block *unused1,
 	 * Kill all pending fallback requests to avoid both stalling shutdown,
 	 * and avoid a deadlock with the usermode_lock.
 	 */
-	kill_pending_fw_fallback_reqs(false);
+	kill_pending_fw_fallback_reqs(true);
 
 	return NOTIFY_DONE;
 }
-- 
2.7.4

