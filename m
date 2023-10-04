Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA07B82D1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242977AbjJDO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbjJDO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:56:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7CC4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:56:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394BPXgq023918;
        Wed, 4 Oct 2023 14:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=W3GltK28J0SONn7jU/j3ZxDyrtxFksKfwkeLktZT698=;
 b=S2TaWc46J6wiam6ChDgxLNMFLy6uBImCPLXKhzUmAnfCfqVmF3hI6qYoQfa+XHk+z4sa
 589sPj3SkSlNrzRokxEk1C+oZazwi5uOrE5qGl7a4t5uBeHgh3qjn/qE6AnnXI9c6xK2
 QKA1Euco2mVrQJZ1Xqgf5ek5i9tO80ZHJGVj+3WxfRyp4TiKvOdCdDYdHG0PYm3bgVg6
 MVl8+f1fM4sTDqOTCsfOnXM1cK38pxTZQOogs0he81fLQm2m/wi4ngNhuHBgfxC43l/N
 8q6i2WwZjGzqd8D45i/ye1Cw0nX3sViPJY0i2zo0AZN4ThA1tzAizSo1JNxKG24YYAZB ww== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mj6bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 14:55:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 394Etjsj004849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 14:55:45 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 07:55:43 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <mcgrof@kernel.org>, <russell.h.weight@intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2] firmware_loader: Abort new fw load request once firmware core knows about reboot
Date:   Wed, 4 Oct 2023 20:25:27 +0530
Message-ID: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8WA_CQ0sq4Lcb7Igo60R555WIRf_u0PH
X-Proofpoint-ORIG-GUID: 8WA_CQ0sq4Lcb7Igo60R555WIRf_u0PH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be following scenario where there is a ongoing reboot
is going from processA which tries to call all the reboot notifier
callback and one of them is firmware reboot call which tries to
abort all the ongoing firmware userspace request under fw_lock but
there could be another processB which tries to do request firmware,
which came just after abort done from ProcessA and ask for userspace
to load the firmware and this can stop the ongoing reboot ProcessA
to stall for next 60s(default timeout) which may not be expected
behaviour everyone like to see, instead we should abort any firmware
load request which came once firmware knows about the reboot through
notification.

      ProcessA                             ProcessB

kernel_restart_prepare
  blocking_notifier_call_chain
   fw_shutdown_notify
     kill_pending_fw_fallback_reqs
      __fw_load_abort
       fw_state_aborted	           request_firmware
         __fw_state_set                 firmware_fallback_sysfs
...                                       fw_load_from_user_helper
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
Changes from v1: https://lore.kernel.org/lkml/1694773288-15755-1-git-send-email-quic_mojha@quicinc.com/
 - Renamed the flag to fw_load_abort.
 - Kept the flag under fw_lock.
 - Repharsed commit text.

 drivers/base/firmware_loader/fallback.c | 6 +++++-
 drivers/base/firmware_loader/firmware.h | 1 +
 drivers/base/firmware_loader/main.c     | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index bf68e3947814..b9f855d248ac 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -57,6 +57,10 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)
 		if (!fw_priv->need_uevent || !only_kill_custom)
 			 __fw_load_abort(fw_priv);
 	}
+
+	if (!only_kill_custom)
+		fw_load_abort = true;
+
 	mutex_unlock(&fw_lock);
 }
 
@@ -86,7 +90,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	mutex_lock(&fw_lock);
-	if (fw_state_is_aborted(fw_priv)) {
+	if (fw_load_abort || fw_state_is_aborted(fw_priv)) {
 		mutex_unlock(&fw_lock);
 		retval = -EINTR;
 		goto out;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index bf549d6500d7..015846e50dff 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -86,6 +86,7 @@ struct fw_priv {
 
 extern struct mutex fw_lock;
 extern struct firmware_cache fw_cache;
+extern bool fw_load_abort;
 
 static inline bool __fw_state_check(struct fw_priv *fw_priv,
 				    enum fw_status status)
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b58c42f1b1ce..467ff1d439af 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -93,6 +93,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
 DEFINE_MUTEX(fw_lock);
 
 struct firmware_cache fw_cache;
+bool fw_load_abort;
 
 void fw_state_init(struct fw_priv *fw_priv)
 {
-- 
2.7.4

