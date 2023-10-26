Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA57D84B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbjJZO2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbjJZO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:28:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479111AA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:28:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QEKdM2016139;
        Thu, 26 Oct 2023 14:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qyBn6jguV2CtCgZJ0YSbZFMuweVL9xc6h7MSnGeedig=;
 b=CECpQjiCNIZaREcojvx76nEEaxbeEPJguNV3nKv12M/GEVXPPvGD1Aum/0ORMjFpWvwC
 /iqF1njAHyYwbkSfWawb5SQ5lT5lhmdiUk3++G9P7FRPVOUkhmQ+P9E2wtYIdI2/uI29
 Y0EO55TsuD7Jj6p5OiTNLO/M0ceUAEXQKsyQy0xcSmz7351/+xAwMkgDADjW0zVZX5Q7
 nWuBiuSP1L977grkKG53hZ6s51KlbfEpQkqaR02UCoBXwvNCcuMj7rQnLr5gcjnF+oOx
 stJ+ppzIHQf/d9UIAfvbjLQmS3flVQt0EFxlUE2CXp83jS0OjC67las1NOysTPNlZBgz 7A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyfm9hb47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:28:29 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39QESSCg028126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:28:28 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 07:28:25 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v4 2/2] firmware_loader: Abort all upcoming firmware load request once reboot triggered
Date:   Thu, 26 Oct 2023 19:57:39 +0530
Message-ID: <1698330459-31776-2-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698330459-31776-1-git-send-email-quic_mojha@quicinc.com>
References: <1698330459-31776-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tsMwgciLkAVGKKvgbd95kEkaySdBWg6n
X-Proofpoint-GUID: tsMwgciLkAVGKKvgbd95kEkaySdBWg6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_13,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
       fw_state_aborted                request_firmware
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
Changes from v3: https://lore.kernel.org/lkml/1696482420-1329-1-git-send-email-quic_mojha@quicinc.com/
 - Again renamed variable name to be more meaningful after 1/2.

Changes from v2: https://lore.kernel.org/lkml/1696431327-7369-1-git-send-email-quic_mojha@quicinc.com/
 - Renamed the flag to fw_abort_load.

Changes from v1: https://lore.kernel.org/lkml/1694773288-15755-1-git-send-email-quic_mojha@quicinc.com/
 - Renamed the flag to fw_load_abort.
 - Kept the flag under fw_lock.
 - Repharsed commit text.

 drivers/base/firmware_loader/fallback.c | 6 +++++-
 drivers/base/firmware_loader/firmware.h | 1 +
 drivers/base/firmware_loader/main.c     | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index b3ce07160281..3ef0b312ae71 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -57,6 +57,10 @@ void kill_pending_fw_fallback_reqs(bool kill_all)
 		if (kill_all || !fw_priv->need_uevent)
 			 __fw_load_abort(fw_priv);
 	}
+
+	if (kill_all)
+		fw_load_abort_all = true;
+
 	mutex_unlock(&fw_lock);
 }
 
@@ -86,7 +90,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	mutex_lock(&fw_lock);
-	if (fw_state_is_aborted(fw_priv)) {
+	if (fw_load_abort_all || fw_state_is_aborted(fw_priv)) {
 		mutex_unlock(&fw_lock);
 		retval = -EINTR;
 		goto out;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index bf549d6500d7..e891742ba264 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -86,6 +86,7 @@ struct fw_priv {
 
 extern struct mutex fw_lock;
 extern struct firmware_cache fw_cache;
+extern bool fw_load_abort_all;
 
 static inline bool __fw_state_check(struct fw_priv *fw_priv,
 				    enum fw_status status)
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 522ccee781b4..ea28102d421e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -93,6 +93,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
 DEFINE_MUTEX(fw_lock);
 
 struct firmware_cache fw_cache;
+bool fw_load_abort_all;
 
 void fw_state_init(struct fw_priv *fw_priv)
 {
-- 
2.7.4

