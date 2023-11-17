Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6BA7EF4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjKQOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:50:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568493;
        Fri, 17 Nov 2023 06:50:04 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHDm1IZ002145;
        Fri, 17 Nov 2023 14:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=tiWhCPKBY8KcVMe9xaTROqbLzzUZTgRw9sA0EjTq5A8=;
 b=AAqhxSgtA8AU0jKhqXAieBG4FFMiWCEgv6PL3lIBfWb/dAzAGjvSAQjK+ReQcTwg/HLE
 HzcdKT0lgTUiidZm0H3GduafJL9n/rbz7m/qS2AtUG5rb6Wm3A1BOMfmoYWoG2uqa7/g
 Syaaf/mkwYgPHES84YXsAuitr6b7kvy92+K5D9xbjdktqqEbT8fknVmbo3oayhEJMRTc
 FVkzGH1qXehT0sMwohP0F21KMn+DhniC7AMWTIpIgU01y6soM0zVecHivbWynRmKmDVX
 5rDR3L3NLfoyZsFCbOnT+fybP4dHrEGQxNczSYv/y90g+A9nRdsldUd7BtLC8pI9i1ND zA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ue5exrkkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:49:57 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AHEnuFo020315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 14:49:56 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 06:49:54 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] devcoredump: Send uevent once devcd is ready
Date:   Fri, 17 Nov 2023 20:19:32 +0530
Message-ID: <1700232572-25823-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v7dCXa4ntkORvh4rGS-3Bq9COYS1Gh-N
X-Proofpoint-ORIG-GUID: v7dCXa4ntkORvh4rGS-3Bq9COYS1Gh-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 spamscore=0
 mlxlogscore=986 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_coredumpm() creates a devcoredump device and adds it
to the core kernel framework which eventually end up
sending uevent to the user space and later creates a
symbolic link to the failed device. An application
running in userspace may be interested in this symbolic
link to get the name of the failed device.

In a issue scenario, once uevent sent to the user space
it start reading '/sys/class/devcoredump/devcdX/failing_device'
to get the actual name of the device which might not been
created and it is in its path of creation.

To fix this, suppress sending uevent till the failing device
symbolic link gets created and send uevent once symbolic
link is created successfully.

Fixes: 833c95456a70 ("device coredump: add new device coredump class")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: stable@vger.kernel.org
---
Change in v3:
 - Cced stable.

Change in v2:
 - Added Fixes tag as per suggestion from [Johannes]

 drivers/base/devcoredump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 91536ee05f14..7e2d1f0d903a 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -362,6 +362,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->devcd_dev.class = &devcd_class;
 
 	mutex_lock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -376,6 +377,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 		              "devcoredump"))
 		dev_warn(dev, "devcoredump create_link failed\n");
 
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
 	mutex_unlock(&devcd->mutex);
-- 
2.7.4

