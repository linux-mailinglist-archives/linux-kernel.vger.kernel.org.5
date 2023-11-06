Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9C7E26BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjKFOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:25:57 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:25:53 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A66tsF9003575;
        Mon, 6 Nov 2023 14:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=RHtjl9Y8AOTJrzlR+/eTZQ/YBNP/qMKUVfpQIE0pZFg=;
 b=nM6FRlR3shYiK7frKA5Epjt5/Ard179T6e00a+R6jIk8siTa5zI2IGpsM3eT/XB6ujX8
 kHGvfD96r3kAAMkt43bXjxU1+E+TMtOXY3sDmxl1PEIaWjyzWZf5pXKgQn/QChC70Inq
 pNu1J/I6kDPKmojpXcdZN9dxQ4ZsQkUPm9w8/vEKCxn1Xf59iWEfMzTMYURNxOJBzd9d
 No7dgJTS/UV6ZtrPWJz7iyqGtIRW6Yfl5MqLOAZo9e3pCo6X709yharKvmcWZWRr8FxB
 4PiXGUKTxkYcFXMyIwsFKU/pAcKb/Hl4lwRwcqHKdzKKL+xuBhbp0USv3G/n31rEk2Na zg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5eqn4c2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 14:25:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6EPk0l012901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 14:25:47 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 06:25:44 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] devcoredump: Send uevent once devcd is ready
Date:   Mon, 6 Nov 2023 19:55:35 +0530
Message-ID: <1699280735-31482-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G-0uEUbctdT3MkSwdfSyDteyQyaIF0qg
X-Proofpoint-ORIG-GUID: G-0uEUbctdT3MkSwdfSyDteyQyaIF0qg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=949
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060116
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
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

