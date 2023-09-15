Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2517A1BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjIOKW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:22:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8476C1AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:22:19 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F3HUE2009289;
        Fri, 15 Sep 2023 10:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=tiWOyH+/M7saEqjNewqDhkz34LSgnEcc+FVODI6f1Ug=;
 b=bF3KPETUFFwuw30VOWOys7LLs0Xy0b5mI7bjZ5Nn6s+NxtzpRA0tsUgCC/aoQw8UAX6Z
 TTjtI7n3RGB+qFKfV2I2L/94wgh40OBo9eIm2Xq9lpc8MFu8XGl156mSWuJLjtyzmUyJ
 azdvbxnhmwyT07b0WpRPZECSbUuUexs8/abNz8mw3edGenhP1htp9nvzgq7jweiPej6p
 yCjMSUlvaPPwN1RWUw08IABNxrLkJj6qJTc8zJAgVB7iwvkHalRyx5T9GCxJhV6eO/R1
 3NgKKI3/lpOHUaNIro4h3+xEZDBICR5DJhpAkU5f6gy9zMCsIylPKyg6monxE7qKIsFT 6A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4f6v0wuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 10:22:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38FAM58i019642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 10:22:05 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 03:22:02 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <mcgrof@kernel.org>, <russell.h.weight@intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] firmware_loader: Add reboot_in_progress for user helper path
Date:   Fri, 15 Sep 2023 15:51:28 +0530
Message-ID: <1694773288-15755-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b1kqsY2SZzaAt5osDISF_O-luDjlHeSG
X-Proofpoint-ORIG-GUID: b1kqsY2SZzaAt5osDISF_O-luDjlHeSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_06,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150091
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be following scenario where there is a ongoing reboot
is going from processA which tries to call all the reboot notifier
callback and one of them is firmware reboot call which tries to
abort all the ongoing firmware userspace request under fw_lock
but there could be another processB which tries to do request
firmware, which came just after abort done from ProcessA and
ask for userspace to load the firmware and this can stop the
ongoing reboot ProcessA to stall for next 60s(default timeout)
which may be expected behaviour everyone like to see, instead
we should abort every request which came after once firmware
marks reboot notification.

      ProcessA                             ProcessB

kernel_restart_prepare
  blocking_notifier_call_chain
   fw_shutdown_notify
     kill_pending_fw_fallback_reqs
      __fw_load_abort
       fw_state_aborted	              request_firmware
         __fw_state_set                   firmware_fallback_sysfs
...                                        fw_load_from_user_helper
..                                         ...
.                                          ..
                                            usermodehelper_read_trylock
                                             fw_load_sysfs_fallback
                                              fw_sysfs_wait_timeout
usermodehelper_disable
 __usermodehelper_disable
  down_write()

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 drivers/base/firmware_loader/firmware.h | 1 +
 drivers/base/firmware_loader/main.c     | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index bf68e3947814..a5546aeea91f 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -86,7 +86,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	mutex_lock(&fw_lock);
-	if (fw_state_is_aborted(fw_priv)) {
+	if (reboot_in_progress || fw_state_is_aborted(fw_priv)) {
 		mutex_unlock(&fw_lock);
 		retval = -EINTR;
 		goto out;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index bf549d6500d7..6f44248e2e44 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -86,6 +86,7 @@ struct fw_priv {
 
 extern struct mutex fw_lock;
 extern struct firmware_cache fw_cache;
+extern bool reboot_in_progress;
 
 static inline bool __fw_state_check(struct fw_priv *fw_priv,
 				    enum fw_status status)
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b58c42f1b1ce..d72b7950edf0 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -93,6 +93,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
 DEFINE_MUTEX(fw_lock);
 
 struct firmware_cache fw_cache;
+bool reboot_in_progress;
 
 void fw_state_init(struct fw_priv *fw_priv)
 {
@@ -1613,6 +1614,7 @@ static int fw_shutdown_notify(struct notifier_block *unused1,
 	 * and avoid a deadlock with the usermode_lock.
 	 */
 	kill_pending_fw_fallback_reqs(false);
+	reboot_in_progress = true;
 
 	return NOTIFY_DONE;
 }
-- 
2.7.4

