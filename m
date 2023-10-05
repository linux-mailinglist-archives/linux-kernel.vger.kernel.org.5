Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AB7B9EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjJEOGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjJEOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD54287CB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:46:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3954HwsC030830;
        Thu, 5 Oct 2023 05:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6Zm2FCsilHvqLTaw5r9qa0CY52o9Sl26vI0qEIq2qMQ=;
 b=pK00mUiM1HMi8ZAa5tNzJnbAE9maY39yq+qgr/kRGSWGmTShlgdCSMtJZ1uVT+wjfkfa
 g0E5iS0dgjGAXfDdfBeDWSa9gcv5ZSmsCmvlEM+ZzjnM3wYDqQyKxUcW6qcbFS8TjHVK
 fY9culyR451y46yXSNhos+tp4Rs1ORBbXPxh/9r6i5+aEHWHzaBD+31mFuHCiFt4qzLB
 0isW5HComB7/ILyD8rUVpj7rDYCnqabLcyi6lG70mH2VglX425uM5rklmun7RG7KA8+F
 NRprWQchyt3Pv4wCk+MKgD2mWHKHb/49KmGnNmVKcI/EFYpG5v/+rcgOQn7g+roO8dks yg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th8e1syf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 05:07:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39557BjC003979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 05:07:11 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 22:07:09 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <mcgrof@kernel.org>, <russell.h.weight@intel.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3] firmware_loader: Abort new fw load request once firmware core knows about reboot
Date:   Thu, 5 Oct 2023 10:37:00 +0530
Message-ID: <1696482420-1329-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6RInTwoyBuVofr09zfMWNu1sicpdHw2w
X-Proofpoint-ORIG-GUID: 6RInTwoyBuVofr09zfMWNu1sicpdHw2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_02,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
       fw_state_aborted	               request_firmware
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
index bf68e3947814..a162020e98f2 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -57,6 +57,10 @@ void kill_pending_fw_fallback_reqs(bool only_kill_custom)
 		if (!fw_priv->need_uevent || !only_kill_custom)
 			 __fw_load_abort(fw_priv);
 	}
+
+	if (!only_kill_custom)
+		fw_abort_load = true;
+
 	mutex_unlock(&fw_lock);
 }
 
@@ -86,7 +90,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 	}
 
 	mutex_lock(&fw_lock);
-	if (fw_state_is_aborted(fw_priv)) {
+	if (fw_abort_load || fw_state_is_aborted(fw_priv)) {
 		mutex_unlock(&fw_lock);
 		retval = -EINTR;
 		goto out;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index bf549d6500d7..8b2549910f36 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -86,6 +86,7 @@ struct fw_priv {
 
 extern struct mutex fw_lock;
 extern struct firmware_cache fw_cache;
+extern bool fw_abort_load;
 
 static inline bool __fw_state_check(struct fw_priv *fw_priv,
 				    enum fw_status status)
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b58c42f1b1ce..2658bdcdf1ee 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -93,6 +93,7 @@ static inline struct fw_priv *to_fw_priv(struct kref *ref)
 DEFINE_MUTEX(fw_lock);
 
 struct firmware_cache fw_cache;
+bool fw_abort_load;
 
 void fw_state_init(struct fw_priv *fw_priv)
 {
-- 
2.7.4

